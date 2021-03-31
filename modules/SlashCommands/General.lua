--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CampaignNames = { }

local SlashCommands = LUIE.SlashCommands

local printToChat = LUIE.PrintToChat
local zo_strformat = zo_strformat

-- Slash Command to port to primary home
function SlashCommands.SlashHome()
    local primaryHouse = GetHousingPrimaryHouse()
    -- Check if we are in combat
    if IsUnitInCombat("player") then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in Imperial City
    if IsInImperialCity() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IC), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IC)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in Cyrodiil
    if IsPlayerInAvAWorld() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in a battleground
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_BG), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Check if user set a primary home
    if primaryHouse == 0 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    else
        RequestJumpToHouse(primaryHouse)
        printToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG)))
        end
    end
end

-- Slash Command to initiate a trade dialogue
function SlashCommands.SlashTrade(option)
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Notify.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    TradeInviteByName(option)
end

local firstRun = true -- Changed by SlashCommands.SlashCampaignQ() when called, used to index available campaigns.

-- Slash Command to queue for a campaign
function SlashCommands.SlashCampaignQ(option)
    -- Return an error message if no input is entered.
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NONAME), true)
        if LUIE.SV.TempAlertCampaign then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NONAME))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Return an error message if the player is in a battleground. -- TODO: Verify you can't queue in a battleground, remove this if you can.
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_BG), true)
        if LUIE.SV.TempAlertCampaign then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_BG))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- The first time we call this function and it passes a check to make sure input is valid, fill a table with campaign names and their corresponding id.
    if firstRun then
        firstRun = false
        for i = 1, 200 do -- TODO: Find a way to determine # of campaigns dynamically instead of iterating.
            local campaignName = string.lower(GetCampaignName(i))
            if campaignName ~= "" and campaignName ~= nil then
                LUIE.CampaignNames[campaignName] = i
            end
        end
    end

    -- If input is valid and the name is in the campaign table, try to queue for the campaign.
    local option = string.lower(option)
    if LUIE.CampaignNames[option] then
        local campaignId = LUIE.CampaignNames[option]
        local campaignName = GetCampaignName(campaignId)

        if GetAssignedCampaignId() == campaignId or GetGuestCampaignId() == campaignId then
            QueueForCampaign(campaignId)
            printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_QUEUE), campaignName), true)
            if LUIE.SV.TempAlertCampaign then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_QUEUE), campaignName))
            end
            return
        else
            printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NOT_ENTERED), true)
            if LUIE.SV.TempAlertCampaign then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_NOT_ENTERED))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            return
        end
    end

    -- Otherwise, return an error message that the campaign doesn't exist.
    printToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_WRONGCAMPAIGN), true)
    if LUIE.SV.TempAlertCampaign then
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_CAMPAIGN_FAILED_WRONGCAMPAIGN))
    end
    PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
end

-- Slash Command to use collectibles based on their collectible id
function SlashCommands.SlashCollectible(id, fromKeybind)
    -- Check to make sure we're not in Imperial City
    if IsInImperialCity() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_IC), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_IC)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in Cyrodiil
    if IsPlayerInAvAWorld() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_AVA), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_AVA)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in a battleground
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_BG), true)
        if LUIE.SV.TempAlertHome then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    if type(id) == "number" then
        if IsCollectibleUnlocked(id) then
            UseCollectible(id)
            LUIE.SlashCollectibleOverride = not fromKeybind
            if id~= 300 and id ~= 267 and id ~= 6376 and id ~= 301 and id ~= 6378 then
                LUIE.LastMementoUsed = id
            end
        else
            printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED), GetCollectibleName(id)), true)
            if LUIE.SV.TempAlertHome then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED)))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            return
        end
    elseif id == "banker" then
        if SlashCommands.SV.SlashBankerChoice == 1 then
            if IsCollectibleUnlocked(267) then
                UseCollectible(267) -- Tythis
                LUIE.SlashCollectibleOverride = not fromKeybind
            else
                printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED), GetCollectibleName(267)), true)
                if LUIE.SV.TempAlertHome then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED)))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end
        else
            if IsCollectibleUnlocked(6376) then
                UseCollectible(6376) -- Ezabi
                LUIE.SlashCollectibleOverride = not fromKeybind
            else
                printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED), GetCollectibleName(6376)), true)
                if LUIE.SV.TempAlertHome then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED)))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end
        end
    elseif id == "merchant" then
        if SlashCommands.SV.SlashMerchantChoice == 1 then
            if IsCollectibleUnlocked(301) then
                UseCollectible(301) -- Nuzhimeh
                LUIE.SlashCollectibleOverride = not fromKeybind
            else
                printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED), GetCollectibleName(301)), true)
                if LUIE.SV.TempAlertHome then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED)))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end
        else
            if IsCollectibleUnlocked(6378) then
                UseCollectible(6378) -- Ferez
                LUIE.SlashCollectibleOverride = not fromKeybind
            else
                printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED), GetCollectibleName(6378)), true)
                if LUIE.SV.TempAlertHome then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_COLLECTIBLE_FAILED_NOTUNLOCKED)))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end
        end
    end
end

-- Slash Command to equip a chosen outfit by number
function SlashCommands.SlashOutfit(option)
    if option == "" or option == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID))
        if LUIE.SV.TempAlertOutfit then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local valid = tonumber(option)
    if not valid or valid > 10 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID))
        if LUIE.SV.TempAlertOutfit then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_VALID))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local numOutfits = GetNumUnlockedOutfits()

    if valid > numOutfits then
        printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_UNLOCKED), valid))
        if LUIE.SV.TempAlertOutfit then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, zo_strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_NOT_UNLOCKED), valid))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    EquipOutfit(valid)
    -- Display a confirmation message.
    local name = GetOutfitName(valid)
    if name == "" then
        name = zo_strformat("<<1>> <<2>>", GetString(SI_CROWN_STORE_SEARCH_ADDITIONAL_OUTFITS), valid)
    end
    printToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_CONFIRMATION), name))
    if LUIE.SV.TempAlertOutfit then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(GetString(SI_LUIE_SLASHCMDS_OUTFIT_CONFIRMATION), name))
    end
end

-- Slash Command to report a player by given name and attach useful information
function SlashCommands.SlashReport(player)
    local location = GetPlayerLocationName()
    local currenttime = GetTimeString()
    local currentdate = GetDateStringFromTimestamp(GetTimeStamp())
    local server = GetWorldName()
    local text = "I've encounterd a suspicious player.\n\nName: <<1>>\nLocation: <<2>>\nDate & Time: <<3>> <<4>>\nServer: <<5>>"

    -- Set the category to report a player
    HELP_CUSTOMER_SERVICE_ASK_FOR_HELP_KEYBOARD:SelectCategory(2)
    -- Set the subcategory (default: Other)
    HELP_CUSTOMER_SERVICE_ASK_FOR_HELP_KEYBOARD:SelectSubcategory(4)

    -- Populate the reporting window name and description
    ZO_Help_Ask_For_Help_Keyboard_ControlDetailsTextLineField:SetText(player)
	ZO_Help_Ask_For_Help_Keyboard_ControlDescriptionBodyField:SetText(zo_strformat(text, player, location, currentdate, currenttime, server))

    -- Open the reporting window
    HELP_CUSTOMER_SUPPORT_KEYBOARD:OpenScreen(HELP_CUSTOMER_SERVICE_ASK_FOR_HELP_KEYBOARD_FRAGMENT)
end

local petIds = {
    [23304] = "[Familiar]", -- Summon Unstable Familiar (Sorcerer)
    [23319] = "[Clannfear]", -- Summon Unstable Clannfear (Sorcerer)
    [23316] = "[Volatile Familiar]", -- Summon Volatile Familiar (Sorcerer)
    [24613] = "[Winged Twilight]", -- Summon Winged Twilight (Sorcerer)
    [24636] = "[Twilight Tormentor]", -- Summon Twilight Tormentor (Sorcerer)
    [24639] = "[Twilight Matriarch]", -- Summon Twilight Matriarch (Sorcerer)
    [85982] = "[Feral Guardian]", -- Feral Guardian (Warden)
    [85986] = "[Eternal Guardian]", -- Eternal Guardian (Warden)
    [85990] = "[Wild Guardian]", -- Wild Guardian (Warden)
}

-- Slash Command to dismiss pets and optionally non-combat pets
function SlashCommands.SlashPet()
    for i = 1, GetNumBuffs("player") do
        local _, _, _, buffSlot, _, _, _, _, _, _, abilityId = GetUnitBuffInfo("player", i)
        if petIds[abilityId] then
            CancelBuff(buffSlot)
            if SlashCommands.SV.SlashPetMessage then
                local petName = petIds[abilityId]
                local message = zo_strformat(GetString(SI_LUIE_DISMISS_PET), petName)
                printToChat(message)
            end
        end
    end
end
