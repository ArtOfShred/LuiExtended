--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- SlashCommands namespace
LUIE.SlashCommands = {}

local SC = LUIE.SlashCommands

local printToChat = LUIE.PrintToChat
local strformat = zo_strformat

local moduleName = LUIE.name .. "_SlashCommands"

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
SC.SV = nil

function SC.Initialize(enabled)
    -- Load Settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        SC.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, "SlashCommands", SC.D)
    else
        SC.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, "SlashCommands", SC.D)
    end

    if not enabled then
        return
    end
    SC.Enabled = true

    SC.RegisterSlashCommands()
end

function SC.RegisterSlashCommands()
    -- Clear commands list
    SLASH_COMMANDS["/home"]         = nil
    SLASH_COMMANDS["/regroup"]      = nil
    SLASH_COMMANDS["/disband"]      = nil
    SLASH_COMMANDS["/leave"]        = nil
    SLASH_COMMANDS["/leavegroup"]   = nil
    SLASH_COMMANDS["/kick"]         = SC.SlashKick -- This command is always registered since it is also a default emote
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
    SLASH_COMMANDS["/invite"]       = SC.SlashInvite -- This command is always registered since it is also a default command
    SLASH_COMMANDS["/bank"]         = nil
    SLASH_COMMANDS["/banker"]       = nil
    SLASH_COMMANDS["/sell"]         = nil
    SLASH_COMMANDS["/merchant"]     = nil
    SLASH_COMMANDS["/vendor"]       = nil
    SLASH_COMMANDS["/smuggler"]     = nil
    SLASH_COMMANDS["/fence"]        = nil
    SLASH_COMMANDS["/ready"]        = nil
    SLASH_COMMANDS["/readycheck"]   = SC.SlashReadyCheck -- This command is always registered since it is also a default command
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
        SLASH_COMMANDS["/home"]         = SC.SlashHome
    end
    if SC.SV.SlashTrade then
        SLASH_COMMANDS["/trade"]        = SC.SlashTrade
    end
    if SC.SV.SlashCampaignQ then
        SLASH_COMMANDS["/campaign"]     = SC.SlashCampaignQ
    end
    if SC.SV.SlashOutfit then
        SLASH_COMMANDS["/outfit"]       = SC.SlashOutfit
    end
    if SC.SV.SlashReport then
        SLASH_COMMANDS["/report"]       = SC.SlashReport
    end
    if SC.SV.SlashRegroup then
        SLASH_COMMANDS["/regroup"]      = SC.SlashRegroup
    end
    if SC.SV.SlashDisband then
        SLASH_COMMANDS["/disband"]      = SC.SlashDisband
    end
    if SC.SV.SlashGroupLeave then
        SLASH_COMMANDS["/leave"]        = SC.SlashGroupLeave
        SLASH_COMMANDS["/leavegroup"]   = SC.SlashGroupLeave
    end
    if SC.SV.SlashGroupKick then
        SLASH_COMMANDS["/remove"]       = SC.SlashGroupKick
        SLASH_COMMANDS["/groupkick"]    = SC.SlashGroupKick
        SLASH_COMMANDS["/groupremove"]  = SC.SlashGroupKick
    end
    if SC.SV.SlashVoteKick then
        SLASH_COMMANDS["/votekick"]     = SC.SlashVoteKick
        SLASH_COMMANDS["/voteremove"]   = SC.SlashVoteKick
    end
    if SC.SV.SlashReadyCheck then
        SLASH_COMMANDS["/ready"]        = SC.SlashReadyCheck
    end
    if SC.SV.SlashGuildInvite then
        SLASH_COMMANDS["/guildinvite"]  = SC.SlashGuildInvite
        SLASH_COMMANDS["/ginvite"]      = SC.SlashGuildInvite
    end
    if SC.SV.SlashGuildKick then
        SLASH_COMMANDS["/guildkick"]    = SC.SlashGuildKick
        SLASH_COMMANDS["/gkick"]        = SC.SlashGuildKick
    end
    if SC.SV.SlashGuildQuit then
        SLASH_COMMANDS["/guildquit"]    = SC.SlashGuildQuit
        SLASH_COMMANDS["/gquit"]        = SC.SlashGuildQuit
        SLASH_COMMANDS["/guildleave"]   = SC.SlashGuildQuit
        SLASH_COMMANDS["/gleave"]       = SC.SlashGuildQuit
    end
    if SC.SV.SlashFriend then
        SLASH_COMMANDS["/addfriend"]    = SC.SlashFriend
        SLASH_COMMANDS["/friend"]       = SC.SlashFriend
    end
    if SC.SV.SlashIgnore then
        SLASH_COMMANDS["/addignore"]    = SC.SlashIgnore
        SLASH_COMMANDS["/ignore"]       = SC.SlashIgnore
    end
    if SC.SV.SlashRemoveFriend then
        SLASH_COMMANDS["/unfriend"]     = SC.SlashRemoveFriend
        SLASH_COMMANDS["/removefriend"] = SC.SlashRemoveFriend
    end
    if SC.SV.SlashRemoveIgnore then
        SLASH_COMMANDS["/unignore"]     = SC.SlashRemoveIgnore
        SLASH_COMMANDS["/removeignore"] = SC.SlashRemoveIgnore
    end
    if SC.SV.SlashBanker then
        SLASH_COMMANDS["/bank"]         = function(...) SC.SlashCollectible(267) end
        SLASH_COMMANDS["/banker"]       = function(...) SC.SlashCollectible(267) end
    end
    if SC.SV.SlashMerchant then
        SLASH_COMMANDS["/sell"]         = function(...) SC.SlashCollectible(301) end
        SLASH_COMMANDS["/merchant"]     = function(...) SC.SlashCollectible(301) end
        SLASH_COMMANDS["/vendor"]       = function(...) SC.SlashCollectible(301) end
    end
    if SC.SV.SlashFence then
        SLASH_COMMANDS["/smuggler"]     = function(...) SC.SlashCollectible(300) end
        SLASH_COMMANDS["/fence"]        = function(...) SC.SlashCollectible(300) end
    end
    if SC.SV.SlashCake then
        SLASH_COMMANDS["/cake"]         = function(...) SC.SlashCollectible(5886) end
        SLASH_COMMANDS["/anniversary"]  = function(...) SC.SlashCollectible(5886) end
    end
    if SC.SV.SlashPie then
        SLASH_COMMANDS["/pie"]          = function(...) SC.SlashCollectible(1167) end
        SLASH_COMMANDS["/jester"]       = function(...) SC.SlashCollectible(1167) end
    end
    if SC.SV.SlashMead then
        SLASH_COMMANDS["/mead"]         = function(...) SC.SlashCollectible(1168) end
        SLASH_COMMANDS["/newlife"]      = function(...) SC.SlashCollectible(1168) end
    end
    if SC.SV.SlashWitch then
        SLASH_COMMANDS["/witch"]        = function(...) SC.SlashCollectible(479) end
        SLASH_COMMANDS["/witchfest"]    = function(...) SC.SlashCollectible(479) end
    end
end
