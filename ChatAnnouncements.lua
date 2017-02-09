------------------
-- ChatAnnouncements namespace
LUIE.ChatAnnouncements = {}

-- Performance Enhancement
local CA            = LUIE.ChatAnnouncements
local CommaValue    = LUIE.CommaValue
local strformat     = zo_strformat
local strfmt        = string.format
local strsub        = string.sub 
local gsub          = string.gsub
local tinsert       = table.insert

local moduleName    = LUIE.name .. '_ChatAnnouncements'

CA.D = {
    TimeStamp                     = true,
    TimeStampFormat               = "HH:m",
    GroupChatMsg                  = true,
    GoldChange                    = true,
    TotalGoldChange               = true,
    GoldName                      = "Gold",
    AlliancePointChange           = true,
    TotalAlliancePointChange      = true,
    AlliancePointName             = "Alliance Point",
    TelVarStoneChange             = true,
    TotalTelVarStoneChange        = true,
    TelVarStoneName               = "Tel Var Stone",
    WritVoucherChange             = true,
    TotalWritVoucherChange        = true,
    WritVoucherName               = "Writ Voucher",
    AllowCurrencyMenu             = true,
    AllowLootMenu                 = true,
    AllowExperienceMenu           = true,
    Loot                          = true,
    LootIcons                     = true,
    LootVendor                    = false,
    LootMail                      = true,
    LootTrade                     = false,
    LootCraft                     = false,
    LootGroup                     = true,
    LootOnlyNotable               = false,
    LootShowTrait                 = true,
    LootShowArmorType             = false,
    LootNotTrash                  = true,
    LootBlacklist                 = false,
    LootCurrencyCombo             = false,
    ItemBracketDisplayOptions     = 1,
    ItemContextToggle             = false,
    ItemContextMessage            = "",
    CurrencyIcons                 = true,
    CurrencyBracketDisplayOptions = 1,
    CurrencyContextToggle         = false,
    CurrencyContextMessageUp      = "",
    CurrencyContextMessageDown    = "",
    CurrencyTotalMessage          = "[New Total]",
    ExperienceLevelUp             = true,
    Experience                    = true,
    ExperienceContextName         = "[Gained]",
    ExperienceName                = "XP",
    ExperienceIcon                = true,
    ExperienceShowProgress        = true,
    ExperienceProgressColor       = true,
    ExperienceProgressName        = "[Progress]",
    ExperienceShowPBrackets       = true,
    ExperienceShowDecimal         = true,
    ExperienceShowLevel           = true,
    ExperienceDisplayOptions      = 1,
    ExperiencexperienceHideCombat = false,
    Achievements                  = false,
    AchievementsStep              = 2,
    AchievementsDetails           = true,
    AchIgnoreList                 = {}, -- inverted list of achievements to be tracked
    MiscBags                      = true,
    MiscLockpick                  = true,
}

local g_playerName = nil
local combostring = "" -- String is filled by the EVENT_CURRENCY_CHANGE events and ammended onto the end of purchase/sales from LootLog component if toggled on!

function CA.Initialize()
    -- load settings
    CA.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, 'ChatAnnouncements', CA.D )

    -- Read current player toon name
    g_playerName = GetRawUnitName('player')

    -- register events
    CA.RegisterGroupEvents()
    CA.RegisterGoldEvents()
    CA.RegisterAlliancePointEvents()
    CA.RegisterTelVarStoneEvents()
    CA.RegisterWritVoucherEvents()
    CA.RegisterLootEvents()
    CA.RegisterVendorEvents()
    CA.RegisterTradeEvents()
    CA.RegisterMailEvents()
    CA.RegisterCraftEvents()
    CA.RegisterXPEvents()
    CA.RegisterAchievementsEvent()
    CA.RegisterBagEvents()
    CA.RegisterLockpickEvents()

end

--[[----------------------------------------------------------
    Display group join/leave in chat
--]]----------------------------------------------------------
function CA.RegisterGroupEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_MEMBER_LEFT)
    if CA.SV.GroupChatMsg then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED, CA.OnGroupMemberJoined)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_LEFT,   CA.OnGroupMemberLeft)
    end
end

function CA.OnGroupMemberJoined(eventCode, memberName)
    if g_playerName ~= memberName then
        -- Can occur if event is before EVENT_PLAYER_ACTIVATED
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(memberName,"%^%a+","") )
        if CHAT_SYSTEM then
            printToChat(strfmt('%s|r has joined your group.', characterNameLink))
        end
    end
end

function CA.OnGroupMemberLeft(eventCode, memberName, reason, wasLocalPlayer)
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(memberName,"%^%a+","") )
    local msg = nil
    if reason == GROUP_LEAVE_REASON_VOLUNTARY then
        msg = g_playerName == memberName and 'You have left the group.' or '|%s|r has left your group.'
    elseif reason == GROUP_LEAVE_REASON_KICKED then
        -- msg = g_playerName == memberName and 'You were kicked from the group.' or '|cFEFEFE%s|r was kicked from your group.' -- Don't want to have to fetch this color code again if I need it.
        msg = g_playerName == memberName and 'You were kicked from the group.' or '%s|r was kicked from your group.'
    elseif reason == GROUP_LEAVE_REASON_DISBAND and g_playerName == memberName then
        msg = 'Your group has been disbanded.'
    end
    if msg then
        -- Can occur if event is before EVENT_PLAYER_ACTIVATED
        if CHAT_SYSTEM then
            printToChat(strfmt(msg, characterNameLink))
        end
    end
end

--[[----------------------------------------------------------
    Return a formatted time
    (Stolen from pChat - thanks Ayantir)
--]]----------------------------------------------------------
function CreateTimestamp(timeStr, formatStr)
    formatStr = formatStr or CA.SV.TimeStampFormat
    
    -- Split up default timestamp
    local hours, minutes, seconds = timeStr:match("([^%:]+):([^%:]+):([^%:]+)")
    local hoursNoLead = tonumber(hours) -- hours without leading zero
    local hours12NoLead = (hoursNoLead - 1)%12 + 1
    local hours12
    if (hours12NoLead < 10) then
        hours12 = "0" .. hours12NoLead
    else
        hours12 = hours12NoLead
    end
    local pUp = "AM"
    local pLow = "am"
    if (hoursNoLead >= 12) then
        pUp = "PM"
        pLow = "pm"
    end
    
    -- Create new one
    local timestamp = formatStr
    timestamp = timestamp:gsub("HH", hours)
    timestamp = timestamp:gsub("H", hoursNoLead)
    timestamp = timestamp:gsub("hh", hours12)
    timestamp = timestamp:gsub("h", hours12NoLead)
    timestamp = timestamp:gsub("m", minutes)
    timestamp = timestamp:gsub("s", seconds)
    timestamp = timestamp:gsub("A", pUp)
    timestamp = timestamp:gsub("a", pLow)
    
    return timestamp

end

--[[----------------------------------------------------------
    FormatMessage helper function
--]]----------------------------------------------------------
function CA.FormatMessage(msg, doTimestamp)
    local msg = msg or ""
    if doTimestamp then
        --[[ Disabling this code, for now
        -- We want to have timestamp of the same colour as the message
        local timeStamp = '[' .. GetTimeString() .. '] '
        if "|c" == strsub(msg, 0, 2) then
            msg = strsub(msg, 0, 8) .. timeStamp .. strsub(msg, 9)
        else
            msg = timeStamp .. msg
        end
        ]]-- Instead just put gray timestamp
        msg = '|c8F8F8F[' .. CreateTimestamp(GetTimeString()) .. ']|r ' .. msg
    end
    return msg
end

--[[----------------------------------------------------------
    printToChat function used in next sections
--]]----------------------------------------------------------
function printToChat(msg)
    local msg = CA.FormatMessage(msg or 'no message', CA.SV.TimeStamp)
    if (CHAT_SYSTEM.primaryContainer) then
        -- If possible, post as a System message so that it can appear in multiple tabs.
        CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
    else
        CHAT_SYSTEM:AddMessage(msg)
    end
end 

--[[----------------------------------------------------------
    Gold change into chat -- Only register this event if the menu setting is true
--]]----------------------------------------------------------
function CA.RegisterGoldEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MONEY_UPDATE)
    if CA.SV.GoldChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MONEY_UPDATE, CA.OnMoneyUpdate)
    end
end

function CA.RegisterAlliancePointEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ALLIANCE_POINT_UPDATE)
    if CA.SV.AlliancePointChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ALLIANCE_POINT_UPDATE, CA.OnAlliancePointUpdate)
    end
end

function CA.RegisterTelVarStoneEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TELVAR_STONE_UPDATE)
    if CA.SV.TelVarStoneChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TELVAR_STONE_UPDATE, CA.OnTelVarStoneUpdate)
    end
end

function CA.RegisterWritVoucherEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_WRIT_VOUCHER_UPDATE)
    if CA.SV.WritVoucherChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_WRIT_VOUCHER_UPDATE, CA.OnWritVoucherUpdate)
    end
end

--[[----------------------------------------------------------
    Gold Change Announcements
--]]----------------------------------------------------------
function CA.OnMoneyUpdate(eventCode, newMoney, oldMoney, reason)
    
    combostring = ""
    
    --[[
    BIG ASS INDEX OF CURRENCY CHANGE EVENT REASONS AND WHAT THEY DO:
    reason 0 = loot from Chest
    reason 1 = sell/buy from merchant
    reason 2 = send/recieve money in mail
    reason 3 = spend/receive money in trade
    reason 4 = quest reward
    reason 5 = spent on NPC conversation
    reason 8 = spent - Bag Space Upgrade
    reason 9 = spent - Bank Space Upgrade
    reason 19 = spent - Wayshrine Cost
    reason 20 = Receieve from COD (Untested)
    reason 28 = Spent - Mount Feed
    reason 29 - Spent - Repairs
    reason 31 = Spent - Buy on AH
    reason 32 = Received - AH Refund (Untested)
    reason 33 = Spent - AH Listing Fee
    reason 42 = Deposit - Bank
    reason 43 = Withdraw - Bank
    reason 44 = Spent - Respec Skills
    reason 45 = Spell - Respec Attributes
    reason 47 = Spent - Bounty Paid to Guard
    reason 48 = Spent - Unstuck Function
    reason 49 = Spent - Edit Guild Heraldry (Untested)
    reason 50 = Spent - Bought a guild tabard
    reason 51 = Deposit - G Bank
    reason 52 = Withdraw - G Bank
    reason 53 = Guild Standard (Untested) - I'm not sure what this is, assuming Spent?
    reason 54 = Jump Failure (Untested) - Guessing this is a gain in gold if Wayshrine jump fails somehow, IDK wtf
    reason 55 = Spent - Respec Morphs
    reason 56 = Spent - Pay bounty to Fence
    reason 57 = Loss - Bounty confiscated if killed by guard
    reason 58 = Guild Forward Camp (Untested) - Not sure what this one is either
    reason 59 = Looted - Pickpocket (Untested) (Don't think any NPC's have gold in their pockets)
    reason 60 = Spent - Launder
    reason 61 = Spent - Champion Respec
    reason 62 = Looted - Stolen loot or chest (BUG NOTE: No event fired from Justice Chests UNLESS gold is specifically looted)
    reason 63 = Received - Sold Stolen
    reason 64 = Spent - Buyback
    reason 65 = PVP Kill Transfer??? (Untested)
    reason 66 = Bank Fee??? (Untested)
    reason 67 = Death??? (Untested)
    ]]--
    
    local UpOrDown = newMoney - oldMoney
    local currentMoney = CommaValue ( GetCurrentMoney() )
    local color = ""
    local changetype = ""
    local message = ""
    local total = ""
    local plural = "s"
    local formathelper = " "
    local bracket1 = ""
    local bracket2 = ""
    
    if CA.SV.CurrencyBracketDisplayOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.CurrencyBracketDisplayOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.CurrencyBracketDisplayOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.CurrencyBracketDisplayOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end
    
    -- If the total gold change was 0 then we end this now
    if UpOrDown == 0 then return end
    
    -- Determine the color of the text based on whether we gained or lost gold
    if UpOrDown > 0 then
        color = "|c0B610B"
        changetype = CommaValue (newMoney - oldMoney)
    else
        color = "|ca80700"
        changetype = CommaValue (oldMoney - newMoney)
    end
    
    -- If we only recieve or lose 1 Gold, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.GoldName == "" or CA.SV.GoldName == "Gold" then
        plural = ""
    end
    
    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.GoldName == ( "" ) then
        formathelper = ( "" )
    end
    
    -- Sell/Buy from a Merchant
    if reason == 1 and UpOrDown > 0 then message = ( "Received" )
    elseif reason == 1 and UpOrDown < 0 then message = ("Spent" )

    -- Receieve/Send Money in the Mail
    elseif reason == 2 and UpOrDown > 0 then message = ( "Received" )
    elseif reason == 2 and UpOrDown < 0 then message = ( "Sent" )
    
    -- Receive/Give Money in a Trade (Likely consolidate this later)
    elseif reason == 3 and UpOrDown > 0 then message = ( "Traded" )
    elseif reason == 3 and UpOrDown < 0 then message = ( "Traded" )
    
    -- Receive from Quest Reward (4), Sell to Fence (63)
    elseif reason == 4 or reason == 63 then message = ( "Received" )
        
    -- Spend - NPC Conversation (5), Bag Space (8), Bank Space (9), Wayshrine (19), Mount Feed (28), Repairs (29), Buy on AH (31), AH Listing Fee (33), Respec Skills (44), Respec Attributes (45), Pay to Guard (47),
    -- Unstuck (48), Edit Guild Heraldry (49), Buy Guild Tabard (50), Respec Morphs (55), Pay Fence (56), Launder (60), Champion Respec (61), Buyback (64)
    elseif reason == 5 or reason == 8 or reason == 9 or reason == 19 or reason == 28 or reason == 29 or reason == 31 or reason == 33 or reason == 44 or reason == 45 or reason == 47 or reason == 48 or reason == 49 or reason == 50 or reason == 55 or reason == 56 or reason == 60 or reason == 61 or reason == 64 then message = ( "Spent" )
    
    -- Desposit in Bank (42) or Guild Bank (51)
    elseif reason == 42 or reason == 51 then message = ( "Desposited" )
    
    -- Withdraw from Bank (43) or Guild Bank (52)
    elseif reason == 43 or reason == 52 then message = ( "Withdrew" )
    
    -- Confiscated -- Killed by Guard (57)
    elseif reason == 57 then message = ( "Lost" )
    
    -- Pickpocketed (59)
    elseif reason == 59 then message = ( "Pickpocket" )
    
    -- Looted - From Chest (0), Looted (13), Stolen Gold (62)
    elseif reason == 0 or reason == 13 or reason == 62 then message = ( "Looted" )
    
    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    elseif reason == 6 then message = "Currency Change Reason 6 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 7 then message = "Currency Change Reason 7 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 12 then message = "Currency Change Reason 12 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 14 then message = "Currency Change Reason 14 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 15 then message = "Currency Change Reason 15 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 16 then message = "Currency Change Reason 16 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 18 then message = "Currency Change Reason 18 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 20 then message = "Currency Change Reason 20 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 21 then message = "Currency Change Reason 21 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 22 then message = "Currency Change Reason 22 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 23 then message = "Currency Change Reason 23 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 24 then message = "Currency Change Reason 24 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 25 then message = "Currency Change Reason 25 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 26 then message = "Currency Change Reason 26 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 27 then message = "Currency Change Reason 27 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 30 then message = "Currency Change Reason 30 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 32 then message = "Currency Change Reason 32 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 34 then message = "Currency Change Reason 34 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 36 then message = "Currency Change Reason 36 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 37 then message = "Currency Change Reason 37 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 38 then message = "Currency Change Reason 38 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 39 then message = "Currency Change Reason 39 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 40 then message = "Currency Change Reason 40 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 41 then message = "Currency Change Reason 41 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 46 then message = "Currency Change Reason 46 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 53 then message = "Currency Change Reason 53 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 54 then message = "Currency Change Reason 54 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 58 then message = "Currency Change Reason 58 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 66 then message = "Currency Change Reason 66 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    -- END DEBUG EVENTS
    -- ==============================================================================
    
    -- If none of these returned true, then we must have just looted the gold (Potentially a few currency change events I missed too may have to adjust later)
    else message = ( "Looted" ) end
    
    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ( "|c0B610B" ) then 
            message = ( CA.SV.CurrencyContextMessageUp )
        else
            message = ( CA.SV.CurrencyContextMessageDown )
        end
    end

    -- Determines syntax based on whether icon is displayed or not, we use "ICON - GOLD CHANGE AMOUNT" if so, and "GOLD CHANGE AMOUNT - GOLD" if not
    local syntax = CA.SV.CurrencyIcons and ( " |r|t16:16:/esoui/art/currency/currency_gold.dds|t " .. changetype .. formathelper .. CA.SV.GoldName .. plural .. "|r") or ( " |r" .. changetype .. formathelper .. CA.SV.GoldName .. plural .. "|r")
    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if CA.SV.TotalGoldChange == true and CA.SV.CurrencyIcons == false then
        total = CA.SV.TotalGoldChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |r" .. currentMoney ) or ''
    elseif CA.SV.TotalGoldChange == true and CA.SV.CurrencyIcons == true then
        total = CA.SV.TotalGoldChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |r|t16:16:/esoui/art/currency/currency_gold.dds|t " .. currentMoney )
    else
        total = ''
    end
    
    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and UpOrDown < 0 and (reason == 1 or reason == 2 or reason == 60 or reason == 63 or reason == 64) then
        combostring = ( strfmt ( " → %s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    elseif  CA.SV.LootCurrencyCombo and UpOrDown > 0 and (reason == 1 or reason == 2 or reason == 60 or reason == 63 or reason == 64) then
        combostring = ( strfmt ( " ← %s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    elseif CA.SV.LootCurrencyCombo and CA.SV.MiscBags and (reason == 8 or reason == 9) then
        combostring = ( strfmt ( " → %s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    -- IMPORTANT INSERT MESSAGE HERE!!!
    -- IMPORTANT AS FUCK ^^^^^^
    else
        printToChat ( strfmt ( "%s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    end
    
end

--[[----------------------------------------------------------
    Alliance Point Change Announcements
--]]----------------------------------------------------------

function CA.OnAlliancePointUpdate(eventCode, alliancePoints, playSound, difference)

    combostring = ""
    
    local UpOrDown = alliancePoints + difference
    local color = ""
    local changetype = ""
    local message = ""
    local total = ""
    local plural = "s"
    local formathelper = " "
    local bracket1 = ""
    local bracket2 = ""
    
    if CA.SV.CurrencyBracketDisplayOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.CurrencyBracketDisplayOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.CurrencyBracketDisplayOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.CurrencyBracketDisplayOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end
    
    -- If the total AP change was 0 then we end this now
    if UpOrDown == alliancePoints then return end

    -- Determine the color and message of the text based on whether we gained or lost Alliance Points
    if UpOrDown > alliancePoints then
        color = "|c0B610B"
        changetype = CommaValue ( difference )
        message = ( "Received" )
    else
        color = "|ca80700"
        changetype = CommaValue ( difference * -1 )
        message = ( "Spent" )
    end
    
    -- If we only recieve or lose 1 Alliance Point, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.AlliancePointName == "" then
        plural = ""
    end
    
    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.AlliancePointName == ( "" ) then
        formathelper = ( "" )
    end
    
    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ( "|c0B610B" ) then 
            message = ( CA.SV.CurrencyContextMessageUp )
        else
            message = ( CA.SV.CurrencyContextMessageDown )
        end
    end

    -- Determines syntax based on whether icon is displayed or not, we use "ICON - ALLIANCE POINT CHANGE AMOUNT" if so, and "ALLIANCE POINT CHANGE AMOUNT - ALLIANCE POINT" if not
    local syntax = CA.SV.CurrencyIcons and ( " |r|c20e713|t16:16:/esoui/art/currency/alliancepoints.dds|t " .. changetype .. formathelper .. CA.SV.AlliancePointName .. plural .. "|r" ) or ( " |r|c20e713" .. changetype .. formathelper .. CA.SV.AlliancePointName .. plural .. "|r" )
    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if CA.SV.TotalAlliancePointChange == true and CA.SV.CurrencyIcons == false then
        total = CA.SV.TotalAlliancePointChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |c20e713" .. CommaValue (alliancePoints) ) or ''
    elseif CA.SV.TotalAlliancePointChange == true and CA.SV.CurrencyIcons == true then
        total = CA.SV.TotalAlliancePointChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |c20e713|t16:16:/esoui/art/currency/alliancepoints.dds|t " .. CommaValue (alliancePoints) )
    else
        total = ''
    end
    
    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    if reason == 6 then message = "Currency Change Reason 6 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 7 then message = "Currency Change Reason 7 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 12 then message = "Currency Change Reason 12 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 14 then message = "Currency Change Reason 14 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 15 then message = "Currency Change Reason 15 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 16 then message = "Currency Change Reason 16 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 18 then message = "Currency Change Reason 18 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 20 then message = "Currency Change Reason 20 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 21 then message = "Currency Change Reason 21 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 22 then message = "Currency Change Reason 22 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 23 then message = "Currency Change Reason 23 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 24 then message = "Currency Change Reason 24 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 25 then message = "Currency Change Reason 25 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 26 then message = "Currency Change Reason 26 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 27 then message = "Currency Change Reason 27 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 30 then message = "Currency Change Reason 30 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 32 then message = "Currency Change Reason 32 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 34 then message = "Currency Change Reason 34 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 36 then message = "Currency Change Reason 36 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 37 then message = "Currency Change Reason 37 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 38 then message = "Currency Change Reason 38 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 39 then message = "Currency Change Reason 39 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 40 then message = "Currency Change Reason 40 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 41 then message = "Currency Change Reason 41 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 46 then message = "Currency Change Reason 46 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 53 then message = "Currency Change Reason 53 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 54 then message = "Currency Change Reason 54 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 58 then message = "Currency Change Reason 58 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 66 then message = "Currency Change Reason 66 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    end
    -- END DEBUG EVENTS
    -- ==============================================================================
    
    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and color ( "|ca80700" ) then
        combostring = ( strfmt ( " → %s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    else
        printToChat ( strfmt ( "%s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    end

end

function CA.OnTelVarStoneUpdate(eventCode, newTelvarStones, oldTelvarStones, reason)
    
    combostring = ""
    
    --[[ Relevant Reason codes for Tel Var:
    0 = Chest Loot
    1 = Merchant Buy/Sell
    42 = Deposit in Bank
    43 = Withdraw from Bank
    65 = PVP Kill Transfer (NPC or Player)
    67 = Death (Player Dies)
    ]]--
    
    local UpOrDown = newTelvarStones - oldTelvarStones
    local currentTelvar = CommaValue (newTelvarStones)
    local color = ""
    local changetype = ""
    local message = ""
    local total = ""
    local plural = "s"
    local formathelper = " "
    local bracket1 = ""
    local bracket2 = ""
    
    if CA.SV.CurrencyBracketDisplayOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.CurrencyBracketDisplayOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.CurrencyBracketDisplayOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.CurrencyBracketDisplayOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end
    
    -- If the total Tel Var change was 0 then we end this now
    if UpOrDown == 0 then return end
    
    -- Reason 35 = Player Init (Triggers when player enters or exits Cyrodiil)
    if reason == 35 then return end

    -- Determine the color of the text based on whether we gained or lost gold
    if UpOrDown > 0 then
        color = "|c0B610B"
        changetype = CommaValue (newTelvarStones - oldTelvarStones)
    else
        color = "|ca80700"
        changetype = CommaValue (oldTelvarStones - newTelvarStones)
    end
    
    -- If we only recieve or lose 1 Tel Var Stone, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.TelVarStoneName == "" then
        plural = ""
    end
    
    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.TelVarStoneName == ( "" ) then
        formathelper = ( "" )
    end
    
    -- Buy from a Merchant (no way to sell Tel Var)
    if reason == 1 and UpOrDown < 0 then message = ( "Spent" )
    
    -- Desposit in Bank (42)
    elseif reason == 42 then message = ( "Desposited" )
    
    -- Withdraw from Bank (43)
    elseif reason == 43 then message = ( "Withdrew" )
    
    -- Looted - From Chest (0) or from Player/NPC (65)
    elseif reason == 0 or reason == 65 then message = ( "Looted" )
    
    -- Died to Player/NPC (67)
    elseif reason == 67 then message = ( "Lost" )
    
    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    elseif reason == 6 then message = "Currency Change Reason 6 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 7 then message = "Currency Change Reason 7 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 12 then message = "Currency Change Reason 12 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 14 then message = "Currency Change Reason 14 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 15 then message = "Currency Change Reason 15 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 16 then message = "Currency Change Reason 16 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 18 then message = "Currency Change Reason 18 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 20 then message = "Currency Change Reason 20 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 21 then message = "Currency Change Reason 21 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 22 then message = "Currency Change Reason 22 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 23 then message = "Currency Change Reason 23 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 24 then message = "Currency Change Reason 24 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 25 then message = "Currency Change Reason 25 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 26 then message = "Currency Change Reason 26 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 27 then message = "Currency Change Reason 27 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 30 then message = "Currency Change Reason 30 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 32 then message = "Currency Change Reason 32 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 34 then message = "Currency Change Reason 34 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 36 then message = "Currency Change Reason 36 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 37 then message = "Currency Change Reason 37 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 38 then message = "Currency Change Reason 38 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 39 then message = "Currency Change Reason 39 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 40 then message = "Currency Change Reason 40 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 41 then message = "Currency Change Reason 41 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 46 then message = "Currency Change Reason 46 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 53 then message = "Currency Change Reason 53 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 54 then message = "Currency Change Reason 54 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 58 then message = "Currency Change Reason 58 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 66 then message = "Currency Change Reason 66 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    -- END DEBUG EVENTS
    -- ==============================================================================
    
    -- If none of these returned true, then we must have just looted the Tel Var Stones
    else message = ( "Looted" ) end
    
    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ( "|c0B610B" ) then 
            message = ( CA.SV.CurrencyContextMessageUp )
        else
            message = ( CA.SV.CurrencyContextMessageDown )
        end
    end
    
    -- Determines syntax based on whether icon is displayed or not, we use "ICON - TEL VAR CHANGE AMOUNT" if so, and "TEL VAR CHANGE AMOUNT - TEL VAR" if not
    local syntax = CA.SV.CurrencyIcons and ( " |r|c66a8ff|t16:16:/esoui/art/currency/currency_telvar.dds|t " .. changetype .. formathelper .. CA.SV.TelVarStoneName .. plural .. "|r" ) or ( " |r|c66a8ff" .. changetype .. formathelper .. CA.SV.TelVarStoneName .. plural .. "|r" )
    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if CA.SV.TotalTelVarStoneChange == true and CA.SV.CurrencyIcons == false then
        total = CA.SV.TotalTelVarStoneChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |c66a8ff" .. currentTelvar ) or ''
    elseif CA.SV.TotalTelVarStoneChange == true and CA.SV.CurrencyIcons == true then
        total = CA.SV.TotalTelVarStoneChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |c66a8ff|t16:16:/esoui/art/currency/currency_telvar.dds|t " .. currentTelvar )
    else
        total = ''
    end
    
    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and UpOrDown < 0 and reason == 1 then
        combostring = ( strfmt ( " → %s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    elseif CA.SV.LootCurrencyCombo and UpOrDown > 0 and reason == 1 then
        combostring = ( strfmt ( " ← %s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    else
        printToChat ( strfmt ( "%s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    end

end

function CA.OnWritVoucherUpdate(eventCode, newWritVouchers, oldWritVouchers, reason)
    
    combostring = ""
    
    local UpOrDown = newWritVouchers - oldWritVouchers
    local currentWritVouchers = CommaValue (newWritVouchers)
    local color = ""
    local changetype = ""
    local message = ""
    local total = ""
    local plural = "s"
    local formathelper = " "
    local bracket1 = ""
    local bracket2 = ""
    
    if CA.SV.CurrencyBracketDisplayOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.CurrencyBracketDisplayOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.CurrencyBracketDisplayOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.CurrencyBracketDisplayOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end
    
    -- If the total Tel Var change was 0 then we end this now
    if UpOrDown == 0 then return end
    
    -- Reason 35 = Player Init (Triggers when player changes zones)
    if reason == 35 then return end
    
    -- Determine the color of the text based on whether we gained or lost gold
    if UpOrDown > 0 then
        color = "|c0B610B"
        changetype = CommaValue (newWritVouchers - oldWritVouchers)
        message = ( "Received" )
    else
        color = "|ca80700"
        changetype = CommaValue (oldWritVouchers - newWritVouchers)
        message = ( "Spent" )
    end
    
    -- If we only recieve or lose 1 Writ Voucher, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.WritVoucherName == "" then
        plural = ""
    end
    
    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.WritVoucherName == ( "" ) then
        formathelper = ( "" )
    end
    
    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    if reason == 6 then message = "Currency Change Reason 6 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 7 then message = "Currency Change Reason 7 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 12 then message = "Currency Change Reason 12 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 14 then message = "Currency Change Reason 14 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 15 then message = "Currency Change Reason 15 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 16 then message = "Currency Change Reason 16 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 18 then message = "Currency Change Reason 18 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 20 then message = "Currency Change Reason 20 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 21 then message = "Currency Change Reason 21 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 22 then message = "Currency Change Reason 22 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 23 then message = "Currency Change Reason 23 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 24 then message = "Currency Change Reason 24 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 25 then message = "Currency Change Reason 25 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 26 then message = "Currency Change Reason 26 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 27 then message = "Currency Change Reason 27 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 30 then message = "Currency Change Reason 30 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 32 then message = "Currency Change Reason 32 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 34 then message = "Currency Change Reason 34 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 36 then message = "Currency Change Reason 36 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 37 then message = "Currency Change Reason 37 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 38 then message = "Currency Change Reason 38 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 39 then message = "Currency Change Reason 39 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 40 then message = "Currency Change Reason 40 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 41 then message = "Currency Change Reason 41 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 46 then message = "Currency Change Reason 46 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 53 then message = "Currency Change Reason 53 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 54 then message = "Currency Change Reason 54 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 58 then message = "Currency Change Reason 58 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    elseif reason == 66 then message = "Currency Change Reason 66 Triggered - If you have time please post on the LUI Extended comments section on ESOUI.com with what the event that caused this to happen. Thanks!"
    end
    -- END DEBUG EVENTS
    -- ==============================================================================
    
    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ( "|c0B610B" ) then 
            message = ( CA.SV.CurrencyContextMessageUp )
        else
            message = ( CA.SV.CurrencyContextMessageDown )
        end
    end
    
    -- Determines syntax based on whether icon is displayed or not, we use "ICON - WRIT VOUCHER CHANGE AMOUNT" if so, and "WRIT VOUCHER CHANGE AMOUNT - WRIT VOUCHER" if not
    local syntax = CA.SV.CurrencyIcons and ( " |r|cffffff|t16:16:/esoui/art/currency/currency_writvoucher.dds|t " .. changetype .. formathelper .. CA.SV.WritVoucherName .. plural .. "|r") or ( " |r|cffffff" .. changetype .. formathelper .. CA.SV.WritVoucherName .. plural .. "|r" )
    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if CA.SV.TotalWritVoucherChange == true and CA.SV.CurrencyIcons == false then
        total = CA.SV.TotalWritVoucherChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |cffffff" .. currentWritVouchers ) or ''
    elseif CA.SV.TotalWritVoucherChange == true and CA.SV.CurrencyIcons == true then
        total = CA.SV.TotalWritVoucherChange and ( color .. " " .. CA.SV.CurrencyTotalMessage .. " |cffffff|t16:16:/esoui/art/currency/currency_writvoucher.dds|t " .. currentWritVouchers )
    else
        total = ''
    end
    
    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and UpOrDown < 0 then
        combostring = ( strfmt ( " → %s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    else
        printToChat ( strfmt ( "%s%s%s%s%s%s|r", color, bracket1, message, bracket2, syntax, total ) )
    end
    
end

--[[----------------------------------------------------------
    Loot Announcements
--]]----------------------------------------------------------
function CA.RegisterLootEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_RECEIVED)
    if CA.SV.Loot then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_RECEIVED, CA.OnLootReceived)  
    end
end

function CA.RegisterVendorEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_BUY_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_SELL_RECEIPT)
    if CA.SV.LootVendor then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT, CA.OnBuybackItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_BUY_RECEIPT, CA.OnBuyItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SELL_RECEIPT, CA.OnSellItem)
    end
end
    
function CA.RegisterTradeEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_ITEM_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_ITEM_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_SUCCEEDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_WAITING)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_CONSIDERING)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_CANCELED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_CANCELED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_DECLINED)
    if CA.SV.LootTrade then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_ADDED, CA.OnTradeAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_REMOVED, CA.OnTradeRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_SUCCEEDED, CA.OnTradeSuccess)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_WAITING, CA.TradeInviteWaiting)   
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_CONSIDERING, CA.TradeInviteConsidering)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_CANCELED, CA.OnTradeCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_FAILED, CA.OnTradeCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_CANCELED, CA.OnTradeCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_DECLINED, CA.OnTradeCancel)
    end
end
    
function CA.RegisterMailEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_READABLE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
    if CA.SV.LootMail then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_READABLE, CA.OnMailReadable)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, CA.OnMailTakeAttachedItem)
    end
end

function CA.RegisterCraftEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CRAFT_COMPLETED)
    if CA.SV.LootCraft then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CRAFT_COMPLETED, CA.OnCraftComplete)
    end
end

function CA.RegisterBagEvents()
        EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_BAG_CAPACITY_CHANGED)
        EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_BANK_CAPACITY_CHANGED)
    if CA.SV.MiscBags then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_BAG_CAPACITY_CHANGED, CA.MiscAlertBags)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_BANK_CAPACITY_CHANGED, CA.MiscAlertBank)
    end
end

function CA.RegisterLockpickEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOCKPICK_BROKE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS)
    if CA.SV.MiscLockpick then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_BROKE, CA.MiscAlertLockBroke)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS, CA.MiscAlertLockSuccess)
    end
end

--------------------------------------------------------------

function CA.MiscAlertLockBroke (eventCode, inactivityLengthMs)
    printToChat ("Lockpick broken, you're fucking terrible!!")
end

function CA.MiscAlertLockSuccess (eventCode)
    printToChat ("Lockpick successful!")
end

function CA.MiscAlertBags (eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)

local bracket1 = ""
local bracket2 = ""
local icon = ""
local logPrefix = "Purchased"
    
    if CA.SV.ItemBracketDisplayOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.ItemBracketDisplayOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.ItemBracketDisplayOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.ItemBracketDisplayOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end

    if CA.SV.LootIcons then 
        icon = "|t16:16:/esoui/art/icons/store_upgrade_bag.dds|t "
    else
        icon = ""
    end
    
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    if CA.SV.LootCurrencyCombo then
        printToChat ( strfmt( "|c0B610B%sPurchased%s|r %s[Bag Space Upgrade] %s/8%s", bracket1, bracket2, icon, currentUpgrade, combostring) )
        combostring = ""
    else
        printToChat ( strfmt( "|c0B610B%sPurchased%s|r %s[Bag Space Upgrade] %s/8", bracket1, bracket2, icon, currentUpgrade) )
    end

end

function CA.MiscAlertBank (eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)

local bracket1 = ""
local bracket2 = ""
local icon = ""
local logPrefix = "Purchased"
    
    if CA.SV.ItemBracketDisplayOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.ItemBracketDisplayOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.ItemBracketDisplayOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.ItemBracketDisplayOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end

    if CA.SV.LootIcons then 
        icon = "|t16:16:/esoui/art/icons/store_upgrade_bank.dds|t "
    else
        icon = ""
    end
    
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    if CA.SV.LootCurrencyCombo then
        printToChat ( strfmt( "|c0B610B%s%s%s|r %s[Bank Space Upgrade] %s/18%s", bracket1, logPrefix, bracket2, icon, currentUpgrade, combostring) )
        combostring = ""
    else
        printToChat ( strfmt( "|c0B610B%s%s%s|r %s[Bank Space Upgrade] %s/18", bracket1, logPrefix, bracket2, icon, currentUpgrade) )
    end

end

function CA.OnBuybackItem(eventCode, itemName, quantity, money, itemSound)

    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon
    
    icon = ( CA.SV.LootIcons and icon and icon ~= '' ) and ('|t16:16:' .. icon .. '|t ') or ''
    
    local logPrefix = "Buyback"
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end
    
    local receivedBy = ""
    local gainorloss = "|c0B610B"
    
    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss)
end

function CA.OnBuyItem(eventCode, itemName, entryType, quantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)

    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon
    
    icon = ( CA.SV.LootIcons and icon and icon ~= '' ) and ('|t16:16:' .. icon .. '|t ') or ''
    
    local logPrefix = "Purchased"
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end
    
    local receivedBy = ""
    local gainorloss = "|c0B610B"
    
    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss)
end

function CA.OnSellItem(eventCode, itemName, quantity, money)

    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon
    
    icon = ( CA.SV.LootIcons and icon and icon ~= '' ) and ('|t16:16:' .. icon .. '|t ') or ''
    
    local logPrefix = "Sold"
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end
    
    local receivedBy = ""
    local gainorloss = "|ca80700"
    
    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss)
end

--------------------------------------------------------------

function CA.OnLootReceived(eventCode, receivedBy, itemName, quantity, itemSound, lootType, lootedBySelf, isPickpocketLoot, questItemIcon, itemId)
    
    combostring = ""
    
    local icon
    -- fix Icon for missing quest items
    if lootType == LOOT_TYPE_QUEST_ITEM then
        icon = questItemIcon
    elseif lootType == LOOT_TYPE_COLLECTIBLE then
        local collectibleId = GetCollectibleIdFromLink(itemName)
        local _,_,collectibleIcon = GetCollectibleInfo(collectibleId)
        icon = collectibleIcon
    else
        -- Get Icon
        local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
        icon = itemIcon
    end
    -- Create Icon string if icon exists and corresponding setting is ON
    icon = ( CA.SV.LootIcons and icon and icon ~= '' ) and ('|t16:16:' .. icon .. '|t ') or ''

    local itemType, specializedItemType = GetItemLinkItemType(itemName)
    local itemQuality = GetItemLinkQuality(itemName)
    local itemIsSet = GetItemLinkSetInfo(itemName)
    
    -- Workaround for a ZOS bug: Daedric Embers are not flagged in-game as key fragments
    if (itemId == 69059) then specializedItemType = SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT end
    
    local itemIsKeyFragment = (itemType == ITEMTYPE_TROPHY) and (specializedItemType == SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT)
    local itemIsSpecial = (itemType == ITEMTYPE_TROPHY and not itemIsKeyFragment) or (itemType == ITEMTYPE_COLLECTIBLE) or IsItemLinkConsumable(itemName)
    
    -- List of items to whitelist as notable
    notableIDs = {
        [56862]  = true,    -- [Fortified Nirncrux]
        [56863]  = true,    -- [Potent Nirncrux]
        [68342]  = true,    -- [Hakeijo]
    }
    
    -- List of items to blacklist
    blacklistIDs = {
        [64713]  = true,    -- [Laurel]
        [64690]  = true,    -- [Malachite Shard]
        [69432]  = true,    -- [Glass Style Motif Fragment]
        -- Trial Loot
        [114427] = true,    -- [Undaunted Plunder]
        [81180]  = true,    -- [The Serpent's Egg-Tooth]
        [74453]  = true,    -- [The Rid-Thar's Moon Pearls]
        [87701]  = true,    -- [Star-Studded Champion's Baldric]
        [87700]  = true,    -- [Periapt of Elinhir]
        -- Mercenary Motif Pages
        -- TODO: Find a better way than using IDs
        [64716]  = true,    -- [Mercenary Motif]
        [64717]  = true,    -- [Mercenary Motif]
        [64718]  = true,    -- [Mercenary Motif]
        [64719]  = true,    -- [Mercenary Motif]
        [64720]  = true,    -- [Mercenary Motif]
        [64721]  = true,    -- [Mercenary Motif]
        [64722]  = true,    -- [Mercenary Motif]
        [64723]  = true,    -- [Mercenary Motif]
        [64724]  = true,    -- [Mercenary Motif]
        [64725]  = true,    -- [Mercenary Motif]
        [64726]  = true,    -- [Mercenary Motif]
        [64727]  = true,    -- [Mercenary Motif]
        [64728]  = true,    -- [Mercenary Motif]
        [64729]  = true,    -- [Mercenary Motif]
    }
    
    -- Check for Blacklisted loot
    if ( CA.SV.LootBlacklist and blacklistIDs[itemId] ) then return end
    
    -- Set prefix based on Looted/Pickpocket/Received
    local logPrefix = "Looted"
    
    if ( isPickpocketLoot ) then logPrefix = "Pickpocket" end
    if ( receivedBy == nil ) then logPrefix = "Received" end
    if CA.SV.ItemContextToggle then logPrefix = ( CA.SV.ItemContextMessage ) end
    
    
    local gainorloss = "|c0B610B"
    
    if lootedBySelf then
        if CA.SV.LootOnlyNotable then
            -- Notable items are: any set items, any purple+ items, blue+ special items (e.g., treasure maps)
            if ( (itemIsSet) or
                 (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
                 (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
                 (lootType == LOOT_TYPE_COLLECTIBLE) or
                 (notableIDs[itemId]) ) then
                
                CA.LogItem(logPrefix, icon, itemName, itemType, quantity, lootedBySelf and "" or receivedBy, gainorloss)
            end
        elseif CA.SV.LootNotTrash and ( itemQuality == ITEM_QUALITY_TRASH ) then
            return
        else
            CA.LogItem(logPrefix, icon, itemName, itemType, quantity, lootedBySelf and "" or receivedBy, gainorloss)
        end
    elseif CA.SV.LootGroup then
        if ( (lootType ~= LOOT_TYPE_ITEM and lootType ~= LOOT_TYPE_COLLECTIBLE) or
             (itemType == ITEMTYPE_CONTAINER ) ) then -- Don't show containers for group members
            return
        end
        local itemQuality = GetItemLinkQuality(itemName)
        if ( (itemIsSet) or
             (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
             (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
             (lootType == LOOT_TYPE_COLLECTIBLE) or
             (notableIDs[itemId]) ) then

            CA.LogItem(logPrefix, icon, itemName, itemType, quantity, self and "" or receivedBy, gainorloss)
        end
    end
end

function CA.LogItem( logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss )

    local bracket1 = ""
    local bracket2 = ""
    
    if CA.SV.ItemBracketDisplayOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.ItemBracketDisplayOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.ItemBracketDisplayOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.ItemBracketDisplayOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end

    local formattedRecipient
    local formattedQuantity  = ""
    local formattedTrait     = ""
    local formattedArmorType = ""
    local arrowPointer       = ""
 
    if (receivedBy == "") then
        -- Don't display yourself
        -- TODO: Make a Setting to choose Character or Account name
        formattedRecipient = ""
    else
        -- TODO: This change fixed the arrow on loot group members receive
        --       Sadly it broke the arrow for trade >_>
        if gainorloss == "|c0B610B" then
            arrowPointer = "→"
        else
            arrowPointer = "←"
        end
        -- Create a character link to make it easier to contact the recipient
        formattedRecipient = strfmt(
            "%s |c%06X|H0:character:%s|h%s|h|r",
            testme,
            HashString(receivedBy) % 0x1000000, -- Use the hash of the name for the color so that is random, but consistent
            receivedBy,
            receivedBy:gsub("%^%a+$", "", 1)
        )
    end

    if (quantity > 1) then
        formattedQuantity = strfmt(" |cFFFFFFx%d|r", quantity)
    end

    local armorType = GetItemLinkArmorType(itemName) -- Get Armor Type of item
    if (CA.SV.LootShowArmorType and armorType ~= ARMORTYPE_NONE) then
        formattedArmorType = strfmt(" |cFFFFFF(%s)|r", GetString("SI_ARMORTYPE", armorType))
    end

    local traitType = GetItemLinkTraitInfo(itemName) -- Get Trait type of item
    if (CA.SV.LootShowTrait and traitType ~= ITEM_TRAIT_TYPE_NONE and itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT) then
        formattedTrait = strfmt(" |cFFFFFF(%s)|r", GetString("SI_ITEMTRAITTYPE", traitType))
    end
   
    printToChat(strfmt(
        "%s%s%s%s|r %s%s%s%s%s %s%s",
        gainorloss,
        bracket1,
        logPrefix,
        bracket2,
        icon,
        itemName:gsub("^|H0", "|H1", 1),
        formattedQuantity,
        formattedArmorType,
        formattedTrait,
        formattedRecipient,
        combostring
    ))
    
end

-- Variables used for Trade Functions
local g_TradeStacksIn = {}
local g_TradeStacksOut = {}
local TradeInviter = ""
local TradeInvitee = ""

-- These 2 functions help us get the name of the person we are trading with regardless of who initiated the trade
function CA.TradeInviteWaiting(eventCode, inviteeCharacterName, inviteeDisplayName) 
    TradeInvitee = inviteeCharacterName
    -- printToChat (TradeInvitee) -- Debug
end

-- These 2 functions help us get the name of the person we are trading with regardless of who initiated the trade
function CA.TradeInviteConsidering(eventCode, inviterCharacterName, inviterDisplayName) 
    TradeInviter = inviterCharacterName
    -- printToChat (TradeInviter) -- Debug
end

-- Adds item to index when they are added to the trade
function CA.OnTradeAdded (eventCode, who, tradeIndex, itemSoundCategory) 
    
    -- printToChat ( "tradeIndex: " .. tradeIndex .. " --- WHO: " .. who ) -- Debug
    
    if who == 0 then
        local indexOut = tradeIndex
        local name, icon, stack = GetTradeItemInfo (who, tradeIndex)
        local tradeitemlink = GetTradeItemLink (who, tradeIndex, LINK_STYLE_DEFAULT)
        g_TradeStacksOut[indexOut] = {stack=stack, name=name, icon=icon, itemlink=tradeitemlink}
        
    else
        local indexIn = tradeIndex
        local name, icon, stack = GetTradeItemInfo (who, tradeIndex)
        local tradeitemlink = GetTradeItemLink (who, tradeIndex, LINK_STYLE_DEFAULT)
        g_TradeStacksIn[indexIn] = {stack=stack, name=name, icon=icon, itemlink=tradeitemlink}
    end
    
end

-- Removes items from index if they are removed from the trade
function CA.OnTradeRemoved (eventCode, who, tradeIndex, itemSoundCategory)

    if who == 0 then
        local indexOut = tradeIndex
        g_TradeStacksOut[indexOut] = nil
    else
        local indexIn = tradeIndex
        g_TradeStacksIn[indexIn] = nil
    end
    
end 

-- Cleanup if a Trade is canceled/exited
function CA.OnTradeCancel (eventCode, cancelerName)

    g_TradeStacksIn = {}
    g_TradeStacksOut = {}
    TradeInviter = ""
    TradeInvitee = ""

end

-- Sends results of the trade to the Item Log print function and clears variables so they are reset for next trade interactions
function CA.OnTradeSuccess (eventCode) 
    
    combostring = ""
    
    if TradeInviter == "" then tradetarget = TradeInvitee end
    if TradeInvitee == "" then tradetarget = TradeInviter end
    
        for indexOut = 1, #g_TradeStacksOut do
        local gainorloss = "|ca80700"
        local logPrefix = "Traded"
        if CA.SV.ItemContextToggle then logPrefix = ( CA.SV.ItemContextMessage ) end
        local receivedBy = tradetarget
        local item = g_TradeStacksOut[indexOut]
        icon = ( CA.SV.LootIcons and item.icon and item.icon ~= '' ) and ('|t16:16:' .. item.icon .. '|t ') or ''
        --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue)
        CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainorloss)
        end
        
        for indexIn = 1, #g_TradeStacksIn do
        local gainorloss = "|c0B610B"
        local logPrefix = "Traded"
        if CA.SV.ItemContextToggle then logPrefix = ( CA.SV.ItemContextMessage ) end
        local receivedBy = tradetarget
        local item = g_TradeStacksIn[indexIn]
        icon = ( CA.SV.LootIcons and item.icon and item.icon ~= '' ) and ('|t16:16:' .. item.icon .. '|t ') or ''
        --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue)
        CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainorloss)
        end

    g_TradeStacksIn = {}
    g_TradeStacksOut = {}
    TradeInviter = ""
    TradeInvitee = ""
    
end

local g_CraftStacks = {}

-- Temporary function that does an alright job of printing out Tradeskill item gain/loss to us. Can't get itemlinks currently which severely limits the functionality.
function CA.OnCraftComplete (eventCode, craftSkill)
    
    local gainorloss = "|c0B610B"
    local receivedBy = ""
    
    for i = 1, 4 do 
        local name, icon, stack, sellPrice, meetsUsageRequirement, equipType, itemtype, itemstyle, quality, soundCategory, itemInstanceID = GetLastCraftingResultItemInfo(i)
        if name == "" then break end
        g_CraftStacks[i] = {name=name, icon=icon, stack=stack, quality=quality, itemtype=itemtype, itemstyle=itemstyle}
    end
    
    for i = 1, #g_CraftStacks do
    
    local logPrefix
    local item = g_CraftStacks[i]
    
    local color
    local style = ""

    if item.quality == 2 then
    color = ZO_ColorDef:New(0.176470, 0.772549, 0.054901, 1)
    elseif item.quality == 3 then
    color = ZO_ColorDef:New(0.227450, 0.572549, 1, 1)
    elseif item.quality == 4 then
    color = ZO_ColorDef:New(0.627450, 0.180392, 0.968627, 1)
    elseif item.quality == 5 then
    color = ZO_ColorDef:New(0.933333, 0.792156, 0.164705, 1)
    else
    color = ZO_ColorDef:New(1, 1, 1, 1)
    end
    
    local colorprinter = color:Colorize(zo_strformat("[<<t:1>>]", item.name, item.itemstyle) )
    
    if item.itemstyle ~= ITEMSTYLE_NONE then
        style = strfmt(" |cFFFFFF(%s)|r", GetString("SI_ITEMSTYLE", item.itemstyle))
    end
    
    local itemname = strfmt("%s%s", colorprinter, style)
    
    if item.itemtype == ITEMTYPE_BLACKSMITHING_BOOSTER 
    or item.itemtype == ITEMTYPE_BLACKSMITHING_MATERIAL 
    or item.itemtype == ITEMTYPE_BLACKSMITHING_RAW_MATERIAL 
    or item.itemtype == ITEMTYPE_CLOTHIER_BOOSTER 
    or item.itemtype == ITEMTYPE_CLOTHIER_MATERIAL 
    or item.itemtype == ITEMTYPE_CLOTHIER_RAW_MATERIAL
    or item.itemtype == ITEMTYPE_ENCHANTING_RUNE_ASPECT
    or item.itemtype == ITEMTYPE_ENCHANTING_RUNE_ESSENCE
    or item.itemtype == ITEMTYPE_ENCHANTING_RUNE_POTENCY
    or item.itemtype == ITEMTYPE_ENCHANTMENT_BOOSTER
    or item.itemtype == ITEMTYPE_WOODWORKING_BOOSTER
    or item.itemtype == ITEMTYPE_WOODWORKING_MATERIAL
    or item.itemtype == ITEMTYPE_WOODWORKING_RAW_MATERIAL
    or item.itemtype == ITEMTYPE_STYLE_MATERIAL
    or item.itemtype == ITEMTYPE_ARMOR_BOOSTER
    or item.itemtype == ITEMTYPE_ARMOR_TRAIT
    or item.itemtype == ITEMTYPE_WEAPON_BOOSTER
    or item.itemtype == ITEMTYPE_WEAPON_TRAIT then
        logPrefix = "Received"
    else
        logPrefix = "Crafted"
    end
    
    if CA.SV.ItemContextToggle then logPrefix = ( CA.SV.ItemContextMessage ) end

    icon = ( CA.SV.LootIcons and item.icon and item.icon ~= '' ) and ('|t16:16:' .. item.icon .. '|t ') or ''
    --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue)
    CA.LogItem(logPrefix, icon, itemname, item.itemtype, item.stack or 1, receivedBy, gainorloss)
    end
    
    g_CraftStacks = {}

    
end
   
--[[
 * Next two functions will track items in mail atachments
 ]]--
local g_MailStacks

function CA.OnMailReadable(eventCode, mailId)

    g_MailStacks = {}

    local numAttachments = GetMailAttachmentInfo( mailId )

    for attachIndex = 1, numAttachments do
        local icon, stack = GetAttachedItemInfo( mailId,  attachIndex)
        local mailitemlink = GetAttachedItemLink( mailId,  attachIndex, LINK_STYLE_DEFAULT)
        g_MailStacks[attachIndex] = { stack=stack, icon=icon, itemlink=mailitemlink, }
    end
end

function CA.OnMailTakeAttachedItem(eventCode, mailId)

    combostring = ""
    
    local gainorloss = "|c0B610B"
    
    for attachIndex = 1, #g_MailStacks do
        local item = g_MailStacks[attachIndex]
        CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, gainorloss)
    end

    g_MailStacks = {}
end

function CA.RegisterXPEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN)
    if CA.SV.Experience or CA.SV.ExperienceLevelUp then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN, CA.OnExperienceUpdate)
        CA.LevelUpdateHelper()
    end
end

function CA.LevelUpdateHelper()

    IsChampion = IsUnitChampion('player')
    
    if IsChampion then
        CurrentLevel = GetUnitChampionPoints ('player')
        XPLevel = GetNumChampionXPInChampionPoint(CurrentLevel)
        LevelContext = ( "Champion" )
    else
        CurrentLevel = GetUnitLevel ('player')
        XPLevel = GetNumExperiencePointsInLevel(CurrentLevel)
        LevelContext = ( "Level" )
    end
    
end

local function ExperiencePctToColour(xppct)
        return xppct == 100 and "71DE73" or xppct < 33.33 and "F27C7C" or xppct < 66.66 and "EDE858" or "CCF048"
end

function CA.OnExperienceUpdate( eventCode, reason, level, previousExperience, currentExperience, championPoints )

    local weleveled = 0 -- Incremented and reset if we leveled up.
    local levelhelper = 0 -- Gives us the correct value of XP to use toward the next level when calculating progress after a level up
    local crossover = 0
    
    if IsChampion then
        levelhelper = GetPlayerChampionXP()
    else
        levelhelper = GetUnitXP ('player')
    end

    -- Determines if we leveled up - Needs to be functioning even if we don't printout progress or current level
    if currentExperience >= XPLevel then
        if not IsChampion and CurrentLevel == 49 then -- If we are level 49 and we level up that means we've reached Champion Level, this means we need to update these values!
            crossover = 1 -- Variable incrementer to help us determine if we just reached Champion Level
        end
        weleveled = 1
        CA.LevelUpdateHelper()
    end
    
        if CA.SV.Experience and ( not ( CA.SV.ExperienceHideCombat and reason == 0 ) or not reason == 0 ) then
            -- Change in Experience Points on gaining them
            local change = currentExperience - previousExperience
            local formathelper = " "
    
            -- Format Helper puts a space in if the player enters a value for Experience Name, this way they don't have to do this formatting themselves.
            if CA.SV.ExperienceName == ( "" ) then
                formathelper = ( "" )
            end
        
            -- Displays an icon if enabled
            local icon = CA.SV.ExperienceIcon and ("|r|t16:16:/esoui/art/icons/icon_experience.dds|t " .. CommaValue (change) .. formathelper .. CA.SV.ExperienceName .. "|r" ) or ( "|r" .. CommaValue (change) .. formathelper .. CA.SV.ExperienceName .. "|r" )
    
            local xppct = 0             -- XP Percent
            local decimal = 0           -- If we're using a % value, this is the string that determines whether we have a decimal point or not.
            local progressbrackets = ""
            local progress = ""         -- String returned depending on whether Progress Option is toggled on or off

            if CA.SV.ExperienceShowProgress then

                if CA.SV.ExperienceShowDecimal then
                        xppct = math.floor(10000*levelhelper/XPLevel) / 100
                else
                        xppct = math.floor(100*levelhelper/XPLevel)
                end
            
                --[[ Crossover from Normal XP --> Champion XP modifier ]] --
                if crossover == 1 then -- Corrects values printed for the XP gain event that takes us from Normal XP --> Champion XP
                    xppct = 0 -- Experience points that bring you above 49 don't carryover into champion XP
                    levelhelper = 0 -- Reseting levelhelper to 0 for the [x/x] display option
                end
                
                if CA.SV.ExperienceShowPBrackets then -- If [Progress] display brackets are hidden, then the XP numbers will just print on the end
                    progressbrackets = strfmt( " %s|r", CA.SV.ExperienceProgressName ) 
                else
                    progressbrackets = ( "" )
                end
        
                -- Configures progress experience configuration options
                if CA.SV.ExperienceProgressColor then
                    decimal = strfmt( "|c%s%s", ExperiencePctToColour(xppct), xppct)
                else
                    decimal = strfmt( "%s", xppct)
                end
            
                if CA.SV.ExperienceDisplayOptions == 1 then
                    if CA.SV.ExperienceProgressColor then
                    progress = strfmt( "%s|r (|c%s%s|r/|c71DE73%s|r)", progressbrackets, ExperiencePctToColour(xppct), CommaValue (levelhelper), CommaValue (XPLevel) )
                    else
                    progress = strfmt( "%s|r (%s/%s)|r", progressbrackets, CommaValue (levelhelper), CommaValue (XPLevel) )
                    end
                elseif CA.SV.ExperienceDisplayOptions == 2 then
                    if CA.SV.ExperienceProgressColor then
                    progress = strfmt("%s|r (%s%%|r)", progressbrackets, decimal)
                    else
                    progress = strfmt("%s|r (%s%%|r)", progressbrackets, decimal)
                    end
                elseif CA.SV.ExperienceDisplayOptions == 3 then
                    if CA.SV.ExperienceProgressColor then
                    progress = strfmt("%s|r (%s%%|r - |c%s%s|r/|c71DE73%s|r)", progressbrackets, decimal, ExperiencePctToColour(xppct), CommaValue (levelhelper), CommaValue (XPLevel) )
                    else
                    progress = strfmt("%s|r (%s%%|r - %s/%s)|r", progressbrackets, decimal, CommaValue (levelhelper), CommaValue (XPLevel) )
                    end
                end
                
            end

            -- Displays current player level if option is toggled on
            local totallevel = CA.SV.ExperienceShowLevel and strfmt ( " (%s %s)", LevelContext, CurrentLevel) or ("")
        
            -- Prints out Experience gain message
            printToChat( strfmt("%s %s%s%s", CA.SV.ExperienceContextName, icon, progress, totallevel) )
            
        end
    
    -- Prints out level up message if its toggled on, then resets weleveled
    if weleveled == 1 then
        weleveled = 0
        if CA.SV.ExperienceLevelUp then
            printToChat ("You have reached " .. LevelContext .. " " .. CurrentLevel .. "!")
        end
    end

end

--[[----------------------------------------------------------
    Display achievements progress in chat
--]]----------------------------------------------------------
function CA.RegisterAchievementsEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED)
    if CA.SV.Achievements then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED, CA.OnAchievementUpdated)
    end
end

-- here we will store last displayed percentage for achievement
g_lastPercentage = {}

-- helper function to return colour (without |c prefix) according to current percentage
local function AchievementPctToColour(pct)
    return pct == 1 and "71DE73" or pct < 0.33 and "F27C7C" or pct < 0.66 and "EDE858" or "CCF048"
end

function CA.OnAchievementUpdated(eventCode, aId)

    local topLevelIndex, categoryIndex, achievementIndex = GetCategoryInfoFromAchievementId(aId)

    -- bail out if this achievement comes from unwanted category
    if CA.SV.AchIgnoreList[topLevelIndex] then
        return
    end

    local link = strformat( GetAchievementLink(aId, LINK_STYLE_BRACKETS) )
    local catName = GetAchievementCategoryInfo(topLevelIndex)

    local totalCmp = 0
    local totalReq = 0
    local showInfo = false

    local numCriteria = GetAchievementNumCriteria(aId)
    local cmpInfo = {}
    for i = 1, numCriteria do
        local name, numCompleted, numRequired = GetAchievementCriterion(aId, i)

        table.insert(cmpInfo, { strformat(name), numCompleted, numRequired })

        -- collect the numbers to calculate the correct percentage
        totalCmp = totalCmp + numCompleted
        totalReq = totalReq + numRequired

        -- show the achievement on every special achievement because it's a rare event
        if numRequired == 1 and numCompleted == 1 then
            showInfo = true
        end
    end

    if not showInfo then
        -- achievement completed
        -- this is the first numCompleted value
        -- show every time
        if ( totalCmp == totalReq ) or ( totalCmp == 1 ) or ( CA.SV.AchievementsStep == 0 ) then
            showInfo = true
        else
            -- achievement step hit
            local percentage = math.floor( 100 / totalReq * totalCmp )

            if percentage > 0 and percentage % CA.SV.AchievementsStep == 0 and g_lastPercentage[aId] ~= percentage then
                showInfo = true
                g_lastPercentage[aId] = percentage
            end
        end
    end

    -- bail out here if this achievement update event is not going to be printed to chat
    if not showInfo then
        return
    end

    -- prepare details information
    local details
    if CA.SV.AchievementsDetails then
        -- Skyshards needs separate treatment otherwise text become too long
        -- We also put this short information for achievements that has too many subitems
        if topLevelIndex == 9 or #cmpInfo > 12 then
            details = strfmt( " > |c%s%d|c87B7CC/|c71DE73%d|c87B7CC.", AchievementPctToColour(totalCmp/totalReq), totalCmp, totalReq )
        else
            for i = 1, #cmpInfo do
                -- boolean achievement stage
                if cmpInfo[i][3] == 1 then
                    cmpInfo[i] = strfmt( "|c%s%s", AchievementPctToColour(cmpInfo[i][2]), cmpInfo[i][1] )
                -- others
                else
                    local pct = cmpInfo[i][2] / cmpInfo[i][3]
                    cmpInfo[i] = strfmt( "%s |c%s%d|c87B7CC/|c71DE73%d", cmpInfo[i][1], AchievementPctToColour(pct), cmpInfo[i][2], cmpInfo[i][3] )
                end
            end
            details = ' > ' .. table.concat(cmpInfo, '|c87B7CC, ') .. '|c87B7CC.'
        end
    end

    printToChat( strfmt("|c87B7CC%s %s - |c%s%d%%|c87B7CC [%s]%s|r",
                            (totalCmp == totalReq) and "[Achivement Completed]" or "[Achievement Updated]",
                            link,
                            AchievementPctToColour(totalCmp/totalReq),
                            math.floor(100*totalCmp/totalReq),
                            catName,
                            details or '.' )
                )
end