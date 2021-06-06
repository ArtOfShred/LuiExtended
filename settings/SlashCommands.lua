--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SlashCommands = LUIE.SlashCommands

local zo_strformat = zo_strformat

local bankerTythis = GetCollectibleName(267)
local bankerCat = GetCollectibleName(6376)
local merchantNuzimeh = GetCollectibleName(301)
local merchantCat = GetCollectibleName(6378)
local companionBastian = GetCollectibleName(9245)
local companionMirri =  GetCollectibleName(9353)

local bankerOptions     = { bankerTythis, bankerCat }
local bankerOptionsKeys = { [bankerTythis] = 1, [bankerCat] = 2 }
local merchantOptions   = { merchantNuzimeh, merchantCat }
local merchantOptionsKeys   = { [merchantNuzimeh] = 1, [merchantCat] = 2 }
local companionOptions   = { companionBastian, companionMirri }
local companionOptionsKeys   = { [companionBastian] = 1, [companionMirri] = 2 }
local homeOptions       = { "Inside", "Outside"}
local homeOptionsKeys   = { ["Inside"] = 1, ["Outside"] = 2 }

-- Create Slash Commands Settings Menu
function SlashCommands.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibAddonMenu2
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
            },
            {
                -- Choose Home Option
                type = "dropdown",
                name = "\t\t\t\t\tChoose Inside or Outside for /Home",
                choices = homeOptions,
                getFunc = function() return homeOptions[Settings.SlashHomeChoice] end,
                setFunc = function(value) Settings.SlashHomeChoice = homeOptionsKeys[value] end,
                width = "full",
                default = Defaults.SlashHomeChoice,
                disabled = function() return not Settings.SlashHome end,
            },
            {
                -- SlashSetPrimaryHome
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_HOME_SET_PRIMARY),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_HOME_SET_PRIMARY_TP),
                getFunc = function() return Settings.SlashSetPrimaryHome end,
                setFunc = function(value) Settings.SlashSetPrimaryHome = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashSetPrimaryHome,
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
            },
            {
                -- SlashCompanion
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_COMPANION),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_COMPANION_TP),
                getFunc = function() return Settings.SlashCompanion end,
                setFunc = function(value) Settings.SlashCompanion = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashCompanion,
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
            },
            {
                -- Choose Companion
                type = "dropdown",
                name = "\t\t\t\t\tChoose Companion to Summon",
                choices = companionOptions,
                getFunc = function() return companionOptions[Settings.SlashCompanionChoice] end,
                setFunc = function(value) Settings.SlashCompanionChoice = companionOptionsKeys[value] end,
                width = "full",
                default = Defaults.SlashCompanionChoice,
                disabled = function() return not Defaults.SlashCompanion end,

            },
            {
                -- SlashEye
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_EYE),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_EYE_TP),
                getFunc = function() return Settings.SlashEye end,
                setFunc = function(value) Settings.SlashEye = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashEye,
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
            },
            {
                -- SlashPet
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_SLASHCMDS_PET),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_PET_TP),
                getFunc = function() return Settings.SlashPet end,
                setFunc = function(value) Settings.SlashPet = value SlashCommands.RegisterSlashCommands() end,
                width = "full",
                default = Defaults.SlashPet,
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
            },
            {
                -- SlashPet Message
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_SLASHCMDS_PET_MESSAGE)),
                tooltip = GetString(SI_LUIE_LAM_SLASHCMDS_PET_MESSAGE_TP),
                getFunc = function() return Settings.SlashPetMessage end,
                setFunc = function(value) Settings.SlashPetMessage = value end,
                width = "full",
                default = LUIE.Defaults.SlashPetMessage,
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
            },
            {
                -- /Home Alert -- TODO
                type = "checkbox",
                name = "/Home Results - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /home command is used.\nNote: This setting will be deprecated in the future when Social Errors Events are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertHome end,
                setFunc = function(value) LUIE.SV.TempAlertHome = value end,
                width = "full",
                default = LUIE.Defaults.TempAlertHome,
            },
            {
                -- /Campaign Results Alert -- TODO
                type = "checkbox",
                name = "/Campaign Results - Show Alert (Temp Setting)",
                tooltip = "Display an alert when the /campaign command is used.\nNote: This setting will be deprecated in the future when Campaign Queue Events are implemented in Chat Announcements.",
                getFunc = function() return LUIE.SV.TempAlertCampaign end,
                setFunc = function(value) LUIE.SV.TempAlertCampaign = value end,
                width = "full",
                default = LUIE.Defaults.TempAlertCampaign,
            },
            {
                -- /Outfit Alert -- TODO
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
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
                warning = GetString(SI_LUIE_LAM_RELOADUI_SLASH_WARNING),
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.SlashCommands_Enable then
        LAM:RegisterAddonPanel(LUIE.name .. 'SlashCommandsOptions', panelDataSlashCommands)
        LAM:RegisterOptionControls(LUIE.name .. 'SlashCommandsOptions', optionsDataSlashCommands)
    end
end
