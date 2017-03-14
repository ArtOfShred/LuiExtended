local strformat = zo_strformat

-- Create Settings Menu
function LUIE_CreateSettings()
    -- Load LibAddonMenu
    local LAM2  = LibStub("LibAddonMenu-2.0")

    local l_BuffsMovingEnabled  = false -- Helper local flag
    local FontsList             = {}
    local FontsListCombatInfo   = {}
    local StatusbarTexturesList = {}

    -- Get Fonts
    for f in pairs(LUIE.Fonts) do
        table.insert(FontsList, f)
    end
    for key, _ in pairs(LUIE.CombatInfo.FontFamilies) do
        table.insert(FontsListCombatInfo, key)
    end
    for key, _ in pairs(LUIE.StatusbarTextures) do
        table.insert(StatusbarTexturesList, key)
    end

    local styleOptions                  = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" }
    local nameDisplayOptions            = { "@UserID", "Character Name", "Character Name @UserID" }
    local nameDisplayOptionsKeys        = { ["@UserID"] = 1, ["Character Name"] = 2, ["Character Name @UserID"] = 3 }
    local chatnameDisplayOptions        = { "@UserID", "Character Name", "Character Name @UserID" }
    local chatnameDisplayOptionsKeys    = { ["@UserID"] = 1, ["Character Name"] = 2, ["Character Name @UserID"] = 3 }
    local currencyBracketOptions        = { "[]", "()", "Hyphen", "No Brackets" }
    local currencyBracketOptionsKeys    = { ["[]"] = 1, ["()"] = 2, ["Hyphen"] =3, ["No Brackets"] = 4 }
    local itemBracketOptions            = { "[]", "()", "Hyphen", "No Brackets" }
    local itemBracketOptionsKeys        = { ["[]"] = 1, ["()"] = 2, ["Hyphen"] =3, ["No Brackets"] = 4 }
    local experienceDisplayOptions      = { "Value", "Percentage", "Both" }
    local experienceDisplayOptionsKeys  = { ["Value"] = 1, ["Percentage"] = 2, ["Both"] = 3 }
    local guildrankDisplayOptions       = { "Self Only", "Self + All w/ Permissions", "Display All Rank Changes" }
    local guildrankDisplayOptionsKeys   = { ["Self Only"] = 1, ["Self + All w/ Permissions"] = 2, ["Display All Rank Changes"] = 3 }
    local rotationOptions               = { "Horizontal", "Vertical" }
    local rotationOptionsKeys           = { ["Horizontal"] = 1, ["Vertical"] = 2 }
    local hAlignOptions                 = { "Left", "Centered", "Right" }
    local vAlignOptions                 = { "Top", "Middle", "Bottom" }

    local formatOptions = {
        "Nothing",
        "Current",
        "Current + Shield",
        "Max",
        "Percentage%",
        "Current / Max",
        "Current + Shield / Max",
        "Current / Max (Percentage%)",
        "Current + Shield / Max (Percentage%)",
        "Current (Percentage%)",
        "Current + Shield (Percentage%)"
    }

    local panelData = {
        type = "panel",
        name = LUIE.name,
        displayName = strformat(LUIE.name, GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = "http://www.esoui.com/downloads/info818-LuiExtended.html",
        slashCommand = "/luiset",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local panelDataUnitFrames = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_UF)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_UF), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = "http://www.esoui.com/downloads/info818-LuiExtended.html",
        slashCommand = "/luiframes",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsData = {}
    local optionsDataUnitFrames = {}

    -- ReloadUI Button
    optionsData[#optionsData + 1] = {
        type = "button",
        name = "Reload UI",
        tooltip = GetString(SI_LUIE_LAM_RELOADUI),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Info Panel Options
    optionsData[#optionsData + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_IP_HEADER),
        reference = "Info_Panel_Options_Submenu",
        controls = {
            {
                -- Show InfoPanel
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWPANEL),
                tooltip = GetString(SI_LUIE_LAM_IP_SHOWPANEL_TOOLTIP),
                getFunc = function() return LUIE.SV.InfoPanel_Enabled end,
                setFunc = function(value) LUIE.SV.InfoPanel_Enabled = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.D.InfoPanel_Enabled,
            },
            {
                -- Unlock InfoPanel
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_UNLOCKPANEL),
                tooltip = GetString(SI_LUIE_LAM_IP_UNLOCKPANEL_TOOLTIP),
                getFunc = function() return LUIE.InfoPanel.panelUnlocked end,
                setFunc = LUIE.InfoPanel.SetMovingState,
                width = "half",
                default = false,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
                resetFunc = LUIE.InfoPanel.ResetPosition,
            },
            {
                -- Reset InfoPanel position
                type = "button",
                name = GetString(SI_LUIE_LAM_RESETPOSITION),
                tooltip = GetString(SI_LUIE_LAM_IP_RESETPOSITION_TOOLTIP),
                func = LUIE.InfoPanel.ResetPosition,
                width = "half",
            },
            {
                -- InfoPanel scale
                type = "slider",
                name = GetString(SI_LUIE_LAM_IP_PANELSCALE),
                tooltip = GetString(SI_LUIE_LAM_IP_PANELSCALE_TOOLTIP),
                min = 100, max = 300, step = 10,
                getFunc = function() return LUIE.InfoPanel.SV.panelScale end,
                setFunc = function(value) LUIE.InfoPanel.SV.panelScale = value LUIE.InfoPanel.SetScale() end,
                width = "full",
                default = 100,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_IP_ELEMENTS_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWLATENCY),
                getFunc = function() return not LUIE.InfoPanel.SV.HideLatency end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideLatency = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWCLOCK),
                getFunc = function() return not LUIE.InfoPanel.SV.HideClock end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideClock = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWFPS),
                getFunc = function() return not LUIE.InfoPanel.SV.HideFPS end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideFPS = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWMOUNTTIMER),
                tooltip = GetString(SI_LUIE_LAM_IP_SHOWMOUNTTIMER_TOOLTIP),
                getFunc = function() return not LUIE.InfoPanel.SV.HideMountFeed end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideMountFeed = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWARMORDURABILITY),
                getFunc = function() return not LUIE.InfoPanel.SV.HideArmour end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideArmour = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWEAPONCHARGES),
                getFunc = function() return not LUIE.InfoPanel.SV.HideWeapons end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideWeapons = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWBAGSPACE),
                getFunc = function() return not LUIE.InfoPanel.SV.HideBags end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideBags = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWSOULGEMS),
                getFunc = function() return not LUIE.InfoPanel.SV.HideGems end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideGems = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_SHOWICTROPHYCOUNT),
                getFunc = function() return LUIE.InfoPanel.SV.ShowTrophy end,
                setFunc = function(value) LUIE.InfoPanel.SV.ShowTrophy = value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = false,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "header",
                name = GetString(SI_PLAYER_MENU_MISC),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_IP_DISABLECOLORSRO),
                tooltip = GetString(SI_LUIE_LAM_IP_DISABLECOLORSRO_TOOLTIP),
                getFunc = function() return LUIE.InfoPanel.SV.DisableInfoColours end,
                setFunc = function(value) LUIE.InfoPanel.SV.DisableInfoColours = value end,
                width = "full",
                default = false,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
        },
    }
    -- Combat Info Options
    optionsData[#optionsData + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CI_HEADER),
        reference = "Combat_Info_Options_Submenu",
        controls = {
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_SHOWCOMBATINFO),
                tooltip = GetString(SI_LUIE_LAM_CI_SHOWCOMBATINFO_TOOLTIP),
                getFunc = function() return LUIE.SV.CombatInfo_Enabled end,
                setFunc = function(value) LUIE.SV.CombatInfo_Enabled = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.D.CombatInfo_Enabled,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_SHOWCOOLDOWNS),
                tooltip = GetString(SI_LUIE_LAM_CI_SHOWCOOLDOWNS_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.CoolDown end,
                setFunc = function(value) LUIE.CombatInfo.SV.CoolDown = value end,
                width = "full",
                default = LUIE.CombatInfo.D.CoolDown,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CI_ULTIMATETRACKING_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_SHOWULTIMATEVALUE),
                tooltip = GetString(SI_LUIE_LAM_CI_SHOWULTIMATEVALUE_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.UltimateEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateEnabled = value LUIE.CombatInfo.OnSlotsFullUpdate(nil) end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_HIDEPERCENTWHENFULL),
                tooltip = GetString(SI_LUIE_LAM_CI_HIDEPERCENTWHENFULL_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.UltimateHideFull end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateHideFull = value end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateHideFull,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.UltimateEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ENABLEULTIREADYALERT),
                tooltip = GetString(SI_LUIE_LAM_CI_ENABLEULTIREADYALERT_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.UltimateAlert end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateAlert = value end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateAlert,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_SHOWULTIGENTEXTURE),
                tooltip = GetString(SI_LUIE_LAM_CI_SHOWULTIGENTEXTURE_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.UltimateGeneration end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateGeneration = value end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateGeneration,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CI_CLOUDTYPE_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_CLOUDTYPE_UNLOCK),
                tooltip = GetString(SI_LUIE_LAM_CI_CLOUDTYPE_UNLOCK_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.panelUnlocked end,
                setFunc = LUIE.CombatInfo.SetMovingState,
                width = "half",
                default = false,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
                resetFunc = LUIE.CombatInfo.ResetPosition,
            },
            {
                type = "button",
                name = GetString(SI_INTERFACE_OPTIONS_FRAMERATE_LATENCY_POSITION_RESET),
                tooltip = GetString(SI_LUIE_LAM_CI_CLOUDTYPE_RESETPOSITION),
                func = LUIE.CombatInfo.ResetPosition,
                width = "half",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_CLOUDTYPE_ENABLE),
                getFunc = function() return LUIE.CombatInfo.SV.CloudTextEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.CloudTextEnabled = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.CombatInfo.D.CloudTextEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_LARGEFONT),
                tooltip = GetString(SI_LUIE_LAM_CI_LARGEFONT_TOOLTIP),
                min = 20, max = 50, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.FontCloudSizeLarge end,
                setFunc = function(value) LUIE.CombatInfo.SV.FontCloudSizeLarge = value LUIE.CombatInfo.PrepareFonts(true) end,
                width = "full",
                default = LUIE.CombatInfo.D.FontCloudSizeLarge,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CloudTextEnabled) end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_MEDIUMFONT),
                tooltip = GetString(SI_LUIE_LAM_CI_MEDIUMFONT_TOOLTIP),
                min = 14, max = 40, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.FontCloudSizeMedium end,
                setFunc = function(value) LUIE.CombatInfo.SV.FontCloudSizeMedium = value LUIE.CombatInfo.PrepareFonts(true) end,
                width = "full",
                default = LUIE.CombatInfo.D.FontCloudSizeMedium,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CloudTextEnabled) end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_SMALLFONT),
                tooltip = GetString(SI_LUIE_LAM_CI_SMALLFONT_TOOLTIP),
                min = 12, max = 30, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.FontCloudSizeSmall end,
                setFunc = function(value) LUIE.CombatInfo.SV.FontCloudSizeSmall = value LUIE.CombatInfo.PrepareFonts(true) end,
                width = "full",
                default = LUIE.CombatInfo.D.FontCloudSizeSmall,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CloudTextEnabled) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_LABELICONS),
                tooltip = GetString(SI_LUIE_LAM_CI_LABELICONS_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.ShowIconsCloud end,
                setFunc = function(value) LUIE.CombatInfo.SV.ShowIconsCloud = value end,
                width = "full",
                default = LUIE.CombatInfo.D.ShowIconsCloud,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CloudTextEnabled) end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CI_SCROLLTYPE_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_SCROLLTYPE_ENABLE),
                getFunc = function() return LUIE.CombatInfo.SV.ScrollTextEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.ScrollTextEnabled = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.CombatInfo.D.ScrollTextEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_LARGEFONT),
                tooltip = GetString(SI_LUIE_LAM_CI_LARGEFONT_TOOLTIP),
                min = 20, max = 50, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.FontScrollSizeLarge end,
                setFunc = function(value) LUIE.CombatInfo.SV.FontScrollSizeLarge = value LUIE.CombatInfo.PrepareFonts(true) end,
                width = "full",
                default = LUIE.CombatInfo.D.FontScrollSizeLarge,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.ScrollTextEnabled) end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_MEDIUMFONT),
                tooltip = GetString(SI_LUIE_LAM_CI_MEDIUMFONT_TOOLTIP),
                min = 14, max = 40, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.FontScrollSizeMedium end,
                setFunc = function(value) LUIE.CombatInfo.SV.FontScrollSizeMedium = value LUIE.CombatInfo.PrepareFonts(true) end,
                width = "full",
                default = LUIE.CombatInfo.D.FontScrollSizeMedium,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.ScrollTextEnabled) end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_SMALLFONT),
                tooltip = GetString(SI_LUIE_LAM_CI_SMALLFONT_TOOLTIP),
                min = 12, max = 30, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.FontScrollSizeSmall end,
                setFunc = function(value) LUIE.CombatInfo.SV.FontScrollSizeSmall = value LUIE.CombatInfo.PrepareFonts(true) end,
                width = "full",
                default = LUIE.CombatInfo.D.FontScrollSizeSmall,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.ScrollTextEnabled) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_LABELICONS),
                tooltip = GetString(SI_LUIE_LAM_CI_LABELICONS_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.ShowIconsScroll end,
                setFunc = function(value) LUIE.CombatInfo.SV.ShowIconsScroll = value end,
                width = "full",
                default = LUIE.CombatInfo.D.ShowIconsScroll,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.ScrollTextEnabled) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_SCROLLTYPE_QEVENTS),
                tooltip = GetString(SI_LUIE_LAM_CI_SCROLLTYPE_QEVENTS_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.PurgeExpiredScroll end,
                setFunc = function(value) LUIE.CombatInfo.SV.PurgeExpiredScroll = value end,
                width = "full",
                default = LUIE.CombatInfo.D.PurgeExpiredScroll,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.ScrollTextEnabled) end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CI_COMMON_HEADER),
                width = "full",
            },
            {
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CI_COMMON_FONTFAMILY),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_FONTFAMILY_TOOLTIP),
                choices = FontsListCombatInfo,
                getFunc = function() return LUIE.CombatInfo.SV.FontFamily end,
                setFunc = function(var) LUIE.CombatInfo.SV.FontFamily = var LUIE.CombatInfo.PrepareFonts(true) end,
                width = "full",
                sort = "name-up",
                default = LUIE.CombatInfo.D.FontFamily,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_COMBATTEXT),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_COMBATTEXT_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.CombatEventsEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.CombatEventsEnabled = value LUIE.CombatInfo.RegisterCombatEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.CombatEventsEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_THROTTLE),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_THROTTLE_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.ThrottleEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.ThrottleEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.ThrottleEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWINCDOT),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWINCDOT_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.DotsInEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.DotsInEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.DotsInEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWOUTDOT),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWOUTDOT_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.DotsOutEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.DotsOutEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.DotsOutEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWINCHEAL),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWINCHEAL_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.HealingInEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.HealingInEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.HealingInEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWOUTHEAL),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWOUTHEAL_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.HealingOutEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.HealingOutEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.HealingOutEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_DMGCOLORS),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_DMGCOLORS_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.DamageColoured end,
                setFunc = function(value) LUIE.CombatInfo.SV.DamageColoured = value end,
                width = "full",
                default = LUIE.CombatInfo.D.DamageColoured,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWCCEVENTS),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWCCEVENTS_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.CombatCCEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.CombatCCEnabled = value LUIE.CombatInfo.RegisterCombatEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.CombatCCEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWATTRDRAIN),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWATTRDRAIN_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.DrainEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.DrainEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.DrainEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWATTRNRG),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWATTRNRG_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.EnergizeEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.EnergizeEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.EnergizeEnabled,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatEventsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWXPGAIN),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWXPGAIN_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.ExperienceEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.ExperienceEnabled = value LUIE.CombatInfo.RegisterXPEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.ExperienceEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWAPGAIN),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWAPGAIN_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.AllianceEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.AllianceEnabled = value LUIE.CombatInfo.RegisterAPEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.AllianceEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMMON_SHOWTVGAIN),
                tooltip = GetString(SI_LUIE_LAM_CI_COMMON_SHOWTVGAIN_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.TelVarEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.TelVarEnabled = value LUIE.CombatInfo.RegisterTSEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.TelVarEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_ENABLETIPS),
                tooltip = GetString(SI_LUIE_LAM_CI_ALERTS_ENABLETIPS_TOOLTIP),
                warning = GetString(SI_LUIE_LAM_CI_ALERTS_ENABLETIPS_WARRNING),
                getFunc = function() return LUIE.CombatInfo.SV.CombatTipsEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.CombatTipsEnabled = value LUIE.CombatInfo.RegisterCombatTipEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.CombatTipsEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_HIDEZOSTIPS),
                tooltip = GetString(SI_LUIE_LAM_CI_ALERTS_HIDEZOSTIPS_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.HideIngameTips end,
                setFunc = function(value) LUIE.CombatInfo.SV.HideIngameTips = value ZO_ActiveCombatTips:SetHidden(value) end,
                width = "full",
                default = LUIE.CombatInfo.D.HideIngameTips,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CombatTipsEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_ENABLEDEATH),
                tooltip = GetString(SI_LUIE_LAM_CI_ALERTS_ENABLEDEATH_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.GroupDeathEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.GroupDeathEnabled = value LUIE.CombatInfo.RegisterDeathEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.GroupDeathEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_LOWATTRIB),
                tooltip = GetString(SI_LUIE_LAM_CI_ALERTS_LOWATTRIB_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.LowEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.LowEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.LowEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_THRESHOLD),
                min = 10, max = 50, step = 5,
                getFunc = function() return LUIE.CombatInfo.SV.LowThreshold end,
                setFunc = function(value) LUIE.CombatInfo.SV.LowThreshold = value LUIE.CombatInfo.thresholdAttribute = 0.01 * value end,
                width = "half",
                default = LUIE.CombatInfo.D.LowThreshold,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.LowEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_NOTIFYSOUND),
                tooltip = GetString(GetString(SI_LUIE_LAM_CI_ALERTS_NOTIFYSOUND_TOOLTIP)),
                getFunc = function() return LUIE.CombatInfo.SV.LowSound end,
                setFunc = function(value) LUIE.CombatInfo.SV.LowSound = value end,
                width = "half",
                default = LUIE.CombatInfo.D.LowSound,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.LowEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_EXECUTE),
                tooltip = GetString(SI_LUIE_LAM_CI_ALERTS_EXECUTE_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.ExecuteEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.ExecuteEnabled = value end,
                width = "full",
                default = LUIE.CombatInfo.D.ExecuteEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_THRESHOLD),
                min = 20, max = 35, step = 1,
                getFunc = function() return LUIE.CombatInfo.SV.ExecuteThreshold end,
                setFunc = function(value) LUIE.CombatInfo.SV.ExecuteThreshold = value LUIE.CombatInfo.thresholdExecute = 0.01 * value end,
                width = "half",
                default = LUIE.CombatInfo.D.ExecuteThreshold,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.ExecuteEnabled ) end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_ALERTS_TIMEOUT),
                tooltip = GetString(SI_LUIE_LAM_CI_ALERTS_TIMEOUT_TOOLTIP),
                min = 4, max = 20, step = 1,
                getFunc = function() return LUIE.CombatInfo.SV.ExecuteTimeout end,
                setFunc = function(value) LUIE.CombatInfo.SV.ExecuteTimeout = value end,
                width = "half",
                default = LUIE.CombatInfo.D.ExecuteTimeout,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.ExecuteEnabled ) end,
            },
            {
                type = "header",
                name = GetString(SI_PLAYER_MENU_MISC),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_COMBATSTATE),
                tooltip = GetString(SI_LUIE_LAM_CI_COMBATSTATE_TOOLTIP),
                getFunc = function() return LUIE.CombatInfo.SV.CombatStateEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.CombatStateEnabled = value LUIE.CombatInfo.RegisterCombatStateEvent() end,
                width = "full",
                default = LUIE.CombatInfo.D.CombatStateEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
        },
    }
    -- Buffs and Debuffs Options
    optionsData[#optionsData + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_BUFF_HEADER),
        reference = "Buffs_and_Debuffs_Options_Submenu",
        controls = {
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_ENABLEEFFECTSTRACK),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ENABLEEFFECTSTRACK_TOOLTIP),
                getFunc = function() return LUIE.SV.SpellCastBuff_Enable end,
                setFunc = function(value) LUIE.SV.SpellCastBuff_Enable = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.D.SpellCastBuff_Enable,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetBuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetDebuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetDebuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
             {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideGroundEffects end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideGroundEffects = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.SV.HideGroundEffects,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_HARDLOCK),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.lockPositionToUnitFrames end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.lockPositionToUnitFrames = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_WARNING),
                default = LUIE.SpellCastBuffs.D.lockPositionToUnitFrames,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_UNLOCKWINDOW),
                tooltip = GetString(SI_LUIE_LAM_BUFF_UNLOCKWINDOW_TOOLTIP),
                getFunc = function() return l_BuffsMovingEnabled end,
                setFunc = function(value)
                    l_BuffsMovingEnabled = value
                    LUIE.SpellCastBuffs.SetMovingState(value)
                    end,
                width = "half",
                default = false,
                resetFunc = LUIE.SpellCastBuffs.ResetTlwPosition,
            },
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_RESETPOSITION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_RESETPOSITION_TOOLTIP),
                func = LUIE.SpellCastBuffs.ResetTlwPosition,
                width = "half",
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_BUFF_ICONOPTIONS),
                width = "full",
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_BUFF_ICONSIZE),
                min = 30, max = 60, step = 2,
                getFunc = function() return LUIE.SpellCastBuffs.SV.IconSize end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IconSize = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.IconSize,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN_TOOLTIP),
                choices = hAlignOptions,
                getFunc = function() return LUIE.SpellCastBuffs.SV.Alignment end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignment,
                width = "full",
                default = LUIE.SpellCastBuffs.D.Alignment,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT),
                choices = {"Left to Right", "Right to Left"},
                getFunc = function() return LUIE.SpellCastBuffs.SV.SortDirection end,
                setFunc = LUIE.SpellCastBuffs.SetSortDirection,
                width = "full",
                default = LUIE.SpellCastBuffs.D.SortDirection,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.GlowIcons end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.GlowIcons = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.GlowIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWBOARDERCOOLDOWN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWBOARDERCOOLDOWN_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingCooldown end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingCooldown = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingCooldown,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.FadeOutIcons end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.FadeOutIcons = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.FadeOutIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingText end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingText = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingText,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_FONT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTS_TOOLTIP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontFace end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.BuffFontFace = var LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.BuffFontFace,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.RemainingText ) end,
            },
            {
                type = "slider",
                name = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTS_SIZE_TOOLTIP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontSize end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.BuffFontSize = value LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.BuffFontSize,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.RemainingText ) end,
            },
            {
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_FONT_STYLE),
                choices = styleOptions,
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontStyle end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.BuffFontStyle = var LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.BuffFontStyle,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.RemainingText ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_COLOUREDTIMELABEL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_COLOUREDTIMELABE_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingTextColoured end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingTextColoured = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingTextColoured,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.RemainingText ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingTextMillis end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingTextMillis = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingTextMillis,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.RemainingText ) end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SELF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SELF_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffects_Player end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffects_Player = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffects_Player,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffects_Target end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffects_Target = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffects_Target,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMundusPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMundusPlayer = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMundusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMundusTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMundusTarget = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMundusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPPLAYER_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreVampLycanPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreVampLycanPlayer = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreVampLycanPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPTARGET_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreVampLycanTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreVampLycanTarget = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreVampLycanTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreCyrodiilPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreCyrodiilPlayer = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreCyrodiilPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
             {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreCyrodiilTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreCyrodiilTarget = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreCyrodiilTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritPlayer = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBattleSpiritPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritTarget = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBattleSpiritTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Ignore ESO Plus - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreEsoPlusPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreEsoPlusPlayer = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreEsoPlusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Ignore ESO Plus - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreEsoPlusTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreEsoPlusTarget = not value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreEsoPlusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },

            {
                -- Show Disguises
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreDisguise end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreDisguise = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreDisguise,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Show Costumes
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_COSTUME),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_COSTUME_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreCostume end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreCostume = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreCostume,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Show Hats
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HAT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HAT_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreHat end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreHat = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreHat,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Show Skins
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SKIN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SKIN_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSkin end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSkin = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSkin,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Show Polymorphs
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_POLYMORPH),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_POLYMORPH_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnorePolymorph end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnorePolymorph = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnorePolymorph,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Show Assistants
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreAssistant end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreAssistant = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreAssistant,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Show Pets
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnorePet end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnorePet = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnorePet,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Show Mounts
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_TOOLTIP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMount end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMount = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMount,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Seperate control for player effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffectsSeparate,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player ) end,
            },
            {
                -- Container orientation
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER_TOOLTIP),
                choices = rotationOptions,
                getFunc = function() return rotationOptions[LUIE.SpellCastBuffs.SV.LongTermEffectsSeparateAlignment] end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffectsSeparateAlignment = rotationOptionsKeys[value] LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = rotationOptions[2],
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player and LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate ) end,
            },
            {
                -- Vertical Icons Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERTALIGNICON),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERTALIGNICON_TOOLTIP),
                choices = vAlignOptions,
                getFunc = function() return LUIE.SpellCastBuffs.SV.AlignmentVert end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignmentVert,
                width = "full",
                default = LUIE.SpellCastBuffs.D.AlignmentVert,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffectsSeparateAlignment == 2) end,
            },
            {
                -- SpellCastBuffs Miscellaneous
                type = "header",
                name = GetString(SI_PLAYER_MENU_MISC),
                width = "full",
            },
            {
                -- Highlight Ability Bar Icon for Active Procs
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_BARICONPROC),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_BARICONPROC_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowTriggered end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowTriggered = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowTriggered,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Highlight Ability Bar Icon for Active Effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_BARICONEFFECT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_BARICONEFFECT_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowToggled end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowToggled = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowToggled,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Block Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowBlockPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowBlockPlayer = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowBlockPlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Block Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowBlockTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowBlockTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowBlockTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Stealth Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.StealthStatePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.StealthStatePlayer = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.StealthStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Stealth Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.StealthStateTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.StealthStateTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.StealthStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWDISGUISEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWDISGUISEPLAYER_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.DisguiseStatePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.DisguiseStatePlayer = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.DisguiseStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWDISGUISETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWDISGUISETARGET_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.DisguiseStateTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.DisguiseStateTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.DisguiseStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Sprint Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowSprint end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowSprint = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowSprint,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Gallop Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowGallop end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowGallop = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowGallop,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Rezz Immunity Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowResurrectionImmunity end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowResurrectionImmunity = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowResurrectionImmunity,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Recall Cooldown Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL_TOOLTIP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowRecall end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowRecall = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowRecall,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
        },
    }
    -- Damage Meter and Combat Log Options
    -- Not gonna add localization support atm since we might get rid of that component.
    optionsData[#optionsData + 1] = {
        type = "submenu",
        name = "Damage Meter & Combat Log",
        reference = "Damage_Meter_and_Combat_Log_Submenu",
        controls = {
            {
                type = "checkbox",
                name = "Enable Damage Meter",
                tooltip = "Counts damage and healing done.",
                getFunc = function() return LUIE.SV.DamageMeter_Enable end,
                setFunc = function(value) LUIE.SV.DamageMeter_Enable = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.D.DamageMeter_Enable,
            },
            {
                type = "slider",
                name = "Timeout Threshold",
                tooltip = "Number of seconds without damage to signal encounter termination.",
                min = 1, max = 10, step = 1,
                getFunc = function() return LUIE.DamageMeter.SV.DamageTimeout end,
                setFunc = function(value) LUIE.DamageMeter.SV.DamageTimeout = value end,
                width = "full",
                disabled = function() return not LUIE.SV.DamageMeter_Enable end,
                default = LUIE.DamageMeter.D.DamageTimeout,
            },
            {
                type = "checkbox",
                name = "Update Damage Statistics in realtime",
                tooltip = "Update Full Damage Meter window during combat. Otherwise it is updated when being displayed with information of last combat.",
                getFunc = function() return LUIE.DamageMeter.SV.UpdateFullRealtime end,
                setFunc = function(value) LUIE.DamageMeter.SV.UpdateFullRealtime = value end,
                width = "full",
                disabled = function() return not LUIE.SV.DamageMeter_Enable end,
                default = LUIE.DamageMeter.D.UpdateFullRealtime,
            },
            {
                type = "checkbox",
                name = "Unlock window",
                tooltip = "Allow mouse dragging for Damage Meter window.",
                getFunc = function() return LUIE.DamageMeter.panelUnlocked end,
                setFunc = LUIE.DamageMeter.SetMovingState,
                width = "half",
                default = false,
                disabled = function() return not LUIE.SV.DamageMeter_Enable end,
                resetFunc = LUIE.DamageMeter.ResetTlwPosition,
            },
            {
                type = "button",
                name = "Reset position",
                tooltip = "This will reset position of Damage Meter window into screen top left corner.",
                func = LUIE.DamageMeter.ResetTlwPosition,
                width = "half",
            },
            {
                type = "header",
                name = "Meter Mini-panel",
                width = "full",
            },
            {
                type = "checkbox",
                name = "Show Fight time label",
                tooltip = "Include Fight time control as 4th element on mini-panel.",
                getFunc = function() return LUIE.DamageMeter.SV.FightTime end,
                setFunc = function(value) LUIE.DamageMeter.SV.FightTime = value LUIE.DamageMeter.LayoutMiniPanel() end,
                width = "full",
                default = LUIE.DamageMeter.D.FightTime,
                disabled = function() return not LUIE.SV.DamageMeter_Enable end,
            },
            {
                type = "checkbox",
                name = "Show Background on Mini-meter panel",
                tooltip = "Create mini-panel with background or leave it completely transparent.",
                getFunc = function() return LUIE.DamageMeter.SV.Backdrop end,
                setFunc = function(value) LUIE.DamageMeter.SV.Backdrop = value LUIE.DamageMeter.LayoutMiniPanel() end,
                width = "full",
                default = LUIE.DamageMeter.D.Backdrop,
                disabled = function() return not LUIE.SV.DamageMeter_Enable end,
            },
            {
                type = "header",
                name = "Notes",
                width = "full",
            },
            {
                type = "description",
                text = "You can click on incoming damage label to display full combat statistics for completed fight. Clicking on 'fight time' label will display graphical log of the fight. To report to chat your damage/healing performance click on damage and healing text labels on the meter mini-panel.",
            },
            {
                type = "description",
                text = "You can also setup unique key bindings for those actions in standard game 'Controls' menu.",
            },
            {
                type = "checkbox",
                name = "Enable Combat Log",
                tooltip = "Enable Combat Log component to print combat related information into separate chat tab named 'Combat Log'.",
                getFunc = function() return LUIE.DamageMeter.SV.CombatLog end,
                setFunc = function(value) LUIE.DamageMeter.SV.CombatLog = value LUIE.DamageMeter.RegisterCombatStateEvent() LUIE.DamageMeter.RegisterEffectChangedEvent() end,
                width = "full",
                default = LUIE.DamageMeter.D.CombatLog,
                disabled = function() return not LUIE.SV.DamageMeter_Enable end,
            },
            {
                type = "checkbox",
                name = "Include Time Stamp",
                tooltip = "Include time of each combat event.",
                getFunc = function() return LUIE.DamageMeter.SV.LogTimeStamp end,
                setFunc = function(value) LUIE.DamageMeter.SV.LogTimeStamp = value end,
                width = "full",
                default = LUIE.DamageMeter.D.LogTimeStamp,
                disabled = function() return not (LUIE.SV.DamageMeter_Enable and LUIE.DamageMeter.SV.CombatLog) end,
            },
            {
                type = "checkbox",
                name = "Focus in combat",
                tooltip = "Switch active chat tab to CombatLog when enterring combat and resore the original one when finishing combat.",
                getFunc = function() return LUIE.DamageMeter.SV.CombatLogFocus end,
                setFunc = function(value) LUIE.DamageMeter.SV.CombatLogFocus = value LUIE.DamageMeter.RegisterCombatStateEvent() end,
                width = "full",
                default = LUIE.DamageMeter.D.CombatLogFocus,
                disabled = function() return not (LUIE.SV.DamageMeter_Enable and LUIE.DamageMeter.SV.CombatLog) end
            },
            {
                type = "checkbox",
                name = "Log debuffs on player",
                tooltip = "Include in CombatLog events when negative effect was applied to player character.",
                getFunc = function() return LUIE.DamageMeter.SV.CombatLogDebuff end,
                setFunc = function(value) LUIE.DamageMeter.SV.CombatLogDebuff = value LUIE.DamageMeter.RegisterEffectChangedEvent() end,
                width = "full",
                default = LUIE.DamageMeter.D.CombatLogDebuff,
                disabled = function() return not (LUIE.SV.DamageMeter_Enable and LUIE.DamageMeter.SV.CombatLog) end,
            },
            {
                type = "slider",
                name = "Font Size Adjustment",
                tooltip = "Used to change size of Combat Log font with respect to default chat font size.",
                min = -3, max = 2, step = 1,
                getFunc = function() return LUIE.DamageMeter.SV.CombatLogFont end,
                setFunc = function(value) LUIE.DamageMeter.SV.CombatLogFont = value LUIE.DamageMeter.OnPlayerActivated() end,
                width = "full",
                default = LUIE.DamageMeter.D.CombatLogFont,
                disabled = function() return not (LUIE.SV.DamageMeter_Enable and LUIE.DamageMeter.SV.CombatLog) end,
            },
            {
                type = "checkbox",
                name = "Preserve between logins",
                tooltip = "Try to save last 20 log elements between character logins. Though this will not work if you game crashes instead exiting normally.",
                getFunc = function() return LUIE.DamageMeter.SVC.LogSaveEnable end,
                setFunc = function(value) LUIE.DamageMeter.SVC.LogSaveEnable = value end,
                width = "full",
                default = LUIE.DamageMeter.DC.LogSaveEnable,
                disabled = function() return not (LUIE.SV.DamageMeter_Enable and LUIE.DamageMeter.SV.CombatLog) end,
            },
            {
                type = "description",
                text = "This component will create new chat tab 'CombatLog' and will send all combat related text into it. If you delete this tab it will be automatically recreated. If you wish to stop using this component, then first disable it here in menu and after it delete chat tab manually.",
            },
        },
    }

    -- Chat Announcements Options
    optionsData[#optionsData + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_HEADER),
        reference = "Chat_Announcements_Options_Submenu",
        controls = {
            {
                -- Enable Chat Announcements
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ENABLE),
                tooltip = GetString(SI_LUIE_LAM_CA_ENABLE_TOOLTIP),
                getFunc = function() return LUIE.SV.ChatAnnouncements_Enable end,
                setFunc = function(value) LUIE.SV.ChatAnnouncements_Enable = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.D.ChatAnnouncements_Enable,
            },
            {
                -- Player Name Display Method
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD),
                tooltip = GetString(SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD_TOOLTIP),
                choices = chatnameDisplayOptions,
                getFunc = function() return chatnameDisplayOptions[LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions = chatnameDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = chatnameDisplayOptions[2],
            },
            {
                -- Default String Enhance
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_DEFAULTSTRINGENHANCE),
                tooltip = GetString(SI_LUIE_LAM_CA_DEFAULTSTRINGENHANCE_TOOLTIP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.CustomStrings end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.CustomStrings = value LUIE.ChatAnnouncements.RegisterCustomStrings() end,
                width = "full",
                warning = strformat("<<1>>\n<<2>>", GetString(SI_LUIE_LAM_COMPATIBILITY_WARNING), GetString(SI_LUIE_LAM_RELOADUI_WARNING)),
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.CustomStrings,
            },
            {
                -- Positive Change Color
                type = "colorpicker",
                name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLORUP)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.ChangeColorUp) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.ChangeColorUp = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = {r=LUIE.ChatAnnouncements.D.ChangeColorUp[1], g=LUIE.ChatAnnouncements.D.ChangeColorUp[2], b=LUIE.ChatAnnouncements.D.ChangeColorUp[3]}
            },
            {
                -- Negative Change Color
                type = "colorpicker",
                name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLORDOWN)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.ChangeColorDown) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.ChangeColorDown = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = {r=LUIE.ChatAnnouncements.D.ChangeColorDown[1], g=LUIE.ChatAnnouncements.D.ChangeColorDown[2], b=LUIE.ChatAnnouncements.D.ChangeColorDown[3]}
            },
            {
                -- CA Miscellaneous Announcements Submenu
                type = "submenu",
                name = GetString(SI_LUIE_LAM_CA_MISC_HEADER),
                reference = "Chat_Announcements_Options_Misc_Announcements_Submenu",
                controls = {
                    {
                        -- Show Group Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWGROUP),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWGROUP_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupChatMsg end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupChatMsg = value LUIE.ChatAnnouncements.RegisterGroupEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupChatMsg,
                    },
                    {
                        -- Show Trade Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWTRADE),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWTRADE),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscTrade end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscTrade = value LUIE.ChatAnnouncements.RegisterTradeEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscTrade,
                    },
                    {
                        -- Show Mail Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscMail end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscMail = value LUIE.ChatAnnouncements.RegisterMailEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscMail,
                    },
                    {
                        -- Show Duel Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_DUEL),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_DUEL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscDuel end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscDuel = value LUIE.ChatAnnouncements.RegisterDuelEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscDuel,
                    },
                    {
                        -- Show Pledge of Mara Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_MARA),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_MARA_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscMara end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscMara = value LUIE.ChatAnnouncements.RegisterMaraEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscMara,
                    },
                    {
                        -- Show Social Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWSOCIAL),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWSOCIAL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscSocial end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscSocial = value LUIE.ChatAnnouncements.RegisterSocialEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscSocial,
                    },
                    {
                        -- Show Guild Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILD),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILD_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscGuild end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscGuild = value LUIE.ChatAnnouncements.RegisterGuildEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscGuild,
                    },
                    {
                        -- Show Guild Events Icons
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDICONS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDICONS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscGuildIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscGuildIcon = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.MiscGuild and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.MiscGuildIcon,
                    },
                    {
                        -- Show Guild Rank Events
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDRANK)),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDRANK_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscGuildRank end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscGuildRank = value LUIE.ChatAnnouncements.RegisterGuildEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.MiscGuild and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.MiscGuildRank,
                    },
                    {
                        -- Show Guild Rank Events Display Options
                        type = "dropdown",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDRANKDISPLAY)),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDRANKDISPLAY_TOOLTIP),
                        choices = guildrankDisplayOptions,
                        getFunc = function() return guildrankDisplayOptions[LUIE.ChatAnnouncements.SV.GuildRankDisplayOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildRankDisplayOptions = guildrankDisplayOptionsKeys[value] LUIE.ChatAnnouncements.RegisterGuildEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.MiscGuild and LUIE.ChatAnnouncements.SV.MiscGuildRank and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = guildrankDisplayOptions[1],
                    },
                    {
                        -- Show Guild MOTD Events
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDMOTD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWGUILDMOTD_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscGuildMOTD end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscGuildMOTD = value LUIE.ChatAnnouncements.RegisterGuildEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.MiscGuild and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.MiscGuildMOTD,
                    },
                    {
                        -- Show Bank/Bag Upgrade
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscBags end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscBags = value LUIE.ChatAnnouncements.RegisterBagEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscBags,
                    },
                    {
                        -- Show Riding Skill Upgrade
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscHorse end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscHorse = value LUIE.ChatAnnouncements.RegisterHorseEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscHorse,
                    },
                    {
                        -- Show Lockpick Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscLockpick end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscLockpick = value LUIE.ChatAnnouncements.RegisterLockpickEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscLockpick,
                    },
                    {
                        -- Show Justice Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscConfiscate end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscConfiscate = value LUIE.ChatAnnouncements.RegisterDestroyEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscConfiscate,
                    },
                    {
                        -- Show Disguise Events
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWDISGUISE),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWDISGUISE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscDisguise end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscDisguise = value LUIE.ChatAnnouncements.RegisterDisguiseEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.MiscDisguise,
                    },
                    {
                        -- Show Disguise Alerts
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_MISC_SHOWDISGUISEALERT),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_SHOWDISGUISEALERT_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.MiscDisguiseAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.MiscDisguiseAlert = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.MiscDisguise) end,
                        default = LUIE.ChatAnnouncements.D.MiscDisguiseAlert,
                    },
                },
            },
            {
                -- CA Currency Announcements Options Submenu
                type = "submenu",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_HEADER),
                reference = "Chat_Announcements_Options_Currency_Announcements_Submenu",
                controls = {
                    {
                        -- Show Currency Icons
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyIcons end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyIcons = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CurrencyIcons,
                    },
                    {
                        -- Show Gold
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWGOLD),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWGOLD_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GoldChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GoldChange = value LUIE.ChatAnnouncements.RegisterGoldEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GoldChange,
                    },
                    {
                        -- Show Gold Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWGOLDCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.GoldColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.GoldColor = { r, g, b, a } CA.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.GoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.GoldColor[1], g=LUIE.ChatAnnouncements.D.GoldColor[2], b=LUIE.ChatAnnouncements.D.GoldColor[3]}
                    },
                    {
                        -- Show Gold Name
                        type = "editbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWGOLDNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWGOLDNAME_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GoldName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GoldName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.GoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.GoldName,
                    },
                    {
                        -- Show Gold Total Amount
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWGOLDTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWGOLDTOTAL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.TotalGoldChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.TotalGoldChange = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.GoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.TotalGoldChange,
                    },
                    {
                        -- Hide Gold Spent on AH
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT)),
                        tooltip = strformat("<<1>>\n<<2>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT_TOOLTIP), GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT_NOTE)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GoldHideAHSpente end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GoldHideAHSpent = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.GoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.GoldHideAHSpent,
                    },
                    {
                        -- Show Alliance Points
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AlliancePointChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AlliancePointChange = value LUIE.ChatAnnouncements.RegisterAlliancePointEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.AlliancePointChange,
                    },
                    {
                        -- Show Alliance Points Threshold
                        type = "slider",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AlliancePointFilter end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AlliancePointFilter = value end,
                        min = 0,
                        max = 10000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AlliancePointChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AlliancePointFilter,
                    },
                    {
                        -- Show Alliance Points Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.AlliancePointColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.AlliancePointColor = { r, g, b, a } CA.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AlliancePointChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.AlliancePointColor[1], g=LUIE.ChatAnnouncements.D.AlliancePointColor[2], b=LUIE.ChatAnnouncements.D.AlliancePointColor[3]}
                    },
                    {
                        -- Show Alliance Points Name
                        type = "editbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AlliancePointName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AlliancePointName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AlliancePointChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.TotalAlliancePointName,
                    },
                    {
                        -- Show Alliance Points Total
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.TotalAlliancePointChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.TotalAlliancePointChange = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AlliancePointChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.TotalAlliancePointChange,
                    },
                    {
                        -- Show Tel Var
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.TelVarStoneChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.TelVarStoneChange = value LUIE.ChatAnnouncements.RegisterTelVarStoneEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.TelVarStoneChange,
                    },
                    {
                        -- Show Tel Var Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.TelVarStoneColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.TelVarStoneColor = { r, g, b, a } CA.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.TelVarStoneChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.TelVarStoneColor[1], g=LUIE.ChatAnnouncements.D.TelVarStoneColor[2], b=LUIE.ChatAnnouncements.D.TelVarStoneColor[3]}
                    },
                    {
                        -- Show Tel Var Name
                        type = "editbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.TelVarStoneName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.TelVarStoneName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.TelVarStoneChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.TelVarStoneName,
                    },
                    {
                        -- Show Tel Var Total
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.TotalTelVarStoneChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.TotalTelVarStoneChange = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.TelVarStoneChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.TotalTelVarStoneChange,
                    },
                    {
                        -- Show Writ Vouchers
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.WritVoucherChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.WritVoucherChange = value LUIE.ChatAnnouncements.RegisterWritVoucherEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.WritVoucherChange,
                    },
                    {
                        -- Show Writ Vouchers Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.WritVoucherColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.WritVoucherColor = { r, g, b, a } CA.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.WritVoucherChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.WritVoucherColor[1], g=LUIE.ChatAnnouncements.D.WritVoucherColor[2], b=LUIE.ChatAnnouncements.D.WritVoucherColor[3]}
                    },
                    {
                        -- Show Writ Vouchers Name
                        type = "editbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.WritVoucherName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.WritVoucherName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.WritVoucherChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.WritVoucherName,
                    },
                    {
                        -- Show Writ Vouchers Total
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.TotalWritVoucherChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.TotalWritVoucherChange = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.WritVoucherChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.TotalWritVoucherChange,
                    },
                    {
                        -- Bracket Settings for Context Specific Messages
                        type = "dropdown",
                        name = GetString(SI_LUIE_LAM_CA_CSMBRACKET),
                        choices = currencyBracketOptions,
                        tooltip = GetString(SI_LUIE_LAM_CA_CSMBRACKET_TOOLTIP),
                        getFunc = function() return currencyBracketOptions[LUIE.ChatAnnouncements.SV.CurrencyBracketDisplayOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyBracketDisplayOptions = currencyBracketOptionsKeys[value] end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.GoldChange or
                                LUIE.ChatAnnouncements.SV.AlliancePointChange or
                                LUIE.ChatAnnouncements.SV.TelVarStoneChange or
                                LUIE.ChatAnnouncements.SV.WritVoucherChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = currencyBracketOptions[1]
                    },
                    {
                        -- Override Context specific messages
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CSMOVERRIDE),
                        tooltip = strformat("<<1>>\n<<2>>", GetString(SI_LUIE_LAM_CA_CSMOVERRIDE_TOOLTIP), GetString(SI_LUIE_LAM_CA_CSMOVERRIDE_NOTE)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyContextToggle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyContextToggle = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.GoldChange or
                                LUIE.ChatAnnouncements.SV.AlliancePointChange or
                                LUIE.ChatAnnouncements.SV.TelVarStoneChange or
                                LUIE.ChatAnnouncements.SV.WritVoucherChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyContextToggle,
                    },
                    {
                        -- Context Override Message Currency Gain
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_CSMCURRENCY_GAIN),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CSMCURRENCY_GAIN_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyContextMessageUp end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyContextMessageUp = value end,
                        width = "full",
                        disabled =  function() return not (LUIE.ChatAnnouncements.SV.CurrencyContextToggle and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyContextMessageUp,
                    },
                    {
                        -- Context Override Message Currency Loss
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_CSMCURRENCY_LOSS),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CSMCURRENCY_LOSS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyContextMessageDown end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyContextMessageDown = value end,
                        width = "full",
                        disabled =  function() return not (LUIE.ChatAnnouncements.SV.CurrencyContextToggle and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyContextMessageDown,
                    },
                    {
                        -- Total Currency Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_TOTALCURRENCYMSG),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TOTALCURRENCYMSG_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyTotalMessage end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyTotalMessage = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.GoldChange or
                                LUIE.ChatAnnouncements.SV.AlliancePointChange or
                                LUIE.ChatAnnouncements.SV.TelVarStoneChange or
                                LUIE.ChatAnnouncements.SV.WritVoucherChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyTotalMessage,
                    },
                },
            },
            {
                -- CA Loot Announcements Options Submenu
                type = "submenu",
                name = GetString(SI_LUIE_LAM_CA_LOOT_HEADER),
                reference = "Chat_Announcements_Options_Loot_Announcements_Submenu",
                controls = {
                    {
                        -- Show looted item icons
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootIcons end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootIcons = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootIcons,
                    },
                    {
                        -- Show looted items
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.Loot end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.Loot = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.Loot,
                    },
                    {
                        -- Show notable loot
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootOnlyNotable end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootOnlyNotable = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootOnlyNotable,
                    },
                    {
                        -- Show group loot
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootGroup end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootGroup = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootGroup,
                    },
                    {
                        -- Hide annoying items
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootBlacklist end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootBlacklist = value end,
                        width = "full",
                        warning = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_WARNING),
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootBlacklist,
                    },
                    {
                        -- Show Vendor Inventory Changes
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootVendor end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootVendor = value LUIE.ChatAnnouncements.RegisterVendorEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootVendor,
                    },
                    {
                        -- Show Bank Inventory Changes
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootBank end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootBank = value LUIE.ChatAnnouncements.RegisterBankEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootBank,
                    },
                    {
                        -- Show Mail Inventory Changes
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMail end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMail = value LUIE.ChatAnnouncements.RegisterMailEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMail,
                    },
                    {
                        -- Show Trade
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootTrade end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootTrade = value LUIE.ChatAnnouncements.RegisterTradeEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootTrade,
                    },
                    {
                        -- Show Craft
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootCraft end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootCraft = value LUIE.ChatAnnouncements.RegisterCraftEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootCraft,
                    },
                    {
                        -- Show Materials consumed when crafting
                        type = "checkbox",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ShowCraftUse end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ShowCraftUse = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.LootCraft and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ShowCraftUse,
                    },
                    {
                        -- Show Confiscated Items
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCONFISCATED),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCONFISCATED_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ShowConfiscate end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ShowConfiscate = value LUIE.ChatAnnouncements.RegisterDestroyEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ShowConfiscate,
                    },
                    {
                        -- Show Destroyed Items
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWDESTROYED),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWDESTROYED_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ShowDestroy end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ShowDestroy = value LUIE.ChatAnnouncements.RegisterDestroyEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ShowDestroy,
                    },
                    {
                        -- Show Disguise Equip
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWDISGUISE),
                        tooltip = strformat("<<1>>\n<<2>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWDISGUISE_TOOLTIP), GetString(SI_LUIE_LAM_CA_LOOT_SHOWDISGUISE_NOTE)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ShowDisguise end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ShowDisguise = value LUIE.ChatAnnouncements.RegisterDestroyEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ShowDisguise,
                    },
                    {
                        -- Show Armor Type
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowArmorType end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowArmorType = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.Loot or
                                LUIE.ChatAnnouncements.SV.LootCraft or
                                LUIE.ChatAnnouncements.SV.LootTrade or
                                LUIE.ChatAnnouncements.SV.LootMail or
                                LUIE.ChatAnnouncements.SV.LootVendor or
                                LUIE.ChatAnnouncements.SV.LootBank
                            )) end,
                        default = LUIE.ChatAnnouncements.D.LootShowArmorType,
                    },
                    {
                        -- Show Item Trait
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowTrait end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowTrait = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.Loot or
                                LUIE.ChatAnnouncements.SV.LootCraft or
                                LUIE.ChatAnnouncements.SV.LootTrade or
                                LUIE.ChatAnnouncements.SV.LootMail or
                                LUIE.ChatAnnouncements.SV.LootVendor or
                                LUIE.ChatAnnouncements.SV.LootBank
                            )) end,
                        default = LUIE.ChatAnnouncements.D.LootShowTrait,
                    },
                    {
                        -- Show Item Style
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowStyle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowStyle = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.Loot or
                                LUIE.ChatAnnouncements.SV.LootCraft or
                                LUIE.ChatAnnouncements.SV.LootTrade or
                                LUIE.ChatAnnouncements.SV.LootMail or
                                LUIE.ChatAnnouncements.SV.LootVendor or
                                LUIE.ChatAnnouncements.SV.LootBank
                            )) end,
                        default = LUIE.ChatAnnouncements.D.LootShowStyle,
                    },
                    {
                        -- Hide Trash Quality Items
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootNotTrash end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootNotTrash = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.Loot or
                                LUIE.ChatAnnouncements.SV.LootCraft or
                                LUIE.ChatAnnouncements.SV.LootTrade or
                                LUIE.ChatAnnouncements.SV.LootMail or
                                LUIE.ChatAnnouncements.SV.LootVendor or
                                LUIE.ChatAnnouncements.SV.LootBank
                            )) end,
                        default = LUIE.ChatAnnouncements.D.LootNotTrash,
                    },
                    {
                        -- Show Collectible Items
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_COLLECTIBLE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_COLLECTIBLE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootCollectible end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootCollectible = value LUIE.ChatAnnouncements.RegisterCollectibleEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootCollectible,
                    },
                    {
                        -- Collectible Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_COLLECTIBLE_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.LootCollectibleColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.LootCollectibleColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.LootCollectible) end,
                        default = {r=LUIE.ChatAnnouncements.D.LootCollectibleColor[1], g=LUIE.ChatAnnouncements.D.LootCollectibleColor[2], b=LUIE.ChatAnnouncements.D.LootCollectibleColor[3]}
                    },
                    {
                        -- Bracket Settings for Context Specific Messages
                        type = "dropdown",
                        name = GetString(SI_LUIE_LAM_CA_CSMBRACKET),
                        choices = itemBracketOptions,
                        tooltip = GetString(SI_LUIE_LAM_CA_CSMBRACKET_TOOLTIP),
                        getFunc = function() return itemBracketOptions[LUIE.ChatAnnouncements.SV.ItemBracketDisplayOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ItemBracketDisplayOptions = itemBracketOptionsKeys[value] end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.Loot or
                                LUIE.ChatAnnouncements.SV.LootCraft or
                                LUIE.ChatAnnouncements.SV.LootTrade or
                                LUIE.ChatAnnouncements.SV.LootMail or
                                LUIE.ChatAnnouncements.SV.LootVendor or
                                LUIE.ChatAnnouncements.SV.LootBank
                            )) end,
                        default = itemBracketOptions[1]
                    },
                    {
                        -- Allow override Context specific messages
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CSMOVERRIDE),
                        tooltip = strformat("<<1>>\n<<2>>", GetString(SI_LUIE_LAM_CA_CSMOVERRIDE_TOOLTIP), GetString(SI_LUIE_LAM_CA_CSMOVERRIDE_NOTE)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ItemContextToggle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ItemContextToggle = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.Loot or
                                LUIE.ChatAnnouncements.SV.LootCraft or
                                LUIE.ChatAnnouncements.SV.LootTrade or
                                LUIE.ChatAnnouncements.SV.LootMail or
                                LUIE.ChatAnnouncements.SV.LootVendor or
                                LUIE.ChatAnnouncements.SV.LootBank
                            )) end,
                        default = LUIE.ChatAnnouncements.D.ItemContextToggle,
                    },
                    {
                        -- Context Specific Override Message Loot
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_CSMLOOT_GAIN),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_CSMLOOT_GAIN_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ItemContextMessage end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ItemContextMessage = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.ItemContextToggle and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ItemContextMessage,
                    },
                    {
                        -- Merge LootLog Sales with Currency Changes
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MERGEWITHCURRENCY),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MERGEWITHCURRENCY_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootCurrencyCombo end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootCurrencyCombo = value end,
                        width = "full",
                        warning = GetString(SI_LUIE_LAM_GENERIC_WARNING),
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.Loot or
                                LUIE.ChatAnnouncements.SV.LootCraft or
                                LUIE.ChatAnnouncements.SV.LootTrade or
                                LUIE.ChatAnnouncements.SV.LootMail or
                                LUIE.ChatAnnouncements.SV.LootVendor or
                                LUIE.ChatAnnouncements.SV.LootBank
                            )) end,
                        default = LUIE.ChatAnnouncements.D.LootCurrencyCombo,
                    },
                },
            },
            {
                -- CA Experience Announcements Options Submenu
                type = "submenu",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER),
                reference = "Chat_Announcements_Options_Experience_Announcements_Submenu",
                controls = {
                    {
                        -- Show Level Up Message in Chat
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_LVLUPMSG),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_LVLUPMSG_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceLevelUp end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceLevelUp = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ExperienceLevelUp,
                    },
                    {
                        -- Show Level Icon on Level Up
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LevelUpIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LevelUpIcon = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.ExperienceLevelUp and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LevelUpIcon,
                    },
                    {
                        -- Show Experience Gain
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.Experience end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.Experience = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.Experience,
                    },
                    {
                        -- Show Experience Icon
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceIcon = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceIcon,
                    },
                    {
                        -- Combat Experience Gain Filter Threshold
                        type = "slider",
                        name = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceFilter end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceFilter = value end,
                        min = 0,
                        max = 10000,
                        step = 100,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceFilter,
                    },
                    {
                        -- Context Name for Experience Gain
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINCONTEXTNAME),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINCONTEXTNAME_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceContextName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceContextName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceContextName,
                    },
                    {
                        -- Name for Experience Gain
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINDISPLAYNAME),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINDISPLAYNAME_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceName,
                    },
                    {
                        -- Show Progress to next level
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_PROGRESSTONEXTLVL),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_PROGRESSTONEXTLVL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceShowProgress end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceShowProgress = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceShowProgress,
                    },
                    {
                        -- Progress Display Method
                        type = "dropdown",
                        name = GetString(SI_LUIE_LAM_CA_EXP_PROGRESSDISPLAYMETHOD),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_PROGRESSDISPLAYMETHOD_TOOLTIP),
                        choices = experienceDisplayOptions,
                        getFunc = function() return experienceDisplayOptions[LUIE.ChatAnnouncements.SV.ExperienceDisplayOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceDisplayOptions = experienceDisplayOptionsKeys[value] end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.ChatAnnouncements.SV.ExperienceShowProgress and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = experienceDisplayOptions[1],
                    },
                    {
                        -- Show Color Experience Progress
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_PROGRESSCOLOR),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_PROGRESSCOLOR_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceProgressColor end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceProgressColor = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.ChatAnnouncements.SV.ExperienceShowProgress and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceProgressColor,
                    },
                    {
                        -- Show [x.xx] decimal format
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_SHOWDECIMALFORMAT),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWDECIMALFORMAT_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceShowDecimal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceShowDecimal = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.ChatAnnouncements.SV.ExperienceShowProgress and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceShowDecimal,
                    },
                    {
                        -- Show Progress label
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_SHOWPROGRESSLABEL),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWPROGRESSLABEL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceShowPBrackets end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceShowPBrackets = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.ChatAnnouncements.SV.ExperienceShowProgress and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceShowPBrackets,
                    },
                    {
                        -- Display name for Progress label
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_SHOWPROGRESSLABELNAME),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWPROGRESSLABELNAME_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceProgressName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceProgressName = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.ChatAnnouncements.SV.ExperienceShowProgress and LUIE.ChatAnnouncements.SV.ExperienceShowPBrackets and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceProgressName,
                    },
                    {
                        -- Show Current Level label
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_SHOWCURRENTLVLLABEL),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWCURRENTLVLLABEL_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceShowLevel end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceShowLevel = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceShowLevel,
                    },
                    {
                        -- Color Level by Context
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceColorLevel end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceColorLevel = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceColorLevel,
                    },
                    {
                        -- Hide Experience from Kills
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceHideCombat end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceHideCombat = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceHideCombat,
                    },
                    {
                        -- Throttle Experience gained in combat
                        type = "slider",
                        name = GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceThrottle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceThrottle = value end,
                        min = 0,
                        max = 5,
                        step = 1,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceThrottle,
                    },
                },
            },
            {
                -- CA Experience Announcements Options Submenu
                type = "submenu",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_HEADER),
                reference = "Chat_Announcements_Options_Achievements_Announcements_Submenu",
                controls = {
                    {
                        -- Enable Achievements Tracking
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.Achievements end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievements = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.Achievements,
                    },
                    {
                        -- Achievements Step Size
                        type = "slider",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE_TOOLTIP),
                        min = 0, max = 25, step = 1,
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementsStep end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementsStep = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementsStep,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Show Detailed Achievement Info
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO_TOOLTIP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementsDetails end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementsDetails = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementsDetails,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(1),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(1)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory1 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory1 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory1,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(2),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(2)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory2 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory2 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory2,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(3),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(3)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory3 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory3 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory3,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(4),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(4)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory4 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory4 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory4,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(5),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(5)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory5 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory5 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory5,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(6),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(6)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory6 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory6 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory6,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(7),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(7)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory7 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory7 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory7,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(8),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(8)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory8 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory8 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory8,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(9),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(9)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory9 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory9 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory9,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(10),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(10)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory10 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory10 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory10,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(11),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(11)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory11 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory11 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory11,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = GetAchievementCategoryInfo(12),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_ENABLE_CATEGORY), GetAchievementCategoryInfo(12)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory12 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory12 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory12,
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievements and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                },
            },
        },
    }

    -- Use LUI print to chat for messages
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_LUIPRINTTOCHAT),
        tooltip = GetString(SI_LUIE_LAM_LUIPRINTTOCHAT_TOOLTIP),
        getFunc = function() return LUIE.SV.ChatUseSystem end,
        setFunc = function(value) LUIE.SV.ChatUseSystem = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_GENERIC_WARNING),
        default = LUIE.D.ChatUseSystem,
    }
    -- Include Timestamp
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = strformat("\t\t<<1>>", GetString(SI_LUIE_LAM_TIMESTAMP)),
        tooltip = GetString(SI_LUIE_LAM_TIMESTAMP_TOOLTIP),
        getFunc = function() return LUIE.SV.TimeStamp end,
        setFunc = function(value) LUIE.SV.TimeStamp = value end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatUseSystem end,
        default = LUIE.D.TimeStamp,
    }
    -- Timestamp Format
    optionsData[#optionsData + 1] = {
        type = "editbox",
        name = strformat("\t\t<<1>>", GetString(SI_LUIE_LAM_TIMESTAMPFORMAT)),
        tooltip = GetString(SI_LUIE_LAM_TIMESTAMPFORMAT_TOOLTIP),
        getFunc = function() return LUIE.SV.TimeStampFormat end,
        setFunc = function(value) LUIE.SV.TimeStampFormat = value end,
        width = "full",
        disabled = function() return not (LUIE.SV.ChatUseSystem and LUIE.SV.TimeStamp) end,
        default = LUIE.D.TimeStampFormat,
    }
    -- Startup message options
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_STARTUPMSG),
        tooltip = GetString(SI_LUIE_LAM_STARTUPMSG_TOOLTIP),
        getFunc = function() return LUIE.SV.StartupInfo end,
        setFunc = function(value) LUIE.SV.StartupInfo = value end,
        width = "full",
        default = LUIE.D.StartupInfo,
    }
    -- Slash Commands Overview
    optionsData[#optionsData + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_SLASHCMDSHEADER),
        width = "full",
    }
    -- Slash Commands description
    optionsData[#optionsData + 1] = {
        type = "description",
        text = strformat("<<1>>\n<<2>>\n<<3>>\n<<4>>",
               GetString(SI_LUIE_LAM_SLASHCMDS_HOME),
               GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND),
               GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP),
               GetString(SI_LUIE_LAM_SLASHCMDS_GUILDINV)),
    }
    -- Enable Unit Frames module
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_ENABLE),
        getFunc = function() return LUIE.SV.UnitFrames_Enabled end,
        setFunc = function(value) LUIE.SV.UnitFrames_Enabled = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.UnitFrames_Enabled,
    }
    -- Unit Frames module description
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_UF_DESCRIPTION),
    }
    -- ReloadUI Button
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "button",
        name = "Reload UI",
        tooltip = GetString(SI_LUIE_LAM_RELOADUI),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }
    -- Shorten numbers
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS),
        tooltip = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.ShortenNumbers end,
        setFunc = function(value) LUIE.UnitFrames.SV.ShortenNumbers = value end,
        width = "full",
        default = LUIE.UnitFrames.D.ShortenNumbers,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Default Frames header
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_HEADER),
        width = "full",
    }
    -- Default PLAYER frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_PLAYER),
        choices = LUIE.UnitFrames.GetDefaultFramesOptions('Player'),
        getFunc = function() return LUIE.UnitFrames.GetDefaultFramesSetting('Player') end,
        setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesSetting('Player', value) end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.UnitFrames.GetDefaultFramesSetting('Player', true),
    }
    -- Default TARGET frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_TARGET),
        choices = LUIE.UnitFrames.GetDefaultFramesOptions('Target'),
        getFunc = function() return LUIE.UnitFrames.GetDefaultFramesSetting('Target') end,
        setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesSetting('Target', value) end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.UnitFrames.GetDefaultFramesSetting('Target', true),
    }
    -- Default small GROUP frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_GROUPSMALL),
        choices = LUIE.UnitFrames.GetDefaultFramesOptions('Group'),
        getFunc = function() return LUIE.UnitFrames.GetDefaultFramesSetting('Group') end,
        setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesSetting('Group', value) end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.UnitFrames.GetDefaultFramesSetting('Group', true),
    }
    -- Reposition default player bars
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_REPOSIT),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_REPOSIT_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.RepositionFrames end,
        setFunc = function(value) LUIE.UnitFrames.SV.RepositionFrames = value end,
        width = "full",
        default = LUIE.UnitFrames.D.RepositionFrames,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Format label text
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_TOOLTIP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.Format end,
        setFunc = function(var) LUIE.UnitFrames.SV.Format = var end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.Format,
    }
    -- Out-of-Combat bars transparency
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS_TOOLTIP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.DefaultOocTransparency end,
        setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesTransparency(value, nil) end,
        width = "full",
        default = LUIE.UnitFrames.D.DefaultOocTransparency,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- In-Combat bars transparency
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_INCTRANS),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_INCTRANS_TOOLTIP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.DefaultIncTransparency end,
        setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesTransparency(nil, value) end,
        width = "full",
        default = LUIE.UnitFrames.D.DefaultIncTransparency,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- DefaultFrames Font
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_FONT),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_TOOLTIP),
        choices = FontsList,
        sort = "name-up",
        getFunc = function() return LUIE.UnitFrames.SV.DefaultFontFace end,
        setFunc = function(var) LUIE.UnitFrames.SV.DefaultFontFace = var LUIE.UnitFrames.DefaultFramesApplyFont() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.DefaultFontFace,
    }
    -- DefaultFrames Font Size
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_FONT_SIZE),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_SIZE_TOOLTIP),
        min = 10, max = 30, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.DefaultFontSize end,
        setFunc = function(value) LUIE.UnitFrames.SV.DefaultFontSize = value LUIE.UnitFrames.DefaultFramesApplyFont() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.DefaultFontSize,
    }
    -- DefaultFrames Font Style
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_FONT_STYLE),
        choices = styleOptions,
        sort = "name-up",
        getFunc = function() return LUIE.UnitFrames.SV.DefaultFontStyle end,
        setFunc = function(var) LUIE.UnitFrames.SV.DefaultFontStyle = var LUIE.UnitFrames.DefaultFramesApplyFont() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.DefaultFontStyle,
    }
    -- Color of text labels
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_COLOR),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.DefaultTextColour) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.DefaultTextColour={r,g,b} LUIE.UnitFrames.DefaultFramesApplyColour() end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.DefaultTextColour[1], g=LUIE.UnitFrames.D.DefaultTextColour[2], b=LUIE.UnitFrames.D.DefaultTextColour[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Target class icon
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS),
        tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetShowClass end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetShowClass = value end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetShowClass,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Target ignore/friend/guild icon
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_GFI),
        tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_GFI_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetShowFriend end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetShowFriend = value end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetShowFriend,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Colour target name by reaction
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION),
        tooltip = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetColourByReaction end,
        setFunc = LUIE.UnitFrames.TargetColourByReaction,
        width = "full",
        default = LUIE.UnitFrames.D.TargetColourByReaction,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Header
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_HEADER),
        width = "full",
    }
    -- Custom Unit Frames Unlock
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.CustomFramesMovingState end,
        setFunc = LUIE.UnitFrames.CustomFramesSetMovingState,
        width = "half",
        default = false,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        resetFunc = LUIE.UnitFrames.CustomFramesResetPosition,
    }
    -- Custom Unit Frames Reset position
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT_TOOLTIP),
        func = LUIE.UnitFrames.CustomFramesResetPosition,
        width = "half",
    }
    -- Custom Unit Frames format left label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_FORMATTXT_LEFT),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FORMATTXT_LEFT_TOOLTIP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatOne end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatOne = var LUIE.UnitFrames.CustomFramesFormatLabels() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFormatOne,
    }
    -- Custom Unit Frames format right label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_FORMATTXT_RIGHT),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FORMATTXT_RIGHT_TOOLTIP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatTwo end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatTwo = var LUIE.UnitFrames.CustomFramesFormatLabels() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFormatTwo,
    }
    -- Custom Unit Frames Font
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_FONT),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_TOOLTIP),
        choices = FontsList,
        sort = "name-up",
        getFunc = function() return LUIE.UnitFrames.SV.CustomFontFace end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFontFace = var LUIE.UnitFrames.CustomFramesApplyFont() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFontFace,
    }
    -- Custom Unit Frames Font size labels
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS_TOOLTIP),
        min = 10, max = 30, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFontOther end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFontOther = value LUIE.UnitFrames.CustomFramesApplyFont() end,
        width = "half",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFontOther,
    }
    -- Custom Unit Frames Font size bars
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS_TOOLTIP),
        min = 10, max = 30, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFontBars end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFontBars = value LUIE.UnitFrames.CustomFramesApplyFont() end,
        width = "half",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFontBars,
    }
    -- Custom Unit Frames Font style
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_FONT_STYLE),
        choices = styleOptions,
        sort = "name-up",
        getFunc = function() return LUIE.UnitFrames.SV.CustomFontStyle end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFontStyle = var LUIE.UnitFrames.CustomFramesApplyFont() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFontStyle,
    }
    -- Custom Unit Frames Texture
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_TEXTURE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_TEXTURE_TOOLTIP),
        choices = StatusbarTexturesList,
        sort = "name-up",
        getFunc = function() return LUIE.UnitFrames.SV.CustomTexture end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomTexture = var LUIE.UnitFrames.CustomFramesApplyTexture() end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomTexture,
    }
    -- Custom Unit Frames Display HoT / DoT Animations
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_HOTDOT),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_HOTDOT_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomEnableRegen end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomEnableRegen = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomEnableRegen,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.UnitFrames.SV.CustomEnableRegen end,
    }
    -- Custom Unit Frames Health Bar Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALTH),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealth) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealth={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourHealth[1], g=LUIE.UnitFrames.D.CustomColourHealth[2], b=LUIE.UnitFrames.D.CustomColourHealth[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Shield Bar Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SHIELD),
        getFunc = function() return LUIE.UnitFrames.SV.CustomColourShield[1], LUIE.UnitFrames.SV.CustomColourShield[2], LUIE.UnitFrames.SV.CustomColourShield[3]  end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourShield={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourShield[1], g=LUIE.UnitFrames.D.CustomColourShield[2], b=LUIE.UnitFrames.D.CustomColourShield[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Magicka Bar Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_MAGICKA),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourMagicka) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourMagicka={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourMagicka[1], g=LUIE.UnitFrames.D.CustomColourMagicka[2], b=LUIE.UnitFrames.D.CustomColourMagicka[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Stamina Bar Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_STAMINA),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourStamina) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourStamina={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourStamina[1], g=LUIE.UnitFrames.D.CustomColourStamina[2], b=LUIE.UnitFrames.D.CustomColourStamina[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Group Color Player Role
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.ColorRoleGroup end,
        setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleGroup = value LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = LUIE.UnitFrames.D.ColorRoleGroup,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) ) end,
    }
    -- Custom Unit Frames Raid Color Player Role
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.ColorRoleRaid end,
        setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleRaid = value LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = LUIE.UnitFrames.D.ColorRoleRaid,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) ) end,
    }
    -- Custom Unit Frames DPS Role Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DPS),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourDPS) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourDPS={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourDPS[1], g=LUIE.UnitFrames.D.CustomColourDPS[2], b=LUIE.UnitFrames.D.CustomColourDPS[3] },
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) and (LUIE.UnitFrames.SV.ColorRoleGroup or LUIE.UnitFrames.SV.ColorRoleRaid) ) end,
    }
    -- Custom Unit Frames Healer Role Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALER),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealer) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourHealer[1], g=LUIE.UnitFrames.D.CustomColourHealer[2], b=LUIE.UnitFrames.D.CustomColourHealer[3] },
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) and (LUIE.UnitFrames.SV.ColorRoleGroup or LUIE.UnitFrames.SV.ColorRoleRaid) ) end,
    }
     -- Custom Unit Frames Tank Role Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TANK),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourTank) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourTank={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(isMenu) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourTank[1], g=LUIE.UnitFrames.D.CustomColourTank[2], b=LUIE.UnitFrames.D.CustomColourTank[3] },
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) and (LUIE.UnitFrames.SV.ColorRoleGroup or LUIE.UnitFrames.SV.ColorRoleRaid) ) end,
    }
    -- Custom Unit Frames Separate Shield Bar
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE),
        tooltip = strformat(GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_TOOLTIP), GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_NOTE)),
        getFunc = function() return LUIE.UnitFrames.SV.CustomShieldBarSeparate end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomShieldBarSeparate = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomShieldBarSeparate,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end
    }
    -- Custom Unit Frames Separate Shield Bar Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT),
        min = 4, max = 12, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.CustomShieldBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomShieldBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomShieldBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomShieldBarSeparate ) end,
    }
    -- Custom Unit Frames Overlay Full Height Shield Bar
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomShieldBarFull end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomShieldBarFull = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomShieldBarFull,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and not LUIE.UnitFrames.SV.CustomShieldBarSeparate ) end,
    }
    -- Custom Unit Frames Smooth Bar Transition
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomSmoothBar end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomSmoothBar = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomSmoothBar,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames (Player, Target)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_HEADER),
        width = "full",
    }
    -- Enable LUIE PLAYER frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesPlayer end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesPlayer = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesPlayer,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Enable LUIE Target frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesTarget end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesTarget = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesTarget,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Player Bars Width
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_WIDTH),
        min = 200, max = 500, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Player Health Bar Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_HP_HIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightHealth end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightHealth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerBarHeightHealth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Player Magicka Bar Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_HIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightMagicka end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightMagicka = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerBarHeightMagicka,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Player Stamina Bar Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_HIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightStamina end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightStamina = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerBarHeightStamina,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Hide Player Magicka Bar Label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.HideLabelMagicka end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideLabelMagicka = value LUIE.UnitFrames.SV.HideBarMagicka = false end,
        width = "full",
        default = LUIE.UnitFrames.D.HideLabelMagicka,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Hide Player Magicka Bar
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR_TOOLTIP),
        getFunc = function() return LUIE.UnitFrames.SV.HideBarMagicka end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideBarMagicka = value end,
        width = "full",
        default = LUIE.UnitFrames.D.HideBarMagicka,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.HideLabelMagicka ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Hide Player Stamina Bar Label",
        tooltip = "Completely hide the Player Stamina Bar",
        getFunc = function() return LUIE.UnitFrames.SV.HideLabelStamina end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideLabelStamina = value LUIE.UnitFrames.SV.HideBarStamina = false end,
        width = "full",
        default = LUIE.UnitFrames.D.HideLabelStamina,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Hide Player Stamina Bar",
        tooltip = "Hide just the label on the Player Stamina Bar",
        getFunc = function() return LUIE.UnitFrames.SV.HideBarStamina end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideBarStamina = value end,
        width = "full",
        default = LUIE.UnitFrames.D.HideBarStamina,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.HideLabelStamina ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Spacing between Player Bars",
        min = -1, max = 4, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerBarSpacing end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerBarSpacing,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display Your name on Player Frame",
        tooltip = "Display your character name and level on the player frame.",
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableYourname end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableYourname = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableYourname,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display Mount/Siege/Werewolf Bar",
        tooltip = "Display alternative meaning bar to track mount stamina, siege weapon health, werewolf time left.",
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarMSW end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarMSW = value LUIE.UnitFrames.CustomFramesSetupAlternative() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableAltbarMSW,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display XP/Champion XP Bar",
        tooltip = "Display alternative meaning bar to track player experience.",
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarXP end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarXP = value LUIE.UnitFrames.CustomFramesSetupAlternative() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableAltbarXP,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Champion XP Bar Point-Type Colour",
        tooltip = "Set colour of ChampionXP bar (Experience bar for vr14 players) to be dependent on type of Champion Point being earned.",
        getFunc = function() return LUIE.UnitFrames.SV.PlayerChampionColour end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerChampionColour = value LUIE.UnitFrames.OnChampionPointGained() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerChampionColour,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerEnableAltbarXP ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display Armor stat change",
        tooltip = "Display additional icon on unit health bar when unit has its armor affected. Also displays cracked texture over health bar when armor is decreased.",
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableArmor end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableArmor = value end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableArmor,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    --[[optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display Weapon Power stat change",
        tooltip = "Display additional icon on unit health bar when unit has its weapon power affected.",
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableWeaponPower end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableWeaponPower = value end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableWeaponPower,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }]]--
    --[[optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display Spell Power stat change",
        tooltip = "Display additional icon on unit health bar when unit has its spell power affected.",
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableSpellPower end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableSpellPower = value end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableSpellPower,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }]]--
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Out-of-Combat frame opacity",
        tooltip = "Opacity of Player custom frame when not engaged in combat.",
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.CustomOocAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomOocAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "In-Combat frame opacity",
        tooltip = "Opacity of Player custom frame when engaged in combat.",
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.CustomIncAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomIncAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Treat Missing Power as In-Combat",
        -- tooltip = "",
        getFunc = function() return LUIE.UnitFrames.SV.CustomOocAlphaPower end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomOocAlphaPower = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomOocAlphaPower,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Apply same opacity to Target frame",
        tooltip = "Apply same transparency setting to Target frame as well. If this option is disabled, the Targets frame will have always 'In-Combat' values of opacity.",
        getFunc = function() return LUIE.UnitFrames.SV.CustomOocAlphaTarget end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomOocAlphaTarget = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomOocAlphaTarget,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Target Bars Width",
        min = 200, max = 500, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.TargetBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Target Bar Height",
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.TargetBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display Target class label",
        tooltip = "Display text label with target class name on target frame together with class icon.",
        getFunc = function() return LUIE.UnitFrames.SV.TargetEnableClass end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableClass = value end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetEnableClass,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Execute Health % Threshold",
        tooltip = "Determines the threshold of HP to color the target label text red, as well as display the skull execute texture if enabled.",
        min = 0, max = 50, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.ExecutePercentage end,
        setFunc = function(value) LUIE.UnitFrames.SV.ExecutePercentage = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.UnitFrames.D.ExecutePercentage,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Display Skull Execute Texture",
        tooltip = "Display Skull texture next to custom target frame for low-health target that should be executed.",
        getFunc = function() return LUIE.UnitFrames.SV.TargetEnableSkull end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableSkull = value end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetEnableSkull,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = "Custom Unit Frames (Group)",
        width = "full",
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Enable This Addon GROUP frames",
        tooltip = "Create custom GROUP unit frames.",
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesGroup end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesGroup = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesGroup,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Enable Default GROUP frames",
        tooltip = "This will show default UI small group unit frames when group size is less or equal then 4.",
        getFunc = function() return not ( LUIE.UnitFrames.SV.GroupDisableDefault and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) ) end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupDisableDefault = not value LUIE.UnitFrames.CustomFramesGroupUpdate() end,
        width = "full",
        default = not LUIE.UnitFrames.D.GroupDisableDefault,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Include Player in Group Frame",
        -- tooltip = "",
        getFunc = function() return not LUIE.UnitFrames.SV.GroupExcludePlayer end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupExcludePlayer = (not value) LUIE.UnitFrames.CustomFramesGroupUpdate() end,
        width = "full",
        default = not LUIE.UnitFrames.D.GroupExcludePlayer,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Group Bars Width",
        min = 100, max = 400, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.GroupBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Group Bars Height",
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.GroupBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Spacing between Group Bars",
        min = 20, max = 80, step = 2,
        getFunc = function() return LUIE.UnitFrames.SV.GroupBarSpacing end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupBarSpacing,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Show Role Icon on Group Frames",
        tooltip = "This will show the selected player role on group frames.",
        getFunc = function() return LUIE.UnitFrames.SV.RoleIconSmallGroup end,
        setFunc = function(value) LUIE.UnitFrames.SV.RoleIconSmallGroup = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.RoleIconSmallGroup,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = "Custom Unit Frames (Raid)",
        width = "full",
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Enable This Addon RAID frames",
        tooltip = "Create custom RAID unit frames. If custom GROUP frames are used, then this raid frame will also be used for small groups.",
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesRaid end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesRaid = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesRaid,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Enable Default RAID frames",
        tooltip = "This will show default UI RAID unit frames when group size is larger then 4.",
        getFunc = function() return not ( LUIE.UnitFrames.SV.RaidDisableDefault and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidDisableDefault = not value LUIE.UnitFrames.CustomFramesGroupUpdate() end,
        width = "full",
        default = not LUIE.UnitFrames.D.RaidDisableDefault,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Raid Bars Width",
        min = 100, max = 500, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.RaidBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "Raid Bars Height",
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.RaidBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = "Raid Frame Layout",
        tooltip = "Select layout of raid frame in format 'columns*rows'.",
        choices = { '1 x 24', '2 x 12', '3 x 8', '4 x 6', '6 x 4' },
        -- sort = "name-up",
        getFunc = function() return LUIE.UnitFrames.SV.RaidLayout end,
        setFunc = function(var) LUIE.UnitFrames.SV.RaidLayout = var LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
        default = LUIE.UnitFrames.D.RaidLayout,
    }
    --[[
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Sort Raid Frame",
        tooltip = "Perform alphabetic sort of members in raid-size group. This is a default UI behaviour. If for any reason you prefer to have raid members sorted according to internal game numbering, you can switch off this option.",
        getFunc = function() return LUIE.UnitFrames.SV.RaidSort end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidSort = value LUIE.UnitFrames.CustomFramesGroupUpdate() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidSort,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    } ]]--
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Add Spacer for every 4 members",
        tooltip = "Add a small spacer between raid members frames to visualize default group splitting.",
        getFunc = function() return LUIE.UnitFrames.SV.RaidSpacers end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidSpacers = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidSpacers,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Show Role Icon on Raid Frames",
        tooltip = "This will show the selected player role on raid frames.",
        getFunc = function() return LUIE.UnitFrames.SV.RoleIconRaid end,
        setFunc = function(value) LUIE.UnitFrames.SV.RoleIconRaid  = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RoleIconRaid,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and (LUIE.UnitFrames.SV.CustomFramesGroup or LUIE.UnitFrames.SV.CustomFramesRaid) ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = "Custom Unit Frames (Boss)",
        width = "full",
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Enable This Addon BOSS frames",
        tooltip = "Create custom BOSS unit frames. This will track health of up to 6 bosses in dungeons encounters.",
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesBosses end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesBosses = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesBosses,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = "Custom Unit Frames (PvP Target Frame)",
        width = "full",
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Enable additional PvP Target frame",
        tooltip = "Create additional custom target unit frames. This will track health of hostile pvp players only. It also by default has larger size, less information and positioned on screen center.",
        getFunc = function() return LUIE.UnitFrames.SV.AvaCustFramesTarget end,
        setFunc = function(value) LUIE.UnitFrames.SV.AvaCustFramesTarget = value end,
        width = "full",
        default = LUIE.UnitFrames.D.AvaCustFramesTarget,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "PvP Target Bars Width",
        min = 300, max = 700, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.AvaTargetBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = "PvP Target Bar Height",
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.AvaTargetBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = "Common options",
        width = "full",
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = "Name Display Method",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        tooltip = "Determines the method used to display other player names on unit frames. This setting does not effect the player frame.\nDefault: Character Name",
        choices = nameDisplayOptions,
        getFunc = function() return nameDisplayOptions[LUIE.UnitFrames.SV.DisplayOptions] end,
        setFunc = function(value) LUIE.UnitFrames.SV.DisplayOptions = nameDisplayOptionsKeys[value] end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = nameDisplayOptions[2]
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = "Default Caption Colour",
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour[1], g=LUIE.UnitFrames.D.Target_FontColour[2], b=LUIE.UnitFrames.D.Target_FontColour[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = "Friendly NPC Font Colour",
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_FriendlyNPC) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_FriendlyNPC={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[1], g=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[2], b=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = "Friendly Player Font Colour",
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_FriendlyPlayer) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_FriendlyPlayer={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[1], g=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[2], b=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = "Hostile Font Colour",
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_Hostile) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_Hostile={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour_Hostile[1], g=LUIE.UnitFrames.D.Target_FontColour_Hostile[2], b=LUIE.UnitFrames.D.Target_FontColour_Hostile[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = "Apply same settings to reticle",
        tooltip = "Change the colour of reticle (cross-hair) according to unit reaction.",
        getFunc = function() return LUIE.UnitFrames.SV.ReticleColourByReaction end,
        setFunc = LUIE.UnitFrames.ReticleColourByReaction,
        width = "full",
        default = LUIE.UnitFrames.D.ReticleColourByReaction,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = "Interactible Reticle Colour",
        getFunc = function() return unpack(LUIE.UnitFrames.SV.ReticleColour_Interact) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.ReticleColour_Interact={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.ReticleColour_Interact[1], g=LUIE.UnitFrames.D.ReticleColour_Interact[2], b=LUIE.UnitFrames.D.ReticleColour_Interact[3] },
        disabled = function() return not (LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.ReticleColourByReaction) end,
    }
    --[[
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = "Font Style",
        choices = styleOptions,
        sort = "name-up",
        getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontStyle end,
        setFunc = function(var) LUIE.SpellCastBuffs.SV.BuffFontStyle = var LUIE.SpellCastBuffs.ApplyFont() end,
        width = "full",
        default = LUIE.SpellCastBuffs.D.BuffFontStyle,
        disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.RemainingText ) end,
    }
    ]]--

    LAM2:RegisterAddonPanel('LUIEAddonOptions', panelData)
    LAM2:RegisterOptionControls('LUIEAddonOptions', optionsData)

    LAM2:RegisterAddonPanel('LUIEUnitFramesOptions', panelDataUnitFrames)
    LAM2:RegisterOptionControls('LUIEUnitFramesOptions', optionsDataUnitFrames)
end
