--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local CA = LUIE.ChatAnnouncements

local strformat = zo_strformat

local optionsDataChatAnnouncements = {}

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
local duelStartOptions              = { "Message + Icon", "Message Only", "Icon Only" }
local duelStartOptionsKeys          = { ["Message + Icon"] = 1, ["Message Only"] = 2, ["Icon Only"] = 3 }

function CA.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelDataChatAnnouncements = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CA)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_CA), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        slashCommand = "/luica",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    -- Chat Announcements Module Description
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

    -- Chat Announcements - Chat Message Settings Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_CHATHEADER),
        controls = {
            {
                -- Player Name Display Method
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD),
                tooltip = GetString(SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD_TP),
                choices = chatNameDisplayOptions,
                getFunc = function() return chatNameDisplayOptions[CA.SV.ChatPlayerDisplayOptions] end,
                setFunc = function(value) CA.SV.ChatPlayerDisplayOptions = chatNameDisplayOptionsKeys[value] CA.IndexGroupLoot() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = chatNameDisplayOptions[2],
            },
            {
                -- Character Name Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[CA.SV.BracketOptionCharacter] end,
                setFunc = function(value) CA.SV.BracketOptionCharacter = linkBracketDisplayOptionsKeys[value] CA.IndexGroupLoot() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.BracketOptionCharacter,
            },
            --[[{
                -- Notification Color
                type = "colorpicker",
                name = "Notification Color (Unimplemented)",
                tooltip = "This message will be used to colorize various generic notification messages that are not Social/Guild related or error messages.",
                getFunc = function() return unpack(CA.SV.Notify.NotificationColor) end,
                setFunc = function(r, g, b, a) CA.SV.Notify.NotificationColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.TodoLater end,
                default = {r=CA.D.Notify.NotificationColor[1], g=CA.D.Notify.NotificationColor[2], b=CA.D.Notify.NotificationColor[3]}
            },]]--
            {
                -- Choose Chat Print Method
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_CHATMETHOD),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATMETHOD_TP),
                choices = { "Print to All Tabs", "Print to Specific Tabs" },
                getFunc = function() return CA.SV.ChatMethod end,
                setFunc = function(value) CA.SV.ChatMethod = value end,
                width = "full",
                sort = "name-up",
                default = CA.D.ChatMethod,
            },
            {
                -- Bypass LUIE to use other chat addons
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CHATBYPASS)),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATBYPASS_TP),
                getFunc = function() return CA.SV.ChatBypass end,
                setFunc = function(value) CA.SV.ChatBypass = value end,
                width = "full",
                disabled = function() return CA.SV.ChatMethod == "Print to Specific Tabs" end,
                default = CA.D.ChatBypass,
            },
            {
                -- Print Chat Announcements & Messages to Tab 1
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "1"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "1"),
                getFunc = function() return CA.SV.ChatTab[1] end,
                setFunc = function(value) CA.SV.ChatTab[1] = value end,
                width = "full",
                disabled = function() return CA.SV.ChatMethod == "Print to All Tabs" end,
                default = CA.D.ChatTab[1],
            },
            {
                -- Print Chat Announcements & Messages to Tab 2
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "2"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "2"),
                getFunc = function() return CA.SV.ChatTab[2] end,
                setFunc = function(value) CA.SV.ChatTab[2] = value end,
                width = "full",
                disabled = function() return CA.SV.ChatMethod == "Print to All Tabs" end,
                default = CA.D.ChatTab[2],
            },
            {
                -- Print Chat Announcements & Messages to Tab 3
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "3"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "3"),
                getFunc = function() return CA.SV.ChatTab[3] end,
                setFunc = function(value) CA.SV.ChatTab[3] = value end,
                width = "full",
                disabled = function() return CA.SV.ChatMethod == "Print to All Tabs" end,
                default = CA.D.ChatTab[3],
            },
            {
                -- Print Chat Announcements & Messages to Tab 4
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "4"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "4"),
                getFunc = function() return CA.SV.ChatTab[4] end,
                setFunc = function(value) CA.SV.ChatTab[4] = value end,
                width = "full",
                disabled = function() return CA.SV.ChatMethod == "Print to All Tabs" end,
                default = CA.D.ChatTab[4],
            },
            {
                -- Print Chat Announcements & Messages to Tab 5
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "5"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "5"),
                getFunc = function() return CA.SV.ChatTab[5] end,
                setFunc = function(value) CA.SV.ChatTab[5] = value end,
                width = "full",
                disabled = function() return CA.SV.ChatMethod == "Print to All Tabs" end,
                default = CA.D.ChatTab[5],
            },
            {
                -- Display System & Notifications in all Tabs
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CHATTABSYSTEMALL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATTABSYSTEMALL_TP),
                getFunc = function() return CA.SV.ChatSystemAll end,
                setFunc = function(value) CA.SV.ChatSystemAll = value end,
                width = "full",
                disabled = function() return CA.SV.ChatMethod == "Print to All Tabs" end,
                default = CA.D.ChatSystemAll,
            },
            {
                -- Include Timestamp
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_TIMESTAMP),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMP_TP),
                getFunc = function() return CA.SV.TimeStamp end,
                setFunc = function(value) CA.SV.TimeStamp = value end,
                width = "full",
                default = CA.D.TimeStamp,
            },
            {
                -- Timestamp Format
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_TIMESTAMPFORMAT)),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMPFORMAT_TP),
                getFunc = function() return CA.SV.TimeStampFormat end,
                setFunc = function(value) CA.SV.TimeStampFormat = value end,
                width = "full",
                disabled = function() return not CA.SV.TimeStamp end,
                default = CA.D.TimeStampFormat,
            },
            {
                -- Timestamp Color
                type    = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_TIMESTAMPCOLOR)),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMPCOLOR_TP),
                getFunc = function() return unpack(CA.SV.TimeStampColor) end,
                setFunc = function(r, g, b, a) CA.SV.TimeStampColor = { r, g, b, a } LUIE.UpdateTimeStampColor() end,
                width = "full",
                disabled = function() return not CA.SV.TimeStamp end,
                default = {r=CA.SV.TimeStampColor[1], g=CA.SV.TimeStampColor[2], b=CA.SV.TimeStampColor[3]},
            },
        },
    }

    -- Chat Announcements - Currency Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_HEADER),
        controls = {
            {
                -- Show Currency Icons
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWICONS_TP),
                getFunc = function() return CA.SV.Currency.CurrencyIcon end,
                setFunc = function(value) CA.SV.Currency.CurrencyIcon = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyIcon,
            },
            {
                -- Show Gold
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLD_TP),
                getFunc = function() return CA.SV.Currency.CurrencyGoldChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyGoldChange = value CA.RegisterGoldEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyGoldChange,
            },
            {
                -- Show Gold Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyGoldColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyGoldColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyGoldColor[1], g=CA.D.Currency.CurrencyGoldColor[2], b=CA.D.Currency.CurrencyGoldColor[3]}
            },
            {
                -- Show Gold Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyGoldName end,
                setFunc = function(value) CA.SV.Currency.CurrencyGoldName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyGoldName,
            },
            {
                -- Show Gold Total Amount
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyGoldShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyGoldShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyGoldShowTotal,
            },
            {
                -- Total Currency Message (Gold)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalGold end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalGold = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyGoldChange and CA.SV.Currency.CurrencyGoldShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalGold,
            },
            {
                -- Show Gold Threshold
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD_TP),
                getFunc = function() return CA.SV.Currency.CurrencyGoldFilter end,
                setFunc = function(value) CA.SV.Currency.CurrencyGoldFilter = value end,
                min = 0,
                max = 10000,
                step = 50,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyGoldFilter,
            },
            {
                -- Throttle Gold Looted
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE_TP),
                getFunc = function() return CA.SV.Currency.CurrencyGoldThrottle end,
                setFunc = function(value) CA.SV.Currency.CurrencyGoldThrottle = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyGoldThrottle,
            },
            {
                -- Hide Gold Spent on AH (Listing)
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHLIST)),
                tooltip = strformat("<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHLIST_TP)),
                getFunc = function() return CA.SV.Currency.CurrencyGoldHideListingAH end,
                setFunc = function(value) CA.SV.Currency.CurrencyGoldHideListingAH = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyGoldHideListingAH,
            },
            {
                -- Hide Gold Spent on AH (Purchase)
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT)),
                tooltip = strformat("<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT_TP)),
                getFunc = function() return CA.SV.Currency.CurrencyGoldHideAH end,
                setFunc = function(value) CA.SV.Currency.CurrencyGoldHideAH = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyGoldHideAH,
            },
            {
                -- Show Alliance Points
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAP_TP),
                getFunc = function() return CA.SV.Currency.CurrencyAPShowChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyAPShowChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyAPShowChange,
            },
            {
                -- Show Alliance Points Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyAPColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyAPColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyAPColor[1], g=CA.D.Currency.CurrencyAPColor[2], b=CA.D.Currency.CurrencyAPColor[3]}
            },
            {
                -- Show Alliance Points Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyAPName end,
                setFunc = function(value) CA.SV.Currency.CurrencyAPName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.TotalCurrencyAPName,
            },
            {
                -- Show Alliance Points Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyAPShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyAPShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyAPShowTotal,
            },
            {
                -- Total Currency Message (Alliance Points)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalAP end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalAP = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyAPShowChange and CA.SV.Currency.CurrencyAPShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalAP,
            },
            {
                -- Show Alliance Points Threshold
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD_TP),
                getFunc = function() return CA.SV.Currency.CurrencyAPFilter end,
                setFunc = function(value) CA.SV.Currency.CurrencyAPFilter = value end,
                min = 0,
                max = 10000,
                step = 50,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyAPFilter,
            },
            {
                -- Throttle Alliance Points Earned
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE_TP),
                getFunc = function() return CA.SV.Currency.CurrencyAPThrottle end,
                setFunc = function(value) CA.SV.Currency.CurrencyAPThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyAPShowChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyAPThrottle,
            },
            {
                -- Show Tel Var
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTV_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTVChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyTVChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyTVChange,
            },
            {
                -- Show Tel Var Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyTVColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyTVColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyTVColor[1], g=CA.D.Currency.CurrencyTVColor[2], b=CA.D.Currency.CurrencyTVColor[3]}
            },
            {
                -- Show Tel Var Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTVName end,
                setFunc = function(value) CA.SV.Currency.CurrencyTVName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyTVName,
            },
            {
                -- Show Tel Var Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTVShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyTVShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyTVShowTotal,
            },
            {
                -- Total Currency Message (Tel Var)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalTV end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalTV = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyAPShowChange and CA.SV.Currency.CurrencyTVShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalTV,
            },
            {
                -- Show Tel Var Stones Threshold
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTVFilter end,
                setFunc = function(value) CA.SV.Currency.CurrencyTVFilter = value end,
                min = 0,
                max = 10000,
                step = 50,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyTVFilter,
            },
            {
                -- Throttle Tel Var Stones Looted
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTVThrottle end,
                setFunc = function(value) CA.SV.Currency.CurrencyTVThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyTVThrottle,
            },
            {
                -- Show Writ Vouchers
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER_TP),
                getFunc = function() return CA.SV.Currency.CurrencyWVChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyWVChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyWVChange,
            },
            {
                -- Show Writ Vouchers Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyWVColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyWVColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyWVColor[1], g=CA.D.Currency.CurrencyWVColor[2], b=CA.D.Currency.CurrencyWVColor[3]}
            },
            {
                -- Show Writ Vouchers Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyWVName end,
                setFunc = function(value) CA.SV.Currency.CurrencyWVName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyWVName,
            },
            {
                -- Show Writ Vouchers Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyWVShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyWVShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyWVChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyWVShowTotal,
            },
            {
                -- Total Currency Message (Writ Vouchers)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalWV end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalWV = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyWVChange and CA.SV.Currency.CurrencyWVShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalWV,
            },
            {
                -- Show Outfit Tokens
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENS_TP),
                getFunc = function() return CA.SV.Currency.CurrencyOutfitTokenChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyOutfitTokenChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyOutfitTokenChange,
            },
            {
                -- Show Outfit Tokens Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyOutfitTokenColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyOutfitTokenColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyOutfitTokenColor[1], g=CA.D.Currency.CurrencyOutfitTokenColor[2], b=CA.D.Currency.CurrencyOutfitTokenColor[3]}
            },
            {
                -- Show Outfit Tokens Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyOutfitTokenName end,
                setFunc = function(value) CA.SV.Currency.CurrencyOutfitTokenName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyOutfitTokenName,
            },
            {
                -- Show Outfit Tokens Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyOutfitTokenShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyOutfitTokenShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyOutfitTokenShowTotal,
            },
            {
                -- Total Currency Message (Outfit Tokens)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TOKENSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TOKENSTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalOutfitToken end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalOutfitToken = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyOutfitTokenChange and CA.SV.Currency.CurrencyOutfitTokenShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalOutfitToken,
            },
            {
                -- Show Transmute Crystals
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTE_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTransmuteChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyTransmuteChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyTransmuteChange,
            },
            {
                -- Show Transmute Crystals Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTECOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyTransmuteColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyTransmuteColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyTransmuteColor[1], g=CA.D.Currency.CurrencyTransmuteColor[2], b=CA.D.Currency.CurrencyTransmuteColor[3]}
            },
            {
                -- Show Transmute Crystals Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTENAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTENAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTransmuteName end,
                setFunc = function(value) CA.SV.Currency.CurrencyTransmuteName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyTransmuteName,
            },
            {
                -- Show Transmute Crystals Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTETOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTETOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyTransmuteShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyTransmuteShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyTransmuteShowTotal,
            },
            {
                -- Total Currency Message (Transmute Crystals)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TRANSMUTETOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TRANSMUTETOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalTransmute end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalTransmute = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyTransmuteChange and CA.SV.Currency.CurrencyTransmuteShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalTransmute,
            },
            {
                -- Show Event Tickets
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENT_TP),
                getFunc = function() return CA.SV.Currency.CurrencyEventChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyEventChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyEventChange,
            },
            {
                -- Show Event Tickets Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyEventColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyEventColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyEventColor[1], g=CA.D.Currency.CurrencyEventColor[2], b=CA.D.Currency.CurrencyEventColor[3]}
            },
            {
                -- Show Event Tickets Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyEventName end,
                setFunc = function(value) CA.SV.Currency.CurrencyEventName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyEventName,
            },
            {
                -- Show Event Tickets Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyEventShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyEventShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyEventShowTotal,
            },
            {
                -- Total Currency Message (Event Tickets)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_EVENTTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_EVENTTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalEvent end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalEvent = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyEventChange and CA.SV.Currency.CurrencyEventShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalEvent,
            },
            {
                -- Show Crowns
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNS_TP),
                getFunc = function() return CA.SV.Currency.CurrencyCrownsChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyCrownsChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyCrownsChange,
            },
            {
                -- Show Crowns Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyCrownsColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyCrownsColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyCrownsColor[1], g=CA.D.Currency.CurrencyCrownsColor[2], b=CA.D.Currency.CurrencyCrownsColor[3]}
            },
            {
                -- Show Crowns Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyCrownsName end,
                setFunc = function(value) CA.SV.Currency.CurrencyCrownsName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyCrownsName,
            },
            {
                -- Show Crowns Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyCrownsShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyCrownsShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyCrownsShowTotal,
            },
            {
                -- Total Currency Message (Crowns)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNSTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalCrowns end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalCrowns = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyCrownsChange and CA.SV.Currency.CurrencyCrownsShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalCrowns,
            },
            {
                -- Show Crown Gems
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMS_TP),
                getFunc = function() return CA.SV.Currency.CurrencyCrownGemsChange end,
                setFunc = function(value) CA.SV.Currency.CurrencyCrownGemsChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyCrownGemsChange,
            },
            {
                -- Show Crown Gems Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSCOLOR)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyCrownGemsColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyCrownGemsColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyCrownGemsColor[1], g=CA.D.Currency.CurrencyCrownGemsColor[2], b=CA.D.Currency.CurrencyCrownGemsColor[3]}
            },
            {
                -- Show Crown Gems Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSNAME_TP),
                getFunc = function() return CA.SV.Currency.CurrencyCrownGemsName end,
                setFunc = function(value) CA.SV.Currency.CurrencyCrownGemsName = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyCrownGemsName,
            },
            {
                -- Show Crown Gems Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSTOTAL_TP),
                getFunc = function() return CA.SV.Currency.CurrencyCrownGemsShowTotal end,
                setFunc = function(value) CA.SV.Currency.CurrencyCrownGemsShowTotal = value end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Currency.CurrencyCrownGemsShowTotal,
            },
            {
                -- Total Currency Message (Crown Gems)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNGEMSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNGEMSTOTAL_MSG_TP),
                getFunc = function() return CA.SV.Currency.CurrencyMessageTotalCrownGems end,
                setFunc = function(value) CA.SV.Currency.CurrencyMessageTotalCrownGems = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Currency.CurrencyCrownGemsChange and CA.SV.Currency.CurrencyCrownGemsShowTotal) end,
                default = CA.D.Currency.CurrencyMessageTotalCrownGems,
            },
        },
    }

    -- Chat Announcements - Loot Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_LOOT_HEADER),
        controls = {
            {
                -- Item Link Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[CA.SV.BracketOptionItem] end,
                setFunc = function(value) CA.SV.BracketOptionItem = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.BracketOptionItem,
            },
            {
                -- Show looted item icons
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWICONS_TP),
                getFunc = function() return CA.SV.Inventory.LootIcons end,
                setFunc = function(value) CA.SV.Inventory.LootIcons = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootIcons,
            },
            {
                -- Show Armor Type
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE_TP),
                getFunc = function() return CA.SV.Inventory.LootShowArmorType end,
                setFunc = function(value) CA.SV.Inventory.LootShowArmorType = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootShowArmorType,
            },
            {
                -- Show Item Style
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE_TP),
                getFunc = function() return CA.SV.Inventory.LootShowStyle end,
                setFunc = function(value) CA.SV.Inventory.LootShowStyle = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootShowStyle,
            },
            {
                -- Show Item Trait
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT_TP),
                getFunc = function() return CA.SV.Inventory.LootShowTrait end,
                setFunc = function(value) CA.SV.Inventory.LootShowTrait = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootShowTrait,
            },
            {
                -- Show loot total
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTAL_TP),
                getFunc = function() return CA.SV.Inventory.LootTotal end,
                setFunc = function(value) CA.SV.Inventory.LootTotal = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootTotal,
            },
            {
                -- Loot total string
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_TOTALSTRING_TP),
                getFunc = function() return CA.SV.Inventory.LootTotalString end,
                setFunc = function(value) CA.SV.Inventory.LootTotalString = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.LootTotal and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootTotalString,
            },
            {
                -- Show looted items
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWITEMS_TP),
                getFunc = function() return CA.SV.Inventory.Loot end,
                setFunc = function(value) CA.SV.Inventory.Loot = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.Loot,
            },
            {
                -- Show notable loot
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE_TP),
                getFunc = function() return CA.SV.Inventory.LootOnlyNotable end,
                setFunc = function(value) CA.SV.Inventory.LootOnlyNotable = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootOnlyNotable,
            },
            {
                -- Show group loot
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT_TP),
                getFunc = function() return CA.SV.Inventory.LootGroup end,
                setFunc = function(value) CA.SV.Inventory.LootGroup = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootGroup,
            },
            {
                -- Hide annoying items
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_TP),
                getFunc = function() return CA.SV.Inventory.LootBlacklist end,
                setFunc = function(value) CA.SV.Inventory.LootBlacklist = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_WARNING),
                disabled = function() return not (CA.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootBlacklist,
            },
            {
                -- Hide Trash Quality Items
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_HIDETRASH_TP),
                getFunc = function() return CA.SV.Inventory.LootNotTrash end,
                setFunc = function(value) CA.SV.Inventory.LootNotTrash = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootNotTrash,
            },
            {
                -- Show Confiscated Items
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTCONFISCATED)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTCONFISCATED_TP),
                getFunc = function() return CA.SV.Inventory.LootConfiscate end,
                setFunc = function(value) CA.SV.Inventory.LootConfiscate = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootConfiscate,
            },
            {
                -- Show Destroyed Items
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED_TP),
                getFunc = function() return CA.SV.Inventory.LootShowDestroy end,
                setFunc = function(value) CA.SV.Inventory.LootShowDestroy = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootShowDestroy,
            },
            {
                -- Show Removed Items
                type = "checkbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWREMOVED)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWREMOVED_TP),
                getFunc = function() return CA.SV.Inventory.LootShowRemove end,
                setFunc = function(value) CA.SV.Inventory.LootShowRemove = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.Loot and CA.SV.Inventory.LootShowDestroy and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootShowRemove,
            },
            {
                -- Show Lockpick Break
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK_TP),
                getFunc = function() return CA.SV.Inventory.LootShowLockpick end,
                setFunc = function(value) CA.SV.Inventory.LootShowLockpick = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.Loot and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootShowLockpick,
            },
            {
                -- Show Quest Loot (Add)
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD_TP),
                getFunc = function() return CA.SV.Inventory.LootQuestAdd end,
                setFunc = function(value) CA.SV.Inventory.LootQuestAdd = value CA.RegisterLootEvents() CA.AddQuestItemsToIndex() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootQuestAdd,
            },
            {
                -- Show Quest Loot (Remove)
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM_TP),
                getFunc = function() return CA.SV.Inventory.LootQuestRemove end,
                setFunc = function(value) CA.SV.Inventory.LootQuestRemove = value CA.RegisterLootEvents() CA.AddQuestItemsToIndex() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootQuestRemove,
            },
            {
                -- Show Vendor Inventory Changes
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWVENDOR_TP),
                getFunc = function() return CA.SV.Inventory.LootVendor end,
                setFunc = function(value) CA.SV.Inventory.LootVendor = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootVendor,
            },
            {
                -- Merge Currency & Loot Message
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE_TP),
                getFunc = function() return CA.SV.Inventory.LootVendorCurrency end,
                setFunc = function(value) CA.SV.Inventory.LootVendorCurrency = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.LootVendor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootVendorCurrency,
            },
            {
                -- Loot Vendor Total Items
                type = "checkbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS_TP),
                getFunc = function() return CA.SV.Inventory.LootVendorTotalItems end,
                setFunc = function(value) CA.SV.Inventory.LootVendorTotalItems = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.LootVendor and CA.SV.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootVendorTotalItems,
            },
            {
                -- Loot Vendor Total Currency
                type = "checkbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY_TP),
                getFunc = function() return CA.SV.Inventory.LootVendorTotalCurrency end,
                setFunc = function(value) CA.SV.Inventory.LootVendorTotalCurrency = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.LootVendor and CA.SV.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootVendorTotalCurrency,
            },
            {
                -- Show Bank Inventory Changes
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWBANK_TP),
                getFunc = function() return CA.SV.Inventory.LootBank end,
                setFunc = function(value) CA.SV.Inventory.LootBank = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootBank,
            },
            {
                -- Show Craft
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_TP),
                getFunc = function() return CA.SV.Inventory.LootCraft end,
                setFunc = function(value) CA.SV.Inventory.LootCraft = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootCraft,
            },
            {
                -- Show Materials consumed when crafting
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS_TP),
                getFunc = function() return CA.SV.Inventory.LootShowCraftUse end,
                setFunc = function(value) CA.SV.Inventory.LootShowCraftUse = value end,
                width = "full",
                disabled = function() return not (CA.SV.Inventory.LootCraft and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Inventory.LootShowCraftUse,
            },
            {
                -- Show Mail Inventory Changes
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWMAIL_TP),
                getFunc = function() return CA.SV.Inventory.LootMail end,
                setFunc = function(value) CA.SV.Inventory.LootMail = value CA.RegisterMailEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootMail,
            },
            {
                -- Show Trade
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_SHOWTRADE_TP),
                getFunc = function() return CA.SV.Inventory.LootTrade end,
                setFunc = function(value) CA.SV.Inventory.LootTrade = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootTrade,
            },
            {
                -- Show Disguise Equip
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE_TP),
                getFunc = function() return CA.SV.Inventory.LootShowDisguise end,
                setFunc = function(value) CA.SV.Inventory.LootShowDisguise = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Inventory.LootShowDisguise,
            },
        },
    }

    -- Chat Announcements - Shared Currency/Loot Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_CURRENCY_CONTEXT_MENU),
        controls = {
            {
                -- Currency/Loot Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyColor) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable or CA.SV.Currency.CurrencyContextColor end,
                default = {r=CA.D.Currency.CurrencyColor[1], g=CA.D.Currency.CurrencyColor[2], b=CA.D.Currency.CurrencyColor[3]}
            },
            {
                -- Use Context Color for Currency/Loot Messages
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT_TP),
                getFunc = function() return CA.SV.Currency.CurrencyContextColor end,
                setFunc = function(value) CA.SV.Currency.CurrencyContextColor = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Currency.CurrencyContextColor,
            },
            {
                -- Positive Change Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORUP)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyColorUp) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyColorUp = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyColorUp[1], g=CA.D.Currency.CurrencyColorUp[2], b=CA.D.Currency.CurrencyColorUp[3]}
            },
            {
                -- Negative Change Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORDOWN)),
                getFunc = function() return unpack(CA.SV.Currency.CurrencyColorDown) end,
                setFunc = function(r, g, b, a) CA.SV.Currency.CurrencyColorDown = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Currency.CurrencyColorDown[1], g=CA.D.Currency.CurrencyColorDown[2], b=CA.D.Currency.CurrencyColorDown[3]}
            },
            {
                -- Context Messages Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_CONTEXT_HEADER),
                width = "full",
            },
            {
                -- Loot Message (Loot)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageLoot end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageLoot = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageLoot,
            },
            {
                -- Loot Message (Receive)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageReceive end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageReceive = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageReceive,
            },
            {
                -- Earned Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageEarn end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageEarn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageEarn,
            },
            {
                -- Loot Message (Steal)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageSteal end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageSteal = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageSteal,
            },
            {
                -- Loot Message (Pickpocket)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessagePickpocket end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessagePickpocket = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessagePickpocket,
            },
            {
                -- Loot Message (Confiscate)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageConfiscate end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageConfiscate = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageConfiscate,
            },
            {
                -- Loot Message (Spend)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageSpend end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageSpend = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageSpend,
            },
            {
                -- Loot Message (Pay)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PAY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PAY_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessagePay end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessagePay = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessagePay,
            },
            {
                -- Loot Message (TradeIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageTradeIn end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageTradeIn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageTradeIn,
            },
            {
                -- Loot Message (TradeIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_NO_NAME_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageTradeInNoName end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageTradeInNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageTradeInNoName,
            },
            {
                -- Loot Message (TradeOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageTradeOut end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageTradeOut = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageTradeOut,
            },
            {
                -- Loot Message (TradeOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_NO_NAME_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageTradeOutNoName end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageTradeOutNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageTradeOutNoName,
            },
            {
                -- Loot Message (MailIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageMailIn end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageMailIn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageMailIn,
            },
            {
                -- Loot Message (MailIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_NO_NAME_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageMailInNoName end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageMailInNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageMailInNoName,
            },
            {
                -- Loot Message (MailOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageMailOut end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageMailOut = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageMailOut,
            },
            {
                -- Loot Message (MailOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_NO_NAME_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageMailOutNoName end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageMailOutNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageMailOutNoName,
            },
            {
                -- Loot Message (Deposit)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDeposit end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDeposit = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDeposit,
            },
            {
                -- Loot Message (Withdraw)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageWithdraw end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageWithdraw = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageWithdraw,
            },
            {
                -- Loot Message (Deposit Guild)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDepositGuild end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDepositGuild  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDepositGuild ,
            },
            {
                -- Loot Message (Withdraw Guild)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageWithdrawGuild  end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageWithdrawGuild  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageWithdrawGuild ,
            },
            {
                -- Loot Message (Deposit)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITSTORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITSTORAGE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDepositStorage end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDepositStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDepositStorage,
            },
            {
                -- Loot Message (Withdraw)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWSTORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWSTORAGE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageWithdrawStorage end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageWithdrawStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageWithdrawStorage,
            },
            {
                -- Lost Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageLost end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageLost = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageLost,
            },
            {
                -- Bounty Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageBounty end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageBounty = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageBounty,
            },
            {
                -- Repair Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageRepair end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageRepair = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageRepair,
            },
            {
                -- Trader Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageTrader end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageTrader = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageTrader,
            },
            {
                -- Listing Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageListing end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageListing = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageListing,
            },
            {
                -- Loot Message (Buy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_VALUE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageBuy end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageBuy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageBuy,
            },
            {
                -- Loot Message (Buy) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageBuyNoV end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageBuyNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageBuyNoV,
            },
            {
                -- Loot Message (Buyback)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_VALUE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageBuyback end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageBuyback = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageBuyback,
            },
            {
                -- Loot Message (Buyback) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageBuybackNoV end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageBuybackNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageBuybackNoV,
            },
            {
                -- Loot Message (Sell)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_VALUE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageSell end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageSell = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageSell,
            },
            {
                -- Loot Message (Sell) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageSellNoV end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageSellNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageSellNoV,
            },
            {
                -- Loot Message (Fence)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_VALUE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageFence end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageFence = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageFence,
            },
            {
                -- Loot Message (Fence)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageFenceNoV end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageFenceNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageFenceNoV,
            },
            {
                -- Loot Message (Launder)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_VALUE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageLaunder end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageLaunder = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageLaunder,
            },
            {
                -- Loot Message (Launder)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageLaunderNoV end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageLaunderNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageLaunderNoV,
            },
            {
                -- Stable Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageStable end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageStable = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageStable,
            },
            {
                -- Storage Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageStorage end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageStorage,
            },
            {
                -- Wayshrine Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageWayshrine end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageWayshrine = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageWayshrine,
            },
            {
                -- Unstuck Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageUnstuck end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageUnstuck = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageUnstuck,
            },
            {
                -- Attributes Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageAttributes end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageAttributes = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageAttributes,
            },
            {
                -- Champion Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageChampion end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageChampion = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageChampion,
            },
            {
                -- Morphs Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageMorphs end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageMorphs = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageMorphs,
            },
            {
                -- Skills Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageSkills end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageSkills = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageSkills,
            },
            {
                -- Campaign Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageCampaign end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageCampaign = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageCampaign,
            },
            {
                -- Loot Message (Use)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_USE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_USE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageUse end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageUse = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageUse,
            },
            {
                -- Loot Message (Craft)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CRAFT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CRAFT_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageCraft end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageCraft = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageCraft,
            },
            {
                -- Loot Message (Extract)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXTRACT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXTRACT_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageExtract end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageExtract = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageExtract,
            },
            {
                -- Loot Message (Upgrade)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageUpgrade end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageUpgrade = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageUpgrade,
            },
            {
                -- Loot Message (Upgrade)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_FAIL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_FAIL_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageUpgradeFail end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageUpgradeFail = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageUpgradeFail,
            },
            {
                -- Loot Message (Refine)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REFINE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REFINE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageRefine end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageRefine = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageRefine,
            },
            {
                -- Loot Message (Deconstruct)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DECONSTRUCT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DECONSTRUCT_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDeconstruct end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDeconstruct = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDeconstruct,
            },
            {
                -- Loot Message (Research)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RESEARCH),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RESEARCH_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageResearch end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageResearch = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageResearch,
            },
            {
                -- Loot Message (Destroy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DESTROY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DESTROY_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDestroy end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDestroy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDestroy,
            },
            {
                -- Loot Message (Lockpick)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOCKPICK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOCKPICK_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageLockpick end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageLockpick = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageLockpick,
            },
            {
                -- Loot Message Removed (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REMOVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REMOVE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageRemove end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageRemove = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageRemove,
            },
            {
                -- Loot Message Group
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_GROUP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_GROUP_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageGroup end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageGroup = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageGroup,
            },
            {
                -- Loot Message (Disguise Equip)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_EQUIP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_EQUIP_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDisguiseEquip end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDisguiseEquip = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDisguiseEquip,
            },
            {
                -- Loot Message (Disguise Remove)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_REMOVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_REMOVE_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDisguiseRemove end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDisguiseRemove = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDisguiseRemove,
            },
            {
                -- Loot Message (Disguise Destroy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_DESTROY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_DESTROY_TP),
                getFunc = function() return CA.SV.ContextMessages.CurrencyMessageDisguiseDestroy end,
                setFunc = function(value) CA.SV.ContextMessages.CurrencyMessageDisguiseDestroy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.ContextMessages.CurrencyMessageDisguiseDestroy,
            },
        },
    }

    -- Chat Announcements - Experience Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_EXP_HEADER),
        controls = {
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_ENLIGHTENED),
                width = "full",
            },
            {
                -- Enlightenment (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.XP.ExperienceEnlightenedCA end,
                setFunc = function(value) CA.SV.XP.ExperienceEnlightenedCA = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.XP.ExperienceEnlightenedCA,
            },
            {
                -- Enlightenment (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.XP.ExperienceEnlightenedCSA end,
                setFunc = function(value) CA.SV.XP.ExperienceEnlightenedCSA = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.XP.ExperienceEnlightenedCSA,
            },
            {
                -- Enlightenment (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.XP.ExperienceEnlightenedAlert end,
                setFunc = function(value) CA.SV.XP.ExperienceEnlightenedAlert = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.XP.ExperienceEnlightenedAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_LEVELUP),
                width = "full",
            },
            {
                -- Level Up (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.XP.ExperienceLevelUpCA end,
                setFunc = function(value) CA.SV.XP.ExperienceLevelUpCA = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.XP.ExperienceLevelUpCA,
            },
            {
                -- Level Up (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.XP.ExperienceLevelUpCSA end,
                setFunc = function(value) CA.SV.XP.ExperienceLevelUpCSA = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.XP.ExperienceLevelUpCSA,
            },
            {
                -- Level Up CSA Expanded
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND_TP),
                getFunc = function() return CA.SV.XP.ExperienceLevelUpCSAExpand end,
                setFunc = function(value) CA.SV.XP.ExperienceLevelUpCSAExpand = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.XP.ExperienceLevelUpCSA and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceLevelUpCSAExpand,
            },
            {
                -- Level Up (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_LEVELUP_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.XP.ExperienceLevelUpAlert end,
                setFunc = function(value) CA.SV.XP.ExperienceLevelUpAlert = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.XP.ExperienceLevelUpAlert,
            },
            {
                -- Show Level Icon on Level Up
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_LVLUPICON_TP),
                getFunc = function() return CA.SV.XP.ExperienceLevelUpIcon end,
                setFunc = function(value) CA.SV.XP.ExperienceLevelUpIcon = value end,
                width = "full",
                disabled = function() return not (CA.SV.XP.ExperienceLevelUpCA or CA.SV.XP.ExperienceLevelUpCSA or CA.SV.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceExperienceLevelUpIcon,
            },
            {
                -- Experience Level Up Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_LEVELUP_COLOR)),
                getFunc = function() return unpack(CA.SV.XP.ExperienceLevelUpColor) end,
                setFunc = function(r, g, b, a) CA.SV.XP.ExperienceLevelUpColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.XP.ExperienceLevelUpCA or CA.SV.XP.ExperienceLevelUpCSA or CA.SV.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.XP.ExperienceLevelUpColor[1], g=CA.D.XP.ExperienceLevelUpColor[2], b=CA.D.XP.ExperienceLevelUpColor[3]}
            },
            {
                -- Color Level by Context
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT_TP),
                getFunc = function() return CA.SV.XP.ExperienceLevelColorByLevel end,
                setFunc = function(value) CA.SV.XP.ExperienceLevelColorByLevel = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.XP.ExperienceLevelUpCA or CA.SV.XP.ExperienceLevelUpCSA or CA.SV.XP.ExperienceLevelUpAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceLevelColorByLevel,
            },
            {
                -- Experience Points Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_EXPERIENCEGAIN),
                width = "full",
            },
            {
                -- Show Experience Gain
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN_TP),
                getFunc = function() return CA.SV.XP.Experience end,
                setFunc = function(value) CA.SV.XP.Experience = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.XP.Experience,
            },
            {
                -- Show Experience Icon
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_SHOWEXPICON_TP),
                getFunc = function() return CA.SV.XP.ExperienceIcon end,
                setFunc = function(value) CA.SV.XP.ExperienceIcon = value end,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceIcon,
            },
            {
                -- Experience Message Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORMESSAGE)),
                getFunc = function() return unpack(CA.SV.XP.ExperienceColorMessage) end,
                setFunc = function(r, g, b, a) CA.SV.XP.ExperienceColorMessage = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.XP.ExperienceColorMessage[1], g=CA.D.XP.ExperienceColorMessage[2], b=CA.D.XP.ExperienceColorMessage[3]}
            },
            {
                -- Experience Name Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXPERIENCE_COLORNAME)),
                getFunc = function() return unpack(CA.SV.XP.ExperienceColorName) end,
                setFunc = function(r, g, b, a) CA.SV.XP.ExperienceColorName = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.XP.ExperienceColorName[1], g=CA.D.XP.ExperienceColorName[2], b=CA.D.XP.ExperienceColorName[3]}
            },
            {
                -- Context Name for Experience Gain
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_MESSAGE)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_MESSAGE_TP),
                getFunc = function() return CA.SV.XP.ExperienceMessage end,
                setFunc = function(value) CA.SV.XP.ExperienceMessage = value end,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceMessage,
            },
            {
                -- Name for Experience Gain
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_NAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_NAME_TP),
                getFunc = function() return CA.SV.XP.ExperienceName end,
                setFunc = function(value) CA.SV.XP.ExperienceName = value end,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceName,
            },
            {
                -- Hide Experience from Kills
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS_TP),
                getFunc = function() return CA.SV.XP.ExperienceHideCombat end,
                setFunc = function(value) CA.SV.XP.ExperienceHideCombat = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceHideCombat,
            },
            {
                -- Combat Experience Gain Filter Threshold
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD_TP),
                getFunc = function() return CA.SV.XP.ExperienceFilter end,
                setFunc = function(value) CA.SV.XP.ExperienceFilter = value end,
                min = 0,
                max = 10000,
                step = 100,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceFilter,
            },
            {
                -- Throttle Experience gained in combat
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT)),
                tooltip = GetString(SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT_TP),
                getFunc = function() return CA.SV.XP.ExperienceThrottle end,
                setFunc = function(value) CA.SV.XP.ExperienceThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (CA.SV.XP.Experience and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.XP.ExperienceThrottle,
            },
            {
                -- Skill Points Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_SKILL_POINTS),
                width = "full",
            },
            {
                -- Show Skill Points Updated CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Skills.SkillPointCA end,
                setFunc = function(value) CA.SV.Skills.SkillPointCA = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillPointCA,
            },
            {
                -- Show Skill Points Updated CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Skills.SkillPointCSA end,
                setFunc = function(value) CA.SV.Skills.SkillPointCSA = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillPointCSA,
            },
            {
                -- Show Skill Points Updated Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Skills.SkillPointAlert end,
                setFunc = function(value) CA.SV.Skills.SkillPointAlert = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillPointAlert,
            },
            {
                -- Skill Point Color 1
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR1)),
                getFunc = function() return unpack(CA.SV.Skills.SkillPointColor1) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillPointColor1 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not ( CA.SV.Skills.SkillPointCA or CA.SV.Skills.SkillPointCSA or CA.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Skills.SkillPointColor1[1], g=CA.D.Skills.SkillPointColor1[2], b=CA.D.Skills.SkillPointColor1[3]}
            },
            {
                -- Skill Point Color 2
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_COLOR2)),
                getFunc = function() return unpack(CA.SV.Skills.SkillPointColor2) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillPointColor2 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not ( CA.SV.Skills.SkillPointCA or CA.SV.Skills.SkillPointCSA or CA.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Skills.SkillPointColor2[1], g=CA.D.Skills.SkillPointColor2[2], b=CA.D.Skills.SkillPointColor2[3]}
            },
            {
                -- Skyshard Prefix
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX_TP),
                getFunc = function() return CA.SV.Skills.SkillPointSkyshardMsg end,
                setFunc = function(value) CA.SV.Skills.SkillPointSkyshardMsg = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not ( CA.SV.Skills.SkillPointCA or CA.SV.Skills.SkillPointCSA or CA.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Skills.SkillPointSkyshardMsg,
            },
            {
                -- Skyshard Brackets
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET_TP),
                choices = bracketOptions5,
                getFunc = function() return bracketOptions5[CA.SV.Skills.SkillPointBracket] end,
                setFunc = function(value) CA.SV.Skills.SkillPointBracket = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not ( CA.SV.Skills.SkillPointCA or CA.SV.Skills.SkillPointCSA or CA.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Skills.SkillPointBracket
            },
            {
                -- Show Skill Points Updated Partial
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL_TP),
                getFunc = function() return CA.SV.Skills.SkillPointsPartial end,
                setFunc = function(value) CA.SV.Skills.SkillPointsPartial = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not ( CA.SV.Skills.SkillPointCA or CA.SV.Skills.SkillPointCSA or CA.SV.Skills.SkillPointAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Skills.SkillPointsPartial,
            },
            {
                -- Skill Lines Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_SKILL_LINES),
                width = "full",
            },
            {
                -- Skill Line Unlocked CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Skills.SkillLineUnlockCA end,
                setFunc = function(value) CA.SV.Skills.SkillLineUnlockCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillLineUnlockCA,
            },
            {
                -- Skill Line Unlocked CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Skills.SkillLineUnlockCSA end,
                setFunc = function(value) CA.SV.Skills.SkillLineUnlockCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillLineUnlockCSA,
            },
            {
                -- Skill Line Unlocked Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Skills.SkillLineUnlockAlert end,
                setFunc = function(value) CA.SV.Skills.SkillLineUnlockAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillLineUnlockAlert,
            },
            {
                -- Skill Line Icon
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_SKILL_LINE_ICON_TP),
                getFunc = function() return CA.SV.Skills.SkillLineIcon end,
                setFunc = function(value) CA.SV.Skills.SkillLineIcon = value end,
                width = "full",
                disabled = function() return not (
                    CA.SV.Skills.SkillLineUnlockCA or
                    CA.SV.Skills.SkillLineUnlockCSA or
                    CA.SV.Skills.SkillLineUnlockAlert and
                    LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Skills.SkillLineIcon,
            },
            {
                -- Skill Line Progression CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Skills.SkillLineCA end,
                setFunc = function(value) CA.SV.Skills.SkillLineCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillLineCA,
            },
            {
                -- Skill Line Progression CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Skills.SkillLineCSA end,
                setFunc = function(value) CA.SV.Skills.SkillLineCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillLineCSA,
            },
            {
                -- Skill Line Progression Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Skills.SkillLineAlert end,
                setFunc = function(value) CA.SV.Skills.SkillLineAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillLineAlert,
            },
            {
                -- Skill Ability Progression CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Skills.SkillAbilityCA end,
                setFunc = function(value) CA.SV.Skills.SkillAbilityCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillAbilityCA,
            },
            {
                -- Skill Ability Progression CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Skills.SkillAbilityCSA end,
                setFunc = function(value) CA.SV.Skills.SkillAbilityCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillAbilityCSA,
            },
            {
                -- Skill Ability Progression Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Skills.SkillAbilityAlert end,
                setFunc = function(value) CA.SV.Skills.SkillAbilityAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillAbilityAlert,
            },
            {
                -- Skill Line Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SKILL_LINE_COLOR)),
                getFunc = function() return unpack(CA.SV.Skills.SkillLineColor) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillLineColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                    CA.SV.Skills.SkillLineUnlockCA or
                    CA.SV.Skills.SkillLineUnlockCSA or
                    CA.SV.Skills.SkillLineUnlockAlert or
                    CA.SV.Skills.SkillLineAlertCA or
                    CA.SV.Skills.SkillLineAlertCSA or
                    CA.SV.Skills.SkillLineAlertAlert or
                    CA.SV.Skills.SkillAbilityCA or
                    CA.SV.Skills.SkillAbilityCSA or
                    CA.SV.Skills.SkillAbilityAlert and
                    LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Skills.SkillLineColor[1], g=CA.D.Skills.SkillLineColor[2], b=CA.D.Skills.SkillLineColor[3]}
            },
            {
                -- Guild Reputation Header
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_EXP_HEADER_GUILDREP),
                width = "full",
            },
            {
                -- Display Guild Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_ICON),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_ICON_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildIcon end,
                setFunc = function(value) CA.SV.Skills.SkillGuildIcon = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildIcon,
            },
            {
                -- Guild Reputation Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGECOLOR),
                getFunc = function() return unpack(CA.SV.Skills.SkillGuildColor) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillGuildColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = {r=CA.D.Skills.SkillGuildColor[1], g=CA.D.Skills.SkillGuildColor[2], b=CA.D.Skills.SkillGuildColor[3]}
            },
            {
                -- Guild Reputation Message Format
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildMsg end,
                setFunc = function(value) CA.SV.Skills.SkillGuildMsg = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildMsg,
            },
            {
                -- Guild Reputation Points Name
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildRepName end,
                setFunc = function(value) CA.SV.Skills.SkillGuildRepName = value CA.RegisterXPEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildRepName,
            },
            {
                -- Skill Fighters Guild
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_FG),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_FG_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildFighters end,
                setFunc = function(value) CA.SV.Skills.SkillGuildFighters = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildFighters,
            },
            {
                -- Guild Skill Point Color FG
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_FG_COLOR)),
                getFunc = function() return unpack(CA.SV.Skills.SkillGuildColorFG) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillGuildColorFG = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildFighters) end,
                default = {r=CA.D.Skills.SkillGuildColorFG[1], g=CA.D.Skills.SkillGuildColorFG[2], b=CA.D.Skills.SkillGuildColorFG[3]}
            },
            {
                -- Fighter's Guild Threshold
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THRESHOLD_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildThreshold end,
                setFunc = function(value) CA.SV.Skills.SkillGuildThreshold = value end,
                min = 0,
                max = 5,
                step = 1,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildFighters) end,
                default = CA.D.Skills.SkillGuildThreshold,
            },
            {
                -- Fighter's Guild Throttle
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE)),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_THROTTLE_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildThrottle end,
                setFunc = function(value) CA.SV.Skills.SkillGuildThrottle = value end,
                min = 0,
                max = 5000,
                step = 50,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildFighters) end,
                default = CA.D.Skills.SkillGuildThrottle,
            },
            {
                -- Skill Mages Guild
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_MG),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_MG_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildMages end,
                setFunc = function(value) CA.SV.Skills.SkillGuildMages = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildMages,
            },
            {
                -- Guild Skill Point Color MG
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_MG_COLOR)),
                getFunc = function() return unpack(CA.SV.Skills.SkillGuildColorMG) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillGuildColorMG = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildMages) end,
                default = {r=CA.D.Skills.SkillGuildColorMG[1], g=CA.D.Skills.SkillGuildColorMG[2], b=CA.D.Skills.SkillGuildColorMG[3]}
            },
            {
                -- Skill Undaunted
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_UD),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_UD_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildUndaunted end,
                setFunc = function(value) CA.SV.Skills.SkillGuildUndaunted = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildUndaunted,
            },
            {
                -- Guild Skill Point Color UD
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_UD_COLOR)),
                getFunc = function() return unpack(CA.SV.Skills.SkillGuildColorUD) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillGuildColorUD = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildUndaunted) end,
                default = {r=CA.D.Skills.SkillGuildColorUD[1], g=CA.D.Skills.SkillGuildColorUD[2], b=CA.D.Skills.SkillGuildColorUD[3]}
            },
            {
                -- Skill Thieves Guild
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_TG),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_TG_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildThieves end,
                setFunc = function(value) CA.SV.Skills.SkillGuildThieves = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildThieves,
            },
            {
                -- Guild Skill Point Color TG
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_TG_COLOR)),
                getFunc = function() return unpack(CA.SV.Skills.SkillGuildColorTG) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillGuildColorTG = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildThieves) end,
                default = {r=CA.D.Skills.SkillGuildColorTG[1], g=CA.D.Skills.SkillGuildColorTG[2], b=CA.D.Skills.SkillGuildColorTG[3]}
            },
            {
                -- Skill Dark Brotherhood
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_DB),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_DB_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildDarkBrotherhood end,
                setFunc = function(value) CA.SV.Skills.SkillGuildDarkBrotherhood = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildDarkBrotherhood,
            },
            {
                -- Guild Skill Point Color DB
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_DB_COLOR)),
                getFunc = function() return unpack(CA.SV.Skills.SkillGuildColorDB) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillGuildColorDB = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildDarkBrotherhood) end,
                default = {r=CA.D.Skills.SkillGuildColorDB[1], g=CA.D.Skills.SkillGuildColorDB[2], b=CA.D.Skills.SkillGuildColorDB[3]}
            },
            {
                -- Skill Psijic Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_PO),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_PO_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildPsijicOrder end,
                setFunc = function(value) CA.SV.Skills.SkillGuildPsijicOrder = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildPsijicOrder,
            },
            {
                -- Guild Skill Point Color PO
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_PO_COLOR)),
                getFunc = function() return unpack(CA.SV.Skills.SkillGuildColorPO) end,
                setFunc = function(r, g, b, a) CA.SV.Skills.SkillGuildColorPO = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and CA.SV.Skills.SkillGuildDarkBrotherhood) end,
                default = {r=CA.D.Skills.SkillGuildColorPO[1], g=CA.D.Skills.SkillGuildColorPO[2], b=CA.D.Skills.SkillGuildColorPO[3]}
            },
            {
                -- Skill Guild Alert
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_ALERT_TP),
                getFunc = function() return CA.SV.Skills.SkillGuildAlert end,
                setFunc = function(value) CA.SV.Skills.SkillGuildAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Skills.SkillGuildAlert,
            },
        },
    }

    -- Chat Announcements - Collectible/Lorebooks Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_HEADER),
        controls = {
            {
                --
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COL_HEADER),
                width = "full",
            },
            {
                -- Show Collectibles Unlocked CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Collectibles.CollectibleCA end,
                setFunc = function(value) CA.SV.Collectibles.CollectibleCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Collectibles.CollectibleCA,
            },
            {
                -- Show Collectibles Unlocked CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Collectibles.CollectibleCSA end,
                setFunc = function(value) CA.SV.Collectibles.CollectibleCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Collectibles.CollectibleCSA,
            },
            {
                -- Show Collectibles Unlocked Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Collectibles.CollectibleAlert end,
                setFunc = function(value) CA.SV.Collectibles.CollectibleAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Collectibles.CollectibleAlert,
            },
            {
                -- Collectible Icon
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_ICON_TP),
                getFunc = function() return CA.SV.Collectibles.CollectibleIcon end,
                setFunc = function(value) CA.SV.Collectibles.CollectibleIcon = value end,
                width = "full",
                disabled = function() return not (CA.SV.Collectibles.CollectibleCA or CA.SV.Collectibles.CollectibleCSA or CA.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Collectibles.CollectibleIcon,
            },
            {
                -- Collectible Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[CA.SV.BracketOptionCollectible] end,
                setFunc = function(value) CA.SV.BracketOptionCollectible = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (CA.SV.Collectibles.CollectibleCA or CA.SV.Collectibles.CollectibleCSA or CA.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.BracketOptionCollectible,
            },
            {
                -- Collectible Color 1
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_ONE)),
                getFunc = function() return unpack(CA.SV.Collectibles.CollectibleColor1) end,
                setFunc = function(r, g, b, a) CA.SV.Collectibles.CollectibleColor1 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Collectibles.CollectibleCA or CA.SV.Collectibles.CollectibleCSA or CA.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Collectibles.CollectibleColor1[1], g=CA.D.Collectibles.CollectibleColor1[2], b=CA.D.Collectibles.CollectibleColor1[3]}
            },
            {
                -- Collectible Color 2
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_TWO)),
                getFunc = function() return unpack(CA.SV.Collectibles.CollectibleColor2) end,
                setFunc = function(r, g, b, a) CA.SV.Collectibles.CollectibleColor2 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Collectibles.CollectibleCA or CA.SV.Collectibles.CollectibleCSA or CA.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Collectibles.CollectibleColor2[1], g=CA.D.Collectibles.CollectibleColor2[2], b=CA.D.Collectibles.CollectibleColor2[3]}
            },
            {
                -- Collectible Message Prefix
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX_TP),
                getFunc = function() return CA.SV.Collectibles.CollectiblePrefix end,
                setFunc = function(value) CA.SV.Collectibles.CollectiblePrefix = value end,
                width = "full",
                disabled = function() return not (CA.SV.Collectibles.CollectibleCA or CA.SV.Collectibles.CollectibleCSA or CA.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Collectibles.CollectiblePrefix,
            },
            {
                -- Collectible Bracket Options
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET_TP),
                choices = bracketOptions5,
                getFunc = function() return bracketOptions5[CA.SV.Collectibles.CollectibleBracket] end,
                setFunc = function(value) CA.SV.Collectibles.CollectibleBracket = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not (CA.SV.Collectibles.CollectibleCA or CA.SV.Collectibles.CollectibleCSA or CA.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Collectibles.CollectibleBracket
            },
            {
                -- Collectible Category
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY)),
                tooltip = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY_TP),
                getFunc = function() return CA.SV.Collectibles.CollectibleCategory end,
                setFunc = function(value) CA.SV.Collectibles.CollectibleCategory = value end,
                width = "full",
                disabled = function() return not (CA.SV.Collectibles.CollectibleCA or CA.SV.Collectibles.CollectibleCSA or CA.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Collectibles.CollectibleCategory,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_COLLECTIBLE_LORE_HEADER),
                width = "full",
            },
            {
                -- Lorebook Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[CA.SV.BracketOptionLorebook] end,
                setFunc = function(value) CA.SV.BracketOptionLorebook = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.BracketOptionLorebook,
            },
            {
                -- Show Lorebooks (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Lorebooks.LorebookCA end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Lorebooks.LorebookCA,
            },
            {
                -- Show Lorebooks (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Lorebooks.LorebookCSA end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Lorebooks.LorebookCSA,
            },
            {
                -- Show Lorebooks (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Lorebooks.LorebookAlert end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Lorebooks.LorebookAlert,
            },
            {
                -- Show Lorebook Collection Complete (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Lorebooks.LorebookCollectionCA end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookCollectionCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Lorebooks.LorebookCollectionCA,
            },
            {
                -- Show Lorebook Collection Complete (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Lorebooks.LorebookCollectionCSA end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookCollectionCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Lorebooks.LorebookCollectionCSA,
            },
            {
                -- Show Lorebook Collection Complete (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Lorebooks.LorebookCollectionAlert end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookCollectionAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Lorebooks.LorebookCollectionAlert,
            },
            {
                -- Lorebooks Icon
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_ICON_TP),
                getFunc = function() return CA.SV.Lorebooks.LorebookIcon end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookIcon = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Lorebooks.LorebookIcon,
            },
            {
                -- Lorebooks Color 1
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR1)),
                getFunc = function() return unpack(CA.SV.Lorebooks.LorebookColor1) end,
                setFunc = function(r, g, b, a) CA.SV.Lorebooks.LorebookColor1 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Lorebooks.LorebookColor1[1], g=CA.D.Lorebooks.LorebookColor1[2], b=CA.D.Lorebooks.LorebookColor1[3]}
            },
            {
                -- Lorebooks Color 2
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOREBOOK_COLOR2)),
                getFunc = function() return unpack(CA.SV.Lorebooks.LorebookColor2) end,
                setFunc = function(r, g, b, a) CA.SV.Lorebooks.LorebookColor2 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Lorebooks.LorebookColor2[1], g=CA.D.Lorebooks.LorebookColor2[2], b=CA.D.Lorebooks.LorebookColor2[3]}
            },
            {
                -- Lorebooks Prefix 1
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX1_TP),
                getFunc = function() return CA.SV.Lorebooks.LorebookPrefix1 end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookPrefix1 = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Lorebooks.LorebookPrefix1,
            },
            {
                -- Lorebooks Prefix 2
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX2_TP),
                getFunc = function() return CA.SV.Lorebooks.LorebookPrefix2 end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookPrefix2 = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Lorebooks.LorebookPrefix2,
            },
            {
                -- Lorebooks Collection Prefix
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION_TP),
                getFunc = function() return CA.SV.Lorebooks.LorebookCollectionPrefix end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookCollectionPrefix = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Lorebooks.LorebookCollectionPrefix,
            },
            {
                -- Lorebooks Bracket Options
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET)),
                choices = bracketOptions5,
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET_TP),
                getFunc = function() return bracketOptions5[CA.SV.Lorebooks.LorebookBracket] end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookBracket = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Lorebooks.LorebookBracket
            },
            {
                -- Lorebooks Category
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_TP),
                getFunc = function() return CA.SV.Lorebooks.LorebookCategory end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookCategory = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Lorebooks.LorebookCategory,
            },
            {
                -- Show hidden books
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>",GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE_TP),
                getFunc = function() return CA.SV.Lorebooks.LorebookShowHidden end,
                setFunc = function(value) CA.SV.Lorebooks.LorebookShowHidden = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Lorebooks.LorebookCA or
                CA.SV.Lorebooks.LorebookCSA or
                CA.SV.Lorebooks.LorebookAlert or
                CA.SV.Lorebooks.LorebookCollectionCA or
                CA.SV.Lorebooks.LorebookCollectionCSA or
                CA.SV.Lorebooks.LorebookCollectionAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Lorebooks.LorebookShowHidden,
            },
        },
    }

    -- Chat Announcements - Achievements Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_ACHIEVE_HEADER),
        controls = {
            {
                -- Show Achievement Update CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Achievement.AchievementUpdateCA end,
                setFunc = function(value) CA.SV.Achievement.AchievementUpdateCA = value CA.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Achievement.AchievementUpdateCA,
            },
            {
                -- Show Achievement Update Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Achievement.AchievementUpdateAlert end,
                setFunc = function(value) CA.SV.Achievement.AchievementUpdateAlert = value CA.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Achievement.AchievementUpdateAlert,
            },
            {
                -- Show Detailed Achievement Info
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO)),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO_TP),
                getFunc = function() return CA.SV.Achievement.AchievementDetails end,
                setFunc = function(value) CA.SV.Achievement.AchievementDetails = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementDetails,
            },
            {
                -- Achievements Step Size
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE)),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return CA.SV.Achievement.AchievementStep end,
                setFunc = function(value) CA.SV.Achievement.AchievementStep = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementStep,
            },
            {
                -- Enable Achievement Complete CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Achievement.AchievementCompleteCA end,
                setFunc = function(value) CA.SV.Achievement.AchievementCompleteCA = value CA.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Achievement.AchievementCompleteCA,
            },
            {
                -- Enable Achievement Complete CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Achievement.AchievementCompleteCSA end,
                setFunc = function(value) CA.SV.Achievement.AchievementCompleteCSA = value CA.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Achievement.AchievementCompleteCSA,
            },
            {
                -- Enable Achievement Complete Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Achievement.AchievementCompleteAlert end,
                setFunc = function(value) CA.SV.Achievement.AchievementCompleteAlert = value CA.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Achievement.AchievementCompleteAlert,
            },
            {
                -- Show 100% Completion on complete event
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT)),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT_TP),
                getFunc = function() return CA.SV.Achievement.AchievementCompPercentage end,
                setFunc = function(value) CA.SV.Achievement.AchievementCompPercentage = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementCompPercentage,
            },
            {
                -- Show Achievement Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_ICON_TP),
                getFunc = function() return CA.SV.Achievement.AchievementIcon end,
                setFunc = function(value) CA.SV.Achievement.AchievementIcon = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementIcon,
            },
            {
                -- Achievement Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[CA.SV.BracketOptionAchievement] end,
                setFunc = function(value) CA.SV.BracketOptionAchievement = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.BracketOptionAchievement,
            },
            {
                -- Achievement Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR1),
                getFunc = function() return unpack(CA.SV.Achievement.AchievementColor1) end,
                setFunc = function(r, g, b, a) CA.SV.Achievement.AchievementColor1 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Achievement.AchievementColor1[1], g=CA.D.Achievement.AchievementColor1[2], b=CA.D.Achievement.AchievementColor1[3]}
            },
            {
                -- Achievement Message Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLOR2),
                getFunc = function() return unpack(CA.SV.Achievement.AchievementColor2) end,
                setFunc = function(r, g, b, a) CA.SV.Achievement.AchievementColor2 = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Achievement.AchievementColor2[1], g=CA.D.Achievement.AchievementColor2[2], b=CA.D.Achievement.AchievementColor2[3]}
            },
            {
                -- Context Name for Achievement Progress
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_PROGMSG_TP),
                getFunc = function() return CA.SV.Achievement.AchievementProgressMsg end,
                setFunc = function(value) CA.SV.Achievement.AchievementProgressMsg = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementProgressMsg,
            },
            {
                -- Context Name for Achievement Completion
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG_TP),
                getFunc = function() return CA.SV.Achievement.AchievementCompleteMsg end,
                setFunc = function(value) CA.SV.Achievement.AchievementCompleteMsg = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementCompleteMsg,
            },
            {
                -- Show Achievement Category
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY_TP),
                getFunc = function() return CA.SV.Achievement.AchievementCategory end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementCategory,
            },
            {
                -- Show Achievement Subcategory
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY_TP),
                getFunc = function() return CA.SV.Achievement.AchievementSubcategory end,
                setFunc = function(value) CA.SV.Achievement.AchievementSubcategory = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementSubcategory,
            },
            {
                -- Prefix Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_BRACKET_TP),
                choices = bracketOptions5,
                getFunc = function() return bracketOptions5[CA.SV.Achievement.AchievementBracketOptions] end,
                setFunc = function(value) CA.SV.Achievement.AchievementBracketOptions = bracketOptions5Keys[value] end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementBracketOptions
            },
            {
                -- Category & Subcategory Bracket Options
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET_TP),
                choices = bracketOptions4,
                getFunc = function() return bracketOptions4[CA.SV.Achievement.AchievementCatBracketOptions] end,
                setFunc = function(value) CA.SV.Achievement.AchievementCatBracketOptions = bracketOptions4Keys[value] end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCategory or CA.SV.Achievement.AchievementSubcategory) or not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementCatBracketOptions
            },
            {
                -- Color Achievement Progress
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS),
                tooltip = GetString(SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS_TP),
                getFunc = function() return CA.SV.Achievement.AchievementColorProgress end,
                setFunc = function(value) CA.SV.Achievement.AchievementColorProgress = value end,
                width = "full",
                disabled = function() return not (CA.SV.Achievement.AchievementCompleteCA or CA.SV.Achievement.AchievementCompleteCSA or CA.SV.Achievement.AchievementCompleteAlert or CA.SV.Achievement.AchievementUpdateCA or CA.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Achievement.AchievementColorProgress,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_HEADER),
                width = "full",
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(1)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(1)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory1 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory1 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory1,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(2)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(2)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory2 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory2 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory2,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(3)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(3)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory3 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory3 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory3,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(4)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(4)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory4 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory4 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory4,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(5)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(5)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory5 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory5 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory5,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(6)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(6)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory6 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory6 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory6,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(7)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(7)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory7 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory7 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory7,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(8)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(8)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory8 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory8 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory8,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(9)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(9)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory9 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory9 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory9,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(10)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(10)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory10 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory10 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory10,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(11)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(11)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory11 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory11 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory11,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(12)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(12)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory12 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory12 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory12,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(13)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(13)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory13 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory13 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory13,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(14)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(14)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory14 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory14 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory14,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(15)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(15)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory15 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory15 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory15,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(16)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(16)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory16 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory16 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory16,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(17)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(17)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory17 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory17 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory17,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(18)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(18)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory18 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory18 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory18,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(19)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(19)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory19 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory19 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory19,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(20)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(20)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory20 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory20 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory20,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(21)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(21)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory21 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory21 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory21,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(22)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(22)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory22 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory22 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory22,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
            {
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(23)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(23)),
                getFunc = function() return CA.SV.Achievement.AchievementCategory23 end,
                setFunc = function(value) CA.SV.Achievement.AchievementCategory23 = value end,
                width = "full",
                default = CA.D.Achievement.AchievementCategory23,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
        },
    }

    -- Chat Announcements - Quest Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_QUEST_HEADER),
        controls = {
            {
                -- Show Quest Share CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestShareCA end,
                setFunc = function(value) CA.SV.Quests.QuestShareCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestShareCA,
            },
            {
                -- Show Quest Share Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestShareAlert end,
                setFunc = function(value) CA.SV.Quests.QuestShareAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestShareAlert,
            },
            {
                -- Show Location Discovery (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestLocDiscoveryCA end,
                setFunc = function(value) CA.SV.Quests.QuestLocDiscoveryCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocDiscoveryCA,
            },
            {
                -- Show Location Discovery (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestLocDiscoveryCSA end,
                setFunc = function(value) CA.SV.Quests.QuestLocDiscoveryCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocDiscoveryCSA,
            },
            {
                -- Show Location Discovery (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestLocDiscoveryAlert end,
                setFunc = function(value) CA.SV.Quests.QuestLocDiscoveryAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocDiscoveryAlert,
            },
            {
                -- Show Location Objective (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestLocObjectiveCA end,
                setFunc = function(value) CA.SV.Quests.QuestLocObjectiveCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocObjectiveCA,
            },
            {
                -- Show Location Objective (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestLocObjectiveCSA end,
                setFunc = function(value) CA.SV.Quests.QuestLocObjectiveCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocObjectiveCSA,
            },
            {
                -- Show Location Objective (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestLocObjectiveAlert end,
                setFunc = function(value) CA.SV.Quests.QuestLocObjectiveAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocObjectiveAlert,
            },
            {
                -- Show Location Complete (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestLocCompleteCA end,
                setFunc = function(value) CA.SV.Quests.QuestLocCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocCompleteCA,
            },
            {
                -- Show Location Complete (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestLocCompleteCSA end,
                setFunc = function(value) CA.SV.Quests.QuestLocCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocCompleteCSA,
            },
            {
                -- Show Location Complete (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestLocCompleteAlert end,
                setFunc = function(value) CA.SV.Quests.QuestLocCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocCompleteAlert,
            },
            {
                -- Show Quest Accept (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestAcceptCA end,
                setFunc = function(value) CA.SV.Quests.QuestAcceptCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestAcceptCA,
            },
            {
                -- Show Quest Accept (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestAcceptCSA end,
                setFunc = function(value) CA.SV.Quests.QuestAcceptCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestAcceptCSA,
            },
            {
                -- Show Quest Accept (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ACCEPT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestAcceptAlert end,
                setFunc = function(value) CA.SV.Quests.QuestAcceptAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestAcceptAlert,
            },
            {
                -- Show Quest Complete (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestCompleteCA end,
                setFunc = function(value) CA.SV.Quests.QuestCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestCompleteCA,
            },
            {
                -- Show Quest Complete (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestCompleteCSA end,
                setFunc = function(value) CA.SV.Quests.QuestCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestCompleteCSA,
            },
            {
                -- Show Quest Complete (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestCompleteAlert end,
                setFunc = function(value) CA.SV.Quests.QuestCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestCompleteAlert,
            },
            {
                -- Show Quest Abandon (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestAbandonCA end,
                setFunc = function(value) CA.SV.Quests.QuestAbandonCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestAbandonCA,
            },
            {
                -- Show Quest Abandon (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestAbandonCSA end,
                setFunc = function(value) CA.SV.Quests.QuestAbandonCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestAbandonCSA,
            },
            {
                -- Show Quest Abandon (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_ABANDON_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestAbandonAlert end,
                setFunc = function(value) CA.SV.Quests.QuestAbandonAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestAbandonAlert,
            },
            {
                -- Show Quest Failure (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestFailCA end,
                setFunc = function(value) CA.SV.Quests.QuestFailCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestFailCA,
            },
            {
                -- Show Quest Failure (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestFailCSA end,
                setFunc = function(value) CA.SV.Quests.QuestFailCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestFailCSA,
            },
            {
                -- Show Quest Failure (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestFailAlert end,
                setFunc = function(value) CA.SV.Quests.QuestFailAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestFailAlert,
            },
            {
                -- Show Quest Objective Updates (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestObjUpdateCA end,
                setFunc = function(value) CA.SV.Quests.QuestObjUpdateCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestObjUpdateCA,
            },
            {
                -- Show Quest Objective Updates (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestObjUpdateCSA end,
                setFunc = function(value) CA.SV.Quests.QuestObjUpdateCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestObjUpdateCSA,
            },
            {
                -- Show Quest Objective Updates (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestObjUpdateAlert end,
                setFunc = function(value) CA.SV.Quests.QuestObjUpdateAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestObjUpdateAlert,
            },
            {
                -- Show Quest Objective Complete (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestObjCompleteCA end,
                setFunc = function(value) CA.SV.Quests.QuestObjCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestObjCompleteCA,
            },
            {
                -- Show Quest Objective Complete (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestObjCompleteCSA end,
                setFunc = function(value) CA.SV.Quests.QuestObjCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestObjCompleteCSA,
            },
            {
                -- Show Quest Objective Complete (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestObjCompleteAlert end,
                setFunc = function(value) CA.SV.Quests.QuestObjCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestObjCompleteAlert,
            },
            {
                -- Show Quest Icon
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON_TP),
                getFunc = function() return CA.SV.Quests.QuestIcon end,
                setFunc = function(value) CA.SV.Quests.QuestIcon = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestIcon,
            },
            {
                -- Location Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR1)),
                getFunc = function() return unpack(CA.SV.Quests.QuestColorLocName) end,
                setFunc = function(r,g,b,a) CA.SV.Quests.QuestColorLocName={r,g,b} CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=CA.D.Quests.QuestColorLocName[1], g=CA.D.Quests.QuestColorLocName[2], b=CA.D.Quests.QuestColorLocName[3] },
            },
            {
                -- Location Description Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR2)),
                getFunc = function() return unpack(CA.SV.Quests.QuestColorLocDescription) end,
                setFunc = function(r,g,b,a) CA.SV.Quests.QuestColorLocDescription={r,g,b} CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=CA.D.Quests.QuestColorLocDescription[1], g=CA.D.Quests.QuestColorLocDescription[2], b=CA.D.Quests.QuestColorLocDescription[3] },
            },
            {
                -- Quest Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR3)),
                getFunc = function() return unpack(CA.SV.Quests.QuestColorName) end,
                setFunc = function(r,g,b,a) CA.SV.Quests.QuestColorName={r,g,b} CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=CA.D.Quests.QuestColorName[1], g=CA.D.Quests.QuestColorName[2], b=CA.D.Quests.QuestColorName[3] },
            },
            {
                -- Quest Description Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_COLOR4)),
                getFunc = function() return unpack(CA.SV.Quests.QuestColorDescription) end,
                setFunc = function(r,g,b,a) CA.SV.Quests.QuestColorDescription={r,g,b} CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = { r=CA.D.Quests.QuestColorDescription[1], g=CA.D.Quests.QuestColorDescription[2], b=CA.D.Quests.QuestColorDescription[3] },
            },
            {
                -- Show Quest Long String
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG_TP),
                getFunc = function() return CA.SV.Quests.QuestLong end,
                setFunc = function(value) CA.SV.Quests.QuestLong = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLong,
            },
            {
                -- Show POI Completed Long String
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG_TP),
                getFunc = function() return CA.SV.Quests.QuestLocLong end,
                setFunc = function(value) CA.SV.Quests.QuestLocLong = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestLocLong,
            },
        },
    }

    -- Chat Announcements - Social Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_SOCIAL_HEADER),
        controls = {
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_HEADER),
                width = "full",
            },
            {
                -- Show Friend/Ignore Events CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.FriendIgnoreCA end,
                setFunc = function(value) CA.SV.Social.FriendIgnoreCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.FriendIgnoreCA,
            },
            {
                -- Show Friend/Ignore Events Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.FriendIgnoreAlert end,
                setFunc = function(value) CA.SV.Social.FriendIgnoreAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.FriendIgnoreAlert,
            },
            {
                -- Friend Online/Offline CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.FriendStatusCA end,
                setFunc = function(value) CA.SV.Social.FriendStatusCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.FriendStatusCA,
            },
            {
                -- Friend Online/Offline Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.FriendStatusAlert end,
                setFunc = function(value) CA.SV.Social.FriendStatusAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.FriendStatusAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_HEADER),
                width = "full",
            },
            {
                -- Show Guild Events CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.GuildCA end,
                setFunc = function(value) CA.SV.Social.GuildCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.GuildCA,
            },
            {
                -- Show Guild Events Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.GuildAlert end,
                setFunc = function(value) CA.SV.Social.GuildAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.GuildAlert,
            },
            {
                -- Show Guild Rank Events CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.GuildRankCA end,
                setFunc = function(value) CA.SV.Social.GuildRankCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.GuildRankCA,
            },
            {
                -- Show Guild Rank Events Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.GuildRankAlert end,
                setFunc = function(value) CA.SV.Social.GuildRankAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.GuildRankAlert,
            },
            {
                -- Show Guild Rank Events Display Options
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS_TP),
                choices = guildRankDisplayOptions,
                getFunc = function() return guildRankDisplayOptions[CA.SV.Social.GuildRankDisplayOptions] end,
                setFunc = function(value) CA.SV.Social.GuildRankDisplayOptions = guildRankDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (CA.SV.Social.GuildRankCA or CA.SV.Social.GuildRankAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Social.GuildRankDisplayOptions,
            },
            {
                -- Show Guild Management CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.GuildManageCA end,
                setFunc = function(value) CA.SV.Social.GuildManageCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.GuildManageCA,
            },
            {
                -- Show Guild Management Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.GuildManageAlert end,
                setFunc = function(value) CA.SV.Social.GuildManageAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.GuildManageAlert,
            },
            {
                -- Show Guild Icons
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS_TP),
                getFunc = function() return CA.SV.Social.GuildIcon end,
                setFunc = function(value) CA.SV.Social.GuildIcon = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Social.GuildCA or
                CA.SV.Social.GuildAlert or
                CA.SV.Social.GuildRankCA or
                CA.SV.Social.GuildRankAlert or
                CA.SV.Social.GuildManageCA or
                CA.SV.Social.GuildManageAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Social.GuildIcon,
            },
            {
                -- Guild Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR)),
                getFunc = function() return unpack(CA.SV.Social.GuildColor) end,
                setFunc = function(r, g, b, a) CA.SV.Social.GuildColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (
                CA.SV.Social.GuildCA or
                CA.SV.Social.GuildAlert or
                CA.SV.Social.GuildRankCA or
                CA.SV.Social.GuildRankAlert or
                CA.SV.Social.GuildManageCA or
                CA.SV.Social.GuildManageAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Social.GuildColor[1], g=CA.D.Social.GuildColor[2], b=CA.D.Social.GuildColor[3]}
            },
            {
                -- Use Alliance Color for Guild
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE_TP),
                getFunc = function() return CA.SV.Social.GuildAllianceColor end,
                setFunc = function(value) CA.SV.Social.GuildAllianceColor = value end,
                width = "full",
                disabled = function() return not (
                CA.SV.Social.GuildCA or
                CA.SV.Social.GuildAlert or
                CA.SV.Social.GuildRankCA or
                CA.SV.Social.GuildRankAlert or
                CA.SV.Social.GuildManageCA or
                CA.SV.Social.GuildManageAlert and
                LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Social.GuildAllianceColor,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_HEADER),
                width = "full",
            },
            {
                -- Show Trade Events
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.NotificationTradeCA end,
                setFunc = function(value) CA.SV.Notify.NotificationTradeCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationTradeCA,
            },
            {
                -- Show Trade Events
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_TRADE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.NotificationTradeAlert end,
                setFunc = function(value) CA.SV.Notify.NotificationTradeAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationTradeAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_HEADER),
                width = "full",
            },
            {
                -- Show Duel Events (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.DuelCA end,
                setFunc = function(value) CA.SV.Social.DuelCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelCA,
            },
            {
                -- Show Duel Events (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUEL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.DuelAlert end,
                setFunc = function(value) CA.SV.Social.DuelAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelAlert,
            },
            {
                -- Duel Start CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.DuelStartCA end,
                setFunc = function(value) CA.SV.Social.DuelStartCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelStartCA,
            },
            {
                -- Duel Start CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TPCSA), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Social.DuelStartCSA end,
                setFunc = function(value) CA.SV.Social.DuelStartCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelStartCSA,
            },
            {
                -- Duel Start Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.DuelStartAlert end,
                setFunc = function(value) CA.SV.Social.DuelStartAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelStartAlert,
            },
            {
                -- Duel Start Options
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION)),
                tooltip = GetString(SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION_TP),
                choices = duelStartOptions,
                getFunc = function() return duelStartOptions[CA.SV.Social.DuelStartOptions] end,
                setFunc = function(value) CA.SV.Social.DuelStartOptions = duelStartOptionsKeys[value] end,
                width = "full",
                default = duelStartOptions[1],
                disabled = function() return not (CA.SV.Social.DuelStartCA or CA.SV.Social.DuelStartCSA or CA.SV.Social.DuelStartAlert and LUIE.SV.ChatAnnouncements_Enable) end,
            },
            {
                -- Duel Won CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.DuelWonCA end,
                setFunc = function(value) CA.SV.Social.DuelWonCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelWonCA,
            },
            {
                -- Duel Won CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Social.DuelWonCSA end,
                setFunc = function(value) CA.SV.Social.DuelWonCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelWonCSA,
            },
            {
                -- Duel Won Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.DuelWonAlert end,
                setFunc = function(value) CA.SV.Social.DuelWonAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelWonAlert,
            },
            {
                -- Duel Boundary CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.DuelBoundaryCA end,
                setFunc = function(value) CA.SV.Social.DuelBoundaryCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelBoundaryCA,
            },
            {
                -- Duel Boundary CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Social.DuelBoundaryCSA end,
                setFunc = function(value) CA.SV.Social.DuelBoundaryCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelBoundaryCSA,
            },
            {
                -- Duel Boundary Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.DuelBoundaryAlert end,
                setFunc = function(value) CA.SV.Social.DuelBoundaryAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.DuelBoundaryAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_SOCIAL_MARA_HEADER),
                width = "full",
            },
            {
                -- Show Pledge of Mara CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Social.PledgeOfMaraCA end,
                setFunc = function(value) CA.SV.Social.PledgeOfMaraCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.PledgeOfMaraCA,
            },
            {
                -- Show Pledge of Mara CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Social.PledgeOfMaraCSA end,
                setFunc = function(value) CA.SV.Social.PledgeOfMaraCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.PledgeOfMaraCSA,
            },
            {
                -- Show Pledge of Mara Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_MARA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Social.PledgeOfMaraAlert end,
                setFunc = function(value) CA.SV.Social.PledgeOfMaraAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Social.PledgeOfMaraAlert,
            },
            {
                -- Pledge of Mara (Alert Only on Failure)
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT)),
                tooltip = GetString(SI_LUIE_LAM_CA_MISC_MARA_ALERT_TP),
                getFunc = function() return CA.SV.Social.PledgeOfMaraAlertOnlyFail end,
                setFunc = function(value) CA.SV.Social.PledgeOfMaraAlertOnlyFail = value end,
                width = "full",
                disabled = function() return not (CA.SV.Social.PledgeOfMaraAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = CA.D.Social.PledgeOfMaraAlertOnlyFail,
            },
        },
    }

    -- Chat Announcements - Group Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_GROUP_HEADER),
        controls = {
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_GROUP_BASE_HEADER),
                width = "full",
            },
            {
                -- Show Group CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupCA end,
                setFunc = function(value) CA.SV.Group.GroupCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupCA,
            },
            {
                -- Show Group Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupAlert end,
                setFunc = function(value) CA.SV.Group.GroupAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_GROUP_LFG_HEADER),
                width = "full",
            },
            {
                -- Show Group LFG CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupLFGCA end,
                setFunc = function(value) CA.SV.Group.GroupLFGCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupLFGCA,
            },
            {
                -- Show Group LFG Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGREADY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupLFGAlert end,
                setFunc = function(value) CA.SV.Group.GroupLFGAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupLFGAlert,
            },
            {
                -- Show Group LFG CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupLFGQueueCA end,
                setFunc = function(value) CA.SV.Group.GroupLFGQueueCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupLFGQueueCA,
            },
            {
                -- Show Group LFG Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupLFGQueueAlert end,
                setFunc = function(value) CA.SV.Group.GroupLFGQueueAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupLFGQueueAlert,
            },
            {
                -- Show Group Vote CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupVoteCA end,
                setFunc = function(value) CA.SV.Group.GroupVoteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupVoteCA,
            },
            {
                -- Show Group Vote Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupVoteAlert end,
                setFunc = function(value) CA.SV.Group.GroupVoteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupVoteAlert,
            },
            {
                -- Show LFG Activity Completed CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupLFGCompleteCA end,
                setFunc = function(value) CA.SV.Group.GroupLFGCompleteCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupLFGCompleteCA,
            },
            {
                -- Show LFG Activity Completed CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Group.GroupLFGCompleteCSA end,
                setFunc = function(value) CA.SV.Group.GroupLFGCompleteCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupLFGCompleteCSA,
            },
            {
                -- Show LFG Activity Completed Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupLFGCompleteAlert end,
                setFunc = function(value) CA.SV.Group.GroupLFGCompleteAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupLFGCompleteAlert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CA_GROUP_RAID_HEADER),
                width = "full",
            },
            {
                -- Raid Announcements CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupRaidCA end,
                setFunc = function(value) CA.SV.Group.GroupRaidCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidCA,
            },
            {
                -- Raid Announcements CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Group.GroupRaidCSA end,
                setFunc = function(value) CA.SV.Group.GroupRaidCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidCSA,
            },
            {
                -- Raid Announcements Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupRaidAlert end,
                setFunc = function(value) CA.SV.Group.GroupRaidAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidAlert,
            },
            {
                -- Raid Score CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupRaidScoreCA end,
                setFunc = function(value) CA.SV.Group.GroupRaidScoreCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidScoreCA,
            },
            {
                -- Raid Score CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Group.GroupRaidScoreCSA end,
                setFunc = function(value) CA.SV.Group.GroupRaidScoreCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidScoreCSA,
            },
            {
                -- Raid Score Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupRaidScoreAlert end,
                setFunc = function(value) CA.SV.Group.GroupRaidScoreAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidScoreAlert,
            },
            {
                -- Raid Best Score CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupRaidBestScoreCA end,
                setFunc = function(value) CA.SV.Group.GroupRaidBestScoreCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidBestScoreCA,
            },
            {
                -- Raid Best Score CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Group.GroupRaidBestScoreCSA end,
                setFunc = function(value) CA.SV.Group.GroupRaidBestScoreCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidBestScoreCSA,
            },
            {
                -- Raid Best Score Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupRaidBestScoreAlert end,
                setFunc = function(value) CA.SV.Group.GroupRaidBestScoreAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidBestScoreAlert,
            },
            {
                -- Raid Revive Counter CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupRaidReviveCA end,
                setFunc = function(value) CA.SV.Group.GroupRaidReviveCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidReviveCA,
            },
            {
                -- Raid Revive Counter CSA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Group.GroupRaidReviveCSA end,
                setFunc = function(value) CA.SV.Group.GroupRaidReviveCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidReviveCSA,
            },
            {
                -- Raid Revive Counter Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupRaidReviveAlert end,
                setFunc = function(value) CA.SV.Group.GroupRaidReviveAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidReviveAlert,
            },
        },
    }

    -- Chat Announcements - Display Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_DISPLAY_HEADER),
        controls = {
            {
                -- Display Announcements Header
                type = "description",
                text = GetString(SI_LUIE_LAM_CA_DISPLAY_DESCRIPTION),
            },
            {
                -- Display Announcement DEBUG
                type = "checkbox",
                name = "*** Show Display Announcement Debug Message ***",
                tooltip = "Display a debug message when a Display Announcement that has not yet been added to LUIE is triggered. Enable this option if you'd like to help out with the addon by posting the messages you receive from this event. Do not enable if you are not using the English client.",
                getFunc = function() return CA.SV.DisplayAnnouncements.Debug end,
                setFunc = function(value) CA.SV.DisplayAnnouncements.Debug = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.DisplayAnnouncements.Debug,
            },
            {
                -- Respec Notification (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.NotificationRespecCA end,
                setFunc = function(value) CA.SV.Notify.NotificationRespecCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationRespecCA,
            },
            {
                -- Respec Notification (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Notify.NotificationRespecCSA end,
                setFunc = function(value) CA.SV.Notify.NotificationRespecCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationRespecCSA,
            },
            {
                -- Respec Notification (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_EXP_RESPEC_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.NotificationRespecAlert end,
                setFunc = function(value) CA.SV.Notify.NotificationRespecAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationRespecAlert,
            },
            {
                -- Display Group Area Message (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.NotificationGroupAreaCA end,
                setFunc = function(value) CA.SV.Notify.NotificationGroupAreaCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationGroupAreaCA,
            },
            {
                -- Display Group Area Message (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Notify.NotificationGroupAreaCSA end,
                setFunc = function(value) CA.SV.Notify.NotificationGroupAreaCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationGroupAreaCSA,
            },
            {
                -- Display Group Area Message (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_GROUPAREA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.NotificationGroupAreaAlert end,
                setFunc = function(value) CA.SV.Notify.NotificationGroupAreaAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationGroupAreaAlert,
            },
            {
                -- Arena Notifications (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupRaidArenaCA end,
                setFunc = function(value) CA.SV.Group.GroupRaidArenaCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidArenaCA,
            },
            {
                -- Arena Notifications (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Group.GroupRaidArenaCSA end,
                setFunc = function(value) CA.SV.Group.GroupRaidArenaCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidArenaCSA,
            },
            {
                -- Arena Notifications (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupRaidArenaAlert end,
                setFunc = function(value) CA.SV.Group.GroupRaidArenaAlert  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidArenaAlert,
            },
            {
                -- Arena Round Notifications (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Group.GroupRaidArenaRoundCA end,
                setFunc = function(value) CA.SV.Group.GroupRaidArenaRoundCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidArenaRoundCA,
            },
            {
                -- Arena Round Notifications (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Group.GroupRaidArenaRoundCSA end,
                setFunc = function(value) CA.SV.Group.GroupRaidArenaRoundCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidArenaRoundCSA,
            },
            {
                -- Arena Round Notifications (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Group.GroupRaidArenaRoundAlert end,
                setFunc = function(value) CA.SV.Group.GroupRaidArenaRoundAlert  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Group.GroupRaidArenaRoundAlert,
            },
            {
                -- Imperial City Display Announcement (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestICDiscoveryCA end,
                setFunc = function(value) CA.SV.Quests.QuestICDiscoveryCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestICDiscoveryCA,
            },
            {
                -- Imperial City Display Announcement (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestICDiscoveryCSA end,
                setFunc = function(value) CA.SV.Quests.QuestICDiscoveryCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestICDiscoveryCSA,
            },
            {
                -- Imperial City Display Announcement (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_QUEST_IC_DISCOVERY_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestICDiscoveryAlert end,
                setFunc = function(value) CA.SV.Quests.QuestICDiscoveryAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestICDiscoveryAlert,
            },
            {
                -- Imperial City Display Description
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION_TP),
                getFunc = function() return CA.SV.Quests.QuestICDescription end,
                setFunc = function(value) CA.SV.Quests.QuestICDescription = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and (CA.SV.Quests.QuestICDiscoveryCA or CA.SV.Quests.QuestICDiscoveryCSA or CA.SV.Quests.QuestICDiscoveryAlert) ) end,
                default = CA.D.Quests.QuestICDiscoveryAlert,
            },
            {
                -- Craglorn Buff (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Quests.QuestCraglornBuffCA end,
                setFunc = function(value) CA.SV.Quests.QuestCraglornBuffCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestCraglornBuffCA,
            },
            {
                -- Craglorn Buff (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Quests.QuestCraglornBuffCSA end,
                setFunc = function(value) CA.SV.Quests.QuestCraglornBuffCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestCraglornBuffCSA,
            },
            {
                -- Craglorn Buff (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Quests.QuestCraglornBuffAlert end,
                setFunc = function(value) CA.SV.Quests.QuestCraglornBuffAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Quests.QuestCraglornBuffAlert,
            },
        },
    }

    -- Chat Announcements - Miscellaneous Announcements Options Submenu
    optionsDataChatAnnouncements[#optionsDataChatAnnouncements +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CA_MISC_HEADER),
        controls = {
            {
                -- Mail (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.NotificationMailCA end,
                setFunc = function(value) CA.SV.Notify.NotificationMailCA = value CA.RegisterMailEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationMailCA,
            },
            {
                -- Mail (ALERT)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.NotificationMailAlert end,
                setFunc = function(value) CA.SV.Notify.NotificationMailAlert = value CA.RegisterMailEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationMailAlert,
            },
            {
                -- Show Lockpick Events CA
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.NotificationLockpickCA end,
                setFunc = function(value) CA.SV.Notify.NotificationLockpickCA = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationLockpickCA,
            },
            {
                -- Show Lockpick Events Alert
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.NotificationLockpickAlert end,
                setFunc = function(value) CA.SV.Notify.NotificationLockpickAlert = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationLockpickAlert,
            },
            {
                -- Show Justice Confiscate (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.NotificationConfiscateCA end,
                setFunc = function(value) CA.SV.Notify.NotificationConfiscateCA = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationConfiscateCA,
            },
            {
                -- Show Justice Confiscate (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.NotificationConfiscateAlert end,
                setFunc = function(value) CA.SV.Notify.NotificationConfiscateAlert = value CA.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.NotificationConfiscateAlert,
            },
            {
                -- Show Bag/Bank Upgrade (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.StorageBagCA end,
                setFunc = function(value) CA.SV.Notify.StorageBagCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.StorageBagCA,
            },
            {
                -- Show Bag/Bank Upgrade (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Notify.StorageBagCSA end,
                setFunc = function(value) CA.SV.Notify.StorageBagCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.StorageBagCSA,
            },
            {
                -- Show Bag/Bank Upgrade (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.StorageBagAlert end,
                setFunc = function(value) CA.SV.Notify.StorageBagAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.StorageBagAlert,
            },
            {
                -- Bag/Bank Upgrade Message Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_COLOR)),
                getFunc = function() return unpack(CA.SV.Notify.StorageBagColor) end,
                setFunc = function(r, g, b, a) CA.SV.Notify.StorageBagColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Notify.StorageBagCA or CA.SV.Notify.StorageBagCSA or CA.SV.Notify.StorageBagAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Notify.StorageBagColor[1], g=CA.D.Notify.StorageBagColor[2], b=CA.D.Notify.StorageBagColor[3]}
            },
            {
                -- Show Mount Upgrade (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.StorageRidingCA end,
                setFunc = function(value) CA.SV.Notify.StorageRidingCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.StorageRidingCA,
            },
            {
                -- Show Mount Upgrade (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Notify.StorageRidingCSA end,
                setFunc = function(value) CA.SV.Notify.StorageRidingCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.StorageRidingCSA,
            },
            {
                -- Show Mount Upgrade (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.StorageRidingAlert end,
                setFunc = function(value) CA.SV.Notify.StorageRidingAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.StorageRidingAlert,
            },
            {
                -- Mount Upgrade Message Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR)),
                getFunc = function() return unpack(CA.SV.Notify.StorageRidingColor) end,
                setFunc = function(r, g, b, a) CA.SV.Notify.StorageRidingColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Notify.StorageRidingCA or CA.SV.Notify.StorageRidingCSA or CA.SV.Notify.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Notify.StorageRidingColor[1], g=CA.D.Notify.StorageRidingColor[2], b=CA.D.Notify.StorageRidingColor[3]}
            },
            {
                -- Mount Upgrade Message Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR_BOOK)),
                getFunc = function() return unpack(CA.SV.Notify.StorageRidingBookColor) end,
                setFunc = function(r, g, b, a) CA.SV.Notify.StorageRidingBookColor = { r, g, b, a } CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Notify.StorageRidingCA or CA.SV.Notify.StorageRidingCSA or CA.SV.Notify.StorageRidingAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=CA.D.Notify.StorageRidingBookColor[1], g=CA.D.Notify.StorageRidingBookColor[2], b=CA.D.Notify.StorageRidingBookColor[3]}
            },
            {
                -- Show Disguise Events (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.DisguiseCA end,
                setFunc = function(value) CA.SV.Notify.DisguiseCA = value CA.RegisterDisguiseEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.DisguiseCA,
            },
            {
                -- Show Disguise Events (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Notify.DisguiseCSA end,
                setFunc = function(value) CA.SV.Notify.DisguiseCSA = value CA.RegisterDisguiseEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.DisguiseCSA,
            },
            {
                -- Show Disguise Events (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.DisguiseAlert end,
                setFunc = function(value) CA.SV.Notify.DisguiseAlert = value CA.RegisterDisguiseEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.DisguiseAlert,
            },
            {
                -- Show Disguise Warning (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return CA.SV.Notify.DisguiseWarnCA end,
                setFunc = function(value) CA.SV.Notify.DisguiseWarnCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.DisguiseWarnCA,
            },
            {
                -- Show Disguise Warning (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return CA.SV.Notify.DisguiseWarnCSA end,
                setFunc = function(value) CA.SV.Notify.DisguiseWarnCSA = value end,
                width = "full",
               disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.DisguiseWarnCSA,
            },
            {
                -- Show Disguise Warning (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return CA.SV.Notify.DisguiseWarnAlert end,
                setFunc = function(value) CA.SV.Notify.DisguiseWarnAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = CA.D.Notify.DisguiseWarnAlert,
            },
            {
                -- Disguise Alert Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR)),
                tooltip = GetString(SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR_TP),
                getFunc = function() return unpack(CA.SV.Notify.DisguiseAlertColor) end,
                setFunc = function(r,g,b,a) CA.SV.Notify.DisguiseAlertColor={r,g,b} CA.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (CA.SV.Notify.DisguiseWarnCA or CA.SV.Notify.DisguiseWarnCSA or CA.SV.Notify.DisguiseWarnAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = { r=CA.D.Notify.DisguiseAlertColor[1], g=CA.D.Notify.DisguiseAlertColor[2], b=CA.D.Notify.DisguiseAlertColor[3] },
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.ChatAnnouncements_Enable then
        LAM:RegisterAddonPanel('LUIEChatAnnouncementOptions', panelDataChatAnnouncements)
        LAM:RegisterOptionControls('LUIEChatAnnouncementOptions', optionsDataChatAnnouncements)
    end
end
