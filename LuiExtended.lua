------------------
-- LUIE namespace
LUIE             = {}
LUIE.name        = "LuiExtended"
LUIE.author      = "ArtOfShred, psypanda, Upularity & SpellBuilder"
LUIE.version     = "4.99f BETA"
LUIE.components  = {}

-- Saved variables options
LUIE.SV          = nil
LUIE.SVVer       = 2
LUIE.SVName      = 'LUIESV'

-- Default Settings
LUIE.D = {
    UnitFrames_Enabled          = true,
    InfoPanel_Enabled           = true,
    CombatInfo_Enabled          = true,
    SpellCastBuff_Enable        = true,
    ChatAnnouncements_Enable    = true,
    DamageMeter_Enable          = false,
    ChatUseSystem               = false,
    TimeStamp                   = false,
    TimeStampFormat             = "HH:m:s",
    StartupInfo                 = false,
}

-- Global fonts table to use in other parts of this addon
LUIE.Fonts = {
    ["ProseAntique"]            = "/EsoUI/Common/Fonts/ProseAntiquePSMT.otf",
    ["Consolas"]                = "/EsoUI/Common/Fonts/consola.ttf",
    ["Futura Condensed"]        = "/EsoUI/Common/Fonts/FTN57.otf",
    ["Futura Condensed Bold"]   = "/EsoUI/Common/Fonts/FTN87.otf",
    ["Futura Condensed Light"]  = "/EsoUI/Common/Fonts/FTN47.otf",
    ["Skyrim Handwritten"]      = "/EsoUI/Common/Fonts/Handwritten_Bold.otf",
    ["Trajan Pro"]              = "/EsoUI/Common/Fonts/trajanpro-regular.otf",
    ["Univers 55"]              = "/EsoUI/Common/Fonts/univers55.otf",
    ["Univers 57"]              = "/EsoUI/Common/Fonts/univers57.otf",
    ["Univers 67"]              = "/EsoUI/Common/Fonts/univers67.otf",
    ["Fontin Bold"]             = "/LuiExtended/media/fonts/fontin_sans_b.otf",
    ["Fontin Italic"]           = "/LuiExtended/media/fonts/fontin_sans_i.otf",
    ["Fontin Regular"]          = "/LuiExtended/media/fonts/fontin_sans_r.otf",
    ["Fontin SmallCaps"]        = "/LuiExtended/media/fonts/fontin_sans_sc.otf",
    ["EnigmaBold"]              = [[/LuiExtended/media/fonts/EnigmaBold.ttf]],
    ['Adventure']               = [[/LuiExtended/media/fonts/adventure.ttf]],
    ['Bazooka']                 = [[/LuiExtended/media/fonts/bazooka.ttf]],
    ['Cooline']                 = [[/LuiExtended/media/fonts/cooline.ttf]],
    ['Diogenes']                = [[/LuiExtended/media/fonts/diogenes.ttf]],
    ['Ginko']                   = [[/LuiExtended/media/fonts/ginko.ttf]],
    ['Heroic']                  = [[/LuiExtended/media/fonts/heroic.ttf]],
    ['Metamorphous']            = [[/LuiExtended/media/fonts/metamorphous.otf]],
    ['Porky']                   = [[/LuiExtended/media/fonts/porky.ttf]],
    ['Roboto Bold']             = [[/LuiExtended/media/fonts/Roboto-Bold.ttf]],
    ['Roboto Bold Italic']      = [[/LuiExtended/media/fonts/Roboto-BoldItalic.ttf]],
    ['Talisman']                = [[/LuiExtended/media/fonts/talisman.ttf]],
    ['Transformers']            = [[/LuiExtended/media/fonts/transformers.ttf]],
    ['Yellowjacket']            = [[/LuiExtended/media/fonts/yellowjacket.ttf]],
}

LUIE.StatusbarTextures = {
    ["Aluminium"]               = "/LuiExtended/media/unitframes/textures/Aluminium.dds",
    ["Elder Scrolls Gradient"]  = "/LuiExtended/media/unitframes/textures/ElderScrollsGrad.dds",
    ["Glass"]                   = "/LuiExtended/media/unitframes/textures/Glass.dds",
    ["Glaze"]                   = "/LuiExtended/media/unitframes/textures/Glaze.dds",
    ["Horizontal Gradient 1"]   = "/LuiExtended/media/unitframes/textures/HorizontalGrad.dds",
    ["Horizontal Gradient 2"]   = "/LuiExtended/media/unitframes/textures/HorizontalGradV2.dds",
    ["Inner Glow"]              = "/LuiExtended/media/unitframes/textures/InnerGlow.dds",
    ["Inner Shadow"]            = "/LuiExtended/media/unitframes/textures/InnerShadow.dds",
    ["Inner Shadow Glossy"]     = "/LuiExtended/media/unitframes/textures/InnerShadowGloss.dds",
    ["Minimalistic"]            = "/LuiExtended/media/unitframes/textures/Minimalistic.dds",
    ["Round"]                   = "/LuiExtended/media/unitframes/textures/Round.dds",
    ["Sand Paper 1"]            = "/LuiExtended/media/unitframes/textures/SandPaper.dds",
    ["Sand Paper 2"]            = "/LuiExtended/media/unitframes/textures/SandPaperV2.dds",
    ["Shadow"]                  = "/LuiExtended/media/unitframes/textures/Shadow.dds",
    ["Smooth"]                  = "/LuiExtended/media/unitframes/textures/Smooth.dds",
}

-- Load saved settings
local function LUIE_LoadSavedVars()
    -- Addon options
    LUIE.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, nil, LUIE.D)
end

-- Load additional fonts and status bar textures from LMP if it is present in environment
local function LUIE_LoadMedia()
    local LMP = LibStub("LibMediaProvider-1.0")
    if LMP == nil then return end

    -- Update Fonts
    for _, f in pairs(LMP:List(LMP.MediaType.FONT)) do
        if not LUIE.Fonts[f] then
            LUIE.Fonts[f] = LMP:Fetch(LMP.MediaType.FONT, f)
        end
    end

    -- Update StatusBar textures
    for _, s in pairs(LMP:List(LMP.MediaType.STATUSBAR)) do
        if not LUIE.StatusbarTextures[s] then
            LUIE.StatusbarTextures[s] = LMP:Fetch(LMP.MediaType.STATUSBAR, s)
        end
    end
end

-- Startup Info string
local function LUIE_LoadScreen()
    EVENT_MANAGER:UnregisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED)

    if not LUIE.SV.StartupInfo then
        LUIE.PrintToChat(zo_strformat("|cFEFEFE<<1>> by|r |c00C000<<2>>|r |cFEFEFEv<<3>>|r", LUIE.name, LUIE.author, LUIE.version))
    end
end

-- Runs on the EVENT_ACTION_LAYER_POPPED and EVENT_ACTION_LAYER_PUSHED listeners.
-- This handler is used to hide and show all GUI elements when player opens any sort of menu.
local function LUIE_ToggleVisibility(eventCode, layerIndex, activeLayerIndex)
    local hidden = ( activeLayerIndex > 2 )
    for _, control in pairs( LUIE.components ) do
        control:SetHidden( hidden )
    end
end

local function LUIE_RegisterEvents()
    EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LUIE_LoadScreen)
    EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_ACTION_LAYER_POPPED, LUIE_ToggleVisibility)
    EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_ACTION_LAYER_PUSHED, LUIE_ToggleVisibility)
    
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SOCIAL_ERROR, LUIE.SocialError)
end

function LUIE.SocialError(eventCode, reason)

if reason ~= 1 then LUIE.PrintToChat(zo_strformat(GetString("SI_SOCIALACTIONRESULT", reason))) end

end

-- LuiExtended Initialization
local function LUIE_OnAddOnLoaded(eventCode, addonName)
    -- Only initialize our own addon
    if LUIE.name ~= addonName then return end
    -- Once we know it's ours, lets unregister the event listener
    EVENT_MANAGER:UnregisterForEvent(addonName, eventCode)

    -- Load additional media from LMP and other addons
    LUIE_LoadMedia()

    -- Load saved variables
    LUIE_LoadSavedVars()

    -- Initialize this addon modules according to user preferences
    LUIE.UnitFrames.Initialize( LUIE.SV.UnitFrames_Enabled )
    LUIE.InfoPanel.Initialize( LUIE.SV.InfoPanel_Enabled )
    LUIE.CombatInfo.Initialize( LUIE.SV.CombatInfo_Enabled )
    LUIE.SpellCastBuffs.Initialize( LUIE.SV.SpellCastBuff_Enable )
    LUIE.DamageMeter.Initialize(LUIE.SV.DamageMeter_Enable)
    LUIE.ChatAnnouncements.Initialize( LUIE.SV.ChatAnnouncements_Enable )

    -- Create settings menu for our addon
    LUIE_CreateSettings()

    -- register global event listeners
    LUIE_RegisterEvents()
end

local delayBuffer     = {}
local playerName      = GetUnitName("player")
local g_regroupStacks = {}
local PendingRegroup  = false

-- Return a formatted time
-- Stolen from pChat, thanks @Ayantir
function LUIE.CreateTimestamp(timeStr, formatStr)
    formatStr = formatStr or LUIE.SV.TimeStampFormat

    -- Split up default timestamp
    local hours, minutes, seconds = timeStr:match("([^%:]+):([^%:]+):([^%:]+)")
    local hoursNoLead = tonumber(hours) -- Hours without leading zero
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
    timestamp = timestamp:gsub("H",  hoursNoLead)
    timestamp = timestamp:gsub("hh", hours12)
    timestamp = timestamp:gsub("h",  hours12NoLead)
    timestamp = timestamp:gsub("m",  minutes)
    timestamp = timestamp:gsub("s",  seconds)
    timestamp = timestamp:gsub("A",  pUp)
    timestamp = timestamp:gsub("a",  pLow)

    return timestamp
end

-- FormatMessage helper function
function LUIE.FormatMessage(msg, doTimestamp)
    local msg = msg or ""
    if doTimestamp then
        local timestring = GetTimeString()
        -- Color Code to match pChat default
        msg = zo_strformat("|c8F8F8F[<<1>>]|r <<2>>", LUIE.CreateTimestamp(timestring), msg)
    end
    return msg
end

-- Easy Print to Chat
function LUIE.PrintToChat(msg)
    if LUIE.SV.ChatUseSystem and CHAT_SYSTEM.primaryContainer then
        local msg = LUIE.FormatMessage(msg or "no message", LUIE.SV.TimeStamp)
        -- Post as a System message so that it can appear in multiple tabs.
        CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
    else
        -- Post as a normal message
        CHAT_SYSTEM:AddMessage(msg)
    end
end

-- Delay Buffer
function LUIE.DelayBuffer(key, buffer, currentTime)
    if key == nil then return end

    local buffer = buffer or 10
    local now    = currentTime or GetFrameTimeMilliseconds()

    if delayBuffer[key] == nil then
        delayBuffer[key] = now
        return true -- for first call of DelayBuffer we should return true
    end
    local eval = ( now - delayBuffer[key] ) >= buffer
    if eval then
        delayBuffer[key] = now
    end
    return eval
end

-- Returns a formatted number with commas
-- Function no comma to be added in a later date.
function LUIE.CommaValue(number, shorten, noncomma)
    if number > 0 and shorten then
        local value, suffix

        if number >= 1000000000 then
            value = number / 1000000000
            suffix = 'G'
        elseif number >= 1000000 then
            value = number / 1000000
            suffix = 'M'
        elseif number >= 1000 then
            value = number / 1000
            suffix = 'k'
        else
            value = number
        end

        -- If we could not conver even to 'G', return full number with commas
        if value >= 1000 then
            value = LUIE.CommaValue(number)
        elseif value >= 100 or suffix == nil then
            value = string.format('%d', value)
        elseif value >= 10 then
            value = string.format('%.1f', value)
        else
            value = string.format('%.2f', value)
        end

        if suffix ~= nil then
            value = value .. suffix
        end

        return value
    end

    local number = tostring(number)
    -- No shortening was done, so print number with commas
    local left,num,right = string.match(number,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function LUIE.PortPrimaryHome()
    local primaryHouse = GetHousingPrimaryHouse()

    if IsPlayerInAvAWorld() then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA))
        return
    end
    if not primaryHouse then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME))
    else
        RequestJumpToHouse(primaryHouse)
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG))
    end
end

function LUIE.RegroupDisband()
    -- Check for pending regroup
    if PendingRegroup then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_PENDING))
        return
    end

    -- Check to make sure player is in a group
    local groupSize = GetGroupSize()
    if groupSize <= 1 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTINGRP))
        return
    end

    local isLFG = IsInLFGGroup()
    if isLFG then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_LFGACTIVITY))
        return
    end

    -- Check to make sure player is the leader
    local isLeader = IsUnitGroupLeader("player")
    if not isLeader then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTLEADER))
        return
    end

    PendingRegroup = true

    for i = 1,groupSize do
        -- Note not exactly sure why, but it seems we need to index the player here as well. Maybe array needs to have 2+ values in it to be read correctly.
        local memberTag = GetGroupUnitTagByIndex(i)
        local groupMemberString
        local groupMemberName = GetUnitName(memberTag)
        local groupMemberAccountName = GetUnitDisplayName(memberTag)
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(groupMemberName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(groupMemberAccountName)
        local displayBothString = ( zo_strformat("<<1>><<2>>", groupMemberName, groupMemberAccountName) )
        local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, groupMemberAccountName)
        if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then memberLink = displayNameLink end
        if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then memberLink = characterNameLink end
        if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then memberLink = displayBoth end
        g_regroupStacks[i] = { memberLink = memberLink, memberName = groupMemberName }
    end

    LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_MSG))
    GroupDisband()
    -- Reinvite the group after 5 seconds (give the group interface time to update on server and client end for all group members)
    zo_callLater(LUIE.RegroupInvite, 5000)
end


function LUIE.RegroupInvite()
    LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_MSG))
    for i = 1, #g_regroupStacks do
        local member = g_regroupStacks[i]
        -- Don't invite self and offline members
        if member.memberName ~= playerName then
            GroupInviteByName(member.memberName)
            LUIE.PrintToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG), member.memberLink))
        end
    end

    PendingRegroup = false -- Allow Regroup command to be used again
    g_regroupStacks = {} -- Allow index to be used again.
end

function LUIE.Disband()
    GroupDisband()

    -- Check to make sure player is in a group
    local groupSize = GetGroupSize()
    if groupSize <= 1 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_DISBAND_FAILED_NOTINGRP))
        return
    end

    -- Check to make sure player is the leader
    local isLeader = IsUnitGroupLeader('player')
    if not isLeader then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_DISBAND_FAILED_NOTLEADER))
        return
    end
end

local guilds = GetNumGuilds()

function LUIE.SlashGuildInvite(option)

    if option == "" then LUIE.PrintToChat("You must enter a guild number followed by a character or account name to invite to the guild.") return end -- If no input was entered, display an error and end.
    
    -- Parse input
    local options = {}
    local searchResult = { string.match(option,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
        if (v ~= nil and v ~= "") then
            options[i] = v
        end
    end

    local guildnumber = options[1]
    local name = options[2]
    
    if name == nil then LUIE.PrintToChat("You must enter a guild number followed by a character or account name to invite to the guild.") return end -- If no name was entered, display an error and end.
    
    if guildnumber == "1" then guildnumber = 1
    elseif guildnumber == "2" then guildnumber = 2
    elseif guildnumber == "3" then guildnumber = 3
    elseif guildnumber == "4" then guildnumber = 4
    elseif guildnumber == "5" then guildnumber = 5
    else LUIE.PrintToChat ("You must enter a valid guild number to invite a player.") return end -- If we enter anything outside of the range of 1-5, display an error and end.
    if guildnumber > guilds then LUIE.PrintToChat ("You must enter a valid guild number to invite a player.") return end -- If we try to invite a player to a guild we don't have display an error and end.
    
        GuildInvite(guildnumber, name)

        local guildName = GetGuildName(guildnumber)
        local allianceIconSize = 16
        local guildAlliance = GetGuildAlliance(guildnumber)
        local guildNameAlliance = LUIE.ChatAnnouncements.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), allianceIconSize, allianceIconSize, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))
        LUIE.PrintToChat(zo_strformat(GetString(SI_GUILD_ROSTER_INVITED_MESSAGE), name, guildNameAlliance))
end

function LUIE.GQuit(option)
    
    if option == "1" then option = 1
    elseif option == "2" then option = 2
    elseif option == "3" then option = 3
    elseif option == "4" then option = 4
    elseif option == "5" then option = 5
    else LUIE.PrintToChat ("You must enter a valid guild number to leave a guild.") return end
    if option > guilds then LUIE.PrintToChat ("You must enter a valid guild number to leave a guild.") return end -- If we try to invite a player to a guild we don't have display an error and end.

    GuildLeave(option) -- If neither of the above errors were triggered, leave the guild number.
    
end

function LUIE.GKick(option)

    if option == "" then LUIE.PrintToChat("You must enter a guild number followed by a character or account name to kick from the guild.") return end -- If no input was entered, display an error and end.
    
    -- Parse input
    local options = {}
    local searchResult = { string.match(option,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
        if (v ~= nil and v ~= "") then
            options[i] = v
        end
    end

    local guildnumber = options[1]
    local name = options[2]
    
    if name == nil then LUIE.PrintToChat("You must enter a guild number followed by a character or account name to kick from the guild.") return end -- If no name was entered, display an error and end.
    
    if guildnumber == "1" then guildnumber = 1
    elseif guildnumber == "2" then guildnumber = 2
    elseif guildnumber == "3" then guildnumber = 3
    elseif guildnumber == "4" then guildnumber = 4
    elseif guildnumber == "5" then guildnumber = 5
    else LUIE.PrintToChat ("You must enter a valid guild number to kick a player.") return end -- If we enter anything outside of the range of 1-5, display an error and end.
    if guildnumber > guilds then LUIE.PrintToChat ("You must enter a valid guild number to kick a player.") return end -- If we try to invite a player to a guild we don't have display an error and end.
    
    -- Index guild members so we can use character name as a kick option
    local guildNumbers = GetNumGuildMembers(guildnumber)
    local compareChar = string.lower(name)
    
    g_guildNamesTable = { }
    
    for i = 1,guildNumbers do
        local displayName = GetGuildMemberInfo(guildnumber, i)
        local _, characterName = GetGuildMemberCharacterInfo(guildnumber, i)
    
        local compareDisplay = string.lower(displayName)
        local compareCharacter = string.lower(characterName)
        
        compareCharacter = string.gsub(compareCharacter,"%^%a+","")
        
        g_guildNamesTable[i] = { displayName=displayName, characterName=characterName, compareDisplay=compareDisplay, compareCharacter=compareCharacter}
        --LUIE.PrintToChat(compareDisplay .. compareCharacter)
        --LUIE.PrintToChat("comparing vs... " .. compareChar)
    end
    
    local finalName = ""
    
    for i = 1, #g_guildNamesTable do
        local comparing = g_guildNamesTable[i]
        if comparing.compareDisplay == compareChar or comparing.compareCharacter == compareChar then finalName = comparing.displayName break end
    end

    if finalName ~= "" then
        GuildRemove(guildnumber, finalName)
    else
        LUIE.PrintToChat("You must enter a valid character or account name to kick from the guild.")
    end
    
end

--[[


     GetNumFriends()
        Returns: number numFriends

    GetFriendInfo(number friendIndex)
        Returns: string displayName, string note, number playerStatus, number secsSinceLogoff

    GetFriendCharacterInfo(number friendIndex)

    Returns: boolean hasCharacter, string characterName, string zoneName, number classType, number alliance, number level, number championRank, number zoneId

]]

--[[function LUIE.SlashFriend(option)

    -- ZO_GetPrimaryPlayerName(displayName, characterName, useInternalFormat) Gets account name from string possibly? Could be useful when requests are sent to valid targets!

    -- IsFriend(string charOrDisplayName) -- possibly can use the name sent?

    if option == "" then return end -- Enter a name dumbo!

    local alreadyFriend = IsFriend(option)
    if alreadyFriend then LUIE.PrintToChat "Lol1" end

    local nameCheck = option:lower()

    local numFriends = GetNumFriends()

    for i = 1, numFriends do
        local g_friendName = GetFriendInfo(i)
        local _, g_friendCharacter = GetFriendCharacterInfo(i)
        g_friendName = g_friendName:lower()
        g_friendCharacter = g_friendCharacter:lower()
        if g_friendName == nameCheck or g_friendCharacter == nameCheck then
            LUIE.PrintToChat "Already exists you meatwizard"
            return
        end
    end

    RequestFriend(option)
    LUIE.PrintToChat (zo_strformat("You have sent a friend request to |cFEFEFE\"<<1>>\"|r", option))
end]]

--[[function LUIE.SlashIgnore(option)
    AddIgnore(option)
end]]

-- Slash Commands
SLASH_COMMANDS["/regroup"] = LUIE.RegroupDisband
SLASH_COMMANDS["/disband"] = LUIE.Disband
SLASH_COMMANDS["/home"] = LUIE.PortPrimaryHome

SLASH_COMMANDS["/ginvite"] = LUIE.SlashGuildInvite
SLASH_COMMANDS["/gquit"] = LUIE.GQuit
SLASH_COMMANDS["/gkick"] = LUIE.GKick


-- TODO add these commands and various others later!
--SLASH_COMMANDS["/friend"] = LUIE.SlashFriend
--SLASH_COMMANDS["/ignore"] = LUIE.SlashIgnore

-- NOTES:
    --AddIgnore(string charOrDisplayName)
    --RemoveIgnore(string displayName)
    -- RemoveFriend(string displayName)
    --RequestFriend(string charOrDisplayName, string message)

-- Hook initialization
EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, LUIE_OnAddOnLoaded)
