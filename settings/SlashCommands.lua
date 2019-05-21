--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SC = LUIE.SlashCommands

local strformat = zo_strformat

local optionsDataSlashCommands = {}

-- Create Slash Commands Settings Menu
function SC.CreateSettings()
    -- Load LibAddonMenu with backwards compatibility
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelDataSlashCommands = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_SLASHCMDS)),
        displayName = strformat("<<1>> <<2>>", LUIE.name, GetString(SI_LUIE_LAM_SLASHCMDS)),
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
                getFunc = function() return SC.SV.SlashTrade end,
                setFunc = function(value) SC.SV.SlashTrade = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashTrade,
            },
            {
                -- SlashHome
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_HOME),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_HOME_TP),
                getFunc = function() return SC.SV.SlashHome end,
                setFunc = function(value) SC.SV.SlashHome = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashHome,
            },
            {
                -- SlashCampaignQ
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_CAMPAIGN),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_CAMPAIGN_TP),
                getFunc = function() return SC.SV.SlashCampaignQ end,
                setFunc = function(value) SC.SV.SlashCampaignQ = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashCampaignQ,
            },
            {
                -- SlashBanker
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_BANKER),
                tooltip = strformat(GetString(SI_LUIE_LAM_SLASHCMDS_BANKER_TP), GetCollectibleName(267)),
                getFunc = function() return SC.SV.SlashBanker end,
                setFunc = function(value) SC.SV.SlashBanker = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashBanker,
            },
            {
                -- SlashMerchant
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_MERCHANT),
                tooltip = strformat(GetString(SI_LUIE_LAM_SLASHCMDS_MERCHANT_TP), GetCollectibleName(301)),
                getFunc = function() return SC.SV.SlashMerchant end,
                setFunc = function(value) SC.SV.SlashMerchant = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashMerchant,
            },
            {
                -- SlashFence
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_FENCE),
                tooltip = strformat(GetString(SI_LUIE_LAM_SLASHCMDS_FENCE_TP), GetCollectibleName(300)),
                getFunc = function() return SC.SV.SlashFence end,
                setFunc = function(value) SC.SV.SlashFence = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashFence,
            },
            {
                -- SlashOutfit
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_OUTFIT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_OUTFIT_TP),
                getFunc = function() return SC.SV.SlashOutfit end,
                setFunc = function(value) SC.SV.SlashOutfit = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashOutfit,
            },
            {
                -- SlashReport
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REPORT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REPORT_TP),
                getFunc = function() return SC.SV.SlashReport end,
                setFunc = function(value) SC.SV.SlashReport = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashReport,
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
                getFunc = function() return SC.SV.SlashReadyCheck end,
                setFunc = function(value) SC.SV.SlashReadyCheck = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashReadyCheck,
            },
            {
                -- SlashRegroup
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REGROUP_TP),
                getFunc = function() return SC.SV.SlashRegroup end,
                setFunc = function(value) SC.SV.SlashRegroup = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashRegroup,
            },
            {
                -- SlashDisband
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_DISBAND_TP),
                getFunc = function() return SC.SV.SlashDisband end,
                setFunc = function(value) SC.SV.SlashDisband = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashDisband,
            },
            {
                -- SlashGroupLeave
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_LEAVE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_LEAVE_TP),
                getFunc = function() return SC.SV.SlashGroupLeave end,
                setFunc = function(value) SC.SV.SlashGroupLeave = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashGroupLeave,
            },
            {
                -- SlashGroupKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_KICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_KICK_TP),
                getFunc = function() return SC.SV.SlashGroupKick end,
                setFunc = function(value) SC.SV.SlashGroupKick = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashGroupKick,
            },
            {
                -- SlashVoteKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_VOTEKICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_VOTEKICK_TP),
                getFunc = function() return SC.SV.SlashVoteKick end,
                setFunc = function(value) SC.SV.SlashVoteKick = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashVoteKick,
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
                getFunc = function() return SC.SV.SlashGuildInvite end,
                setFunc = function(value) SC.SV.SlashGuildInvite = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashGuildInvite,
            },
            {
                -- SlashGuildQuit
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDQUIT),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDQUIT_TP),
                getFunc = function() return SC.SV.SlashGuildQuit end,
                setFunc = function(value) SC.SV.SlashGuildQuit = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashGuildQuit,
            },
            {
                -- SlashGuildKick
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDKICK),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_GUILDKICK_TP),
                getFunc = function() return SC.SV.SlashGuildKick end,
                setFunc = function(value) SC.SV.SlashGuildKick = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashGuildKick,
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
                getFunc = function() return SC.SV.SlashFriend end,
                setFunc = function(value) SC.SV.SlashFriend = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashFriend,
            },
            {
                -- SlashIgnore
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_IGNORE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_IGNORE_TP),
                getFunc = function() return SC.SV.SlashIgnore end,
                setFunc = function(value) SC.SV.SlashIgnore = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashIgnore,
            },
            {
                -- SlashRemoveFriend
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND_TP),
                getFunc = function() return SC.SV.SlashRemoveFriend end,
                setFunc = function(value) SC.SV.SlashRemoveFriend = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashRemoveFriend,
            },
            {
                -- SlashRemoveIgnore
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE_TP),
                getFunc = function() return SC.SV.SlashRemoveIgnore end,
                setFunc = function(value) SC.SV.SlashRemoveIgnore = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashRemoveIgnore,
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
                getFunc = function() return SC.SV.SlashCake end,
                setFunc = function(value) SC.SV.SlashCake = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashCake,
            },
            {
                -- SlashPie
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_PIE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_PIE_TP),
                getFunc = function() return SC.SV.SlashPie end,
                setFunc = function(value) SC.SV.SlashPie = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashPie,
            },
            {
                -- SlashMead
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_MEAD),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_MEAD_TP),
                getFunc = function() return SC.SV.SlashMead end,
                setFunc = function(value) SC.SV.SlashMead = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashMead,
            },
            {
                -- SlashWitch
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_WITCH),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_WITCH_TP),
                getFunc = function() return SC.SV.SlashWitch end,
                setFunc = function(value) SC.SV.SlashWitch = value SC.RegisterSlashCommands() end,
                width = "full",
                default = SC.D.SlashWitch,
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.SlashCommands_Enable then
        LAM:RegisterAddonPanel('LUIESlashCommandsOptions', panelDataSlashCommands)
        LAM:RegisterOptionControls('LUIESlashCommandsOptions', optionsDataSlashCommands)
    end
end
