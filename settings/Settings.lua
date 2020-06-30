--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat
local g_ElementMovingEnabled

local alignmentOptions     = { "LEFT", "CENTER", "RIGHT" }
local alignmentOptionsKeys = { ["LEFT"] = 1, ["CENTER"] = 1, ["RIGHT"] = 3 }

-- Create Settings Menu
function LUIE.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibAddonMenu2
    if LAM == nil then return end

    local Defaults = LUIE.Defaults
    local Settings = LUIE.SV

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
        displayName = LUIE.name,
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
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

    -- Default UI Elements Position Unlock
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UNLOCK_DEFAULT_UI),
        tooltip = GetString(SI_LUIE_LAM_UNLOCK_DEFAULT_UI_TP),
        getFunc = function() return g_ElementMovingEnabled end,
        setFunc = function(value)
            g_ElementMovingEnabled = value
            LUIE.SetupElementMover(value)
            end,
        width = "half",
        default = false,
        resetFunc = LUIE.ResetElementPosition,
    }

    -- Default UI Elements Position Reset
    optionsData[#optionsData + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_RESET_DEFAULT_UI_TP),
        func = LUIE.ResetElementPosition,
        warning = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
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
        getFunc = function() return Settings.UnitFrames_Enabled end,
        setFunc = function(value) Settings.UnitFrames_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = Defaults.UnitFrames_Enabled,
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
        getFunc = function() return Settings.CombatInfo_Enabled end,
        setFunc = function(value) Settings.CombatInfo_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = Defaults.CombatInfo_Enabled,
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
        getFunc = function() return Settings.CombatText_Enabled end,
        setFunc = function(value) Settings.CombatText_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = Defaults.CombatText_Enabled,
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
        getFunc = function() return Settings.SpellCastBuff_Enable end,
        setFunc = function(value) Settings.SpellCastBuff_Enable = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = Defaults.SpellCastBuff_Enable,
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
        getFunc = function() return Settings.ChatAnnouncements_Enable end,
        setFunc = function(value) Settings.ChatAnnouncements_Enable = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = Defaults.ChatAnnouncements_Enable,
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
        getFunc = function() return Settings.SlashCommands_Enable end,
        setFunc = function(value) Settings.SlashCommands_Enable = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = Defaults.SlashCommands_Enable,
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
        getFunc = function() return Settings.InfoPanel_Enabled end,
        setFunc = function(value) Settings.InfoPanel_Enabled = value end,
        width = "half",
        warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
        default = Defaults.SlashCommands_Enable,
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

    --[[
    -- Alert Text Alignment
    optionsData[#optionsData + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_ALERT_TEXT_ALIGNMENT),
        tooltip = GetString(SI_LUIE_LAM_ALERT_TEXT_ALIGNMENT_TP),
        choices = alignmentOptions,
        getFunc = function() return alignmentOptions[Settings.AlertFrameAlignment] end,
        setFunc = function(value) Settings.AlertFrameAlignment = alignmentOptionsKeys[value] end,
        width = "full",
        default = Defaults.AlertFrameAlignment,
    }
    ]]--

    -- Hide Alerts
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_ALERT_HIDE_ALL),
        tooltip = GetString(SI_LUIE_LAM_ALERT_HIDE_ALL_TP),
        getFunc = function() return Settings.HideAlertFrame end,
        setFunc = function(value) Settings.HideAlertFrame = value LUIE.SetupAlertFrameVisibility() end,
        width = "full",
        default = Defaults.HideAlertFrame,
    }

    -- Toggle XP Bar popup
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_HIDE_EXPERIENCE_BAR),
        tooltip = GetString(SI_LUIE_LAM_HIDE_EXPERIENCE_BAR_TP),
        getFunc = function() return Settings.HideXPBar end,
        setFunc = function(value) Settings.HideXPBar = value end,
        width = "full",
        default = Defaults.HideXPBar,
    }

    -- Startup Message Options
    optionsData[#optionsData + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_STARTUPMSG),
        tooltip = GetString(SI_LUIE_LAM_STARTUPMSG_TP),
        getFunc = function() return Settings.StartupInfo end,
        setFunc = function(value) Settings.StartupInfo = value end,
        width = "full",
        default = Defaults.StartupInfo,
    }

    LAM:RegisterAddonPanel(LUIE.name .. 'AddonOptions', panelData)
    LAM:RegisterOptionControls(LUIE.name .. 'AddonOptions', optionsData)
end
