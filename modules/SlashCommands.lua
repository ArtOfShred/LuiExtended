-- SlashCommands namespace
LUIE.SlashCommands = {}

-- Performance Enhancement
local SC            = LUIE.SlashCommands
local printToChat   = LUIE.PrintToChat
local strformat     = zo_strformat
local strgsub       = string.gsub
local strlower      = string.lower
local strmatch      = string.match
local pairs         = pairs

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
    SlashGuildQuit      = true,
    SlashGuildKick      = true,
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
}
SC.SV       = nil

local g_regroupStacks   = {}
local PendingRegroup    = false

function SC.Initialize( enabled )
    SC.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "SlashCommands", SC.D )

    if not enabled then
        return
    end
    SC.Enabled = true

    SC.RegisterSlashCommands()
end

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

local function RegroupInvite()
    printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_MSG), true)
    if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
        callAlert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_MSG) )
    end
    for i = 1, #g_regroupStacks do
        local member = g_regroupStacks[i]
        -- Don't invite self and offline members
        if member.memberName ~= LUIE.PlayerNameFormatted then
            GroupInviteByName(member.memberName)
            printToChat(strformat(GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG), member.memberLink), true)
            if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
                callAlert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG), member.memberNoLink) )
            end
        end
    end
    PendingRegroup = false -- Allow Regroup command to be used again
    g_regroupStacks = {} -- Allow index to be used again.
end

function LUIE.SlashRegroup()
    local groupSize = GetGroupSize()
    -- Check for pending regroup
    if PendingRegroup then
        printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_PENDING), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_PENDING)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure player is in a group
    if groupSize <= 1 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTINGRP), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTINGRP)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in a battleground
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_BG), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in LFG
    if IsInLFGGroup() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_LFGACTIVITY), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_LFGACTIVITY)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTLEADER), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTLEADER)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    PendingRegroup = true

    local flagOffline = 0
    local index = 1
    for i = 1, groupSize do
        -- We need to index player here as well
        local memberTag = GetGroupUnitTagByIndex(i)
        if IsUnitOnline(memberTag) then
            local groupMemberString
            local groupMemberName = GetUnitName(memberTag)
            local groupMemberAccountName = GetUnitDisplayName(memberTag)
            local memberLink = LUIE.ChatAnnouncements.ResolveNameLink(groupMemberName, groupMemberAccountName)
            local memberNoLink = LUIE.ChatAnnouncements.ResolveNameNoLink(groupMemberName, groupMemberAccountName)

            -- Place inside counter incremented index, this way if we have offline members in the group we still index everything in an ordered integer list.
            g_regroupStacks[index] = { memberLink = memberLink, memberName = groupMemberName }
            index = index + 1
        else
            flagOffline = flagOffline + 1
        end
    end

    -- Reinvite the group after 5 seconds (give the group interface time to update on server and client end for all group members)
    -- If the stack counter was less than 1 (just the player eligible for reinvite then regroup won't invite any members.)
    if flagOffline > 0 then
        if #g_regroupStacks > 1 then
            printToChat(strformat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_SOME_OFF_MSG), flagOffline, flagOffline, flagOffline), true)
            if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
                callAlert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_SOME_OFF_MSG), flagOffline, flagOffline, flagOffline) )
            end
            GroupDisband()
            callLater(RegroupInvite, 5000)
        else
            printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_ALL_OFF_MSG), true)
            if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
                callAlert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_ALL_OFF_MSG) )
            end
            PendingRegroup = false -- Allow Regroup command to be used again
            g_regroupStacks = {} -- Allow index to be used again.
        end
    else
        printToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_MSG), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_MSG) )
        end
        GroupDisband()
        callLater(RegroupInvite, 5000)
    end
end

local function SlashDisband()
    local groupSize = GetGroupSize()
    -- Check to make sure player is in a group
    if groupSize <= 1 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_NOGROUP), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_NOGROUP)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        printToChat(GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_NOTLEADER), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_NOTLEADER)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure player is not in a BG
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_BG), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in LFG
    local isLFG = IsInLFGGroup()
    if isLFG then
        printToChat(GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_LFG_ACTIVITY), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_LFG_ACTIVITY)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    GroupDisband()
end

local function SlashGroupLeave()
    -- EVENT_GROUP_NOTIFICATION_MESSAGE hook handles response to this.
    GroupLeave()
end

local function SlashKick(option)
    -- If the player uses /kick with no option then we need to play the kick emote, otherwise handle everything with the SlashGroupKick function.
    if option == "" or not SC.SV.SlashGroupKick then
        PlayEmoteByIndex(109)
    else
        SlashGroupKick(option)
    end
end

local function SlashGroupKick(option)
    local groupSize = GetGroupSize()
    -- Rather then error out, let the player use /kick and /remove as a substitute for /votekick and /voteremove in LFG
    if IsInLFGGroup() then
        if option == "" then
            printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME), true)
            if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
                callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME)))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            return
        else
            if SC.SV.SlashVoteKick then
                SlashVoteKick(option)
            else
                printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_LFG), true)
                if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
                    callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_LFG)))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            end
            return
        end
    end

    -- Check to make sure player is in a group
    if groupSize <= 1 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOGROUP), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOGROUP)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        printToChat(GetString(SI_LUIE_CA_GROUP_LEADERKICK_ERROR), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_CA_GROUP_LEADERKICK_ERROR)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local g_partyKick = { }
    local kickedMemberName
    local kickedAccountName
    local compareName = strlower(option)
    local comparePlayerName = strlower(LUIE.PlayerNameFormatted)
    local comparePlayerAccount = strlower(PlayerDisplayName)
    local unitToKick

    for i = 1,24 do
        local memberTag = GetGroupUnitTagByIndex(i)
        -- Once we reach a nil value (aka no party member there, stop the loop)
        if memberTag == nil then
            break
        end
        kickedMemberName = strlower(GetUnitName(memberTag))
        kickedAccountName = strlower(GetUnitDisplayName(memberTag))
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
                GroupKick(unitToKick)
            end
            return
        end
    end

    printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME), true)
    if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
        callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME)))
    end
    PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
end

local function SlashGuildInvite(option)
    -- If no input was entered, display an error and end.
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Parse input
    local options = {}
    local searchResult = { strmatch(option,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
        if (v ~= nil and v ~= "") then
            options[i] = v
        end
    end

    local guildnumber = options[1]
    local name = options[2]

    -- If no name was entered, display an error and end.
    if guildnumber == nil or name == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
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
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV)))
        end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    --GuildInvite(guildnumber, name)
    ZO_TryGuildInvite(guildnumber, name, true)
end

local function SlashGuildQuit(guildnumber)
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
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- If we try to leave a guild we don't have display an error and end.
    if guildnumber == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- If neither of the above errors were triggered, leave the guild number.
    GuildLeave(guildnumber)
end

local function SlashGuildKick(option)
    -- If no input was entered, display an error and end.
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Parse input
    local options = {}
    local searchResult = { strmatch(option,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
        if (v ~= nil and v ~= "") then
            options[i] = v
        end
    end

    local guildnumber = options[1]
    local name = options[2]

    -- If no name was entered, display an error and end.
    if guildnumber == nil or name == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
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
    -- If we enter anything outside of the range of 1-5, display an error and end.
    else
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    if not DoesPlayerHaveGuildPermission (guildnumber, GUILD_PERMISSION_REMOVE) then
        printToChat (GetString(SI_SOCIALACTIONRESULT18), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_SOCIALACTIONRESULT18)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Index guild members so we can use character name as a kick option
    local guildNumbers = GetNumGuildMembers(guildnumber)
    local compareChar = strlower(name)

    g_guildNamesTable = { }

    for i = 1,guildNumbers do
        local displayName = GetGuildMemberInfo(guildnumber, i)
        local _, characterName = GetGuildMemberCharacterInfo(guildnumber, i)
        local compareDisplay = strlower(displayName)
        local compareCharacter = strlower(characterName)

        compareCharacter = strgsub(compareCharacter,"%^%a+","")

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
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME_GUILD), true)
        if LUIE.ChatAnnouncements.SV.Social.GuildAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME_GUILD)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    end
end

local function SlashFriend(option)
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    RequestFriend(option)
end

-- Hook for request friend so menu option also displays invite message
-- Menu is true if this request is sent from the Player to Player interaction menu
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

local function SlashIgnore(option)
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    AddIgnore(option)
end

local function SlashRemoveFriend(option)
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local compareChar = strlower(option)
    local friends = GetNumFriends()
    local g_friendIndex = {}
    for i = 1,friends do
        local displayName = GetFriendInfo(i)
        local _, characterName = GetFriendCharacterInfo(i)
        local compareDisplay = strlower(displayName)
        local compareCharacter = strlower(characterName)
        compareCharacter = strgsub(compareCharacter,"%^%a+","")
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
        printToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    end
end

local function SlashRemoveIgnore(option)
    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local compareChar = strlower(option)
    local ignore = GetNumIgnored()
    local g_ignoreIndex = {}
    for i = 1,ignore do
        local displayName = GetIgnoredInfo(i)
        displayName = strlower(displayName)
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
        printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
end

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

local function SlashVoteKick(option)
    local groupSize = GetGroupSize()
    -- Check to make sure player is in a group
    if groupSize <= 1 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFGKICK), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupLFGAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFGKICK)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    -- Check to make sure we're not in a battleground
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_BG), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupLFGAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in LFG
    if not IsInLFGGroup() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFGKICK), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupLFGAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFGKICK)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    if option == "" then
        printToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupLFGAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local g_partyKick = { }
    local kickedMemberName
    local kickedAccountName
    local compareName = strlower(option)
    local comparePlayerName = strlower(playerName)
    local comparePlayerAccount = strlower(PlayerDisplayName)
    local unitToKick = ""

    for i = 1,24 do
        local memberTag = GetGroupUnitTagByIndex(i)
        -- Once we reach a nil value (aka no party member there, stop the loop)
        if memberTag == nil then
            break
        end
        kickedMemberName = strlower(GetUnitName(memberTag))
        kickedAccountName = strlower(GetUnitDisplayName(memberTag))
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

    -- If we try to kick ourself then display an error message.
    if GetUnitName(unitToKick) == playerName then
        printToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_SELF), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupLFGAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_SELF)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    BeginGroupElection(GROUP_ELECTION_TYPE_KICK_MEMBER, ZO_GROUP_ELECTION_DESCRIPTORS.NONE, unitToKick)
    -- EVENT HANDLER takes care of the error messages here.
end

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
        local compareName = strlower(GetCampaignName(i))
        local option = strlower(option)
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

local function SlashInvite(option)
    local groupSize = GetGroupSize()

    if groupSize > 1 and not IsUnitGroupLeader("player") then
        printToChat(strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE)), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    if option == "" then
        printToChat(GetString(SI_LUIE_CA_GROUP_INVITE_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_CA_GROUP_INVITE_NONAME))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    GroupInviteByName(option)
    printToChat(strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_INVITED), option), true)
    if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
        callAlert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_INVITED), option))
    end
end

-- Summon/Unsummon assistants based on their collectible id
function LUIE.SlashAssistant(id)
    local assistant = id
    -- Check to make sure we're not in Cyrodiil
    if IsPlayerInAvAWorld() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_ASSISTANT_FAILED_AVA), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_ASSISTANT_FAILED_AVA)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure we're not in a battleground
    if IsActiveWorldBattleground() then
        printToChat(GetString(SI_LUIE_SLASHCMDS_ASSISTANT_FAILED_BG), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_ASSISTANT_FAILED_BG)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Check to make sure that we have the Assistant unlocked
    if IsCollectibleUnlocked(assistant) then
        -- Summon/Unsummon the Assistant
        UseCollectible(assistant)
    else
        printToChat(strformat(GetString(SI_LUIE_SLASHCMDS_ASSISTANT_FAILED_NOTUNLOCKED), GetCollectibleName(assistant)), true)
        if LUIE.SV.TempAlertHome then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_ASSISTANT_FAILED_NOTUNLOCKED)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
end

function LUIE.SlashReadyCheck()
    local groupSize = GetGroupSize()
    -- Check to make sure player is in a group
    if groupSize <= 1 then
        printToChat(GetString(SI_LUIE_SLASHCMDS_READYCHECK_FAILED_NOTINGRP), true)
        if LUIE.ChatAnnouncements.SV.Group.GroupAlert then
            callAlert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_READYCHECK_FAILED_NOTINGRP)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    -- Send a ready check to group members
    ZO_SendReadyCheck()
end

function SC.RegisterSlashCommands()
    -- Clear commands list
    SLASH_COMMANDS["/home"]         = nil
    SLASH_COMMANDS["/regroup"]      = nil
    SLASH_COMMANDS["/disband"]      = nil
    SLASH_COMMANDS["/leave"]        = nil
    SLASH_COMMANDS["/leavegroup"]   = nil
    SLASH_COMMANDS["/kick"]         = SlashKick -- This command is always registered since it is also a default emote
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
    SLASH_COMMANDS["/invite"]       = SlashInvite -- This command is always registered since it is also a default command
    SLASH_COMMANDS["/bank"]         = nil
    SLASH_COMMANDS["/banker"]       = nil
    SLASH_COMMANDS["/sell"]         = nil
    SLASH_COMMANDS["/merchant"]     = nil
    SLASH_COMMANDS["/vendor"]       = nil
    SLASH_COMMANDS["/smuggler"]     = nil
    SLASH_COMMANDS["/fence"]        = nil
    SLASH_COMMANDS["/ready"]        = nil
    SLASH_COMMANDS["/readycheck"]   = nil
    SLASH_COMMAND_AUTO_COMPLETE:InvalidateSlashCommandCache()

    -- Add commands based off menu options
    if SC.SV.SlashHome then
        SLASH_COMMANDS["/home"]         = LUIE.SlashHome
    end
    if SC.SV.SlashRegroup then
        SLASH_COMMANDS["/regroup"]      = LUIE.SlashRegroup
    end
    if SC.SV.SlashDisband then
        SLASH_COMMANDS["/disband"]      = SlashDisband
    end
    if SC.SV.SlashGroupLeave then
        SLASH_COMMANDS["/leave"]        = SlashGroupLeave
        SLASH_COMMANDS["/leavegroup"]   = SlashGroupLeave
    end
    if SC.SV.SlashGroupKick then
        SLASH_COMMANDS["/remove"]       = SlashGroupKick
        SLASH_COMMANDS["/groupkick"]    = SlashGroupKick
        SLASH_COMMANDS["/groupremove"]  = SlashGroupKick
    end
    if SC.SV.SlashTrade then
        SLASH_COMMANDS["/trade"]        = SlashTrade
    end
    if SC.SV.SlashVoteKick then
        SLASH_COMMANDS["/votekick"]     = SlashVoteKick
        SLASH_COMMANDS["/voteremove"]   = SlashVoteKick
    end
    if SC.SV.SlashGuildInvite then
        SLASH_COMMANDS["/guildinvite"]  = SlashGuildInvite
        SLASH_COMMANDS["/ginvite"]      = SlashGuildInvite
    end
    if SC.SV.SlashGuildKick then
        SLASH_COMMANDS["/guildkick"]    = SlashGuildKick
        SLASH_COMMANDS["/gkick"]        = SlashGuildKick
    end
    if SC.SV.SlashGuildQuit then
        SLASH_COMMANDS["/guildquit"]    = SlashGuildQuit
        SLASH_COMMANDS["/gquit"]        = SlashGuildQuit
        SLASH_COMMANDS["/guildleave"]   = SlashGuildQuit
        SLASH_COMMANDS["/gleave"]       = SlashGuildQuit
    end
    if SC.SV.SlashFriend then
        SLASH_COMMANDS["/addfriend"]    = SlashFriend
        SLASH_COMMANDS["/friend"]       = SlashFriend
    end
    if SC.SV.SlashIgnore then
        SLASH_COMMANDS["/addignore"]    = SlashIgnore
        SLASH_COMMANDS["/ignore"]       = SlashIgnore
    end
    if SC.SV.SlashRemoveFriend then
        SLASH_COMMANDS["/unfriend"]     = SlashRemoveFriend
        SLASH_COMMANDS["/removefriend"] = SlashRemoveFriend
    end
    if SC.SV.SlashRemoveIgnore then
        SLASH_COMMANDS["/unignore"]     = SlashRemoveIgnore
        SLASH_COMMANDS["/removeignore"] = SlashRemoveIgnore
    end
    if SC.SV.SlashCampaignQ then
        SLASH_COMMANDS["/campaign"]     = SlashCampaignQ
    end
    if SC.SV.SlashBanker then
        SLASH_COMMANDS["/bank"]         = function(...) LUIE.SlashAssistant(267) end
        SLASH_COMMANDS["/banker"]       = function(...) LUIE.SlashAssistant(267) end
    end
    if SC.SV.SlashMerchant then
        SLASH_COMMANDS["/sell"]         = function(...) LUIE.SlashAssistant(301) end
        SLASH_COMMANDS["/merchant"]     = function(...) LUIE.SlashAssistant(301) end
        SLASH_COMMANDS["/vendor"]       = function(...) LUIE.SlashAssistant(301) end
    end
    if SC.SV.SlashFence then
        SLASH_COMMANDS["/smuggler"]     = function(...) LUIE.SlashAssistant(300) end
        SLASH_COMMANDS["/fence"]        = function(...) LUIE.SlashAssistant(300) end
    end
    if SC.SV.SlashReadyCheck then
        SLASH_COMMANDS["/ready"]        = LUIE.SlashReadyCheck
        SLASH_COMMANDS["/readycheck"]   = LUIE.SlashReadyCheck
    end
end
