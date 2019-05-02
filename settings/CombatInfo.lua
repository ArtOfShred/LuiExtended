--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local CI = LUIE.CombatInfo

local strformat = zo_strformat

local optionsDataCombatInfo = {}

local castBarMovingEnable = false -- Helper local flag
local alertFrameMovingEnabled = false -- Helper local flag

local globalMethodOptions     = { "Ascending", "Descending", "Radial" }
local globalMethodOptionsKeys = { ["Ascending"] = 1, ["Descending"] = 2, ["Radial"] = 3 }
local globalAlertOptions = { "Show All Incoming Abilities", "Only Show Hard CC Effects", "Only Show Unbreakable CC Effects" }
local globalAlertOptionsKeys = { ["Show All Incoming Abilities"] = 1, ["Only Show Hard CC Effects"] = 2, ["Only Show Unbreakable CC Effects"] = 3 }

function CI.CreateSettings()
    -- Load LibAddonMenu with backwards compatibility
    local LAM = _G["LibAddonMenu2"] or LibStub("LibAddonMenu-2.0")

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

    local panelDataCombatInfo = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CI)),
        displayName = strformat("<<1>> <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CI)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
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
                getFunc = function() return castBarMovingEnabled end,
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
            -- Unlock Alert Frame
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_MOVE),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_MOVE_TP),
                getFunc = function() return alertFrameMovingEnabled end,
                setFunc = CI.SetMovingStateAlert,
                width = "half",
                default = false,
                resetFunc = CI.ResetAlertFramePosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            -- Reset Alert Frame
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_RESETPOSITION),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_RESET),
                func = CI.ResetAlertFramePosition,
                width = "half",
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },

            {
                -- Show Alerts
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_TP),
                getFunc = function() return CI.SV.alerts.toggles.alertEnable end,
                setFunc = function(v) CI.SV.alerts.toggles.alertEnable = v end,
                default = CI.D.alerts.toggles.alertEnable,
            },

            {
                -- Alert Font Face
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = "TODO",
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.toggles.alertFontFace end,
                setFunc = function(var) CI.SV.alerts.toggles.alertFontFace = var CI.ApplyFontAlert() CI.ResetAlertSize() end,
                width = "full",
                default = CI.D.alerts.toggles.alertFontFace,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                    -- Alert Font Size
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = "TODO",
                min = 16, max = 64, step = 1,
                getFunc = function() return CI.SV.alerts.toggles.alertFontSize end,
                setFunc = function(value) CI.SV.alerts.toggles.alertFontSize = value CI.ApplyFontAlert() CI.ResetAlertSize() end,
                width = "full",
                default = CI.D.alerts.toggles.alertFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                -- Alert Font Style
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = "TODO",
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.toggles.alertFontStyle end,
                setFunc = function(var) CI.SV.alerts.toggles.alertFontStyle = var CI.ApplyFontAlert() CI.ResetAlertSize() end,
                width = "full",
                default = CI.D.alerts.toggles.alertFontStyle,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
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
                -- Mitigation Aura
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA_TP),
                getFunc = function() return CI.SV.alerts.toggles.mitigationAura end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationAura = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.mitigationAura,
            },
            {
                -- Mitigation Rank 3
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3_TP),
                getFunc = function() return CI.SV.alerts.toggles.mitigationRank3 end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationRank3 = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.mitigationRank3,
            },
            {
                -- Mitigation Rank 2
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2_TP),
                getFunc = function() return CI.SV.alerts.toggles.mitigationRank2 end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationRank2 = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.mitigationRank2,
            },
            {
                -- Mitigation Rank 1
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1_TP),
                getFunc = function() return CI.SV.alerts.toggles.mitigationRank1 end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationRank1 = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.mitigationRank1,
            },
            {
                -- Mitigation Dungeon
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON_TP),
                getFunc = function() return CI.SV.alerts.toggles.mitigationDungeon end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationDungeon = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.mitigationDungeon,
            },

            {
                -- Alert Timer
                type    = "checkbox",
                name    = "Display countdown TIMER",
                tooltip = "Display the countdown/cast time of the incoming ability",
                getFunc = function() return CI.SV.alerts.toggles.alertTimer end,
                setFunc = function(v) CI.SV.alerts.toggles.alertTimer = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.alertTimer,
            },

            {
                -- Shared Label Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertShared) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertShared = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertShared[1], g=CI.D.alerts.colors.alertShared[2], b=CI.D.alerts.colors.alertShared[3]}
            },
            {
                -- Shared Timer Color
                type    = "colorpicker",
                name    = "TIMER COLOR",
                tooltip = "WOW WE CAN EVEN COLOR THE TIMER TOO?! NEAT!",
                getFunc = function() return unpack(CI.SV.alerts.colors.alertTimer) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertTimer = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertTimer[1], g=CI.D.alerts.colors.alertTimer[2], b=CI.D.alerts.colors.alertTimer[3]}
            },
            {
                type = "header",
                name = "MITGATION ALERTS",
                width = "full",
            },

            {
                -- MITIGATION ENABLE
                type    = "checkbox",
                name    = "ENABLE MITIGATION ALERTS (TODO)",
                tooltip = "TODO ADD A TP",
                getFunc = function() return CI.SV.alerts.toggles.showAlertMitigate end,
                setFunc = function(v) CI.SV.alerts.toggles.showAlertMitigate = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.showAlertMitigate,
            },

            {
                -- Incoming Ability Filters
                type = "dropdown",
                name = "FILTER INCOMING ABILITIES",
                tooltip = "TODO: Choose whether to show all incoming abilities, only hard CC effects, or only unbreakable CC effects.",
                choices = globalAlertOptions,
                getFunc = function() return globalAlertOptions[CI.SV.alerts.toggles.alertOptions] end,
                setFunc = function(value) CI.SV.alerts.toggles.alertOptions = globalAlertOptionsKeys[value] end,
                width = "full",
                default = CI.D.alerts.toggles.alertOptions,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled ) end,
            },

            {
                -- Show Mitigation Suffix
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_NOTIFICATION_MITIGATION_SUFFIX)),
                tooltip = GetString(SI_LUIE_LAM_CI_NOTIFICATION_MITIGATION_SUFFIX_TP),
                getFunc = function() return CI.SV.alerts.toggles.showMitigation end,
                setFunc = function(v) CI.SV.alerts.toggles.showMitigation = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.showMitigation,
            },
            {
                -- Mitigation Prefix (No Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationPrefix end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationPrefix = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.mitigationPrefix,
            },
            {
                -- Mitigation Prefix (Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationPrefixN end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationPrefixN = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.mitigationPrefixN,
            },

            {
                -- Show Crowd Control Border
                type    = "checkbox",
                name    = "SHOW CROWD CONTROL COLOR BORDER",
                tooltip = "COLOR THE FRAME OF THE INCOMING ABILITY ICON BASED OFF THE TYPE OF CC INCOMING (IF ANY)",
                getFunc = function() return CI.SV.alerts.toggles.showCrowdControlBorder end,
                setFunc = function(v) CI.SV.alerts.toggles.showCrowdControlBorder = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.showCrowdControlBorder,
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
                getFunc = function() return CI.SV.alerts.formats.alertBlock end,
                setFunc = function(v) CI.SV.alerts.formats.alertBlock = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertBlock,
            },
            {
                -- Block Stagger Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK_S)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_S_TP),
                getFunc = function() return CI.SV.alerts.formats.alertBlockStagger end,
                setFunc = function(v) CI.SV.alerts.formats.alertBlockStagger = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertBlockStagger,
            },
            {
                -- Block Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BLOCK_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertBlockA) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertBlockA = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertBlockA[1], g=CI.D.alerts.colors.alertBlockA[2], b=CI.D.alerts.colors.alertBlockA[3]}
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
                getFunc = function() return CI.SV.alerts.formats.alertDodge end,
                setFunc = function(v) CI.SV.alerts.formats.alertDodge = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertDodge,
            },
            {
                -- Dodge Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DODGE_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertDodgeA) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertDodgeA = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertDodgeA[1], g=CI.D.alerts.colors.alertDodgeA[2], b=CI.D.alerts.colors.alertDodgeA[3]}
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
                getFunc = function() return CI.SV.alerts.formats.alertAvoid end,
                setFunc = function(v) CI.SV.alerts.formats.alertAvoid = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertAvoid,
            },
            {
                -- Avoid Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_AVOID_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertAvoidB) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertAvoidB = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertAvoidB[1], g=CI.D.alerts.colors.alertAvoidB[2], b=CI.D.alerts.colors.alertAvoidB[3]}
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
                getFunc = function() return CI.SV.alerts.formats.alertInterrupt end,
                setFunc = function(v) CI.SV.alerts.formats.alertInterrupt = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertInterrupt,
            },
            {
                -- Interrupt Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_INTERRUPT_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertInterruptB) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertInterruptB = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertInterruptB[1], g=CI.D.alerts.colors.alertInterruptB[2], b=CI.D.alerts.colors.alertInterruptB[3]}
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
                getFunc = function() return CI.SV.alerts.toggles.showAlertUnmit end,
                setFunc = function(v) CI.SV.alerts.toggles.showAlertUnmit = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.showAlertUnmit,
            },
            {
                -- Unmit Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_UNMIT_TP),
                getFunc = function() return CI.SV.alerts.formats.alertUnmit end,
                setFunc = function(v) CI.SV.alerts.formats.alertUnmit = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertUnmit,
            },
            {
                -- Unmit Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_UNMIT_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertUnmit) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertUnmit = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertUnmit[1], g=CI.D.alerts.colors.alertUnmit[2], b=CI.D.alerts.colors.alertUnmit[3]}
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
                getFunc = function() return CI.SV.alerts.toggles.showAlertPower end,
                setFunc = function(v) CI.SV.alerts.toggles.showAlertPower = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.showAlertPower,
            },
            {
                -- Power Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POWER_TP),
                getFunc = function() return CI.SV.alerts.formats.alertPower end,
                setFunc = function(v) CI.SV.alerts.formats.alertPower = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertPower,
            },
            {
                -- Prefix Power (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationPowerPrefix end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationPowerPrefix = v end,
                disabled = function() return not (CI.SV.alerts.toggles.alertEnable and CI.SV.alerts.toggles.showAlertPower) end,
                default = CI.D.alerts.toggles.mitigationPowerPrefix,
            },
            {
                -- Prefix Power (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationPowerPrefixN end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationPowerPrefixN = v end,
                disabled = function() return not (CI.SV.alerts.toggles.alertEnable and CI.SV.alerts.toggles.showAlertPower) end,
                default = CI.D.alerts.toggles.mitigationPowerPrefixN,
            },
            {
                -- Power Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POWER_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertPower) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertPower = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertPower[1], g=CI.D.alerts.colors.alertPower[2], b=CI.D.alerts.colors.alertPower[3]}
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
                getFunc = function() return CI.SV.alerts.toggles.showAlertDestroy end,
                setFunc = function(v) CI.SV.alerts.toggles.showAlertDestroy = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.showAlertDestroy,
            },
            {
                -- Destroy Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DESTROY_TP),
                getFunc = function() return CI.SV.alerts.formats.alertDestroy end,
                setFunc = function(v) CI.SV.alerts.formats.alertDestroy = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertDestroy,
            },
            {
                -- Prefix Destroy (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationDestroyPrefix end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationDestroyPrefix = v end,
                disabled = function() return not (CI.SV.alerts.toggles.alertEnable and CI.SV.alerts.toggles.showAlertDestroy) end,
                default = CI.D.alerts.toggles.mitigationDestroyPrefix,
            },
            {
                -- Prefix Destroy (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationDestroyPrefixN end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationDestroyPrefixN = v end,
                disabled = function() return not (CI.SV.alerts.toggles.alertEnable and CI.SV.alerts.toggles.showAlertDestroy) end,
                default = CI.D.alerts.toggles.mitigationDestroyPrefixN,
            },
            {
                -- Destroy Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DESTROY_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertDestroy) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertDestroy = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertDestroy[1], g=CI.D.alerts.colors.alertDestroy[2], b=CI.D.alerts.colors.alertDestroy[3]}
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
                getFunc = function() return CI.SV.alerts.toggles.showAlertSummon end,
                setFunc = function(v) CI.SV.alerts.toggles.showAlertSummon = v end,
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.showAlertSummon,
            },
            {
                -- Summon Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_SUMMON_TP),
                getFunc = function() return CI.SV.alerts.formats.alertSummon end,
                setFunc = function(v) CI.SV.alerts.formats.alertSummon = v end,
                isMultiline = false,
                default = CI.D.alerts.formats.alertSummon,
            },
            {
                -- Prefix Summon (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationSummonPrefix end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationSummonPrefix = v end,
                disabled = function() return not (CI.SV.alerts.toggles.alertEnable and CI.SV.alerts.toggles.showAlertSummon) end,
                default = CI.D.alerts.toggles.mitigationSummonPrefix,
            },
            {
                -- Prefix Summon (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CI.SV.alerts.toggles.mitigationSummonPrefixN end,
                setFunc = function(v) CI.SV.alerts.toggles.mitigationSummonPrefixN = v end,
                disabled = function() return not (CI.SV.alerts.toggles.alertEnable and CI.SV.alerts.toggles.showAlertSummon) end,
                default = CI.D.alerts.toggles.mitigationSummonPrefixN,
            },
            {
                -- Summon Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_SUMMON_TP),
                getFunc = function() return unpack(CI.SV.alerts.colors.alertSummon) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.alertSummon = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.alertSummon[1], g=CI.D.alerts.colors.alertSummon[2], b=CI.D.alerts.colors.alertSummon[3]}
            },

            {
                type = "header",
                name = "CROWD CONTROL COLOR OPTIONS",
                width = "full",
            },
            {
                -- Stun
                type    = "colorpicker",
                name    = "CC COLOR - STUN",
                tooltip = "TODO",
                getFunc = function() return unpack(CI.SV.alerts.colors.stunColor) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.stunColor = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.stunColor[1], g=CI.D.alerts.colors.stunColor[2], b=CI.D.alerts.colors.stunColor[3]}
            },
            {
                -- Disorient
                type    = "colorpicker",
                name    = "CC COLOR - DISORIENT",
                tooltip = "TODO",
                getFunc = function() return unpack(CI.SV.alerts.colors.disorientColor) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.disorientColor = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.disorientColor[1], g=CI.D.alerts.colors.disorientColor[2], b=CI.D.alerts.colors.disorientColor[3]}
            },
            {
                -- Fear
                type    = "colorpicker",
                name    = "CC COLOR - FEAR",
                tooltip = "TODO",
                getFunc = function() return unpack(CI.SV.alerts.colors.fearColor) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.fearColor = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.fearColor[1], g=CI.D.alerts.colors.fearColor[2], b=CI.D.alerts.colors.fearColor[3]}
            },
            {
                -- Silence
                type    = "colorpicker",
                name    = "CC COLOR - SILENCE",
                tooltip = "TODO",
                getFunc = function() return unpack(CI.SV.alerts.colors.silenceColor) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.silenceColor = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.silenceColor[1], g=CI.D.alerts.colors.silenceColor[2], b=CI.D.alerts.colors.silenceColor[3]}
            },
            {
                -- Stagger
                type    = "colorpicker",
                name    = "CC COLOR - STAGGER",
                tooltip = "TODO",
                getFunc = function() return unpack(CI.SV.alerts.colors.staggerColor) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.sstaggerColor = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.staggerColor[1], g=CI.D.alerts.colors.staggerColor[2], b=CI.D.alerts.colors.staggerColor[3]}
            },
            {
                -- Unbreakable
                type    = "colorpicker",
                name    = "CC COLOR - UNBREAKABLE",
                tooltip = "TODO",
                getFunc = function() return unpack(CI.SV.alerts.colors.unbreakableColor) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.colors.unbreakableColor = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.unbreakableColor[1], g=CI.D.alerts.colors.unbreakableColor[2], b=CI.D.alerts.colors.unbreakableColor[3]}
            },
            {
                -- Snare
                type    = "colorpicker",
                name    = "CC COLOR - SNARE",
                tooltip = "TODO",
                getFunc = function() return unpack(CI.SV.alerts.colors.snareColor) end,
                setFunc = function(r, g, b, a) CI.SV.alerts.snareColor = { r, g, b, a } CI.SetAlertColors() end,
                default = {r=CI.D.alerts.colors.snareColor[1], g=CI.D.alerts.colors.snareColor[2], b=CI.D.alerts.colors.snareColor[3]}
            },

            {
                type = "header",
                name = "ALERT SOUND OPTIONS",
                width = "full",
            },

            {
                -- Play Sound Priority 3
                type    = "checkbox",
                name    = "Enable Sound - (No CC) Priority 3",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable3 end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable3 = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable3,
            },

            {
                -- Sound Priority 3
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound3 end,
                setFunc = function(value) CI.SV.alerts.sounds.sound3 = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound3,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 3 CC
                type    = "checkbox",
                name    = "Enable Sound - (Hard CC) Priority 3",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable3CC end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable3CC = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable3CC,
            },

            {
                -- Sound Priority 3 CC
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound3CC end,
                setFunc = function(value) CI.SV.alerts.sounds.sound3CC = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound3CC,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 3 UB
                type    = "checkbox",
                name    = "Enable Sound - (Unbreakable CC) Priority 3",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable3UB end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable3UB = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable3UB,
            },

            {
                -- Sound Priority 3 UB
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound3UB end,
                setFunc = function(value) CI.SV.alerts.sounds.sound3UB = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound3UB,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 2
                type    = "checkbox",
                name    = "Enable Sound - (No CC) Priority 2",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable2 end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable2 = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable2,
            },

            {
                -- Sound Priority 2
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound2 end,
                setFunc = function(value) CI.SV.alerts.sounds.sound2 = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound2,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 2 CC
                type    = "checkbox",
                name    = "Enable Sound - (Hard CC) Priority 2",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable2CC end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable2CC = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable2CC,
            },

            {
                -- Sound Priority 2 CC
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound2CC end,
                setFunc = function(value) CI.SV.alerts.sounds.sound2CC = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound2CC,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 2 UB
                type    = "checkbox",
                name    = "Enable Sound - (Unbreakable CC) Priority 2",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable2UB end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable2UB = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable2UB,
            },

            {
                -- Sound Priority 2 UB
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound2UB end,
                setFunc = function(value) CI.SV.alerts.sounds.sound2UB = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound2UB,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 1
                type    = "checkbox",
                name    = "Enable Sound - (No CC) Priority 1",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable1 end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable1 = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable1,
            },

            {
                -- Sound Priority 1
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound1 end,
                setFunc = function(value) CI.SV.alerts.sounds.sound1 = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound1,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 1 CC
                type    = "checkbox",
                name    = "Enable Sound - (Hard CC) Priority 1",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable1CC end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable1CC = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable1CC,
            },

            {
                -- Sound Priority 1 CC
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound1CC end,
                setFunc = function(value) CI.SV.alerts.sounds.sound1CC = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound1CC,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Priority 1 UB
                type    = "checkbox",
                name    = "Enable Sound - (Unbreakable CC) Priority 1",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnable1UB end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnable1UB = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnable1UB,
            },

            {
                -- Sound Priority 1 UB
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.sound1UB end,
                setFunc = function(value) CI.SV.alerts.sounds.sound1UB = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.sound1UB,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Unmit
                type    = "checkbox",
                name    = "Play Sound - Unmitigable",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnableUnmit end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnableUnmit = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnableUnmit,
            },

            {
                -- Sound Unmit
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.soundUnmit end,
                setFunc = function(value) CI.SV.alerts.sounds.soundUnmit = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.soundUnmit,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Power
                type    = "checkbox",
                name    = "Play Sound Power",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnablePower end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnablePower = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnablePower,
            },

            {
                -- Sound Power
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.soundPower end,
                setFunc = function(value) CI.SV.alerts.sounds.soundPower = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.soundPower,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Summon
                type    = "checkbox",
                name    = "Play Sound - Summon",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnableSummon end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnableSummon = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnableSummon,
            },

            {
                -- Sound Summon
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.soundSummon end,
                setFunc = function(value) CI.SV.alerts.sounds.soundSummon = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.soundSummon,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Play Sound Destroy
                type    = "checkbox",
                name    = "Play Sound - Destroy",
                tooltip = "TODO",
                getFunc = function() return CI.SV.alerts.toggles.soundEnableDestroy end,
                setFunc = function(v) CI.SV.alerts.toggles.soundEnableDestroy = v end,
                width = "half",
                disabled = function() return not CI.SV.alerts.toggles.alertEnable end,
                default = CI.D.alerts.toggles.soundEnableDestroy,
            },

            {
                -- Sound Destroy
                type = "dropdown",
                scrollable = true,
                name = "",
                tooltip = "TODO",
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return CI.SV.alerts.sounds.soundDestroy end,
                setFunc = function(value) CI.SV.alerts.sounds.soundDestroy = value CI.PreviewAlertSound(value) end,
                width = "half",
                default = CI.SV.alerts.sounds.soundDestroy,
                disabled = function() return not (CI.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

        },
    }

    -- Register the settings panel
    if LUIE.SV.CombatInfo_Enabled then
        LAM:RegisterAddonPanel('LUIECombatInfoOptions', panelDataCombatInfo)
        LAM:RegisterOptionControls('LUIECombatInfoOptions', optionsDataCombatInfo)
    end
end
