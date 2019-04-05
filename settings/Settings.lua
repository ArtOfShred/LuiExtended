--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local strformat = zo_strformat

-- Create Settings Menu
function LUIE.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibStub("LibAddonMenu-2.0")

    local optionsData = {}

    local profileCharacters = {} -- List of character profiles
    local profileQueuedCopy = nil -- Currently queued character copy name for copy button

    -- Generate list of character profiles for Menu function
    local function GenerateCharacterProfiles()
        local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV -- Pull info from SV for account wide
        local playerName = GetUnitName('player')
        local version = LUIE.version

        for accountName, data in pairs(LUIESV.Default) do
            for profile, vars in pairs(data) do
                if profile == '$AccountWide' then profile = '$AccountWide (' .. accountName .. ')' end -- Add display name onto Account Wide for differentiation
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

    -- Copies data either to override character's data or creates a new table if no data for that character exists.
    -- Borrowed from Srendarr
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
            deleteProfile = '$AccountWide (' .. GetDisplayName() .. ')'
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
                if profileQueuedCopy == '$AccountWide (' .. accountName .. ')' then profileQueuedCopy = '$AccountWide' end -- When the account name matches the one we're iterating through, copy that value
                if profile == profileQueuedCopy then
                    sourceCharacter = vars
                end
                if profile == copyTarget then
                    targetCharacter = vars
                end
            end
        end

        if not sourceCharacter or not targetCharacter then
            d("LUIE - Unable to copy Character Profile Data.") -- TODO: localization
            return
        else
            CopyTable(sourceCharacter, targetCharacter)
            ReloadUI()
        end
    end

    GenerateCharacterProfiles()

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

    -- Changelog Button
    optionsData[#optionsData + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_CHANGELOG),
        tooltip = GetString(SI_LUIE_LAM_CHANGELOG_TP),
        func = function() LUIE.ToggleChangelog(false) SCENE_MANAGER:ShowBaseScene() end,
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

    LAM:RegisterAddonPanel('LUIEAddonOptions', panelData)
    LAM:RegisterOptionControls('LUIEAddonOptions', optionsData)
end
