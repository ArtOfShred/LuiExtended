-- Performance Enhancement
local strformat     = zo_strformat
local tableinsert   = table.insert
local mathrandom    = math.random
local unpack        = unpack
local pairs         = pairs

local iconFormat    = zo_iconFormat

-- Create Settings Menu
function LUIE_CreateSettings()
    -- Load LibAddonMenu
    local LAM2  = LibStub("LibAddonMenu-2.0")
    -- Load LibMediaProvider
    local LMP   = LibStub("LibMediaProvider-1.0")

    local l_BuffsMovingEnabled  = false -- Helper local flag
    local FontsList             = {}
    local SoundsList            = {}
    local StatusbarTexturesList = {}

    -- Get Fonts
    for f in pairs(LUIE.Fonts) do
        tableinsert(FontsList, f)
    end
    for key, _ in pairs(LUIE.StatusbarTextures) do
        tableinsert(StatusbarTexturesList, key)
    end
    for sound, _ in pairs(LUIE.Sounds) do
        tableinsert(SoundsList, sound)
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
    local globalMethodOptionsKeys       = { ["Ascending"] = 1, ["Descending"] = 2, ["Radial"] = 3 }
    local playerFrameOptions            = { "Vertical Stacked Frames", "Separated Horizontal Frames", "Pyramid" }
    local playerFrameOptionsKeys        = { ["Vertical Stacked Frames"] = 1, ["Separated Horizontal Frames"] = 2, ["Pyramid"] = 3 }
    local championOptions               = { "Show Above Cap", "Limit to Cap", }

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
                options[counter] = iconFormat(GetAbilityIcon(id), 16, 16) .. " [" .. id .. "] " .. strformat("<<C:1>>", GetAbilityName(id))
            -- If the input is not numeric then add this as a name only.
            else
                options[counter] = id
            end
            values[counter] = id
        end
        return options, values
    end

    profileCharacters = {} -- List of character profiles
    profileQueuedCopy = nil -- Currently queued character copy name for copy button

    -- Generate list of character profiles for Menu function
    local function GenerateCharacterProfiles()
        local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV -- Pull info from SV for account wide
        local playerName = GetUnitName('player')
        local version = LUIE.version

        for accountName, data in pairs(LUIESV.Default) do
            for profile, vars in pairs(data) do
                if vars.version == LUIE.SVVer then
                    if isCharacterSpecific then
                        -- Add list of other player characters (but not self) to settings to copy. We also add AccountWide here so you can copy from your base settings if desired.
                        if profile ~= playerName then
                            table.insert(profileCharacters, profile)
                        end
                    else
                        -- Add list of other player characters to settings to copy. We also add AccountWide here so you can copy from your base settings if desired.
                        table.insert(profileCharacters, profile)
                    end
                end
            end
        end
    end

    -- Borrowed from Srendarr - copies data either to override character's data or creates a new table if no data for that character exists.
    local function CopyTable(src, dest)
        if (type(dest) ~= 'table') then
            dest = {}
        end

        if (type(src) == 'table') then
            for k, v in pairs(src) do
                if (type(v) == 'table') then
                    CopyTable(v, dest[k])
                end

                dest[k] = v
            end
        end
    end

    -- Called from Menu by either reset current character or reset account wide settings button.
    local function DeleteCurrentProfile(account)
        local deleteProfile
        if account then
            deleteProfile = '$AccountWide'
        else
            deleteProfile = GetUnitName('player')
        end

        for accountName, data in pairs(LUIESV.Default) do
            for profile, vars in pairs(data) do
                if profile == deleteProfile then
                    data[profile] = nil
                    break
                end
            end
        end
    end

    -- Copy a character profile & replace another.
    local function CopyCharacterProfile()
        local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV -- Pull info from SV for account wide
        local copyTarget = isCharacterSpecific and GetUnitName('player') or '$AccountWide'
        local sourceCharacter, targetCharacter

        for accountName, data in pairs(LUIESV.Default) do
            for profile, vars in pairs(data) do
                if profile == profileQueuedCopy then
                    sourceCharacter = vars
                end
                if profile == copyTarget then
                    targetCharacter = vars
                end
            end
        end

        if not sourceCharacter or not targetCharacter then
            d("Some shit got fucked up dawg.")
            return
        else
            CopyTable(sourceCharacter, targetCharacter)
            ReloadUI()
        end
    end

    GenerateCharacterProfiles()

    -- TODO: localization
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
        website = LUIE.website,
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
        website = LUIE.website,
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
        website = LUIE.website,
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
        website = LUIE.website,
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
        website = LUIE.website,
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
        website = LUIE.website,
        slashCommand = "/luict",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local panelDataSlashCommands = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_SLASHCMDS)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_SLASHCMDS), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        slashCommand = "/luisc",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local panelDataInfoPanel = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_PNL)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_PNL), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        slashCommand = "/luiip",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsData = {}
    local optionsDataBuffsDebuffs = {}
    local optionsDataChatAnnouncements = {}
    local optionsDataUnitFrames = {}
    local optionsDataCombatInfo = {}
    local optionsDataCombatText = {}
    local optionsDataSlashCommands = {}
    local optionsDataInfoPanel = {}

    -- Changelog Button
    optionsData[#optionsData + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_CHANGELOG),
        tooltip = GetString(SI_LUIE_LAM_CHANGELOG_TP),
        func = function() LUIE_WelcomeScreen(true) SCENE_MANAGER:ShowBaseScene() end,
        width = "half",
    }

    -- ReloadUI Button
    optionsData[#optionsData + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "half",
    }

    -- Character Profile Settings Submenu
    optionsData[#optionsData + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_SVPROFILE_HEADER),
        controls = {
            {
                -- Character Profile Description
                type = "description",
                text = GetString(SI_LUIE_LAM_SVPROFILE_DESCRIPTION),
                width = "full",
            },
            {
                -- Use Character Specific Settings Toggle
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SVPROFILE_SETTINGSTOGGLE),
                tooltip = GetString(SI_LUIE_LAM_SVPROFILE_SETTINGSTOGGLE_TP),
                warning = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
                getFunc = function() return LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV end,
                setFunc = function(value) LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV = value ReloadUI() end,
                width = "full",
            },
            {
                -- Copy Profile Dropdown
                type = "dropdown",
                scrollable = true,
                name = GetString(SI_LUIE_LAM_SVPROFILE_PROFILECOPY),
                tooltip = GetString(SI_LUIE_LAM_SVPROFILE_PROFILECOPY_TP),
                choices = profileCharacters,
                sort = "name-up",
                getFunc = function() return profileCharacters end,
                setFunc = function(value) profileQueuedCopy = value end,
                width = "full",
            },
            {
                -- Copy Profile Button
                type = "button",
                name = GetString(SI_LUIE_LAM_SVPROFILE_PROFILECOPYBUTTON),
                tooltip = GetString(SI_LUIE_LAM_SVPROFILE_PROFILECOPYBUTTON_TP),
                warning = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
                func = function() CopyCharacterProfile() end,
                width = "full",
            },
            {
                -- Reset Current Character Settings Button
                type = "button",
                name = GetString(SI_LUIE_LAM_SVPROFILE_RESETCHAR),
                tooltip = GetString(SI_LUIE_LAM_SVPROFILE_RESETCHAR_TP),
                warning = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
                func = function() DeleteCurrentProfile(false) ReloadUI() end,
                width = "half",
                disabled = function() return not LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV end,
            },
            {
                -- Reset Account Wide Settings Button
                type = "button",
                name = GetString(SI_LUIE_LAM_SVPROFILE_RESETACCOUNT),
                tooltip = GetString(SI_LUIE_LAM_SVPROFILE_RESETACCOUNT_TP),
                warning = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
                width = "half",
                func = function() DeleteCurrentProfile(true) ReloadUI() end,
            },
        },
    }

    -- Modules Header
    optionsData[#optionsData + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_MODULEHEADER),
        width = "full",
    }

    -- Unit Frames Module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_ENABLE),
        getFunc = function() return LUIE.SV.UnitFrames_Enabled end,
        setFunc = function(value) LUIE.SV.UnitFrames_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.UnitFrames_Enabled,
    }

    -- Unit Frames module description
    optionsData[#optionsData + 1] = {
        type = "description",
        width = "half",
        text = GetString(SI_LUIE_LAM_UF_DESCRIPTION),
    }

    -- Combat Info Module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CI_SHOWCOMBATINFO),
        getFunc = function() return LUIE.SV.CombatInfo_Enabled end,
        setFunc = function(value) LUIE.SV.CombatInfo_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.CombatInfo_Enabled,
    }

    -- Combat Info Description
    optionsData[#optionsData + 1] = {
        type = "description",
        width = "half",
        text = GetString(SI_LUIE_LAM_CI_DESCRIPTION),
    }

    -- Combat Text Module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CT_SHOWCOMBATTEXT),
        getFunc = function() return LUIE.SV.CombatText_Enabled end,
        setFunc = function(value) LUIE.SV.CombatText_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.CombatText_Enabled,
    }

    -- Combat Text Description
    optionsData[#optionsData + 1] = {
        type = "description",
        width = "half",
        text = GetString(SI_LUIE_LAM_CT_DESCRIPTION),
    }

    -- Buffs & Debuffs Module
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_BUFF_ENABLEEFFECTSTRACK),
        getFunc = function() return LUIE.SV.SpellCastBuff_Enable end,
        setFunc = function(value) LUIE.SV.SpellCastBuff_Enable = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.SpellCastBuff_Enable,
    }

    -- Buffs & Debuffs Description
    optionsData[#optionsData + 1] = {
        type = "description",
        width = "half",
        text = GetString(SI_LUIE_LAM_BUFFS_DESCRIPTION),
    }

    -- Chat Announcements Module
    optionsData[#optionsData +1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_CA_ENABLE),
        getFunc = function() return LUIE.SV.ChatAnnouncements_Enable end,
        setFunc = function(value) LUIE.SV.ChatAnnouncements_Enable = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.ChatAnnouncements_Enable,
    }

    -- Chat Announcements Module Description
    optionsData[#optionsData +1] = {
        type = "description",
        width = "half",
        text = GetString(SI_LUIE_LAM_CA_DESCRIPTION),
    }

    -- Slash Commands Module
    optionsData[#optionsData +1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_SLASHCMDS_ENABLE),
        getFunc = function() return LUIE.SV.SlashCommands_Enable end,
        setFunc = function(value) LUIE.SV.SlashCommands_Enable = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.SlashCommands_Enable,
    }

    -- Slash Commands Module Description
    optionsData[#optionsData +1] = {
        type = "description",
        width = "half",
        text = GetString(SI_LUIE_LAM_SLASHCMDS_DESCRIPTION),
    }

    -- Show InfoPanel
    optionsData[#optionsData +1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_PNL_ENABLE),
        getFunc = function() return LUIE.SV.InfoPanel_Enabled end,
        setFunc = function(value) LUIE.SV.InfoPanel_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = LUIE.D.SlashCommands_Enable,
    }

    -- InfoPanel Module Description
    optionsData[#optionsData +1] = {
        type = "description",
        width = "half",
        text = GetString(SI_LUIE_LAM_PNL_DESCRIPTION),
    }

    -- Misc Settings
    optionsData[#optionsData + 1] = {
        type = "header",
        name = GetString(SI_LUIE_LAM_MISCHEADER),
        width = "full",
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

    -- Startup Message Options
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_STARTUPMSG),
        tooltip = GetString(SI_LUIE_LAM_STARTUPMSG_TP),
        getFunc = function() return LUIE.SV.StartupInfo end,
        setFunc = function(value) LUIE.SV.StartupInfo = value end,
        width = "full",
        default = LUIE.D.StartupInfo,
    }

----------------------------------------------------------------------------------------------
-- INFO PANEL
----------------------------------------------------------------------------------------------

    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_PNL_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
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
    }
	optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
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
	}
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        -- Reset InfoPanel position
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_PNL_RESETPOSITION_TP),
        func = LUIE.InfoPanel.ResetPosition,
        width = "half",
    }

    -- Info Panel Options Submenu
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_PNL_HEADER),
        controls = {
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
                type = "header",
                name = GetString(SI_PLAYER_MENU_MISC),
                width = "full",
            },
			{
				type = "checkbox",
				name = "Display Info Panel on World Map Screen", -- TODO: Localize
				tooltip = "Display the Info Panel when you are viewing the world map. This option can be toggled if your Info Panel position clips with any important elements on the World Map screen.", -- TODO: Localize
				getFunc = function() return LUIE.InfoPanel.SV.DisplayOnWorldMap end,
				setFunc = function(value) LUIE.InfoPanel.SV.DisplayOnWorldMap = value LUIE.InfoPanel.SetDisplayOnMap() end,
				width = "full",
				default = false,
				disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
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

----------------------------------------------------------------------------------------------
-- SLASH COMMANDS
----------------------------------------------------------------------------------------------

    optionsDataSlashCommands[#optionsDataSlashCommands + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_SLASHCMDS_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataSlashCommands[#optionsDataSlashCommands + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Slash Commands - General Commands Submenu
    optionsDataSlashCommands[#optionsDataSlashCommands + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_SLASHCMDSHEADER_GENERAL),
        controls = {
            {
                -- SlashTrade
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_TRADE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_TRADE_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashTrade end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashTrade = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashTrade,
            },
            {
                -- SlashHome
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_HOME),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_HOME_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashHome end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashHome = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashHome,
            },
            {
                -- SlashCampaignQ
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_CAMPAIGN),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_CAMPAIGN_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashCampaignQ end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashCampaignQ = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashCampaignQ,
            },
            {
                -- SlashBanker
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_BANKER),
                tooltip = strformat(GetString(SI_LUIE_LAM_SLASHCMDS_BANKER_TP), GetCollectibleName(267)),
                getFunc = function() return LUIE.SlashCommands.SV.SlashBanker end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashBanker = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashBanker,
            },
            {
                -- SlashMerchant
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_MERCHANT),
                tooltip = strformat(GetString(SI_LUIE_LAM_SLASHCMDS_MERCHANT_TP), GetCollectibleName(301)),
                getFunc = function() return LUIE.SlashCommands.SV.SlashMerchant end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashMerchant = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashMerchant,
            },
            {
                -- SlashFence
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_FENCE),
                tooltip = strformat(GetString(SI_LUIE_LAM_SLASHCMDS_FENCE_TP), GetCollectibleName(300)),
                getFunc = function() return LUIE.SlashCommands.SV.SlashFence end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashFence = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashFence,
            },
			{
                -- SlashOutfit
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_OUTFIT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_OUTFIT_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashOutfit end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashOutfit = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashOutfit,
            },
            {
                -- TODO
                type = "checkbox",
                name = "/Home Results - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /home command is used.\nNote: This setting will be deprecated in the future when Social Errors Events are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertHome end,
                setFunc = function(value) LUIE.SV.TempAlertHome = value end,
                width = "full",
                default = LUIE.D.TempAlertHome,
            },
            {
                -- TODO
                type = "checkbox",
                name = "/Campaign Results - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /campaign command is used.\nNote: This setting will be deprecated in the future when Campaign Queue Events are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertCampaign end,
                setFunc = function(value) LUIE.SV.TempAlertCampaign = value end,
                width = "full",
                default = LUIE.D.TempAlertCampaign,
            },
			{
                -- TODO
                type = "checkbox",
                name = "/Outfit - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /outfit command is used.\nNote: This setting will be deprecated in the future when Outfit Alerts are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertOutfit end,
                setFunc = function(value) LUIE.SV.TempAlertOutfit = value end,
                width = "full",
                default = LUIE.D.TempAlertOutfit,
            },
        },
    }

    -- Slash Commands - Group Commands Options Submenu
    optionsDataSlashCommands[#optionsDataSlashCommands + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_SLASHCMDSHEADER_GROUP),
        controls = {
            {
                -- SlashReadyCheck
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_READYCHECK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_READYCHECK_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashReadyCheck end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashReadyCheck = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashReadyCheck,
            },
            {
                -- SlashRegroup
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashRegroup end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashRegroup = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashRegroup,
            },
            {
                -- SlashDisband
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashDisband end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashDisband = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashDisband,
            },
            {
                -- SlashGroupLeave
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_LEAVE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_LEAVE_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashGroupLeave end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashGroupLeave = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashGroupLeave,
            },
            {
                -- SlashGroupKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_KICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_KICK_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashGroupKick end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashGroupKick = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashGroupKick,
            },
            {
                -- SlashVoteKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_VOTEKICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_VOTEKICK_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashVoteKick end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashVoteKick = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashVoteKick,
            },
        },
    }

    -- Slash Commands - Guild Commands Options Submenu
    optionsDataSlashCommands[#optionsDataSlashCommands + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_SLASHCMDSHEADER_GUILD),
        controls = {
            {
                -- SlashGuildInvite
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDINVITE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDINVITE_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashGuildInvite end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashGuildInvite = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashGuildInvite,
            },
            {
                -- SlashGuildQuit
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDQUIT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDQUIT_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashGuildQuit end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashGuildQuit = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashGuildQuit,
            },
            {
                -- SlashGuildKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDKICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDKICK_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashGuildKick end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashGuildKick = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashGuildKick,
            },
        },
    }

    -- Slash Commands - Social Commands Options Submenu
    optionsDataSlashCommands[#optionsDataSlashCommands + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_SLASHCMDSHEADER_SOCIAL),
        controls = {
            {
                -- SlashFriend
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_FRIEND),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_FRIEND_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashFriend end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashFriend = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashFriend,
            },
            {
                -- SlashIgnore
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_IGNORE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_IGNORE_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashIgnore end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashIgnore = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashIgnore,
            },
            {
                -- SlashRemoveFriend
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashRemoveFriend end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashRemoveFriend = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashRemoveFriend,
            },
            {
                -- SlashRemoveIgnore
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE_TP),
                getFunc = function() return LUIE.SlashCommands.SV.SlashRemoveIgnore end,
                setFunc = function(value) LUIE.SlashCommands.SV.SlashRemoveIgnore = value LUIE.SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = LUIE.SlashCommands.D.SlashRemoveIgnore,
            },
        },
    }

----------------------------------------------------------------------------------------------
-- COMBAT INFO
----------------------------------------------------------------------------------------------

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
                getFunc = function() return LUIE.CombatInfo.SV.GlobalShowGCD end,
                setFunc = function(value) LUIE.CombatInfo.SV.GlobalShowGCD = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_CI_GCD_SHOW_WARN),
                default = LUIE.CombatInfo.D.GlobalShowGCD,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_QUICK)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_QUICK_TP),
                getFunc = function() return LUIE.CombatInfo.SV.GlobalPotion end,
                setFunc = function(value) LUIE.CombatInfo.SV.GlobalPotion = value end,
                width = "full",
                default = LUIE.CombatInfo.D.GlobalPotion,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShowGCD) end,
            },
            {
                -- Show GCD Ready Flash
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_FLASH)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_FLASH_TP),
                getFunc = function() return LUIE.CombatInfo.SV.GlobalFlash end,
                setFunc = function(value) LUIE.CombatInfo.SV.GlobalFlash = value end,
                width = "full",
                default = LUIE.CombatInfo.D.GlobalFlash,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShowGCD) end,
            },
            {
                -- GCD - Desaturate Icons on GCD
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_DESAT)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_DESAT_TP),
                getFunc = function() return LUIE.CombatInfo.SV.GlobalDesat end,
                setFunc = function(value) LUIE.CombatInfo.SV.GlobalDesat = value end,
                width = "full",
                default = LUIE.CombatInfo.D.GlobalDesat,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShowGCD) end,
            },
            {
                -- GCD - Color Slot Label Red
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_COLOR_TP),
                getFunc = function() return LUIE.CombatInfo.SV.GlobalLabelColor end,
                setFunc = function(value) LUIE.CombatInfo.SV.GlobalLabelColor = value end,
                width = "full",
                default = LUIE.CombatInfo.D.GlobalLabelColor,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShowGCD) end,
            },
            {
                -- GCD - Animation Method
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_GCD_ANIMATION)),
                tooltip = GetString(SI_LUIE_LAM_CI_GCD_ANIMATION_TP),
                choices = globalMethodOptions,
                getFunc = function() return globalMethodOptions[LUIE.CombatInfo.SV.GlobalMethod] end,
                setFunc = function(value) LUIE.CombatInfo.SV.GlobalMethod = globalMethodOptionsKeys[value] end,
                width = "full",
                default = LUIE.CombatInfo.D.GlobalMethod,
                disabled = function() return not (LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.GlobalShowGCD) end,
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
                getFunc = function() return LUIE.CombatInfo.SV.UltimateLabelEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateLabelEnabled = value LUIE.CombatInfo.RegisterCombatInfo() LUIE.CombatInfo.OnSlotsFullUpdate() end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateLabelEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW_PCT),
                tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_SHOW_PCT_TP),
                getFunc = function() return LUIE.CombatInfo.SV.UltimatePctEnabled end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimatePctEnabled = value LUIE.CombatInfo.RegisterCombatInfo() LUIE.CombatInfo.OnSlotsFullUpdate() end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimatePctEnabled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },

            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
                min = -72, max = 40, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.UltimateLabelPosition end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateLabelPosition = value LUIE.CombatInfo.ResetUltimateLabel() end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateLabelPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.UltimatePctEnabled ) end,
            },
            {
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return LUIE.CombatInfo.SV.UltimateFontFace end,
                setFunc = function(var) LUIE.CombatInfo.SV.UltimateFontFace = var LUIE.CombatInfo.ApplyFont() end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateFontFace,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.UltimatePctEnabled ) end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.CombatInfo.SV.UltimateFontSize end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateFontSize = value LUIE.CombatInfo.ApplyFont() end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.UltimatePctEnabled ) end,
            },
            {
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_STYLE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return LUIE.CombatInfo.SV.UltimateFontStyle end,
                setFunc = function(var) LUIE.CombatInfo.SV.UltimateFontStyle = var LUIE.CombatInfo.ApplyFont() end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateFontStyle,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.UltimatePctEnabled ) end,
            },


            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL)),
                tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL_TP),
                getFunc = function() return LUIE.CombatInfo.SV.UltimateHideFull end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateHideFull = value LUIE.CombatInfo.OnSlotsFullUpdate() end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateHideFull,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.UltimatePctEnabled ) end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_ULTIMATE_TEXTURE),
                tooltip = GetString(SI_LUIE_LAM_CI_ULTIMATE_TEXTURE_TP),
                getFunc = function() return LUIE.CombatInfo.SV.UltimateGeneration end,
                setFunc = function(value) LUIE.CombatInfo.SV.UltimateGeneration = value end,
                width = "full",
                default = LUIE.CombatInfo.D.UltimateGeneration,
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
                getFunc = function() return LUIE.CombatInfo.SV.ShowTriggered end,
                setFunc = function(value) LUIE.CombatInfo.SV.ShowTriggered = value LUIE.CombatInfo.UpdateBarHighlightTables() LUIE.CombatInfo.OnSlotsFullUpdate() end,
                width = "full",
                default = LUIE.CombatInfo.D.ShowTriggered,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },

            {
                -- Bar Proc Sound
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_PROCSOUND)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_PROCSOUND_TP),
                getFunc = function() return LUIE.CombatInfo.SV.ProcEnableSound end,
                setFunc = function(value) LUIE.CombatInfo.SV.ProcEnableSound = value end,
                width = "full",
                default = LUIE.CombatInfo.D.ProcEnableSound,
                disabled = function() return not (LUIE.CombatInfo.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Bar Proc Sound Choice
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_PROCSOUNDCHOICE)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_PROCSOUNDCHOICE_TP),
                choices = SoundsList,
                sort = "name-up",
                getFunc = function() return LUIE.CombatInfo.SV.ProcSoundName end,
                setFunc = function(value) LUIE.CombatInfo.SV.ProcSoundName = value LUIE.CombatInfo.ApplyProcSound(true) end,
                width = "full",
                default = LUIE.CombatInfo.D.ProcSoundName,
                disabled = function() return not (LUIE.CombatInfo.SV.ShowTriggered and LUIE.SV.CombatInfo_Enabled) end,
            },

            {
                -- Highlight Ability Bar Icon for Active Effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_BAR_EFFECT),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_EFFECT_TP),
                getFunc = function() return LUIE.CombatInfo.SV.ShowToggled end,
                setFunc = function(value) LUIE.CombatInfo.SV.ShowToggled = value LUIE.CombatInfo.UpdateBarHighlightTables() LUIE.CombatInfo.OnSlotsFullUpdate() end,
                width = "full",
                default = LUIE.CombatInfo.D.ShowToggled,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                -- Show Toggled Secondary
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_SECONDARY)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_SECONDARY_TP),
                getFunc = function() return LUIE.CombatInfo.SV.ShowToggledSecondary end,
                setFunc = function(value) LUIE.CombatInfo.SV.ShowToggledSecondary = value LUIE.CombatInfo.UpdateBarHighlightTables() LUIE.CombatInfo.OnSlotsFullUpdate() end,
                width = "full",
                default = LUIE.CombatInfo.D.ShowToggledSecondary,
                disabled = function() return not (LUIE.CombatInfo.SV.ShowToggled and LUIE.SV.CombatInfo_Enabled) end,
            },
            {
                -- Show Toggled Ultimate
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_ULTIMATE)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_ULTIMATE_TP),
                getFunc = function() return LUIE.CombatInfo.SV.ShowToggledUltimate end,
                setFunc = function(value) LUIE.CombatInfo.SV.ShowToggledUltimate = value LUIE.CombatInfo.UpdateBarHighlightTables() LUIE.CombatInfo.OnSlotsFullUpdate() end,
                width = "full",
                default = LUIE.CombatInfo.D.ShowToggledUltimate,
                disabled = function() return not (LUIE.CombatInfo.SV.ShowToggled and LUIE.SV.CombatInfo_Enabled) end,
            },
            {
                -- Show Label On Bar Highlight
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_BAR_LABEL)),
                tooltip = GetString(SI_LUIE_LAM_CI_BAR_LABEL_TP),
                getFunc = function() return LUIE.CombatInfo.SV.BarShowLabel end,
                setFunc = function(value) LUIE.CombatInfo.SV.BarShowLabel = value LUIE.CombatInfo.ResetBarLabel() end,
                width = "full",
                default = LUIE.CombatInfo.D.BarShowLabel,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled) ) end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
                min = -72, max = 40, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.BarLabelPosition end,
                setFunc = function(value) LUIE.CombatInfo.SV.BarLabelPosition = value LUIE.CombatInfo.ResetBarLabel() end,
                width = "full",
                default = LUIE.CombatInfo.D.BarLabelPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
            },
            {
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
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.CombatInfo.SV.BarFontSize end,
                setFunc = function(value) LUIE.CombatInfo.SV.BarFontSize = value LUIE.CombatInfo.ApplyFont() end,
                width = "full",
                default = LUIE.CombatInfo.D.BarFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
            },
            {
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
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return LUIE.CombatInfo.SV.BarMiilis end,
                setFunc = function(value) LUIE.CombatInfo.SV.BarMiilis = value end,
                width = "full",
                default = LUIE.CombatInfo.D.BarMiilis,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.BarShowLabel and ( LUIE.CombatInfo.SV.ShowTriggered or LUIE.CombatInfo.SV.ShowToggled)) end,
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
                getFunc = function() return LUIE.CombatInfo.SV.PotionTimerShow end,
                setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerShow = value end,
                width = "full",
                default = LUIE.CombatInfo.D.PotionTimerShow,
                disabled = function() return not LUIE.SV.CombatInfo_Enabled end,
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_POSITION_TP),
                min = -72, max = 40, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.PotionTimerLabelPosition end,
                setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerLabelPosition = value LUIE.CombatInfo.ResetPotionTimerLabel() end,
                width = "full",
                default = LUIE.CombatInfo.D.PotionTimerLabelPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
            },
            {
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
            },
            {
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.CombatInfo.SV.PotionTimerFontSize end,
                setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerFontSize = value LUIE.CombatInfo.ApplyFont() end,
                width = "full",
                default = LUIE.CombatInfo.D.PotionTimerFontSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
            },
            {
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
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CI_POTION_COLOR_TP),
                getFunc = function() return LUIE.CombatInfo.SV.PotionTimerColor end,
                setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerColor = value end,
                width = "full",
                default = LUIE.CombatInfo.D.PotionTimerColor,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
            },
            {
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return LUIE.CombatInfo.SV.PotionTimerMillis end,
                setFunc = function(value) LUIE.CombatInfo.SV.PotionTimerMillis = value end,
                width = "full",
                default = LUIE.CombatInfo.D.PotionTimerMillis,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.PotionTimerShow ) end,
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
                setFunc = LUIE.CombatInfo.SetMovingState,
                width = "half",
                default = false,
                resetFunc = LUIE.CombatInfo.ResetCastBarPosition,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CastBarEnable ) end,
            },
            -- Cast Bar Unlock Reset position
            {
                type = "button",
                name = GetString(SI_LUIE_LAM_RESETPOSITION),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_RESET),
                func = LUIE.CombatInfo.ResetCastBarPosition,
                width = "half",
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CastBarEnable ) end,
            },
            {
                -- Enable Cast Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_ENABLE),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_ENABLE_TP),
                getFunc = function() return LUIE.CombatInfo.SV.CastBarEnable end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarEnable = value LUIE.CombatInfo.RegisterCombatInfo() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarEnable,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },

            {
                -- Cast Bar Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_SIZEW),
                min = 100, max = 500, step = 5,
                getFunc = function() return LUIE.CombatInfo.SV.CastBarSizeW end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarSizeW = value LUIE.CombatInfo.ResizeCastBar() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarSizeW,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                -- Cast Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_SIZEH),
                min = 16, max = 64, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.CastBarSizeH end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarSizeH = value LUIE.CombatInfo.ResizeCastBar() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarSizeH,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },
            {
                -- Cast Bar Icon Size
                type = "slider",
                name = GetString(SI_LUIE_LAM_CI_CASTBAR_ICONSIZE),
                min = 16, max = 64, step = 2,
                getFunc = function() return LUIE.CombatInfo.SV.CastBarIconSize end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarIconSize = value LUIE.CombatInfo.ResizeCastBar() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarIconSize,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled ) end,
            },

            {
                -- Display Label
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_LABEL)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_LABEL_TP),
                getFunc = function() return LUIE.CombatInfo.SV.CastBarLabel end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarLabel = value end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarLabel,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CastBarEnable ) end,
            },
            {
                -- Display Timer
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_TIMER)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_TIMER_TP),
                getFunc = function() return LUIE.CombatInfo.SV.CastBarTimer end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarTimer = value end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarTimer,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CastBarEnable ) end,
            },
            {
                -- Cast Bar Font Face
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_FONTFACE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_FONTFACE_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return LUIE.CombatInfo.SV.CastBarFontFace end,
                setFunc = function(var) LUIE.CombatInfo.SV.CastBarFontFace = var LUIE.CombatInfo.ApplyFont() LUIE.CombatInfo.UpdateCastBar() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarFontFace,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.CombatInfo.SV.CastBarEnable and (LUIE.CombatInfo.SV.CastBarTimer or LUIE.CombatInfo.SV.CastBarLabel) ) end,
            },
            {
                -- Cast Bar Font Size
                type = "slider",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSIZE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.CombatInfo.SV.CastBarFontSize end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarFontSize = value LUIE.CombatInfo.ApplyFont() LUIE.CombatInfo.UpdateCastBar() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarFontSize,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.CombatInfo.SV.CastBarEnable and (LUIE.CombatInfo.SV.CastBarTimer or LUIE.CombatInfo.SV.CastBarLabel) ) end,
            },
            {
                -- Cast Bar Font Style
                type = "dropdown",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSTYLE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return LUIE.CombatInfo.SV.CastBarFontStyle end,
                setFunc = function(var) LUIE.CombatInfo.SV.CastBarFontStyle = var LUIE.CombatInfo.ApplyFont() LUIE.CombatInfo.UpdateCastBar() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarFontStyle,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.CombatInfo.SV.CastBarEnable and (LUIE.CombatInfo.SV.CastBarTimer or LUIE.CombatInfo.SV.CastBarLabel) ) end,
            },
            {
                -- Cast Bar Texture
                type = "dropdown",
                scrollable = true,
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_TEXTURE)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_TEXTURE_TP),
                choices = StatusbarTexturesList,
                sort = "name-up",
                getFunc = function() return LUIE.CombatInfo.SV.CastBarTexture end,
                setFunc = function(value) LUIE.CombatInfo.SV.CastBarTexture = value LUIE.CombatInfo.UpdateCastBar() end,
                width = "full",
                default = LUIE.CombatInfo.D.CastBarTexture,
                disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CastBarEnable ) end,
            },
            {
                -- Cast Bar Gradient Color 1
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC1)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC1_TP),
                getFunc = function() return unpack(LUIE.CombatInfo.SV.CastBarGradientC1) end,
                setFunc = function(r, g, b, a) LUIE.CombatInfo.SV.CastBarGradientC1 = { r, g, b, a } LUIE.CombatInfo.UpdateCastBar() end,
				width = "half",
                default = {r=LUIE.CombatInfo.SV.CastBarGradientC1[1], g=LUIE.CombatInfo.SV.CastBarGradientC1[2], b=LUIE.CombatInfo.SV.CastBarGradientC1[3]},
				disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CastBarEnable ) end,
            },
			{
                -- Cast Bar Gradient Color 2
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC2)),
                tooltip = GetString(SI_LUIE_LAM_CI_CASTBAR_GRADIENTC2_TP),
                getFunc = function() return unpack(LUIE.CombatInfo.SV.CastBarGradientC2) end,
                setFunc = function(r, g, b, a) LUIE.CombatInfo.SV.CastBarGradientC2 = { r, g, b, a } LUIE.CombatInfo.UpdateCastBar() end,
				width = "half",
                default = {r=LUIE.CombatInfo.SV.CastBarGradientC2[1], g=LUIE.CombatInfo.SV.CastBarGradientC2[2], b=LUIE.CombatInfo.SV.CastBarGradientC2[3]},
				disabled = function() return not ( LUIE.SV.CombatInfo_Enabled and LUIE.CombatInfo.SV.CastBarEnable ) end,
            },

        },
    }

----------------------------------------------------------------------------------------------
-- BUFFS AND DEBUFFS
----------------------------------------------------------------------------------------------

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
        getFunc = function() return l_BuffsMovingEnabled end,
        setFunc = function(value)
            l_BuffsMovingEnabled = value
            LUIE.SpellCastBuffs.SetMovingState(value)
            end,
        width = "half",
        default = false,
        resetFunc = LUIE.SpellCastBuffs.ResetTlwPosition,
    }

    -- Buffs Window Reset position
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_BUFF_RESETPOSITION_TP),
        func = LUIE.SpellCastBuffs.ResetTlwPosition,
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
                getFunc = function() return LUIE.SpellCastBuffs.SV.lockPositionToUnitFrames end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.lockPositionToUnitFrames = value end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_BUFF_HARDLOCK_WARNING),
                default = LUIE.SpellCastBuffs.D.lockPositionToUnitFrames,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HidePlayerBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HidePlayerBuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HidePlayerBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HidePlayerDebuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HidePlayerDebuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HidePlayerDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetBuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideTargetDebuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideTargetDebuffs = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.HideTargetDebuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideGroundEffects end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideGroundEffects = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.SV.HideGroundEffects,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                 -- Add Extra
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_ADD_EXTRA_BUFFS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_ADD_EXTRA_BUFFS_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ExtraBuffs end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ExtraBuffs = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.SV.ExtraBuffs,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Consolidate
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_CONSOLIDATE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_CONSOLIDATE_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ExtraConsolidate end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ExtraConsolidate = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.SV.ExtraConsolidate,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },

            {
                -- Extra Expanded
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_EXTEND_EXTRA)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_EXTEND_EXTRA_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ExtraExpanded end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ExtraExpanded = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.SV.ExtraExpanded,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.ExtraBuffs or LUIE.SpellCastBuffs.SV.ExtraConsolidate ) ) end,
            },

            {
                -- Reduce
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_BUFF_REDUCE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_REDUCE_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.HideReduce end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.HideReduce = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.SV.HideReduce,
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
                getFunc = function() return LUIE.SpellCastBuffs.SV.IconSize end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IconSize = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.IconSize,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Show Remaining Time Label
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingText end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingText = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingText,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Label Position
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_SHARED_POSITION)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABEL_POSITION_TP),
                min = -64, max = 64, step = 2,
                getFunc = function() return LUIE.SpellCastBuffs.SV.LabelPosition end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LabelPosition = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LabelPosition,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Label Font
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
            },
            {
                -- Buff Font Size
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_FONT_SIZE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.SpellCastBuffs.SV.BuffFontSize end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.BuffFontSize = value LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.BuffFontSize,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Font Style
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
            },
            {
                -- Buff Colored Label
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CI_POTION_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LABELCOLOR_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingTextColoured end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingTextColoured = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingTextColoured,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Show Seconds Fractions
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingTextMillis end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingTextMillis = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingTextMillis,
                disabled = function() return not (LUIE.SpellCastBuffs.SV.RemainingText and LUIE.SV.SpellCastBuff_Enable) end,
            },
            {
                -- Buff Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_HORIZONTICONALIGN_TP),
                choices = { "Left", "Centered", "Right" },
                getFunc = function() return LUIE.SpellCastBuffs.SV.Alignment end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignment,
                width = "full",
                default = LUIE.SpellCastBuffs.D.Alignment,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Sort Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_DESCENDINGSORT_TP),
                choices = {"Left to Right", "Right to Left"},
                getFunc = function() return LUIE.SpellCastBuffs.SV.SortDirection end,
                setFunc = LUIE.SpellCastBuffs.SetSortDirection,
                width = "full",
                default = LUIE.SpellCastBuffs.D.SortDirection,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Glow Icon Border
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_GLOWICONBORDER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.GlowIcons end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.GlowIcons = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.GlowIcons,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Show Border Cooldown
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN),
                tooltip = GetString(SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.RemainingCooldown end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.RemainingCooldown = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.RemainingCooldown,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Buff Fade Expiring Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON),
                tooltip = GetString(SI_LUIE_LAM_BUFF_FADEEXPIREICON_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.FadeOutIcons end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.FadeOutIcons = value end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.FadeOutIcons,
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
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffects_Player end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffects_Player = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffects_Player,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_TARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffects_Target end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffects_Target = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffects_Target,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Seperate control for player effects
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffectsSeparate = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffectsSeparate,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player ) end,
            },
            {
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
            },
            {
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
            },
            {
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
            },
            {
                -- Long Term Reverse Sort Order
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_REVERSE_ORDER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.LongTermEffectsReverse end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.LongTermEffectsReverse = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.LongTermEffectsReverse,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.LongTermEffects_Player ) end,
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
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreDisguise end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreDisguise = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreDisguise,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Assistants
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreAssistant end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreAssistant = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreAssistant,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mounts
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMount end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMount = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMount,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },

            {
                -- Use Generic Mount Icon
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_ICON)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_ICON_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.MountGenericIcon end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.MountGenericIcon = value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.MountGenericIcon,
                disabled = function() return LUIE.SpellCastBuffs.SV.IgnoreMount and not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },

            {
                -- Long Term - Pets
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_PET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnorePet end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnorePet = not value LUIE.SpellCastBuffs.OnPlayerActivated() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnorePet,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mundus - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMundusPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMundusPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMundusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Mundus - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreMundusTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreMundusTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreMundusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Food & Drink - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreFoodPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreFoodPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreFoodPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Food & Drink - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_FOODTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreFoodTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreFoodTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreFoodTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Experience - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCEPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreExperiencePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreExperiencePlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreExperiencePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Experience - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_EXPERIENCETARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreExperienceTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreExperienceTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreExperienceTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Vamp Stage - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreVampPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreVampPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreVampPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Vamp Stage - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreVampTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreVampTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreVampTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Lycanthrophy - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreLycanPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreLycanPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreLycanPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Lycanthrophy - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreLycanTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreLycanTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreLycanTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Disease - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreDiseasePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreDiseasePlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreDiseasePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Disease - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreDiseaseTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreDiseaseTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreDiseaseTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Timers - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBitePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBitePlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBitePlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Bite Timers - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBiteTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBiteTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBiteTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Battle Spirit - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") LUIE.SpellCastBuffs.ArtificialEffectUpdate() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBattleSpiritPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Battle Spirit - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreBattleSpiritTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreBattleSpiritTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Cyrodiil - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreCyrodiilPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreCyrodiilPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreCyrodiilPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Crodiil - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreCyrodiilTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreCyrodiilTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreCyrodiilTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - ESO Plus - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreEsoPlusPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreEsoPlusPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreEsoPlusPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - ESO Plus - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreEsoPlusTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreEsoPlusTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreEsoPlusTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Soul Summons - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSoulSummonsPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Soul Summons - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSoulSummonsTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSoulSummonsTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Set ICD - Player
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSetICDPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSetICDPlayer = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSetICDPlayer,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
            },
            {
                -- Long Term - Set ICD - Target
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET_TP),
                getFunc = function() return not LUIE.SpellCastBuffs.SV.IgnoreSetICDTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.IgnoreSetICDTarget = not value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = not LUIE.SpellCastBuffs.D.IgnoreSetICDTarget,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and ( LUIE.SpellCastBuffs.SV.LongTermEffects_Player or LUIE.SpellCastBuffs.SV.LongTermEffects_Target ) ) end,
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
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP_TP),
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
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWREZZ_TP),
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
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWRECALL_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowRecall end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowRecall = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowRecall,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },

            {
                -- Show Werewolf Timer Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWWEREWOLF),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWWEREWOLF_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowWerewolf end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowWerewolf = value LUIE.SpellCastBuffs.RegisterWerewolfEvents() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowWerewolf,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },

            {
                -- Show Block Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowBlockPlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowBlockPlayer = value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects("player") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowBlockPlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Block Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ShowBlockTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowBlockTarget = value LUIE.SpellCastBuffs.UpdateContextHideList() LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ShowBlockTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Stealth Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER_TP),
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
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.StealthStateTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.StealthStateTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.StealthStateTarget,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Player Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.DisguiseStatePlayer end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.DisguiseStatePlayer = value LUIE.SpellCastBuffs.ReloadEffects() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.DisguiseStatePlayer,
                disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
            },
            {
                -- Show Disguise Target Icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET),
                tooltip = GetString(SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.DisguiseStateTarget end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.DisguiseStateTarget = value LUIE.SpellCastBuffs.ReloadEffects("reticleover") end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.DisguiseStateTarget,
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
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentLabel end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ProminentLabel = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentLabel,
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
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentLabelFontFace end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.ProminentLabelFontFace = var LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentLabelFontFace,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Label Font Size
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTSIZE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTSIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentLabelFontSize end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ProminentLabelFontSize = value LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentLabelFontSize,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentLabel ) end,
            },
            {
                -- Prominent Buffs Label Font Style
                type = "dropdown",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_FONTSTYLE)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_FONTSTYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentLabelFontStyle end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.ProminentLabelFontStyle = var LUIE.SpellCastBuffs.ApplyFont() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentLabelFontStyle,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentLabel ) end,
            },
			{
                -- Prominent Buffs Progress Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_PROGRESSBAR_TP),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentProgress end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ProminentProgress = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentProgress,
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
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentProgressTexture end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ProminentProgressTexture = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentProgressTexture,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentProgress ) end,
            },
			{
                -- Prominent Buffs Gradient Color 1
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF1)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF1_TP),
                getFunc = function() return unpack(LUIE.SpellCastBuffs.SV.ProminentProgressBuffC1) end,
                setFunc = function(r, g, b, a) LUIE.SpellCastBuffs.SV.ProminentProgressBuffC1 = { r, g, b, a } LUIE.SpellCastBuffs.Reset() end,
				width = "half",
                default = {r=LUIE.SpellCastBuffs.SV.ProminentProgressBuffC1[1], g=LUIE.SpellCastBuffs.SV.ProminentProgressBuffC1[2], b=LUIE.SpellCastBuffs.SV.ProminentProgressBuffC1[3]},
				disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentProgress ) end,
            },
			{
                -- Prominent Buffs Gradient Color 2
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF2)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORBUFF2_TP),
                getFunc = function() return unpack(LUIE.SpellCastBuffs.SV.ProminentProgressBuffC2) end,
                setFunc = function(r, g, b, a) LUIE.SpellCastBuffs.SV.ProminentProgressBuffC2 = { r, g, b, a } LUIE.SpellCastBuffs.Reset() end,
				width = "half",
                default = {r=LUIE.SpellCastBuffs.SV.ProminentProgressBuffC2[1], g=LUIE.SpellCastBuffs.SV.ProminentProgressBuffC2[2], b=LUIE.SpellCastBuffs.SV.ProminentProgressBuffC2[3]},
				disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentProgress ) end,
            },
			{
                -- Prominent Debuffs Gradient Color 1
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF1)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF1_TP),
                getFunc = function() return unpack(LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC1) end,
                setFunc = function(r, g, b, a) LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC1 = { r, g, b, a } LUIE.SpellCastBuffs.Reset() end,
				width = "half",
                default = {r=LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC1[1], g=LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC1[2], b=LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC1[3]},
				disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentProgress ) end,
            },
			{
                -- Prominent Debuffs Gradient Color 2
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF2)),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_COLORDEBUFF2_TP),
                getFunc = function() return unpack(LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC2) end,
                setFunc = function(r, g, b, a) LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC2 = { r, g, b, a } LUIE.SpellCastBuffs.Reset() end,
				width = "half",
                default = {r=LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC2[1], g=LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC2[2], b=LUIE.SpellCastBuffs.SV.ProminentProgressDebuffC2[3]},
				disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and LUIE.SpellCastBuffs.SV.ProminentProgress ) end,
            },
			{
				-- Prominent Buffs Label/Progress Bar Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFLABELDIRECTION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFLABELDIRECTION_TP),
                choices = { "Right", "Left" },
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentBuffLabelDirection end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.ProminentBuffLabelDirection = var LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentBuffLabelDirection,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and (LUIE.SpellCastBuffs.SV.ProminentLabel or LUIE.SpellCastBuffs.SV.ProminentProgress) ) end,
            },
			{
				-- Prominent Debuffs Label/Progress Bar Direction
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFLABELDIRECTION),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFLABELDIRECTION_TP),
                choices = { "Right", "Left" },
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentDebuffLabelDirection end,
                setFunc = function(var) LUIE.SpellCastBuffs.SV.ProminentDebuffLabelDirection = var LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentDebuffLabelDirection,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable and (LUIE.SpellCastBuffs.SV.ProminentLabel or LUIE.SpellCastBuffs.SV.ProminentProgress) ) end,
            },
            {
				-- Prominent Buffs Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFALIGNMENT_TP),
                choices = { "Top", "Middle", "Bottom" },
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentBuffAlignment end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignmentProminentBuff,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentBuffAlignment,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
			{
				-- Prominent Debuffs Alignment
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFALIGNMENT_TP),
                choices = { "Top", "Middle", "Bottom" },
                sort = "name-up",
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentDebuffAlignment end,
                setFunc = LUIE.SpellCastBuffs.SetIconsAlignmentProminentDebuff,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentDebuffAlignment,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
            {
                -- Prominent Buffs Reverse Sort Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFREVERSESORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_BUFFREVERSESORT),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentBuffReverseSort end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ProminentBuffReverseSort = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentBuffReverseSort,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
            },
			{
                -- Prominent Debuffs Reverse Sort Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFREVERSESORT),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFFREVERSESORT),
                getFunc = function() return LUIE.SpellCastBuffs.SV.ProminentDebuffReverseSort end,
                setFunc = function(value) LUIE.SpellCastBuffs.SV.ProminentDebuffReverseSort = value LUIE.SpellCastBuffs.Reset() end,
                width = "full",
                default = LUIE.SpellCastBuffs.D.ProminentDebuffReverseSort,
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
                setFunc = function(value) LUIE.SpellCastBuffs.AddToCustomList(LUIE.SpellCastBuffs.SV.PromBuffTable, value) LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.PromBuffTable)) end,
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
                getFunc = function() LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.PromBuffTable)) end,
                setFunc = function(value) LUIE.SpellCastBuffs.RemoveFromCustomList(LUIE.SpellCastBuffs.SV.PromBuffTable, value) LUIE_Prominent_Buffs_List:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.PromBuffTable)) end,
                disabled = function() return not ( LUIE.SV.SpellCastBuff_Enable ) end,
                reference = "LUIE_Prominent_Buffs_List"
            },
            {
                -- Prominent Debuffs List (Add)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_ADDLIST),
                tooltip = GetString(SI_LUIE_LAM_BUFF_PROM_DEBUFF_ADDLIST_TP),
                getFunc = function() end,
                setFunc = function(value) LUIE.SpellCastBuffs.AddToCustomList(LUIE.SpellCastBuffs.SV.PromDebuffTable, value) LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.PromDebuffTable)) end,
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
                getFunc = function() LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.PromDebuffTable)) end,
                setFunc = function(value) LUIE.SpellCastBuffs.RemoveFromCustomList(LUIE.SpellCastBuffs.SV.PromDebuffTable, value) LUIE_Prominent_Debuffs_List:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.PromDebuffTable)) end,
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
                setFunc = function(value) LUIE.SpellCastBuffs.AddToCustomList(LUIE.SpellCastBuffs.SV.BlacklistTable, value) LUIE_Blacklist:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.BlacklistTable)) end,
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
                getFunc = function() LUIE_Blacklist:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.BlacklistTable)) end,
                setFunc = function(value) LUIE.SpellCastBuffs.RemoveFromCustomList(LUIE.SpellCastBuffs.SV.BlacklistTable, value) LUIE_Blacklist:UpdateChoices(GenerateCustomList(LUIE.SpellCastBuffs.SV.BlacklistTable)) end,
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
        getFunc = function() return LUIE.SpellCastBuffs.SV.ShowDebugAbilityId end,
        setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowDebugAbilityId = value LUIE.SpellCastBuffs.Reset() end,
        width = "full",
        default = LUIE.SpellCastBuffs.D.ShowDebugAbilityId,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Show Debug for Combat Events",
        tooltip = "Display debug information for combat events - used for development.",
        getFunc = function() return LUIE.SpellCastBuffs.SV.ShowDebugCombat end,
        setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowDebugCombat = value LUIE.SpellCastBuffs.RegisterDebugEvents() end,
        width = "full",
        default = LUIE.SpellCastBuffs.D.ShowDebugCombat,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Show Debug for Effect Change Events",
        tooltip = "Display debug information for effect change events - used for development.",
        getFunc = function() return LUIE.SpellCastBuffs.SV.ShowDebugEffect end,
        setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowDebugEffect = value LUIE.SpellCastBuffs.RegisterDebugEvents() end,
        width = "full",
        default = LUIE.SpellCastBuffs.D.ShowDebugEffect,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

    -- Debug
    optionsDataBuffsDebuffs[#optionsDataBuffsDebuffs + 1] = {
        type = "checkbox",
        name = "Filter Debug Events & Effects",
        tooltip = "Filter out events and effects that have already been processed - used for development.",
        getFunc = function() return LUIE.SpellCastBuffs.SV.ShowDebugFilter end,
        setFunc = function(value) LUIE.SpellCastBuffs.SV.ShowDebugFilter = value end,
        width = "full",
        default = LUIE.SpellCastBuffs.D.ShowDebugFilter,
        disabled = function() return not LUIE.SV.SpellCastBuff_Enable end,
    }

----------------------------------------------------------------------------------------------
-- CHAT ANNOUNCEMENTS
----------------------------------------------------------------------------------------------

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
                getFunc = function() return chatNameDisplayOptions[LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions = chatNameDisplayOptionsKeys[value] LUIE.ChatAnnouncements.IndexGroupLoot() end,
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
                getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionCharacter] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionCharacter = linkBracketDisplayOptionsKeys[value] LUIE.ChatAnnouncements.IndexGroupLoot() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.BracketOptionCharacter,
            },
            --[[{
                -- Notification Color
                type = "colorpicker",
                name = "Notification Color (Unimplemented)",
                tooltip = "This message will be used to colorize various generic notification messages that are not Social/Guild related or error messages.",
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Notify.NotificationColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Notify.NotificationColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.TodoLater end,
                default = {r=LUIE.ChatAnnouncements.D.Notify.NotificationColor[1], g=LUIE.ChatAnnouncements.D.Notify.NotificationColor[2], b=LUIE.ChatAnnouncements.D.Notify.NotificationColor[3]}
            },]]--
            {
                -- Choose Chat Print Method
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_CHATMETHOD),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATMETHOD_TP),
                choices = { "Print to All Tabs", "Print to Specific Tabs" },
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatMethod end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatMethod = value end,
                width = "full",
                sort = "name-up",
                default = LUIE.ChatAnnouncements.D.ChatMethod,
            },
            {
                -- Bypass LUIE to use other chat addons
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CHATBYPASS)),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATBYPASS_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatBypass end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatBypass = value end,
                width = "full",
                disabled = function() return LUIE.ChatAnnouncements.SV.ChatMethod == "Print to Specific Tabs" end,
                default = LUIE.ChatAnnouncements.D.ChatBypass,
            },
            {
                -- Print Chat Announcements & Messages to Tab 1
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "1"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "1"),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatTab[1] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatTab[1] = value end,
                width = "full",
                disabled = function() return LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" end,
                default = LUIE.ChatAnnouncements.D.ChatTab[1],
            },
            {
                -- Print Chat Announcements & Messages to Tab 2
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "2"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "2"),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatTab[2] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatTab[2] = value end,
                width = "full",
                disabled = function() return LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" end,
                default = LUIE.ChatAnnouncements.D.ChatTab[2],
            },
            {
                -- Print Chat Announcements & Messages to Tab 3
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "3"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "3"),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatTab[3] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatTab[3] = value end,
                width = "full",
                disabled = function() return LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" end,
                default = LUIE.ChatAnnouncements.D.ChatTab[3],
            },
            {
                -- Print Chat Announcements & Messages to Tab 4
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "4"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "4"),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatTab[4] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatTab[4] = value end,
                width = "full",
                disabled = function() return LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" end,
                default = LUIE.ChatAnnouncements.D.ChatTab[4],
            },
            {
                -- Print Chat Announcements & Messages to Tab 5
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB), "5"),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_CHATTAB_TP), "5"),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatTab[5] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatTab[5] = value end,
                width = "full",
                disabled = function() return LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" end,
                default = LUIE.ChatAnnouncements.D.ChatTab[5],
            },
            {
                -- Display System & Notifications in all Tabs
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CHATTABSYSTEMALL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CHATTABSYSTEMALL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ChatSystemAll end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ChatSystemAll = value end,
                width = "full",
                disabled = function() return LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" end,
                default = LUIE.ChatAnnouncements.D.ChatSystemAll,
            },
            {
                -- Include Timestamp
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_TIMESTAMP),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMP_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.TimeStamp end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.TimeStamp = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.TimeStamp,
            },
            {
                -- Timestamp Format
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_TIMESTAMPFORMAT)),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMPFORMAT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.TimeStampFormat end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.TimeStampFormat = value end,
                width = "full",
                disabled = function() return not LUIE.ChatAnnouncements.SV.TimeStamp end,
                default = LUIE.ChatAnnouncements.D.TimeStampFormat,
            },
            {
                -- Timestamp Color
                type    = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_TIMESTAMPCOLOR)),
                tooltip = GetString(SI_LUIE_LAM_CA_TIMESTAMPCOLOR_TP),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.TimeStampColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.TimeStampColor = { r, g, b, a } LUIE.UpdateTimeStampColor() end,
                width = "full",
                disabled = function() return not LUIE.ChatAnnouncements.SV.TimeStamp end,
                default = {r=LUIE.ChatAnnouncements.SV.TimeStampColor[1], g=LUIE.ChatAnnouncements.SV.TimeStampColor[2], b=LUIE.ChatAnnouncements.SV.TimeStampColor[3]},
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
                -- Hide Gold Spent on AH (Listing)
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHLIST)),
                tooltip = strformat("<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHLIST_TP)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldHideListingAH end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldHideListingAH = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyGoldChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyGoldHideListingAH,
            },
            {
                -- Hide Gold Spent on AH (Purchase)
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
                -- Show Outfit Tokens
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENS_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenChange end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyOutfitTokenChange,
            },
            {
                -- Show Outfit Tokens Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSCOLOR)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyOutfitTokenColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyOutfitTokenColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyOutfitTokenColor[3]}
            },
            {
                -- Show Outfit Tokens Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSNAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenName = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyOutfitTokenName,
            },
            {
                -- Show Outfit Tokens Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTOKENSTOTAL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenShowTotal end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenShowTotal = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyOutfitTokenShowTotal,
            },
            {
                -- Total Currency Message (Outfit Tokens)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TOKENSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TOKENSTOTAL_MSG_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalOutfitToken end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalOutfitToken = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyOutfitTokenShowTotal) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalOutfitToken,
            },
            {
                -- Show Transmute Crystals
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteChange end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyTransmuteChange,
            },
            {
                -- Show Transmute Crystals Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTECOLOR)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyTransmuteColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyTransmuteColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyTransmuteColor[3]}
            },
            {
                -- Show Transmute Crystals Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTENAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTENAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteName = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyTransmuteName,
            },
            {
                -- Show Transmute Crystals Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTETOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWTRANSMUTETOTAL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteShowTotal end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteShowTotal = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyTransmuteShowTotal,
            },
            {
                -- Total Currency Message (Transmute Crystals)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_TRANSMUTETOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_TRANSMUTETOTAL_MSG_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalTransmute end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalTransmute = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyTransmuteShowTotal) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalTransmute,
            },
            {
                -- Show Event Tickets
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyEventChange end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyEventChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyEventChange,
            },
            {
                -- Show Event Tickets Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTCOLOR)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyEventColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyEventColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyEventColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyEventColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyEventColor[3]}
            },
            {
                -- Show Event Tickets Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTNAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyEventName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyEventName = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyEventName,
            },
            {
                -- Show Event Tickets Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWEVENTTOTAL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyEventShowTotal end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyEventShowTotal = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyEventChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyEventShowTotal,
            },
            {
                -- Total Currency Message (Event Tickets)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_EVENTTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_EVENTTOTAL_MSG_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalEvent end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalEvent = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyEventChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyEventShowTotal) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalEvent,
            },
            {
                -- Show Crowns
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNS_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsChange end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyCrownsChange,
            },
            {
                -- Show Crowns Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSCOLOR)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyCrownsColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyCrownsColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyCrownsColor[3]}
            },
            {
                -- Show Crowns Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSNAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsName = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyCrownsName,
            },
            {
                -- Show Crowns Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNSTOTAL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsShowTotal end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsShowTotal = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyCrownsShowTotal,
            },
            {
                -- Total Currency Message (Crowns)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNSTOTAL_MSG_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalCrowns end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalCrowns = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownsShowTotal) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalCrowns,
            },
            {
                -- Show Crown Gems
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMS_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsChange end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsChange = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyCrownGemsChange,
            },
            {
                -- Show Crown Gems Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSCOLOR)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyCrownGemsColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyCrownGemsColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyCrownGemsColor[3]}
            },
            {
                -- Show Crown Gems Name
                type = "editbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSNAME)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSNAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsName = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyCrownGemsName,
            },
            {
                -- Show Crown Gems Total
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSTOTAL)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_SHOWCROWNGEMSTOTAL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsShowTotal end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsShowTotal = value end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsChange and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyCrownGemsShowTotal,
            },
            {
                -- Total Currency Message (Crown Gems)
                type = "editbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNGEMSTOTAL_MSG)),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_CROWNGEMSTOTAL_MSG_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalCrownGems end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyMessageTotalCrownGems = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsChange and LUIE.ChatAnnouncements.SV.Currency.CurrencyCrownGemsShowTotal) end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyMessageTotalCrownGems,
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
                getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionItem] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionItem = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.BracketOptionItem,
            },
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
                -- Show Removed Items
                type = "checkbox",
                name = strformat("\t\t\t\t\t\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWREMOVED)),
                tooltip = GetString(SI_LUIE_LAM_CA_LOOT_LOOTSHOWREMOVED_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Inventory.LootShowRemove end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Inventory.LootShowRemove = value LUIE.ChatAnnouncements.RegisterLootEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.Loot and LUIE.ChatAnnouncements.SV.Inventory.LootShowDestroy and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.Inventory.LootShowRemove,
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
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.LootVendor and LUIE.ChatAnnouncements.SV.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
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
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Inventory.LootVendor and LUIE.ChatAnnouncements.SV.Inventory.LootVendorCurrency and LUIE.SV.ChatAnnouncements_Enable) end,
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
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyColor) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyColor = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable or LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyColor[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyColor[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyColor[3]}
            },
            {
                -- Use Context Color for Currency/Loot Messages
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Currency.CurrencyContextColor,
            },
            {
                -- Positive Change Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORUP)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyColorUp) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyColorUp = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyColorUp[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyColorUp[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyColorUp[3]}
            },
            {
                -- Negative Change Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_CURRENCY_COLORDOWN)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Currency.CurrencyColorDown) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Currency.CurrencyColorDown = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Currency.CurrencyContextColor and LUIE.SV.ChatAnnouncements_Enable) end,
                default = {r=LUIE.ChatAnnouncements.D.Currency.CurrencyColorDown[1], g=LUIE.ChatAnnouncements.D.Currency.CurrencyColorDown[2], b=LUIE.ChatAnnouncements.D.Currency.CurrencyColorDown[3]}
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
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLoot = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageLoot,
            },
            {
                -- Loot Message (Receive)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageReceive = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageReceive,
            },
            {
                -- Earned Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageEarn end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageEarn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageEarn,
            },
            {
                -- Loot Message (Steal)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSteal end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSteal = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageSteal,
            },
            {
                -- Loot Message (Pickpocket)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessagePickpocket end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessagePickpocket = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessagePickpocket,
            },
            {
                -- Loot Message (Confiscate)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageConfiscate end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageConfiscate = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageConfiscate,
            },
            {
                -- Loot Message (Spend)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSpend = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageSpend,
            },
            {
                -- Loot Message (Pay)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PAY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PAY_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessagePay end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessagePay = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessagePay,
            },
            {
                -- Loot Message (TradeIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeIn end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeIn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageTradeIn,
            },
            {
                -- Loot Message (TradeIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_NO_NAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeInNoName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeInNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageTradeInNoName,
            },
            {
                -- Loot Message (TradeOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOut end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOut = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageTradeOut,
            },
            {
                -- Loot Message (TradeOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_NO_NAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOutNoName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTradeOutNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageTradeOutNoName,
            },
            {
                -- Loot Message (MailIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailIn end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailIn = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageMailIn,
            },
            {
                -- Loot Message (MailIn)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_NO_NAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailInNoName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailInNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageMailInNoName,
            },
            {
                -- Loot Message (MailOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOut end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOut = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageMailOut,
            },
            {
                -- Loot Message (MailOut)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_NO_NAME),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_NO_NAME_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOutNoName end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMailOutNoName = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageMailOutNoName,
            },
            {
                -- Loot Message (Deposit)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeposit = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDeposit,
            },
            {
                -- Loot Message (Withdraw)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdraw end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdraw = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageWithdraw,
            },
            {
                -- Loot Message (Deposit Guild)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositGuild end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositGuild  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDepositGuild ,
            },
            {
                -- Loot Message (Withdraw Guild)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawGuild  end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawGuild  = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageWithdrawGuild ,
            },
            {
                -- Loot Message (Deposit)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITSTORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITSTORAGE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositStorage end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDepositStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDepositStorage,
            },
            {
                -- Loot Message (Withdraw)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWSTORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWSTORAGE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawStorage end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWithdrawStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageWithdrawStorage,
            },
            {
                -- Lost Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLost end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLost = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageLost,
            },
            {
                -- Bounty Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBounty end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBounty = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageBounty,
            },
            {
                -- Repair Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageRepair end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageRepair = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageRepair,
            },
            {
                -- Trader Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTrader end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageTrader = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageTrader,
            },
            {
                -- Listing Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageListing end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageListing = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageListing,
            },
            {
                -- Loot Message (Buy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_VALUE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuy end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageBuy,
            },
            {
                -- Loot Message (Buy) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUY_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuyNoV end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuyNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageBuyNoV,
            },
            {
                -- Loot Message (Buyback)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_VALUE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuyback end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuyback = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageBuyback,
            },
            {
                -- Loot Message (Buyback) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BUYBACK_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuybackNoV end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageBuybackNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageBuybackNoV,
            },
            {
                -- Loot Message (Sell)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_VALUE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSell end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSell = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageSell,
            },
            {
                -- Loot Message (Sell) No Value
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SELL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSellNoV end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSellNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageSellNoV,
            },
            {
                -- Loot Message (Fence)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_VALUE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageFence end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageFence = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageFence,
            },
            {
                -- Loot Message (Fence)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_FENCE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageFenceNoV end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageFenceNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageFenceNoV,
            },
            {
                -- Loot Message (Launder)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_VALUE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_VALUE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunder end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunder = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageLaunder,
            },
            {
                -- Loot Message (Launder)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LAUNDER_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunderNoV end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLaunderNoV = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageLaunderNoV,
            },
            {
                -- Stable Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageStable end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageStable = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageStable,
            },
            {
                -- Storage Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageStorage end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageStorage = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageStorage,
            },
            {
                -- Wayshrine Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWayshrine end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageWayshrine = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageWayshrine,
            },
            {
                -- Unstuck Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUnstuck end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUnstuck = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageUnstuck,
            },
            {
                -- Attributes Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageAttributes end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageAttributes = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageAttributes,
            },
            {
                -- Champion Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageChampion end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageChampion = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageChampion,
            },
            {
                -- Morphs Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMorphs end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageMorphs = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageMorphs,
            },
            {
                -- Skills Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSkills end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageSkills = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageSkills,
            },
            {
                -- Campaign Message
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CAMPAIGN_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageCampaign end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageCampaign = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageCampaign,
            },
            {
                -- Loot Message (Use)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_USE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_USE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUse = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageUse,
            },
            {
                -- Loot Message (Craft)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CRAFT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CRAFT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageCraft = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageCraft,
            },
            {
                -- Loot Message (Extract)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXTRACT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EXTRACT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageExtract end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageExtract = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageExtract,
            },
            {
                -- Loot Message (Upgrade)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgrade end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgrade = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageUpgrade,
            },
            {
                -- Loot Message (Upgrade)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_FAIL),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UPGRADE_FAIL_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageUpgradeFail = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageUpgradeFail,
            },
            {
                -- Loot Message (Refine)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REFINE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REFINE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageRefine end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageRefine = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageRefine,
            },
            {
                -- Loot Message (Deconstruct)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DECONSTRUCT),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DECONSTRUCT_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeconstruct end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDeconstruct = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDeconstruct,
            },
            {
                -- Loot Message (Research)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RESEARCH),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RESEARCH_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageResearch end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageResearch = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageResearch,
            },
            {
                -- Loot Message (Destroy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DESTROY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DESTROY_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDestroy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDestroy,
            },
            {
                -- Loot Message (Lockpick)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOCKPICK),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOCKPICK_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLockpick end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageLockpick = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageLockpick,
            },
            {
                -- Loot Message Removed (Quest)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REMOVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REMOVE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageRemove end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageRemove = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageRemove,
            },
            {
                -- Loot Message Group
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_GROUP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_GROUP_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageGroup end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageGroup = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageGroup,
            },
            {
                -- Loot Message (Disguise Equip)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_EQUIP),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_EQUIP_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseEquip end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseEquip = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDisguiseEquip,
            },
            {
                -- Loot Message (Disguise Remove)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_REMOVE),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_REMOVE_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseRemove end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseRemove = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDisguiseRemove,
            },
            {
                -- Loot Message (Disguise Destroy)
                type = "editbox",
                name = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_DESTROY),
                tooltip = GetString(SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DISGUISE_DESTROY_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseDestroy end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.ContextMessages.CurrencyMessageDisguiseDestroy = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.ContextMessages.CurrencyMessageDisguiseDestroy,
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
                width = "full",
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
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_UD),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_UD_TP),
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
                -- Skill Psijic Order
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CA_GUILDREP_PO),
                tooltip = GetString(SI_LUIE_LAM_CA_GUILDREP_PO_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Skills.SkillGuildPsijicOrder end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Skills.SkillGuildPsijicOrder = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Skills.SkillGuildPsijicOrder,
            },
            {
                -- Guild Skill Point Color PO
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_GUILDREP_PO_COLOR)),
                getFunc = function() return unpack(LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorPO) end,
                setFunc = function(r, g, b, a) LUIE.ChatAnnouncements.SV.Skills.SkillGuildColorPO = { r, g, b, a } LUIE.ChatAnnouncements.RegisterColorEvents() end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and LUIE.ChatAnnouncements.SV.Skills.SkillGuildDarkBrotherhood) end,
                default = {r=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorPO[1], g=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorPO[2], b=LUIE.ChatAnnouncements.D.Skills.SkillGuildColorPO[3]}
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
                -- Collectible Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionCollectible] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionCollectible = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleCSA or LUIE.ChatAnnouncements.SV.Collectibles.CollectibleAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.BracketOptionCollectible,
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
                width = "full",
            },
            {
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
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA = value LUIE.ChatAnnouncements.RegisterAchievementsEvent() end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementUpdateCA,
            },
            {
                -- Show Achievement Update Alert
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
                -- Achievement Bracket
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT),
                tooltip = GetString(SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT_TP),
                choices = linkBracketDisplayOptions,
                getFunc = function() return linkBracketDisplayOptions[LUIE.ChatAnnouncements.SV.BracketOptionAchievement] end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.BracketOptionAchievement = linkBracketDisplayOptionsKeys[value] end,
                width = "full",
                disabled = function() return not (LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteCSA or LUIE.ChatAnnouncements.SV.Achievement.AchievementCompleteAlert or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateCA or LUIE.ChatAnnouncements.SV.Achievement.AchievementUpdateAlert and LUIE.SV.ChatAnnouncements_Enable) end,
                default = LUIE.ChatAnnouncements.D.BracketOptionAchievement,
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
                width = "full",
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
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(12)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(12)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory12 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory12 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory12,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(13)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(13)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory13 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory13 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory13,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(14)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(14)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory14 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory14 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory14,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(15)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(15)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory15 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory15 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory15,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(16)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(16)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory16 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory16 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory16,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(17)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(17)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory17 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory17 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory17,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(18)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(18)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory18 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory18 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory18,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(19)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(19)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory19 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory19 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory19,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(20)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(20)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory20 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory20 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory20,
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
            },
			{
                -- Enables achievements tracking in %s category
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY), GetAchievementCategoryInfo(21)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP), GetAchievementCategoryInfo(21)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory21 end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Achievement.AchievementCategory21 = value end,
                width = "full",
                default = LUIE.ChatAnnouncements.D.Achievement.AchievementCategory21,
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
                width = "full",
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
                width = "full",
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
                width = "full",
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
                width = "full",
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
                width = "full",
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
                width = "full",
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
                getFunc = function() return LUIE.ChatAnnouncements.SV.DisplayAnnouncements.Debug end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.DisplayAnnouncements.Debug = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.DisplayAnnouncements.Debug,
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
                -- Imperial City Display Announcement (CA)
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
                -- Imperial City Display Announcement (CSA)
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
                -- Imperial City Display Announcement (Alert)
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
                -- Imperial City Display Description
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION)),
                tooltip = GetString(SI_LUIE_LAM_CA_QUEST_IC_DESCRIPTION_TP),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestICDescription end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestICDescription = value end,
                width = "full",
                disabled = function() return not (LUIE.SV.ChatAnnouncements_Enable and (LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCA or LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryCSA or LUIE.ChatAnnouncements.SV.Quests.QuestICDiscoveryAlert) ) end,
                default = LUIE.ChatAnnouncements.D.Quests.QuestICDiscoveryAlert,
            },
            {
                -- Craglorn Buff (CA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_CA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CA)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestCraglornBuffCA end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestCraglornBuffCA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Quests.QuestCraglornBuffCA,
            },
            {
                -- Craglorn Buff (CSA)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_CSA_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_CSA)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestCraglornBuffCSA end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestCraglornBuffCSA = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Quests.QuestCraglornBuffCSA,
            },
            {
                -- Craglorn Buff (Alert)
                type = "checkbox",
                name = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN), GetString(SI_LUIE_LAM_CA_SHARED_ALERT_SHORT)),
                tooltip = strformat(GetString(SI_LUIE_LAM_CA_DISPLAY_CRAGLORN_TP), GetString(SI_LUIE_LAM_CA_SHARED_ALERT)),
                getFunc = function() return LUIE.ChatAnnouncements.SV.Quests.QuestCraglornBuffAlert end,
                setFunc = function(value) LUIE.ChatAnnouncements.SV.Quests.QuestCraglornBuffAlert = value end,
                width = "full",
                disabled = function() return not LUIE.SV.ChatAnnouncements_Enable end,
                default = LUIE.ChatAnnouncements.D.Quests.QuestCraglornBuffAlert,
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

----------------------------------------------------------------------------------------------
-- UNIT FRAMES
----------------------------------------------------------------------------------------------

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

    -- Custom Unit Frames Unlock
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK_TP),
        getFunc = function() return LUIE.CombatInfo.CastBarUnlocked end,
        setFunc = LUIE.UnitFrames.CustomFramesSetMovingState,
        width = "half",
        default = false,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        resetFunc = function() LUIE.UnitFrames.CustomFramesResetPosition(false) end,
    }

    -- Custom Unit Frames Reset position
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT_TP),
        func = function() LUIE.UnitFrames.CustomFramesResetPosition(false) end,
        width = "half",
    }

    -- Unit Frames - Default Unit Frames Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_HEADER),
        controls = {
            {
                -- Default PLAYER frame
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
            {
                -- Default TARGET frame
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
            {
                -- Default small GROUP frame
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
            {
                -- Reposition default player bars
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
            {
                -- Reposition frames adjust Y Coordinates
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
            {
                -- Out-of-Combat bars transparency
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
            {
                -- In-Combat bars transparency
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
            {
                -- Format label text
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
            {
                -- DefaultFrames Font
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
            {
                -- DefaultFrames Font Size
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
            {
                -- DefaultFrames Font Style
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
            {
                 -- Color of text labels
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_COLOR),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.DefaultTextColour) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.DefaultTextColour={r,g,b} LUIE.UnitFrames.DefaultFramesApplyColour() end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.DefaultTextColour[1], g=LUIE.UnitFrames.D.DefaultTextColour[2], b=LUIE.UnitFrames.D.DefaultTextColour[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Color target name by reaction
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION),
                tooltip = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION_TP),
                getFunc = function() return LUIE.UnitFrames.SV.TargetColourByReaction end,
                setFunc = LUIE.UnitFrames.TargetColourByReaction,
                width = "full",
                default = LUIE.UnitFrames.D.TargetColourByReaction,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Target class icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS),
                tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS_TP),
                getFunc = function() return LUIE.UnitFrames.SV.TargetShowClass end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetShowClass = value end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetShowClass,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Target ignore/friend/guild icon
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

    -- Unit Frames - Custom Unit Frames Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_HEADER),
        controls = {
            {
                -- Custom Unit Frames Font
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
            {
                -- Custom Unit Frames Font size labels
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
            {
                -- Custom Unit Frames Font size bars
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
            {
                -- Custom Unit Frames Font style
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
            {
                -- Custom Unit Frames Texture
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
            {
                -- Custom Unit Frames Separate Shield Bar
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
            {
                -- Custom Unit Frames Separate Shield Bar Height
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT_TP),
                min = 4, max = 12, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.CustomShieldBarHeight end,
                setFunc = function(value) LUIE.UnitFrames.SV.CustomShieldBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) LUIE.UnitFrames.CustomFramesApplyLayoutGroup() end,
                width = "full",
                default = LUIE.UnitFrames.D.CustomShieldBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomShieldBarSeparate ) end,
            },
            {
                -- Custom Unit Frames Overlay Full Height Shield Bar
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
            {
                -- Shield Transparency
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_ALPHA),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_ALPHA_TP),
                min = 0, max = 100, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.ShieldAlpha end,
                setFunc = function(value) LUIE.UnitFrames.SV.ShieldAlpha = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.ShieldAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and not LUIE.UnitFrames.SV.CustomShieldBarSeparate ) end,
            },
            {
                -- Custom Unit Frames Smooth Bar Transition
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS_TP),
                getFunc = function() return LUIE.UnitFrames.SV.CustomSmoothBar end,
                setFunc = function(value) LUIE.UnitFrames.SV.CustomSmoothBar = value end,
                width = "full",
                default = LUIE.UnitFrames.D.CustomSmoothBar,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Champion Points Effective
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

    -- Unit Frames - Custom Unit Frame Color Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEADER),
        controls = {
            {
                -- Custom Unit Frames Health Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALTH),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealth) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealth={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourHealth[1], g=LUIE.UnitFrames.D.CustomColourHealth[2], b=LUIE.UnitFrames.D.CustomColourHealth[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Shield Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SHIELD),
                getFunc = function() return LUIE.UnitFrames.SV.CustomColourShield[1], LUIE.UnitFrames.SV.CustomColourShield[2], LUIE.UnitFrames.SV.CustomColourShield[3]  end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourShield={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourShield[1], g=LUIE.UnitFrames.D.CustomColourShield[2], b=LUIE.UnitFrames.D.CustomColourShield[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Magicka Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_MAGICKA),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourMagicka) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourMagicka={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourMagicka[1], g=LUIE.UnitFrames.D.CustomColourMagicka[2], b=LUIE.UnitFrames.D.CustomColourMagicka[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Stamina Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_STAMINA),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourStamina) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourStamina={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourStamina[1], g=LUIE.UnitFrames.D.CustomColourStamina[2], b=LUIE.UnitFrames.D.CustomColourStamina[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames DPS Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DPS),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourDPS) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourDPS={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourDPS[1], g=LUIE.UnitFrames.D.CustomColourDPS[2], b=LUIE.UnitFrames.D.CustomColourDPS[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Healer Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALER),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHealer) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHealer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourHealer[1], g=LUIE.UnitFrames.D.CustomColourHealer[2], b=LUIE.UnitFrames.D.CustomColourHealer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Tank Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TANK),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourTank) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourTank={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourTank[1], g=LUIE.UnitFrames.D.CustomColourTank[2], b=LUIE.UnitFrames.D.CustomColourTank[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Dragonknight Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DK),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourDragonknight) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourDragonknight={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourDragonknight[1], g=LUIE.UnitFrames.D.CustomColourDragonknight[2], b=LUIE.UnitFrames.D.CustomColourDragonknight[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Nightblade Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_NB),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourNightblade) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourNightblade={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourNightblade[1], g=LUIE.UnitFrames.D.CustomColourNightblade[2], b=LUIE.UnitFrames.D.CustomColourNightblade[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Sorcerer Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SORC),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourSorcerer) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourSorcerer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourSorcerer[1], g=LUIE.UnitFrames.D.CustomColourSorcerer[2], b=LUIE.UnitFrames.D.CustomColourSorcerer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Templar Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TEMP),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourTemplar) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourTemplar={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourTemplar[1], g=LUIE.UnitFrames.D.CustomColourTemplar[2], b=LUIE.UnitFrames.D.CustomColourTemplar[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Warden Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_WARD),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourWarden) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourWarden={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourWarden[1], g=LUIE.UnitFrames.D.CustomColourWarden[2], b=LUIE.UnitFrames.D.CustomColourWarden[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_PLAYER),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourPlayer) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourPlayer={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourPlayer[1], g=LUIE.UnitFrames.D.CustomColourPlayer[2], b=LUIE.UnitFrames.D.CustomColourPlayer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_FRIENDLY),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourFriendly) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourFriendly={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourFriendly[1], g=LUIE.UnitFrames.D.CustomColourFriendly[2], b=LUIE.UnitFrames.D.CustomColourFriendly[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_HOSTILE),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourHostile) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourHostile={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourHostile[1], g=LUIE.UnitFrames.D.CustomColourHostile[2], b=LUIE.UnitFrames.D.CustomColourHostile[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_NEUTRAL),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourNeutral) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourNeutral={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourNeutral[1], g=LUIE.UnitFrames.D.CustomColourNeutral[2], b=LUIE.UnitFrames.D.CustomColourNeutral[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },

            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_GUARD),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.CustomColourGuard) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.CustomColourGuard={r,g,b} LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.CustomColourGuard[1], g=LUIE.UnitFrames.D.CustomColourGuard[2], b=LUIE.UnitFrames.D.CustomColourGuard[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frames (Player & Target) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_HEADER),
        controls = {
            {
                -- Enable LUIE PLAYER frame
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
            {
                -- Enable LUIE Target frame
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
            {
                 -- Player Name Display Method (Player)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_PLAYER),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_PLAYER_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[LUIE.UnitFrames.SV.DisplayOptionsPlayer] end,
                setFunc = function(value) LUIE.UnitFrames.SV.DisplayOptionsPlayer = nameDisplayOptionsKeys[value] LUIE.UnitFrames.CustomFramesReloadControlsMenu(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Player Name Display Method (Target)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_TARGET_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[LUIE.UnitFrames.SV.DisplayOptionsTarget] end,
                setFunc = function(value) LUIE.UnitFrames.SV.DisplayOptionsTarget = nameDisplayOptionsKeys[value] LUIE.UnitFrames.CustomFramesReloadControlsMenu(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Custom Unit Frames format left label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
                choices = formatOptions,
                getFunc = function() return LUIE.UnitFrames.SV.CustomFormatOnePT end,
                setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatOnePT = var LUIE.UnitFrames.CustomFramesFormatLabels(true) LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = LUIE.UnitFrames.D.CustomFormatOnePT,
            },
            {
                -- Custom Unit Frames format right label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
                choices = formatOptions,
                getFunc = function() return LUIE.UnitFrames.SV.CustomFormatTwoPT end,
                setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatTwoPT = var LUIE.UnitFrames.CustomFramesFormatLabels(true) LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = LUIE.UnitFrames.D.CustomFormatTwoPT,
            },
            {
                -- Player Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_WIDTH),
                min = 200, max = 500, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.PlayerBarWidth end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Player Health Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_HP_HIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightHealth end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightHealth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerBarHeightHealth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Player Magicka Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_HIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightMagicka end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightMagicka = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerBarHeightMagicka,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Player Stamina Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_HIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.PlayerBarHeightStamina end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarHeightStamina = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerBarHeightStamina,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Out-of-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.PlayerOocAlpha end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerOocAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
            },
            {
                -- In-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.PlayerIncAlpha end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerIncAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
            },
            {
                -- HIDE BUFFS OOC - PLAYER
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER_TP),
                getFunc = function() return LUIE.UnitFrames.SV.HideBuffsPlayerOoc end,
                setFunc = function(value) LUIE.UnitFrames.SV.HideBuffsPlayerOoc = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
                width = "full",
                default = LUIE.UnitFrames.D.HideBuffsPlayerOoc,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
            },
            {
                -- Display self name on Player Frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF_TP),
                getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableYourname end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableYourname = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerEnableYourname,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display Mount/Siege/Werewolf Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR_TP),
                getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarMSW end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarMSW = value LUIE.UnitFrames.CustomFramesSetupAlternative() LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerEnableAltbarMSW,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display XP/Champion XP Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR_TP),
                getFunc = function() return LUIE.UnitFrames.SV.PlayerEnableAltbarXP end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerEnableAltbarXP = value LUIE.UnitFrames.CustomFramesSetupAlternative() LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerEnableAltbarXP,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Champion XP Bar Point-Type Color
                type = "checkbox",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR_TP),
                getFunc = function() return LUIE.UnitFrames.SV.PlayerChampionColour end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerChampionColour = value LUIE.UnitFrames.OnChampionPointGained() LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerChampionColour,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerEnableAltbarXP ) end,
            },
            {
                -- Custom Unit Frames Low Health Warning
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_HEALTH),
                tooltip = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_HEALTH_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.LowResourceHealth end,
                setFunc = function(value) LUIE.UnitFrames.SV.LowResourceHealth = value LUIE.UnitFrames.CustomFramesReloadLowResourceThreshold() end,
                width = "full",
                default = LUIE.UnitFrames.D.LowResourceHealth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Custom Unit Frames Low Magicka Warning
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_MAGICKA),
                tooltip = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_MAGICKA_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.LowResourceMagicka end,
                setFunc = function(value) LUIE.UnitFrames.SV.LowResourceMagicka = value LUIE.UnitFrames.CustomFramesReloadLowResourceThreshold() end,
                width = "full",
                default = LUIE.UnitFrames.D.LowResourceMagicka,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Custom Unit Frames Low Stamina Warning
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_STAMINA),
                tooltip = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_STAMINA_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.LowResourceStamina end,
                setFunc = function(value) LUIE.UnitFrames.SV.LowResourceStamina = value LUIE.UnitFrames.CustomFramesReloadLowResourceThreshold() end,
                width = "full",
                default = LUIE.UnitFrames.D.LowResourceStamina,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Target Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_WIDTH),
                min = 200, max = 500, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.TargetBarWidth end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
            },
            {
                -- Target Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.TargetBarHeight end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
            },
            {
                -- Out-of-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.TargetOocAlpha end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetOocAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetOocAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
            },
            {
                -- In-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_ICPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.TargetIncAlpha end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetIncAlpha = value LUIE.UnitFrames.CustomFramesApplyInCombat() LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetIncAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
            },
            {
                -- HIDE BUFFS OOC - TARGET
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BUFFS_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BUFFS_TARGET_TP),
                getFunc = function() return LUIE.UnitFrames.SV.HideBuffsTargetOoc end,
                setFunc = function(value) LUIE.UnitFrames.SV.HideBuffsTargetOoc = value LUIE.UnitFrames.CustomFramesApplyInCombat() end,
                width = "full",
                default = LUIE.UnitFrames.D.HideBuffsTargetOoc,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( LUIE.UnitFrames.SV.CustomFramesPlayer or LUIE.UnitFrames.SV.CustomFramesTarget ) ) end,
            },
            {
                -- Color Target by Reaction
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_REACTION_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_REACTION_TARGET_TP),
                getFunc = function() return LUIE.UnitFrames.SV.FrameColorReaction end,
                setFunc = function(value) LUIE.UnitFrames.SV.FrameColorReaction = value LUIE.UnitFrames.CustomFramesApplyColours() end,
                width = "full",
                default = LUIE.UnitFrames.D.FrameColorReaction,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
            },
            {
                -- Display Target Class Label
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL_TP),
                getFunc = function() return LUIE.UnitFrames.SV.TargetEnableClass end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableClass = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetEnableClass,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
            },
            {
                -- Execute Health % Threshold
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD_TP),
                min = 0, max = 50, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.ExecutePercentage end,
                setFunc = function(value) LUIE.UnitFrames.SV.ExecutePercentage = value LUIE.UnitFrames.CustomFramesReloadExecuteMenu() end,
                width = "full",
                default = LUIE.UnitFrames.D.ExecutePercentage,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
            },
            {
                -- Display Skull Execute Texture
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE_TP),
                getFunc = function() return LUIE.UnitFrames.SV.TargetEnableSkull end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableSkull = value end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetEnableSkull,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesTarget ) end,
            },
            {
                -- Display title on target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE_TP),
                getFunc = function() return LUIE.UnitFrames.SV.TargetEnableTitle end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableTitle = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetEnableTitle,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display rank name on target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TP),
                getFunc = function() return LUIE.UnitFrames.SV.TargetEnableRank end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableRank = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetEnableRank,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Prioritize Title or AvA Rank
                type = 'dropdown',
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TITLE_PRIORITY)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TITLE_PRIORITY_TP),
                choices = { "AVA Rank", "Title" },
                getFunc = function() return LUIE.UnitFrames.SV.TargetTitlePriority end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetTitlePriority = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetTitlePriority,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.TargetEnableRank and LUIE.UnitFrames.SV.TargetEnableTitle) end,
            },
            {
                -- Display rank icon on target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANKICON),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANKICON_TP),
                getFunc = function() return LUIE.UnitFrames.SV.TargetEnableRankIcon end,
                setFunc = function(value) LUIE.UnitFrames.SV.TargetEnableRankIcon = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.TargetEnableRankIcon,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display Armor stat change
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
            {
                -- Display Power stat change
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
            {
                -- Custom Unit Frames Display HoT / DoT Animations
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
            {
                -- Treat Missing Power as In-Combat
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

    -- Unit Frames - Additional Player Frame Display Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_OPTIONS_HEADER),
        controls = {
            {
                -- Player Frames Display Method
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
            {
                -- Position Adjust Horizontal
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_HORIZ_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_HORIZ_ADJUST_TP),
                min = 0, max = 500, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.AdjustStaminaHPos end,
                setFunc = function(value) LUIE.UnitFrames.SV.AdjustStaminaHPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.AdjustStaminaHPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Position Adjust Vertical
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_VERT_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_VERT_ADJUST_TP),
                min = -250, max = 250, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.AdjustStaminaVPos end,
                setFunc = function(value) LUIE.UnitFrames.SV.AdjustStaminaVPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.AdjustStaminaVPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Position Adjust
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_HORIZ_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_HORIZ_ADJUST_TP),
                min = 0, max = 500, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.AdjustMagickaHPos end,
                setFunc = function(value) LUIE.UnitFrames.SV.AdjustMagickaHPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.AdjustMagickaHPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Position Adjust
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_VERT_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_VERT_ADJUST_TP),
                min = -250, max = 250, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.AdjustMagickaVPos end,
                setFunc = function(value) LUIE.UnitFrames.SV.AdjustMagickaVPos = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.AdjustMagickaVPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and LUIE.UnitFrames.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Spacing between Player Bars
                type = "slider",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING_TP),
                min = -1, max = 4, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.PlayerBarSpacing end,
                setFunc = function(value) LUIE.UnitFrames.SV.PlayerBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.PlayerBarSpacing,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesPlayer and ( LUIE.UnitFrames.SV.PlayerFrameOptions == 1 or LUIE.UnitFrames.SV.PlayerFrameOptions == 3 ) ) end,
            },
            {
                -- Hide Player Magicka Bar Label
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
            {
                 -- Hide Player Magicka Bar
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
            {
                -- Hide Player Stamina Bar Label
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
            {
                -- Hide Player Stamina Bar
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
        },
    }

    -- Unit Frames - Custom Unit Frames (Group) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEADER),
        controls = {
            {
                -- Enable Group Frames
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
            {
                -- Player Name Display Method (Group/Raid)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[LUIE.UnitFrames.SV.DisplayOptionsGroupRaid] end,
                setFunc = function(value) LUIE.UnitFrames.SV.DisplayOptionsGroupRaid = nameDisplayOptionsKeys[value] LUIE.UnitFrames.CustomFramesReloadControlsMenu(false, true, true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Custom Unit Frames format left label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
                choices = formatOptions,
                getFunc = function() return LUIE.UnitFrames.SV.CustomFormatOneGroup end,
                setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatOneGroup = var LUIE.UnitFrames.CustomFramesFormatLabels(true) LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
                default = LUIE.UnitFrames.D.CustomFormatOneGroup,
            },
            {
                -- Custom Unit Frames format right label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
                choices = formatOptions,
                getFunc = function() return LUIE.UnitFrames.SV.CustomFormatTwoGroup end,
                setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatTwoGroup = var LUIE.UnitFrames.CustomFramesFormatLabels(true) LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
                default = LUIE.UnitFrames.D.CustomFormatTwoGroup,
            },
            {
                -- Group Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_WIDTH),
                min = 100, max = 400, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.GroupBarWidth end,
                setFunc = function(value) LUIE.UnitFrames.SV.GroupBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.GroupBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Group Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.GroupBarHeight end,
                setFunc = function(value) LUIE.UnitFrames.SV.GroupBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.GroupBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Group / Raid ALPHA
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.GroupAlpha end,
                setFunc = function(value) LUIE.UnitFrames.SV.GroupAlpha = value LUIE.UnitFrames.CustomFramesGroupAlpha() LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.GroupAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Spacing between Group Bars
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_SPACING),
                min = 20, max = 80, step = 2,
                getFunc = function() return LUIE.UnitFrames.SV.GroupBarSpacing end,
                setFunc = function(value) LUIE.UnitFrames.SV.GroupBarSpacing = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.GroupBarSpacing,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Include Player in Group Frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER_TP),
                getFunc = function() return not LUIE.UnitFrames.SV.GroupExcludePlayer end,
                setFunc = function(value) LUIE.UnitFrames.SV.GroupExcludePlayer = (not value) LUIE.UnitFrames.CustomFramesGroupUpdate() LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = not LUIE.UnitFrames.D.GroupExcludePlayer,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Show Role Icon on Group Frames
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON_TP),
                getFunc = function() return LUIE.UnitFrames.SV.RoleIconSmallGroup end,
                setFunc = function(value) LUIE.UnitFrames.SV.RoleIconSmallGroup = value LUIE.UnitFrames.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.RoleIconSmallGroup,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Custom Unit Frames Group Color Player Role
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE_TP),
                getFunc = function() return LUIE.UnitFrames.SV.ColorRoleGroup end,
                setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleGroup = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.ColorRoleGroup,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Custom Unit Frames Group Color Class
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS_TP),
                getFunc = function() return LUIE.UnitFrames.SV.ColorClassGroup end,
                setFunc = function(value) LUIE.UnitFrames.SV.ColorClassGroup = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.ColorClassGroup,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Display Armor stat change
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
            {
                -- Display Power stat change
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
            {
                -- Display Regen Arrows
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

    -- Unit Frames - Custom Unit Frames (Raid) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEADER),
        controls = {
            {
                -- Enable Raid Frames
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
            {
                -- Player Name Display Method (Group/Raid)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[LUIE.UnitFrames.SV.DisplayOptionsGroupRaid] end,
                setFunc = function(value) LUIE.UnitFrames.SV.DisplayOptionsGroupRaid = nameDisplayOptionsKeys[value] LUIE.UnitFrames.CustomFramesReloadControlsMenu(false, true, true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Raid HP Bar Format
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_TP),
                choices = formatOptions,
                getFunc = function() return LUIE.UnitFrames.SV.CustomFormatRaid end,
                setFunc = function(var) LUIE.UnitFrames.SV.CustomFormatRaid = var LUIE.UnitFrames.CustomFramesFormatLabels(true) LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
                default = LUIE.UnitFrames.D.CustomFormatRaid,
            },
            {
                -- Raid Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_WIDTH),
                min = 100, max = 500, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.RaidBarWidth end,
                setFunc = function(value) LUIE.UnitFrames.SV.RaidBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.RaidBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
            },
            {
                -- Raid Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.RaidBarHeight end,
                setFunc = function(value) LUIE.UnitFrames.SV.RaidBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.RaidBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
            },
            {
                -- Group / Raid ALPHA
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.GroupAlpha end,
                setFunc = function(value) LUIE.UnitFrames.SV.GroupAlpha = value LUIE.UnitFrames.CustomFramesGroupAlpha() LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.GroupAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesGroup ) end,
            },
            {
                -- Raid Frame Layout
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_LAYOUT),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_LAYOUT_TP),
                choices = { "1 x 24", "2 x 12", "3 x 8", "4 x 6", "6 x 4" },
                -- sort = "name-up",
                getFunc = function() return LUIE.UnitFrames.SV.RaidLayout end,
                setFunc = function(var) LUIE.UnitFrames.SV.RaidLayout = var LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
                default = LUIE.UnitFrames.D.RaidLayout,
            },
            {
                -- Add Spacer for every 4 members
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER_TP),
                getFunc = function() return LUIE.UnitFrames.SV.RaidSpacers end,
                setFunc = function(value) LUIE.UnitFrames.SV.RaidSpacers = LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.RaidSpacers,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
            },
            {
                -- Raid Name Clip
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP_TP),
                min = 0, max = 200, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.RaidNameClip end,
                setFunc = function(value) LUIE.UnitFrames.SV.RaidNameClip = value LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.RaidNameClip,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
            },
            {
                -- Class / Role Icon on Raid Frames Setting
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_ROLEICON),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_ROLEICON_TP),
                choices = raidIconOptions,
                getFunc = function() return raidIconOptions[LUIE.UnitFrames.SV.RaidIconOptions] end,
                setFunc = function(value) LUIE.UnitFrames.SV.RaidIconOptions = raidIconOptionsKeys[value] LUIE.UnitFrames.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.RaidIconOptions,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
            },
            {
                -- Custom Unit Frames Raid Color Player Role
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE_TP),
                getFunc = function() return LUIE.UnitFrames.SV.ColorRoleRaid end,
                setFunc = function(value) LUIE.UnitFrames.SV.ColorRoleRaid = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.ColorRoleRaid,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
            },
            {
                -- Custom Unit Frames Raid Color Player Class
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS_TP),
                getFunc = function() return LUIE.UnitFrames.SV.ColorClassRaid end,
                setFunc = function(value) LUIE.UnitFrames.SV.ColorClassRaid = value LUIE.UnitFrames.CustomFramesApplyColours(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.ColorClassRaid,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesRaid ) end,
            },
            {
                -- Display Armor stat change
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
            {
                -- Display Power stat change
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
            {
                -- Display Regen Arrows
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

    -- Unit Frames - Custom Unit Frames (Boss) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEADER),
        controls = {
            {
                -- Enable This Addon BOSS frames
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
            {
                -- Boss HP Bar Format
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
            {
                -- Boss Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESB_WIDTH),
                min = 100, max = 500, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.BossBarWidth end,
                setFunc = function(value) LUIE.UnitFrames.SV.BossBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutBosses() end,
                width = "full",
                default = LUIE.UnitFrames.D.BossBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
            },
            {
                -- Boss Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.BossBarHeight end,
                setFunc = function(value) LUIE.UnitFrames.SV.BossBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutBosses() end,
                width = "full",
                default = LUIE.UnitFrames.D.BossBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.CustomFramesBosses ) end,
            },
            {
                -- Out-of-Combat frame opacity
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
            {
                -- In-Combat frame opacity
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
            {
                -- Display Armor stat change
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
            {
                -- Display Power stat change
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
            {
                -- Display Regen Arrows
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

    -- Unit Frames - Custom Unit Frames (PvP Target Frame) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_HEADER),
        controls = {
            {
                -- Enable additional PvP Target frame
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
            {
                -- PvP Target Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_WIDTH),
                min = 300, max = 700, step = 5,
                getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarWidth end,
                setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarWidth = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.AvaTargetBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
            },
            {
                -- PvP Target Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return LUIE.UnitFrames.SV.AvaTargetBarHeight end,
                setFunc = function(value) LUIE.UnitFrames.SV.AvaTargetBarHeight = value LUIE.UnitFrames.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.AvaTargetBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.AvaCustFramesTarget ) end,
            },
        },
    }

    -- Unit Frames - Common Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HEADER),
        controls = {
            {
                -- Shorten numbers
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS),
                tooltip = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS_TP),
                getFunc = function() return LUIE.UnitFrames.SV.ShortenNumbers end,
                setFunc = function(value) LUIE.UnitFrames.SV.ShortenNumbers = value LUIE.UnitFrames.CustomFramesFormatLabels(true) end,
                width = "full",
                default = LUIE.UnitFrames.D.ShortenNumbers,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Default Caption Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_CAPTIONCOLOR),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour={r,g,b} end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.Target_FontColour[1], g=LUIE.UnitFrames.D.Target_FontColour[2], b=LUIE.UnitFrames.D.Target_FontColour[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Friendly NPC Font Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NPCFONTCOLOR),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_FriendlyNPC) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_FriendlyNPC={r,g,b} end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[1], g=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[2], b=LUIE.UnitFrames.D.Target_FontColour_FriendlyNPC[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Friendly Player Font Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_PLAYERFONTCOLOR),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_FriendlyPlayer) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_FriendlyPlayer={r,g,b} end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[1], g=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[2], b=LUIE.UnitFrames.D.Target_FontColour_FriendlyPlayer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Hostile Font Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_HOSTILEFONTCOLOR),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.Target_FontColour_Hostile) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.Target_FontColour_Hostile={r,g,b} end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.Target_FontColour_Hostile[1], g=LUIE.UnitFrames.D.Target_FontColour_Hostile[2], b=LUIE.UnitFrames.D.Target_FontColour_Hostile[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Apply same settings to reticle
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLOR),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLOR_TP),
                getFunc = function() return LUIE.UnitFrames.SV.ReticleColourByReaction end,
                setFunc = LUIE.UnitFrames.ReticleColourByReaction,
                width = "full",
                default = LUIE.UnitFrames.D.ReticleColourByReaction,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Interactible Reticle Color
                type = "colorpicker",
                name = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLORINTERACT)),
                getFunc = function() return unpack(LUIE.UnitFrames.SV.ReticleColour_Interact) end,
                setFunc = function(r,g,b,a) LUIE.UnitFrames.SV.ReticleColour_Interact={r,g,b} end,
                width = "full",
                default = { r=LUIE.UnitFrames.D.ReticleColour_Interact[1], g=LUIE.UnitFrames.D.ReticleColour_Interact[2], b=LUIE.UnitFrames.D.ReticleColour_Interact[3] },
                disabled = function() return not (LUIE.SV.UnitFrames_Enabled and LUIE.UnitFrames.SV.ReticleColourByReaction) end,
            },
        },
    }

----------------------------------------------------------------------------------------------
-- Combat Text
----------------------------------------------------------------------------------------------

    -- Combat Text Description
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

    optionsDataCombatText[#optionsDataCombatText +1] = {
        -- Unlock Panels
        type    = "checkbox",
        width = "half",
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

    -- Combat Text - Common Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HEADER),
        controls = {
            {
                -- In Combat Only
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_IC_ONLY),
                tooltip = GetString(SI_LUIE_LAM_CT_IC_ONLY_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.inCombatOnly end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.inCombatOnly = v end,
                default = LUIE.CombatText.D.toggles.inCombatOnly,
            },
            {
                -- Transparency
                type = "slider",
                name = GetString(SI_LUIE_LAM_CT_TRANSPARENCY),
                tooltip = GetString(SI_LUIE_LAM_CT_TRANSPARENCY_TP),
                min = 0,
                max = 100,
                getFunc = function() return LUIE.CombatText.SV.common.transparencyValue end,
                setFunc = function(v) LUIE.CombatText.SV.common.transparencyValue = v end,
                default = LUIE.CombatText.D.common.transparencyValue,
            },
            {
                -- Abbreviate Numbers
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CT_ABBREVIATE),
                tooltip = GetString(SI_LUIE_LAM_CT_ABBREVIATE_TP),
                getFunc = function() return LUIE.CombatText.SV.common.abbreviateNumbers end,
                setFunc = function(v) LUIE.CombatText.SV.common.abbreviateNumbers = v end,
                default = LUIE.CombatText.D.common.abbreviateNumbers,
            },
        },
    }

    -- Combat Text - Damage & Healing Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_DAMAGE_AND_HEALING), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                width = "full",
            },
            {
                -- Damage (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDamage end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDamage = v end,
                default = LUIE.CombatText.D.toggles.incoming.showDamage,
            },
            {
                -- Damage (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDamage end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDamage = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showDamage,
            },
            {
                -- Damage Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.damage end,
                setFunc = function(v) LUIE.CombatText.SV.formats.damage = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.damage,
            },
            {
                -- Damage Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_CRITICAL_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.damagecritical end,
                setFunc = function(v) LUIE.CombatText.SV.formats.damagecritical = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.damagecritical,
            },
            {
                -- Damage Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DAMAGE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.damage end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.damage = size end,
                default = LUIE.CombatText.D.fontSizes.damage,
            },
            {
                -- Damage Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DAMAGE_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.damagecritical end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.damagecritical = size end,
                default = LUIE.CombatText.D.fontSizes.damagecritical,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                width = "full",
            },
            {
                -- Damage over Time (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DOT_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDot end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDot = v end,
                default = LUIE.CombatText.D.toggles.incoming.showDot,
            },
            {
                -- Damage over Time (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DOT_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDot end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDot = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showDot,
            },
            {
                -- Damage over Time Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.dot end,
                setFunc = function(v) LUIE.CombatText.SV.formats.dot = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.dot,
            },
            {
                -- Damage over Time Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_CRITICAL_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.dotcritical end,
                setFunc = function(v) LUIE.CombatText.SV.formats.dotcritical = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.dotcritical,
            },
            {
                -- Damage over Time Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DOT_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.dot end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.dot = size end,
                default = LUIE.CombatText.D.fontSizes.dot,
            },
            {
                -- Damage over Time Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DOT_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.dotcritical end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.dotcritical = size end,
                default = LUIE.CombatText.D.fontSizes.dotcritical,
            },
            {
                -- Damage Color Options
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_DAMAGE_COLOR),
                width = "full",
            },
            {
                -- None
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_NONE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_NONE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[0]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[0] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[0][1], g=LUIE.CombatText.D.colors.damage[0][2], b=LUIE.CombatText.D.colors.damage[0][3]}
            },
            {
                -- Generic
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[1]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[1] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[1][1], g=LUIE.CombatText.D.colors.damage[1][2], b=LUIE.CombatText.D.colors.damage[1][3]}
            },
            {
                -- Physical
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[2]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[2] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[2][1], g=LUIE.CombatText.D.colors.damage[2][2], b=LUIE.CombatText.D.colors.damage[2][3]}
            },
            {
                -- Fire
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[3]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[3] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[3][1], g=LUIE.CombatText.D.colors.damage[3][2], b=LUIE.CombatText.D.colors.damage[3][3]}
            },
            {
                -- Shock
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[4]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[4] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[4][1], g=LUIE.CombatText.D.colors.damage[4][2], b=LUIE.CombatText.D.colors.damage[4][3]}
            },
            {
                -- Oblivion
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[5]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[5] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[5][1], g=LUIE.CombatText.D.colors.damage[5][2], b=LUIE.CombatText.D.colors.damage[5][3]}
            },
            {
                -- Cold
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[6]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[6] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[6][1], g=LUIE.CombatText.D.colors.damage[6][2], b=LUIE.CombatText.D.colors.damage[6][3]}
            },
            {
                -- Eearth
                type     = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[7]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[7] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[7][1], g=LUIE.CombatText.D.colors.damage[7][2], b=LUIE.CombatText.D.colors.damage[7][3]}
            },
            {
                -- Magic
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[8]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[8] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[8][1], g=LUIE.CombatText.D.colors.damage[8][2], b=LUIE.CombatText.D.colors.damage[8][3]}
            },
            {
                -- Drown
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[9]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[9] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[9][1], g=LUIE.CombatText.D.colors.damage[9][2], b=LUIE.CombatText.D.colors.damage[9][3]}
            },
            {
                -- Disease
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[10]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[10] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[10][1], g=LUIE.CombatText.D.colors.damage[10][2], b=LUIE.CombatText.D.colors.damage[10][3]}
            },
            {
                -- Poison
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damage[11]) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damage[11] = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damage[11][1], g=LUIE.CombatText.D.colors.damage[11][2], b=LUIE.CombatText.D.colors.damage[11][3]}
            },

            {
                -- Checkbox Critical Damage Override
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.criticalDamageOverride end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.criticalDamageOverride = v end,
                default = LUIE.CombatText.D.toggles.criticalDamageOverride,
            },
            {
                -- Color Critical Damage Override
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.criticalDamageOverride) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.criticalDamageOverride = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.criticalDamageOverride[1], g=LUIE.CombatText.D.colors.criticalDamageOverride[2], b=LUIE.CombatText.D.colors.criticalDamageOverride[3]}
            },

            {
                -- Checkbox Incoming Damage Override
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incomingDamageOverride end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incomingDamageOverride = v end,
                default = LUIE.CombatText.D.toggles.incomingDamageOverride
            },
            {
                -- Color Incoming Damage Override
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.incomingDamageOverride) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.incomingDamageOverride = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.incomingDamageOverride[1], g=LUIE.CombatText.D.colors.incomingDamageOverride[2], b=LUIE.CombatText.D.colors.incomingDamageOverride[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                width = "full",
            },
            {
                -- Healing (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HEALING), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HEALING_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showHealing end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showHealing = v end,
                default = LUIE.CombatText.D.toggles.incoming.showHealing,
            },
            {
                -- Healing (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HEALING), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HEALING_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showHealing end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showHealing = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showHealing,
            },
            {
                -- Healing Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.healing end,
                setFunc = function(v) LUIE.CombatText.SV.formats.healing = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.healing,
            },
            {
                -- Healing Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_CRITICAL_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.healingcritical end,
                setFunc = function(v) LUIE.CombatText.SV.formats.healingcritical = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.healingcritical,
            },
            {
                -- Healing Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HEALING_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.healing end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.healing = size end,
                default = LUIE.CombatText.D.fontSizes.healing,
            },
            {
                -- Healing Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HEALING_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.healingcritical end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.healingcritical = size end,
                default = LUIE.CombatText.D.fontSizes.healingcritical,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                width = "full",
            },
            {
                -- Healing over Time (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HOT_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showHot end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showHot = v end,
                default = LUIE.CombatText.D.toggles.incoming.showHot,
            },
            {
                -- Healing over Time (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HOT_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showHot end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showHot = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showHot,
            },
            {
                -- Healing over Time Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.hot end,
                setFunc = function(v) LUIE.CombatText.SV.formats.hot = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.hot,
            },
            {
                -- Healing over Time Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_CRITICAL_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.hotcritical end,
                setFunc = function(v) LUIE.CombatText.SV.formats.hotcritical = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.hotcritical,
            },
            {
                -- Healing over Time Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HOT_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.hot end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.hot = size end,
                default = LUIE.CombatText.D.fontSizes.hot,
            },
            {
                -- Healing over Time Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HOT_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.hotcritical end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.hotcritical = size end,
                default = LUIE.CombatText.D.fontSizes.hotcritical,
            },
            {
                -- Healing Color Options
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_HEALING_COLOR),
                width = "full",
            },
            {
                -- Healing
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.healing) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.healing = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.healing[1], g=LUIE.CombatText.D.colors.healing[2], b=LUIE.CombatText.D.colors.healing[3]}
            },
            {
                -- Checkbox Critical Healing Override
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.criticalHealingOverride end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.criticalHealingOverride = v end,
                default = LUIE.CombatText.D.toggles.criticalHealingOverride
            },
            {
                -- Color Critical Healing Override
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.criticalHealingOverride) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.criticalHealingOverride = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.criticalHealingOverride[1], g=LUIE.CombatText.D.colors.criticalHealingOverride[2], b=LUIE.CombatText.D.colors.criticalHealingOverride[3]}
            },
        },
    }

    -- Combat Text - Resource Gain & Drain Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_RESOURCE_GAIN_DRAIN), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Gain Loss Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_GAIN_LOSS_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.gainLoss end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.gainLoss = size end,
                default = LUIE.CombatText.D.fontSizes.gainLoss,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                width = "full",
            },
            {
                -- Resource Gain (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showEnergize end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showEnergize = v end,
                default = LUIE.CombatText.D.toggles.incoming.showEnergize,
            },
            {
                -- Resource Gain (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showEnergize end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showEnergize = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showEnergize,
            },
            {
                -- Resource Gain Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.energize end,
                setFunc = function(v) LUIE.CombatText.SV.formats.energize = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.energize,
            },
            {
                -- Gain Magicka Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_MAGICKA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_MAGICKA_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeMagicka) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeMagicka = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.energizeMagicka[1], g=LUIE.CombatText.D.colors.energizeMagicka[2], b=LUIE.CombatText.D.colors.energizeMagicka[3]}
            },
            {
                -- Gain Stamina Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_STAMINA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_STAMINA_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeStamina) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeStamina = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.energizeStamina[1], g=LUIE.CombatText.D.colors.energizeStamina[2], b=LUIE.CombatText.D.colors.energizeStamina[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                width = "full",
            },
            {
                -- Ultimate Gain (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showUltimateEnergize end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showUltimateEnergize = v end,
                default = LUIE.CombatText.D.toggles.incoming.showUltimateEnergize,
            },
            {
                -- Ultimate Gain (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showUltimateEnergize end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showUltimateEnergize = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showUltimateEnergize,
            },
            {
                -- Ultimate Gain Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.ultimateEnergize end,
                setFunc = function(v) LUIE.CombatText.SV.formats.ultimateEnergize = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.ultimateEnergize,
            },
            {
                -- Gain Ultimate Color
                type    = "colorpicker",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.energizeUltimate) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.energizeUltimate = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.energizeUltimate[1], g=LUIE.CombatText.D.colors.energizeUltimate[2], b=LUIE.CombatText.D.colors.energizeUltimate[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                width = "full",
            },
            {
                -- Resource Drain (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DRAIN), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DRAIN_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDrain end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDrain = v end,
                default = LUIE.CombatText.D.toggles.incoming.showDrain,
            },
            {
                -- Resource Drain (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DRAIN), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DRAIN_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDrain end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDrain = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showDrain,
            },
            {
                -- Resource Damage Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DRAIN_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.drain end,
                setFunc = function(v) LUIE.CombatText.SV.formats.drain = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.drain,
            },
            {
                -- Drain Magicka Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_MAGICKA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_MAGICKA_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.drainMagicka) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.drainMagicka = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.drainMagicka[1], g=LUIE.CombatText.D.colors.drainMagicka[2], b=LUIE.CombatText.D.colors.drainMagicka[3]}
            },
            {
                -- Drain Stamina Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_STAMINA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_STAMINA_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.drainStamina) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.drainStamina = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.drainStamina[1], g=LUIE.CombatText.D.colors.drainStamina[2], b=LUIE.CombatText.D.colors.drainStamina[3]}
            },
        },
    }

    -- Combat Text - Mitigation Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_MITIGATION), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Mitigation Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_MITIGATION_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.mitigation end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.mitigation = size end,
                default = LUIE.CombatText.D.fontSizes.mitigation,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_MISS),
                width = "full",
            },
            {
                -- Missed (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_MISS), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_MISS_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showMiss end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showMiss = v end,
                default = LUIE.CombatText.D.toggles.incoming.showMiss
            },
            {
                -- Missed (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_MISS), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_MISS_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showMiss end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showMiss = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showMiss,
            },
            {
                -- Missed (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_MISS_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.miss end,
                setFunc = function(v) LUIE.CombatText.SV.formats.miss = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.miss,
            },
            {
                -- Missed (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_MISS_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.miss) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.miss = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.miss[1], g=LUIE.CombatText.D.colors.miss[2], b=LUIE.CombatText.D.colors.miss[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                width = "full",
            },
            {
                -- Immune (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_IMMUNE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showImmune end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showImmune = v end,
                default = LUIE.CombatText.D.toggles.incoming.showImmune,
            },
            {
                -- Immune (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_IMMUNE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showImmune end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showImmune = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showImmune,
            },
            {
                -- Immune (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_IMMUNE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.immune end,
                setFunc = function(v) LUIE.CombatText.SV.formats.immune = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.immune,
            },
            {
                -- Immune (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_IMMUNE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.immune) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.immune = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.immune[1], g=LUIE.CombatText.D.colors.immune[2], b=LUIE.CombatText.D.colors.immune[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                width = "full",
            },
            {
                -- Parried (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_PARRIED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_PARRIED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showParried end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showParried = v end,
                default = LUIE.CombatText.D.toggles.incoming.showParried,
            },
            {
                -- Parried (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_PARRIED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_PARRIED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showParried end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showParried = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showParried,
            },
            {
                -- Parried (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_PARRIED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.parried end,
                setFunc = function(v) LUIE.CombatText.SV.formats.parried = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.parried,
            },
            {
                -- Parried (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_PARRIED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.parried) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.parried = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.parried[1], g=LUIE.CombatText.D.colors.parried[2], b=LUIE.CombatText.D.colors.parried[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                width = "full",
            },
            {
                -- Reflected (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_REFLECTED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showReflected end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showReflected = v end,
                default = LUIE.CombatText.D.toggles.incoming.showReflected,
            },
            {
                -- Reflected (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_REFLECTED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showReflected end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showReflected = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showReflected,
            },
            {
                -- Reflected (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_REFLECTED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.reflected end,
                setFunc = function(v) LUIE.CombatText.SV.formats.reflected = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.reflected,
            },
            {
                -- Reflected (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_REFLETCED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.reflected) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.reflected = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.reflected[1], g=LUIE.CombatText.D.colors.reflected[2], b=LUIE.CombatText.D.colors.reflected[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                width = "full",
            },
            {
                -- Damage Shielded (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_SHIELD_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDamageShield end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDamageShield = v end,
                default = LUIE.CombatText.D.toggles.incoming.showDamageShield,
            },
            {
                -- Damage Shielded (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_SHIELD_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDamageShield end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDamageShield = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showDamageShield,
            },
            {
                -- Damage Shielded (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_SHIELD_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.damageShield end,
                setFunc = function(v) LUIE.CombatText.SV.formats.damageShield = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.damageShield,
            },
            {
                -- Damage Shielded (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHIELD_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.damageShield) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.damageShield = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.damageShield[1], g=LUIE.CombatText.D.colors.damageShield[2], b=LUIE.CombatText.D.colors.damageShield[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                width = "full",
            },
            {
                -- Dodged (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DODGED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DODGED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDodged end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDodged = v end,
                default = LUIE.CombatText.D.toggles.incoming.showDodged,
            },
            {
                -- Dodged (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DODGED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DODGED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDodged end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDodged = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showDodged,
            },
            {
                -- Dodged (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DODGED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.dodged end,
                setFunc = function(v) LUIE.CombatText.SV.formats.dodged = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.dodged,
            },
            {
                -- Dodged (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DODGED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.dodged) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.dodged = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.dodged[1], g=LUIE.CombatText.D.colors.dodged[2], b=LUIE.CombatText.D.colors.dodged[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                width = "full",
            },
            {
                -- Blocked (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_BLOCKED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showBlocked end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showBlocked = v end,
                default = LUIE.CombatText.D.toggles.incoming.showBlocked,
            },
            {
                -- Blocked (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_BLOCKED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showBlocked end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showBlocked = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showBlocked,
            },
            {
                -- Blocked (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_BLOCKED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.blocked end,
                setFunc = function(v) LUIE.CombatText.SV.formats.blocked = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.blocked,
            },
            {
                -- Blocked (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_BLOCKED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.blocked) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.blocked = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.blocked[1], g=LUIE.CombatText.D.colors.blocked[2], b=LUIE.CombatText.D.colors.blocked[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                width = "full",
            },
            {
                -- Interrupted (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_INTERRUPTED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showInterrupted end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showInterrupted = v end,
                default = LUIE.CombatText.D.toggles.incoming.showInterrupted,
            },
            {
                -- Interrupted (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_INTERRUPTED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showInterrupted end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showInterrupted = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showInterrupted,
            },
            {
                -- Interrupted (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_INTERRUPTED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.interrupted end,
                setFunc = function(v) LUIE.CombatText.SV.formats.interrupted = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.interrupted,
            },
            {
                -- Interrupted (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INTERRUPTED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.interrupted) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.interrupted = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.interrupted[1], g=LUIE.CombatText.D.colors.interrupted[2], b=LUIE.CombatText.D.colors.interrupted[3]}
            },
        },
    }

    -- Combat Text - Crowd Control Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_CROWD_CONTROL), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Crowd Control Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_CROWD_CONTROL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.crowdControl end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.crowdControl = size end,
                default = LUIE.CombatText.D.fontSizes.crowdControl,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED),
                width = "full",
            },
            {
                -- Disoriented (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DISORIENTED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showDisoriented end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showDisoriented = v end,
                default = LUIE.CombatText.D.toggles.incoming.showDisoriented,
            },
            {
                -- Disoriented (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DISORIENTED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showDisoriented end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showDisoriented = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showDisoriented,
            },
            {
                -- Disoriented (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DISORIENTED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.disoriented end,
                setFunc = function(v) LUIE.CombatText.SV.formats.disoriented = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.disoriented,
            },
            {
                -- Disoriented (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DISORIENTED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.disoriented) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.disoriented = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.disoriented[1], g=LUIE.CombatText.D.colors.disoriented[2], b=LUIE.CombatText.D.colors.disoriented[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                width = "full",
            },
            {
                -- Feared (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_FEARED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_FEARED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showFeared end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showFeared = v end,
                default = LUIE.CombatText.D.toggles.incoming.showFeared,
            },
            {
                -- Feared (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_FEARED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_FEARED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showFeared end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showFeared = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showFeared,
            },
            {
                -- Feared (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_FEARED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.feared end,
                setFunc = function(v) LUIE.CombatText.SV.formats.feared = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.feared,
            },
            {
                -- Feared (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_FEARED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.feared) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.feared = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.feared[1], g=LUIE.CombatText.D.colors.feared[2], b=LUIE.CombatText.D.colors.feared[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                width = "full",
            },
            {
                -- Off-Balance (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_OFF_BALANCE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showOffBalanced end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showOffBalanced = v end,
                default = LUIE.CombatText.D.toggles.incoming.showOffBalanced,
            },
            {
                -- Off-Balance (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_OFF_BALANCE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showOffBalanced end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showOffBalanced = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showOffBalanced,
            },
            {
                -- Off-Balanced (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_OFF_BALANCE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.offBalanced end,
                setFunc = function(v) LUIE.CombatText.SV.formats.offBalanced = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.offBalanced,
            },
            {
                -- Off-Balanced (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_OFF_BALANCE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.offBalanced) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.offBalanced = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.offBalanced[1], g=LUIE.CombatText.D.colors.offBalanced[2], b=LUIE.CombatText.D.colors.offBalanced[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                width = "full",
            },
            {
                -- Silenced (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_SILENCED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_SILENCED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showSilenced end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showSilenced = v end,
                default = LUIE.CombatText.D.toggles.incoming.showSilenced,
            },
            {
                -- Silenced (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_SILENCED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_SILENCED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showSilenced end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showSilenced = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showSilenced,
            },
            {
                -- Silenced (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_SILENCED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.silenced end,
                setFunc = function(v) LUIE.CombatText.SV.formats.silenced = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.silenced,
            },
            {
                -- Silenced (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_SILENCED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.silenced) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.silenced = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.silenced[1], g=LUIE.CombatText.D.colors.silenced[2], b=LUIE.CombatText.D.colors.silenced[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                width = "full",
            },
            {
                -- Stunned (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_STUNNED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_STUNNED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.incoming.showStunned end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.incoming.showStunned = v end,
                default = LUIE.CombatText.D.toggles.incoming.showStunned,
            },
            {
                -- Stunned (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_STUNNED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_STUNNED_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.outgoing.showStunned end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.outgoing.showStunned = v end,
                default = LUIE.CombatText.D.toggles.outgoing.showStunned,
            },
            {
                -- Stunned (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_STUNNED_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.stunned end,
                setFunc = function(v) LUIE.CombatText.SV.formats.stunned = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.stunned,
            },
            {
                -- Stunned (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_STUNNED_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.stunned) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.stunned = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.stunned[1], g=LUIE.CombatText.D.colors.stunned[2], b=LUIE.CombatText.D.colors.stunned[3]}
            },

        },
    }

    -- Combat Text -- Notification Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_NOTIFICATION), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_STATE),
                width = "full",
            },
            {
                -- In Combat
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_IN_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showInCombat end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showInCombat = v end,
                default = LUIE.CombatText.D.toggles.showInCombat,
            },
            {
                -- Out of Combat
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_OUT_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showOutCombat end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showOutCombat = v end,
                default = LUIE.CombatText.D.toggles.showOutCombat,
            },
            {
                -- In Combat
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)",GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_COMBAT_IN_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.inCombat end,
                setFunc = function(v) LUIE.CombatText.SV.formats.inCombat = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.inCombat,
            },
            {
                -- Out Combat
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)",GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_COMBAT_OUT_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.outCombat end,
                setFunc = function(v) LUIE.CombatText.SV.formats.outCombat = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.outCombat,
            },
            {
                -- Combat State Font Size
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_COMBAT_STATE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.combatState end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.combatState = size end,
                default = LUIE.CombatText.D.fontSizes.combatState,
            },
            {
                -- In Combat
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_IN_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.inCombat) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.inCombat = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.inCombat[1], g=LUIE.CombatText.D.colors.inCombat[2], b=LUIE.CombatText.D.colors.inCombat[3]}
            },
            {
                -- Out Combat
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_OUT_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.outCombat) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.outCombat = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.outCombat[1], g=LUIE.CombatText.D.colors.outCombat[2], b=LUIE.CombatText.D.colors.outCombat[3]}
            },
            {
                type = "header",
                name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE), GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POINT_HEADER)),
                width = "full",
            },
            {
                -- Points Font Size
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_POINTS_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.point end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.point = size end,
                default = LUIE.CombatText.D.fontSizes.point,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_ALLIANCE),
                width = "full",
            },
            {
                -- Alliance Points
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POINTS_ALLIANCE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_ALLIANCE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showPointsAlliance end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsAlliance = v end,
                default = LUIE.CombatText.D.toggles.showPointsAlliance,
            },
            {
                -- Alliance Points
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_ALLIANCE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.pointsAlliance end,
                setFunc = function(v) LUIE.CombatText.SV.formats.pointsAlliance = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.pointsAlliance,
            },
            {
                -- Alliance Points Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ALLIANCE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsAlliance) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsAlliance = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.pointsAlliance[1], g=LUIE.CombatText.D.colors.pointsAlliance[2], b=LUIE.CombatText.D.colors.pointsAlliance[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                width = "full",
            },
            {
                -- Experience Points
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_EXPERIENCE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showPointsExperience end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsExperience = v end,
                default = LUIE.CombatText.D.toggles.showPointsExperience,
            },
            {
                -- Experience Points
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPERIENCE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.pointsExperience end,
                setFunc = function(v) LUIE.CombatText.SV.formats.pointsExperience = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.pointsExperience,
            },
            {
                -- Experience Points Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPERIENCE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsExperience) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsExperience = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.pointsExperience[1], g=LUIE.CombatText.D.colors.pointsExperience[2], b=LUIE.CombatText.D.colors.pointsExperience[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                width = "full",
            },
            {
                -- Champion Points
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_CHAMPION_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showPointsChampion end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showPointsChampion = v end,
                default = LUIE.CombatText.D.toggles.showPointsChampion,
            },
            {
                -- Champion Points
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_CHAMPION_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.pointsChampion end,
                setFunc = function(v) LUIE.CombatText.SV.formats.pointsChampion = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.pointsChampion,
            },
            {
                -- Champion Points Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CHAMPION_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.pointsChampion) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.pointsChampion = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.pointsChampion[1], g=LUIE.CombatText.D.colors.pointsChampion[2], b=LUIE.CombatText.D.colors.pointsChampion[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_AND_POTION_READY),
                width = "full",
            },
            {
                -- Font Size Ready
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_RESOURCE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.readylabel end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.readylabel = size end,
                default = LUIE.CombatText.D.fontSizes.readylabel,
            },
            {
                -- Ultimate Ready Enable
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ULTIMATE_READY_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showUltimate end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showUltimate = v end,
                default = LUIE.CombatText.D.toggles.showUltimate,
            },
            {
                -- Potion Ready Enable
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POTION_READY_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showPotionReady end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showPotionReady = v end,
                default = LUIE.CombatText.D.toggles.showPotionReady,
            },
            {
                -- Ultimate Ready Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_ULTIMATE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.ultimateReady end,
                setFunc = function(v) LUIE.CombatText.SV.formats.ultimateReady = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.ultimateReady,
            },
            {
                -- Potion Ready Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POTION_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.potionReady end,
                setFunc = function(v) LUIE.CombatText.SV.formats.potionReady = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.potionReady,
            },
            {
                -- Ultimate Ready Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ULTIMATE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.ultimateReady) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.ultimateReady = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.ultimateReady[1], g=LUIE.CombatText.D.colors.ultimateReady[2], b=LUIE.CombatText.D.colors.ultimateReady[3]}
            },
            {
                -- Potion Ready Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POTION_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.potionReady) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.potionReady = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.potionReady[1], g=LUIE.CombatText.D.colors.potionReady[2], b=LUIE.CombatText.D.colors.potionReady[3]}
            },
        },
    }

    -- Combat Text - Low Resource Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_LOW_RESOURCE), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_RESOURCE_OPTIONS),
                width = "full",
            },
            {
                -- Low Resource Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_RESOURCE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.resource end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.resource = size end,
                default = LUIE.CombatText.D.fontSizes.resource,
            },
            {
                -- Low Resource Warning Sound
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.warningSound end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.warningSound = v end,
                disabled = function() return not (LUIE.CombatText.SV.toggles.showLowHealth or LUIE.CombatText.SV.toggles.showLowMagicka or LUIE.CombatText.SV.toggles.showLowStamina) end,
                default = LUIE.CombatText.D.toggles.warningSound,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_LOW_HEALTH),
                width = "full",
            },
            {
                -- Low Health
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_LOW_HEALTH)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_HEALTH_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showLowHealth end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showLowHealth = v end,
                default = LUIE.CombatText.D.toggles.showLowHealth,
            },
            {
                -- Low Health Warning Threshold Slider
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
            {
                -- Low Health Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_RESOURCE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.resourceHealth end,
                setFunc = function(v) LUIE.CombatText.SV.formats.resourceHealth = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.resourceHealth,
            },
            {
                -- Low Health Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_HEALTH_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowHealth) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowHealth = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.lowHealth[1], g=LUIE.CombatText.D.colors.lowHealth[2], b=LUIE.CombatText.D.colors.lowHealth[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA),
                width = "full",
            },
            {
                -- Low Magicka
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_MAGICKA_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showLowMagicka end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showLowMagicka = v end,
                default = LUIE.CombatText.D.toggles.showLowMagicka,
            },
            {
                -- Low Magicka Warning Threshold Slider
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
            {
                -- Low Magicka Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_RESOURCE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.resourceMagicka end,
                setFunc = function(v) LUIE.CombatText.SV.formats.resourceMagicka = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.resourceMagicka,
            },
            {
                -- Low Magicka Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_MAGICKA_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowMagicka) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowMagicka = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.lowMagicka[1], g=LUIE.CombatText.D.colors.lowMagicka[2], b=LUIE.CombatText.D.colors.lowMagicka[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA),
                width = "full",
            },
            {
                -- Low Stamina
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_STAMINA_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showLowStamina end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showLowStamina = v end,
                default = LUIE.CombatText.D.toggles.showLowStamina,
            },
            {
                -- Low Stamina Warning Threshold Slider
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
            {
                -- Low Stamina Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_RESOURCE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.resourceStamina end,
                setFunc = function(v) LUIE.CombatText.SV.formats.resourceStamina = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.resourceStamina,
            },
            {
                -- Low Stamina Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_STAMINA_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.lowStamina) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.lowStamina = { r, g, b, a } end,
                default = {r=LUIE.CombatText.D.colors.lowStamina[1], g=LUIE.CombatText.D.colors.lowStamina[2], b=LUIE.CombatText.D.colors.lowStamina[3]}
            },


        },
    }

    -- Combat Text - Active Combat Alerts
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_ACTIVE_COMBAT_ALERT), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {

            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERTS_DESC),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Alerts Font
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_ALERT_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return LUIE.CombatText.SV.fontSizes.alert end,
                setFunc = function(size) LUIE.CombatText.SV.fontSizes.alert = size end,
                default = LUIE.CombatText.D.fontSizes.alert,
            },

            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE),
                width = "full",
            },
            {
                -- Cleanse Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_CLEANSE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertCleanse end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertCleanse = v end,
                default = LUIE.CombatText.D.toggles.showAlertCleanse,
            },
            {
                -- Cleanse Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_CLEANSE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertCleanse end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertCleanse = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertCleanse,
            },
            {
                -- Cleanse Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CLEANSE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertCleanse) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertCleanse = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertCleanse[1], g=LUIE.CombatText.D.colors.alertCleanse[2], b=LUIE.CombatText.D.colors.alertCleanse[3]}
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
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertExploit end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertExploit = v end,
                default = LUIE.CombatText.D.toggles.showAlertExploit,
            },
            {
                -- Exploit  Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPLOIT_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertExploit end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertExploit = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertExploit,
            },
            {
                -- Exploit Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPLOIT_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertExploit) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertExploit = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertExploit[1], g=LUIE.CombatText.D.colors.alertExploit[2], b=LUIE.CombatText.D.colors.alertExploit[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                width = "full",
            },
            {
                -- Execute Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXECUTE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertExecute end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertExecute = v end,
                default = LUIE.CombatText.D.toggles.showAlertExecute,
            },
            {
                -- Execute Threshold Slider
                type    = "slider",
                width   = "half",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD_TP),
                min     = 10,
                max     = 50,
                getFunc = function() return LUIE.CombatText.SV.executeThreshold end,
                setFunc = function(v) LUIE.CombatText.SV.executeThreshold = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertExecute end,
                default = LUIE.CombatText.D.executeThreshold,
            },
            {
                -- Execute Frequency Slider
                type    = "slider",
                width   = "half",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY_TP),
                min     = 1,
                max     = 20,
                getFunc = function() return LUIE.CombatText.SV.executeFrequency end,
                setFunc = function(v) LUIE.CombatText.SV.executeFrequency = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertExecute end,
                default = LUIE.CombatText.D.executeFrequency,
            },
            {
                -- Execute Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXECUTE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertExecute end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertExecute = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertExecute,
            },
            {
                -- Execute Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXECUTE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertExecute) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertExecute = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertExecute[1], g=LUIE.CombatText.D.colors.alertExecute[2], b=LUIE.CombatText.D.colors.alertExecute[3]}
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
                getFunc = function() return LUIE.CombatText.SV.toggles.hideIngameTips end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.hideIngameTips = v; ZO_ActiveCombatTips:SetHidden(v) end,
                default = LUIE.CombatText.D.toggles.hideIngameTips,
            },
            {
                -- Mitigation Alerts
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertMitigation end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertMitigation = v end,
                default = LUIE.CombatText.D.toggles.showAlertMitigation,
            },
            {
                -- Mitigation Method
                type    = "dropdown",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD_TP),
                choices = LUIE.CombatTextConstants.mitigationType,
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationType end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationType = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationType,
            },
            {
                -- Hide Mitigation Grouped Alerts
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_HIDE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_HIDE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.hideMitigation end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.hideMitigation = v end,
                disabled = function() return not (LUIE.CombatText.SV.toggles.showAlertMitigation and LUIE.CombatText.SV.toggles.mitigationType == "Single Line") end,
                default = LUIE.CombatText.D.toggles.hideMitigation,
            },
            {
                -- Mitigation Prefix (No Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationPrefix end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationPrefix = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationPrefix,
            },
            {
                -- Mitigation Prefix (Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationPrefixN end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationPrefixN = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationPrefixN,
            },
            {
                -- Mitigation Suffix
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationDefaultSuffix end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationDefaultSuffix = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationDefaultSuffix,
            },
            {
                -- Mitigation Aura
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationAura end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationAura = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationAura,
            },
            {
                -- Mitigation Rank 3
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank3 end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank3 = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationRank3,
            },
            {
                -- Mitigation Rank 2
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank2 end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank2 = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationRank2,
            },
            {
                -- Mitigation Rank 1
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationRank1 end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationRank1 = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationRank1,
            },
            {
                -- Mitigation Dungeon
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationDungeon end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationDungeon = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.mitigationDungeon,
            },
            {
                -- Shared Label Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertShared) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertShared = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertShared[1], g=LUIE.CombatText.D.colors.alertShared[2], b=LUIE.CombatText.D.colors.alertShared[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK),
                width = "full",
            },
            {
                -- Block Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_BLOCK_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertBlock end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertBlock = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.showAlertBlock,
            },
            {
                -- Block Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertBlock end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertBlock = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertBlock,
            },
            {
                -- Block Stagger Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK_S)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_S_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertBlockStagger end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertBlockStagger = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertBlockStagger,
            },
            {
                -- Block Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BLOCK_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertBlock) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertBlock = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertBlock[1], g=LUIE.CombatText.D.colors.alertBlock[2], b=LUIE.CombatText.D.colors.alertBlock[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE),
                width = "full",
            },
            {
                -- Dodge Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_DODGE_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertDodge end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertDodge = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.showAlertDodge,
            },
            {
                -- Dodge  Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DODGE_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertDodge end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertDodge = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertDodge,
            },
            {
                -- Dodge Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DODGE_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertDodge) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertDodge = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertDodge[1], g=LUIE.CombatText.D.colors.alertDodge[2], b=LUIE.CombatText.D.colors.alertDodge[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID),
                width = "full",
            },
            {
                -- Avoid Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_AVOID_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertAvoid end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertAvoid = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.showAlertAvoid,
            },
            {
                -- Avoid Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_AVOID_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertAvoid end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertAvoid = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertAvoid,
            },
            {
                -- Avoid Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_AVOID_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertAvoid) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertAvoid = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertAvoid[1], g=LUIE.CombatText.D.colors.alertAvoid[2], b=LUIE.CombatText.D.colors.alertAvoid[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT),
                width = "full",
            },
            {
                -- Interrupt Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_INTERRUPT_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertInterrupt end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertInterrupt = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.showAlertInterrupt,
            },
            {
                -- Interrupt Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_INTERRUPT_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertInterrupt end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertInterrupt = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertInterrupt,
            },
            {
                -- Interrupt Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_INTERRUPT_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertInterrupt) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertInterrupt = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertInterrupt[1], g=LUIE.CombatText.D.colors.alertInterrupt[2], b=LUIE.CombatText.D.colors.alertInterrupt[3]}
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
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertPower end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertPower = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.showAlertPower,
            },
            {
                -- Power Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POWER_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertPower end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertPower = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertPower,
            },
            {
                -- Prefix Power (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationPowerPrefix end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationPowerPrefix = v end,
                disabled = function() return not (LUIE.CombatText.SV.toggles.showAlertMitigation and LUIE.CombatText.SV.toggles.showAlertPower) end,
                default = LUIE.CombatText.D.toggles.mitigationPowerPrefix,
            },
            {
                -- Prefix Power (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationPowerPrefixN end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationPowerPrefixN = v end,
                disabled = function() return not (LUIE.CombatText.SV.toggles.showAlertMitigation and LUIE.CombatText.SV.toggles.showAlertPower) end,
                default = LUIE.CombatText.D.toggles.mitigationPowerPrefixN,
            },
            {
                -- Power Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POWER_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertPower) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertPower = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertPower[1], g=LUIE.CombatText.D.colors.alertPower[2], b=LUIE.CombatText.D.colors.alertPower[3]}
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
                getFunc = function() return LUIE.CombatText.SV.toggles.showAlertDestroy end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showAlertDestroy = v end,
                disabled = function() return not LUIE.CombatText.SV.toggles.showAlertMitigation end,
                default = LUIE.CombatText.D.toggles.showAlertDestroy,
            },
            {
                -- Destroy Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DESTROY_TP),
                getFunc = function() return LUIE.CombatText.SV.formats.alertDestroy end,
                setFunc = function(v) LUIE.CombatText.SV.formats.alertDestroy = v end,
                isMultiline = false,
                default = LUIE.CombatText.D.formats.alertDestroy,
            },
            {
                -- Prefix Destroy (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationDestroyPrefix end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationDestroyPrefix = v end,
                disabled = function() return not (LUIE.CombatText.SV.toggles.showAlertMitigation and LUIE.CombatText.SV.toggles.showAlertDestroy) end,
                default = LUIE.CombatText.D.toggles.mitigationDestroyPrefix,
            },
            {
                -- Prefix Destroy (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return LUIE.CombatText.SV.toggles.mitigationDestroyPrefixN end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.mitigationDestroyPrefixN = v end,
                disabled = function() return not (LUIE.CombatText.SV.toggles.showAlertMitigation and LUIE.CombatText.SV.toggles.showAlertDestroy) end,
                default = LUIE.CombatText.D.toggles.mitigationDestroyPrefixN,
            },
            {
                -- Destroy Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DESTROY_TP),
                getFunc = function() return unpack(LUIE.CombatText.SV.colors.alertDestroy) end,
                setFunc = function(r, g, b, a) LUIE.CombatText.SV.colors.alertDestroy = { r, g, b, a } LUIE.CombatText.SetAlertColors() end,
                default = {r=LUIE.CombatText.D.colors.alertDestroy[1], g=LUIE.CombatText.D.colors.alertDestroy[2], b=LUIE.CombatText.D.colors.alertDestroy[3]}
            },

        },
    }



    -- Combat Text - Font Format Options Submenu
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_FONT_HEADER),
        controls = {
            {
                -- Font Face Dropdown
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
            {
                -- Font Outline Dropdown
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
            {
                -- Test Font Button
                type = "button",
                name    = GetString(SI_LUIE_LAM_CT_FONT_TEST),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_TEST_TP),
                func = function()
                    CALLBACK_MANAGER:FireCallbacks(LUIE.CombatTextConstants.eventType.COMBAT, LUIE.CombatTextConstants.combatType.INCOMING, POWERTYPE_STAMINA, mathrandom(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                end,
            },
        },
    }

    -- Combat Text - Animation Options Submenu
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_ANIMATION_HEADER),
        controls = {
            {
                -- Animation Type
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_TYPE),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_TYPE_TP),
                choices = LUIE.CombatTextConstants.animationType,
                getFunc = function() return LUIE.CombatText.SV.animation.animationType end,
                setFunc = function(v) LUIE.CombatText.SV.animation.animationType = v end,
                default = LUIE.CombatText.D.animation.animationType,
            },
            {
                -- Incoming Direction
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN_TP),
                choices = LUIE.CombatTextConstants.directionType,
                getFunc = function() return LUIE.CombatText.SV.animation.incoming.directionType end,
                setFunc = function(v) LUIE.CombatText.SV.animation.incoming.directionType = v end,
                default = LUIE.CombatText.D.animation.incoming.directionType,
            },
            {
                -- Incoming Icon Position
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN_TP),
                choices = LUIE.CombatTextConstants.iconSide,
                getFunc = function() return LUIE.CombatText.SV.animation.incomingIcon end,
                setFunc = function(v) LUIE.CombatText.SV.animation.incomingIcon = v end,
                default = LUIE.CombatText.D.animation.incomingIcon,
            },
            {
                -- Outgoing Direction
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT_TP),
                choices = LUIE.CombatTextConstants.directionType,
                getFunc = function() return LUIE.CombatText.SV.animation.outgoing.directionType end,
                setFunc = function(v) LUIE.CombatText.SV.animation.outgoing.directionType = v end,
                default = LUIE.CombatText.D.animation.outgoing.directionType,
            },
            {
                -- Outgoing Icon Position
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT_TP),
                choices = LUIE.CombatTextConstants.iconSide,
                getFunc = function() return LUIE.CombatText.SV.animation.outgoingIcon end,
                setFunc = function(v) LUIE.CombatText.SV.animation.outgoingIcon = v end,
                default = LUIE.CombatText.D.animation.outgoingIcon,
            },
            {
                -- Test Button
                type = "button",
                name = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST_TP),
                func = function()
                    CALLBACK_MANAGER:FireCallbacks(LUIE.CombatTextConstants.eventType.COMBAT, LUIE.CombatTextConstants.combatType.INCOMING, POWERTYPE_STAMINA, mathrandom(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                    CALLBACK_MANAGER:FireCallbacks(LUIE.CombatTextConstants.eventType.COMBAT, LUIE.CombatTextConstants.combatType.OUTGOING, POWERTYPE_STAMINA, mathrandom(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                end,
            },
        },
    }

    -- Combat Text - Throttle Options (Combat) Options Submenu
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_THROTTLE_HEADER),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_THROTTLE_DESCRIPTION),
            },
            {
                -- Damage
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
            {
                -- Damage over Time
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
            {
                -- Healing
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
            {
                -- Healing over Time
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
            {
                -- Throttle Trailer
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER),
                tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER_TP),
                getFunc = function() return LUIE.CombatText.SV.toggles.showThrottleTrailer end,
                setFunc = function(v) LUIE.CombatText.SV.toggles.showThrottleTrailer = v end,
                default = LUIE.CombatText.D.toggles.showThrottleTrailer,
            },
            {
                -- Crits
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

    if LUIE.SV.SlashCommands_Enable then
        LAM2:RegisterAddonPanel('LUIESlashCommandsOptions', panelDataSlashCommands)
        LAM2:RegisterOptionControls('LUIESlashCommandsOptions', optionsDataSlashCommands)
    end

    if LUIE.SV.InfoPanel_Enabled then
        LAM2:RegisterAddonPanel('LUIEInfoPanelOptions', panelDataInfoPanel)
        LAM2:RegisterOptionControls('LUIEInfoPanelOptions', optionsDataInfoPanel)
    end
end
