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
LUIE.SVName      = "LUIESV"

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
    ["Adventure"]               = [[/LuiExtended/media/fonts/adventure.ttf]],
    ["Bazooka"]                 = [[/LuiExtended/media/fonts/bazooka.ttf]],
    ["Cooline"]                 = [[/LuiExtended/media/fonts/cooline.ttf]],
    ["Diogenes"]                = [[/LuiExtended/media/fonts/diogenes.ttf]],
    ["Ginko"]                   = [[/LuiExtended/media/fonts/ginko.ttf]],
    ["Heroic"]                  = [[/LuiExtended/media/fonts/heroic.ttf]],
    ["Metamorphous"]            = [[/LuiExtended/media/fonts/metamorphous.otf]],
    ["Porky"]                   = [[/LuiExtended/media/fonts/porky.ttf]],
    ["Roboto Bold"]             = [[/LuiExtended/media/fonts/Roboto-Bold.ttf]],
    ["Roboto Bold Italic"]      = [[/LuiExtended/media/fonts/Roboto-BoldItalic.ttf]],
    ["Talisman"]                = [[/LuiExtended/media/fonts/talisman.ttf]],
    ["Transformers"]            = [[/LuiExtended/media/fonts/transformers.ttf]],
    ["Yellowjacket"]            = [[/LuiExtended/media/fonts/yellowjacket.ttf]],
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
    if LMP == nil then
        return
    end

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
    -- Events registed for Slash Commands
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SOCIAL_ERROR, LUIE.SocialError)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, LUIE.GuildAddedSelf)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD, LUIE.GuildRemovedSelf)
end

-- LuiExtended Initialization
local function LUIE_OnAddOnLoaded(eventCode, addonName)
    -- Only initialize our own addon
    if LUIE.name ~= addonName then
        return
    end
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

    -- Register global event listeners
    LUIE_RegisterEvents()

    -- Keep track of guilds for the /ginvite commands
    LUIE.InitGuildData()
end

local delayBuffer       = {}
local playerName        = GetUnitName("player")
local playerDisplayName = GetUnitDisplayName("player")
local g_regroupStacks   = {}
local PendingRegroup    = false

-- Return a formatted time
-- Stolen from pChat, thanks @Ayantir
function LUIE.CreateTimestamp(timeStr, formatStr)
    local formatStr = formatStr or LUIE.SV.TimeStampFormat

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
    if key == nil then
        return
    end

    local buffer = buffer or 10
    local now    = currentTime or GetFrameTimeMilliseconds()

    if delayBuffer[key] == nil then
        delayBuffer[key] = now
        return true -- For first call of DelayBuffer we should return true
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
        local value
        local suffix

        if number >= 1000000000 then
            value = number / 1000000000
            suffix = "G"
        elseif number >= 1000000 then
            value = number / 1000000
            suffix = "M"
        elseif number >= 1000 then
            value = number / 1000
            suffix = "k"
        else
            value = number
        end

        -- If we could not conver even to "G", return full number with commas
        if value >= 1000 then
            value = LUIE.CommaValue(number)
        elseif value >= 100 or suffix == nil then
            value = string.format("%d", value)
        elseif value >= 10 then
            value = string.format("%.1f", value)
        else
            value = string.format("%.2f", value)
        end

        if suffix ~= nil then
            value = value .. suffix
        end

        return value
    end

    local number = tostring(number)
    -- No shortening was done, so print number with commas
    local left,num,right = string.match(number,"^([^%d]*%d)(%d*)(.-)$")
    return left .. (num:reverse():gsub("(%d%d%d)","%1,"):reverse()) .. right
end

function LUIE.SlashHome()
    local primaryHouse = GetHousingPrimaryHouse()

    if IsUnitInCombat("player") then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT))
        return
    end

    if IsPlayerInAvAWorld() then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA))
        return
    end

    if primaryHouse == 0 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME))
    else
        RequestJumpToHouse(primaryHouse)
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG))
    end

end

function LUIE.SlashRegroup()
    local groupSize = GetGroupSize()
    -- Check for pending regroup
    if PendingRegroup then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_PENDING))
        return
    end
    -- Check to make sure player is in a group
    if groupSize <= 1 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTINGRP))
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTLEADER))
        return
    end
    -- Check to make sure we're not in LFG
    if IsInLFGGroup() then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_LFGACTIVITY))
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
        if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then
            memberLink = displayNameLink
        end
        if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then
            memberLink = characterNameLink
        end
        if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then
            memberLink = displayBoth
        end
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

function LUIE.SlashDisband()
    -- Check to make sure player is in a group
    if GetGroupSize() <= 1 then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER))
        return
    end
    -- Check to make sure we're not in LFG
    local isLFG = IsInLFGGroup()
    if isLFG then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_LFG_ACTIVITY))
        return
    end
    
    GroupDisband()
end

function LUIE.SlashGroupLeave()
    GroupLeave()
    local groupSize = GetGroupSize()
    if groupSize <= 1 then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
        return
    end
end

function LUIE.SlashGroupKick(option)
    -- Rather then error out, let the player use /kick and /remove as a substitute for /votekick and /voteremove in LFG
    if IsInLFGGroup() then
        if option == "" then
            LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME))
            return
        else
            LUIE.SlashVoteKick(option)
            return
        end
    end

    -- Check to make sure player is in a group
    if GetGroupSize() <= 1 then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER))
        return
    end

    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME))
        return
    end

    local g_partyKick = { }
    local kickedMemberName
    local kickedAccountName
    local compareName = string.lower(option)
    local comparePlayerName = string.lower(playerName)
    local comparePlayerAccount = string.lower(playerAccountName)
    local unitToKick

    for i = 1,24 do
        local memberTag = GetGroupUnitTagByIndex(i)
        -- Once we reach a nil value (aka no party member there, stop the loop)
        if memberTag == nil then
            break
        end
        kickedMemberName = string.lower(GetUnitName(memberTag))
        kickedAccountName = string.lower(GetUnitDisplayName(memberTag))
        g_partyKick[i] = { memberTag=memberTag, kickedMemberName=kickedMemberName, kickedAccountName=kickedAccountName }
    end

    -- Iterate through UnitTags to get the member who just joined
    for i = 1,#g_partyKick do
        local kickcompare = g_partyKick[i]
        if kickcompare.kickedMemberName == compareName or kickcompare.kickedAccountName == compareName then
            if kickcompare.kickedMemberName == comparePlayerName or kickcompare.kickedAccountName == comparePlayerAccount then
                GroupLeave()
            else
                unitToKick = kickcompare.memberTag
                SlashGroupKick(unitToKick)
            end
            return
        end
    end

    LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME))
end

function LUIE.InitGuildData()
    GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

function LUIE.SocialError(eventCode, reason)
    if reason ~= 1 then
        LUIE.PrintToChat(zo_strformat(GetString("SI_SOCIALACTIONRESULT", reason)))
    end
end

function LUIE.GuildAddedSelf()
    GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

function LUIE.GuildRemovedSelf()
    GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

function LUIE.SlashGuildInvite(option)
    -- If no input was entered, display an error and end.
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV))
        return
    end

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

    -- If no name was entered, display an error and end.
    if name == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV))
        return
    end

    if guildnumber == "1" and LUIE.GuildIndexData[1] then
        guildnumber = LUIE.GuildIndexData[1].id
    elseif guildnumber == "2" and LUIE.GuildIndexData[2] then
        guildnumber = LUIE.GuildIndexData[2].id
    elseif guildnumber == "3" and LUIE.GuildIndexData[3] then
        guildnumber = LUIE.GuildIndexData[3].id
    elseif guildnumber == "4" and LUIE.GuildIndexData[4] then
        guildnumber = LUIE.GuildIndexData[4].id
    elseif guildnumber == "5" and LUIE.GuildIndexData[5] then
        guildnumber = LUIE.GuildIndexData[5].id
    else -- If we enter anything outside of the range of 1-5, display an error and end.
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_INV))
        return
    end

    -- If we try to invite a player to a guild we don't have display an error and end.
    if guildnumber == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_INV))
        return
    end

    GuildInvite(guildnumber, name)

    local guildName = GetGuildName(guildnumber)
    local allianceIconSize = 16
    local guildAlliance = GetGuildAlliance(guildnumber)
    local guildNameAlliance = LUIE.ChatAnnouncements.SV.MiscGuildIcon
            and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), allianceIconSize, allianceIconSize, ZO_SELECTED_TEXT:Colorize(guildName))
            or (ZO_SELECTED_TEXT:Colorize(guildName))

    LUIE.PrintToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE), name, guildNameAlliance))
end

function LUIE.SlashGuildQuit(guildnumber)
    if guildnumber == "1" and LUIE.GuildIndexData[1] then
        guildnumber = LUIE.GuildIndexData[1].id
    elseif guildnumber == "2" and LUIE.GuildIndexData[2] then
        guildnumber = LUIE.GuildIndexData[2].id
    elseif guildnumber == "3" and LUIE.GuildIndexData[3] then
        guildnumber = LUIE.GuildIndexData[3].id
    elseif guildnumber == "4" and LUIE.GuildIndexData[4] then
        guildnumber = LUIE.GuildIndexData[4].id
    elseif guildnumber == "5" and LUIE.GuildIndexData[5] then
        guildnumber = LUIE.GuildIndexData[5].id
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE))
        return
    end

    -- If we try to invite a player to a guild we don't have display an error and end.
    if guildnumber == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE))
        return
    end

    -- If neither of the above errors were triggered, leave the guild number.
    GuildLeave(guildnumber)
end

function LUIE.SlashGuildKick(option)
    -- If no input was entered, display an error and end.
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK))
        return
    end

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

    -- If no name was entered, display an error and end.
    if name == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK))
        return
    end

    if guildnumber == "1" and LUIE.GuildIndexData[1] then
        guildnumber = LUIE.GuildIndexData[1].id
    elseif guildnumber == "2" and LUIE.GuildIndexData[2] then
        guildnumber = LUIE.GuildIndexData[2].id
    elseif guildnumber == "3" and LUIE.GuildIndexData[3] then
        guildnumber = LUIE.GuildIndexData[3].id
    elseif guildnumber == "4" and LUIE.GuildIndexData[4] then
        guildnumber = LUIE.GuildIndexData[4].id
    elseif guildnumber == "5" and LUIE.GuildIndexData[5] then
        guildnumber = LUIE.GuildIndexData[5].id
    else -- If we enter anything outside of the range of 1-5, display an error and end.
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_KICK))
        return
    end

    -- If we try to invite a player to a guild we don't have display an error and end.
    if guildnumber == nil then
        LUIE.PrintToChat (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_KICK))
        return
    end

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
        --d(compareDisplay .. compareCharacter)
        --d("comparing vs... " .. compareChar)
    end

    local finalName = ""

    for i = 1, #g_guildNamesTable do
        local comparing = g_guildNamesTable[i]
        if comparing.compareDisplay == compareChar or comparing.compareCharacter == compareChar then
            finalName = comparing.displayName
            break
        end
    end

    if finalName ~= "" then
        GuildRemove(guildnumber, finalName)
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK))
    end
end

function LUIE.SlashFriend(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME))
        return
    end
    LUIE.PrintToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG), option))
    RequestFriend(option)
end

function LUIE.SlashIgnore(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME))
        return
    end
    if IsIgnored(option) then -- Only lists account names, unfortunately
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE))
        return
    end
    AddIgnore(option)
end

function LUIE.SlashRemoveFriend(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME))
        return
    end

    local compareChar = string.lower(option)

    local friends = GetNumFriends()
    local g_friendIndex = {}
    for i = 1,friends do
        local displayName = GetFriendInfo(i)
        local _, characterName = GetFriendCharacterInfo(i)
        local compareDisplay = string.lower(displayName)
        local compareCharacter = string.lower(characterName)
        compareCharacter = string.gsub(compareCharacter,"%^%a+","")
        g_friendIndex[i] = {displayName=displayName, characterName=characterName, compareDisplay=compareDisplay, compareCharacter=compareCharacter}
    end

    local finalName = ""

    for i = 1, #g_friendIndex do
        local comparing = g_friendIndex[i]
        if comparing.compareDisplay == compareChar or comparing.compareCharacter == compareChar then
            finalName = comparing.displayName
            break
        end
    end

    if finalName ~= "" then
        RemoveFriend(finalName)
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_FAILED_NONAME))
    end
end

function LUIE.SlashRemoveIgnore(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE))
        return
    end

    local compareChar = string.lower(option)

    local ignore = GetNumIgnored()
    local g_ignoreIndex = {}
    for i = 1,ignore do
        local displayName = GetIgnoredInfo(i)
        displayName = string.lower(displayName)
        g_ignoreIndex[i] = {displayName=displayName}
    end

    local finalName = ""

    for i = 1,#g_ignoreIndex do
        local comparing = g_ignoreIndex[i]
        if comparing.displayName == compareChar then
            finalName = comparing.displayName
            break
        end
    end

    if finalName ~= "" then
        RemoveIgnore(option)
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE))
    end
end

function LUIE.SlashTrade(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME))
        return
    end

    TradeInviteByName(option)
end

function LUIE.SlashVoteKick(option)
    -- Check to make sure player is in a group
    if GetGroupSize() <= 1 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFG))
        return
    end
    
    -- Check to make sure we're not in LFG
    if not IsInLFGGroup() then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFG))
        return
    end

    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NONAME))
        return
    end

    local g_partyKick = { }
    local kickedMemberName
    local kickedAccountName
    local compareName = string.lower(option)
    local comparePlayerName = string.lower(playerName)
    local comparePlayerAccount = string.lower(playerAccountName)
    local unitToKick = ""

    for i = 1,24 do
        local memberTag = GetGroupUnitTagByIndex(i)
        -- Once we reach a nil value (aka no party member there, stop the loop)
        if memberTag == nil then
            break
        end
        kickedMemberName = string.lower(GetUnitName(memberTag))
        kickedAccountName = string.lower(GetUnitDisplayName(memberTag))
        g_partyKick[i] = { memberTag=memberTag, kickedMemberName=kickedMemberName, kickedAccountName=kickedAccountName }
    end

    -- Iterate through UnitTags to get the member who just joined
    for i = 1,#g_partyKick do
        local kickcompare = g_partyKick[i]
        if kickcompare.kickedMemberName == compareName or kickcompare.kickedAccountName == compareName then
            if kickcompare.kickedMemberName == comparePlayerName or kickcompare.kickedAccountName == comparePlayerAccount then
                unitToKick = kickcompare.memberTag
                break
            else
                unitToKick = kickcompare.memberTag
                break
            end
        end
    end

    BeginGroupElection(GROUP_ELECTION_TYPE_KICK_MEMBER, ZO_GROUP_ELECTION_DESCRIPTORS.NONE, unitToKick)
end

-- Slash Commands
-- Safe commands
SLASH_COMMANDS["/regroup"]      = LUIE.SlashRegroup
SLASH_COMMANDS["/disband"]      = LUIE.SlashDisband
SLASH_COMMANDS["/leave"]        = LUIE.SlashGroupLeave
SLASH_COMMANDS["/leavegroup"]   = LUIE.SlashGroupLeave
SLASH_COMMANDS["/kick"]         = LUIE.SlashGroupKick
SLASH_COMMANDS["/remove"]       = LUIE.SlashGroupKick
SLASH_COMMANDS["/groupkick"]    = LUIE.SlashGroupKick
SLASH_COMMANDS["/groupremove"]  = LUIE.SlashGroupKick
SLASH_COMMANDS["/home"]         = LUIE.SlashHome
SLASH_COMMANDS["/trade"]        = LUIE.SlashTrade
SLASH_COMMANDS["/votekick"]     = LUIE.SlashVoteKick
SLASH_COMMANDS["/voteremove"]   = LUIE.SlashVoteKick
SLASH_COMMANDS["/guildinvite"]  = LUIE.SlashGuildInvite
SLASH_COMMANDS["/guildquit"]    = LUIE.SlashGuildQuit
SLASH_COMMANDS["/guildkick"]    = LUIE.SlashGuildKick
SLASH_COMMANDS["/addfriend"]    = LUIE.SlashFriend
SLASH_COMMANDS["/friend"]       = LUIE.SlashFriend
SLASH_COMMANDS["/addignore"]    = LUIE.SlashIgnore
SLASH_COMMANDS["/ignore"]       = LUIE.SlashIgnore
SLASH_COMMANDS["/unfriend"]     = LUIE.SlashRemoveFriend
SLASH_COMMANDS["/removefriend"] = LUIE.SlashRemoveFriend
SLASH_COMMANDS["/unignore"]     = LUIE.SlashRemoveIgnore
SLASH_COMMANDS["/removeignore"] = LUIE.SlashRemoveIgnore

-- Hook initialization
EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, LUIE_OnAddOnLoaded)
