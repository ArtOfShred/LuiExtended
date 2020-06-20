--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- SlashCommands namespace
LUIE.SlashCommands = {}
local SlashCommands = LUIE.SlashCommands

local printToChat = LUIE.PrintToChat
local zo_strformat = zo_strformat

local moduleName = LUIE.name .. "SlashCommands"

SlashCommands.Enabled  = false
SlashCommands.Defaults = {
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
    SlashBankerChoice   = 1,
    SlashMerchant       = true,
    SlashMerchantChoice = 1,
    SlashFence          = true,
    SlashReadyCheck     = true,
    SlashOutfit         = true,
    SlashCake           = true,
    SlashPie            = true,
    SlashMead           = true,
    SlashWitch          = true,
    SlashReport         = true,
    SlashPet            = true,
    SlashPetMessage     = true,
}
SlashCommands.SV = nil

LUIE.LastMementoUsed            = 0 -- Set by the SlashCollectible function, passes this value to CA to display the Memento we used if a slash command is used
LUIE.SlashCollectibleOverride   = false -- Set by the SlashCollectible function, flags the CA function to display info on the collectible used even if the CA option are DISABLED.

function SlashCommands.Initialize(enabled)
    -- Load Settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        SlashCommands.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, "SlashCommands", SlashCommands.Defaults)
    else
        SlashCommands.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, "SlashCommands", SlashCommands.Defaults)
    end

    -- Disable module if setting not toggled on
    if not enabled then
        return
    end
    SlashCommands.Enabled = true

    SlashCommands.RegisterSlashCommands()
end

function SlashCommands.RegisterSlashCommands()

    -- Register commands that replace default functions
    SLASH_COMMANDS["/kick"]         = SlashCommands.SlashKick -- This command is always registered since it is also a default emote
    SLASH_COMMANDS["/invite"]       = SlashCommands.SlashInvite -- This command is always registered since it is also a default command
    SLASH_COMMANDS["/readycheck"]   = SlashCommands.SlashReadyCheck -- This command is always registered since it is also a default command

    -- Slash Commands are no longer set to nil when disabled to prevent interference with other addons that may add the same functionality. This list is preserved as an easy reference for all functions added.
    --SLASH_COMMANDS["/home"]         = nil
    --SLASH_COMMANDS["/regroup"]      = nil
    --SLASH_COMMANDS["/disband"]      = nil
    --SLASH_COMMANDS["/leave"]        = nil
    --SLASH_COMMANDS["/leavegroup"]   = nil
    --SLASH_COMMANDS["/remove"]       = nil
    --SLASH_COMMANDS["/groupkick"]    = nil
    --SLASH_COMMANDS["/groupremove"]  = nil
    --SLASH_COMMANDS["/trade"]        = nil
    --SLASH_COMMANDS["/votekick"]     = nil
    --SLASH_COMMANDS["/voteremove"]   = nil
    --SLASH_COMMANDS["/guildinvite"]  = nil
    --SLASH_COMMANDS["/ginvite"]      = nil
    --SLASH_COMMANDS["/guildkick"]    = nil
    --SLASH_COMMANDS["/gkick"]        = nil
    --SLASH_COMMANDS["/guildquit"]    = nil
    --SLASH_COMMANDS["/gquit"]        = nil
    --SLASH_COMMANDS["/guildleave"]   = nil
    --SLASH_COMMANDS["/gleave"]       = nil
    --SLASH_COMMANDS["/addfriend"]    = nil
    --SLASH_COMMANDS["/friend"]       = nil
    --SLASH_COMMANDS["/addignore"]    = nil
    --SLASH_COMMANDS["/ignore"]       = nil
    --SLASH_COMMANDS["/unfriend"]     = nil
    --SLASH_COMMANDS["/removefriend"] = nil
    --SLASH_COMMANDS["/unignore"]     = nil
    --SLASH_COMMANDS["/removeignore"] = nil
    --SLASH_COMMANDS["/campaign"]     = nil
    --SLASH_COMMANDS["/bank"]         = nil
    --SLASH_COMMANDS["/banker"]       = nil
    --SLASH_COMMANDS["/sell"]         = nil
    --SLASH_COMMANDS["/merchant"]     = nil
    --SLASH_COMMANDS["/vendor"]       = nil
    --SLASH_COMMANDS["/smuggler"]     = nil
    --SLASH_COMMANDS["/fence"]        = nil
    --SLASH_COMMANDS["/ready"]        = nil
    --SLASH_COMMANDS["/outfit"]       = nil
    --SLASH_COMMANDS["/cake"]         = nil
    --SLASH_COMMANDS["/anniversary"]  = nil
    --SLASH_COMMANDS["/pie"]          = nil
    --SLASH_COMMANDS["/jester"]       = nil
    --SLASH_COMMANDS["/mead"]         = nil
    --SLASH_COMMANDS["/newlife"]      = nil
    --SLASH_COMMANDS["/witch"]        = nil
    --SLASH_COMMANDS["/witchfest"]    = nil
    --SLASH_COMMANDS["/report"]       = nil
    CHAT_SYSTEM.textEntry.slashCommandAutoComplete:InvalidateSlashCommandCache()

    -- Add commands based off menu options
    if SlashCommands.SV.SlashHome then
        SLASH_COMMANDS["/home"]         = SlashCommands.SlashHome
    end
    if SlashCommands.SV.SlashTrade then
        SLASH_COMMANDS["/trade"]        = SlashCommands.SlashTrade
    end
    if SlashCommands.SV.SlashCampaignQ then
        SLASH_COMMANDS["/campaign"]     = SlashCommands.SlashCampaignQ
    end
    if SlashCommands.SV.SlashOutfit then
        SLASH_COMMANDS["/outfit"]       = SlashCommands.SlashOutfit
    end
    if SlashCommands.SV.SlashReport then
        SLASH_COMMANDS["/report"]       = SlashCommands.SlashReport
    end
    if SlashCommands.SV.SlashRegroup then
        SLASH_COMMANDS["/regroup"]      = SlashCommands.SlashRegroup
    end
    if SlashCommands.SV.SlashDisband then
        SLASH_COMMANDS["/disband"]      = SlashCommands.SlashDisband
    end
    if SlashCommands.SV.SlashGroupLeave then
        SLASH_COMMANDS["/leave"]        = SlashCommands.SlashGroupLeave
        SLASH_COMMANDS["/leavegroup"]   = SlashCommands.SlashGroupLeave
    end
    if SlashCommands.SV.SlashGroupKick then
        SLASH_COMMANDS["/remove"]       = SlashCommands.SlashGroupKick
        SLASH_COMMANDS["/groupkick"]    = SlashCommands.SlashGroupKick
        SLASH_COMMANDS["/groupremove"]  = SlashCommands.SlashGroupKick
    end
    if SlashCommands.SV.SlashVoteKick then
        SLASH_COMMANDS["/votekick"]     = SlashCommands.SlashVoteKick
        SLASH_COMMANDS["/voteremove"]   = SlashCommands.SlashVoteKick
    end
    if SlashCommands.SV.SlashReadyCheck then
        SLASH_COMMANDS["/ready"]        = SlashCommands.SlashReadyCheck
    end
    if SlashCommands.SV.SlashGuildInvite then
        SLASH_COMMANDS["/guildinvite"]  = SlashCommands.SlashGuildInvite
        SLASH_COMMANDS["/ginvite"]      = SlashCommands.SlashGuildInvite
    end
    if SlashCommands.SV.SlashGuildKick then
        SLASH_COMMANDS["/guildkick"]    = SlashCommands.SlashGuildKick
        SLASH_COMMANDS["/gkick"]        = SlashCommands.SlashGuildKick
    end
    if SlashCommands.SV.SlashGuildQuit then
        SLASH_COMMANDS["/guildquit"]    = SlashCommands.SlashGuildQuit
        SLASH_COMMANDS["/gquit"]        = SlashCommands.SlashGuildQuit
        SLASH_COMMANDS["/guildleave"]   = SlashCommands.SlashGuildQuit
        SLASH_COMMANDS["/gleave"]       = SlashCommands.SlashGuildQuit
    end
    if SlashCommands.SV.SlashFriend then
        SLASH_COMMANDS["/addfriend"]    = SlashCommands.SlashFriend
        SLASH_COMMANDS["/friend"]       = SlashCommands.SlashFriend
    end
    if SlashCommands.SV.SlashIgnore then
        SLASH_COMMANDS["/addignore"]    = SlashCommands.SlashIgnore
        SLASH_COMMANDS["/ignore"]       = SlashCommands.SlashIgnore
    end
    if SlashCommands.SV.SlashRemoveFriend then
        SLASH_COMMANDS["/unfriend"]     = SlashCommands.SlashRemoveFriend
        SLASH_COMMANDS["/removefriend"] = SlashCommands.SlashRemoveFriend
    end
    if SlashCommands.SV.SlashRemoveIgnore then
        SLASH_COMMANDS["/unignore"]     = SlashCommands.SlashRemoveIgnore
        SLASH_COMMANDS["/removeignore"] = SlashCommands.SlashRemoveIgnore
    end
    if SlashCommands.SV.SlashBanker then
        SLASH_COMMANDS["/bank"]         = function(...) SlashCommands.SlashCollectible("banker") end
        SLASH_COMMANDS["/banker"]       = function(...) SlashCommands.SlashCollectible("banker") end
    end
    if SlashCommands.SV.SlashMerchant then
        SLASH_COMMANDS["/sell"]         = function(...) SlashCommands.SlashCollectible("merchant") end
        SLASH_COMMANDS["/merchant"]     = function(...) SlashCommands.SlashCollectible("merchant") end
        SLASH_COMMANDS["/vendor"]       = function(...) SlashCommands.SlashCollectible("merchant") end
    end
    if SlashCommands.SV.SlashFence then
        SLASH_COMMANDS["/smuggler"]     = function(...) SlashCommands.SlashCollectible(300) end
        SLASH_COMMANDS["/fence"]        = function(...) SlashCommands.SlashCollectible(300) end
    end
    if SlashCommands.SV.SlashPet then
        SLASH_COMMANDS["/pet"]         = SlashCommands.SlashPet
        SLASH_COMMANDS["/pets"]        = SlashCommands.SlashPet
        SLASH_COMMANDS["/dismisspet"]  = SlashCommands.SlashPet
        SLASH_COMMANDS["/dismisspets"] = SlashCommands.SlashPet
    end
    if SlashCommands.SV.SlashCake then
        SLASH_COMMANDS["/cake"]         = function(...) SlashCommands.SlashCollectible(7619) end
        SLASH_COMMANDS["/anniversary"]  = function(...) SlashCommands.SlashCollectible(7619) end
    end
    if SlashCommands.SV.SlashPie then
        SLASH_COMMANDS["/pie"]          = function(...) SlashCommands.SlashCollectible(1167) end
        SLASH_COMMANDS["/jester"]       = function(...) SlashCommands.SlashCollectible(1167) end
    end
    if SlashCommands.SV.SlashMead then
        SLASH_COMMANDS["/mead"]         = function(...) SlashCommands.SlashCollectible(1168) end
        SLASH_COMMANDS["/newlife"]      = function(...) SlashCommands.SlashCollectible(1168) end
    end
    if SlashCommands.SV.SlashWitch then
        SLASH_COMMANDS["/witch"]        = function(...) SlashCommands.SlashCollectible(479) end
        SLASH_COMMANDS["/witchfest"]    = function(...) SlashCommands.SlashCollectible(479) end
    end
end
