--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SlashCommands = LUIE.SlashCommands

local printToChat = LUIE.PrintToChat
local zo_strformat = zo_strformat

-- Slash Command to add someone to the friendslist
function SlashCommands.SlashFriend(option)
    if option == "" or option == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    ZO_Dialogs_ShowDialog("REQUEST_FRIEND", { name = option })
end

-- Slash Command to add someone to ignore list
function SlashCommands.SlashIgnore(option)
    if option == "" or option == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
    AddIgnore(option)
end

-- Slash Command to remove someone from friends list
function SlashCommands.SlashRemoveFriend(option)
    if option == "" or option == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
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
        printToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    end
end

-- Slash Command to remove a given name from the ignore list
function SlashCommands.SlashRemoveIgnore(option)
    if option == "" or option == nil then
        printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
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
        printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE), true)
        if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE)))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end
end
