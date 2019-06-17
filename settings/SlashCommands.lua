--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SlashCommands = LUIE.SlashCommands

local zo_strformat = zo_strformat

local bankerOptions     = { "Tythis", "Cat Planet Banker" }
local bankerOptionsKeys = { ["Tythis"] = 1, ["Cat Planet Banker"] = 2 }
local merchantOptions   = { "Nuzimeh", "Cat Planet Merchant" }
local merchantOptionsKeys   = { ["Nuzimeh"] = 1, ["Cat Planet Merchant"] = 2 }

-- Create Slash Commands Settings Menu
function SlashCommands.CreateSettings()
    -- Load LibAddonMenu
    local LAM = _G["LibAddonMenu2"]
    if LAM == nil then return end

    local Defaults = SlashCommands.Defaults
    local Settings = SlashCommands.SV

    local panelDataSlashCommands = {
        type = "panel",
        name = zo_strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_SLASHCMDS)),
        displayName = zo_strformat("<<1>> <<2>>", LUIE.name, GetString(SI_LUIE_LAM_SLASHCMDS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
        slashCommand = "/luisc",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    local optionsDataSlashCommands = {}

    -- Slash Commands description
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
                getFunc = function() return Settings.SlashTrade end,
                setFunc = function(value) Settings.SlashTrade = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashTrade,
            },
            {
                -- SlashHome
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_HOME),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_HOME_TP),
                getFunc = function() return Settings.SlashHome end,
                setFunc = function(value) Settings.SlashHome = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashHome,
            },
            {
                -- SlashCampaignQ
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_CAMPAIGN),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_CAMPAIGN_TP),
                getFunc = function() return Settings.SlashCampaignQ end,
                setFunc = function(value) Settings.SlashCampaignQ = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashCampaignQ,
            },
            {
                -- SlashBanker
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_BANKER),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_SLASHCMDS_BANKER_TP), GetCollectibleName(267)),
                getFunc = function() return Settings.SlashBanker end,
                setFunc = function(value) Settings.SlashBanker = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashBanker,
            },
            {
                -- Choose Banker
                type = "dropdown",
                name = "\t\t\t\t\tChoose Banker to Summon",
                choices = bankerOptions,
                getFunc = function() return bankerOptions[Settings.SlashBankerChoice] end,
                setFunc = function(value) Settings.SlashBankerChoice = bankerOptionsKeys[value] end,
                width = "full",
                default = Defaults.SlashBankerChoice,
                disabled = function() return not Defaults.SlashBanker end,

            },
            {
                -- SlashMerchant
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_MERCHANT),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_SLASHCMDS_MERCHANT_TP), GetCollectibleName(301)),
                getFunc = function() return Settings.SlashMerchant end,
                setFunc = function(value) Settings.SlashMerchant = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashMerchant,
            },
            {
                -- Choose Merchant
                type = "dropdown",
                name = "\t\t\t\t\tChoose Merchant to Summon",
                choices = merchantOptions,
                getFunc = function() return merchantOptions[Settings.SlashMerchantChoice] end,
                setFunc = function(value) Settings.SlashMerchantChoice = merchantOptionsKeys[value] end,
                width = "full",
                default = Defaults.SlashMerchantChoice,
                disabled = function() return not Defaults.SlashMerchant end,

            },
            {
                -- SlashFence
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_FENCE),
                tooltip = zo_strformat(GetString(SI_LUIE_LAM_SLASHCMDS_FENCE_TP), GetCollectibleName(300)),
                getFunc = function() return Settings.SlashFence end,
                setFunc = function(value) Settings.SlashFence = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashFence,
            },
            {
                -- SlashOutfit
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_OUTFIT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_OUTFIT_TP),
                getFunc = function() return Settings.SlashOutfit end,
                setFunc = function(value) Settings.SlashOutfit = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashOutfit,
            },
            {
                -- SlashReport
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REPORT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REPORT_TP),
                getFunc = function() return Settings.SlashReport end,
                setFunc = function(value) Settings.SlashReport = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashReport,
            },
            {
                -- TODO
                type = "checkbox",
                name = "/Home Results - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /home command is used.\nNote: This setting will be deprecated in the future when Social Errors Events are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertHome end,
                setFunc = function(value) LUIE.SV.TempAlertHome = value end,
                width = "full",
                default = LUIE.Defaults.TempAlertHome,
            },
            {
                -- TODO
                type = "checkbox",
                name = "/Campaign Results - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /campaign command is used.\nNote: This setting will be deprecated in the future when Campaign Queue Events are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertCampaign end,
                setFunc = function(value) LUIE.SV.TempAlertCampaign = value end,
                width = "full",
                default = LUIE.Defaults.TempAlertCampaign,
            },
            {
                -- TODO
                type = "checkbox",
                name = "/Outfit - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /outfit command is used.\nNote: This setting will be deprecated in the future when Outfit Alerts are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertOutfit end,
                setFunc = function(value) LUIE.SV.TempAlertOutfit = value end,
                width = "full",
                default = LUIE.Defaults.TempAlertOutfit,
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
                getFunc = function() return Settings.SlashReadyCheck end,
                setFunc = function(value) Settings.SlashReadyCheck = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashReadyCheck,
            },
            {
                -- SlashRegroup
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP_TP),
                getFunc = function() return Settings.SlashRegroup end,
                setFunc = function(value) Settings.SlashRegroup = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashRegroup,
            },
            {
                -- SlashDisband
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND_TP),
                getFunc = function() return Settings.SlashDisband end,
                setFunc = function(value) Settings.SlashDisband = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashDisband,
            },
            {
                -- SlashGroupLeave
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_LEAVE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_LEAVE_TP),
                getFunc = function() return Settings.SlashGroupLeave end,
                setFunc = function(value) Settings.SlashGroupLeave = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashGroupLeave,
            },
            {
                -- SlashGroupKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_KICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_KICK_TP),
                getFunc = function() return Settings.SlashGroupKick end,
                setFunc = function(value) Settings.SlashGroupKick = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashGroupKick,
            },
            {
                -- SlashVoteKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_VOTEKICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_VOTEKICK_TP),
                getFunc = function() return Settings.SlashVoteKick end,
                setFunc = function(value) Settings.SlashVoteKick = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashVoteKick,
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
                getFunc = function() return Settings.SlashGuildInvite end,
                setFunc = function(value) Settings.SlashGuildInvite = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashGuildInvite,
            },
            {
                -- SlashGuildQuit
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDQUIT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDQUIT_TP),
                getFunc = function() return Settings.SlashGuildQuit end,
                setFunc = function(value) Settings.SlashGuildQuit = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashGuildQuit,
            },
            {
                -- SlashGuildKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDKICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDKICK_TP),
                getFunc = function() return Settings.SlashGuildKick end,
                setFunc = function(value) Settings.SlashGuildKick = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashGuildKick,
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
                getFunc = function() return Settings.SlashFriend end,
                setFunc = function(value) Settings.SlashFriend = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashFriend,
            },
            {
                -- SlashIgnore
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_IGNORE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_IGNORE_TP),
                getFunc = function() return Settings.SlashIgnore end,
                setFunc = function(value) Settings.SlashIgnore = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashIgnore,
            },
            {
                -- SlashRemoveFriend
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND_TP),
                getFunc = function() return Settings.SlashRemoveFriend end,
                setFunc = function(value) Settings.SlashRemoveFriend = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashRemoveFriend,
            },
            {
                -- SlashRemoveIgnore
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE_TP),
                getFunc = function() return Settings.SlashRemoveIgnore end,
                setFunc = function(value) Settings.SlashRemoveIgnore = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashRemoveIgnore,
            },
        },
    }

    -- Slash Commands - Holiday XP Events Commands Options Submenu
    optionsDataSlashCommands[#optionsDataSlashCommands + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_SLASHCMDSHEADER_HOLIDAY),
        controls = {
            {
                -- SlashCake
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_CAKE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_CAKE_TP),
                getFunc = function() return Settings.SlashCake end,
                setFunc = function(value) Settings.SlashCake = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashCake,
            },
            {
                -- SlashPie
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_PIE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_PIE_TP),
                getFunc = function() return Settings.SlashPie end,
                setFunc = function(value) Settings.SlashPie = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashPie,
            },
            {
                -- SlashMead
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_MEAD),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_MEAD_TP),
                getFunc = function() return Settings.SlashMead end,
                setFunc = function(value) Settings.SlashMead = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashMead,
            },
            {
                -- SlashWitch
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_WITCH),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_WITCH_TP),
                getFunc = function() return Settings.SlashWitch end,
                setFunc = function(value) Settings.SlashWitch = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashWitch,
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.SlashCommands_Enable then
        LAM:RegisterAddonPanel(LUIE.name .. 'SlashCommandsOptions', panelDataSlashCommands)
        LAM:RegisterOptionControls(LUIE.name .. 'SlashCommandsOptions', optionsDataSlashCommands)
    end
end
