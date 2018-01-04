local strformat	= zo_strformat

-- Create Settings Menu
function LUIE_CreateSettings()
    -- Load LibAddonMenu
    local LAM2  = LibStub("LibAddonMenu-2.0")
    local LMP   = LibStub("LibMediaProvider-1.0")

    local l_BuffsMovingEnabled  = false -- Helper local flag
    local FontsList             = {}
    local StatusbarTexturesList = {}

    -- Get Fonts
    for f in pairs(LUIE.Fonts) do
        table.insert(FontsList, f)
    end
    for key, _ in pairs(LUIE.StatusbarTextures) do
        table.insert(StatusbarTexturesList, key)
    end

    local nameDisplayOptions            = { "@UserID", "Character Name", "Character Name @UserID" }
    local nameDisplayOptionsKeys        = { ["@UserID"] = 1, ["Character Name"] = 2, ["Character Name @UserID"] = 3 }
    local chatNameDisplayOptions        = { "@UserID", "Character Name", "Character Name @UserID" }
    local chatNameDisplayOptionsKeys    = { ["@UserID"] = 1, ["Character Name"] = 2, ["Character Name @UserID"] = 3 }
    local linkBracketDisplayOptions     = { "No Brackets", "Display Brackets" }
    local linkBracketDisplayOptionsKeys = { ["No Brackets"] = 1, ["Display Brackets"] = 2}
    local bracketOptions4               = { "[]", "()", "-", "No Brackets" }
    local bracketOptions4Keys           = { ["[]"] = 1, ["()"] = 2, ["-"] = 3, ["No Brackets"] = 4 }
    local bracketOptions5               = { "[]", "()", "-", ":", "No Brackets" }
    local bracketOptions5Keys           = { ["[]"] = 1, ["()"] = 2, ["-"] = 3, [":"] = 4, ["No Brackets"] = 5 }
    local guildRankDisplayOptions       = { "Self Only", "Self + All w/ Permissions", "Display All Rank Changes" }
    local guildRankDisplayOptionsKeys   = { ["Self Only"] = 1, ["Self + All w/ Permissions"] = 2, ["Display All Rank Changes"] = 3 }
    local rotationOptions               = { "Horizontal", "Vertical" }
    local rotationOptionsKeys           = { ["Horizontal"] = 1, ["Vertical"] = 2 }
    local duelStartOptions              = { "Message + Icon", "Message Only", "Icon Only" }
    local duelStartOptionsKeys          = { ["Message + Icon"] = 1, ["Message Only"] = 2, ["Icon Only"] = 3 }
    local raidIconOptions               = { "No Icons", "Class Icons Only", "Role Icons Only", "Class Icon in PVP, Role in PVE", "Class Icon in PVE, Role in PVP" }
    local raidIconOptionsKeys           = { ["No Icons"] = 1 , ["Class Icons Only"] = 2, ["Role Icons Only"] = 3, ["Class Icon in PVP, Role in PVE"] = 4, ["Class Icon in PVE, Role in PVP"] = 5 }
    local globalMethodOptions           = { "Ascending", "Descending", "Radial" }
	local globalMethodOptionsKeys = { ["Ascending"] = 1, ["Descending"] = 2, ["Radial"] = 3 }
	local playerFrameOptions = { "Vertical Stacked Frames", "Separated Horizontal Frames", "Pyramid" }
	local playerFrameOptionsKeys = { ["Vertical Stacked Frames"] = 1, ["Separated Horizontal Frames"] = 2, ["Pyramid"] = 3 }
    
    local championOptions = { "Show Above Cap", "Limit to Cap", }
    
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
    
    local panelDataBuffsDebuffs = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_BUFFSDEBUFFS)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_BUFFSDEBUFFS), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = "http://www.esoui.com/downloads/info818-LuiExtended.html",
        slashCommand = "/luiscb",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local panelDataChatAnnouncements = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CA)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_CA), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = "http://www.esoui.com/downloads/info818-LuiExtended.html",
        slashCommand = "/luica",
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
        slashCommand = "/luiuf",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    
    local panelDataCombatInfo = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CI)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_CI), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = "http://www.esoui.com/downloads/info818-LuiExtended.html",
        slashCommand = "/luici",
        registerForRefresh = true,
        registerForDefaults = true,
    }
    
    local panelDataCombatText = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CT)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_CT), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = "http://www.esoui.com/downloads/info818-LuiExtended.html",
        slashCommand = "/luict",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsData = {}
    local optionsDataBuffsDebuffs = {}
    local optionsDataChatAnnouncements = {}
    local optionsDataUnitFrames = {}
    local optionsDataCombatInfo = {}
    local optionsDataCombatText = {}

    -- ReloadUI Button
    optionsData[#optionsData + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }
    
    -- Enable Unit Frames module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_ENABLE),
        getFunc = function() return LUIE.SV.UnitFrames_Enabled end,
        setFunc = function(value) LUIE.SV.UnitFrames_Enabled = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.UnitFrames_Enabled,
    }
    -- Unit Frames module description
    optionsData[#optionsData + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_UF_DESCRIPTION),
    }
    
    -- Enable CI Module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_SHOWCOMBATINFO),
        getFunc = function() return LUIE.SV.CombatInfo_Enabled end,
        setFunc = function(value) LUIE.SV.CombatInfo_Enabled = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.CombatInfo_Enabled,
    }
    -- CI Description
    optionsData[#optionsData + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CI_DESCRIPTION),
    }
    
    -- Enable CT Module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CT_SHOWCOMBATTEXT),
        getFunc = function() return LUIE.SV.CombatText_Enabled end,
        setFunc = function(value) LUIE.SV.CombatText_Enabled = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.CombatText_Enabled,
    }
    -- CT Description
    optionsData[#optionsData + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CT_DESCRIPTION),
    }
    
    -- Enable Buffs & Debuffs Module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_BUFF_ENABLEEFFECTSTRACK),
        getFunc = function() return LUIE.SV.SpellCastBuff_Enable end,
        setFunc = function(value) LUIE.SV.SpellCastBuff_Enable = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.SpellCastBuff_Enable,
    }
    -- Buffs & Debuffs Description
    optionsData[#optionsData + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_BUFFS_DESCRIPTION),
    }
    
    -- Enable Chat Announcements module
    optionsData[#optionsData +1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CA_ENABLE),
        getFunc = function() return LUIE.SV.ChatAnnouncements_Enable end,
        setFunc = function(value) LUIE.SV.ChatAnnouncements_Enable = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.ChatAnnouncements_Enable,
    }
    -- CA Module Description
    optionsData[#optionsData +1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CA_DESCRIPTION),
    }

    -- Info Panel Options
    optionsData[#optionsData + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_PNL_HEADER),
        reference = "Info_Panel_Options_Submenu",
        controls = {
                
            
            {
                -- InfoPanel Header
                type = "description",
                text = GetString(SI_LUIE_LAM_PNL_DESCRIPTION),
            },
            {
                -- Show InfoPanel
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWPANEL),
                tooltip = GetString(SI_LUIE_LAM_PNL_SHOWPANEL_TP),
                getFunc = function() return LUIE.SV.InfoPanel_Enabled end,
                setFunc = function(value) LUIE.SV.InfoPanel_Enabled = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = LUIE.D.InfoPanel_Enabled,
            },
            {
                -- Unlock InfoPanel
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_UNLOCKPANEL),
                tooltip = GetString(SI_LUIE_LAM_PNL_UNLOCKPANEL_TP),
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
                tooltip = GetString(SI_LUIE_LAM_PNL_RESETPOSITION_TP),
                func = LUIE.InfoPanel.ResetPosition,
                width = "half",
            },
            {
                -- InfoPanel scale
                type = "slider",
                name = GetString(SI_LUIE_LAM_PNL_PANELSCALE),
                tooltip = GetString(SI_LUIE_LAM_PNL_PANELSCALE_TP),
                min = 100, max = 300, step = 10,
                getFunc = function() return LUIE.InfoPanel.SV.panelScale end,
                setFunc = function(value) LUIE.InfoPanel.SV.panelScale = value LUIE.InfoPanel.SetScale() end,
                width = "full",
                default = 100,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_PNL_ELEMENTS_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWLATENCY),
                getFunc = function() return not LUIE.InfoPanel.SV.HideLatency end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideLatency = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWCLOCK),
                getFunc = function() return not LUIE.InfoPanel.SV.HideClock end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideClock = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWFPS),
                getFunc = function() return not LUIE.InfoPanel.SV.HideFPS end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideFPS = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWMOUNTTIMER),
                tooltip = GetString(SI_LUIE_LAM_PNL_SHOWMOUNTTIMER_TP),
                getFunc = function() return not LUIE.InfoPanel.SV.HideMountFeed end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideMountFeed = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWARMORDURABILITY),
                getFunc = function() return not LUIE.InfoPanel.SV.HideArmour end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideArmour = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWEAPONCHARGES),
                getFunc = function() return not LUIE.InfoPanel.SV.HideWeapons end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideWeapons = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWBAGSPACE),
                getFunc = function() return not LUIE.InfoPanel.SV.HideBags end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideBags = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWSOULGEMS),
                getFunc = function() return not LUIE.InfoPanel.SV.HideGems end,
                setFunc = function(value) LUIE.InfoPanel.SV.HideGems = not value LUIE.InfoPanel.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWICTROPHYCOUNT),
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
                name = GetString(SI_LUIE_LAM_PNL_DISABLECOLORSRO),
                tooltip = GetString(SI_LUIE_LAM_PNL_DISABLECOLORSRO_TP),
                getFunc = function() return LUIE.InfoPanel.SV.DisableInfoColours end,
                setFunc = function(value) LUIE.InfoPanel.SV.DisableInfoColours = value end,
                width = "full",
                default = false,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
        },
    }

    -- Use LUI print to chat for messages
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_LUIPRINTTOCHAT),
        tooltip = GetString(SI_LUIE_LAM_LUIPRINTTOCHAT_TP),
        getFunc = function() return LUIE.SV.ChatUseSystem end,
        setFunc = function(value) LUIE.SV.ChatUseSystem = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_GENERIC_WARNING),
        default = LUIE.D.ChatUseSystem,
    }
    -- Include Timestamp
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_TIMESTAMP)),
        tooltip = GetString(SI_LUIE_LAM_TIMESTAMP_TP),
        getFunc = function() return LUIE.SV.TimeStamp end,
        setFunc = function(value) LUIE.SV.TimeStamp = value end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatUseSystem end,
        default = LUIE.D.TimeStamp,
    }
    -- Timestamp Format
    optionsData[#optionsData + 1] = {
        type = "editbox",
        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_TIMESTAMPFORMAT)),
        tooltip = GetString(SI_LUIE_LAM_TIMESTAMPFORMAT_TP),
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
        tooltip = GetString(SI_LUIE_LAM_STARTUPMSG_TP),
        getFunc = function() return LUIE.SV.StartupInfo end,
        setFunc = function(value) LUIE.SV.StartupInfo = value end,
        width = "full",
        default = LUIE.D.StartupInfo,
    }
    -- Toggle XP Bar popup
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_HIDE_EXPERIENCE_BAR),
        tooltip = GetString(SI_LUIE_LAM_HIDE_EXPERIENCE_BAR_TP),
        getFunc = function() return LUIE.SV.HideXPBar end,
        setFunc = function(value) LUIE.SV.HideXPBar = value end,
        width = "full",
        default = LUIE.D.HideXPBar,
    }
    -- Slash Commands Overview
    optionsData[#optionsData + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_SLASHCMDSHEADER),
        width = "full",
    }
	
	optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = "/Home Results - Show Alert (Temp Setting)",
        tooltip = "Display an alert when the /home command is used.\nNote: This setting will be deprecated in the future when Social Errors Events are implemented in Chat Announcements.",
        getFunc = function() return LUIE.SV.TempAlertHome end,
        setFunc = function(value) LUIE.SV.TempAlertHome = value end,
        width = "full",
        default = LUIE.D.TempAlertHome,
    }
	optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = "/Campaign Results - Show Alert (Temp Setting)",
        tooltip = "Display an alert when the /campaign command is used.\NNote: This setting will be deprecated in the future when Campaign Queue Events are implemented in Chat Announcements.",
        getFunc = function() return LUIE.SV.TempAlertCampaign end,
        setFunc = function(value) LUIE.SV.TempAlertCampaign = value end,
        width = "full",
        default = LUIE.D.TempAlertCampaign,
    }
	
    -- Slash Commands description
    optionsData[#optionsData + 1] = {
        type = "description",
        text = strformat("<<1>>\n<<2>>\n<<3>>\n<<4>>",
               GetString(SI_LUIE_LAM_SLASHCMDSHEADER_GENERAL),
               GetString(SI_LUIE_LAM_SLASHCMDS_TRADE),
               GetString(SI_LUIE_LAM_SLASHCMDS_HOME),
               GetString(SI_LUIE_LAM_SLASHCMDS_CAMPAIGN)),
    }
    optionsData[#optionsData + 1] = {
        type = "description",
        text = strformat("<<1>>\n<<2>>\n<<3>>\n<<4>>\n<<5>>\n<<6>>",
               GetString(SI_LUIE_LAM_SLASHCMDSHEADER_GROUP),
               GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP),
               GetString(SI_LUIE_LAM_SLASHCMDS_LEAVE),
               GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND),
               GetString(SI_LUIE_LAM_SLASHCMDS_KICK),
               GetString(SI_LUIE_LAM_SLASHCMDS_VOTEKICK)),
    }
    optionsData[#optionsData + 1] = {
        type = "description",
        text = strformat("<<1>>\n<<2>>\n<<3>>\n<<4>>",
               GetString(SI_LUIE_LAM_SLASHCMDSHEADER_GUILD),
               GetString(SI_LUIE_LAM_SLASHCMDS_GUILDINVITE),
               GetString(SI_LUIE_LAM_SLASHCMDS_GUILDKICK),
               GetString(SI_LUIE_LAM_SLASHCMDS_GUILDQUIT)),
    }
    optionsData[#optionsData + 1] = {
        type = "description",
        text = strformat("<<1>>\n<<2>>\n<<3>>\n<<4>>\n<<5>>",
               GetString(SI_LUIE_LAM_SLASHCMDSHEADER_SOCIAL),
               GetString(SI_LUIE_LAM_SLASHCMDS_FRIEND),
               GetString(SI_LUIE_LAM_SLASHCMDS_IGNORE),
               GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND),
               GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE)),
    }
    
    
    -- Enable CI Module
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_SHOWCOMBATINFO),
        tooltip = GetString(SI_LUIE_LAM_CI_SHOWCOMBATINFO_TP),
        getFunc = function() return LUIE.SV.CombatInfo_Enabled end,
        setFunc = function(value) LUIE.SV.CombatInfo_Enabled = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.CombatInfo_Enabled,
    }
    -- CI Description
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
    -- Combat Info Options
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_CI_HEADER_GCD),
        width = "full",
    }
    -- Show GCD on Action Bars
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_GCD_SHOW),
        tooltip = GetString(SI_LUIE_LAM_CI_GCD_SHOW_TP),
        getFunc = function() return LUIE.CombatInfo.SV.GlobalShow end,
        setFunc = function(value) LUIE.CombatInfo.SV.GlobalShow = value end,
        width = "full",
        default = LUIE.CombatInfo.D.GlobalShow,
        disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
    }
    -- Show GCD on Quickslot
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_QUICK)),
        tooltip = GetString(SI_LUIE_LAM_CI_GCD_QUICK_TP),
        getFunc = function() return LUIE.CombatInfo.SV.GlobalPotion end,
        setFunc = function(value) LUIE.CombatInfo.SV.GlobalPotion = value end,
        width = "full",
        default = LUIE.CombatInfo.D.GlobalPotion,
        disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShow) end,
    }
    -- Show GCD Ready Flash
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_FLASH)),
        tooltip = GetString(SI_LUIE_LAM_CI_GCD_FLASH_TP),
        getFunc = function() return LUIE.CombatInfo.SV.GlobalFlash end,
        setFunc = function(value) LUIE.CombatInfo.SV.GlobalFlash = value end,
        width = "full",
        default = LUIE.CombatInfo.D.GlobalFlash,
        disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShow) end,
    }
    -- GCD - Desaturate Icons on GCD
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_DESAT)),
        tooltip = GetString(SI_LUIE_LAM_CI_GCD_DESAT_TP),
        getFunc = function() return LUIE.CombatInfo.SV.GlobalDesat end,
        setFunc = function(value) LUIE.CombatInfo.SV.GlobalDesat = value end,
        width = "full",
        default = LUIE.CombatInfo.D.GlobalDesat,
        disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShow) end,
    }
    -- GCD - Color Slot Label Red
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_COLOR)),
        tooltip = GetString(SI_LUIE_LAM_CI_GCD_COLOR_TP),
        getFunc = function() return LUIE.CombatInfo.SV.GlobalLabelColor end,
        setFunc = function(value) LUIE.CombatInfo.SV.GlobalLabelColor = value end,
        width = "full",
        default = LUIE.CombatInfo.D.GlobalLabelColor,
        disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShow) end,
    }
    -- GCD - Animation Method
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "dropdown",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_ANIMATION)),
        tooltip = GetString(SI_LUIE_LAM_CI_GCD_ANIMATION_TP),
        choices = globalMethodOptions,
        getFunc = function() return globalMethodOptions[LUIE.CombatInfo.SV.GlobalMethod] end,
        setFunc = function(value) LUIE.CombatInfo.SV.GlobalMethod = globalMethodOptionsKeys[value] end,
        width = "full",
        default = LUIE.CombatInfo.D.GlobalMethod,
        disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShow) end,
    }

    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_CI_HEADER_ULTIMATE),
        width = "full",
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW),
        tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW_TP),
        getFunc = function() return LUIE.CombatInfo.SV.UltimateEnabled end,
        setFunc = function(value) LUIE.CombatInfo.SV.UltimateEnabled = value LUIE.CombatInfo.RegisterCombatInfo() LUIE.CombatInfo.OnSlotsFullUpdate(nil) end,
        width = "full",
        default = LUIE.CombatInfo.D.UltimateEnabled,
        disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL)),
        tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL_TP),
        getFunc = function() return LUIE.CombatInfo.SV.UltimateHideFull end,
        setFunc = function(value) LUIE.CombatInfo.SV.UltimateHideFull = value LUIE.CombatInfo.OnSlotsFullUpdate(nil) end,
        width = "full",
        default = LUIE.CombatInfo.D.UltimateHideFull,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.UltimateEnabled ) end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_ULTIMATE_TEXTURE),
        tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_TEXTURE_TP),
        getFunc = function() return LUIE.CombatInfo.SV.UltimateGeneration end,
        setFunc = function(value) LUIE.CombatInfo.SV.UltimateGeneration = value end,
        width = "full",
        default = LUIE.CombatInfo.D.UltimateGeneration,
        disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_CI_HEADER_BAR),
        width = "full",
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        -- Highlight Ability Bar Icon for Active Procs
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_BAR_PROC),
        tooltip = GetString(SI_LUIE_LAM_CI_BAR_PROC_TP),
        getFunc = function() return LUIE.CombatInfo.SV.ShowTriggered end,
        setFunc = function(value) LUIE.CombatInfo.SV.ShowTriggered = value LUIE.CombatInfo.OnSlotsFullUpdate() end,
        width = "full",
        default = LUIE.CombatInfo.D.ShowTriggered,
        disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        -- Highlight Ability Bar Icon for Active Effects
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_BAR_EFFECT),
        tooltip = GetString(SI_LUIE_LAM_CI_BAR_EFFECT_TP),
        getFunc = function() return LUIE.CombatInfo.SV.ShowToggled end,
        setFunc = function(value) LUIE.CombatInfo.SV.ShowToggled = value LUIE.CombatInfo.OnSlotsFullUpdate() end,
        width = "full",
        default = LUIE.CombatInfo.D.ShowToggled,
        disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        -- SHOW LABEL ON BAR HIGHLIGHT
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_LABEL)),
        tooltip = GetString(SI_LUIE_LAM_CI_BAR_LABEL_TP),
        getFunc = function() return LUIE.CombatInfo.SV.BarShowLabel end,
        setFunc = function(value) LUIE.CombatInfo.SV.BarShowLabel = value LUIE.CombatInfo.ResetBarLabel() end,
        width = "full",
        default = LUIE.CombatInfo.D.BarShowLabel,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled) ) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "slider",
        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
        min = -72, max = 40, step = 2,
        getFunc = function() return LUIE.CombatInfo.SV.BarLabelPosition end,
        setFunc = function(value) LUIE.CombatInfo.SV.BarLabelPosition = value LUIE.CombatInfo.ResetBarLabel() end,
        width = "full",
        default = LUIE.CombatInfo.D.BarLabelPosition,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "dropdown",
        scrollable = true,
        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONT_TP),
        choices = FontsList,
        sort = "name-up",
        getFunc = function() return LUIE.CombatInfo.SV.BarFontFace end,
        setFunc = function(var) LUIE.CombatInfo.SV.BarFontFace = var LUIE.CombatInfo.ApplyFont() end,
        width = "full",
        default = LUIE.CombatInfo.D.BarFontFace,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "slider",
        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
        min = 10, max = 30, step = 1,
        getFunc = function() return LUIE.CombatInfo.SV.BarFontSize end,
        setFunc = function(value) LUIE.CombatInfo.SV.BarFontSize = value LUIE.CombatInfo.ApplyFont() end,
        width = "full",
        default = LUIE.CombatInfo.D.BarFontSize,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "dropdown",
        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSTYLE_TP),
        choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
        sort = "name-up",
        getFunc = function() return LUIE.CombatInfo.SV.BarFontStyle end,
        setFunc = function(var) LUIE.CombatInfo.SV.BarFontStyle = var LUIE.CombatInfo.ApplyFont() end,
        width = "full",
        default = LUIE.CombatInfo.D.BarFontStyle,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
        tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
        getFunc = function() return LUIE.CombatInfo.SV.BarMiilis end,
        setFunc = function(value) LUIE.CombatInfo.SV.BarMiilis = value end,
        width = "full",
        default = LUIE.CombatInfo.D.BarMiilis,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_CI_HEADER_POTION),
        width = "full",
    }
    -- Show Cooldowns (Potion Only when I get finished) -- TODO
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_POTION),
        tooltip = GetString(SI_LUIE_LAM_CI_POTION_TP),
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerShow end,
        setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerShow = value end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerShow,
        disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "slider",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
        min = -72, max = 40, step = 2,
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerLabelPosition end,
        setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerLabelPosition = value LUIE.CombatInfo.ResetPotionTimerLabel() end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerLabelPosition,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "dropdown",
        scrollable = true,
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONT_TP),
        choices = FontsList,
        sort = "name-up",
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerFontFace end,
        setFunc = function(var) LUIE.CombatInfo.SV.PotionTimerFontFace = var LUIE.CombatInfo.ApplyFont() end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerFontFace,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "slider",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
        min = 10, max = 30, step = 1,
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerFontSize end,
        setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerFontSize = value LUIE.CombatInfo.ApplyFont() end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerFontSize,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
    }
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "dropdown",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
        tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSTYLE_TP),
        choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
        sort = "name-up",
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerFontStyle end,
        setFunc = function(var) LUIE.CombatInfo.SV.PotionTimerFontStyle = var LUIE.CombatInfo.ApplyFont() end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerFontStyle,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
        tooltip = GetString(SI_LUIE_LAM_CI_POTION_COLOR_TP),
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerColor end,
        setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerColor = value end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerColor,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
        tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerMillis end,
        setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerMillis = value end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerMillis,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
    }

    -- Enable Buffs & Debuffs Module
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_BUFF_ENABLEEFFECTSTRACK),
        tooltip = GetString(SI_LUIE_LAM_BUFF_ENABLEEFFECTSTRACK_TP),
        getFunc = function() return LUIE.SV.SpellCastBuff_Enable end,
        setFunc = function(value) LUIE.SV.SpellCastBuff_Enable = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.SpellCastBuff_Enable,
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
            -- SCB Header
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "header",
                name = GetString(SI_LUIE_LAM_BUFF_HEADER_POSITION),
                width = "full",
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_HARDLOCK),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.lockPositionToUnitFrames end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.lockPositionToUnitFrames = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_WARNING),
                default = LUIE.SpellCastBuffs.D.lockPositionToUnitFrames,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_UNLOCKWINDOW),
                tooltip = GetString(SI_LUIE_LAM_BUFF_UNLOCKWINDOW_TP),
                getFunc = function() return l_BuffsMovingEnabled end,
                setFunc = function(value)
                    l_BuffsMovingEnabled = value
                    LUIE.SpellCastBuffs.SetMovingState(value)
                    end,
                width = "half",
                default = false,
                resetFunc = LUIE.SpellCastBuffs.ResetTlwPosition,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "button",
                name = GetString(SI_LUIE_LAM_RESETPOSITION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_RESETPOSITION_TP),
                func = LUIE.SpellCastBuffs.ResetTlwPosition,
                width = "half",
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HidePlayerBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HidePlayerBuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HidePlayerBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HidePlayerDebuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HidePlayerDebuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HidePlayerDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetBuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetDebuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetDebuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideGroundEffects end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideGroundEffects = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.SV.HideGroundEffects,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "header",
                name = GetString(SI_LUIE_LAM_BUFF_ICON_HEADER),
                width = "full",
            }
            -- Buff Icon Size
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "slider",
                name = GetString(SI_LUIE_LAM_BUFF_ICONSIZE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ICONSIZE_TP),
                min = 30, max = 60, step = 2,
                getFunc = function() return LUIE.SpellCastBuffs.SV.IconSize end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IconSize = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.IconSize,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            -- Buff Show Remaining Time Label
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingText end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingText = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingText,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            -- Buff Label Position
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABEL_POSITION_TP),
                min = -64, max = 64, step = 2,
                getFunc = function() return LUIE.SpellCastBuffs.SV.LabelPosition end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LabelPosition = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LabelPosition,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            }
            -- Buff Label Font
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontFace end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.BuffFontFace = var LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.BuffFontFace,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            }
            -- Buff Font Size
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontSize end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.BuffFontSize = value LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.BuffFontSize,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            }
            -- Buff Font Style
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontStyle end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.BuffFontStyle = var LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.BuffFontStyle,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            }
            -- Buff Colored Label
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABELCOLOR_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingTextColoured end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingTextColoured = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingTextColoured,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            }
            -- Buff Show Seconds Fractions
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingTextMillis end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingTextMillis = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingTextMillis,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            }            
            -- Buff Alignment
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return LUIE.SpellCastBuffs.SV.Alignment end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignment,
                width = "full",
                default = LUIE.SpellCastBuffs.D.Alignment,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            -- Buff Sort Direction
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT_TP),
                choices = {"Left to Right", "Right to Left"},
                getFunc = function() return LUIE.SpellCastBuffs.SV.SortDirection end,
                setFunc = LUIE.SpellCastBuffs.SetSortDirection,
                width = "full",
                default = LUIE.SpellCastBuffs.D.SortDirection,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            -- Buff Glow Icon Border
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.GlowIcons end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.GlowIcons = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.GlowIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            -- Buff Show Border Cooldown
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingCooldown end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingCooldown = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingCooldown,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            -- Buff Fade Expiring Icon
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.FadeOutIcons end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.FadeOutIcons = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.FadeOutIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "header",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HEADER),
                width = "full",
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SELF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SELF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffects_Player end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffects_Player = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffects_Player,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffects_Target end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffects_Target = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffects_Target,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Seperate control for player effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffectsSeparate,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player ) end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Container orientation
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER_TP),
                choices = rotationOptions,
                getFunc = function() return rotationOptions[LUIE.SpellCastBuffs.SV.LongTermEffectsSeparateAlignment] end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffectsSeparateAlignment = rotationOptionsKeys[value] LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = rotationOptions[2],
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player and LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate ) end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Vertical Long Term Icons Alignment
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERT)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERT_TP),
                choices = { "Top", "Middle", "Bottom" },
                getFunc = function() return LUIE.SpellCastBuffs.SV.AlignmentLongVert end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignmentLongVert,
                width = "full",
                default = LUIE.SpellCastBuffs.D.AlignmentLongVert,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player and LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate and LUIE.SpellCastBuffs.SV.LongTermEffectsSeparateAlignment == 2 ) end,
            }
            
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Horizontal Long Term Icons Alignment
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_HORIZ)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_HORIZ_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return LUIE.SpellCastBuffs.SV.AlignmentLongHorz end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignmentLongHorz,
                width = "full",
                default = LUIE.SpellCastBuffs.D.AlignmentLongHorz,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player and LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate and LUIE.SpellCastBuffs.SV.LongTermEffectsSeparateAlignment == 1) end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- LONG TERM REVERSE SORT ORDER
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffectsReverse end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffectsReverse = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffectsReverse,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player ) end,
            }
            -- Long Term Effects Filters
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "header",
                name = GetString(SI_LUIE_LAM_BUFF_FILTER_LONG_HEADER),
                width = "full",
            }
            -- Long Term - Disguises
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreDisguise end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreDisguise = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreDisguise,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Assistants
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreAssistant end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreAssistant = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreAssistant,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Mounts
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMount end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMount = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMount,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
			-- Long Term - Pets
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnorePet end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnorePet = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnorePet,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Mundus - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMundusPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMundusPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMundusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Mundus - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMundusTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMundusTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMundusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Vamp Stage - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreVampPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreVampPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreVampPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Vamp Stage - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreVampTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreVampTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreVampTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Lycanthrophy - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreLycanPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreLycanPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreLycanPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Lycanthrophy - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreLycanTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreLycanTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreLycanTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Bite Disease - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreDiseasePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreDiseasePlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreDiseasePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Bite Disease - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreDiseaseTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreDiseaseTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreDiseaseTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Bite Timers - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBitePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBitePlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBitePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Bite Timers - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBiteTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBiteTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBiteTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Battle Spirit - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") LUIE.SpellCastBuffs.ArtificialEffectUpdate() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBattleSpiritPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Battle Spirit - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBattleSpiritTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Cyrodiil - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreCyrodiilPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreCyrodiilPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreCyrodiilPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Crodiil - Target
             optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreCyrodiilTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreCyrodiilTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreCyrodiilTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - ESO Plus - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreEsoPlusPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreEsoPlusPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreEsoPlusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - ESO Plus - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreEsoPlusTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreEsoPlusTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreEsoPlusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Soul Summons - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSoulSummonsPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Soul Summons - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSoulSummonsTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Set ICD - Player
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSetICDPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSetICDPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSetICDPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Long Term - Set ICD - Target
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSetICDTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSetICDTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSetICDTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            }
            -- Short-Term Effect Filters
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "header",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_HEADER),
                width = "full",
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Sprint Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowSprint end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowSprint = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowSprint,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Gallop Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowGallop end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowGallop = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowGallop,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Rezz Immunity Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowResurrectionImmunity end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowResurrectionImmunity = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowResurrectionImmunity,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Recall Cooldown Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowRecall end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowRecall = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowRecall,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Block Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowBlockPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowBlockPlayer = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowBlockPlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Block Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowBlockTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowBlockTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowBlockTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Stealth Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.StealthStatePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.StealthStatePlayer = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.StealthStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Stealth Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.StealthStateTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.StealthStateTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.StealthStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Disguise Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.DisguiseStatePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.DisguiseStatePlayer = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.DisguiseStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                -- Show Disguise Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.DisguiseStateTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.DisguiseStateTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.DisguiseStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
    
    -- Enable Chat Announcements module
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CA_ENABLE),
        tooltip = GetString(SI_LUIE_LAM_CA_ENABLE_TP),
        getFunc = function() return LUIE.SV.ChatAnnouncements_Enable end,
        setFunc = function(value) LUIE.SV.ChatAnnouncements_Enable = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.ChatAnnouncements_Enable,
    }
    -- CA Module Description
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CA_DESCRIPTION),
    }
    -- ReloadUI Button
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }
    

		-- CA Currency Announcements Options Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_CURRENCY_HEADER),
		reference = "Chat_Announcements_Options_Currency_Announcements_Submenu",
		controls = {
			{
				-- Show Currency Icons
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyIcon = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyIcon,
			},
			{
				-- Show Gold
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange = value LUIE.ChatAnnouncements.RegisterGoldEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyGoldChange,
			},
			{
				-- Show Gold Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDCOLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyGoldColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyGoldColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyGoldColor[3]}
			},
			{
				-- Show Gold Name
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldName end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldName = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyGoldName,
			},
			{
				-- Show Gold Total Amount
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyGoldShowTotal,
			},
			{
				-- Total Currency Message (Gold)
				type = "editbox",
				name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalGold end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalGold = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalGold,
			},
			{
				-- Show Gold Threshold
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldFilter end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldFilter = value end,
				min = 0,
				max = 10000,
				step = 50,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyGoldFilter,
			},
			{
				-- Throttle Gold Looted
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldThrottle end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldThrottle = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyGoldThrottle,
			},
			{
				-- Hide Gold Spent on AH
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT)),
				tooltip = strformat("<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT_TP)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldHideAH end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldHideAH = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyGoldHideAH,
			},
			{
				-- Show Alliance Points
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyAPShowChange,
			},
			{
				-- Show Alliance Points Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPCOLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyAPColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyAPColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyAPColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyAPColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyAPColor[3]}
			},
			{
				-- Show Alliance Points Name
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyAPName end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyAPName = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.TotalCurrencyAPName,
			},
			{
				-- Show Alliance Points Total
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowTotal end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowTotal = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyAPShowTotal,
			},
			{
				-- Total Currency Message (Alliance Points)
				type = "editbox",
				name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalAP end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalAP = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowTotal) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalAP,
			},
			{
				-- Show Alliance Points Threshold
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyAPFilter end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyAPFilter = value end,
				min = 0,
				max = 10000,
				step = 50,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyAPFilter,
			},
			{
				-- Throttle Alliance Points Earned
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyAPThrottle end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyAPThrottle = value end,
				min = 0,
				max = 5000,
				step = 50,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyAPThrottle,
			},
			{
				-- Show Tel Var
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyTVChange,
			},
			{
				-- Show Tel Var Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVCOLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyTVColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyTVColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyTVColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyTVColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyTVColor[3]}
			},
			{
				-- Show Tel Var Name
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTVName end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTVName = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyTVName,
			},
			{
				-- Show Tel Var Total
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTVShowTotal end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTVShowTotal = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyTVShowTotal,
			},
			{
				-- Total Currency Message (Tel Var)
				type = "editbox",
				name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalTV end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalTV = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyTVShowTotal) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalTV,
			},
			{
				-- Show Tel Var Stones Threshold
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTVFilter end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTVFilter = value end,
				min = 0,
				max = 10000,
				step = 50,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyTVFilter,
			},
			{
				-- Throttle Tel Var Stones Looted
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTVThrottle end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTVThrottle = value end,
				min = 0,
				max = 5000,
				step = 50,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyTVThrottle,
			},
			{
				-- Show Writ Vouchers
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyWVChange,
			},
			{
				-- Show Writ Vouchers Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERCOLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyWVColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyWVColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyWVColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyWVColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyWVColor[3]}
			},
			{
				-- Show Writ Vouchers Name
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyWVName end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyWVName = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyWVName,
			},
			{
				-- Show Writ Vouchers Total
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyWVShowTotal end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyWVShowTotal = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyWVShowTotal,
			},
			{
				-- Total Currency Message (Writ Vouchers)
				type = "editbox",
				name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG)),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalWV end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalWV = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyWVShowTotal) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalWV,
			},

			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_CURRENCY_CONTEXT),
			width = "half",
			},
			
			{
				-- Receive Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageReceive end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageReceive = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageReceive,
			},
			{
				-- Loot Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageLoot end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageLoot = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageLoot,
			},
			{
				-- Earned Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageEarn end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageEarn = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageEarn,
			},
			{
				-- Spend Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageSpend end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageSpend = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageSpend,
			},
			{
				-- Lost Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageLost end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageLost = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageLost,
			},
			{
				-- Steal
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageSteal end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageSteal = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageSteal,
			},
			{
				-- Pickpocket Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessagePickpocket end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessagePickpocket = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessagePickpocket,
			},
			{
				-- Bounty Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageBounty end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageBounty = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageBounty,
			},
			{
				-- Confiscate Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageConfiscate end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageConfiscate = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageConfiscate,
			},
			{
				-- Repair Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageRepair end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageRepair = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageRepair,
			},
			{
				-- Trader Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTrader end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTrader = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTrader,
			},
			{
				-- Listing Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageListing end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageListing = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageListing,
			},
			{
				-- Trade Message (In)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTradeIn end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTradeIn = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTradeIn,
			},
			{
				-- Trade Message (Out)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTradeOut end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTradeOut = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTradeOut,
			},
			{
				-- Mail Message (In)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMailIn end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMailIn = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageMailIn,
			},
			{
				-- Mail Message (Out)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMailOut end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMailOut = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageMailOut,
			},
			{
				-- Mail Message (COD Payment)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILCOD),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILCOD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMailCOD end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMailCOD = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageMailCOD,
			},
			{
				-- Mail Message (Postage)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_POSTAGE),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_POSTAGE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessagePostage end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessagePostage = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessagePostage,
			},
			{
				-- Deposit Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageDeposit end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageDeposit = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageDeposit,
			},
			{
				-- Withdraw Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageWithdraw end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageWithdraw = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageWithdraw,
			},
			{
				-- Deposit Guild Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageDepositGuild end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageDepositGuild = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageDepositGuild,
			},
			{
				-- Withdraw Guild Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageWithdrawGuild end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageWithdrawGuild = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageWithdrawGuild,
			},
			{
				-- Stable Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageStable end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageStable = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageStable,
			},
			{
				-- Storage Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageStorage end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageStorage = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageStorage,
			},
			{
				-- Wayshrine Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageWayshrine end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageWayshrine = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageWayshrine,
			},
			{
				-- Unstuck Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageUnstuck end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageUnstuck = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageUnstuck,
			},
			{
				-- Attributes Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageAttributes end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageAttributes = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageAttributes,
			},
			{
				-- Champion Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageChampion end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageChampion = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageChampion,
			},
			{
				-- Morphs Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMorphs end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageMorphs = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageMorphs,
			},
			{
				-- Skills Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageSkills end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageSkills = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageSkills,
			},
			{
				-- Campaign Message
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN),
				tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageCampaign end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageCampaign = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
					(
						LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyTVChange or
						LUIE.ChatAnnouncements.SV.Currency.CurrencyWVChange or
						LUIE.SV.ChatAnnouncements_Enable
					)) end,
				default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageCampaign,
			},
			
		},
	}
		-- CA Loot Announcements Options Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_LOOT_HEADER),
		reference = "Chat_Announcements_Options_Loot_Announcements_Submenu",
		controls = {
			{
				-- Show looted item icons
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootIcons end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootIcons = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootIcons,
			},
			{
				-- Show Armor Type
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowArmorType end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowArmorType = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootShowArmorType,
			},
			{
				-- Show Item Style
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowStyle end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowStyle = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootShowStyle,
			},
			{
				-- Show Item Trait
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowTrait end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowTrait = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootShowTrait,
			},
			{
				-- Show loot total
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootTotal end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootTotal = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootTotal,
			},
			{
				-- Loot total string
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootTotalString end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootTotalString = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.LootTotal and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootTotalString,
			},
			
			{
				-- Show looted items
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.Loot end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.Loot = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.Loot,
			},
			{
				-- Show notable loot
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootOnlyNotable end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootOnlyNotable = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootOnlyNotable,
			},
			{
				-- Show group loot
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootGroup end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootGroup = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootGroup,
			},
			{
				-- Hide annoying items
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootBlacklist end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootBlacklist = value end,
				width = "full",
				warning = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_WARNING),
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootBlacklist,
			},
			
			{
				-- Hide Trash Quality Items
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootNotTrash end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootNotTrash = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootNotTrash,
			},
			
			{
				-- Show Confiscated Items
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LootConfiscateD)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LootConfiscateD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootConfiscate end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootConfiscate = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootConfiscate,
			},
			{
				-- Show Destroyed Items
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowDestroy end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowDestroy = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootShowDestroy,
			},
			{
				-- Show Lockpick Break
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowLockpick end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowLockpick = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootShowLockpick,
			},
			
			{
				-- Show Quest Loot (Add)
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootQuestAdd end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootQuestAdd = value LUIE.ChatAnnouncements.RegisterLootEvents() LUIE.ChatAnnouncements.AddQuestItemsToIndex() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootQuestAdd,
			},
			{
				-- Show Quest Loot (Remove)
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootQuestRemove end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootQuestRemove = value LUIE.ChatAnnouncements.RegisterLootEvents() LUIE.ChatAnnouncements.AddQuestItemsToIndex() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootQuestRemove,
			},
			
			{
				-- Show Vendor Inventory Changes
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootVendor end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootVendor = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootVendor,
			},
			{
				-- Merge Currency & Loot Message
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootVendorCurrency end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootVendorCurrency = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.LootVendor and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootVendorCurrency,
			},
			{
				-- Loot Vendor Total Items
				type = "checkbox",
				name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootVendorTotalItems end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootVendorTotalItems = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.LootVendor and LUIE.ChatAnnouncements.SV.Inventory.LootTotal and LUIE.ChatAnnouncements.SV.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootVendorTotalItems,
			},
			{
				-- Loot Vendor Total Currency
				type = "checkbox",
				name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootVendorTotalCurrency end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootVendorTotalCurrency = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.LootVendor and LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldShowTotal and LUIE.ChatAnnouncements.SV.Currency.CurrencyAPShowTotal and LUIE.ChatAnnouncements.SV.Currency.CurrencyTVShowTotal and LUIE.ChatAnnouncements.SV.Currency.CurrencyWVShowTotal and LUIE.ChatAnnouncements.SV.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootVendorTotalCurrency,
			},
			{
				-- Show Bank Inventory Changes
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootBank end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootBank = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootBank,
			},
			{
				-- Show Craft
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootCraft end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootCraft = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootCraft,
			},
			{
				-- Show Materials consumed when crafting
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowCraftUse end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowCraftUse = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.LootCraft and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootShowCraftUse,
			},
			{
				-- Show Mail Inventory Changes
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMail end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMail = value LUIE.ChatAnnouncements.RegisterMailEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMail,
			},
			{
				-- Show Trade
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootTrade end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootTrade = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootTrade,
			},
			{
				-- Show Disguise Equip
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowDisguise end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowDisguise = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootShowDisguise,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_CURRENCY_CONTEXT),
			width = "half",
			},

			{
				-- Loot Message (Loot)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LOOT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LOOT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageLoot end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageLoot = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageLoot,
			},
			{
				-- Loot Message (Receive)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RECEIVE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RECEIVE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageReceive end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageReceive = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageReceive,
			},
			{
				-- Loot Message (Steal)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_STEAL),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_STEAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageSteal end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageSteal = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageSteal,
			},
			{
				-- Loot Message (Pickpocket)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_PICKPOCKET),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_PICKPOCKET_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessagePickpocket end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessagePickpocket = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessagePickpocket,
			},
			{
				-- Loot Message (Confiscate)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CONFISCATE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CONFISCATE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageConfiscate end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageConfiscate = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageConfiscate,
			},
			
			{
				-- Loot Message (TradeIn)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEIN),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEIN_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageTradeIn end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageTradeIn = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageTradeIn,
			},
			{
				-- Loot Message (TradeOut)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEOUT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEOUT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageTradeOut end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageTradeOut = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageTradeOut,
			},
			{
				-- Loot Message (MailIn)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILIN),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILIN_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageMailIn end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageMailIn = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageMailIn,
			},
			{
				-- Loot Message (MailOut)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILOUT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILOUT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageMailOut end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageMailOut = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageMailOut,
			},
			
			{
				-- Loot Message (Deposit)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSIT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSIT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageDeposit end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageDeposit = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageDeposit,
			},
			{
				-- Loot Message (Withdraw)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAW),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAW_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageWithdraw end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageWithdraw = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageWithdraw,
			},
			
			{
				-- Loot Message (Deposit Guild)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSITGUILD),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSITGUILD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageDepositGuild end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageDepositGuild  = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageDepositGuild ,
			},
			{
				-- Loot Message (Withdraw Guild)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAWGUILD),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAWGUILD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageWithdrawGuild  end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageWithdrawGuild  = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageWithdrawGuild ,
			},
			{
				-- Loot Message (Buy)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_VALUE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_VALUE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuy end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuy = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageBuy,
			},                    
			{
				-- Loot Message (Buy) No Value
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuyNoV end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuyNoV = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageBuyNoV,
			},
			{
				-- Loot Message (Buyback)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_VALUE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_VALUE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuyback end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuyback = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageBuyback,
			},
			{
				-- Loot Message (Buyback) No Value
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuybackNoV end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageBuybackNoV = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageBuybackNoV,
			},
			{
				-- Loot Message (Sell)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_VALUE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_VALUE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageSell end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageSell = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageSell,
			},
			{
				-- Loot Message (Sell) No Value
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageSellNoV end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageSellNoV = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageSellNoV,
			},
			{
				-- Loot Message (Fence)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_FENCE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_FENCE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageFence end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageFence = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageFence,
			},
			{
				-- Loot Message (Launder)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LAUNDER),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LAUNDER_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageLaunder end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageLaunder = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageLaunder,
			},
			{
				-- Loot Message (Use)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_USE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_USE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageUse end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageUse = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageUse,
			},
			{
				-- Loot Message (Craft)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CRAFT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CRAFT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageCraft end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageCraft = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageCraft,
			},
			{
				-- Loot Message (Extract)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_EXTRACT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_EXTRACT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageExtract end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageExtract = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageExtract,
			},
			{
				-- Loot Message (Upgrade)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageUpgrade end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageUpgrade = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageUpgrade,
			},
			{
				-- Loot Message (Upgrade)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_FAIL),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_FAIL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageUpgradeFail end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageUpgradeFail = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageUpgradeFail,
			},                         
			{
				-- Loot Message (Refine)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REFINE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REFINE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageRefine end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageRefine = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageRefine,
			},  
			{
				-- Loot Message (Deconstruct)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DECONSTRUCT),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DECONSTRUCT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageDeconstruct end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageDeconstruct = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageDeconstruct,
			},  
			{
				-- Loot Message (Research)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RESEARCH),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RESEARCH_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageResearch end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageResearch = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageResearch,
			},  
			{
				-- Loot Message (Destroy)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DESTROY),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DESTROY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageDestroy end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageDestroy = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageDestroy,
			},  
			{
				-- Loot Message (Lockpick)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LOCKPICK),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LOCKPICK_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageLockpick end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageLockpick = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageLockpick,
			},
			{
				-- Loot Message Removed (Quest)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REMOVE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REMOVE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageRemove end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageRemove = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageRemove,
			},
			{
				-- Loot Message Group
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_GROUP),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_GROUP_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageGroup end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageGroup = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageGroup,
			},
			{
				-- Loot Message (Disguise Equip)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_EQUIP),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_EQUIP_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageDisguiseEquip end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageDisguiseEquip = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageDisguiseEquip,
			},     
			{
				-- Loot Message (Disguise Remove)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_REMOVE),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_REMOVE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageDisguiseRemove end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageDisguiseRemove = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageDisguiseRemove,
			},     
			{
				-- Loot Message (Disguise Destroy)
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_DESTROY),
				tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_DESTROY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootMessageDisguiseDestroy end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootMessageDisguiseDestroy = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Inventory.LootMessageDisguiseDestroy,
			},     
			
			
		},
	}
		-- CA Experience Announcements Options Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_EXP_HEADER),
		reference = "Chat_Announcements_Options_Experience_Announcements_Submenu",
		controls = {
		
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_ENLIGHTENED),
			width = "full,"
			},
		
			{
				-- Enlightenment (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceEnlightenedCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceEnlightenedCA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceEnlightenedCA,
			},
			{
				-- Enlightenment (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceEnlightenedCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceEnlightenedCSA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceEnlightenedCSA,
			},
			{
				-- Enlightenment (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceEnlightenedAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceEnlightenedAlert = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceEnlightenedAlert,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_LEVELUP),
			width = "full,"
			},
			
			{
				-- Level Up (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceLevelUpCA,
			},
			{
				-- Level Up (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceLevelUpCSA,
			},
			{
				-- Level Up CSA Expanded
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSAExpand end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSAExpand = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSA and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceLevelUpCSAExpand,
			},
			{
				-- Level Up (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpAlert = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceLevelUpAlert,
			},
			{
				-- Show Level Icon on Level Up
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpIcon = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCA or LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSA or LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceExperienceLevelUpIcon,
			},
			{
				-- Experience Level Up Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_LEVELUP_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCA or LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSA or LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.XP.ExperienceLevelUpColor[1], g=LUIE.ChatAnnouncements.D.XP.ExperienceLevelUpColor[2], b=LUIE.ChatAnnouncements.D.XP.ExperienceLevelUpColor[3]}
			},
			{
				-- Color Level by Context
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceLevelColorByLevel end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceLevelColorByLevel = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCA or LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpCSA or LUIE.ChatAnnouncements.SV.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceLevelColorByLevel,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_RESPEC),
			width = "full,"
			},
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_EXPERIENCEGAIN),
			width = "full,"
			},
			
			{
				-- Show Experience Gain
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.Experience end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.Experience = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.XP.Experience,
			},
			{
				-- Show Experience Icon
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceIcon = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceIcon,
			},
			{
				-- Experience Message Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORMESSAGE)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.XP.ExperienceColorMessage) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.XP.ExperienceColorMessage = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.XP.ExperienceColorMessage[1], g=LUIE.ChatAnnouncements.D.XP.ExperienceColorMessage[2], b=LUIE.ChatAnnouncements.D.XP.ExperienceColorMessage[3]}
			},
			{
				-- Experience Name Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORNAME)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.XP.ExperienceColorName) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.XP.ExperienceColorName = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.XP.ExperienceColorName[1], g=LUIE.ChatAnnouncements.D.XP.ExperienceColorName[2], b=LUIE.ChatAnnouncements.D.XP.ExperienceColorName[3]}
			},
			{
				-- Context Name for Experience Gain
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_MESSAGE)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_MESSAGE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceMessage end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceMessage = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceMessage,
			},
			{
				-- Name for Experience Gain
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_NAME)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_NAME_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceName end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceName = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceName,
			},
			{
				-- Hide Experience from Kills
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceHideCombat end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceHideCombat = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceHideCombat,
			},
			{
				-- Combat Experience Gain Filter Threshold
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceFilter end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceFilter = value end,
				min = 0,
				max = 10000,
				step = 100,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceFilter,
			},
			{
				-- Throttle Experience gained in combat
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT)),
				tooltip = GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.XP.ExperienceThrottle end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.XP.ExperienceThrottle = value end,
				min = 0,
				max = 5000,
				step = 50,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.XP.ExperienceThrottle,
			},   
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_SKILL_POINTS),
			width = "full,"
			},
			
			{
				-- Show Skill Points Updated CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillPointCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillPointCA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillPointCA,
			},
			{
				-- Show Skill Points Updated CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillPointCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillPointCSA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillPointCSA,
			},
			{
				-- Show Skill Points Updated Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillPointAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillPointAlert = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillPointAlert,
			},
			{
				-- Skill Point Color 1
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR1)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillPointColor1) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillPointColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not ( LUIE.ChatAnnouncements.SV.Skills.SkillPointCA or LUIE.ChatAnnouncements.SV.Skills.SkillPointCSA or LUIE.ChatAnnouncements.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillPointColor1[1], g=LUIE.ChatAnnouncements.D.Skills.SkillPointColor1[2], b=LUIE.ChatAnnouncements.D.Skills.SkillPointColor1[3]}
			},
			{
				-- Skill Point Color 2
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR2)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillPointColor2) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillPointColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not ( LUIE.ChatAnnouncements.SV.Skills.SkillPointCA or LUIE.ChatAnnouncements.SV.Skills.SkillPointCSA or LUIE.ChatAnnouncements.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillPointColor2[1], g=LUIE.ChatAnnouncements.D.Skills.SkillPointColor2[2], b=LUIE.ChatAnnouncements.D.Skills.SkillPointColor2[3]}
			},
			{
				-- Skyshard Prefix
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX)),
				tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillPointSkyshardMsg end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillPointSkyshardMsg = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not ( LUIE.ChatAnnouncements.SV.Skills.SkillPointCA or LUIE.ChatAnnouncements.SV.Skills.SkillPointCSA or LUIE.ChatAnnouncements.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillPointSkyshardMsg,
			},
			{
				-- Skyshard Brackets
				type = "dropdown",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET)),
				tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET_TP),
				choices = bracketOptions5,
				getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.Skills.SkillPointBracket] end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillPointBracket = bracketOptions5Keys[value] end,
				width = "full",
				disabled = function() return not ( LUIE.ChatAnnouncements.SV.Skills.SkillPointCA or LUIE.ChatAnnouncements.SV.Skills.SkillPointCSA or LUIE.ChatAnnouncements.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillPointBracket
			},
			{
				-- Show Skill Points Updated Partial
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL)),
				tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillPointsPartial end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillPointsPartial = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not ( LUIE.ChatAnnouncements.SV.Skills.SkillPointCA or LUIE.ChatAnnouncements.SV.Skills.SkillPointCSA or LUIE.ChatAnnouncements.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillPointsPartial,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_SKILL_LINES),
			width = "full,"
			},
			
			{
				-- Skill Line Unlocked CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillLineUnlockCA,
			},
			{
				-- Skill Line Unlocked CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillLineUnlockCSA,
			},
			{
				-- Skill Line Unlocked Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillLineUnlockAlert,
			},
			{
				-- Skill Line Icon
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON)),
				tooltip = GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillLineIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillLineIcon = value end,
				width = "full",
				disabled = function() return not (
					LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCA or
					LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCSA or
					LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockAlert and
					LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillLineIcon,
			},
			{
				-- Skill Line Progression CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillLineCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillLineCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillLineCA,
			},
			{
				-- Skill Line Progression CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillLineCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillLineCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillLineCSA,
			},
			{
				-- Skill Line Progression Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillLineAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillLineAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillLineAlert,
			},
			
			{
				-- Skill Ability Progression CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillAbilityCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillAbilityCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillAbilityCA,
			},
			{
				-- Skill Ability Progression CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillAbilityCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillAbilityCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillAbilityCSA,
			},
			{
				-- Skill Ability Progression Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillAbilityAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillAbilityAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillAbilityAlert,
			},
			{
				-- Skill Line Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillLineColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillLineColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (
					LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCA or
					LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockCSA or
					LUIE.ChatAnnouncements.SV.Skills.SkillLineUnlockAlert or
					LUIE.ChatAnnouncements.SV.Skills.SkillLineAlertCA or
					LUIE.ChatAnnouncements.SV.Skills.SkillLineAlertCSA or
					LUIE.ChatAnnouncements.SV.Skills.SkillLineAlertAlert or
					LUIE.ChatAnnouncements.SV.Skills.SkillAbilityCA or
					LUIE.ChatAnnouncements.SV.Skills.SkillAbilityCSA or
					LUIE.ChatAnnouncements.SV.Skills.SkillAbilityAlert and
					LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillLineColor[1], g=LUIE.ChatAnnouncements.D.Skills.SkillLineColor[2], b=LUIE.ChatAnnouncements.D.Skills.SkillLineColor[3]}
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_GUILDREP),
			width = "full,"
			},

			{
				-- Display Guild Icon
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_ICON),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_ICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildIcon = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildIcon,
			},
			
			{
				-- Guild Reputation Message Color
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGECOLOR),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillGuildColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillGuildColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillGuildColor[1], g=LUIE.ChatAnnouncements.D.Skills.SkillGuildColor[2], b=LUIE.ChatAnnouncements.D.Skills.SkillGuildColor[3]}
			},
			
			{
				-- Guild Reputation Message Format
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildMsg end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildMsg = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildMsg,
			},
			
			{
				-- Guild Reputation Points Name
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildRepName end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildRepName = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildRepName,
			},
			
			{
				-- Skill Fighters Guild
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_FG),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_FG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildFighters end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildFighters = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildFighters,
			},
			{
				-- Guild Skill Point Color FG
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_FG_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorFG) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorFG = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildFighters) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorFG[1], g=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorFG[2], b=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorFG[3]}
			},
			{
				-- Fighter's Guild Threshold
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD)),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildThreshold end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildThreshold = value end,
				min = 0,
				max = 5,
				step = 1,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildFighters) end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildThreshold,
			},
			{
				-- Fighter's Guild Throttle
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE)),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildThrottle end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildThrottle = value end,
				min = 0,
				max = 5000,
				step = 50,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildFighters) end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildThrottle,
			},
			{
				-- Skill Mages Guild
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_MG),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildMages end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildMages = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildMages,
			},
			{
				-- Guild Skill Point Color MG
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_MG_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorMG) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorMG = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildMages) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorMG[1], g=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorMG[2], b=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorMG[3]}
			},
			{
				-- Skill Undaunted
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_MG),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildUndaunted end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildUndaunted = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildUndaunted,
			},
			{
				-- Guild Skill Point Color UD
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_UD_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorUD) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorUD = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildUndaunted) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorUD[1], g=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorUD[2], b=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorUD[3]}
			},
			{
				-- Skill Thieves Guild
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_TG),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_TG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildThieves end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildThieves = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildThieves,
			},
			{
				-- Guild Skill Point Color TG
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_TG_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorTG) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorTG = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildThieves) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorTG[1], g=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorTG[2], b=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorTG[3]}
			},
			{
				-- Skill Dark Brotherhood
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_DB),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_DB_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildDarkBrotherhood end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildDarkBrotherhood = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildDarkBrotherhood,
			},
			{
				-- Guild Skill Point Color DB
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_DB_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorDB) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorDB = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildDarkBrotherhood) end,
				default = {r=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorDB[1], g=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorDB[2], b=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorDB[3]}
			},
			
			{
				-- Skill Guild Alert
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT),
				tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Skills.SkillGuildAlert,
			},

		},
	}
		-- CA Collectible Announcements Options Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_HEADER),
		reference = "Chat_Announcements_Options_Collectible_Announcements_Submenu",
		controls = {
		
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COL_HEADER),
			width = "full,"
			},
		
			{
				-- Show Collectibles Unlocked CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Collectibles.CollectibleCA,
			},
			{
				-- Show Collectibles Unlocked CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Collectibles.CollectibleCSA,
			},
			{
				-- Show Collectibles Unlocked Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Collectibles.CollectibleAlert,
			},
			
			{
				-- Collectible Icon
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON)),
				tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Collectibles.CollectibleIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleIcon = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Collectibles.CollectibleIcon,
			},
			
			{
				-- Collectible Color 1
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_ONE)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Collectibles.CollectibleColor1) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Collectibles.CollectibleColor1[1], g=LUIE.ChatAnnouncements.D.Collectibles.CollectibleColor1[2], b=LUIE.ChatAnnouncements.D.Collectibles.CollectibleColor1[3]}
			},
			{
				-- Collectible Color 2
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_TWO)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Collectibles.CollectibleColor2) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Collectibles.CollectibleColor2[1], g=LUIE.ChatAnnouncements.D.Collectibles.CollectibleColor2[2], b=LUIE.ChatAnnouncements.D.Collectibles.CollectibleColor2[3]}
			},
			{
				-- Collectible Message Prefix
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX)),
				tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Collectibles.CollectiblePrefix end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Collectibles.CollectiblePrefix = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Collectibles.CollectiblePrefix,
			},
			{
				-- Collectible Bracket Options
				type = "dropdown",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET)),
				tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET_TP),
				choices = bracketOptions5,
				getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.Collectibles.CollectibleBracket] end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleBracket = bracketOptions5Keys[value] end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Collectibles.CollectibleBracket
			},
			{
				-- Collectible Category
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY)),
				tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCategory end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCategory = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Collectibles.CollectibleCategory,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_LORE_HEADER),
			width = "full,"
			},
			
			{
				-- Show Lorebooks (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookCA,
			},
			{
				-- Show Lorebooks (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookCSA,
			},
			{
				-- Show Lorebooks (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookAlert,
			},
			
			{
				-- Show Lorebook Collection Complete (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookCollectionCA,
			},
			{
				-- Show Lorebook Collection Complete (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookCollectionCSA,
			},
			{
				-- Show Lorebook Collection Complete (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookCollectionAlert,
			},
			
			{
				-- Lorebooks Icon
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookIcon = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookIcon,
			},
			{
				-- Lorebooks Color 1
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR1)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Lorebooks.LorebookColor1) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Lorebooks.LorebookColor1[1], g=LUIE.ChatAnnouncements.D.Lorebooks.LorebookColor1[2], b=LUIE.ChatAnnouncements.D.Lorebooks.LorebookColor1[3]}
			},
			{
				-- Lorebooks Color 2
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR2)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Lorebooks.LorebookColor2) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Lorebooks.LorebookColor2[1], g=LUIE.ChatAnnouncements.D.Lorebooks.LorebookColor2[2], b=LUIE.ChatAnnouncements.D.Lorebooks.LorebookColor2[3]}
			},
			{
				-- Lorebooks Prefix 1
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookPrefix1 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookPrefix1 = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookPrefix1,
			},
			{
				-- Lorebooks Prefix 2
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookPrefix2 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookPrefix2 = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookPrefix2,
			},
			{
				-- Lorebooks Collection Prefix
				type = "editbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionPrefix end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionPrefix = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookCollectionPrefix,
			},
			{
				-- Lorebooks Bracket Options
				type = "dropdown",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET)),
				choices = bracketOptions5,
				tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET_TP),
				getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.Lorebooks.LorebookBracket] end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookBracket = bracketOptions5Keys[value] end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookBracket
			},
			{
				-- Lorebooks Category
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCategory end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCategory = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookCategory,
			},
			{
				-- Show hidden books
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE)),
				tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Lorebooks.LorebookShowHidden end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Lorebooks.LorebookShowHidden = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookAlert or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionCSA or
				LUIE.ChatAnnouncements.SV.Lorebooks.LorebookCollectionAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Lorebooks.LorebookShowHidden,
			},
			
		},
	}
		-- CA Achievements Announcements Options Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_ACHIEVE_HEADER),
		reference = "Chat_Announcements_Options_Achievements_Announcements_Submenu",
		controls = {
			{
				-- SHOW ACHIEVEMENT UPDATE CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementUpdateCA,
			},
			{
				-- SHOW ACHIEVEMENT UPDATE ALERT
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementUpdateAlert,
			},
			{
				-- Show Detailed Achievement Info
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO)),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementDetails end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementDetails = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementDetails,
			},
			{
				-- Achievements Step Size
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE)),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE_TP),
				min = 0, max = 50, step = 1,
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementStep end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementStep = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementStep,
			},
			
			{
				-- Enable Achievement Complete CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCompleteCA,
			},
			{
				-- Enable Achievement Complete CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCompleteCSA,
			},
			{
				-- Enable Achievement Complete Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCompleteAlert,
			},
			{
				-- Show 100% Completion on complete event
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT)),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCompPercentage end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCompPercentage = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCompPercentage,
			},
			{
				-- Show Achievement Icon
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementIcon = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementIcon,
			},
			{
				-- Achievement Message Color
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR1),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Achievement.AchievementColor1) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Achievement.AchievementColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Achievement.AchievementColor1[1], g=LUIE.ChatAnnouncements.D.Achievement.AchievementColor1[2], b=LUIE.ChatAnnouncements.D.Achievement.AchievementColor1[3]}
			},
			{
				-- Achievement Message Color
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR2),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Achievement.AchievementColor2) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Achievement.AchievementColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Achievement.AchievementColor2[1], g=LUIE.ChatAnnouncements.D.Achievement.AchievementColor2[2], b=LUIE.ChatAnnouncements.D.Achievement.AchievementColor2[3]}
			},
			{
				-- Context Name for Achievement Progress
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementProgressMsg end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementProgressMsg = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementProgressMsg,
			},
			{
				-- Context Name for Achievement Completion
				type = "editbox",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteMsg end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteMsg = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCompleteMsg,
			},
			{
				-- Show Achievement Category
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory,
			},
			{
				-- Show Achievement Subcategory
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementSubcategory end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementSubcategory = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementSubcategory,
			},
			
			{
				-- Prefix Bracket
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET_TP),
				choices = bracketOptions5,
				getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.Achievement.AchievementBracketOptions] end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementBracketOptions = bracketOptions5Keys[value] end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementBracketOptions
			},
			{
				-- Category & Subcategory Bracket Options
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET_TP),
				choices = bracketOptions4,
				getFunc = function() return bracketOptions4[LUIE.ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions] end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCatBracketOptions = bracketOptions4Keys[value] end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory or LUIE.ChatAnnouncements.SV.Achievement.AchievementSubcategory) or not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCatBracketOptions
			},
			{
				-- Color Achievement Progress
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS),
				tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementColorProgress end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementColorProgress = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementColorProgress,
			},
		   
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_HEADER),
			width = "half"
			},
			
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(1)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(1)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory1 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory1 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory1,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(2)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(2)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory2 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory2 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory2,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(3)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(3)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory3 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory3 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory3,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(4)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(4)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory4 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory4 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory4,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(5)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(5)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory5 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory5 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory5,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(6)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(6)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory6 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory6 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory6,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(7)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(7)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory7 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory7 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory7,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(8)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(8)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory8 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory8 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory8,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(9)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(9)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory9 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory9 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory9,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(10)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(10)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory10 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory10 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory10,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			{
				-- Enables achievements tracking in %s category
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(11)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(11)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory11 end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory11 = value end,
				width = "full",
				default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory11,
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
			},
			
		},
	}
		-- CA Quest Announcements Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_QUEST_HEADER),
		reference = "Chat_Announcements_Options_Quest_Announcements_Submenu",
		controls = {
		
			{
				-- Show Quest Share CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestShareCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestShareCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestShareCA,                   
			},
			{
				-- Show Quest Share Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestShareAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestShareAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestShareAlert,                   
			},
			{
				-- Show Location Discovery (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocDiscoveryCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocDiscoveryCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocDiscoveryCA,                   
			},
			{
				-- Show Location Discovery (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocDiscoveryCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocDiscoveryCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocDiscoveryCSA,                   
			},
			{
				-- Show Location Discovery (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocDiscoveryAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocDiscoveryAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocDiscoveryAlert,                   
			},
			{
				-- Show Location Objective (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocObjectiveCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocObjectiveCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocObjectiveCA,                   
			},
			{
				-- Show Location Objective (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocObjectiveCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocObjectiveCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocObjectiveCSA,                   
			},
			{
				-- Show Location Objective (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocObjectiveAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocObjectiveAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocObjectiveAlert,                   
			},
			{
				-- Show Location Complete (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocCompleteCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocCompleteCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocCompleteCA,                   
			},
			{
				-- Show Location Complete (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocCompleteCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocCompleteCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocCompleteCSA,                   
			},
			{
				-- Show Location Complete (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocCompleteAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocCompleteAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocCompleteAlert,                   
			},
			{
				-- Show Quest Accept (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestAcceptCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestAcceptCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestAcceptCA,                   
			},
			{
				-- Show Quest Accept (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestAcceptCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestAcceptCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestAcceptCSA,                   
			},
			{
				-- Show Quest Accept (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestAcceptAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestAcceptAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestAcceptAlert,                   
			},
			{
				-- Show Quest Complete (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestCompleteCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestCompleteCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestCompleteCA,                   
			},
			{
				-- Show Quest Complete (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestCompleteCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestCompleteCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestCompleteCSA,                   
			},
			{
				-- Show Quest Complete (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestCompleteAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestCompleteAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestCompleteAlert,                   
			},
			{
				-- Show Quest Abandon (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestAbandonCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestAbandonCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestAbandonCA,                   
			},
			{
				-- Show Quest Abandon (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestAbandonCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestAbandonCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestAbandonCSA,                   
			},
			{
				-- Show Quest Abandon (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestAbandonAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestAbandonAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestAbandonAlert,                   
			},
			{
				-- Show Quest Failure (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestFailCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestFailCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestFailCA,                   
			},
			{
				-- Show Quest Failure (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestFailCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestFailCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestFailCSA,                   
			},
			{
				-- Show Quest Failure (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestFailAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestFailAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestFailAlert,                   
			},
			{
				-- Show Quest Objective Updates (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestObjUpdateCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestObjUpdateCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestObjUpdateCA,                   
			},
			{
				-- Show Quest Objective Updates (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestObjUpdateCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestObjUpdateCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestObjUpdateCSA,                   
			},
			{
				-- Show Quest Objective Updates (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestObjUpdateAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestObjUpdateAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestObjUpdateAlert,                   
			},
			{
				-- Show Quest Objective Complete (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestObjCompleteCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestObjCompleteCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestObjCompleteCA,                   
			},
			{
				-- Show Quest Objective Complete (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestObjCompleteCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestObjCompleteCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestObjCompleteCSA,                   
			},
			{
				-- Show Quest Objective Complete (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestObjCompleteAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestObjCompleteAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestObjCompleteAlert,                   
			},
			{
				-- Show Quest Icon
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON)),
				tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestIcon = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestIcon,
			},
			{
				-- Location Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR1)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Quests.QuestColorLocName) end,
				setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.Quests.QuestColorLocName={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = { r=LUIE.ChatAnnouncements.D.Quests.QuestColorLocName[1], g=LUIE.ChatAnnouncements.D.Quests.QuestColorLocName[2], b=LUIE.ChatAnnouncements.D.Quests.QuestColorLocName[3] },
			},
			{
				-- Location Description Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR2)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Quests.QuestColorLocDescription) end,
				setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.Quests.QuestColorLocDescription={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = { r=LUIE.ChatAnnouncements.D.Quests.QuestColorLocDescription[1], g=LUIE.ChatAnnouncements.D.Quests.QuestColorLocDescription[2], b=LUIE.ChatAnnouncements.D.Quests.QuestColorLocDescription[3] },
			},
			{
				-- Quest Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR3)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Quests.QuestColorName) end,
				setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.Quests.QuestColorName={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = { r=LUIE.ChatAnnouncements.D.Quests.QuestColorName[1], g=LUIE.ChatAnnouncements.D.Quests.QuestColorName[2], b=LUIE.ChatAnnouncements.D.Quests.QuestColorName[3] },
			},
			{
				-- Quest Description Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR4)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Quests.QuestColorDescription) end,
				setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.Quests.QuestColorDescription={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = { r=LUIE.ChatAnnouncements.D.Quests.QuestColorDescription[1], g=LUIE.ChatAnnouncements.D.Quests.QuestColorDescription[2], b=LUIE.ChatAnnouncements.D.Quests.QuestColorDescription[3] },
			},
			{
				-- Show Quest Long String
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG)),
				tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLong end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLong = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLong,                   
			},
			{
				-- Show POI Completed Long String
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG)),
				tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestLocLong end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestLocLong = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestLocLong,                   
			},
			
		},
	}
		
		-- CA Social Announcements Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_SOCIAL_HEADER),
		reference = "Chat_Announcements_Options_Social_Announcements_Submenu",
		controls = {
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_HEADER),
			width = "full"
			},
			
			{
				-- Show Friend/Ignore Events CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.FriendIgnoreCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.FriendIgnoreCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.FriendIgnoreCA,
			},
			{
				-- Show Friend/Ignore Events Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.FriendIgnoreAlert,
			},
			
			{
				-- Friend Online/Offline CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.FriendStatusCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.FriendStatusCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.FriendStatusCA,
			},
			{
				-- Friend Online/Offline Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.FriendStatusAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.FriendStatusAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.FriendStatusAlert,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_HEADER),
			width = "full"
			},
			
			{
				-- Show Guild Events CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.GuildCA,
			},
			{
				-- Show Guild Events Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.GuildAlert,
			},
			{
				-- Show Guild Rank Events CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildRankCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildRankCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.GuildRankCA,
			},
			{
				-- Show Guild Rank Events Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildRankAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildRankAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.GuildRankAlert,
			},
			{
				-- Show Guild Rank Events Display Options
				type = "dropdown",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS)),
				tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS_TP),
				choices = guildRankDisplayOptions,
				getFunc = function() return guildRankDisplayOptions[LUIE.ChatAnnouncements.SV.Social.GuildRankDisplayOptions] end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildRankDisplayOptions = guildRankDisplayOptionsKeys[value] end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Social.GuildRankCA or LUIE.ChatAnnouncements.SV.Social.GuildRankAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Social.GuildRankDisplayOptions,
			},
			{
				-- Show Guild Management CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildManageCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildManageCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.GuildManageCA,
			},
			{
				-- Show Guild Management Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildManageAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildManageAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.GuildManageAlert,
			},
			{
				-- Show Guild Icons
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS)),
				tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildIcon end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildIcon = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Social.GuildCA or
				LUIE.ChatAnnouncements.SV.Social.GuildAlert or
				LUIE.ChatAnnouncements.SV.Social.GuildRankCA or
				LUIE.ChatAnnouncements.SV.Social.GuildRankAlert or
				LUIE.ChatAnnouncements.SV.Social.GuildManageCA or
				LUIE.ChatAnnouncements.SV.Social.GuildManageAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Social.GuildIcon,
			},
			{
				-- Guild Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Social.GuildColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Social.GuildColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Social.GuildCA or
				LUIE.ChatAnnouncements.SV.Social.GuildAlert or
				LUIE.ChatAnnouncements.SV.Social.GuildRankCA or
				LUIE.ChatAnnouncements.SV.Social.GuildRankAlert or
				LUIE.ChatAnnouncements.SV.Social.GuildManageCA or
				LUIE.ChatAnnouncements.SV.Social.GuildManageAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Social.GuildColor[1], g=LUIE.ChatAnnouncements.D.Social.GuildColor[2], b=LUIE.ChatAnnouncements.D.Social.GuildColor[3]}
			},
			{
				-- Use Alliance Color for Guild
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE)),
				tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.GuildAllianceColor end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.GuildAllianceColor = value end,
				width = "full",
				disabled = function() return not (
				LUIE.ChatAnnouncements.SV.Social.GuildCA or
				LUIE.ChatAnnouncements.SV.Social.GuildAlert or
				LUIE.ChatAnnouncements.SV.Social.GuildRankCA or
				LUIE.ChatAnnouncements.SV.Social.GuildRankAlert or
				LUIE.ChatAnnouncements.SV.Social.GuildManageCA or
				LUIE.ChatAnnouncements.SV.Social.GuildManageAlert and
				LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Social.GuildAllianceColor,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_HEADER),
			width = "full"
			},
		
			{
				-- Show Trade Events
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationTradeCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationTradeCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationTradeCA,
			},
			{
				-- Show Trade Events
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationTradeAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationTradeAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationTradeAlert,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_HEADER),
			width = "full"
			},
			
			{
				-- Show Duel Events (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelCA,
			},
			{
				-- Show Duel Events (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelAlert,
			},
			{
				-- Duel Start CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelStartCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelStartCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelStartCA,
			},
			{
				-- Duel Start CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TPCSA), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelStartCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelStartCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelStartCSA,
			},
			{
				-- Duel Start Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelStartAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelStartAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelStartAlert,
			},
			{
				-- Duel Start Options
				type = "dropdown",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION)),
				tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION_TP),
				choices = duelStartOptions,
				getFunc = function() return duelStartOptions[LUIE.ChatAnnouncements.SV.Social.DuelStartOptions] end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelStartOptions = duelStartOptionsKeys[value] end,
				width = "full",
				default = duelStartOptions[1],
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Social.DuelStartCA or LUIE.ChatAnnouncements.SV.Social.DuelStartCSA or LUIE.ChatAnnouncements.SV.Social.DuelStartAlert and LUIE.SV.ChatAnnouncements_Enable) end,
			},
			{
				-- Duel Won CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelWonCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelWonCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelWonCA,
			},
			{
				-- Duel Won CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelWonCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelWonCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelWonCSA,
			},
			{
				-- Duel Won Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelWonAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelWonAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelWonAlert,
			},
			{
				-- Duel Boundary CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelBoundaryCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelBoundaryCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelBoundaryCA,
			},
			{
				-- Duel Boundary CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelBoundaryCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelBoundaryCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelBoundaryCSA,
			},
			{
				-- Duel Boundary Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.DuelBoundaryAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.DuelBoundaryAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.DuelBoundaryAlert,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_SOCIAL_MARA_HEADER),
			width = "full"
			},
			
			{
				-- Show Pledge of Mara CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.PledgeOfMaraCA,
			},
			{
				-- Show Pledge of Mara CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.PledgeOfMaraCSA,
			},
			{
				-- Show Pledge of Mara Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Social.PledgeOfMaraAlert,
			},
			{
				-- Pledge of Mara (Alert Only on Failure)
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT)),
				tooltip = GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraAlertOnlyFail end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraAlertOnlyFail = value end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Social.PledgeOfMaraAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = LUIE.ChatAnnouncements.D.Social.PledgeOfMaraAlertOnlyFail,
			},
			
		},
	}
		-- CA Group Announcements Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_GROUP_HEADER),
		reference = "Chat_Announcements_Options_Group_Announcements_Submenu",
		controls = {
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_GROUP_BASE_HEADER),
			width = "full"
			},
			
			{
				-- Show Group CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupCA,
			},
			{
				-- Show Group Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupAlert,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_GROUP_LFG_HEADER),
			width = "full"
			},
			
			{
				-- Show Group LFG CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupLFGCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupLFGCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupLFGCA,
			},
			{
				-- Show Group LFG Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupLFGAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupLFGAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupLFGAlert,
			},
			
			{
				-- Show Group LFG CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupLFGQueueCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupLFGQueueCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupLFGQueueCA,
			},
			{
				-- Show Group LFG Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupLFGQueueAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupLFGQueueAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupLFGQueueAlert,
			},
			
			{
				-- Show Group Vote CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupVoteCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupVoteCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupVoteCA,
			},
			{
				-- Show Group Vote Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupVoteAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupVoteAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupVoteAlert,
			},
			
			{
				-- Show LFG Activity Completed CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupLFGCompleteCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupLFGCompleteCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupLFGCompleteCA,
			},
			{
				-- Show LFG Activity Completed CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupLFGCompleteCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupLFGCompleteCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupLFGCompleteCSA,
			},
			{
				-- Show LFG Activity Completed Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupLFGCompleteAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupLFGCompleteAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupLFGCompleteAlert,
			},
			
			{
			type = "header",
			name = GetString(SI_LUIE_LAM_CA_GROUP_RAID_HEADER),
			width = "full"
			},
			
			{
				-- Raid Announcements CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidCA,
			},
			{
				-- Raid Announcements CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidCSA,
			},
			{
				-- Raid Announcements Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidAlert,
			},
			
			{
				-- Raid Score CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidScoreCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidScoreCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidScoreCA,
			},
			{
				-- Raid Score CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidScoreCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidScoreCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidScoreCSA,
			},
			{
				-- Raid Score Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidScoreAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidScoreAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidScoreAlert,
			},
			
			{
				-- Raid Best Score CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidBestScoreCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidBestScoreCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidBestScoreCA,
			},
			{
				-- Raid Best Score CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidBestScoreCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidBestScoreCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidBestScoreCSA,
			},
			{
				-- Raid Best Score Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidBestScoreAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidBestScoreAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidBestScoreAlert,
			},
			
			{
				-- Raid Revive Counter CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidReviveCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidReviveCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidReviveCA,
			},
			{
				-- Raid Revive Counter CSA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidReviveCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidReviveCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidReviveCSA,
			},
			{
				-- Raid Revive Counter Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidReviveAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidReviveAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidReviveAlert,
			},
		},
	}
		
		-- CA Display Announcements Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = "DISPLAY ANNOUNCEMENTS",
		reference = "Chat_Announcements_Options_Display_Announcements_Submenu",
		controls = {
		
			-- Display Announcements description
			{
				type = "description",
				text = "Display Announcements are various messages displayed under certain conditions, these range from broad to very specific categories, and thus fall under their own section for Announcements.",
			},
			
			 {
				-- Respec Notification (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationRespecCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationRespecCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationRespecCA,
			},
			{
				-- Respec Notification (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationRespecCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationRespecCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationRespecCSA,
			},
			{
				-- Respec Notification (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationRespecAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationRespecAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationRespecAlert,
			},
		
			{
				-- Display Group Area Message (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationGroupAreaCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationGroupAreaCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationGroupAreaCA,
			},
			{
				-- Display Group Area Message (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationGroupAreaCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationGroupAreaCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationGroupAreaCSA,
			},
			{
				-- Display Group Area Message (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationGroupAreaAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationGroupAreaAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationGroupAreaAlert,
			},
			
			{
				-- Arena Notifications (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidArenaCA,
			},
			{
				-- Arena Notifications (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidArenaCSA,
			},
			{
				-- Arena Notifications (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaAlert  = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidArenaAlert,
			},
			
			{
				-- Arena Round Notifications (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaRoundCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaRoundCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidArenaRoundCA,
			},
			{
				-- Arena Round Notifications (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaRoundCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaRoundCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidArenaRoundCSA,
			},
			{
				-- Arena Round Notifications (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaRoundAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Group.GroupRaidArenaRoundAlert  = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Group.GroupRaidArenaRoundAlert,
			},
			
			{
				-- IC DISPLAY ANNOUNCEMENT (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestICDiscoveryCA,                   
			},
			{
				-- IC DISPLAY ANNOUNCEMENT (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestICDiscoveryCSA,                   
			},
			{
				-- IC DISPLAY ANNOUNCEMENT (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestICDiscoveryAlert,                   
			},
			
			{
				-- IC DISPLAY DESCRIPTION
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION)),
				tooltip = GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION_TP),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestICDescription end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestICDescription = value end,
				width = "full",
				disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and (LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCA or LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCSA or LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryAlert) ) end,
				default = LUIE.ChatAnnouncements.D.Quests.QuestICDiscoveryAlert,                   
			},
			
		},
	}

		-- CA Miscellaneous Announcements Submenu
		optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
		type = "submenu",
		name = GetString(SI_LUIE_LAM_CA_MISC_HEADER),
		reference = "Chat_Announcements_Options_Misc_Announcements_Submenu",
		controls = {
			{
				-- Mail (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationMailCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationMailCA = value LUIE.ChatAnnouncements.RegisterMailEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationMailCA,
			},
			{
				-- Mail (ALERT)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationMailAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationMailAlert = value LUIE.ChatAnnouncements.RegisterMailEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationMailAlert,
			},
			
			{
				-- Show Lockpick Events CA
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationLockpickCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationLockpickCA = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationLockpickCA,
			},
			{
				-- Show Lockpick Events Alert
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationLockpickAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationLockpickAlert = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationLockpickAlert,
			},
			{
				-- Show Justice Confiscate (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationConfiscateCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationConfiscateCA = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationConfiscateCA,
			},
			
			{
				-- Show Justice Confiscate (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.NotificationConfiscateAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.NotificationConfiscateAlert = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.NotificationConfiscateAlert,
			},
			
			
			{
				-- Show Bag/Bank Upgrade (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.StorageBagCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.StorageBagCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.StorageBagCA,
			},
			{
				-- Show Bag/Bank Upgrade (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.StorageBagCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.StorageBagCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.StorageBagCSA,
			},
			{
				-- Show Bag/Bank Upgrade (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.StorageBagAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.StorageBagAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.StorageBagAlert,
			},
			{
				-- Bag/Bank Upgrade Message Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Notify.StorageBagColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Notify.StorageBagColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Notify.StorageBagCA or LUIE.ChatAnnouncements.SV.Notify.StorageBagCSA or LUIE.ChatAnnouncements.SV.Notify.StorageBagAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Notify.StorageBagColor[1], g=LUIE.ChatAnnouncements.D.Notify.StorageBagColor[2], b=LUIE.ChatAnnouncements.D.Notify.StorageBagColor[3]}
			},
			{
				-- Show Mount Upgrade (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.StorageRidingCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.StorageRidingCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.StorageRidingCA,
			},
			{
				-- Show Mount Upgrade (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.StorageRidingCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.StorageRidingCSA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.StorageRidingCSA,
			},
			{
				-- Show Mount Upgrade (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.StorageRidingAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.StorageRidingAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.StorageRidingAlert,
			},
			{
				-- Mount Upgrade Message Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Notify.StorageRidingColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Notify.StorageRidingColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Notify.StorageRidingCA or LUIE.ChatAnnouncements.SV.Notify.StorageRidingCSA or LUIE.ChatAnnouncements.SV.Notify.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Notify.StorageRidingColor[1], g=LUIE.ChatAnnouncements.D.Notify.StorageRidingColor[2], b=LUIE.ChatAnnouncements.D.Notify.StorageRidingColor[3]}
			},
			{
				-- Mount Upgrade Message Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR_BOOK)),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Notify.StorageRidingBookColor) end,
				setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Notify.StorageRidingBookColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Notify.StorageRidingCA or LUIE.ChatAnnouncements.SV.Notify.StorageRidingCSA or LUIE.ChatAnnouncements.SV.Notify.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = {r=LUIE.ChatAnnouncements.D.Notify.StorageRidingBookColor[1], g=LUIE.ChatAnnouncements.D.Notify.StorageRidingBookColor[2], b=LUIE.ChatAnnouncements.D.Notify.StorageRidingBookColor[3]}
			},
			
			
			
			
			{
				-- Show Disguise Events (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.DisguiseCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.DisguiseCA = value LUIE.ChatAnnouncements.RegisterDisguiseEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.DisguiseCA,
			},
			{
				-- Show Disguise Events (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.DisguiseCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.DisguiseCSA = value LUIE.ChatAnnouncements.RegisterDisguiseEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.DisguiseCSA,
			},
			{
				-- Show Disguise Events (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.DisguiseAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.DisguiseAlert = value LUIE.ChatAnnouncements.RegisterDisguiseEvents() end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.DisguiseAlert,
			},
			
			{
				-- Show Disguise Warning (CA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnCA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnCA = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.DisguiseWarnCA,
			},
			{
				-- Show Disguise Warning (CSA)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnCSA end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnCSA = value end,
				width = "full",
			   disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.DisguiseWarnCSA,
			},
			{
				-- Show Disguise Warning (Alert)
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
				tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
				getFunc = function() return LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnAlert end,
				setFunc = function(value) LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnAlert = value end,
				width = "full",
				disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
				default = LUIE.ChatAnnouncements.D.Notify.DisguiseWarnAlert,
			},
			
			{
				-- Disguise Alert Color
				type = "colorpicker",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR)),
				tooltip = GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR_TP),
				getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Notify.DisguiseAlertColor) end,
				setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.Notify.DisguiseAlertColor={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
				width = "full",
				disabled = function() return not (LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnCA or LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnCSA or LUIE.ChatAnnouncements.SV.Notify.DisguiseWarnAlert and LUIE.SV.ChatAnnouncements_Enable) end,
				default = { r=LUIE.ChatAnnouncements.D.Notify.DisguiseAlertColor[1], g=LUIE.ChatAnnouncements.D.Notify.DisguiseAlertColor[2], b=LUIE.ChatAnnouncements.D.Notify.DisguiseAlertColor[3] },
			},
		},
	}
 -- CA Common Options Header
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HEADER),
        width = "full",
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Player Name Display Method
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_NAMEDISPLAYMETHOD),
        tooltip = GetString(SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD_TP),
        choices = chatNameDisplayOptions,
        getFunc = function() return chatNameDisplayOptions[LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions] end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions = chatNameDisplayOptionsKeys[value] LUIE.ChatAnnouncements.IndexGroupLoot() end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = chatNameDisplayOptions[2],
    }
	--[[
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Notification Color
        type = "colorpicker",
        name = "Notification Color (Unimplemented)",
        tooltip = "This message will be used to colorize various generic notification messages that are not Social/Guild related or error messages.",
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Notify.NotificationColor) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Notify.NotificationColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not LUIE.TodoLater end,
        default = {r=LUIE.ChatAnnouncements.D.Notify.NotificationColor[1], g=LUIE.ChatAnnouncements.D.Notify.NotificationColor[2], b=LUIE.ChatAnnouncements.D.Notify.NotificationColor[3]}
    }
	]]--
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Currency/Loot Message Color
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR),
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyColor) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable or LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor end,
        default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyColor[3]}
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Use Context Color for Currency/Loot Messages
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT),
        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT_TP),
        getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor = value end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = LUIE.ChatAnnouncements.D.Currency.CurrencyContextColor,
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Positive Change Color
        type = "colorpicker",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORUP)),
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyColorUp) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyColorUp = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
        default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyColorUp[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyColorUp[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyColorUp[3]}
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Negative Change Color
        type = "colorpicker",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORDOWN)),
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyColorDown) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyColorDown = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
        default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyColorDown[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyColorDown[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyColorDown[3]}
    }
    
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Character Name Bracket
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER),
        tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER_TP),
        choices = linkBracketDisplayOptions,
        getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionCharacter] end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionCharacter = linkBracketDisplayOptionsKeys[value] LUIE.ChatAnnouncements.IndexGroupLoot() end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = LUIE.ChatAnnouncements.D.BracketOptionCharacter,
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Item Link Bracket
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM),
        tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM_TP),
        choices = linkBracketDisplayOptions,
        getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionItem] end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionItem = linkBracketDisplayOptionsKeys[value] end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = LUIE.ChatAnnouncements.D.BracketOptionItem,
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Lorebook Bracket
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK),
        tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK_TP),
        choices = linkBracketDisplayOptions,
        getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionLorebook] end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionLorebook = linkBracketDisplayOptionsKeys[value] end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = LUIE.ChatAnnouncements.D.BracketOptionLorebook,
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Collectible Bracket
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE),
        tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE_TP),
        choices = linkBracketDisplayOptions,
        getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionCollectible] end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionCollectible = linkBracketDisplayOptionsKeys[value] end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = LUIE.ChatAnnouncements.D.BracketOptionCollectible,
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Achievement Bracket
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT),
        tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT_TP),
        choices = linkBracketDisplayOptions,
        getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionAchievement] end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionAchievement = linkBracketDisplayOptionsKeys[value] end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = LUIE.ChatAnnouncements.D.BracketOptionAchievement,
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
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }
    -- Default Frames header
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_HEADER),
        controls = {
			-- Default PLAYER frame
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_PLAYER),
				choices = LUIE.UnitFrames.GetDefaultFramesOptions('Player'),
				getFunc = function() return LUIE.UnitFrames.GetDefaultFramesSetting('Player') end,
				setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesSetting('Player', value) end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				default = LUIE.UnitFrames.GetDefaultFramesSetting('Player', true),
			},
			-- Default TARGET frame
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_TARGET),
				choices = LUIE.UnitFrames.GetDefaultFramesOptions('Target'),
				getFunc = function() return LUIE.UnitFrames.GetDefaultFramesSetting('Target') end,
				setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesSetting('Target', value) end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				default = LUIE.UnitFrames.GetDefaultFramesSetting('Target', true),
			},
			-- Default small GROUP frame
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_GROUPSMALL),
				choices = LUIE.UnitFrames.GetDefaultFramesOptions('Group'),
				getFunc = function() return LUIE.UnitFrames.GetDefaultFramesSetting('Group') end,
				setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesSetting('Group', value) end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				default = LUIE.UnitFrames.GetDefaultFramesSetting('Group', true),
			},
			-- Reposition default player bars
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_REPOSIT),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_REPOSIT_TP),
				getFunc = function() return LUIE.UnitFrames.SV.RepositionFrames end,
				setFunc = function(value) LUIE.UnitFrames.SV.RepositionFrames = value end,
				width = "full",
				default = LUIE.UnitFrames.D.RepositionFrames,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Reposition frames adjust Y Coordinates
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_VERT),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_VERT_TP),
				min = -150, max = 300, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.RepositionFramesAdjust end,
				setFunc = function(value) LUIE.UnitFrames.SV.RepositionFramesAdjust = value end,
				width = "full",
				default = LUIE.UnitFrames.D.RepositionFramesAdjust,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.RepositionFrames) end,
			},
			-- Out-of-Combat bars transparency
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.DefaultOocTransparency end,
				setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesTransparency(value, nil) end,
				width = "full",
				default = LUIE.UnitFrames.D.DefaultOocTransparency,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- In-Combat bars transparency
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_INCTRANS),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_INCTRANS_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.DefaultIncTransparency end,
				setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesTransparency(nil, value) end,
				width = "full",
				default = LUIE.UnitFrames.D.DefaultIncTransparency,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Format label text
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_TP),
				choices = formatOptions,
				getFunc = function() return LUIE.UnitFrames.SV.Format end,
				setFunc = function(var) LUIE.UnitFrames.SV.Format = var end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.Format,
			},
			-- DefaultFrames Font
			{
				type = "dropdown",
				scrollable = true,
				name = GetString(SI_LUIE_LAM_FONT),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_TP),
				choices = FontsList,
				sort = "name-up",
				getFunc = function() return LUIE.UnitFrames.SV.DefaultFontFace end,
				setFunc = function(var) LUIE.UnitFrames.SV.DefaultFontFace = var LUIE.UnitFrames.DefaultFramesApplyFont() end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.DefaultFontFace,
			},
			-- DefaultFrames Font Size
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_FONT_SIZE),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_SIZE_TP),
				min = 10, max = 30, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.DefaultFontSize end,
				setFunc = function(value) LUIE.UnitFrames.SV.DefaultFontSize = value LUIE.UnitFrames.DefaultFramesApplyFont() end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.DefaultFontSize,
			},
			-- DefaultFrames Font Style
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_FONT_STYLE),
				tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_STYLE_TP),
				choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
				sort = "name-up",
				getFunc = function() return LUIE.UnitFrames.SV.DefaultFontStyle end,
				setFunc = function(var) LUIE.UnitFrames.SV.DefaultFontStyle = var LUIE.UnitFrames.DefaultFramesApplyFont() end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.DefaultFontStyle,
			},
			-- Color of text labels
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_COLOR),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.DefaultTextColour) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.DefaultTextColour={r,g,b} LUIE.UnitFrames.DefaultFramesApplyColour() end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.DefaultTextColour[1], g=LUIE.UnitFrames.D.DefaultTextColour[2], b=LUIE.UnitFrames.D.DefaultTextColour[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Color target name by reaction
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION),
				tooltip = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION_TP),
				getFunc = function() return LUIE.UnitFrames.SV.TargetColourByReaction end,
				setFunc = LUIE.UnitFrames.TargetColourByReaction,
				width = "full",
				default = LUIE.UnitFrames.D.TargetColourByReaction,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Target class icon
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS),
				tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS_TP),
				getFunc = function() return LUIE.UnitFrames.SV.TargetShowClass end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetShowClass = value end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetShowClass,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Target ignore/friend/guild icon
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_GFI),
				tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_GFI_TP),
				getFunc = function() return LUIE.UnitFrames.SV.TargetShowFriend end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetShowFriend = value end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetShowFriend,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
		},
	}
    -- Custom Unit Frames Header
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_HEADER),
        controls = {
			-- Custom Unit Frames Unlock
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK_TP),
				getFunc = function() return LUIE.UnitFrames.CustomFramesMovingState end,
				setFunc = LUIE.UnitFrames.CustomFramesSetMovingState,
				width = "half",
				default = false,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				resetFunc = LUIE.UnitFrames.CustomFramesResetPosition,
			},
			-- Custom Unit Frames Reset position
			{
				type = "button",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT_TP),
				func = LUIE.UnitFrames.CustomFramesResetPosition,
				width = "half",
			},
			-- Custom Unit Frames Font
			{
				type = "dropdown",
				scrollable = true,
				name = GetString(SI_LUIE_LAM_FONT),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_TP),
				choices = FontsList,
				sort = "name-up",
				getFunc = function() return LUIE.UnitFrames.SV.CustomFontFace end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFontFace = var LUIE.UnitFrames.CustomFramesApplyFont() end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.CustomFontFace,
			},
			-- Custom Unit Frames Font size labels
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS_TP),
				min = 10, max = 30, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFontOther end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomFontOther = value LUIE.UnitFrames.CustomFramesApplyFont() end,
				width = "half",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.CustomFontOther,
			},
			-- Custom Unit Frames Font size bars
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS_TP),
				min = 10, max = 30, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFontBars end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomFontBars = value LUIE.UnitFrames.CustomFramesApplyFont() end,
				width = "half",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.CustomFontBars,
			},
			-- Custom Unit Frames Font style
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_FONT_STYLE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_STYLE_TP),
				choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
				sort = "name-up",
				getFunc = function() return LUIE.UnitFrames.SV.CustomFontStyle end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFontStyle = var LUIE.UnitFrames.CustomFramesApplyFont() end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.CustomFontStyle,
			},
			-- Custom Unit Frames Texture
			{
				type = "dropdown",
				scrollable = true,
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_TEXTURE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_TEXTURE_TP),
				choices = StatusbarTexturesList,
				sort = "name-up",
				getFunc = function() return LUIE.UnitFrames.SV.CustomTexture end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomTexture = var LUIE.UnitFrames.CustomFramesApplyTexture() end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.CustomTexture,
			},
			-- Custom Unit Frames Separate Shield Bar
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomShieldBarSeparate end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomShieldBarSeparate = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomShieldBarSeparate,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end
			},
			-- Custom Unit Frames Separate Shield Bar Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT_TP),
				min = 4, max = 12, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.CustomShieldBarHeight end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomShieldBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomShieldBarHeight,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomShieldBarSeparate ) end,
			},
			-- Custom Unit Frames Overlay Full Height Shield Bar
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomShieldBarFull end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomShieldBarFull = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomShieldBarFull,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and not LUIE.UnitFrames.SV.CustomShieldBarSeparate ) end,
			},
			-- Custom Unit Frames Smooth Bar Transition
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomSmoothBar end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomSmoothBar = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomSmoothBar,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Champion Points Effective
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_CHAMPION),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_CHAMPION_TP),
				choices = championOptions,
				getFunc = function() return LUIE.UnitFrames.SV.ChampionOptions end,
				setFunc = function(var) LUIE.UnitFrames.SV.ChampionOptions = var LUIE.UnitFrames.OnPlayerActivated() end,
				width = "full",
				default = LUIE.UnitFrames.D.ChampionOptions,
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
		},
	}
    -- Custom Unit Frame Color Options
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEADER),
        controls = {
			-- Custom Unit Frames Health Bar Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALTH),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealth) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealth={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourHealth[1], g=LUIE.UnitFrames.D.CustomColourHealth[2], b=LUIE.UnitFrames.D.CustomColourHealth[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Shield Bar Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SHIELD),
				getFunc = function() return LUIE.UnitFrames.SV.CustomColourShield[1], LUIE.UnitFrames.SV.CustomColourShield[2], LUIE.UnitFrames.SV.CustomColourShield[3]  end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourShield={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourShield[1], g=LUIE.UnitFrames.D.CustomColourShield[2], b=LUIE.UnitFrames.D.CustomColourShield[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Magicka Bar Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_MAGICKA),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourMagicka) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourMagicka={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourMagicka[1], g=LUIE.UnitFrames.D.CustomColourMagicka[2], b=LUIE.UnitFrames.D.CustomColourMagicka[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Stamina Bar Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_STAMINA),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourStamina) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourStamina={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourStamina[1], g=LUIE.UnitFrames.D.CustomColourStamina[2], b=LUIE.UnitFrames.D.CustomColourStamina[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames DPS Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DPS),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourDPS) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourDPS={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourDPS[1], g=LUIE.UnitFrames.D.CustomColourDPS[2], b=LUIE.UnitFrames.D.CustomColourDPS[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Healer Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALER),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealer) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourHealer[1], g=LUIE.UnitFrames.D.CustomColourHealer[2], b=LUIE.UnitFrames.D.CustomColourHealer[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Tank Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TANK),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourTank) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourTank={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourTank[1], g=LUIE.UnitFrames.D.CustomColourTank[2], b=LUIE.UnitFrames.D.CustomColourTank[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Dragonknight Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DK),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourDragonknight) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourDragonknight={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourDragonknight[1], g=LUIE.UnitFrames.D.CustomColourDragonknight[2], b=LUIE.UnitFrames.D.CustomColourDragonknight[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Nightblade Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_NB),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourNightblade) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourNightblade={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourNightblade[1], g=LUIE.UnitFrames.D.CustomColourNightblade[2], b=LUIE.UnitFrames.D.CustomColourNightblade[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Sorcerer Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SORC),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourSorcerer) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourSorcerer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourSorcerer[1], g=LUIE.UnitFrames.D.CustomColourSorcerer[2], b=LUIE.UnitFrames.D.CustomColourSorcerer[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Templar Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TEMP),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourTemplar) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourTemplar={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourTemplar[1], g=LUIE.UnitFrames.D.CustomColourTemplar[2], b=LUIE.UnitFrames.D.CustomColourTemplar[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames Warden Role Color
			{
				type = "colorpicker",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_WARD),
				getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourWarden) end,
				setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourWarden={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = { r=LUIE.UnitFrames.D.CustomColourWarden[1], g=LUIE.UnitFrames.D.CustomColourWarden[2], b=LUIE.UnitFrames.D.CustomColourWarden[3] },
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
		},
    }
    -- Custom Unit Frames (Player, Target)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_OPTIONS_HEADER),
        controls = {
			-- Player Frames Display Method
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_METHOD),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_METHOD_TP),
				choices = playerFrameOptions,
				getFunc = function() return playerFrameOptions[LUIE.UnitFrames.SV.PlayerFrameOptions] end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerFrameOptions = playerFrameOptionsKeys[value] LUIE.UnitFrames.MenuUpdatePlayerFrameOptions(LUIE.UnitFrames.SV.PlayerFrameOptions) end,
				width = "full",
				warning = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_METHOD_WARN),
				default = LUIE.UnitFrames.D.PlayerFrameOptions,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			
			-- Position Adjust
			{
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_HORIZ_ADJUST)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_HORIZ_ADJUST_TP),
				min = 0, max = 500, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.AdjustStaminaHPos end,
				setFunc = function(value) LUIE.UnitFrames.SV.AdjustStaminaHPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.AdjustStaminaHPos,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
			},
			-- Position Adjust
			{
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_VERT_ADJUST)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_VERT_ADJUST_TP),
				min = -250, max = 250, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.AdjustStaminaVPos end,
				setFunc = function(value) LUIE.UnitFrames.SV.AdjustStaminaVPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.AdjustStaminaVPos,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
			},
			-- Position Adjust
			{
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_HORIZ_ADJUST)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_HORIZ_ADJUST_TP),
				min = 0, max = 500, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.AdjustMagickaHPos end,
				setFunc = function(value) LUIE.UnitFrames.SV.AdjustMagickaHPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.AdjustMagickaHPos,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
			},
			-- Position Adjust
			{
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_VERT_ADJUST)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_VERT_ADJUST_TP),
				min = -250, max = 250, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.AdjustMagickaVPos end,
				setFunc = function(value) LUIE.UnitFrames.SV.AdjustMagickaVPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.AdjustMagickaVPos,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
			},
			
			-- Spacing between Player Bars
			{
				type = "slider",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING_TP),
				min = -1, max = 4, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.PlayerBarSpacing end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerBarSpacing,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and ( LUIE.UnitFrames.SV.PlayerFrameOptions == 1 or LUIE.UnitFrames.SV.PlayerFrameOptions == 3 ) ) end,
			},
		},
	}
	-- Custom Unit Frames (Player, Target)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_HEADER),
        controls = {
			-- Enable LUIE PLAYER frame
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomFramesPlayer end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesPlayer = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomFramesPlayer,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Enable LUIE Target frame
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomFramesTarget end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesTarget = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomFramesTarget,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames format left label
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
				choices = formatOptions,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFormatOnePT end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatOnePT = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.CustomFormatOnePT,
			},
			-- Custom Unit Frames format right label
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
				choices = formatOptions,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFormatTwoPT end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatTwoPT = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
				width = "full",
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
				default = LUIE.UnitFrames.D.CustomFormatTwoPT,
			},
			-- Player Bars Width
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_WIDTH),
				min = 200, max = 500, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.PlayerBarWidth end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerBarWidth,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Player Health Bar Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_HP_HIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightHealth end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightHealth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerBarHeightHealth,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Player Magicka Bar Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_HIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightMagicka end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightMagicka = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerBarHeightMagicka,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Player Stamina Bar Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_HIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightStamina end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightStamina = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerBarHeightStamina,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Hide Player Magicka Bar Label
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL_TP),
				getFunc = function() return LUIE.UnitFrames.SV.HideLabelMagicka end,
				setFunc = function(value) LUIE.UnitFrames.SV.HideLabelMagicka = value LUIE.UnitFrames.SV.HideBarMagicka = false end,
				width = "full",
				default = LUIE.UnitFrames.D.HideLabelMagicka,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Hide Player Magicka Bar
			{
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.HideBarMagicka end,
				setFunc = function(value) LUIE.UnitFrames.SV.HideBarMagicka = value end,
				width = "full",
				default = LUIE.UnitFrames.D.HideBarMagicka,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.HideLabelMagicka ) end,
			},
			-- Hide Player Stamina Bar Label
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL_TP),
				getFunc = function() return LUIE.UnitFrames.SV.HideLabelStamina end,
				setFunc = function(value) LUIE.UnitFrames.SV.HideLabelStamina = value LUIE.UnitFrames.SV.HideBarStamina = false end,
				width = "full",
				default = LUIE.UnitFrames.D.HideLabelStamina,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Hide Player Stamina Bar
			{
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.HideBarStamina end,
				setFunc = function(value) LUIE.UnitFrames.SV.HideBarStamina = value end,
				width = "full",
				default = LUIE.UnitFrames.D.HideBarStamina,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.HideLabelStamina ) end,
			},
			-- Out-of-Combat frame opacity
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.PlayerOocAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerOocAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			-- In-Combat frame opacity
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.PlayerIncAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerIncAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			-- HIDE BUFFS OOC - PLAYER
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER_TP),
				getFunc = function() return LUIE.UnitFrames.SV.HideBuffsPlayerOoc end,
				setFunc = function(value) LUIE.UnitFrames.SV.HideBuffsPlayerOoc = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.HideBuffsPlayerOoc,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			-- Display self name on Player Frame
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF_TP),
				getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableYourname end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableYourname = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerEnableYourname,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Display Mount/Siege/Werewolf Bar
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarMSW end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarMSW = value LUIE.UnitFrames.CustomFramesSetupAlternative() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerEnableAltbarMSW,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Display XP/Champion XP Bar
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarXP end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarXP = value LUIE.UnitFrames.CustomFramesSetupAlternative() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerEnableAltbarXP,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Champion XP Bar Point-Type Colour
			{
				type = "checkbox",
				name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR)),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.PlayerChampionColour end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerChampionColour = value LUIE.UnitFrames.OnChampionPointGained() end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerChampionColour,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerEnableAltbarXP ) end,
			},
			-- Target Bars Width
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_WIDTH),
				min = 200, max = 500, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.TargetBarWidth end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetBarWidth,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
			},
			-- Target Bars Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_HEIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.TargetBarHeight end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetBarHeight,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
			},
			-- Out-of-Combat frame opacity
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.TargetOocAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetOocAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			-- In-Combat frame opacity
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_ICPACITY_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.TargetIncAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetIncAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			-- HIDE BUFFS OOC - TARGET
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_TARGET),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_TARGET_TP),
				getFunc = function() return LUIE.UnitFrames.SV.HideBuffsTargetOoc end,
				setFunc = function(value) LUIE.UnitFrames.SV.HideBuffsTargetOoc = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.HideBuffsTargetOoc,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			-- Display Target class label
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL_TP),
				getFunc = function() return LUIE.UnitFrames.SV.TargetEnableClass end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableClass = value end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetEnableClass,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
			},
			-- Execute Health % Threshold
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD_TP),
				min = 0, max = 50, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.ExecutePercentage end,
				setFunc = function(value) LUIE.UnitFrames.SV.ExecutePercentage = value end,
				width = "full",
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				default = LUIE.UnitFrames.D.ExecutePercentage,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Display Skull Execute Texture
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.TargetEnableSkull end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableSkull = value end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetEnableSkull,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
			},
			-- Display title on target frame
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.TargetEnableTitle end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableTitle = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetEnableTitle,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Display rank on target frame
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TP),
				getFunc = function() return LUIE.UnitFrames.SV.TargetEnableRank end,
				setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableRank = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.TargetEnableRank,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
			},
			-- Display Armor stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableArmor end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableArmor = value end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerEnableArmor,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			--Display Power stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
				getFunc = function() return LUIE.UnitFrames.SV.PlayerEnablePower end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnablePower = value end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerEnablePower,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
			-- Custom Unit Frames Display HoT / DoT Animations
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
				getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableRegen end,
				setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableRegen = value end,
				width = "full",
				default = LUIE.UnitFrames.D.PlayerEnableRegen,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Treat Missing Power as In-Combat
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomOocAlphaPower end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomOocAlphaPower = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomOocAlphaPower,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
			},
		},
	}
    -- Custom Unit Frames (Group)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEADER),
        controls = {
			-- Enable This Addon GROUP frames
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomFramesGroup end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesGroup = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomFramesGroup,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Custom Unit Frames format left label
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
				choices = formatOptions,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFormatOneGroup end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatOneGroup = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
				width = "full",
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
				default = LUIE.UnitFrames.D.CustomFormatOneGroup,
			},
			-- Custom Unit Frames format right label
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
				choices = formatOptions,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFormatTwoGroup end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatTwoGroup = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
				width = "full",
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
				default = LUIE.UnitFrames.D.CustomFormatTwoGroup,
			},
			-- Group Bars Width
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESG_WIDTH),
				min = 100, max = 400, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.GroupBarWidth end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupBarWidth,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Group Bars Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.GroupBarHeight end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupBarHeight,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Group / Raid ALPHA
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.GroupAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupAlpha = value LUIE.UnitFrames.CustomFramesGroupAlpha() end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Spacing between Group Bars
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESG_SPACING),
				min = 20, max = 80, step = 2,
				getFunc = function() return LUIE.UnitFrames.SV.GroupBarSpacing end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupBarSpacing,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Include Player in Group Frame
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER_TP),
				getFunc = function() return not LUIE.UnitFrames.SV.GroupExcludePlayer end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupExcludePlayer = (not value) LUIE.UnitFrames.CustomFramesGroupUpdate() end,
				width = "full",
				default = not LUIE.UnitFrames.D.GroupExcludePlayer,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Show Role Icon on Group Frames
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON_TP),
				getFunc = function() return LUIE.UnitFrames.SV.RoleIconSmallGroup end,
				setFunc = function(value) LUIE.UnitFrames.SV.RoleIconSmallGroup = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
				width = "full",
				default = LUIE.UnitFrames.D.RoleIconSmallGroup,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Custom Unit Frames Group Color Player Role
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.ColorRoleGroup end,
				setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleGroup = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = LUIE.UnitFrames.D.ColorRoleGroup,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			
			-- Custom Unit Frames Group Color Class
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS_TP),
				getFunc = function() return LUIE.UnitFrames.SV.ColorClassGroup end,
				setFunc = function(value) LUIE.UnitFrames.SV.ColorClassGroup = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = LUIE.UnitFrames.D.ColorClassGroup,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Display Armor stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.GroupEnableArmor end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupEnableArmor = value end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupEnableArmor,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			--Display Power stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
				getFunc = function() return LUIE.UnitFrames.SV.GroupEnablePower end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupEnablePower = value end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupEnablePower,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Display Regen Arrows
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
				getFunc = function() return LUIE.UnitFrames.SV.GroupEnableRegen end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupEnableRegen = value end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupEnableRegen,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
		},
	}
    -- Custom Unit Frames (Raid)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEADER),
        controls = {
			-- Enable This Addon RAID frames
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomFramesRaid end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesRaid = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomFramesRaid,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Raid HP Bar Format
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_TP),
				choices = formatOptions,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFormatRaid end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatRaid = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
				width = "full",
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
				default = LUIE.UnitFrames.D.CustomFormatRaid,
			},
			-- Raid Bars Width
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESR_WIDTH),
				min = 100, max = 500, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.RaidBarWidth end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
				width = "full",
				default = LUIE.UnitFrames.D.RaidBarWidth,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Raid Bars Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.RaidBarHeight end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
				width = "full",
				default = LUIE.UnitFrames.D.RaidBarHeight,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Group / Raid ALPHA
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.GroupAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.GroupAlpha = value LUIE.UnitFrames.CustomFramesGroupAlpha() end,
				width = "full",
				default = LUIE.UnitFrames.D.GroupAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
			},
			-- Raid Frame Layout
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESR_LAYOUT),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_LAYOUT_TP),
				choices = { "1 x 24", "2 x 12", "3 x 8", "4 x 6", "6 x 4" },
				-- sort = "name-up",
				getFunc = function() return LUIE.UnitFrames.SV.RaidLayout end,
				setFunc = function(var) LUIE.UnitFrames.SV.RaidLayout = var LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
				width = "full",
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
				default = LUIE.UnitFrames.D.RaidLayout,
			},
			-- Add Spacer for every 4 members
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER_TP),
				getFunc = function() return LUIE.UnitFrames.SV.RaidSpacers end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidSpacers = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
				width = "full",
				default = LUIE.UnitFrames.D.RaidSpacers,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Raid Name Clip
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP_TP),
				min = 0, max = 200, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.RaidNameClip end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidNameClip = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
				width = "full",
				default = LUIE.UnitFrames.D.RaidNameClip,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},  
			-- Class / Role Icon on Raid Frames Setting
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESR_ROLEICON),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_ROLEICON_TP),
				choices = raidIconOptions,
				getFunc = function() return raidIconOptions[LUIE.UnitFrames.SV.RaidIconOptions] end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidIconOptions = raidIconOptionsKeys[value] LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
				width = "full",
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				default = LUIE.UnitFrames.D.RaidIconOptions,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Custom Unit Frames Raid Color Player Role
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.ColorRoleRaid end,
				setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleRaid = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = LUIE.UnitFrames.D.ColorRoleRaid,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Custom Unit Frames Raid Color Player Class
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS_TP),
				getFunc = function() return LUIE.UnitFrames.SV.ColorClassRaid end,
				setFunc = function(value) LUIE.UnitFrames.SV.ColorClassRaid = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
				width = "full",
				default = LUIE.UnitFrames.D.ColorClassRaid,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Display Armor stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.RaidEnableArmor end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidEnableArmor = value end,
				width = "full",
				default = LUIE.UnitFrames.D.RaidEnableArmor,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Display Power stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
				getFunc = function() return LUIE.UnitFrames.SV.RaidEnablePower end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidEnablePower = value end,
				width = "full",
				default = LUIE.UnitFrames.D.RaidEnablePower,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
			-- Display Regen Arrows
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
				getFunc = function() return LUIE.UnitFrames.SV.RaidEnableRegen end,
				setFunc = function(value) LUIE.UnitFrames.SV.RaidEnableRegen = value end,
				width = "full",
				default = LUIE.UnitFrames.D.RaidEnableRegen,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
			},
		},
    }
	
    -- Custom Unit Frames (Boss)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEADER),
        controls = {
			-- Enable This Addon BOSS frames
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE_TP),
				getFunc = function() return LUIE.UnitFrames.SV.CustomFramesBosses end,
				setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesBosses = value end,
				width = "full",
				default = LUIE.UnitFrames.D.CustomFramesBosses,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- Boss HP Bar Format
			{
				type = "dropdown",
				name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_TP),
				choices = formatOptions,
				getFunc = function() return LUIE.UnitFrames.SV.CustomFormatBoss end,
				setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatBoss = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
				width = "full",
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
				default = LUIE.UnitFrames.D.CustomFormatBoss,
			},
			-- Boss Bars Width
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESB_WIDTH),
				min = 100, max = 500, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.BossBarWidth end,
				setFunc = function(value) LUIE.UnitFrames.SV.BossBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutBosses() end,
				width = "full",
				default = LUIE.UnitFrames.D.BossBarWidth,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
			},
			-- Boss Bars Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.BossBarHeight end,
				setFunc = function(value) LUIE.UnitFrames.SV.BossBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutBosses() end,
				width = "full",
				default = LUIE.UnitFrames.D.BossBarHeight,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
			},
			-- Out-of-Combat frame opacity
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.BossOocAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.BossOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.BossOocAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
			},
			-- In-Combat frame opacity
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC_TP),
				min = 0, max = 100, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.BossIncAlpha end,
				setFunc = function(value) LUIE.UnitFrames.SV.BossIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
				width = "full",
				default = LUIE.UnitFrames.D.BossIncAlpha,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
			},
			-- Display Armor stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
				getFunc = function() return LUIE.UnitFrames.SV.BossEnableArmor end,
				setFunc = function(value) LUIE.UnitFrames.SV.BossEnableArmor = value end,
				width = "full",
				default = LUIE.UnitFrames.D.BossEnableArmor,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
			},
			-- Display Power stat change
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
				getFunc = function() return LUIE.UnitFrames.SV.BossEnablePower end,
				setFunc = function(value) LUIE.UnitFrames.SV.BossEnablePower = value end,
				width = "full",
				default = LUIE.UnitFrames.D.BossEnablePower,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
			},
			-- Display Regen Arrows
			{
				type = "checkbox",
				name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
				tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
				getFunc = function() return LUIE.UnitFrames.SV.BossEnableRegen end,
				setFunc = function(value) LUIE.UnitFrames.SV.BossEnableRegen = value end,
				width = "full",
				default = LUIE.UnitFrames.D.BossEnableRegen,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
			},
		},	
    }
    -- Custom Unit Frames (PvP Target Frame)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_HEADER),
        controls = {
			-- Enable additional PvP Target frame
			{
				type = "checkbox",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME),
				tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_TP),
				getFunc = function() return LUIE.UnitFrames.SV.AvaCustFramesTarget end,
				setFunc = function(value) LUIE.UnitFrames.SV.AvaCustFramesTarget = value end,
				width = "full",
				default = LUIE.UnitFrames.D.AvaCustFramesTarget,
				warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
				disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
			},
			-- PvP Target Bars Width
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_WIDTH),
				min = 300, max = 700, step = 5,
				getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarWidth end,
				setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.AvaTargetBarWidth,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
			},
			-- PvP Target Bars Height
			{
				type = "slider",
				name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_HEIGHT),
				min = 20, max = 70, step = 1,
				getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarHeight end,
				setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
				width = "full",
				default = LUIE.UnitFrames.D.AvaTargetBarHeight,
				disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
			},
		},
	}
    -- Common options
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HEADER),
        width = "full",
    }
	-- Shorten numbers
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS),
        tooltip = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS_TP),
        getFunc = function() return LUIE.UnitFrames.SV.ShortenNumbers end,
        setFunc = function(value) LUIE.UnitFrames.SV.ShortenNumbers = value end,
        width = "full",
        default = LUIE.UnitFrames.D.ShortenNumbers,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Player Name Display Method
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_NAMEDISPLAYMETHOD),
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAYMETHOD_TP),
        choices = nameDisplayOptions,
        getFunc = function() return nameDisplayOptions[LUIE.UnitFrames.SV.DisplayOptions] end,
        setFunc = function(value) LUIE.UnitFrames.SV.DisplayOptions = nameDisplayOptionsKeys[value] end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = nameDisplayOptions[2]
    }
    -- Default Caption Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_COMMON_CAPTIONCOLOR),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour[1], g=LUIE.UnitFrames.D.Target_FontColour[2], b=LUIE.UnitFrames.D.Target_FontColour[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Friendly NPC Font Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_COMMON_NPCFONTCOLOR),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_FriendlyNPC) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_FriendlyNPC={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[1], g=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[2], b=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Friendly Player Font Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_COMMON_PLAYERFONTCOLOR),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_FriendlyPlayer) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_FriendlyPlayer={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[1], g=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[2], b=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Hostile Font Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HOSTILEFONTCOLOR),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_Hostile) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_Hostile={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.Target_FontColour_Hostile[1], g=LUIE.UnitFrames.D.Target_FontColour_Hostile[2], b=LUIE.UnitFrames.D.Target_FontColour_Hostile[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Apply same settings to reticle
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLOR),
        tooltip = GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLOR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.ReticleColourByReaction end,
        setFunc = LUIE.UnitFrames.ReticleColourByReaction,
        width = "full",
        default = LUIE.UnitFrames.D.ReticleColourByReaction,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Interactible Reticle Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLORINTERACT)),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.ReticleColour_Interact) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.ReticleColour_Interact={r,g,b} end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.ReticleColour_Interact[1], g=LUIE.UnitFrames.D.ReticleColour_Interact[2], b=LUIE.UnitFrames.D.ReticleColour_Interact[3] },
        disabled = function() return not (LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.ReticleColourByReaction) end,
    }
    
---------------------------------------------------------------------------------------------------------------------------------------
    --//COMBAT TEXT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------   
    
    -- Enable CT Module
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CT_SHOWCOMBATTEXT),
        getFunc = function() return LUIE.SV.CombatText_Enabled end,
        setFunc = function(value) LUIE.SV.CombatText_Enabled = value end,
        width = "full",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.CombatText_Enabled,
    }
    -- CT Description
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CT_DESCRIPTION),
    }
    -- ReloadUI Button
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }
    --UNLOCK PANELS
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type    = "checkbox",
        name    = GetString(SI_LUIE_LAM_CT_UNLOCK),
        tooltip = GetString(SI_LUIE_LAM_CT_UNLOCK_TP),
        default = LUIE.CombatText.D.unlocked,
        getFunc = function() return LUIE.CombatText.SV.unlocked end,
        setFunc = function()
            LUIE.CombatText.SV.unlocked = not LUIE.CombatText.SV.unlocked
            for k, _ in pairs (LUIE.CombatText.SV.panels) do
                _G[k]:SetMouseEnabled(LUIE.CombatText.SV.unlocked)
                _G[k]:SetMovable(LUIE.CombatText.SV.unlocked)
                _G[k .. '_Backdrop']:SetHidden(not LUIE.CombatText.SV.unlocked)
                _G[k .. '_Label']:SetHidden(not LUIE.CombatText.SV.unlocked)
            end
        end,
    }
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type    = "checkbox",
        name    = GetString(SI_LUIE_LAM_CT_IC_ONLY),
        tooltip = GetString(SI_LUIE_LAM_CT_IC_ONLY_TP),
        getFunc = function() return LUIE.CombatText.SV.toggles.inCombatOnly end,
        setFunc = function(v) LUIE.CombatText.SV.toggles.inCombatOnly = v end,
        default = LUIE.CombatText.D.toggles.inCombatOnly,
    }
    
---------------------------------------------------------------------------------------------------------------------------------------
    --//TOGGLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------

    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_INCOMING_HEADER),
        controls = {
        --INCOMING DAMAGE & HEALING
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_HEAL_HEADER),
            },
                {--DAMAGE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDamage end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDamage = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showDamage,
                },
                {--HEALING
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HEALING_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showHealing end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showHealing = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showHealing,
                },
                {--ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showEnergize = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showEnergize,
                },
                {--ULTIMATE ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showUltimateEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showUltimateEnergize = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showUltimateEnergize,
                },
                {--DRAIN
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DRAIN_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDrain end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDrain = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showDrain,
                },
                {--DOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDot = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showDot,
                },
                {--HOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showHot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showHot = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showHot,
                },
        --INCOMING MITIGATION
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_INCOMING_MITIGATION),
            },
                {--MISS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_MISS),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_MISS_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showMiss end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showMiss = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showMiss
                },
                {--IMMUNE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_IMMUNE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showImmune end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showImmune = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showImmune,
                },
                {--PARRIED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_PARRIED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showParried end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showParried = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showParried,
                },
                {--REFLECT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_REFLECTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showReflected end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showReflected = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showReflected,
                },
                {--DAMAGESHIELD
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_SHIELD_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDamageShield end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDamageShield = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showDamageShield,
                },
                {--DODGE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DODGED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDodged end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDodged = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showDodged,
                },
                {--BLOCK
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_BLOCKED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showBlocked end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showBlocked = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showBlocked,
                },
                {--INTERRUPT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_INTERRUPTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showInterrupted end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showInterrupted = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showInterrupted,
                },
        --INCOMING CROWD CONTROL
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_INCOMING_CROWD_CONTROL),
            },
                {--DISORIENTED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DISORIENTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDisoriented end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDisoriented = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showDisoriented,
                },
                {--FEARED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_FEARED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showFeared end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showFeared = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showFeared,
                },
                {--OFF BALANCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_OFF_BALANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showOffBalanced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showOffBalanced = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showOffBalanced,
                },
                {--SILENCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_SILENCED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showSilenced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showSilenced = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showSilenced,
                },
                {--STUNNED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_STUNNED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showStunned end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showStunned = v end,
                    default = LUIE.CombatText.D.toggles.incoming.showStunned,
                },
            },
        }
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_OUTGOING_HEADER),
        controls = {
        --OUTGOING DAMAGE & HEALING
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_HEAL_HEADER),
            },
                {--DAMAGE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDamage end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDamage = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showDamage,
                },
                {--DOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDot = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showDot,
                },
                {--HEALING
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HEALING_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showHealing end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showHealing = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showHealing,
                },
                {--HOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showHot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showHot = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showHot,
                },
                {--ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showEnergize = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showEnergize,
                },
                {--ULTIMATE ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showUltimateEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showUltimateEnergize = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showUltimateEnergize,
                },
                {--DRAIN
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DRAIN_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDrain end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDrain = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showDrain,
                },
        --OUTGOING MITIGATION
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_OUTGOING_MITIGATION),
            },
                {--MISS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_MISS),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_MISS_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showMiss end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showMiss = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showMiss,
                },
                {--IMMUNE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_IMMUNE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showImmune end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showImmune = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showImmune,
                },
                {--PARRIED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_PARRIED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showParried end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showParried = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showParried,
                },
				{--REFLECT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_REFLECTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showReflected end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showReflected = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showReflected,
                },
                {--DAMAGESHIELD
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_SHIELD_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDamageShield end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDamageShield = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showDamageShield,
                },
                {--DODGE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DODGED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDodged end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDodged = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showDodged,
                },
                {--BLOCK
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_BLOCKED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showBlocked end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showBlocked = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showBlocked,
                },
                {--INTERRUPT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_INTERRUPTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showInterrupted end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showInterrupted = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showInterrupted,
                },
        --OUTGOING CROWD CONTROL
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_OUTGOING_CROWD_CONTROL),
            },
                {--DISORIENTED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DISORIENTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDisoriented end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDisoriented = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showDisoriented,
                },
                {--FEARED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_FEARED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showFeared end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showFeared = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showFeared,
                },
                {--OFF BALANCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_OFF_BALANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showOffBalanced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showOffBalanced = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showOffBalanced,
                },
                {--SILENCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_SILENCED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showSilenced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showSilenced = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showSilenced,
                },
                {--STUNNED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_STUNNED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showStunned end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showStunned = v end,
                    default = LUIE.CombatText.D.toggles.outgoing.showStunned,
                },
            },
        }
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_NOTIFICATION),
        controls = {
        --TOGGLE COMBAT STATE
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_STATE),
            },
                {--IN COMBAT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_IN_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showInCombat end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showInCombat = v end,
                    default = LUIE.CombatText.D.toggles.showInCombat,
                },
                {--OUT OF COMBAT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT),
                    tooltip =GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_OUT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showOutCombat end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showOutCombat = v end,
                    default = LUIE.CombatText.D.toggles.showOutCombat,
                },
        --TOGGLE ALERTS
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERTS),
            },
                {
                    type = "description",
                    text = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERTS_DESC),
                },
                {--CLEANSE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_CLEANSE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertCleanse end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertCleanse = v end,
                    default = LUIE.CombatText.D.toggles.showAlertCleanse,
                },
                {--EXPLOIT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXPLOIT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertExploit end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertExploit = v end,
                    default = LUIE.CombatText.D.toggles.showAlertExploit,
                },
                {--EXECUTE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXECUTE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertExecute end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertExecute = v end,
                    default = LUIE.CombatText.D.toggles.showAlertExecute,
                },
                {--EXECUTE THRESHOLD SLIDER
                    type    = "slider",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD_TP),
                    min     = 10,
                    max     = 50,
                    getFunc = function() return LUIE.CombatText.SV.executeThreshold end,
                    setFunc = function(v) LUIE.CombatText.SV.executeThreshold = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertExecute end,
                    default = LUIE.CombatText.D.executeThreshold,
                },
                {--EXECUTE FREQUENCY SLIDER
                    type    = "slider",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY_TP),
                    min     = 1,
                    max     = 20,
                    getFunc = function() return LUIE.CombatText.SV.executeFrequency end,
                    setFunc = function(v) LUIE.CombatText.SV.executeFrequency = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertExecute end,
                    default = LUIE.CombatText.D.executeFrequency,
                },
                {--HIDE INGAME TIPS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.hideIngameTips end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.hideIngameTips = v; ZO_ActiveCombatTips:SetHidden(v) end,
                    default = LUIE.CombatText.D.toggles.hideIngameTips,
                },
                {--MITIGATION ALERTS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertMitigation = v end,
                    default = LUIE.CombatText.D.toggles.showAlertMitigation,
                },
                
                {
                    type = "description",
                    text = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_DESCRIPTION),
                },
                
                {--MITIGATION METHOD
                    type    = "dropdown",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD_TP),
                    choices = LUIE.CombatTextConstants.mitigationType,
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationType end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationType = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationType,
                },
                
                {--MITIGATION FORMAT
                    type    = "editbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationFormat end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationFormat = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationFormat,
                },
                
                {--MITIGATION SUFFIX
                    type    = "editbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationSuffix end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationSuffix = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationSuffix,
                },
				
				{--MITIGATION AURA
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationAura end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationAura = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationAura,
                },
                
                {--MITIGATION RANK 3
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank3 end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank3 = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationRank3,
                },
                {--MITIGATION RANK 2
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank2 end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank2 = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationRank2,
                },
                {--MITIGATION RANK 1
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank1 end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank1 = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationRank1,
                },
                {--MITIGATION DUNGEON
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationDungeon end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationDungeon = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.mitigationDungeon,
                },
                
                {--BLOCK
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_BLOCK_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertBlock end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertBlock = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.showAlertBlock,
                },
                {--DODGE
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_DODGE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertDodge end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertDodge = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.showAlertDodge,
                },
                {--AVOID
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_AVOID_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertAvoid end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertAvoid = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.showAlertAvoid,
                },
                {--INTERRUPT
                    type    = "checkbox",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_INTERRUPT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertInterrupt end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertInterrupt = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = LUIE.CombatText.D.toggles.showAlertInterrupt,
                },
        --TOGGLE POINTS
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS),
            },
                {--ALLIANCE POINTS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_ALLIANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_ALLIANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showPointsAlliance end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsAlliance = v end,
                    default = LUIE.CombatText.D.toggles.showPointsAlliance,
                },
                {--EXPERIENCE POINTS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_EXPERIENCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showPointsExperience end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsExperience = v end,
                    default = LUIE.CombatText.D.toggles.showPointsExperience,
                },
                {--CHAMPION POINTS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_CHAMPION_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showPointsChampion end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsChampion = v end,
                    default = LUIE.CombatText.D.toggles.showPointsChampion,
                },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RESOURCES),
            },
                {--LOW HEALTH
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_HEALTH),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_HEALTH_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showLowHealth end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showLowHealth = v end,
                    default = LUIE.CombatText.D.toggles.showLowHealth,
                },
                {--LOW HEALTH WARNING THRESHOLD SLIDER
                    type    = "slider",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_HEALTH)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_HEALTH_TP),
                    min     = 15,
                    max     = 50,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.healthThreshold end,
                    setFunc = function(threshold) LUIE.CombatText.SV.healthThreshold = threshold end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showLowHealth end,
                    default = LUIE.CombatText.D.healthThreshold,
                },
                {--LOW MAGICKA
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_MAGICKA_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showLowMagicka end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showLowMagicka = v end,
                    default = LUIE.CombatText.D.toggles.showLowMagicka,
                },
                {--LOW MAGICKA WARNING THRESHOLD SLIDER
                    type    = "slider",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_MAGICKA)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_MAGICKA_TP),
                    min     = 15,
                    max     = 50,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.magickaThreshold end,
                    setFunc = function(threshold) LUIE.CombatText.SV.magickaThreshold = threshold end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showLowMagicka end,
                    default = LUIE.CombatText.D.magickaThreshold,
                },
                {--LOW STAMINA
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_STAMINA_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showLowStamina end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showLowStamina = v end,
                    default = LUIE.CombatText.D.toggles.showLowStamina,
                },
                {--LOW STAMINA WARNING THRESHOLD SLIDER
                    type    = "slider",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_STAMINA)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_STAMINA_TP),
                    min     = 15,
                    max     = 50,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.staminaThreshold end,
                    setFunc = function(threshold) LUIE.CombatText.SV.staminaThreshold = threshold end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showLowStamina end,
                    default = LUIE.CombatText.D.staminaThreshold,
                },
                {--WARNING SOUND
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.warningSound end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.warningSound = v end,
                    disabled = function() return not (LUIE.CombatText.SV.toggles.showLowHealth or LUIE.CombatText.SV.toggles.showLowMagicka or LUIE.CombatText.SV.toggles.showLowStamina) end,
                    default = LUIE.CombatText.D.toggles.warningSound,
                },
                {--ULTIMATE READY
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ULTIMATE_READY_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showUltimate end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showUltimate = v end,
                    default = LUIE.CombatText.D.toggles.showUltimate,
                },
                {--POTION READY
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POTION_READY_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showPotionReady end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showPotionReady = v end,
                    default = LUIE.CombatText.D.toggles.showPotionReady,
                },
            },
        }
---------------------------------------------------------------------------------------------------------------------------------------
    --//FONT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_FONT_HEADER),
        controls = {
                {--FONT FACE DROPDOWN
                    type    = "dropdown",
                    scrollable = true,
                    name    = GetString(SI_LUIE_LAM_CT_FONT_FACE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_FACE_TP),
                    choices = FontsList,
                    getFunc = function() return LUIE.CombatText.SV.fontFace end,
                    setFunc = function(face)
                        LUIE.CombatText.SV.fontFace = face
                        for k, _ in pairs (LUIE.CombatText.SV.panels) do
                            _G[k .. "_Label"]:SetFont(LMP:Fetch(LMP.MediaType.FONT, LUIE.CombatText.SV.fontFace) .. "|26|" .. LUIE.CombatText.SV.fontOutline)
                        end
                    end,
                    default = LUIE.CombatText.D.fontFace
                },
                {--FONT OUTLINE DROPDOWN
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_FONT_OUTLINE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_OUTLINE_TP),
                    choices = LUIE.CombatTextConstants.outlineType,
                    getFunc = function() return LUIE.CombatText.SV.fontOutline end,
                    setFunc = function(outline)
                        LUIE.CombatText.SV.fontOutline = outline
                        for k, _ in pairs (LUIE.CombatText.SV.panels) do
                            _G[k .. "_Label"]:SetFont(LMP:Fetch(LMP.MediaType.FONT, LUIE.CombatText.SV.fontFace) .. "|26|" .. LUIE.CombatText.SV.fontOutline)
                        end
                    end,
                    default = LUIE.CombatText.D.fontOutline
                },
                {--TEST FONT BUTTON
                    type = "button",
                    name    = GetString(SI_LUIE_LAM_CT_FONT_TEST),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_TEST_TP),
                    func = function()
                        CALLBACK_MANAGER:FireCallbacks(LUIE.CombatTextConstants.eventType.COMBAT, LUIE.CombatTextConstants.combatType.INCOMING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                    end,
                },
            },
        }
---------------------------------------------------------------------------------------------------------------------------------------
    --//FONT SIZES//--
---------------------------------------------------------------------------------------------------------------------------------------
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HEADER),
        controls = {
                {--DAMAGE
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DAMAGE_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.damage end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.damage = size end,
                    default = LUIE.CombatText.D.fontSizes.damage,
                },
				{--DAMAGE CRITICAL
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DAMAGE_CRITICAL_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.damagecritical end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.damagecritical = size end,
                    default = LUIE.CombatText.D.fontSizes.damagecritical,
                },
                {--HEALING
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HEALING_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.healing end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.healing = size end,
                    default = LUIE.CombatText.D.fontSizes.healing,
                },
				{--HEALING CRITICAL
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HEALING_CRITICAL_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.healingcritical end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.healingcritical = size end,
                    default = LUIE.CombatText.D.fontSizes.healingcritical,
                },
                {--DOT
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DOT_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.dot end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.dot = size end,
                    default = LUIE.CombatText.D.fontSizes.dot,
                },
				{--DOT CRITICAL
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DOT_CRITICAL_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.dotcritical end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.dotcritical = size end,
                    default = LUIE.CombatText.D.fontSizes.dotcritical,
                },
				{--HOT
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HOT_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.hot end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.hot = size end,
                    default = LUIE.CombatText.D.fontSizes.hot,
                },
				{--HOT CRITICAL
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HOT_CRITICAL_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.hotcritical end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.hotcritical = size end,
                    default = LUIE.CombatText.D.fontSizes.hotcritical,
                },
                {--Gain Loss
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_GAIN_LOSS),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_GAIN_LOSS_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.gainLoss end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.gainLoss = size end,
                    default = LUIE.CombatText.D.fontSizes.gainLoss,
                },
                {--MITIGATION
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_MITIGATION),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_MITIGATION_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.mitigation end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.mitigation = size end,
                    default = LUIE.CombatText.D.fontSizes.mitigation,
                },
                {--CROWD CONTROL
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_CROWD_CONTROL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_CROWD_CONTROL_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.crowdControl end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.crowdControl = size end,
                    default = LUIE.CombatText.D.fontSizes.crowdControl,
                },
            },
        }
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_HEADER),
        controls = {
                {--COMBAT STATE
                    type     = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_STATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_COMBAT_STATE_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.combatState end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.combatState = size end,
                    default = LUIE.CombatText.D.fontSizes.combatState,
                },
                {--ALERTS
                    type     = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_ALERT_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.alert end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.alert = size end,
                    default = LUIE.CombatText.D.fontSizes.alert,
                },
                {--POINTS
                    type     = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_POINTS_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.point end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.point = size end,
                    default = LUIE.CombatText.D.fontSizes.point,
                },
                {--RESOURCES
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_RESOURCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_RESOURCE_TP),
                    min     = 8,
                    max     = 72,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.fontSizes.resource end,
                    setFunc = function(size) LUIE.CombatText.SV.fontSizes.resource = size end,
                    default = LUIE.CombatText.D.fontSizes.resource,
                },
            },
        }
---------------------------------------------------------------------------------------------------------------------------------------
    --//COLOR OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEADER),
        controls = {
        --COLOR DAMAGE & HEALING
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_HEALING_HEADER),
            },
                {--NONE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_NONE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_NONE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[0]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[0] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[0][1], g=LUIE.CombatText.D.colors.damage[0][2], b=LUIE.CombatText.D.colors.damage[0][3]}
                },
                {--GENERIC
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[1]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[1] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[1][1], g=LUIE.CombatText.D.colors.damage[1][2], b=LUIE.CombatText.D.colors.damage[1][3]}
                },
                {--PHYSICAL
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[2]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[2] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[2][1], g=LUIE.CombatText.D.colors.damage[2][2], b=LUIE.CombatText.D.colors.damage[2][3]}
                },
                {--FIRE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[3]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[3] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[3][1], g=LUIE.CombatText.D.colors.damage[3][2], b=LUIE.CombatText.D.colors.damage[3][3]}
                },
                {--SHOCK
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[4]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[4] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[4][1], g=LUIE.CombatText.D.colors.damage[4][2], b=LUIE.CombatText.D.colors.damage[4][3]}
                },
                {--OBLIVION
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[5]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[5] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[5][1], g=LUIE.CombatText.D.colors.damage[5][2], b=LUIE.CombatText.D.colors.damage[5][3]}
                },
                {--COLD
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[6]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[6] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[6][1], g=LUIE.CombatText.D.colors.damage[6][2], b=LUIE.CombatText.D.colors.damage[6][3]}
                },
                {--EARTH
                    type     = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[7]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[7] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[7][1], g=LUIE.CombatText.D.colors.damage[7][2], b=LUIE.CombatText.D.colors.damage[7][3]}
                },
                {--MAGIC
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[8]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[8] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[8][1], g=LUIE.CombatText.D.colors.damage[8][2], b=LUIE.CombatText.D.colors.damage[8][3]}
                },
                {--DROWN
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[9]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[9] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[9][1], g=LUIE.CombatText.D.colors.damage[9][2], b=LUIE.CombatText.D.colors.damage[9][3]}
                },
                {--DISEASE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[10]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[10] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[10][1], g=LUIE.CombatText.D.colors.damage[10][2], b=LUIE.CombatText.D.colors.damage[10][3]}
                },
                {--POISON
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[11]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[11] = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damage[11][1], g=LUIE.CombatText.D.colors.damage[11][2], b=LUIE.CombatText.D.colors.damage[11][3]}
                },
                {--HEALING
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.healing) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.healing = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.healing[1], g=LUIE.CombatText.D.colors.healing[2], b=LUIE.CombatText.D.colors.healing[3]}
                },
                {--ENERGIZE MAGICKA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_MAGICKA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeMagicka) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeMagicka = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.energizeMagicka[1], g=LUIE.CombatText.D.colors.energizeMagicka[2], b=LUIE.CombatText.D.colors.energizeMagicka[3]}
                },
                {--ENERGIZE STAMINA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_STAMINA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeStamina) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeStamina = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.energizeStamina[1], g=LUIE.CombatText.D.colors.energizeStamina[2], b=LUIE.CombatText.D.colors.energizeStamina[3]}
                },
                {--ENERGIZE ULTIMATE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeUltimate) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeUltimate = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.energizeUltimate[1], g=LUIE.CombatText.D.colors.energizeUltimate[2], b=LUIE.CombatText.D.colors.energizeUltimate[3]}
                },
                {--DRAIN MAGICKA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_MAGICKA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.drainMagicka) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.drainMagicka = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.drainMagicka[1], g=LUIE.CombatText.D.colors.drainMagicka[2], b=LUIE.CombatText.D.colors.drainMagicka[3]}
                },
                {--DRAIN STAMINA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_STAMINA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.drainStamina) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.drainStamina = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.drainStamina[1], g=LUIE.CombatText.D.colors.drainStamina[2], b=LUIE.CombatText.D.colors.drainStamina[3]}
                },
                {--CHECKBOX CRITICAL DAMAGE OVERRIDE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.criticalDamageOverride end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.criticalDamageOverride = v end,
                    default = LUIE.CombatText.D.toggles.criticalDamageOverride,
                },
                {--COLOR CRITICAL DAMAGE OVERRIDE
                    type    = "colorpicker",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR)),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.criticalDamageOverride) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.criticalDamageOverride = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.criticalDamageOverride[1], g=LUIE.CombatText.D.colors.criticalDamageOverride[2], b=LUIE.CombatText.D.colors.criticalDamageOverride[3]}
                },
                {--CHECKBOX CRITICAL HEALING OVERRIDE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.criticalHealingOverride end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.criticalHealingOverride = v end,
                    default = LUIE.CombatText.D.toggles.criticalHealingOverride
                },
                {--COLOR CRITICAL HEALING OVERRIDE
                    type    = "colorpicker",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR)),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.criticalHealingOverride) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.criticalHealingOverride = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.criticalHealingOverride[1], g=LUIE.CombatText.D.colors.criticalHealingOverride[2], b=LUIE.CombatText.D.colors.criticalHealingOverride[3]}
                },
				{--CHECKBOX INCOMING DAMAGE OVERRIDE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incomingDamageOverride end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incomingDamageOverride = v end,
                    default = LUIE.CombatText.D.toggles.incomingDamageOverride
                },
                {--COLOR INCOMING DAMAGE OVERRIDE
                    type    = "colorpicker",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR)),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.incomingDamageOverride) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.incomingDamageOverride = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.incomingDamageOverride[1], g=LUIE.CombatText.D.colors.incomingDamageOverride[2], b=LUIE.CombatText.D.colors.incomingDamageOverride[3]}
                },
        --COLOR MITIGATION
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_MITIGATION_HEADER),
            },
                {--MISS
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_MISS),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_MISS_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.miss) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.miss = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.miss[1], g=LUIE.CombatText.D.colors.miss[2], b=LUIE.CombatText.D.colors.miss[3]}
                },
                {--IMMUNE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_IMMUNE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.immune) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.immune = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.immune[1], g=LUIE.CombatText.D.colors.immune[2], b=LUIE.CombatText.D.colors.immune[3]}
                },
                {--PARRIED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_PARRIED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.parried) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.parried = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.parried[1], g=LUIE.CombatText.D.colors.parried[2], b=LUIE.CombatText.D.colors.parried[3]}
                },
                {--REFLECTED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_REFLETCED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.reflected) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.reflected = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.reflected[1], g=LUIE.CombatText.D.colors.reflected[2], b=LUIE.CombatText.D.colors.reflected[3]}
                },
                {--DAMAGESHIELD
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHIELD_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damageShield) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damageShield = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.damageShield[1], g=LUIE.CombatText.D.colors.damageShield[2], b=LUIE.CombatText.D.colors.damageShield[3]}
                },
                {--DODGE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DODGED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.dodged) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.dodged = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.dodged[1], g=LUIE.CombatText.D.colors.dodged[2], b=LUIE.CombatText.D.colors.dodged[3]}
                },
                {--BLOCKED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_BLOCKED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.blocked) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.blocked = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.blocked[1], g=LUIE.CombatText.D.colors.blocked[2], b=LUIE.CombatText.D.colors.blocked[3]}
                },
                {--INTERRUPTED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INTERRUPTED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.interrupted) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.interrupted = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.interrupted[1], g=LUIE.CombatText.D.colors.interrupted[2], b=LUIE.CombatText.D.colors.interrupted[3]}
                },
        --COLOR CROWD CONTROL
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CROWD_CONTROL_HEADER),
            },
                {--DISORIENTED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DISORIENTED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.disoriented) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.disoriented = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.disoriented[1], g=LUIE.CombatText.D.colors.disoriented[2], b=LUIE.CombatText.D.colors.disoriented[3]}
                },
                {--FEARED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_FEARED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.feared) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.feared = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.feared[1], g=LUIE.CombatText.D.colors.feared[2], b=LUIE.CombatText.D.colors.feared[3]}
                },
                {--OFFBALANCED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_OFF_BALANCE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.offBalanced) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.offBalanced = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.offBalanced[1], g=LUIE.CombatText.D.colors.offBalanced[2], b=LUIE.CombatText.D.colors.offBalanced[3]}
                },
                {--SILENCED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_SILENCED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.silenced) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.silenced = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.silenced[1], g=LUIE.CombatText.D.colors.silenced[2], b=LUIE.CombatText.D.colors.silenced[3]}
                },
                {--STUNNED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_STUNNED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.stunned) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.stunned = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.stunned[1], g=LUIE.CombatText.D.colors.stunned[2], b=LUIE.CombatText.D.colors.stunned[3]}
                },
            },
        }
        optionsDataCombatText[#optionsDataCombatText +1] = {
            type = "submenu",
            name = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_HEADER),
            controls = {
        --COMBAT STATE
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_HEADER),
            },
                {--IN COMBAT
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_IN_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.inCombat) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.inCombat = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.inCombat[1], g=LUIE.CombatText.D.colors.inCombat[2], b=LUIE.CombatText.D.colors.inCombat[3]}
                },
                {--OUT COMBAT
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_OUT_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.outCombat) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.outCombat = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.outCombat[1], g=LUIE.CombatText.D.colors.outCombat[2], b=LUIE.CombatText.D.colors.outCombat[3]}
                },
        --COLOR ALERTS
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ALERT_HEADER),
            },
                {--BLOCK
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BLOCK_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertBlock) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertBlock = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.alertBlock[1], g=LUIE.CombatText.D.colors.alertBlock[2], b=LUIE.CombatText.D.colors.alertBlock[3]}
                },
                {--DODGE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DODGE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertDodge) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertDodge = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.alertDodge[1], g=LUIE.CombatText.D.colors.alertDodge[2], b=LUIE.CombatText.D.colors.alertDodge[3]}
                },
                {--AVOID
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_AVOID_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertAvoid) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertAvoid = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.alertAvoid[1], g=LUIE.CombatText.D.colors.alertAvoid[2], b=LUIE.CombatText.D.colors.alertAvoid[3]}
                },
                {--INTERRUPT
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_INTERRUPT_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertInterrupt) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertInterrupt = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.alertInterrupt[1], g=LUIE.CombatText.D.colors.alertInterrupt[2], b=LUIE.CombatText.D.colors.alertInterrupt[3]}
                },
                {--EXPLOIT
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPLOIT_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertExploit) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertExploit = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.alertExploit[1], g=LUIE.CombatText.D.colors.alertExploit[2], b=LUIE.CombatText.D.colors.alertExploit[3]}
                },
                {--CLEANSE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CLEANSE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertCleanse) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertCleanse = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.alertCleanse[1], g=LUIE.CombatText.D.colors.alertCleanse[2], b=LUIE.CombatText.D.colors.alertCleanse[3]}
                },
                {--EXECUTE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXECUTE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertExecute) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertExecute = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.alertExecute[1], g=LUIE.CombatText.D.colors.alertExecute[2], b=LUIE.CombatText.D.colors.alertExecute[3]}
                },
        --COLOR POINTS
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POINT_HEADER),
            },
                {--ALLIANCE POINTS
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_ALLIANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ALLIANCE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsAlliance) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsAlliance = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.pointsAlliance[1], g=LUIE.CombatText.D.colors.pointsAlliance[2], b=LUIE.CombatText.D.colors.pointsAlliance[3]}
                },
                {--EXPERIENCE POINTS
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPERIENCE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsExperience) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsExperience = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.pointsExperience[1], g=LUIE.CombatText.D.colors.pointsExperience[2], b=LUIE.CombatText.D.colors.pointsExperience[3]}
                },
                {--CHAMPION POINTS
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CHAMPION_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsChampion) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsChampion = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.pointsChampion[1], g=LUIE.CombatText.D.colors.pointsChampion[2], b=LUIE.CombatText.D.colors.pointsChampion[3]}
                },
        --COLOR RESOURCES
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_RESOURCE_HEADER),
            },
                {--LOW HEALTH
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_HEALTH),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_HEALTH_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowHealth) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowHealth = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.lowHealth[1], g=LUIE.CombatText.D.colors.lowHealth[2], b=LUIE.CombatText.D.colors.lowHealth[3]}
                },
                {--LOW MAGICKA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_MAGICKA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowMagicka) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowMagicka = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.lowMagicka[1], g=LUIE.CombatText.D.colors.lowMagicka[2], b=LUIE.CombatText.D.colors.lowMagicka[3]}
                },
                {--LOW STAMINA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_STAMINA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowStamina) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowStamina = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.lowStamina[1], g=LUIE.CombatText.D.colors.lowStamina[2], b=LUIE.CombatText.D.colors.lowStamina[3]}
                },
                {--ULTIMATE READY
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ULTIMATE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.ultimateReady) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.ultimateReady = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.ultimateReady[1], g=LUIE.CombatText.D.colors.ultimateReady[2], b=LUIE.CombatText.D.colors.ultimateReady[3]}
                },
                {--POTION READY
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POTION_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.potionReady) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.potionReady = { r, g, b, a } end,
                    default = {r=LUIE.CombatText.D.colors.potionReady[1], g=LUIE.CombatText.D.colors.potionReady[2], b=LUIE.CombatText.D.colors.potionReady[3]}
                },
            },
        }
---------------------------------------------------------------------------------------------------------------------------------------
    --//FORMAT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
        optionsDataCombatText[#optionsDataCombatText +1] = {
            type = "submenu",
            name = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEADER),
            controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
        --FORMATS DAMAGE & HEALING
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_HEALING_HEADER),
            },
                {--DAMAGE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.damage end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.damage = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.damage,
                },
				{--DAMAGE CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.damagecritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.damagecritical = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.damagecritical,
                },
                {--HEALING
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.healing end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.healing = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.healing,
                },
				{--HEALING CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.healingcritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.healingcritical = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.healingcritical,
                },
                {--ENERGIZE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.energize end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.energize = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.energize,
                },
                {-- ULTIMATE ENERGIZE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.ultimateEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.ultimateEnergize = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.ultimateEnergize,
                },
                {--DRAIN
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DRAIN_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.drain end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.drain = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.drain,
                },
                {--DOT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.dot end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.dot = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.dot,
                },
				{--DOT CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.dotcritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.dotcritical = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.dotcritical,
                },
                {--HOT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.hot end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.hot = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.hot,
                },
				{--HOT CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.hotcritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.hotcritical = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.hotcritical,
                },
        --FORMATS MITIGATION
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_MITIGATION_HEADER),
            },
                {--MISS
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_MISS),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_MISS_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.miss end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.miss = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.miss,
                },
                {--IMMUNE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_IMMUNE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.immune end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.immune = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.immune,
                },
                {--PARRIED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_PARRIED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.parried end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.parried = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.parried,
                },
                {--REFLECTED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_REFLECTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.reflected end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.reflected = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.reflected,
                },
                {--DAMAGE SHIELD
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_SHIELD_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.damageShield end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.damageShield = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.damageShield,
                },
                {--DODGED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DODGED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.dodged end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.dodged = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.dodged,
                },
                {--BLOCKED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_BLOCKED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.blocked end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.blocked = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.blocked,
                },
                {--INTERRUPTED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_INTERRUPTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.interrupted end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.interrupted = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.interrupted,
                },
        --FORMATS CROWD CONTROL
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_CROWD_CONTROL_HEADER),
            },
                {--DISORIENTED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DISORIENTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.disoriented end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.disoriented = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.disoriented,
                },
                {--FEARED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_FEARED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.feared end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.feared = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.feared,
                },
                {--OFFBALANCED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_OFF_BALANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.offBalanced end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.offBalanced = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.offBalanced,
                },
                {--SILENCED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_SILENCED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.silenced end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.silenced = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.silenced,
                },
                {--STUNNED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_STUNNED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.stunned end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.stunned = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.stunned,
                },
            },
        }
        optionsDataCombatText[#optionsDataCombatText +1] = {
            type = "submenu",
            name = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_HEADER),
            controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
        --FORMATS COMBAT STATE
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_STATE_HEADER),
            },
                {--IN COMBAT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_COMBAT_IN_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.inCombat end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.inCombat = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.inCombat,
                },
                {--OUT COMBAT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_COMBAT_OUT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.outCombat end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.outCombat = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.outCombat,
                },
        --FORMATS ALERTS
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_FORMAT_ALERT_HEADER),
            },
                {--CLEANSE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_CLEANSE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertCleanse end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertCleanse = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertCleanse,
                },
                {--BLOCK
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertBlock end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertBlock = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertBlock,
                },
                {--BLOCK
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK_S),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_S_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertBlockStagger end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertBlockStagger = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertBlockStagger,
                },
                {--EXPLOIT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPLOIT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertExploit end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertExploit = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertExploit,
                },
                {--INTERRUPT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_INTERRUPT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertInterrupt end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertInterrupt = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertInterrupt,
                },
                {--DODGE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DODGE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertDodge end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertDodge = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertDodge,
                },
                {--AVOID
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_AVOID_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertAvoid end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertAvoid = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertAvoid,
                },
                {--EXECUTE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXECUTE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertExecute end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertExecute = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.alertExecute,
                },
        --FORMATS POINTS
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_FORMAT_POINTS_HEADER),
            },
                {--ALLIANCE POINTS
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_ALLIANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_ALLIANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.pointsAlliance end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.pointsAlliance = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.pointsAlliance,
                },
                {--EXPERIENCE POINTS
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPERIENCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.pointsExperience end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.pointsExperience = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.pointsExperience,
                },
                {--CHAMPION POINTS
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_CHAMPION_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.pointsChampion end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.pointsChampion = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.pointsChampion,
                },
        --FORMATS RESOURCES
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_FORMAT_RESOURCES_HEADER),
            },
                {--LOW HEALTH, MAGICKA, STAMINA
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_RESOURCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_RESOURCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.resource end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.resource = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.resource,
                },
                {--ULTIMATE READY
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.ultimateReady end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.ultimateReady = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.ultimateReady,
                },
                {--ULTIMATE READY
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POTION_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.potionReady end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.potionReady = v end,
                    isMultiline = false,
                    default = LUIE.CombatText.D.formats.potionReady,
                },
            },
        }
---------------------------------------------------------------------------------------------------------------------------------------
    --//ANIMATION OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
        optionsDataCombatText[#optionsDataCombatText +1] = {
            type = "submenu",
            name = GetString(SI_LUIE_LAM_CT_ANIMATION_HEADER),
            controls = {
                {--ANIMATION TYPE
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_TYPE),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_TYPE_TP),
                    choices = LUIE.CombatTextConstants.animationType,
                    getFunc = function() return LUIE.CombatText.SV.animation.animationType end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.animationType = v end,
                    default = LUIE.CombatText.D.animation.animationType,
                },
                {--INCOMING DIRECTION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN_TP),
                    choices = LUIE.CombatTextConstants.directionType,
                    getFunc = function() return LUIE.CombatText.SV.animation.incoming.directionType end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.incoming.directionType = v end,
                    default = LUIE.CombatText.D.animation.incoming.directionType,
                },
                {--INCOMING ICON POSITION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN_TP),
                    choices = LUIE.CombatTextConstants.iconSide,
                    getFunc = function() return LUIE.CombatText.SV.animation.incomingIcon end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.incomingIcon = v end,
                    default = LUIE.CombatText.D.animation.incomingIcon,
                },
                {--OUTGOING DIRECTION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT_TP),
                    choices = LUIE.CombatTextConstants.directionType,
                    getFunc = function() return LUIE.CombatText.SV.animation.outgoing.directionType end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.outgoing.directionType = v end,
                    default = LUIE.CombatText.D.animation.outgoing.directionType,
                },
                {--OUTGOING ICON POSITION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT_TP),
                    choices = LUIE.CombatTextConstants.iconSide,
                    getFunc = function() return LUIE.CombatText.SV.animation.outgoingIcon end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.outgoingIcon = v end,
                    default = LUIE.CombatText.D.animation.outgoingIcon,
                },
                {--TEST BUTTON
                    type = "button",
                    name = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST_TP),
                    func = function()
                        CALLBACK_MANAGER:FireCallbacks(LUIE.CombatTextConstants.eventType.COMBAT, LUIE.CombatTextConstants.combatType.INCOMING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                        CALLBACK_MANAGER:FireCallbacks(LUIE.CombatTextConstants.eventType.COMBAT, LUIE.CombatTextConstants.combatType.OUTGOING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                    end,
                },
            },
        }
---------------------------------------------------------------------------------------------------------------------------------------
    --//THROTTLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
        optionsDataCombatText[#optionsDataCombatText +1] = {
            type = "submenu",
            name = GetString(SI_LUIE_LAM_CT_THROTTLE_HEADER),
            controls = {
                {
                    type = "description",
                    text = GetString(SI_LUIE_LAM_CT_THROTTLE_DESCRIPTION),
                },
                {--DAMAGE
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_DAMAGE_TP),
                    min     = 0,
                    max     = 500,
                    step    = 50,
                    getFunc = function() return LUIE.CombatText.SV.throttles.damage end,
                    setFunc = function(v) LUIE.CombatText.SV.throttles.damage = v end,
                    default = LUIE.CombatText.D.throttles.damage,
                },
                {--DOT
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_DOT_TP),
                    min     = 0,
                    max     = 500,
                    step    = 50,
                    getFunc = function() return LUIE.CombatText.SV.throttles.dot end,
                    setFunc = function(v) LUIE.CombatText.SV.throttles.dot = v end,
                    default = LUIE.CombatText.D.throttles.dot,
                },
                {--HEALING
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_HEALING_TP),
                    min     = 0,
                    max     = 500,
                    step    = 50,
                    getFunc = function() return LUIE.CombatText.SV.throttles.healing end,
                    setFunc = function(v) LUIE.CombatText.SV.throttles.healing = v end,
                    default = LUIE.CombatText.D.throttles.healing,
                },
                {--HOT
                    type    = "slider",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_HOT_TP),
                    min     = 0,
                    max     = 500,
                    step    = 50,
                    getFunc = function() return LUIE.CombatText.SV.throttles.hot end,
                    setFunc = function(v) LUIE.CombatText.SV.throttles.hot = v end,
                    default = LUIE.CombatText.D.throttles.hot,
                },
                {--THROTTLE TRAILER
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showThrottleTrailer end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showThrottleTrailer = v end,
                    default = LUIE.CombatText.D.toggles.showThrottleTrailer,
                },
                {--CRITS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_THROTTLE_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showThrottleTrailer end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.throttleCriticals = v end,
                    default = LUIE.CombatText.D.toggles.throttleCriticals,
                },
            },
        }

    LAM2:RegisterAddonPanel('LUIEAddonOptions', panelData)
    LAM2:RegisterOptionControls('LUIEAddonOptions', optionsData)

    if LUIE.SV.UnitFrames_Enabled then
        LAM2:RegisterAddonPanel('LUIEUnitFramesOptions', panelDataUnitFrames)
        LAM2:RegisterOptionControls('LUIEUnitFramesOptions', optionsDataUnitFrames)
    end
    
    if LUIE.SV.ChatAnnouncements_Enable then
        LAM2:RegisterAddonPanel('LUIEChatAnnouncementOptions', panelDataChatAnnouncements)
        LAM2:RegisterOptionControls('LUIEChatAnnouncementOptions', optionsDataChatAnnouncements)
    end
    
    if LUIE.SV.SpellCastBuff_Enable then
        LAM2:RegisterAddonPanel('LUIEBuffsAndDebuffsOptions', panelDataBuffsDebuffs)
        LAM2:RegisterOptionControls('LUIEBuffsAndDebuffsOptions', optionsDataBuffsDebuffs)
    end
    
    if LUIE.SV.CombatInfo_Enabled then
        LAM2:RegisterAddonPanel('LUIECombatInfoOptions', panelDataCombatInfo)
        LAM2:RegisterOptionControls('LUIECombatInfoOptions', optionsDataCombatInfo)
    end
    
    if LUIE.SV.CombatText_Enabled then
        LAM2:RegisterAddonPanel('LUIECombatTextOptions', panelDataCombatText)
        LAM2:RegisterOptionControls('LUIECombatTextOptions', optionsDataCombatText)
    end
    
end
