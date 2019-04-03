--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- SlashCommands namespace
LUIE.SlashCommands = {}

-- Performance Enhancement
local SC            = LUIE.SlashCommands
local printToChat   = LUIE.PrintToChat
local strformat     = zo_strformat

local callLater     = zo_callLater
local callAlert     = ZO_Alert

local moduleName    = LUIE.name .. "_SlashCommands"

SC.Enabled  = false
SC.D = {
    SlashHome           = true,
    SlashRegroup        = true,
    SlashDisband        = true,
    SlashGroupLeave     = true,
    SlashGroupKick      = true,
    SlashGuildInvite    = true,
    SlashGuildQuit      = false,
    SlashGuildKick      = false,
    SlashFriend         = true,
    SlashIgnore         = true,
    SlashRemoveFriend   = true,
    SlashRemoveIgnore   = true,
    SlashTrade          = true,
    SlashVoteKick       = true,
    SlashCampaignQ      = true,
    SlashBanker         = true,
    SlashMerchant       = true,
    SlashFence          = true,
    SlashReadyCheck     = true,
    SlashOutfit         = true,
    SlashCake           = true,
    SlashPie            = true,
    SlashMead           = true,
    SlashWitch          = true,
    SlashReport         = true,
}
SC.SV       = nil

function SC.Initialize( enabled )
    -- Load Settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        SC.SV = ZO_SavedVars:New( LUIE.SVName, LUIE.SVVer, "SlashCommands", SC.D )
    else
        SC.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "SlashCommands", SC.D )
    end

    if not enabled then
        return
    end
    SC.Enabled = true

    SC.RegisterSlashCommands()
end

-- Slash Command to port to primary home
function LUIE.SlashHome()
    local primaryHouse = GetHousingPrimaryHouse()
    -- Check if we are in combat
    if IsUnitInCombat("player") then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Check to make sure we're not in Cyrodiil
    if IsPlayerInAvAWorld() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in a battleground
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_BG), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Check if user set a primary home
    if primaryHouse == 0 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    else
        RequestJumpToHouse(primaryHouse)
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ALERT, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG)))
        end
    end
end

-- Hook for request friend so menu option also displays invite message
-- Menu is true if this request is sent from the Player to Player interaction menu
-- TODO: move this to Hooks.lua maybe?
local zos_RequestFriend = RequestFriend
RequestFriend = function(option1, option2, menu)
    zos_RequestFriend(option1, option2)
    if not menu then
        local message = strformat(GetString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG), option1)
        printToChat(message, true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, message)
        end
    end
end

-- Hook for request ignore to handle error message if account name is already ignored
-- TODO: move this to Hooks.lua maybe?
local zos_AddIgnore = AddIgnore
AddIgnore = function(option)
    zos_AddIgnore(option)

    if IsIgnored(option) then -- Only lists account names, unfortunately
        printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
end

-- Slash Command to initiate a trade dialogue
local function SlashTrade(option)
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    TradeInviteByName(option)
end

-- Slash Command to queue for a campaign
local function SlashCampaignQ(option)
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NONAME), true)
        if LUIE.SV.TempAlertCampaign then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NONAME) )
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_BG), true)
        if LUIE.SV.TempAlertCampaign then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_BG) )
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Compare names to campaigns available, join the campaign and bail out of the function if it is available.
    for i = 1, 100 do
        local compareName = string.lower(GetCampaignName(i))
        local option = string.lower(option)
        if compareName == option then
            local campaignName
            campaignName = GetCampaignName(i)

            if GetAssignedCampaignId() == i or GetGuestCampaignId() == i then
                QueueForCampaign (i)
                printToChat(strformat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_QUEUE), campaignName), true)
                if LUIE.SV.TempAlertCampaign then
                    callAlert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_QUEUE), campaignName) )
                end
                return
            else
                printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NOT_ENTERED), true)
                if LUIE.SV.TempAlertCampaign then
                    callAlert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NOT_ENTERED) )
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end
        end
    end

    printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_WRONGCAMPAIGN), true)
    if LUIE.SV.TempAlertCampaign then
        callAlert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_WRONGCAMPAIGN) )
    end
    PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
end

-- Slash Command to use collectibles based on their collectible id
function LUIE.SlashCollectible(id)
    local collectibleid = id
    -- Check to make sure we're not in Cyrodiil
    if IsPlayerInAvAWorld() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_AVA), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_AVA)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in a battleground
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_BG), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure that we have the collectible unlocked
    if IsCollectibleUnlocked(collectibleid) then
        UseCollectible(collectibleid)
    else
        printToChat(strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED), GetCollectibleName(collectibleid)), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
end

-- Slash Command to equip a chosen outfit by number
function LUIE.SlashOutfit(option)
    if option == "" or option == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID))
        if LUIE.SV.TempAlertOutfit then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID) )
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local valid = tonumber(option)
    if not valid or valid > 10 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID))
        if LUIE.SV.TempAlertOutfit then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID) )
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local numOutfits = GetNumUnlockedOutfits()

    if valid > numOutfits then
        printToChat( strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_UNLOCKED), valid) )
        if LUIE.SV.TempAlertOutfit then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_UNLOCKED), valid) )
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    EquipOutfit(valid)
    -- Display a confirmation message.
    local name = GetOutfitName(valid)
    if name == "" then
        name = strformat("<<1>> <<2>>", GetString(SI_CROWN_STORE_SEARCH_ADDITIONAL_OUTFITS), valid)
    end
    printToChat( strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_CONFIRMATION), name) )
    if LUIE.SV.TempAlertOutfit then
        callAlert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_CONFIRMATION), name) )
    end
end

-- Slash Command to report a player by given name and attach useful information
local function SlashReport(player)
    local name = player
    local location = GetPlayerLocationName()
    local currenttime = GetTimeString()
    local currentdate = GetDateStringFromTimestamp(GetTimeStamp())
    local server = GetCVar("LastPlatform")
    local text = "I've encounterd a suspicious player.\n\nName: <<1>>\nLocation: <<2>>\nDate & Time: <<3>> <<4>>\nServer: <<5>>"

    -- Set the category to report a player
    HELP_CUSTOMER_SERVICE_ASK_FOR_HELP_KEYBOARD:SelectCategory(2)
    -- Set the subcategory (default: Other)
    HELP_CUSTOMER_SERVICE_ASK_FOR_HELP_KEYBOARD:SelectSubcategory(4)

    -- Populate the reporting window name and description
    ZO_Help_Ask_For_Help_Keyboard_ControlDetailsTextLineField:SetText(name)
	ZO_Help_Ask_For_Help_Keyboard_ControlDescriptionBodyField:SetText(strformat(text, name, location, currentdate, currenttime, server))

    -- Open the reporting window
    HELP_CUSTOMER_SUPPORT_KEYBOARD:OpenScreen(HELP_CUSTOMER_SERVICE_ASK_FOR_HELP_KEYBOARD_FRAGMENT)
end

function SC.RegisterSlashCommands()
    -- Clear commands list
    SLASH_COMMANDS["/home"]         = nil
    SLASH_COMMANDS["/regroup"]      = nil
    SLASH_COMMANDS["/disband"]      = nil
    SLASH_COMMANDS["/leave"]        = nil
    SLASH_COMMANDS["/leavegroup"]   = nil
    SLASH_COMMANDS["/kick"]         = LUIE.SlashKick -- This command is always registered since it is also a default emote
    SLASH_COMMANDS["/remove"]       = nil
    SLASH_COMMANDS["/groupkick"]    = nil
    SLASH_COMMANDS["/groupremove"]  = nil
    SLASH_COMMANDS["/trade"]        = nil
    SLASH_COMMANDS["/votekick"]     = nil
    SLASH_COMMANDS["/voteremove"]   = nil
    SLASH_COMMANDS["/guildinvite"]  = nil
    SLASH_COMMANDS["/ginvite"]      = nil
    SLASH_COMMANDS["/guildkick"]    = nil
    SLASH_COMMANDS["/gkick"]        = nil
    SLASH_COMMANDS["/guildquit"]    = nil
    SLASH_COMMANDS["/gquit"]        = nil
    SLASH_COMMANDS["/guildleave"]   = nil
    SLASH_COMMANDS["/gleave"]       = nil
    SLASH_COMMANDS["/addfriend"]    = nil
    SLASH_COMMANDS["/friend"]       = nil
    SLASH_COMMANDS["/addignore"]    = nil
    SLASH_COMMANDS["/ignore"]       = nil
    SLASH_COMMANDS["/unfriend"]     = nil
    SLASH_COMMANDS["/removefriend"] = nil
    SLASH_COMMANDS["/unignore"]     = nil
    SLASH_COMMANDS["/removeignore"] = nil
    SLASH_COMMANDS["/campaign"]     = nil
    SLASH_COMMANDS["/invite"]       = LUIE.SlashInvite -- This command is always registered since it is also a default command
    SLASH_COMMANDS["/bank"]         = nil
    SLASH_COMMANDS["/banker"]       = nil
    SLASH_COMMANDS["/sell"]         = nil
    SLASH_COMMANDS["/merchant"]     = nil
    SLASH_COMMANDS["/vendor"]       = nil
    SLASH_COMMANDS["/smuggler"]     = nil
    SLASH_COMMANDS["/fence"]        = nil
    SLASH_COMMANDS["/ready"]        = nil
    SLASH_COMMANDS["/readycheck"]   = LUIE.SlashReadyCheck -- This command is always registered since it is also a default command
    SLASH_COMMANDS["/outfit"]       = nil
    SLASH_COMMANDS["/cake"]         = nil
    SLASH_COMMANDS["/anniversary"]  = nil
    SLASH_COMMANDS["/pie"]          = nil
    SLASH_COMMANDS["/jester"]       = nil
    SLASH_COMMANDS["/mead"]         = nil
    SLASH_COMMANDS["/newlife"]      = nil
    SLASH_COMMANDS["/witch"]        = nil
    SLASH_COMMANDS["/witchfest"]    = nil
    SLASH_COMMANDS["/report"]       = nil
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()

    -- Add commands based off menu options
    if SC.SV.SlashHome then
        SLASH_COMMANDS["/home"]         = LUIE.SlashHome
    end
    if SC.SV.SlashTrade then
        SLASH_COMMANDS["/trade"]        = SlashTrade
    end
    if SC.SV.SlashCampaignQ then
        SLASH_COMMANDS["/campaign"]     = SlashCampaignQ
    end
    if SC.SV.SlashOutfit then
        SLASH_COMMANDS["/outfit"]       = LUIE.SlashOutfit
    end
    if SC.SV.SlashReport then
        SLASH_COMMANDS["/report"]       = SlashReport
    end
    if SC.SV.SlashRegroup then
        SLASH_COMMANDS["/regroup"]      = LUIE.SlashRegroup
    end
    if SC.SV.SlashDisband then
        SLASH_COMMANDS["/disband"]      = LUIE.SlashDisband
    end
    if SC.SV.SlashGroupLeave then
        SLASH_COMMANDS["/leave"]        = LUIE.SlashGroupLeave
        SLASH_COMMANDS["/leavegroup"]   = LUIE.SlashGroupLeave
    end
    if SC.SV.SlashGroupKick then
        SLASH_COMMANDS["/remove"]       = LUIE.SlashGroupKick
        SLASH_COMMANDS["/groupkick"]    = LUIE.SlashGroupKick
        SLASH_COMMANDS["/groupremove"]  = LUIE.SlashGroupKick
    end
    if SC.SV.SlashVoteKick then
        SLASH_COMMANDS["/votekick"]     = LUIE.SlashVoteKick
        SLASH_COMMANDS["/voteremove"]   = LUIE.SlashVoteKick
    end
    if SC.SV.SlashReadyCheck then
        SLASH_COMMANDS["/ready"]        = LUIE.SlashReadyCheck
    end
    if SC.SV.SlashGuildInvite then
        SLASH_COMMANDS["/guildinvite"]  = LUIE.SlashGuildInvite
        SLASH_COMMANDS["/ginvite"]      = LUIE.SlashGuildInvite
    end
    if SC.SV.SlashGuildKick then
        SLASH_COMMANDS["/guildkick"]    = LUIE.SlashGuildKick
        SLASH_COMMANDS["/gkick"]        = LUIE.SlashGuildKick
    end
    if SC.SV.SlashGuildQuit then
        SLASH_COMMANDS["/guildquit"]    = LUIE.SlashGuildQuit
        SLASH_COMMANDS["/gquit"]        = LUIE.SlashGuildQuit
        SLASH_COMMANDS["/guildleave"]   = LUIE.SlashGuildQuit
        SLASH_COMMANDS["/gleave"]       = LUIE.SlashGuildQuit
    end
    if SC.SV.SlashFriend then
        SLASH_COMMANDS["/addfriend"]    = LUIE.SlashFriend
        SLASH_COMMANDS["/friend"]       = LUIE.SlashFriend
    end
    if SC.SV.SlashIgnore then
        SLASH_COMMANDS["/addignore"]    = LUIE.SlashIgnore
        SLASH_COMMANDS["/ignore"]       = LUIE.SlashIgnore
    end
    if SC.SV.SlashRemoveFriend then
        SLASH_COMMANDS["/unfriend"]     = LUIE.SlashRemoveFriend
        SLASH_COMMANDS["/removefriend"] = LUIE.SlashRemoveFriend
    end
    if SC.SV.SlashRemoveIgnore then
        SLASH_COMMANDS["/unignore"]     = LUIE.SlashRemoveIgnore
        SLASH_COMMANDS["/removeignore"] = LUIE.SlashRemoveIgnore
    end
    if SC.SV.SlashBanker then
        SLASH_COMMANDS["/bank"]         = function(...) LUIE.SlashCollectible(267) end
        SLASH_COMMANDS["/banker"]       = function(...) LUIE.SlashCollectible(267) end
    end
    if SC.SV.SlashMerchant then
        SLASH_COMMANDS["/sell"]         = function(...) LUIE.SlashCollectible(301) end
        SLASH_COMMANDS["/merchant"]     = function(...) LUIE.SlashCollectible(301) end
        SLASH_COMMANDS["/vendor"]       = function(...) LUIE.SlashCollectible(301) end
    end
    if SC.SV.SlashFence then
        SLASH_COMMANDS["/smuggler"]     = function(...) LUIE.SlashCollectible(300) end
        SLASH_COMMANDS["/fence"]        = function(...) LUIE.SlashCollectible(300) end
    end
    if SC.SV.SlashCake then
        SLASH_COMMANDS["/cake"]         = function(...) LUIE.SlashCollectible(5886) end
        SLASH_COMMANDS["/anniversary"]  = function(...) LUIE.SlashCollectible(5886) end
    end
    if SC.SV.SlashPie then
        SLASH_COMMANDS["/pie"]          = function(...) LUIE.SlashCollectible(1167) end
        SLASH_COMMANDS["/jester"]       = function(...) LUIE.SlashCollectible(1167) end
    end
    if SC.SV.SlashMead then
        SLASH_COMMANDS["/mead"]         = function(...) LUIE.SlashCollectible(1168) end
        SLASH_COMMANDS["/newlife"]      = function(...) LUIE.SlashCollectible(1168) end
    end
    if SC.SV.SlashWitch then
        SLASH_COMMANDS["/witch"]        = function(...) LUIE.SlashCollectible(479) end
        SLASH_COMMANDS["/witchfest"]    = function(...) LUIE.SlashCollectible(479) end
    end

    -- TODO: DEBUG REMOVE or move to SCB Debug.lua
    SLASH_COMMANDS["/filter"]           = LUIE.TempSlashFilter
    SLASH_COMMANDS["/ground"]           = LUIE.TempSlashGround
end
