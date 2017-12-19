local strformat = zo_strformat

-- Create Settings Menu
function LUIE_CreateSettings()
    -- Load LibAddonMenu
    local LAM2  = LibStub("LibAddonMenu-2.0")
    local LMP           = LibStub("LibMediaProvider-1.0")
    local L             = CombatCloudLocalization
    local D             = LUIE.CombatText.D

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
    
    local championOptions = {
    
    "Show Above Cap",
    "Limit to Cap",
    
    }
    
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
        slashCommand = "/luiframes",
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
        slashCommand = "/luici",
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
        name = "Reload UI",
        tooltip = GetString(SI_LUIE_LAM_RELOADUI),
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
                -- TEMP DESCRIPTION INFO PANEL (NO LOCALIZATION NEEDED)
                type = "description",
                text = "Displays a small panel with potentially important information on it. This feature may be significantly overhauled in the future.",
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
        name = strformat("\t\t<<1>>", GetString(SI_LUIE_LAM_TIMESTAMP)),
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
        name = strformat("\t\t<<1>>", GetString(SI_LUIE_LAM_TIMESTAMPFORMAT)),
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
        name = "Hide XP Bar Popup",
        tooltip = "When gaining experience from Discovery, Boss Kills, or Skill Line updates, the XP bar will no longer popup. Useful if you have a custom UI element in that corner of the screen and don't want it to be overlapped.",
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
    -- Slash Commands description
    optionsData[#optionsData + 1] = {
        type = "description",
        text = strformat("<<1>>\n<<2>>\n<<3>>",
               GetString(SI_LUIE_LAM_SLASHCMDSHEADER_GENERAL),
               GetString(SI_LUIE_LAM_SLASHCMDS_TRADE),
               GetString(SI_LUIE_LAM_SLASHCMDS_HOME)),
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
        name = "Reload UI",
        tooltip = GetString(SI_LUIE_LAM_RELOADUI),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_QUICK)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_FLASH)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_DESAT)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_COLOR)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_ANIMATION)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_LABEL)),
        tooltip = GetString(SI_LUIE_LAM_CI_BAR_LABEL_TP),
        getFunc = function() return LUIE.CombatInfo.SV.BarShowLabel end,
        setFunc = function(value) LUIE.CombatInfo.SV.BarShowLabel = value LUIE.CombatInfo.ResetBarLabel() end,
        width = "full",
        default = LUIE.CombatInfo.D.BarShowLabel,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled) ) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "slider",
        name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
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
        name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
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
        name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
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
        name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
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
        name = zo_strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
        tooltip = GetString(SI_LUIE_LAM_CI_POTION_COLOR_TP),
        getFunc = function() return LUIE.CombatInfo.SV.PotionTimerColor end,
        setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerColor = value end,
        width = "full",
        default = LUIE.CombatInfo.D.PotionTimerColor,
        disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
    }
    
    optionsDataCombatInfo[#optionsDataCombatInfo + 1] = {
        type = "checkbox",
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
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
        name = "Reload UI",
        tooltip = GetString(SI_LUIE_LAM_RELOADUI),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HidePlayerBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HidePlayerBuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HidePlayerBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HidePlayerDebuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HidePlayerDebuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HidePlayerDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetBuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetDebuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetDebuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            }
            optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_VERT)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_HORIZ)),
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
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER)),
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
        name = "Reload UI",
        tooltip = GetString(SI_LUIE_LAM_RELOADUI),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }
    -- CA Header
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_CI_COMMON_HEADER),
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
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Notification Color
        type = "colorpicker",
        name = "Notification Color (Unimplemented)",
        tooltip = "This message will be used to colorize various generic notification messages that are not Social/Guild related or error messages.",
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.NotificationColor) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.NotificationColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not LUIE.TodoLater end,
        default = {r=LUIE.ChatAnnouncements.D.NotificationColor[1], g=LUIE.ChatAnnouncements.D.NotificationColor[2], b=LUIE.ChatAnnouncements.D.NotificationColor[3]}
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Currency/Loot Message Color
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR),
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CurrencyColor) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CurrencyColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable or LUIE.ChatAnnouncements.SV.CurrencyContextColor end,
        default = {r=LUIE.ChatAnnouncements.D.CurrencyColor[1], g=LUIE.ChatAnnouncements.D.CurrencyColor[2], b=LUIE.ChatAnnouncements.D.CurrencyColor[3]}
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Use Context Color for Currency/Loot Messages
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT),
        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT_TP),
        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyContextColor end,
        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyContextColor = value end,
        width = "full",
        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
        default = LUIE.ChatAnnouncements.D.CurrencyContextColor,
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Positive Change Color
        type = "colorpicker",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORUP)),
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CurrencyColorUp) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CurrencyColorUp = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
        default = {r=LUIE.ChatAnnouncements.D.CurrencyColorUp[1], g=LUIE.ChatAnnouncements.D.CurrencyColorUp[2], b=LUIE.ChatAnnouncements.D.CurrencyColorUp[3]}
    }
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        -- Negative Change Color
        type = "colorpicker",
        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORDOWN)),
        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CurrencyColorDown) end,
        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CurrencyColorDown = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
        width = "full",
        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
        default = {r=LUIE.ChatAnnouncements.D.CurrencyColorDown[1], g=LUIE.ChatAnnouncements.D.CurrencyColorDown[2], b=LUIE.ChatAnnouncements.D.CurrencyColorDown[3]}
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyIcon = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CurrencyIcon,
                    },
                    {
                        -- Show Gold
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyGoldChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyGoldChange = value LUIE.ChatAnnouncements.RegisterGoldEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CurrencyGoldChange,
                    },
                    {
                        -- Show Gold Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CurrencyGoldColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CurrencyGoldColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.CurrencyGoldColor[1], g=LUIE.ChatAnnouncements.D.CurrencyGoldColor[2], b=LUIE.ChatAnnouncements.D.CurrencyGoldColor[3]}
                    },
                    {
                        -- Show Gold Name
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyGoldName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyGoldName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyGoldName,
                    },
                    {
                        -- Show Gold Total Amount
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyGoldShowTotal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyGoldShowTotal = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyGoldShowTotal,
                    },
                    {
                        -- Total Currency Message (Gold)
                        type = "editbox",
                        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageTotalGold end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageTotalGold = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.CurrencyGoldChange and LUIE.ChatAnnouncements.SV.CurrencyGoldShowTotal) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageTotalGold,
                    },
                    {
                        -- Show Gold Threshold
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyGoldFilter end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyGoldFilter = value end,
                        min = 0,
                        max = 10000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyGoldFilter,
                    },
                    {
                        -- Throttle Gold Looted
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyGoldThrottle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyGoldThrottle = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyGoldThrottle,
                    },
                    {
                        -- Hide Gold Spent on AH
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT)),
                        tooltip = strformat("<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT_TP)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyGoldHideAH end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyGoldHideAH = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyGoldHideAH,
                    },
                    {
                        -- Show Alliance Points
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyAPShowChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyAPShowChange = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CurrencyAPShowChange,
                    },
                    {
                        -- Show Alliance Points Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CurrencyAPColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CurrencyAPColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.CurrencyAPColor[1], g=LUIE.ChatAnnouncements.D.CurrencyAPColor[2], b=LUIE.ChatAnnouncements.D.CurrencyAPColor[3]}
                    },
                    {
                        -- Show Alliance Points Name
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyAPName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyAPName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.TotalCurrencyAPName,
                    },
                    {
                        -- Show Alliance Points Total
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyAPShowTotal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyAPShowTotal = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyAPShowTotal,
                    },
                    {
                        -- Total Currency Message (Alliance Points)
                        type = "editbox",
                        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageTotalAP end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageTotalAP = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.CurrencyAPShowChange and LUIE.ChatAnnouncements.SV.CurrencyAPShowTotal) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageTotalAP,
                    },
                    {
                        -- Show Alliance Points Threshold
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyAPFilter end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyAPFilter = value end,
                        min = 0,
                        max = 10000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyAPFilter,
                    },
                    {
                        -- Throttle Alliance Points Earned
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyAPThrottle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyAPThrottle = value end,
                        min = 0,
                        max = 5000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyAPThrottle,
                    },
                    {
                        -- Show Tel Var
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyTVChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyTVChange = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CurrencyTVChange,
                    },
                    {
                        -- Show Tel Var Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CurrencyTVColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CurrencyTVColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.CurrencyTVColor[1], g=LUIE.ChatAnnouncements.D.CurrencyTVColor[2], b=LUIE.ChatAnnouncements.D.CurrencyTVColor[3]}
                    },
                    {
                        -- Show Tel Var Name
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyTVName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyTVName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyTVName,
                    },
                    {
                        -- Show Tel Var Total
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyTVShowTotal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyTVShowTotal = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyTVShowTotal,
                    },
                    {
                        -- Total Currency Message (Tel Var)
                        type = "editbox",
                        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageTotalTV end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageTotalTV = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.CurrencyAPShowChange and LUIE.ChatAnnouncements.SV.CurrencyTVShowTotal) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageTotalTV,
                    },
                    {
                        -- Show Tel Var Stones Threshold
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyTVFilter end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyTVFilter = value end,
                        min = 0,
                        max = 10000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyTVFilter,
                    },
                    {
                        -- Throttle Tel Var Stones Looted
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyTVThrottle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyTVThrottle = value end,
                        min = 0,
                        max = 5000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyTVThrottle,
                    },
                    {
                        -- Show Writ Vouchers
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyWVChange end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyWVChange = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CurrencyWVChange,
                    },
                    {
                        -- Show Writ Vouchers Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERCOLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CurrencyWVColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CurrencyWVColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.CurrencyWVColor[1], g=LUIE.ChatAnnouncements.D.CurrencyWVColor[2], b=LUIE.ChatAnnouncements.D.CurrencyWVColor[3]}
                    },
                    {
                        -- Show Writ Vouchers Name
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyWVName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyWVName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyWVName,
                    },
                    {
                        -- Show Writ Vouchers Total
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyWVShowTotal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyWVShowTotal = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyWVShowTotal,
                    },
                    {
                        -- Total Currency Message (Writ Vouchers)
                        type = "editbox",
                        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG)),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageTotalWV end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageTotalWV = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.CurrencyWVChange and LUIE.ChatAnnouncements.SV.CurrencyWVShowTotal) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageTotalWV,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageReceive end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageReceive = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageReceive,
                    },
                    {
                        -- Loot Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageLoot end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageLoot = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageLoot,
                    },
                    {
                        -- Earned Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageEarn end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageEarn = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageEarn,
                    },
                    {
                        -- Spend Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageSpend end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageSpend = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageSpend,
                    },
                    {
                        -- Lost Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageLost end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageLost = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageLost,
                    },
                    {
                        -- Steal
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageSteal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageSteal = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageSteal,
                    },
                    {
                        -- Pickpocket Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessagePickpocket end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessagePickpocket = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessagePickpocket,
                    },
                    {
                        -- Bounty Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageBounty end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageBounty = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageBounty,
                    },
                    {
                        -- Confiscate Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageConfiscate end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageConfiscate = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageConfiscate,
                    },
                    {
                        -- Repair Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageRepair end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageRepair = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageRepair,
                    },
                    {
                        -- Trader Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageTrader end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageTrader = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageTrader,
                    },
                    {
                        -- Listing Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageListing end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageListing = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageListing,
                    },
                    {
                        -- Trade Message (In)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageTradeIn end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageTradeIn = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageTradeIn,
                    },
                    {
                        -- Trade Message (Out)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageTradeOut end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageTradeOut = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageTradeOut,
                    },
                    {
                        -- Mail Message (In)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageMailIn end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageMailIn = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageMailIn,
                    },
                    {
                        -- Mail Message (Out)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageMailOut end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageMailOut = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageMailOut,
                    },
                    {
                        -- Mail Message (COD Payment)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILCOD),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILCOD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageMailCOD end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageMailCOD = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageMailCOD,
                    },
                    {
                        -- Mail Message (Postage)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_POSTAGE),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_POSTAGE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessagePostage end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessagePostage = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessagePostage,
                    },
                    {
                        -- Deposit Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageDeposit end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageDeposit = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageDeposit,
                    },
                    {
                        -- Withdraw Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageWithdraw end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageWithdraw = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageWithdraw,
                    },
                    {
                        -- Deposit Guild Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageDepositGuild end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageDepositGuild = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageDepositGuild,
                    },
                    {
                        -- Withdraw Guild Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageWithdrawGuild end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageWithdrawGuild = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageWithdrawGuild,
                    },
                    {
                        -- Stable Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageStable end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageStable = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageStable,
                    },
                    {
                        -- Storage Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageStorage end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageStorage = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageStorage,
                    },
                    {
                        -- Wayshrine Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageWayshrine end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageWayshrine = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageWayshrine,
                    },
                    {
                        -- Unstuck Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageUnstuck end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageUnstuck = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageUnstuck,
                    },
                    {
                        -- Attributes Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageAttributes end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageAttributes = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageAttributes,
                    },
                    {
                        -- Champion Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageChampion end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageChampion = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageChampion,
                    },
                    {
                        -- Morphs Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageMorphs end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageMorphs = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageMorphs,
                    },
                    {
                        -- Skills Message
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS),
                        tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CurrencyMessageSkills end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CurrencyMessageSkills = value end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and
                            (
                                LUIE.ChatAnnouncements.SV.CurrencyGoldChange or
                                LUIE.ChatAnnouncements.SV.CurrencyAPShowChange or
                                LUIE.ChatAnnouncements.SV.CurrencyTVChange or
                                LUIE.ChatAnnouncements.SV.CurrencyWVChange or
                                LUIE.SV.ChatAnnouncements_Enable
                            )) end,
                        default = LUIE.ChatAnnouncements.D.CurrencyMessageSkills,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootIcons end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootIcons = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootIcons,
                    },
                    {
                        -- Show Armor Type
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowArmorType end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowArmorType = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootShowArmorType,
                    },
                    {
                        -- Show Item Style
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowStyle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowStyle = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootShowStyle,
                    },
                    {
                        -- Show Item Trait
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowTrait end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowTrait = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootShowTrait,
                    },
                    {
                        -- Show loot total
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootTotal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootTotal = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootTotal,
                    },
                    {
                        -- Loot total string
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootTotalString end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootTotalString = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.LootTotal and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootTotalString,
                    },
                    
                    {
                        -- Show looted items
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.Loot end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.Loot = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.Loot,
                    },
                    {
                        -- Show notable loot
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootOnlyNotable end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootOnlyNotable = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootOnlyNotable,
                    },
                    {
                        -- Show group loot
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootGroup end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootGroup = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootGroup,
                    },
                    {
                        -- Hide annoying items
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootBlacklist end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootBlacklist = value end,
                        width = "full",
                        warning = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_WARNING),
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootBlacklist,
                    },
                    
                    {
                        -- Hide Trash Quality Items
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootNotTrash end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootNotTrash = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootNotTrash,
                    },
                    
                    {
                        -- Show Confiscated Items
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LootConfiscateD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LootConfiscateD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootConfiscate end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootConfiscate = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootConfiscate,
                    },
                    {
                        -- Show Destroyed Items
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowDestroy end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowDestroy = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootShowDestroy,
                    },
                    {
                        -- Show Lockpick Break
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowLockpick end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowLockpick = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootShowLockpick,
                    },
                    
                    {
                        -- Show Quest Loot (Add)
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootQuestAdd end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootQuestAdd = value LUIE.ChatAnnouncements.RegisterLootEvents() LUIE.ChatAnnouncements.AddQuestItemsToIndex() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootQuestAdd,
                    },
                    {
                        -- Show Quest Loot (Remove)
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootQuestRemove end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootQuestRemove = value LUIE.ChatAnnouncements.RegisterLootEvents() LUIE.ChatAnnouncements.AddQuestItemsToIndex() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootQuestRemove,
                    },
                    
                    {
                        -- Show Vendor Inventory Changes
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootVendor end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootVendor = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootVendor,
                    },
                    {
                        -- Merge Currency & Loot Message
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootVendorCurrency end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootVendorCurrency = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.LootVendor and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootVendorCurrency,
                    },
                    {
                        -- Loot Vendor Total Items
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootVendorTotalItems end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootVendorTotalItems = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.LootVendor and LUIE.ChatAnnouncements.SV.LootTotal and LUIE.ChatAnnouncements.SV.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootVendorTotalItems,
                    },
                    {
                        -- Loot Vendor Total Currency
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootVendorTotalCurrency end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootVendorTotalCurrency = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.LootVendor and LUIE.ChatAnnouncements.SV.CurrencyGoldShowTotal and LUIE.ChatAnnouncements.SV.CurrencyAPShowTotal and LUIE.ChatAnnouncements.SV.CurrencyTVShowTotal and LUIE.ChatAnnouncements.SV.CurrencyWVShowTotal and LUIE.ChatAnnouncements.SV.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootVendorTotalCurrency,
                    },
                    {
                        -- Show Bank Inventory Changes
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootBank end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootBank = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootBank,
                    },
                    {
                        -- Show Craft
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootCraft end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootCraft = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootCraft,
                    },
                    {
                        -- Show Materials consumed when crafting
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowCraftUse end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowCraftUse = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.LootCraft and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LootShowCraftUse,
                    },
                    {
                        -- Show Mail Inventory Changes
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL_TP),
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
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootTrade end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootTrade = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootTrade,
                    },
                    {
                        -- Show Disguise Equip
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootShowDisguise end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootShowDisguise = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootShowDisguise,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageLoot end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageLoot = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageLoot,
                    },
                    {
                        -- Loot Message (Receive)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RECEIVE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RECEIVE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageReceive end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageReceive = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageReceive,
                    },
                    {
                        -- Loot Message (Steal)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_STEAL),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_STEAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageSteal end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageSteal = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageSteal,
                    },
                    {
                        -- Loot Message (Pickpocket)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_PICKPOCKET),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_PICKPOCKET_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessagePickpocket end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessagePickpocket = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessagePickpocket,
                    },
                    {
                        -- Loot Message (Confiscate)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CONFISCATE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CONFISCATE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageConfiscate end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageConfiscate = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageConfiscate,
                    },
                    
                    {
                        -- Loot Message (TradeIn)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEIN),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEIN_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageTradeIn end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageTradeIn = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageTradeIn,
                    },
                    {
                        -- Loot Message (TradeOut)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEOUT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEOUT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageTradeOut end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageTradeOut = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageTradeOut,
                    },
                    {
                        -- Loot Message (MailIn)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILIN),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILIN_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageMailIn end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageMailIn = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageMailIn,
                    },
                    {
                        -- Loot Message (MailOut)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILOUT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILOUT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageMailOut end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageMailOut = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageMailOut,
                    },
                    
                    {
                        -- Loot Message (Deposit)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSIT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSIT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageDeposit end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageDeposit = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageDeposit,
                    },
                    {
                        -- Loot Message (Withdraw)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAW),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAW_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageWithdraw end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageWithdraw = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageWithdraw,
                    },
                    
                    {
                        -- Loot Message (Deposit Guild)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSITGUILD),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSITGUILD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageDepositGuild end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageDepositGuild  = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageDepositGuild ,
                    },
                    {
                        -- Loot Message (Withdraw Guild)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAWGUILD),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAWGUILD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageWithdrawGuild  end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageWithdrawGuild  = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageWithdrawGuild ,
                    },
                    {
                        -- Loot Message (Buy)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_VALUE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_VALUE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageBuy end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageBuy = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageBuy,
                    },                    
                    {
                        -- Loot Message (Buy) No Value
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageBuyNoV end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageBuyNoV = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageBuyNoV,
                    },
                    {
                        -- Loot Message (Buyback)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_VALUE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_VALUE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageBuyback end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageBuyback = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageBuyback,
                    },
                    {
                        -- Loot Message (Buyback) No Value
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageBuybackNoV end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageBuybackNoV = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageBuybackNoV,
                    },
                    {
                        -- Loot Message (Sell)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_VALUE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_VALUE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageSell end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageSell = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageSell,
                    },
                    {
                        -- Loot Message (Sell) No Value
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageSellNoV end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageSellNoV = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageSellNoV,
                    },
                    {
                        -- Loot Message (Fence)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_FENCE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_FENCE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageFence end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageFence = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageFence,
                    },
                    {
                        -- Loot Message (Launder)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LAUNDER),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LAUNDER_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageLaunder end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageLaunder = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageLaunder,
                    },
                    {
                        -- Loot Message (Use)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_USE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_USE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageUse end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageUse = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageUse,
                    },
                    {
                        -- Loot Message (Craft)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CRAFT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_CRAFT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageCraft end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageCraft = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageCraft,
                    },
                    {
                        -- Loot Message (Extract)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_EXTRACT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_EXTRACT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageExtract end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageExtract = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageExtract,
                    },
                    {
                        -- Loot Message (Upgrade)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageUpgrade end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageUpgrade = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageUpgrade,
                    },
                    {
                        -- Loot Message (Upgrade)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_FAIL),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_FAIL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageUpgradeFail end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageUpgradeFail = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageUpgradeFail,
                    },                         
                    {
                        -- Loot Message (Refine)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REFINE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REFINE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageRefine end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageRefine = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageRefine,
                    },  
                    {
                        -- Loot Message (Deconstruct)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DECONSTRUCT),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DECONSTRUCT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageDeconstruct end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageDeconstruct = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageDeconstruct,
                    },  
                    {
                        -- Loot Message (Research)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RESEARCH),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_RESEARCH_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageResearch end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageResearch = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageResearch,
                    },  
                    {
                        -- Loot Message (Destroy)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DESTROY),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DESTROY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageDestroy end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageDestroy = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageDestroy,
                    },  
                    {
                        -- Loot Message (Lockpick)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LOCKPICK),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_LOCKPICK_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageLockpick end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageLockpick = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageLockpick,
                    },
                    {
                        -- Loot Message Removed (Quest)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REMOVE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_REMOVE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageRemove end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageRemove = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageRemove,
                    },
                    {
                        -- Loot Message Group
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_GROUP),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_GROUP_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageGroup end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageGroup = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageGroup,
                    },
                    {
                        -- Loot Message (Disguise Equip)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_EQUIP),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_EQUIP_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageDisguiseEquip end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageDisguiseEquip = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageDisguiseEquip,
                    },     
                    {
                        -- Loot Message (Disguise Remove)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_REMOVE),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_REMOVE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageDisguiseRemove end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageDisguiseRemove = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageDisguiseRemove,
                    },     
                    {
                        -- Loot Message (Disguise Destroy)
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_DESTROY),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_DESTROY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LootMessageDisguiseDestroy end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LootMessageDisguiseDestroy = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LootMessageDisguiseDestroy,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceEnlightenedCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceEnlightenedCA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ExperienceEnlightenedCA,
                    },
                    {
                        -- Enlightenment (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceEnlightenedCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceEnlightenedCSA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ExperienceEnlightenedCSA,
                    },
                    {
                        -- Enlightenment (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceEnlightenedAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceEnlightenedAlert = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ExperienceEnlightenedAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceLevelUpCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceLevelUpCA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ExperienceLevelUpCA,
                    },
                    {
                        -- Level Up (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ExperienceLevelUpCSA,
                    },
                    {
                        -- Level Up CSA Expanded
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSAExpand end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSAExpand = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSA and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceLevelUpCSAExpand,
                    },
                    {
                        -- Level Up (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceLevelUpAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceLevelUpAlert = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.ExperienceLevelUpAlert,
                    },
                    {
                        -- Show Level Icon on Level Up
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceLevelUpIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceLevelUpIcon = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.ExperienceLevelUpCA or LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSA or LUIE.ChatAnnouncements.SV.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceExperienceLevelUpIcon,
                    },
                    {
                        -- Experience Level Up Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_LEVELUP_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.ExperienceLevelUpColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.ExperienceLevelUpColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.ExperienceLevelUpCA or LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSA or LUIE.ChatAnnouncements.SV.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.ExperienceLevelUpColor[1], g=LUIE.ChatAnnouncements.D.ExperienceLevelUpColor[2], b=LUIE.ChatAnnouncements.D.ExperienceLevelUpColor[3]}
                    },
                    {
                        -- Color Level by Context
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceLevelColorByLevel end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceLevelColorByLevel = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.ExperienceLevelUpCA or LUIE.ChatAnnouncements.SV.ExperienceLevelUpCSA or LUIE.ChatAnnouncements.SV.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceLevelColorByLevel,
                    },
                    
                    {
                    type = "header",
                    name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_RESPEC),
                    width = "full,"
                    },
                    
                    {
                        -- Respec Notification (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationRespecCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationRespecCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationRespecCA,
                    },
                    {
                        -- Respec Notification (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationRespecCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationRespecCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationRespecCSA,
                    },
                    {
                        -- Respec Notification (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationRespecAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationRespecAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationRespecAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.Experience end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.Experience = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.Experience,
                    },
                    {
                        -- Show Experience Icon
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceIcon = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceIcon,
                    },
                    {
                        -- Experience Message Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORMESSAGE)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.ExperienceColorMessage) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.ExperienceColorMessage = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.ExperienceColorMessage[1], g=LUIE.ChatAnnouncements.D.ExperienceColorMessage[2], b=LUIE.ChatAnnouncements.D.ExperienceColorMessage[3]}
                    },
                    {
                        -- Experience Name Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORNAME)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.ExperienceColorName) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.ExperienceColorName = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.ExperienceColorName[1], g=LUIE.ChatAnnouncements.D.ExperienceColorName[2], b=LUIE.ChatAnnouncements.D.ExperienceColorName[3]}
                    },
                    {
                        -- Context Name for Experience Gain
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_MESSAGE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_MESSAGE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceMessage end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceMessage = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceMessage,
                    },
                    {
                        -- Name for Experience Gain
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_NAME)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_NAME_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceName = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceName,
                    },
                    {
                        -- Hide Experience from Kills
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceHideCombat end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceHideCombat = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceHideCombat,
                    },
                    {
                        -- Combat Experience Gain Filter Threshold
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD_TP),
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
                        -- Throttle Experience gained in combat
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT)),
                        tooltip = GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ExperienceThrottle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ExperienceThrottle = value end,
                        min = 0,
                        max = 5000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ExperienceThrottle,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillPointCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillPointCA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillPointCA,
                    },
                    {
                        -- Show Skill Points Updated CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillPointCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillPointCSA = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillPointCSA,
                    },
                    {
                        -- Show Skill Points Updated Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillPointAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillPointAlert = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillPointAlert,
                    },
                    {
                        -- Skill Point Color 1
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR1)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillPointColor1) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillPointColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not ( LUIE.ChatAnnouncements.SV.SkillPointCA or LUIE.ChatAnnouncements.SV.SkillPointCSA or LUIE.ChatAnnouncements.SV.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillPointColor1[1], g=LUIE.ChatAnnouncements.D.SkillPointColor1[2], b=LUIE.ChatAnnouncements.D.SkillPointColor1[3]}
                    },
                    {
                        -- Skill Point Color 2
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR2)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillPointColor2) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillPointColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not ( LUIE.ChatAnnouncements.SV.SkillPointCA or LUIE.ChatAnnouncements.SV.SkillPointCSA or LUIE.ChatAnnouncements.SV.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillPointColor2[1], g=LUIE.ChatAnnouncements.D.SkillPointColor2[2], b=LUIE.ChatAnnouncements.D.SkillPointColor2[3]}
                    },
                    {
                        -- Skyshard Prefix
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillPointSkyshardMsg end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillPointSkyshardMsg = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not ( LUIE.ChatAnnouncements.SV.SkillPointCA or LUIE.ChatAnnouncements.SV.SkillPointCSA or LUIE.ChatAnnouncements.SV.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.SkillPointSkyshardMsg,
                    },
                    {
                        -- Skyshard Brackets
                        type = "dropdown",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET_TP),
                        choices = bracketOptions5,
                        getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.SkillPointBracket] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillPointBracket = bracketOptions5Keys[value] end,
                        width = "full",
                        disabled = function() return not ( LUIE.ChatAnnouncements.SV.SkillPointCA or LUIE.ChatAnnouncements.SV.SkillPointCSA or LUIE.ChatAnnouncements.SV.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.SkillPointBracket
                    },
                    {
                        -- Show Skill Points Updated Partial
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.ShowSkillPointsPartial end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.ShowSkillPointsPartial = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not ( LUIE.ChatAnnouncements.SV.SkillPointCA or LUIE.ChatAnnouncements.SV.SkillPointCSA or LUIE.ChatAnnouncements.SV.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.ShowSkillPointsPartial,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillLineUnlockCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillLineUnlockCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillLineUnlockCA,
                    },
                    {
                        -- Skill Line Unlocked CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillLineUnlockCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillLineUnlockCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillLineUnlockCSA,
                    },
                    {
                        -- Skill Line Unlocked Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillLineUnlockAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillLineUnlockAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillLineUnlockAlert,
                    },
                    {
                        -- Skill Line Icon
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillLineIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillLineIcon = value end,
                        width = "full",
                        disabled = function() return not (
                            LUIE.ChatAnnouncements.SV.SkillLineUnlockCA or
                            LUIE.ChatAnnouncements.SV.SkillLineUnlockCSA or
                            LUIE.ChatAnnouncements.SV.SkillLineUnlockAlert and
                            LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.SkillLineIcon,
                    },
                    {
                        -- Skill Line Progression CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillLineCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillLineCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillLineCA,
                    },
                    {
                        -- Skill Line Progression CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillLineCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillLineCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillLineCSA,
                    },
                    {
                        -- Skill Line Progression Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillLineAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillLineAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillLineAlert,
                    },
                    
                    {
                        -- Skill Ability Progression CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillAbilityCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillAbilityCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillAbilityCA,
                    },
                    {
                        -- Skill Ability Progression CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillAbilityCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillAbilityCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillAbilityCSA,
                    },
                    {
                        -- Skill Ability Progression Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillAbilityAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillAbilityAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillAbilityAlert,
                    },
                    {
                        -- Skill Line Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillLineColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillLineColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (
                            LUIE.ChatAnnouncements.SV.SkillLineUnlockCA or
                            LUIE.ChatAnnouncements.SV.SkillLineUnlockCSA or
                            LUIE.ChatAnnouncements.SV.SkillLineUnlockAlert or
                            LUIE.ChatAnnouncements.SV.SkillLineAlertCA or
                            LUIE.ChatAnnouncements.SV.SkillLineAlertCSA or
                            LUIE.ChatAnnouncements.SV.SkillLineAlertAlert or
                            LUIE.ChatAnnouncements.SV.SkillAbilityCA or
                            LUIE.ChatAnnouncements.SV.SkillAbilityCSA or
                            LUIE.ChatAnnouncements.SV.SkillAbilityAlert and
                            LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillLineColor[1], g=LUIE.ChatAnnouncements.D.SkillLineColor[2], b=LUIE.ChatAnnouncements.D.SkillLineColor[3]}
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildIcon = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildIcon,
                    },
                    
                    {
                        -- Guild Reputation Message Color
                        type = "colorpicker",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGECOLOR),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillGuildColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillGuildColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillGuildColor[1], g=LUIE.ChatAnnouncements.D.SkillGuildColor[2], b=LUIE.ChatAnnouncements.D.SkillGuildColor[3]}
                    },
                    
                    {
                        -- Guild Reputation Message Format
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildMsg end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildMsg = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildMsg,
                    },
                    
                    {
                        -- Guild Reputation Points Name
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildRepName end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildRepName = value LUIE.ChatAnnouncements.RegisterXPEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildRepName,
                    },
                    
                    {
                        -- Skill Fighters Guild
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_FG),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_FG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildFighters end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildFighters = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildFighters,
                    },
                    {
                        -- Guild Skill Point Color FG
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_FG_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillGuildColorFG) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillGuildColorFG = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.SkillGuildFighters) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillGuildColorFG[1], g=LUIE.ChatAnnouncements.D.SkillGuildColorFG[2], b=LUIE.ChatAnnouncements.D.SkillGuildColorFG[3]}
                    },
                    {
                        -- Fighter's Guild Threshold
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD)),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildThreshold end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildThreshold = value end,
                        min = 0,
                        max = 5,
                        step = 1,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.SkillGuildFighters) end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildThreshold,
                    },
                    {
                        -- Fighter's Guild Throttle
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildThrottle end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildThrottle = value end,
                        min = 0,
                        max = 5000,
                        step = 50,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.SkillGuildFighters) end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildThrottle,
                    },
                    {
                        -- Skill Mages Guild
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_MG),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildMages end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildMages = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildMages,
                    },
                    {
                        -- Guild Skill Point Color MG
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_MG_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillGuildColorMG) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillGuildColorMG = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.SkillGuildMages) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillGuildColorMG[1], g=LUIE.ChatAnnouncements.D.SkillGuildColorMG[2], b=LUIE.ChatAnnouncements.D.SkillGuildColorMG[3]}
                    },
                    {
                        -- Skill Undaunted
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_MG),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildUndaunted end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildUndaunted = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildUndaunted,
                    },
                    {
                        -- Guild Skill Point Color UD
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_UD_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillGuildColorUD) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillGuildColorUD = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.SkillGuildUndaunted) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillGuildColorUD[1], g=LUIE.ChatAnnouncements.D.SkillGuildColorUD[2], b=LUIE.ChatAnnouncements.D.SkillGuildColorUD[3]}
                    },
                    {
                        -- Skill Thieves Guild
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_TG),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_TG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildThieves end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildThieves = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildThieves,
                    },
                    {
                        -- Guild Skill Point Color TG
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_TG_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillGuildColorTG) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillGuildColorTG = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.SkillGuildThieves) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillGuildColorTG[1], g=LUIE.ChatAnnouncements.D.SkillGuildColorTG[2], b=LUIE.ChatAnnouncements.D.SkillGuildColorTG[3]}
                    },
                    {
                        -- Skill Dark Brotherhood
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_DB),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_DB_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildDarkBrotherhood end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildDarkBrotherhood = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildDarkBrotherhood,
                    },
                    {
                        -- Guild Skill Point Color DB
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_DB_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.SkillGuildColorDB) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.SkillGuildColorDB = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.SkillGuildDarkBrotherhood) end,
                        default = {r=LUIE.ChatAnnouncements.D.SkillGuildColorDB[1], g=LUIE.ChatAnnouncements.D.SkillGuildColorDB[2], b=LUIE.ChatAnnouncements.D.SkillGuildColorDB[3]}
                    },
                    
                    {
                        -- Skill Guild Alert
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT),
                        tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.SkillGuildAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.SkillGuildAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.SkillGuildAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CollectibleCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CollectibleCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CollectibleCA,
                    },
                    {
                        -- Show Collectibles Unlocked CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CollectibleCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CollectibleCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CollectibleCSA,
                    },
                    {
                        -- Show Collectibles Unlocked Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CollectibleAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CollectibleAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.CollectibleAlert,
                    },
                    
                    {
                        -- Collectible Icon
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON)),
                        tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CollectibleIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CollectibleIcon = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CollectibleCA or LUIE.ChatAnnouncements.SV.CollectibleCSA or LUIE.ChatAnnouncements.SV.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CollectibleIcon,
                    },
                    
                    {
                        -- Collectible Color 1
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_ONE)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CollectibleColor1) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CollectibleColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CollectibleCA or LUIE.ChatAnnouncements.SV.CollectibleCSA or LUIE.ChatAnnouncements.SV.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.CollectibleColor1[1], g=LUIE.ChatAnnouncements.D.CollectibleColor1[2], b=LUIE.ChatAnnouncements.D.CollectibleColor1[3]}
                    },
                    {
                        -- Collectible Color 2
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_TWO)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.CollectibleColor2) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.CollectibleColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CollectibleCA or LUIE.ChatAnnouncements.SV.CollectibleCSA or LUIE.ChatAnnouncements.SV.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.CollectibleColor2[1], g=LUIE.ChatAnnouncements.D.CollectibleColor2[2], b=LUIE.ChatAnnouncements.D.CollectibleColor2[3]}
                    },
                    {
                        -- Collectible Message Prefix
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX)),
                        tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CollectiblePrefix end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CollectiblePrefix = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CollectibleCA or LUIE.ChatAnnouncements.SV.CollectibleCSA or LUIE.ChatAnnouncements.SV.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CollectiblePrefix,
                    },
                    {
                        -- Collectible Bracket Options
                        type = "dropdown",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET)),
                        tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET_TP),
                        choices = bracketOptions5,
                        getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.CollectibleBracket] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CollectibleBracket = bracketOptions5Keys[value] end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CollectibleCA or LUIE.ChatAnnouncements.SV.CollectibleCSA or LUIE.ChatAnnouncements.SV.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CollectibleBracket
                    },
                    {
                        -- Collectible Category
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY)),
                        tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.CollectibleCategory end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.CollectibleCategory = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.CollectibleCA or LUIE.ChatAnnouncements.SV.CollectibleCSA or LUIE.ChatAnnouncements.SV.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.CollectibleCategory,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LorebookCA,
                    },
                    {
                        -- Show Lorebooks (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LorebookCSA,
                    },
                    {
                        -- Show Lorebooks (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LorebookAlert,
                    },
                    
                    {
                        -- Show Lorebook Collection Complete (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookCollectionCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookCollectionCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LorebookCollectionCA,
                    },
                    {
                        -- Show Lorebook Collection Complete (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookCollectionCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookCollectionCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LorebookCollectionCSA,
                    },
                    {
                        -- Show Lorebook Collection Complete (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookCollectionAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookCollectionAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.LorebookCollectionAlert,
                    },
                    
                    {
                        -- Lorebooks Icon
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookIcon = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LorebookIcon,
                    },
                    {
                        -- Lorebooks Color 1
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR1)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.LorebookColor1) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.LorebookColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.LorebookColor1[1], g=LUIE.ChatAnnouncements.D.LorebookColor1[2], b=LUIE.ChatAnnouncements.D.LorebookColor1[3]}
                    },
                    {
                        -- Lorebooks Color 2
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR2)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.LorebookColor2) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.LorebookColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.LorebookColor2[1], g=LUIE.ChatAnnouncements.D.LorebookColor2[2], b=LUIE.ChatAnnouncements.D.LorebookColor2[3]}
                    },
                    {
                        -- Lorebooks Prefix 1
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookPrefix1 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookPrefix1 = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LorebookPrefix1,
                    },
                    {
                        -- Lorebooks Prefix 2
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookPrefix2 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookPrefix2 = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LorebookPrefix2,
                    },
                    {
                        -- Lorebooks Collection Prefix
                        type = "editbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookCollectionPrefix end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookCollectionPrefix = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LorebookCollectionPrefix,
                    },
                    {
                        -- Lorebooks Bracket Options
                        type = "dropdown",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET)),
                        choices = bracketOptions5,
                        tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET_TP),
                        getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.LorebookBracket] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookBracket = bracketOptions5Keys[value] end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LorebookBracket
                    },
                    {
                        -- Lorebooks Category
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookCategory end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookCategory = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LorebookCategory,
                    },
                    {
                        -- Show hidden books
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.LorebookShowHidden end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.LorebookShowHidden = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.LorebookCA or
                        LUIE.ChatAnnouncements.SV.LorebookCSA or
                        LUIE.ChatAnnouncements.SV.LorebookAlert or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionCSA or
                        LUIE.ChatAnnouncements.SV.LorebookCollectionAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.LorebookShowHidden,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementUpdateCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementUpdateCA = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.AchievementUpdateCA,
                    },
                    {
                        -- SHOW ACHIEVEMENT UPDATE ALERT
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementUpdateAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementUpdateAlert = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.AchievementUpdateAlert,
                    },
                    {
                        -- Show Detailed Achievement Info
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO)),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementDetails end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementDetails = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementDetails,
                    },
                    {
                        -- Achievements Step Size
                        type = "slider",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE_TP),
                        min = 0, max = 50, step = 1,
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementStep end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementStep = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementStep,
                    },
                    
                    {
                        -- Enable Achievement Complete CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCompleteCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCompleteCA = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.AchievementCompleteCA,
                    },
                    {
                        -- Enable Achievement Complete CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCompleteCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCompleteCSA = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.AchievementCompleteCSA,
                    },
                    {
                        -- Enable Achievement Complete Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCompleteAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCompleteAlert = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.AchievementCompleteAlert,
                    },
                    {
                        -- Show 100% Completion on complete event
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT)),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCompPercentage end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCompPercentage = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementCompPercentage,
                    },
                    {
                        -- Show Achievement Icon
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementIcon = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementIcon,
                    },
                    {
                        -- Achievement Message Color
                        type = "colorpicker",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR1),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.AchievementColor1) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.AchievementColor1 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.AchievementColor1[1], g=LUIE.ChatAnnouncements.D.AchievementColor1[2], b=LUIE.ChatAnnouncements.D.AchievementColor1[3]}
                    },
                    {
                        -- Achievement Message Color
                        type = "colorpicker",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR2),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.AchievementColor2) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.AchievementColor2 = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.AchievementColor2[1], g=LUIE.ChatAnnouncements.D.AchievementColor2[2], b=LUIE.ChatAnnouncements.D.AchievementColor2[3]}
                    },
                    {
                        -- Context Name for Achievement Progress
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementProgressMsg end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementProgressMsg = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementProgressMsg,
                    },
                    {
                        -- Context Name for Achievement Completion
                        type = "editbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCompleteMsg end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCompleteMsg = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementCompleteMsg,
                    },
                    {
                        -- Show Achievement Category
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementCategory,
                    },
                    {
                        -- Show Achievement Subcategory
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementSubcategory end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementSubcategory = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementSubcategory,
                    },
                    
                    {
                        -- Prefix Bracket
                        type = "dropdown",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET_TP),
                        choices = bracketOptions5,
                        getFunc = function() return bracketOptions5[LUIE.ChatAnnouncements.SV.AchievementBracketOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementBracketOptions = bracketOptions5Keys[value] end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementBracketOptions
                    },
                    {
                        -- Category & Subcategory Bracket Options
                        type = "dropdown",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET_TP),
                        choices = bracketOptions4,
                        getFunc = function() return bracketOptions4[LUIE.ChatAnnouncements.SV.AchievementCatBracketOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCatBracketOptions = bracketOptions4Keys[value] end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCategory or LUIE.ChatAnnouncements.SV.AchievementSubcategory) or not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementCatBracketOptions
                    },
                    {
                        -- Color Achievement Progress
                        type = "checkbox",
                        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS),
                        tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementColorProgress end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementColorProgress = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.AchievementColorProgress,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory1 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory1 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory1,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(2)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(2)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory2 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory2 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory2,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(3)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(3)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory3 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory3 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory3,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(4)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(4)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory4 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory4 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory4,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(5)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(5)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory5 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory5 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory5,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(6)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(6)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory6 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory6 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory6,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(7)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(7)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory7 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory7 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory7,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(8)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(8)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory8 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory8 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory8,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(9)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(9)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory9 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory9 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory9,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(10)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(10)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory10 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory10 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory10,
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                    },
                    {
                        -- Enables achievements tracking in %s category
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(11)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(11)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.AchievementCategory11 end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.AchievementCategory11 = value end,
                        width = "full",
                        default = LUIE.ChatAnnouncements.D.AchievementCategory11,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestShareCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestShareCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestShareCA,                   
                    },
                    {
                        -- Show Quest Share Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestShareAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestShareAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestShareAlert,                   
                    },
                    {
                        -- Show Location Discovery (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocDiscoveryCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocDiscoveryCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocDiscoveryCA,                   
                    },
                    {
                        -- Show Location Discovery (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocDiscoveryCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocDiscoveryCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocDiscoveryCSA,                   
                    },
                    {
                        -- Show Location Discovery (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocDiscoveryAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocDiscoveryAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocDiscoveryAlert,                   
                    },
                    {
                        -- Show Location Objective (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocObjectiveCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocObjectiveCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocObjectiveCA,                   
                    },
                    {
                        -- Show Location Objective (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocObjectiveCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocObjectiveCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocObjectiveCSA,                   
                    },
                    {
                        -- Show Location Objective (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocObjectiveAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocObjectiveAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocObjectiveAlert,                   
                    },
                    {
                        -- Show Location Complete (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocCompleteCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocCompleteCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocCompleteCA,                   
                    },
                    {
                        -- Show Location Complete (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocCompleteCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocCompleteCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocCompleteCSA,                   
                    },
                    {
                        -- Show Location Complete (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocCompleteAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocCompleteAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocCompleteAlert,                   
                    },
                    {
                        -- Show Quest Accept (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestAcceptCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestAcceptCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestAcceptCA,                   
                    },
                    {
                        -- Show Quest Accept (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestAcceptCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestAcceptCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestAcceptCSA,                   
                    },
                    {
                        -- Show Quest Accept (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestAcceptAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestAcceptAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestAcceptAlert,                   
                    },
                    {
                        -- Show Quest Complete (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestCompleteCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestCompleteCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestCompleteCA,                   
                    },
                    {
                        -- Show Quest Complete (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestCompleteCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestCompleteCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestCompleteCSA,                   
                    },
                    {
                        -- Show Quest Complete (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestCompleteAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestCompleteAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestCompleteAlert,                   
                    },
                    {
                        -- Show Quest Abandon (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestAbandonCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestAbandonCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestAbandonCA,                   
                    },
                    {
                        -- Show Quest Abandon (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestAbandonCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestAbandonCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestAbandonCSA,                   
                    },
                    {
                        -- Show Quest Abandon (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestAbandonAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestAbandonAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestAbandonAlert,                   
                    },
                    {
                        -- Show Quest Failure (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestFailCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestFailCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestFailCA,                   
                    },
                    {
                        -- Show Quest Failure (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestFailCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestFailCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestFailCSA,                   
                    },
                    {
                        -- Show Quest Failure (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestFailAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestFailAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestFailAlert,                   
                    },
                    {
                        -- Show Quest Objective Updates (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestObjUpdateCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestObjUpdateCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestObjUpdateCA,                   
                    },
                    {
                        -- Show Quest Objective Updates (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestObjUpdateCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestObjUpdateCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestObjUpdateCSA,                   
                    },
                    {
                        -- Show Quest Objective Updates (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestObjUpdateAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestObjUpdateAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestObjUpdateAlert,                   
                    },
                    {
                        -- Show Quest Objective Complete (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestObjCompleteCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestObjCompleteCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestObjCompleteCA,                   
                    },
                    {
                        -- Show Quest Objective Complete (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestObjCompleteCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestObjCompleteCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestObjCompleteCSA,                   
                    },
                    {
                        -- Show Quest Objective Complete (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestObjCompleteAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestObjCompleteAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestObjCompleteAlert,                   
                    },
                    {
                        -- Show Quest Icon
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON)),
                        tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestIcon = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestIcon,
                    },
                    {
                        -- Location Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR1)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.QuestColorLocName) end,
                        setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.QuestColorLocName={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = { r=LUIE.ChatAnnouncements.D.QuestColorLocName[1], g=LUIE.ChatAnnouncements.D.QuestColorLocName[2], b=LUIE.ChatAnnouncements.D.QuestColorLocName[3] },
                    },
                    {
                        -- Location Description Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR2)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.QuestColorLocDescription) end,
                        setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.QuestColorLocDescription={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = { r=LUIE.ChatAnnouncements.D.QuestColorLocDescription[1], g=LUIE.ChatAnnouncements.D.QuestColorLocDescription[2], b=LUIE.ChatAnnouncements.D.QuestColorLocDescription[3] },
                    },
                    {
                        -- Quest Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR3)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.QuestColorName) end,
                        setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.QuestColorName={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = { r=LUIE.ChatAnnouncements.D.QuestColorName[1], g=LUIE.ChatAnnouncements.D.QuestColorName[2], b=LUIE.ChatAnnouncements.D.QuestColorName[3] },
                    },
                    {
                        -- Quest Description Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR4)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.QuestColorDescription) end,
                        setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.QuestColorDescription={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = { r=LUIE.ChatAnnouncements.D.QuestColorDescription[1], g=LUIE.ChatAnnouncements.D.QuestColorDescription[2], b=LUIE.ChatAnnouncements.D.QuestColorDescription[3] },
                    },
                    {
                        -- Show Quest Long String
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG)),
                        tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLong end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLong = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLong,                   
                    },
                    {
                        -- Show POI Completed Long String
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG)),
                        tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.QuestLocLong end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.QuestLocLong = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.QuestLocLong,                   
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.FriendIgnoreCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.FriendIgnoreCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.FriendIgnoreCA,
                    },
                    {
                        -- Show Friend/Ignore Events Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.FriendIgnoreAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.FriendIgnoreAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.FriendIgnoreAlert,
                    },
                    
                    {
                        -- Friend Online/Offline CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.FriendStatusCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.FriendStatusCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.FriendStatusCA,
                    },
                    {
                        -- Friend Online/Offline Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.FriendStatusAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.FriendStatusAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.FriendStatusAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GuildCA,
                    },
                    {
                        -- Show Guild Events Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GuildAlert,
                    },
                    {
                        -- Show Guild Rank Events CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildRankCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildRankCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GuildRankCA,
                    },
                    {
                        -- Show Guild Rank Events Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildRankAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildRankAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GuildRankAlert,
                    },
                    {
                        -- Show Guild Rank Events Display Options
                        type = "dropdown",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS_TP),
                        choices = guildRankDisplayOptions,
                        getFunc = function() return guildRankDisplayOptions[LUIE.ChatAnnouncements.SV.GuildRankDisplayOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildRankDisplayOptions = guildRankDisplayOptionsKeys[value] end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.GuildRankCA or LUIE.ChatAnnouncements.SV.GuildRankAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.GuildRankDisplayOptions,
                    },
                    {
                        -- Show Guild Management CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildManageCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildManageCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GuildManageCA,
                    },
                    {
                        -- Show Guild Management Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildManageAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildManageAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GuildManageAlert,
                    },
                    {
                        -- Show Guild Icons
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildIcon end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildIcon = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.GuildCA or
                        LUIE.ChatAnnouncements.SV.GuildAlert or
                        LUIE.ChatAnnouncements.SV.GuildRankCA or
                        LUIE.ChatAnnouncements.SV.GuildRankAlert or
                        LUIE.ChatAnnouncements.SV.GuildManageCA or
                        LUIE.ChatAnnouncements.SV.GuildManageAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.GuildIcon,
                    },
                    {
                        -- Guild Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.GuildColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.GuildColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.GuildCA or
                        LUIE.ChatAnnouncements.SV.GuildAlert or
                        LUIE.ChatAnnouncements.SV.GuildRankCA or
                        LUIE.ChatAnnouncements.SV.GuildRankAlert or
                        LUIE.ChatAnnouncements.SV.GuildManageCA or
                        LUIE.ChatAnnouncements.SV.GuildManageAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.GuildColor[1], g=LUIE.ChatAnnouncements.D.GuildColor[2], b=LUIE.ChatAnnouncements.D.GuildColor[3]}
                    },
                    {
                        -- Use Alliance Color for Guild
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GuildAllianceColor end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GuildAllianceColor = value end,
                        width = "full",
                        disabled = function() return not (
                        LUIE.ChatAnnouncements.SV.GuildCA or
                        LUIE.ChatAnnouncements.SV.GuildAlert or
                        LUIE.ChatAnnouncements.SV.GuildRankCA or
                        LUIE.ChatAnnouncements.SV.GuildRankAlert or
                        LUIE.ChatAnnouncements.SV.GuildManageCA or
                        LUIE.ChatAnnouncements.SV.GuildManageAlert and
                        LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.GuildAllianceColor,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationTradeCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationTradeCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationTradeCA,
                    },
                    {
                        -- Show Trade Events
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationTradeAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationTradeAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationTradeAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelCA,
                    },
                    {
                        -- Show Duel Events (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelAlert,
                    },
                    {
                        -- Duel Start CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelStartCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelStartCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelStartCA,
                    },
                    {
                        -- Duel Start CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TPCSA), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelStartCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelStartCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelStartCSA,
                    },
                    {
                        -- Duel Start Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelStartAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelStartAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelStartAlert,
                    },
                    {
                        -- Duel Start Options
                        type = "dropdown",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION)),
                        tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION_TP),
                        choices = duelStartOptions,
                        getFunc = function() return duelStartOptions[LUIE.ChatAnnouncements.SV.DuelStartOptions] end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelStartOptions = duelStartOptionsKeys[value] end,
                        width = "full",
                        default = duelStartOptions[1],
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.DuelStartCA or LUIE.ChatAnnouncements.SV.DuelStartCSA or LUIE.ChatAnnouncements.SV.DuelStartAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                    },
                    {
                        -- Duel Won CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelWonCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelWonCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelWonCA,
                    },
                    {
                        -- Duel Won CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelWonCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelWonCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelWonCSA,
                    },
                    {
                        -- Duel Won Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelWonAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelWonAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelWonAlert,
                    },
                    {
                        -- Duel Boundary CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelBoundaryCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelBoundaryCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelBoundaryCA,
                    },
                    {
                        -- Duel Boundary CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelBoundaryCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelBoundaryCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelBoundaryCSA,
                    },
                    {
                        -- Duel Boundary Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DuelBoundaryAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DuelBoundaryAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DuelBoundaryAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.PledgeOfMaraCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.PledgeOfMaraCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.PledgeOfMaraCA,
                    },
                    {
                        -- Show Pledge of Mara CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.PledgeOfMaraCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.PledgeOfMaraCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.PledgeOfMaraCSA,
                    },
                    {
                        -- Show Pledge of Mara Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.PledgeOfMaraAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.PledgeOfMaraAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.PledgeOfMaraAlert,
                    },
                    {
                        -- Pledge of Mara (Alert Only on Failure)
                        type = "checkbox",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT)),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT_TP),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.PledgeOfMaraAlertOnlyFail end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.PledgeOfMaraAlertOnlyFail = value end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.PledgeOfMaraAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = LUIE.ChatAnnouncements.D.PledgeOfMaraAlertOnlyFail,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupCA,
                    },
                    {
                        -- Show Group Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupLFGCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupLFGCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupLFGCA,
                    },
                    {
                        -- Show Group LFG Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupLFGAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupLFGAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupLFGAlert,
                    },
                    
                    {
                        -- Show Group LFG CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupLFGQueueCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupLFGQueueCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupLFGQueueCA,
                    },
                    {
                        -- Show Group LFG Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupLFGQueueAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupLFGQueueAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupLFGQueueAlert,
                    },
                    
                    {
                        -- Show Group Vote CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupVoteCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupVoteCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupVoteCA,
                    },
                    {
                        -- Show Group Vote Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupVoteAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupVoteAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupVoteAlert,
                    },
                    
                    {
                        -- Show LFG Activity Completed CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupLFGCompleteCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupLFGCompleteCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupLFGCompleteCA,
                    },
                    {
                        -- Show LFG Activity Completed CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupLFGCompleteCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupLFGCompleteCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupLFGCompleteCSA,
                    },
                    {
                        -- Show LFG Activity Completed Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupLFGCompleteAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupLFGCompleteAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupLFGCompleteAlert,
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
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidCA,
                    },
                    {
                        -- Raid Announcements CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidCSA,
                    },
                    {
                        -- Raid Announcements Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidAlert,
                    },
                    
                    {
                        -- Raid Score CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidScoreCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidScoreCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidScoreCA,
                    },
                    {
                        -- Raid Score CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidScoreCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidScoreCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidScoreCSA,
                    },
                    {
                        -- Raid Score Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidScoreAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidScoreAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidScoreAlert,
                    },
                    
                    {
                        -- Raid Best Score CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidBestScoreCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidBestScoreCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidBestScoreCA,
                    },
                    {
                        -- Raid Best Score CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidBestScoreCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidBestScoreCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidBestScoreCSA,
                    },
                    {
                        -- Raid Best Score Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidBestScoreAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidBestScoreAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidBestScoreAlert,
                    },
                    
                    {
                        -- Raid Revive Counter CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidReviveCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidReviveCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidReviveCA,
                    },
                    {
                        -- Raid Revive Counter CSA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidReviveCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidReviveCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidReviveCSA,
                    },
                    {
                        -- Raid Revive Counter Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidReviveAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidReviveAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidReviveAlert,
                    },
                    
                    {
                        -- Arena Notifications (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidArenaCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidArenaCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidArenaCA,
                    },
                    {
                        -- Arena Notifications (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidArenaCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidArenaCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidArenaCSA,
                    },
                    {
                        -- Arena Notifications (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidArenaAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidArenaAlert  = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidArenaAlert,
                    },
                    
                    {
                        -- Arena Round Notifications (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidArenaRoundCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidArenaRoundCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidArenaRoundCA,
                    },
                    {
                        -- Arena Round Notifications (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidArenaRoundCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidArenaRoundCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidArenaRoundCSA,
                    },
                    {
                        -- Arena Round Notifications (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.GroupRaidArenaRoundAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.GroupRaidArenaRoundAlert  = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.GroupRaidArenaRoundAlert,
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
                        -- Display Group Area Message (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationGroupAreaCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationGroupAreaCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationGroupAreaCA,
                    },
                    {
                        -- Display Group Area Message (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationGroupAreaCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationGroupAreaCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationGroupAreaCSA,
                    },
                    {
                        -- Display Group Area Message (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationGroupAreaAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationGroupAreaAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationGroupAreaAlert,
                    },
                    
                
                    {
                        -- Mail (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationMailCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationMailCA = value LUIE.ChatAnnouncements.RegisterMailEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationMailCA,
                    },
                    {
                        -- Mail (ALERT)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationMailAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationMailAlert = value LUIE.ChatAnnouncements.RegisterMailEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationMailAlert,
                    },
                    
                    {
                        -- Show Lockpick Events CA
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationLockpickCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationLockpickCA = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationLockpickCA,
                    },
                    {
                        -- Show Lockpick Events Alert
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationLockpickAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationLockpickAlert = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationLockpickAlert,
                    },
                    {
                        -- Show Justice Confiscate (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationConfiscateCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationConfiscateCA = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationConfiscateCA,
                    },
                    
                    {
                        -- Show Justice Confiscate (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.NotificationConfiscateAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.NotificationConfiscateAlert = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.NotificationConfiscateAlert,
                    },
                    
                    
                    {
                        -- Show Bag/Bank Upgrade (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.StorageBagCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.StorageBagCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.StorageBagCA,
                    },
                    {
                        -- Show Bag/Bank Upgrade (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.StorageBagCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.StorageBagCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.StorageBagCSA,
                    },
                    {
                        -- Show Bag/Bank Upgrade (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.StorageBagAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.StorageBagAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.StorageBagAlert,
                    },
                    {
                        -- Bag/Bank Upgrade Message Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.StorageBagColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.StorageBagColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.StorageBagCA or LUIE.ChatAnnouncements.SV.StorageBagCSA or LUIE.ChatAnnouncements.SV.StorageBagAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.StorageBagColor[1], g=LUIE.ChatAnnouncements.D.StorageBagColor[2], b=LUIE.ChatAnnouncements.D.StorageBagColor[3]}
                    },
                    {
                        -- Show Mount Upgrade (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.StorageRidingCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.StorageRidingCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.StorageRidingCA,
                    },
                    {
                        -- Show Mount Upgrade (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.StorageRidingCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.StorageRidingCSA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.StorageRidingCSA,
                    },
                    {
                        -- Show Mount Upgrade (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.StorageRidingAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.StorageRidingAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.StorageRidingAlert,
                    },
                    {
                        -- Mount Upgrade Message Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.StorageRidingColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.StorageRidingColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.StorageRidingCA or LUIE.ChatAnnouncements.SV.StorageRidingCSA or LUIE.ChatAnnouncements.SV.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.StorageRidingColor[1], g=LUIE.ChatAnnouncements.D.StorageRidingColor[2], b=LUIE.ChatAnnouncements.D.StorageRidingColor[3]}
                    },
                    {
                        -- Mount Upgrade Message Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR_BOOK)),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.StorageRidingBookColor) end,
                        setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.StorageRidingBookColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.StorageRidingCA or LUIE.ChatAnnouncements.SV.StorageRidingCSA or LUIE.ChatAnnouncements.SV.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = {r=LUIE.ChatAnnouncements.D.StorageRidingBookColor[1], g=LUIE.ChatAnnouncements.D.StorageRidingBookColor[2], b=LUIE.ChatAnnouncements.D.StorageRidingBookColor[3]}
                    },
                    
                    
                    
                    
                    {
                        -- Show Disguise Events (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DisguiseCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DisguiseCA = value LUIE.ChatAnnouncements.RegisterDisguiseEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DisguiseCA,
                    },
                    {
                        -- Show Disguise Events (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DisguiseCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DisguiseCSA = value LUIE.ChatAnnouncements.RegisterDisguiseEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DisguiseCSA,
                    },
                    {
                        -- Show Disguise Events (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DisguiseAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DisguiseAlert = value LUIE.ChatAnnouncements.RegisterDisguiseEvents() end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DisguiseAlert,
                    },
                    
                    {
                        -- Show Disguise Warning (CA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DisguiseWarnCA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DisguiseWarnCA = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DisguiseWarnCA,
                    },
                    {
                        -- Show Disguise Warning (CSA)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DisguiseWarnCSA end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DisguiseWarnCSA = value end,
                        width = "full",
                       disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DisguiseWarnCSA,
                    },
                    {
                        -- Show Disguise Warning (Alert)
                        type = "checkbox",
                        name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                        tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                        getFunc = function() return LUIE.ChatAnnouncements.SV.DisguiseWarnAlert end,
                        setFunc = function(value) LUIE.ChatAnnouncements.SV.DisguiseWarnAlert = value end,
                        width = "full",
                        disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                        default = LUIE.ChatAnnouncements.D.DisguiseWarnAlert,
                    },
                    
                    {
                        -- Disguise Alert Color
                        type = "colorpicker",
                        name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR)),
                        tooltip = GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR_TP),
                        getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.DisguiseAlertColor) end,
                        setFunc = function(r,g,b,a) LUIE.ChatAnnouncements.SV.DisguiseAlertColor={r,g,b} LUIE.ChatAnnouncements.RegisterColorEvents() end,
                        width = "full",
                        disabled = function() return not (LUIE.ChatAnnouncements.SV.DisguiseWarnCA or LUIE.ChatAnnouncements.SV.DisguiseWarnCSA or LUIE.ChatAnnouncements.SV.DisguiseWarnAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                        default = { r=LUIE.ChatAnnouncements.D.DisguiseAlertColor[1], g=LUIE.ChatAnnouncements.D.DisguiseAlertColor[2], b=LUIE.ChatAnnouncements.D.DisguiseAlertColor[3] },
                    },
                },
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
        tooltip = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_REPOSIT_TP),
        getFunc = function() return LUIE.UnitFrames.SV.RepositionFrames end,
        setFunc = function(value) LUIE.UnitFrames.SV.RepositionFrames = value end,
        width = "full",
        default = LUIE.UnitFrames.D.RepositionFrames,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    
    -- Reposition frames adjust Y Coordinates
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
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
    }
    -- Out-of-Combat bars transparency
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_INCTRANS_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.DefaultIncTransparency end,
        setFunc = function(value) LUIE.UnitFrames.SetDefaultFramesTransparency(nil, value) end,
        width = "full",
        default = LUIE.UnitFrames.D.DefaultIncTransparency,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Format label text
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_TP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.Format end,
        setFunc = function(var) LUIE.UnitFrames.SV.Format = var end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.Format,
    }
    -- DefaultFrames Font
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
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
    }
    -- DefaultFrames Font Size
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_FONT_SIZE),
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_SIZE_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_STYLE_TP),
        choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
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
    -- Color target name by reaction
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION),
        tooltip = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION_TP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetColourByReaction end,
        setFunc = LUIE.UnitFrames.TargetColourByReaction,
        width = "full",
        default = LUIE.UnitFrames.D.TargetColourByReaction,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Target class icon
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS),
        tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_GFI_TP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetShowFriend end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetShowFriend = value end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetShowFriend,
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT_TP),
        func = LUIE.UnitFrames.CustomFramesResetPosition,
        width = "half",
    }
    -- Custom Unit Frames Font
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
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
    }
    -- Custom Unit Frames Font size labels
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_STYLE_TP),
        choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
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
    }
    -- Custom Unit Frames Separate Shield Bar
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS_TP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomSmoothBar end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomSmoothBar = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomSmoothBar,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    
    -- Champion Points Effective
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_CHAMPION),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_CHAMPION_TP),
        choices = championOptions,
        getFunc = function() return LUIE.UnitFrames.SV.ChampionOptions end,
        setFunc = function(var) LUIE.UnitFrames.SV.ChampionOptions = var LUIE.UnitFrames.OnPlayerActivated() end,
        width = "full",
        default = LUIE.UnitFrames.D.ChampionOptions,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    
    -- Custom Unit Frame Color Options
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEADER),
        width = "full",
    }
    -- Custom Unit Frames Health Bar Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALTH),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealth) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealth={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourHealth[1], g=LUIE.UnitFrames.D.CustomColourHealth[2], b=LUIE.UnitFrames.D.CustomColourHealth[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Shield Bar Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SHIELD),
        getFunc = function() return LUIE.UnitFrames.SV.CustomColourShield[1], LUIE.UnitFrames.SV.CustomColourShield[2], LUIE.UnitFrames.SV.CustomColourShield[3]  end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourShield={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourShield[1], g=LUIE.UnitFrames.D.CustomColourShield[2], b=LUIE.UnitFrames.D.CustomColourShield[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Magicka Bar Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_MAGICKA),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourMagicka) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourMagicka={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourMagicka[1], g=LUIE.UnitFrames.D.CustomColourMagicka[2], b=LUIE.UnitFrames.D.CustomColourMagicka[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Stamina Bar Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_STAMINA),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourStamina) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourStamina={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourStamina[1], g=LUIE.UnitFrames.D.CustomColourStamina[2], b=LUIE.UnitFrames.D.CustomColourStamina[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames DPS Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DPS),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourDPS) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourDPS={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourDPS[1], g=LUIE.UnitFrames.D.CustomColourDPS[2], b=LUIE.UnitFrames.D.CustomColourDPS[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Healer Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALER),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealer) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourHealer[1], g=LUIE.UnitFrames.D.CustomColourHealer[2], b=LUIE.UnitFrames.D.CustomColourHealer[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Tank Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TANK),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourTank) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourTank={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourTank[1], g=LUIE.UnitFrames.D.CustomColourTank[2], b=LUIE.UnitFrames.D.CustomColourTank[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Dragonknight Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DK),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourDragonknight) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourDragonknight={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourDragonknight[1], g=LUIE.UnitFrames.D.CustomColourDragonknight[2], b=LUIE.UnitFrames.D.CustomColourDragonknight[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Nightblade Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_NB),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourNightblade) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourNightblade={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourNightblade[1], g=LUIE.UnitFrames.D.CustomColourNightblade[2], b=LUIE.UnitFrames.D.CustomColourNightblade[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Sorcerer Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SORC),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourSorcerer) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourSorcerer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourSorcerer[1], g=LUIE.UnitFrames.D.CustomColourSorcerer[2], b=LUIE.UnitFrames.D.CustomColourSorcerer[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Templar Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TEMP),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourTemplar) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourTemplar={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourTemplar[1], g=LUIE.UnitFrames.D.CustomColourTemplar[2], b=LUIE.UnitFrames.D.CustomColourTemplar[3] },
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames Warden Role Color
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "colorpicker",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_WARD),
        getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourWarden) end,
        setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourWarden={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = { r=LUIE.UnitFrames.D.CustomColourWarden[1], g=LUIE.UnitFrames.D.CustomColourWarden[2], b=LUIE.UnitFrames.D.CustomColourWarden[3] },
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER_TP),
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET_TP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesTarget end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesTarget = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesTarget,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames format left label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatOnePT end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatOnePT = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFormatOnePT,
    }
    -- Custom Unit Frames format right label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatTwoPT end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatTwoPT = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
        width = "full",
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        default = LUIE.UnitFrames.D.CustomFormatTwoPT,
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
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL_TP),
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR)),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.HideBarMagicka end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideBarMagicka = value end,
        width = "full",
        default = LUIE.UnitFrames.D.HideBarMagicka,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.HideLabelMagicka ) end,
    }
    -- Hide Player Stamina Bar Label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL_TP),
        getFunc = function() return LUIE.UnitFrames.SV.HideLabelStamina end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideLabelStamina = value LUIE.UnitFrames.SV.HideBarStamina = false end,
        width = "full",
        default = LUIE.UnitFrames.D.HideLabelStamina,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Hide Player Stamina Bar
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR)),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.HideBarStamina end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideBarStamina = value end,
        width = "full",
        default = LUIE.UnitFrames.D.HideBarStamina,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.HideLabelStamina ) end,
    }
    -- Out-of-Combat frame opacity
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerOocAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerOocAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- In-Combat frame opacity
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerIncAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerIncAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- HIDE BUFFS OOC - PLAYER
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER_TP),
        getFunc = function() return LUIE.UnitFrames.SV.HideBuffsPlayerOoc end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideBuffsPlayerOoc = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.HideBuffsPlayerOoc,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- Spacing between Player Bars
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING),
        min = -1, max = 4, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.PlayerBarSpacing end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerBarSpacing,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Display self name on Player Frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF_TP),
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableYourname end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableYourname = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableYourname,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Display Mount/Siege/Werewolf Bar
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarMSW end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarMSW = value LUIE.UnitFrames.CustomFramesSetupAlternative() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableAltbarMSW,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Display XP/Champion XP Bar
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarXP end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarXP = value LUIE.UnitFrames.CustomFramesSetupAlternative() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableAltbarXP,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Champion XP Bar Point-Type Colour
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR)),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.PlayerChampionColour end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerChampionColour = value LUIE.UnitFrames.OnChampionPointGained() end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerChampionColour,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerEnableAltbarXP ) end,
    }
    -- Target Bars Width
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_WIDTH),
        min = 200, max = 500, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.TargetBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    -- Target Bars Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_HEIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.TargetBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    -- Out-of-Combat frame opacity
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.TargetOocAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetOocAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- In-Combat frame opacity
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_ICPACITY_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.TargetIncAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetIncAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- HIDE BUFFS OOC - TARGET
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_TARGET),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_TARGET_TP),
        getFunc = function() return LUIE.UnitFrames.SV.HideBuffsTargetOoc end,
        setFunc = function(value) LUIE.UnitFrames.SV.HideBuffsTargetOoc = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.HideBuffsTargetOoc,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- Display Target class label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL_TP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetEnableClass end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableClass = value end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetEnableClass,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    -- Execute Health % Threshold
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
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
    }
    -- Display Skull Execute Texture
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE_TP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetEnableSkull end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableSkull = value end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetEnableSkull,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
    }
    -- Display title on target frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE_TP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetEnableTitle end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableTitle = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetEnableTitle,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Display rank on target frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TP),
        getFunc = function() return LUIE.UnitFrames.SV.TargetEnableRank end,
        setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableRank = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.TargetEnableRank,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
    }
    -- Display Armor stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableArmor end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableArmor = value end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableArmor,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    --Display Power stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnablePower end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnablePower = value end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnablePower,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- Custom Unit Frames Display HoT / DoT Animations
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
        getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableRegen end,
        setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableRegen = value end,
        width = "full",
        default = LUIE.UnitFrames.D.PlayerEnableRegen,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Treat Missing Power as In-Combat
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT_TP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomOocAlphaPower end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomOocAlphaPower = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomOocAlphaPower,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
    }
    -- Custom Unit Frames (Group)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEADER),
        width = "full",
    }
    -- Enable This Addon GROUP frames
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE_TP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesGroup end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesGroup = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesGroup,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Custom Unit Frames format left label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatOneGroup end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatOneGroup = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
        width = "full",
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
        default = LUIE.UnitFrames.D.CustomFormatOneGroup,
    }
    -- Custom Unit Frames format right label
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatTwoGroup end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatTwoGroup = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
        width = "full",
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
        default = LUIE.UnitFrames.D.CustomFormatTwoGroup,
    }
    -- Group Bars Width
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_WIDTH),
        min = 100, max = 400, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.GroupBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Group Bars Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.GroupBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Group / Raid ALPHA
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.GroupAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupAlpha = value LUIE.UnitFrames.CustomFramesGroupAlpha() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Spacing between Group Bars
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_SPACING),
        min = 20, max = 80, step = 2,
        getFunc = function() return LUIE.UnitFrames.SV.GroupBarSpacing end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupBarSpacing,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Include Player in Group Frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER_TP),
        getFunc = function() return not LUIE.UnitFrames.SV.GroupExcludePlayer end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupExcludePlayer = (not value) LUIE.UnitFrames.CustomFramesGroupUpdate() end,
        width = "full",
        default = not LUIE.UnitFrames.D.GroupExcludePlayer,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Show Role Icon on Group Frames
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON_TP),
        getFunc = function() return LUIE.UnitFrames.SV.RoleIconSmallGroup end,
        setFunc = function(value) LUIE.UnitFrames.SV.RoleIconSmallGroup = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
        width = "full",
        default = LUIE.UnitFrames.D.RoleIconSmallGroup,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Custom Unit Frames Group Color Player Role
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE_TP),
        getFunc = function() return LUIE.UnitFrames.SV.ColorRoleGroup end,
        setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleGroup = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = LUIE.UnitFrames.D.ColorRoleGroup,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    
    -- Custom Unit Frames Group Color Class
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS_TP),
        getFunc = function() return LUIE.UnitFrames.SV.ColorClassGroup end,
        setFunc = function(value) LUIE.UnitFrames.SV.ColorClassGroup = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = LUIE.UnitFrames.D.ColorClassGroup,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Display Armor stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.GroupEnableArmor end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupEnableArmor = value end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupEnableArmor,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    --Display Power stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
        getFunc = function() return LUIE.UnitFrames.SV.GroupEnablePower end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupEnablePower = value end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupEnablePower,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Display Regen Arrows
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
        getFunc = function() return LUIE.UnitFrames.SV.GroupEnableRegen end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupEnableRegen = value end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupEnableRegen,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    
    -- Custom Unit Frames (Raid)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEADER),
        width = "full",
    }
    -- Enable This Addon RAID frames
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE_TP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesRaid end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesRaid = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesRaid,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Raid HP Bar Format
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_TP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatRaid end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatRaid = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
        width = "full",
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
        default = LUIE.UnitFrames.D.CustomFormatRaid,
    }
    -- Raid Bars Width
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_WIDTH),
        min = 100, max = 500, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.RaidBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    -- Raid Bars Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.RaidBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    -- Group / Raid ALPHA
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.GroupAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.GroupAlpha = value LUIE.UnitFrames.CustomFramesGroupAlpha() end,
        width = "full",
        default = LUIE.UnitFrames.D.GroupAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
    }
    -- Raid Frame Layout
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
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
    }
    -- Add Spacer for every 4 members
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER_TP),
        getFunc = function() return LUIE.UnitFrames.SV.RaidSpacers end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidSpacers = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidSpacers,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    -- Raid Name Clip
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP_TP),
        min = 0, max = 200, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.RaidNameClip end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidNameClip = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid() end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidNameClip,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }  
    -- Class / Role Icon on Raid Frames Setting
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
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
    }
    -- Custom Unit Frames Raid Color Player Role
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE_TP),
        getFunc = function() return LUIE.UnitFrames.SV.ColorRoleRaid end,
        setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleRaid = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = LUIE.UnitFrames.D.ColorRoleRaid,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    -- Custom Unit Frames Raid Color Player Class
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS_TP),
        getFunc = function() return LUIE.UnitFrames.SV.ColorClassRaid end,
        setFunc = function(value) LUIE.UnitFrames.SV.ColorClassRaid = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
        width = "full",
        default = LUIE.UnitFrames.D.ColorClassRaid,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    -- Display Armor stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.RaidEnableArmor end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidEnableArmor = value end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidEnableArmor,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    -- Display Power stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
        getFunc = function() return LUIE.UnitFrames.SV.RaidEnablePower end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidEnablePower = value end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidEnablePower,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    -- Display Regen Arrows
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
        getFunc = function() return LUIE.UnitFrames.SV.RaidEnableRegen end,
        setFunc = function(value) LUIE.UnitFrames.SV.RaidEnableRegen = value end,
        width = "full",
        default = LUIE.UnitFrames.D.RaidEnableRegen,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
    }
    
    
    -- Custom Unit Frames (Boss)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEADER),
        width = "full",
    }
    -- Enable This Addon BOSS frames
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE_TP),
        getFunc = function() return LUIE.UnitFrames.SV.CustomFramesBosses end,
        setFunc = function(value) LUIE.UnitFrames.SV.CustomFramesBosses = value end,
        width = "full",
        default = LUIE.UnitFrames.D.CustomFramesBosses,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- Boss HP Bar Format
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_TP),
        choices = formatOptions,
        getFunc = function() return LUIE.UnitFrames.SV.CustomFormatBoss end,
        setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatBoss = var LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
        width = "full",
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
        default = LUIE.UnitFrames.D.CustomFormatBoss,
    }
    -- Boss Bars Width
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_WIDTH),
        min = 100, max = 500, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.BossBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.BossBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutBosses() end,
        width = "full",
        default = LUIE.UnitFrames.D.BossBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
    }
    -- Boss Bars Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.BossBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.BossBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutBosses() end,
        width = "full",
        default = LUIE.UnitFrames.D.BossBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
    }
    -- Out-of-Combat frame opacity
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.BossOocAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.BossOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.BossOocAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
    }
    -- In-Combat frame opacity
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC_TP),
        min = 0, max = 100, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.BossIncAlpha end,
        setFunc = function(value) LUIE.UnitFrames.SV.BossIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
        width = "full",
        default = LUIE.UnitFrames.D.BossIncAlpha,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
    }
    -- Display Armor stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
        getFunc = function() return LUIE.UnitFrames.SV.BossEnableArmor end,
        setFunc = function(value) LUIE.UnitFrames.SV.BossEnableArmor = value end,
        width = "full",
        default = LUIE.UnitFrames.D.BossEnableArmor,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
    }
    -- Display Power stat change
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
        getFunc = function() return LUIE.UnitFrames.SV.BossEnablePower end,
        setFunc = function(value) LUIE.UnitFrames.SV.BossEnablePower = value end,
        width = "full",
        default = LUIE.UnitFrames.D.BossEnablePower,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
    }
    -- Display Regen Arrows
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
        tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
        getFunc = function() return LUIE.UnitFrames.SV.BossEnableRegen end,
        setFunc = function(value) LUIE.UnitFrames.SV.BossEnableRegen = value end,
        width = "full",
        default = LUIE.UnitFrames.D.BossEnableRegen,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
    }
    
    -- Custom Unit Frames (PvP Target Frame)
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_HEADER),
        width = "full",
    }
    -- Enable additional PvP Target frame
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_TP),
        getFunc = function() return LUIE.UnitFrames.SV.AvaCustFramesTarget end,
        setFunc = function(value) LUIE.UnitFrames.SV.AvaCustFramesTarget = value end,
        width = "full",
        default = LUIE.UnitFrames.D.AvaCustFramesTarget,
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
    }
    -- PvP Target Bars Width
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_WIDTH),
        min = 300, max = 700, step = 5,
        getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarWidth end,
        setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.AvaTargetBarWidth,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
    }
    -- PvP Target Bars Height
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_HEIGHT),
        min = 20, max = 70, step = 1,
        getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarHeight end,
        setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer() end,
        width = "full",
        default = LUIE.UnitFrames.D.AvaTargetBarHeight,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
    }
    -- Common options
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HEADER),
        width = "full",
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
        name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLORINTERACT)),
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
        name = "Reload UI",
        tooltip = GetString(SI_LUIE_LAM_RELOADUI),
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
        default = D.toggles.inCombatOnly,
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
                    default = D.toggles.incoming.showDamage,
                },
                {--HEALING
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HEALING_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showHealing end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showHealing = v end,
                    default = D.toggles.incoming.showHealing,
                },
                {--ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showEnergize = v end,
                    default = D.toggles.incoming.showEnergize,
                },
                {--ULTIMATE ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showUltimateEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showUltimateEnergize = v end,
                    default = D.toggles.incoming.showUltimateEnergize,
                },
                {--DRAIN
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DRAIN_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDrain end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDrain = v end,
                    default = D.toggles.incoming.showDrain,
                },
                {--DOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDot = v end,
                    default = D.toggles.incoming.showDot,
                },
                {--HOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showHot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showHot = v end,
                    default = D.toggles.incoming.showHot,
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
                    default = D.toggles.incoming.showMiss
                },
                {--IMMUNE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_IMMUNE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showImmune end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showImmune = v end,
                    default = D.toggles.incoming.showImmune,
                },
                {--PARRIED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_PARRIED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showParried end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showParried = v end,
                    default = D.toggles.incoming.showParried,
                },
                {--REFLECT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_REFLECTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showReflected end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showReflected = v end,
                    default = D.toggles.incoming.showReflected,
                },
                {--DAMAGESHIELD
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_SHIELD_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDamageShield end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDamageShield = v end,
                    default = D.toggles.incoming.showDamageShield,
                },
                {--DODGE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DODGED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDodged end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDodged = v end,
                    default = D.toggles.incoming.showDodged,
                },
                {--BLOCK
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_BLOCKED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showBlocked end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showBlocked = v end,
                    default = D.toggles.incoming.showBlocked,
                },
                {--INTERRUPT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_INTERRUPTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showInterrupted end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showInterrupted = v end,
                    default = D.toggles.incoming.showInterrupted,
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
                    default = D.toggles.incoming.showDisoriented,
                },
                {--FEARED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_FEARED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showFeared end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showFeared = v end,
                    default = D.toggles.incoming.showFeared,
                },
                {--OFF BALANCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_OFF_BALANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showOffBalanced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showOffBalanced = v end,
                    default = D.toggles.incoming.showOffBalanced,
                },
                {--SILENCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_SILENCED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showSilenced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showSilenced = v end,
                    default = D.toggles.incoming.showSilenced,
                },
                {--STUNNED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_STUNNED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showStunned end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showStunned = v end,
                    default = D.toggles.incoming.showStunned,
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
                    default = D.toggles.outgoing.showDamage,
                },
                {--DOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDot = v end,
                    default = D.toggles.outgoing.showDot,
                },
                {--HEALING
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HEALING_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showHealing end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showHealing = v end,
                    default = D.toggles.outgoing.showHealing,
                },
                {--HOT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showHot end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showHot = v end,
                    default = D.toggles.outgoing.showHot,
                },
                {--ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showEnergize = v end,
                    default = D.toggles.outgoing.showEnergize,
                },
                {--ULTIMATE ENERGIZE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showUltimateEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showUltimateEnergize = v end,
                    default = D.toggles.outgoing.showUltimateEnergize,
                },
                {--DRAIN
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DRAIN_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDrain end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDrain = v end,
                    default = D.toggles.outgoing.showDrain,
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
                    default = D.toggles.outgoing.showMiss,
                },
                {--IMMUNE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_IMMUNE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showImmune end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showImmune = v end,
                    default = D.toggles.outgoing.showImmune,
                },
                {--PARRIED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_PARRIED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showParried end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showParried = v end,
                    default = D.toggles.outgoing.showParried,
                },
                {--DAMAGESHIELD
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_SHIELD_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDamageShield end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDamageShield = v end,
                    default = D.toggles.outgoing.showDamageShield,
                },
                {--DODGE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DODGED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDodged end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDodged = v end,
                    default = D.toggles.outgoing.showDodged,
                },
                {--BLOCK
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_BLOCKED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showBlocked end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showBlocked = v end,
                    default = D.toggles.outgoing.showBlocked,
                },
                {--INTERRUPT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_INTERRUPTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showInterrupted end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showInterrupted = v end,
                    default = D.toggles.outgoing.showInterrupted,
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
                    default = D.toggles.outgoing.showDisoriented,
                },
                {--FEARED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_FEARED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showFeared end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showFeared = v end,
                    default = D.toggles.outgoing.showFeared,
                },
                {--OFF BALANCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_OFF_BALANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showOffBalanced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showOffBalanced = v end,
                    default = D.toggles.outgoing.showOffBalanced,
                },
                {--SILENCED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_SILENCED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showSilenced end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showSilenced = v end,
                    default = D.toggles.outgoing.showSilenced,
                },
                {--STUNNED
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_STUNNED_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showStunned end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showStunned = v end,
                    default = D.toggles.outgoing.showStunned,
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
                    default = D.toggles.showInCombat,
                },
                {--OUT OF COMBAT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT),
                    tooltip =GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_OUT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showOutCombat end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showOutCombat = v end,
                    default = D.toggles.showOutCombat,
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
                    default = D.toggles.showAlertCleanse,
                },
                {--EXPLOIT
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXPLOIT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertExploit end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertExploit = v end,
                    default = D.toggles.showAlertExploit,
                },
                {--EXECUTE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXECUTE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertExecute end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertExecute = v end,
                    default = D.toggles.showAlertExecute,
                },
                {--EXECUTE THRESHOLD SLIDER
                    type    = "slider",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD_TP),
                    min     = 10,
                    max     = 50,
                    getFunc = function() return LUIE.CombatText.SV.executeThreshold end,
                    setFunc = function(v) LUIE.CombatText.SV.executeThreshold = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertExecute end,
                    default = D.executeThreshold,
                },
                {--EXECUTE FREQUENCY SLIDER
                    type    = "slider",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY_TP),
                    min     = 1,
                    max     = 20,
                    getFunc = function() return LUIE.CombatText.SV.executeFrequency end,
                    setFunc = function(v) LUIE.CombatText.SV.executeFrequency = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertExecute end,
                    default = D.executeFrequency,
                },
                {--HIDE INGAME TIPS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.hideIngameTips end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.hideIngameTips = v; ZO_ActiveCombatTips:SetHidden(v) end,
                    default = D.toggles.hideIngameTips,
                },
                {--MITIGATION ALERTS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertMitigation = v end,
                    default = D.toggles.showAlertMitigation,
                },
                
                {
                    type = "description",
                    text = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_DESCRIPTION),
                },
                
                {--MITIGATION FORMAT
                    type    = "dropdown",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD_TP),
                    choices = CombatCloudConstants.mitigationType,
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationType end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationType = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.mitigationType,
                },
                
                {--MITIGATION FORMAT
                    type    = "editbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationFormat end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationFormat = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.mitigationFormat,
                },
                
                {--MITIGATION SUFFIX
                    type    = "editbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationSuffix end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationSuffix = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.mitigationSuffix,
                },
                
                {--MITIGATION RANK 3
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank3 end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank3 = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.mitigationRank3,
                },
                {--MITIGATION RANK 2
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank2 end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank2 = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.mitigationRank2,
                },
                {--MITIGATION RANK 1
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank1 end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank1 = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.mitigationRank1,
                },
                {--MITIGATION DUNGEON
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.mitigationDungeon end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationDungeon = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.mitigationDungeon,
                },
                
                {--BLOCK
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_BLOCK_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertBlock end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertBlock = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.showAlertBlock,
                },
                {--DODGE
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_DODGE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertDodge end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertDodge = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.showAlertDodge,
                },
                {--AVOID
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_AVOID_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertAvoid end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertAvoid = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.showAlertAvoid,
                },
                {--INTERRUPT
                    type    = "checkbox",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_INTERRUPT_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showAlertInterrupt end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertInterrupt = v end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                    default = D.toggles.showAlertInterrupt,
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
                    default = D.toggles.showPointsAlliance,
                },
                {--EXPERIENCE POINTS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_EXPERIENCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showPointsExperience end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsExperience = v end,
                    default = D.toggles.showPointsExperience,
                },
                {--CHAMPION POINTS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_CHAMPION_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showPointsChampion end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsChampion = v end,
                    default = D.toggles.showPointsChampion,
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
                    default = D.toggles.showLowHealth,
                },
                {--LOW HEALTH WARNING THRESHOLD SLIDER
                    type    = "slider",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_HEALTH)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_HEALTH_TP),
                    min     = 15,
                    max     = 50,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.healthThreshold end,
                    setFunc = function(threshold) LUIE.CombatText.SV.healthThreshold = threshold end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showLowHealth end,
                    default = D.healthThreshold,
                },
                {--LOW MAGICKA
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_MAGICKA_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showLowMagicka end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showLowMagicka = v end,
                    default = D.toggles.showLowMagicka,
                },
                {--LOW MAGICKA WARNING THRESHOLD SLIDER
                    type    = "slider",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_MAGICKA)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_MAGICKA_TP),
                    min     = 15,
                    max     = 50,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.magickaThreshold end,
                    setFunc = function(threshold) LUIE.CombatText.SV.magickaThreshold = threshold end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showLowMagicka end,
                    default = D.magickaThreshold,
                },
                {--LOW STAMINA
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_STAMINA_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showLowStamina end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showLowStamina = v end,
                    default = D.toggles.showLowStamina,
                },
                {--LOW STAMINA WARNING THRESHOLD SLIDER
                    type    = "slider",
                    name    = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_STAMINA)),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_STAMINA_TP),
                    min     = 15,
                    max     = 50,
                    step    = 1,
                    getFunc = function() return LUIE.CombatText.SV.staminaThreshold end,
                    setFunc = function(threshold) LUIE.CombatText.SV.staminaThreshold = threshold end,
                    disabled = function() return not LUIE.CombatText.SV.toggles.showLowStamina end,
                    default = D.staminaThreshold,
                },
                {--WARNING SOUND
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.warningSound end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.warningSound = v end,
                    disabled = function() return not (LUIE.CombatText.SV.toggles.showLowHealth or LUIE.CombatText.SV.toggles.showLowMagicka or LUIE.CombatText.SV.toggles.showLowStamina) end,
                    default = D.toggles.warningSound,
                },
                {--ULTIMATE READY
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ULTIMATE_READY_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showUltimate end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showUltimate = v end,
                    default = D.toggles.showUltimate,
                },
                {--POTION READY
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POTION_READY_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showPotionReady end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showPotionReady = v end,
                    default = D.toggles.showPotionReady,
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
                    default = D.fontFace
                },
                {--FONT OUTLINE DROPDOWN
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_FONT_OUTLINE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_OUTLINE_TP),
                    choices = CombatCloudConstants.outlineType,
                    getFunc = function() return LUIE.CombatText.SV.fontOutline end,
                    setFunc = function(outline)
                        LUIE.CombatText.SV.fontOutline = outline
                        for k, _ in pairs (LUIE.CombatText.SV.panels) do
                            _G[k .. "_Label"]:SetFont(LMP:Fetch(LMP.MediaType.FONT, LUIE.CombatText.SV.fontFace) .. "|26|" .. LUIE.CombatText.SV.fontOutline)
                        end
                    end,
                    default = D.fontOutline
                },
                {--TEST FONT BUTTON
                    type = "button",
                    name    = GetString(SI_LUIE_LAM_CT_FONT_TEST),
                    tooltip = GetString(SI_LUIE_LAM_CT_FONT_TEST_TP),
                    func = function()
                        CALLBACK_MANAGER:FireCallbacks(CombatCloudConstants.eventType.COMBAT, CombatCloudConstants.combatType.INCOMING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
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
                    default = D.fontSizes.damage,
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
                    default = D.fontSizes.damagecritical,
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
                    default = D.fontSizes.healing,
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
                    default = D.fontSizes.healingcritical,
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
                    default = D.fontSizes.dot,
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
                    default = D.fontSizes.dotcritical,
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
                    default = D.fontSizes.hot,
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
                    default = D.fontSizes.hotcritical,
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
                    default = D.fontSizes.gainLoss,
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
                    default = D.fontSizes.mitigation,
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
                    default = D.fontSizes.crowdControl,
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
                    default = D.fontSizes.combatState,
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
                    default = D.fontSizes.alert,
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
                    default = D.fontSizes.point,
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
                    default = D.fontSizes.resource,
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
                    default = {r=D.colors.damage[0][1], g=D.colors.damage[0][2], b=D.colors.damage[0][3]}
                },
                {--GENERIC
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[1]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[1] = { r, g, b, a } end,
                    default = {r=D.colors.damage[1][1], g=D.colors.damage[1][2], b=D.colors.damage[1][3]}
                },
                {--PHYSICAL
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[2]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[2] = { r, g, b, a } end,
                    default = {r=D.colors.damage[2][1], g=D.colors.damage[2][2], b=D.colors.damage[2][3]}
                },
                {--FIRE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[3]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[3] = { r, g, b, a } end,
                    default = {r=D.colors.damage[3][1], g=D.colors.damage[3][2], b=D.colors.damage[3][3]}
                },
                {--SHOCK
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[4]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[4] = { r, g, b, a } end,
                    default = {r=D.colors.damage[4][1], g=D.colors.damage[4][2], b=D.colors.damage[4][3]}
                },
                {--OBLIVION
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[5]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[5] = { r, g, b, a } end,
                    default = {r=D.colors.damage[5][1], g=D.colors.damage[5][2], b=D.colors.damage[5][3]}
                },
                {--COLD
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[6]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[6] = { r, g, b, a } end,
                    default = {r=D.colors.damage[6][1], g=D.colors.damage[6][2], b=D.colors.damage[6][3]}
                },
                {--EARTH
                    type     = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[7]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[7] = { r, g, b, a } end,
                    default = {r=D.colors.damage[7][1], g=D.colors.damage[7][2], b=D.colors.damage[7][3]}
                },
                {--MAGIC
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[8]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[8] = { r, g, b, a } end,
                    default = {r=D.colors.damage[8][1], g=D.colors.damage[8][2], b=D.colors.damage[8][3]}
                },
                {--DROWN
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[9]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[9] = { r, g, b, a } end,
                    default = {r=D.colors.damage[9][1], g=D.colors.damage[9][2], b=D.colors.damage[9][3]}
                },
                {--DISEASE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[10]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[10] = { r, g, b, a } end,
                    default = {r=D.colors.damage[10][1], g=D.colors.damage[10][2], b=D.colors.damage[10][3]}
                },
                {--POISON
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[11]) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[11] = { r, g, b, a } end,
                    default = {r=D.colors.damage[11][1], g=D.colors.damage[11][2], b=D.colors.damage[11][3]}
                },
                {--HEALING
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.healing) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.healing = { r, g, b, a } end,
                    default = {r=D.colors.healing[1], g=D.colors.healing[2], b=D.colors.healing[3]}
                },
                {--ENERGIZE MAGICKA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_MAGICKA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeMagicka) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeMagicka = { r, g, b, a } end,
                    default = {r=D.colors.energizeMagicka[1], g=D.colors.energizeMagicka[2], b=D.colors.energizeMagicka[3]}
                },
                {--ENERGIZE STAMINA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_STAMINA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeStamina) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeStamina = { r, g, b, a } end,
                    default = {r=D.colors.energizeStamina[1], g=D.colors.energizeStamina[2], b=D.colors.energizeStamina[3]}
                },
                {--ENERGIZE ULTIMATE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeUltimate) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeUltimate = { r, g, b, a } end,
                    default = {r=D.colors.energizeUltimate[1], g=D.colors.energizeUltimate[2], b=D.colors.energizeUltimate[3]}
                },
                {--DRAIN MAGICKA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_MAGICKA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.drainMagicka) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.drainMagicka = { r, g, b, a } end,
                    default = {r=D.colors.drainMagicka[1], g=D.colors.drainMagicka[2], b=D.colors.drainMagicka[3]}
                },
                {--DRAIN STAMINA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_STAMINA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.drainStamina) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.drainStamina = { r, g, b, a } end,
                    default = {r=D.colors.drainStamina[1], g=D.colors.drainStamina[2], b=D.colors.drainStamina[3]}
                },
                {--CHECKBOX CRITICAL DAMAGE OVERRIDE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.criticalDamageOverride end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.criticalDamageOverride = v end,
                    default = D.toggles.criticalDamageOverride,
                },
                {--COLOR CRITICAL DAMAGE OVERRIDE
                    type    = "colorpicker",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR)),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.criticalDamageOverride) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.criticalDamageOverride = { r, g, b, a } end,
                    default = {r=D.colors.criticalDamageOverride[1], g=D.colors.criticalDamageOverride[2], b=D.colors.criticalDamageOverride[3]}
                },
                {--CHECKBOX CRITICAL HEALING OVERRIDE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.criticalHealingOverride end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.criticalHealingOverride = v end,
                    default = D.toggles.criticalHealingOverride
                },
                {--COLOR CRITICAL HEALING OVERRIDE
                    type    = "colorpicker",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR)),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.criticalHealingOverride) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.criticalHealingOverride = { r, g, b, a } end,
                    default = {r=D.colors.criticalHealingOverride[1], g=D.colors.criticalHealingOverride[2], b=D.colors.criticalHealingOverride[3]}
                },
				{--CHECKBOX INCOMING DAMAGE OVERRIDE
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.incomingDamageOverride end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.incomingDamageOverride = v end,
                    default = D.toggles.incomingDamageOverride
                },
                {--COLOR INCOMING DAMAGE OVERRIDE
                    type    = "colorpicker",
                    name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR)),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.incomingDamageOverride) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.incomingDamageOverride = { r, g, b, a } end,
                    default = {r=D.colors.incomingDamageOverride[1], g=D.colors.incomingDamageOverride[2], b=D.colors.incomingDamageOverride[3]}
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
                    default = {r=D.colors.miss[1], g=D.colors.miss[2], b=D.colors.miss[3]}
                },
                {--IMMUNE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_IMMUNE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.immune) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.immune = { r, g, b, a } end,
                    default = {r=D.colors.immune[1], g=D.colors.immune[2], b=D.colors.immune[3]}
                },
                {--PARRIED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_PARRIED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.parried) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.parried = { r, g, b, a } end,
                    default = {r=D.colors.parried[1], g=D.colors.parried[2], b=D.colors.parried[3]}
                },
                {--REFLECTED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_REFLETCED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.reflected) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.reflected = { r, g, b, a } end,
                    default = {r=D.colors.reflected[1], g=D.colors.reflected[2], b=D.colors.reflected[3]}
                },
                {--DAMAGESHIELD
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHIELD_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.damageShield) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damageShield = { r, g, b, a } end,
                    default = {r=D.colors.damageShield[1], g=D.colors.damageShield[2], b=D.colors.damageShield[3]}
                },
                {--DODGE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DODGED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.dodged) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.dodged = { r, g, b, a } end,
                    default = {r=D.colors.dodged[1], g=D.colors.dodged[2], b=D.colors.dodged[3]}
                },
                {--BLOCKED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_BLOCKED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.blocked) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.blocked = { r, g, b, a } end,
                    default = {r=D.colors.blocked[1], g=D.colors.blocked[2], b=D.colors.blocked[3]}
                },
                {--INTERRUPTED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INTERRUPTED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.interrupted) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.interrupted = { r, g, b, a } end,
                    default = {r=D.colors.interrupted[1], g=D.colors.interrupted[2], b=D.colors.interrupted[3]}
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
                    default = {r=D.colors.disoriented[1], g=D.colors.disoriented[2], b=D.colors.disoriented[3]}
                },
                {--FEARED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_FEARED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.feared) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.feared = { r, g, b, a } end,
                    default = {r=D.colors.feared[1], g=D.colors.feared[2], b=D.colors.feared[3]}
                },
                {--OFFBALANCED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_OFF_BALANCE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.offBalanced) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.offBalanced = { r, g, b, a } end,
                    default = {r=D.colors.offBalanced[1], g=D.colors.offBalanced[2], b=D.colors.offBalanced[3]}
                },
                {--SILENCED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_SILENCED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.silenced) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.silenced = { r, g, b, a } end,
                    default = {r=D.colors.silenced[1], g=D.colors.silenced[2], b=D.colors.silenced[3]}
                },
                {--STUNNED
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_STUNNED_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.stunned) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.stunned = { r, g, b, a } end,
                    default = {r=D.colors.stunned[1], g=D.colors.stunned[2], b=D.colors.stunned[3]}
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
                    default = {r=D.colors.inCombat[1], g=D.colors.inCombat[2], b=D.colors.inCombat[3]}
                },
                {--OUT COMBAT
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_OUT_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.outCombat) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.outCombat = { r, g, b, a } end,
                    default = {r=D.colors.outCombat[1], g=D.colors.outCombat[2], b=D.colors.outCombat[3]}
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
                    default = {r=D.colors.alertBlock[1], g=D.colors.alertBlock[2], b=D.colors.alertBlock[3]}
                },
                {--DODGE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DODGE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertDodge) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertDodge = { r, g, b, a } end,
                    default = {r=D.colors.alertDodge[1], g=D.colors.alertDodge[2], b=D.colors.alertDodge[3]}
                },
                {--AVOID
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_AVOID_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertAvoid) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertAvoid = { r, g, b, a } end,
                    default = {r=D.colors.alertAvoid[1], g=D.colors.alertAvoid[2], b=D.colors.alertAvoid[3]}
                },
                {--INTERRUPT
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_INTERRUPT_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertInterrupt) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertInterrupt = { r, g, b, a } end,
                    default = {r=D.colors.alertInterrupt[1], g=D.colors.alertInterrupt[2], b=D.colors.alertInterrupt[3]}
                },
                {--EXPLOIT
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPLOIT_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertExploit) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertExploit = { r, g, b, a } end,
                    default = {r=D.colors.alertExploit[1], g=D.colors.alertExploit[2], b=D.colors.alertExploit[3]}
                },
                {--CLEANSE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CLEANSE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertCleanse) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertCleanse = { r, g, b, a } end,
                    default = {r=D.colors.alertCleanse[1], g=D.colors.alertCleanse[2], b=D.colors.alertCleanse[3]}
                },
                {--EXECUTE
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXECUTE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertExecute) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertExecute = { r, g, b, a } end,
                    default = {r=D.colors.alertExecute[1], g=D.colors.alertExecute[2], b=D.colors.alertExecute[3]}
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
                    default = {r=D.colors.pointsAlliance[1], g=D.colors.pointsAlliance[2], b=D.colors.pointsAlliance[3]}
                },
                {--EXPERIENCE POINTS
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPERIENCE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsExperience) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsExperience = { r, g, b, a } end,
                    default = {r=D.colors.pointsExperience[1], g=D.colors.pointsExperience[2], b=D.colors.pointsExperience[3]}
                },
                {--CHAMPION POINTS
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CHAMPION_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsChampion) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsChampion = { r, g, b, a } end,
                    default = {r=D.colors.pointsChampion[1], g=D.colors.pointsChampion[2], b=D.colors.pointsChampion[3]}
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
                    default = {r=D.colors.lowHealth[1], g=D.colors.lowHealth[2], b=D.colors.lowHealth[3]}
                },
                {--LOW MAGICKA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_MAGICKA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowMagicka) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowMagicka = { r, g, b, a } end,
                    default = {r=D.colors.lowMagicka[1], g=D.colors.lowMagicka[2], b=D.colors.lowMagicka[3]}
                },
                {--LOW STAMINA
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_STAMINA_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowStamina) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowStamina = { r, g, b, a } end,
                    default = {r=D.colors.lowStamina[1], g=D.colors.lowStamina[2], b=D.colors.lowStamina[3]}
                },
                {--ULTIMATE READY
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ULTIMATE_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.ultimateReady) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.ultimateReady = { r, g, b, a } end,
                    default = {r=D.colors.ultimateReady[1], g=D.colors.ultimateReady[2], b=D.colors.ultimateReady[3]}
                },
                {--POTION READY
                    type    = "colorpicker",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POTION_TP),
                    getFunc = function() return unpack(LUIE.CombatText.SV.colors.potionReady) end,
                    setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.potionReady = { r, g, b, a } end,
                    default = {r=D.colors.potionReady[1], g=D.colors.potionReady[2], b=D.colors.potionReady[3]}
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
                    default = D.formats.damage,
                },
				{--DAMAGE CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.damagecritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.damagecritical = v end,
                    isMultiline = false,
                    default = D.formats.damagecritical,
                },
                {--HEALING
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.healing end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.healing = v end,
                    isMultiline = false,
                    default = D.formats.healing,
                },
				{--HEALING CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.healingcritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.healingcritical = v end,
                    isMultiline = false,
                    default = D.formats.healingcritical,
                },
                {--ENERGIZE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.energize end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.energize = v end,
                    isMultiline = false,
                    default = D.formats.energize,
                },
                {-- ULTIMATE ENERGIZE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.ultimateEnergize end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.ultimateEnergize = v end,
                    isMultiline = false,
                    default = D.formats.ultimateEnergize,
                },
                {--DRAIN
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DRAIN_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.drain end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.drain = v end,
                    isMultiline = false,
                    default = D.formats.drain,
                },
                {--DOT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.dot end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.dot = v end,
                    isMultiline = false,
                    default = D.formats.dot,
                },
				{--DOT CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.dotcritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.dotcritical = v end,
                    isMultiline = false,
                    default = D.formats.dotcritical,
                },
                {--HOT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.hot end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.hot = v end,
                    isMultiline = false,
                    default = D.formats.hot,
                },
				{--HOT CRITICAL
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.hotcritical end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.hotcritical = v end,
                    isMultiline = false,
                    default = D.formats.hotcritical,
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
                    default = D.formats.miss,
                },
                {--IMMUNE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_IMMUNE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.immune end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.immune = v end,
                    isMultiline = false,
                    default = D.formats.immune,
                },
                {--PARRIED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_PARRIED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.parried end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.parried = v end,
                    isMultiline = false,
                    default = D.formats.parried,
                },
                {--REFLECTED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_REFLECTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.reflected end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.reflected = v end,
                    isMultiline = false,
                    default = D.formats.reflected,
                },
                {--DAMAGE SHIELD
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_SHIELD_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.damageShield end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.damageShield = v end,
                    isMultiline = false,
                    default = D.formats.damageShield,
                },
                {--DODGED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DODGED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.dodged end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.dodged = v end,
                    isMultiline = false,
                    default = D.formats.dodged,
                },
                {--BLOCKED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_BLOCKED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.blocked end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.blocked = v end,
                    isMultiline = false,
                    default = D.formats.blocked,
                },
                {--INTERRUPTED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_INTERRUPTED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.interrupted end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.interrupted = v end,
                    isMultiline = false,
                    default = D.formats.interrupted,
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
                    default = D.formats.disoriented,
                },
                {--FEARED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_FEARED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.feared end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.feared = v end,
                    isMultiline = false,
                    default = D.formats.feared,
                },
                {--OFFBALANCED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_OFF_BALANCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.offBalanced end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.offBalanced = v end,
                    isMultiline = false,
                    default = D.formats.offBalanced,
                },
                {--SILENCED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_SILENCED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.silenced end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.silenced = v end,
                    isMultiline = false,
                    default = D.formats.silenced,
                },
                {--STUNNED
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_STUNNED_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.stunned end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.stunned = v end,
                    isMultiline = false,
                    default = D.formats.stunned,
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
                    default = D.formats.inCombat,
                },
                {--OUT COMBAT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_COMBAT_OUT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.outCombat end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.outCombat = v end,
                    isMultiline = false,
                    default = D.formats.outCombat,
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
                    default = D.formats.alertCleanse,
                },
                {--BLOCK
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertBlock end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertBlock = v end,
                    isMultiline = false,
                    default = D.formats.alertBlock,
                },
                {--BLOCK
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK_S),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_S_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertBlockStagger end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertBlockStagger = v end,
                    isMultiline = false,
                    default = D.formats.alertBlockStagger,
                },
                {--EXPLOIT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPLOIT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertExploit end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertExploit = v end,
                    isMultiline = false,
                    default = D.formats.alertExploit,
                },
                {--INTERRUPT
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_INTERRUPT_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertInterrupt end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertInterrupt = v end,
                    isMultiline = false,
                    default = D.formats.alertInterrupt,
                },
                {--DODGE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DODGE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertDodge end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertDodge = v end,
                    isMultiline = false,
                    default = D.formats.alertDodge,
                },
                {--AVOID
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_AVOID_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertAvoid end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertAvoid = v end,
                    isMultiline = false,
                    default = D.formats.alertAvoid,
                },
                {--EXECUTE
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXECUTE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.alertExecute end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.alertExecute = v end,
                    isMultiline = false,
                    default = D.formats.alertExecute,
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
                    default = D.formats.pointsAlliance,
                },
                {--EXPERIENCE POINTS
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPERIENCE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.pointsExperience end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.pointsExperience = v end,
                    isMultiline = false,
                    default = D.formats.pointsExperience,
                },
                {--CHAMPION POINTS
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_CHAMPION_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.pointsChampion end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.pointsChampion = v end,
                    isMultiline = false,
                    default = D.formats.pointsChampion,
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
                    default = D.formats.resource,
                },
                {--ULTIMATE READY
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_ULTIMATE_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.ultimateReady end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.ultimateReady = v end,
                    isMultiline = false,
                    default = D.formats.ultimateReady,
                },
                {--ULTIMATE READY
                    type    = "editbox",
                    name    = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY),
                    tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POTION_TP),
                    getFunc = function() return LUIE.CombatText.SV.formats.potionReady end,
                    setFunc = function(v) LUIE.CombatText.SV.formats.potionReady = v end,
                    isMultiline = false,
                    default = D.formats.potionReady,
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
                    choices = CombatCloudConstants.animationType,
                    getFunc = function() return LUIE.CombatText.SV.animation.animationType end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.animationType = v end,
                    default = D.animation.animationType,
                },
                {--INCOMING DIRECTION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN_TP),
                    choices = CombatCloudConstants.directionType,
                    getFunc = function() return LUIE.CombatText.SV.animation.incoming.directionType end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.incoming.directionType = v end,
                    default = D.animation.incoming.directionType,
                },
                {--INCOMING ICON POSITION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN_TP),
                    choices = CombatCloudConstants.iconSide,
                    getFunc = function() return LUIE.CombatText.SV.animation.incomingIcon end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.incomingIcon = v end,
                    default = D.animation.incomingIcon,
                },
                {--OUTGOING DIRECTION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT_TP),
                    choices = CombatCloudConstants.directionType,
                    getFunc = function() return LUIE.CombatText.SV.animation.outgoing.directionType end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.outgoing.directionType = v end,
                    default = D.animation.outgoing.directionType,
                },
                {--OUTGOING ICON POSITION
                    type    = "dropdown",
                    name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT_TP),
                    choices = CombatCloudConstants.iconSide,
                    getFunc = function() return LUIE.CombatText.SV.animation.outgoingIcon end,
                    setFunc = function(v) LUIE.CombatText.SV.animation.outgoingIcon = v end,
                    default = D.animation.outgoingIcon,
                },
                {--TEST BUTTON
                    type = "button",
                    name = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST),
                    tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST_TP),
                    func = function()
                        CALLBACK_MANAGER:FireCallbacks(CombatCloudConstants.eventType.COMBAT, CombatCloudConstants.combatType.INCOMING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                        CALLBACK_MANAGER:FireCallbacks(CombatCloudConstants.eventType.COMBAT, CombatCloudConstants.combatType.OUTGOING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
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
                    default = D.throttles.damage,
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
                    default = D.throttles.dot,
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
                    default = D.throttles.healing,
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
                    default = D.throttles.hot,
                },
                {--THROTTLE TRAILER
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showThrottleTrailer end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.showThrottleTrailer = v end,
                    default = D.toggles.showThrottleTrailer,
                },
                {--CRITS
                    type    = "checkbox",
                    name    = GetString(SI_LUIE_LAM_CT_THROTTLE_CRITICAL),
                    tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_CRITICAL_TP),
                    getFunc = function() return LUIE.CombatText.SV.toggles.showThrottleTrailer end,
                    setFunc = function(v) LUIE.CombatText.SV.toggles.throttleCriticals = v end,
                    default = D.toggles.throttleCriticals,
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
