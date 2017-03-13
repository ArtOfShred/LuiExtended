------------------
-- ChatAnnouncements namespace
LUIE.ChatAnnouncements = {}

-- Performance Enhancement
local CA             = LUIE.ChatAnnouncements
local E              = LUIE.Effects
local printToChat    = LUIE.PrintToChat
local strformat      = zo_strformat
local strfmt         = string.format
local gsub           = string.gsub

local moduleName     = LUIE.name .. '_ChatAnnouncements'

CA.Enabled = false
CA.D = {
    AchievementCategory1          = true,
    AchievementCategory2          = true,
    AchievementCategory3          = true,
    AchievementCategory4          = true,
    AchievementCategory5          = true,
    AchievementCategory6          = true,
    AchievementCategory7          = true,
    AchievementCategory8          = true,
    AchievementCategory9          = true,
    AchievementCategory10         = true,
    AchievementCategory11         = true,
    AchievementCategory12         = true,
    Achievements                  = false,
    AchievementsDetails           = true,
    AchievementsStep              = 10,
    AlliancePointChange           = true,
    AlliancePointColor            = { 0.164706, 0.862745, 0.133333, 1 },
    AlliancePointFilter           = 0,
    AlliancePointName             = GetString(SI_CURRENCY_ALLIANCE_POINTS), -- "Alliance Points"
    ChangeColorUp                 = { 0.043137, 0.380392, 0.043137, 1 },
    ChangeColorDown               = { 0.7, 0, 0, 1 },
    ChatPlayerDisplayOptions      = 2,
    CurrencyBracketDisplayOptions = 1,
    CurrencyContextMessageDown    = "",
    CurrencyContextMessageUp      = "",
    CurrencyContextToggle         = false,
    CurrencyIcons                 = true,
    CurrencyTotalMessage          = GetString(SI_LUIE_CA_DEFAULTVARS_CURRENCYTOTALMESSAGE),
    CustomStrings                 = false,
    Experience                    = true,
    ExperienceColorLevel          = true,
    ExperienceContextName         = GetString(SI_LUIE_CA_DEFAULTVARS_EXPERIENCECONTEXTNAME),
    ExperienceDisplayOptions      = 1,
    ExperienceFilter              = 0,
    ExperienceHideCombat          = false,
    ExperienceIcon                = true,
    ExperienceLevelUp             = true,
    ExperienceName                = "XP",
    ExperienceProgressColor       = true,
    ExperienceProgressName        = GetString(SI_LUIE_CA_DEFAULTVARS_EXPERIENCEPROGRESSNAME),
    ExperienceShowDecimal         = true,
    ExperienceShowLevel           = true,
    ExperienceShowPBrackets       = true,
    ExperienceShowProgress        = true,
    ExperienceThrottle            = 0,
    GoldChange                    = true,
    GoldHideAHSpent               = false,
    GoldColor                     = { 1, 1, 0.2, 1 },
    GoldName                      = GetString(SI_CURRENCY_GOLD), -- "Gold"
    GroupChatMsg                  = false,
    GuildRankDisplayOptions       = 1,
    ItemBracketDisplayOptions     = 1,
    ItemContextMessage            = "",
    ItemContextToggle             = false,
    LevelUpIcon                   = true,
    Loot                          = true,
    LootBank                      = true,
    LootBlacklist                 = false,
    LootCollectible               = false,
    LootCollectibleColor          = { 0, 1, 1, 1 },
    LootCraft                     = true,
    LootCurrencyCombo             = false,
    LootGroup                     = true,
    LootIcons                     = true,
    LootMail                      = true,
    LootNotTrash                  = true,
    LootOnlyNotable               = false,
    LootShowArmorType             = false,
    LootShowStyle                 = false,
    LootShowTrait                 = true,
    LootTrade                     = true,
    LootVendor                    = true,
    MiscBags                      = false,
    MiscConfiscate                = false,
    MiscDuel                      = false,
    MiscGuild                     = false,
    MiscGuildIcon                 = false,
    MiscGuildMOTD                 = false,
    MiscGuildRank                 = false,
    MiscHorse                     = false,
    MiscLockpick                  = false,
    MiscMara                      = true,
    MiscMail                      = false,
    MiscSocial                    = false,
    MiscTrade                     = false,
    MiscDisguise                  = true,
    MiscDisguiseAlert             = false,
    ShowConfiscate                = false,
    ShowCraftUse                  = false,
    ShowDestroy                   = false,
    ShowDisguise                  = false,
    TelVarStoneChange             = true,
    TelVarStoneColor              = { 0.368627, 0.643137, 1, 1 },
    TelVarStoneName               = GetString(SI_CURRENCY_TELVAR_STONES), -- "Tel Var Stones"
    TotalAlliancePointChange      = false,
    TotalGoldChange               = false,
    TotalTelVarStoneChange        = false,
    TotalWritVoucherChange        = false,
    WritVoucherChange             = true,
    WritVoucherColor              = { 1, 1, 1, 1 },
    WritVoucherName               = GetString(SI_CURRENCY_WRIT_VOUCHERS), -- "Writ Vouchers"
}

local g_currentDisguise
local g_disguiseState
local g_bankStacks                = {} -- Called for indexing on opening crafting window (If the player decons an item from the bank - not needed for bank, since we don't care about items in the bank)
local g_CP_BAR_COLORS             = ZO_CP_BAR_GRADIENT_COLORS -- Color for Champion Levels
local g_equippedStacks            = {} -- Called for indexing on init
local g_inventoryStacks           = {} -- Called for indexing on init
local g_JusticeStacks             = {} -- Filled during justice confiscation to compare item changes
local g_XPCombatBufferString      = ""
local g_XPCombatBufferValue       = 0
local g_XP_BAR_COLORS             = ZO_XP_BAR_GRADIENT_COLORS[2] -- Color for Normal Levels
local g_comboString               = "" -- String is filled by the EVENT_CURRENCY_CHANGE events and amended onto the end of purchase/sales from LootLog component if toggled on!
local g_craftStacks               = {}
local g_areWeGrouped              = false
local g_stopGroupLeaveQueue       = false
local g_fixJoinMessage            = false
local g_groupFormFudger           = false
local g_groupJoinFudger           = false -- Controls message for group join
local g_joinLFGOverride           = false
local g_leaveLFGOverride          = false
local g_guildBankCarryGainorloss  = ""
local g_guildBankCarryIcon        = ""
local g_guildBankCarryItemLink    = ""
local g_guildBankCarryItemType    = ""
local g_guildBankCarryLogPrefix   = ""
local g_guildBankCarryReceivedBy  = ""
local g_guildBankCarryStackCount  = 1
local g_guildJoinFudger           = false
local g_guildRankData             = {} -- Variable to store local player guild ranks, for guild rank changes.
local g_isValidLaunder            = false
local g_itemString1Gain           = ""
local g_itemString2Gain           = ""
local g_itemString1Loss           = ""
local g_itemString2Loss           = ""
local g_itemWasDestroyed          = false
local g_lastPercentage            = {} -- Here we will store last displayed percentage for achievement
local g_launderCheck              = false
local g_launderGoldstring         = ""
local g_launderItemstring         = ""
local g_mailCOD                   = 0
local g_mailCurrencyCheck         = true
local g_mailMoney                 = 0
local g_mailStacks                = {}
local g_mailStacksOut             = {}
local g_mailStop                  = false
local g_mailStringPart1           = ""
local g_oldItemLink               = ""
local g_playerName                = nil
local g_playerNameFormatted       = nil
local g_postageAmount             = 0
local g_QuestShareFudger          = false
local g_showActivityStatus        = true
local g_showRCUpdates             = true
local g_showStatusDropMember      = false
local g_stealString               = ""
local g_weAreQueued               = false -- Variable to determine if we are in queue, if the player isn't in queue ACTIVITY_FINDER_STATUS_NONE is broadcast on init, we don't want this to show any event!

-- When quest XP is gained during dialogue the player doesn't actually level up until exiting the dialogue.
-- The variables get stored and saved to print on levelup if this is the case.
local g_weLeveled                 = 0
local g_crossover                 = 0

-- Various fudge variables required for fixing display on levelup when turning in quests that give both XP completion and POI completion!
local g_levelCarryOverValue       = 0
local g_levelChanged1             = false
local g_questCombiner1            = ""
local g_questCombiner2            = ""
local g_questCombiner2Alt         = ""
local g_questString1              = ""
local g_questString2              = ""
local g_totalLevelAdjust          = ""

-- Variables used for Trade Functions
local g_tradeInvitee              = ""
local g_tradeInviter              = ""
local g_tradeStacksIn             = {}
local g_tradeStacksOut            = {}
local g_tradeString1              = ""
local g_tradeString2              = ""

-- Colorize values (We don't define here, just when the call needs to be made)
local ChangeUpColorize
local ChangeDownColorize
local GoldColorize
local APColorize
local TVColorize
local WVColorize

function CA.Initialize(enabled)
    -- Load settings
    CA.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "ChatAnnouncements", CA.D )

    -- Disable if setting not toggled on
    if not enabled then
        return
    end

    CA.Enabled = true

    -- Read current player toon name
    g_playerName = GetRawUnitName("player")
    g_playerNameFormatted = strformat(SI_UNIT_NAME, GetUnitName("player"))
    g_playerDisplayName = strformat(SI_UNIT_NAME, GetUnitDisplayName("player"))

    -- Register events
    CA.RegisterGroupEvents()
    CA.RegisterGoldEvents()
    CA.RegisterAlliancePointEvents()
    CA.RegisterTelVarStoneEvents()
    CA.RegisterWritVoucherEvents()
    CA.RegisterLootEvents()
    CA.RegisterVendorEvents()
    CA.RegisterBankEvents()
    CA.RegisterTradeEvents()
    CA.RegisterMailEvents()
    CA.RegisterCraftEvents()
    CA.RegisterDestroyEvents()
    CA.RegisterXPEvents()
    CA.RegisterAchievementsEvent()
    CA.RegisterBagEvents()
    CA.RegisterLockpickEvents()
    CA.RegisterHorseEvents()
    CA.RegisterGuildEvents()
    CA.RegisterSocialEvents()
    CA.RegisterCustomStrings()
    CA.RegisterDuelEvents()
    CA.RegisterDisguiseEvents()
    CA.RegisterMaraEvents()
    CA.RegisterCollectibleEvents()
    CA.RegisterColorEvents()

end

function CA.RegisterColorEvents()
    ChangeUpColorize = ZO_ColorDef:New(unpack(CA.SV.ChangeColorUp))
    ChangeDownColorize = ZO_ColorDef:New(unpack(CA.SV.ChangeColorDown))
    CollectibleColorize = ZO_ColorDef:New(unpack(CA.SV.LootCollectibleColor))
    GoldColorize = ZO_ColorDef:New(unpack(CA.SV.GoldColor))
    APColorize = ZO_ColorDef:New(unpack(CA.SV.AlliancePointColor))
    TVColorize = ZO_ColorDef:New(unpack(CA.SV.TelVarStoneColor))
    WVColorize = ZO_ColorDef:New(unpack(CA.SV.WritVoucherColor))
end

function CA.RegisterCollectibleEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_COLLECTIBLE_NOTIFICATION_NEW)
    if CA.SV.LootCollectible then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COLLECTIBLE_NOTIFICATION_NEW, CA.NewCollectible)
    end
end

function CA.RegisterSocialEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_FRIEND_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_FRIEND_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_SHARED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_SHARE_REMOVED)
    if CA.SV.MiscSocial then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_FRIEND_ADDED, CA.FriendAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_FRIEND_REMOVED, CA.FriendRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_ADDED, CA.FriendInviteAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_REMOVED, CA.FriendInviteRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_SHARED, CA.QuestShared)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_SHARE_REMOVED, CA.QuestShareRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_ADDED, CA.QuestAdded)
    end
end

function CA.RegisterGuildEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MEMBER_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MEMBER_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MEMBER_RANK_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_INVITE_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_INVITE_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MOTD_CHANGED)
    if CA.SV.MiscGuild then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_ADDED, CA.GuildMemberAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_REMOVED, CA.GuildMemberRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, CA.GuildAddedSelf)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD, CA.GuildRemovedSelf)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_INVITE_ADDED, CA.GuildInviteAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_INVITE_REMOVED, CA.GuildInviteRemoved)
        if CA.SV.MiscGuildMOTD then
            EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MOTD_CHANGED, CA.GuildMOTD)
        end
        if CA.SV.MiscGuildRank then
            EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_RANK_CHANGED, CA.GuildRank)
        end

        -- Index Guild Ranks
        g_guildRankData = {}
        if CA.SV.MiscGuildRank then
            for i = 1,5 do
                local guildId = GetGuildId(i)
                local memberIndex = GetPlayerGuildMemberIndex(guildId)
                local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
                g_guildRankData[guildId] = {rank=rankIndex}
            end
        end
    end
end

function CA.RegisterMaraEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLEDGE_OF_MARA_OFFER)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLEDGE_OF_MARA_RESULT)
    if CA.SV.MiscMara then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLEDGE_OF_MARA_OFFER, CA.MaraOffer)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLEDGE_OF_MARA_RESULT, CA.MaraResult)
    end
end

function CA.RegisterDuelEvents()
    -- EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_COUNTDOWN, CA.DuelCountdown)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_INVITE_RECEIVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_INVITE_ACCEPTED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_INVITE_SENT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_FINISHED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_INVITE_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_INVITE_DECLINED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_INVITE_CANCELED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_NEAR_BOUNDARY)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DUEL_STARTED)
    if CA.SV.MiscDuel then
        --EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_COUNTDOWN, CA.DuelCountdown)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_INVITE_RECEIVED, CA.DuelInviteReceived)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_INVITE_ACCEPTED, CA.DuelInviteAccepted)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_INVITE_SENT, CA.DuelInviteSent)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_FINISHED, CA.DuelFinished)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_INVITE_FAILED, CA.DuelInviteFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_INVITE_DECLINED, CA.DuelInviteDeclined)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_INVITE_CANCELED, CA.DuelInviteCanceled)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_NEAR_BOUNDARY, CA.DuelNearBoundary)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_STARTED, CA.DuelStarted)
    end
end

function CA.RegisterDisguiseEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED)
    if CA.SV.MiscDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED, CA.DisguiseState )
        EVENT_MANAGER:AddFilterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
        g_currentDisguise = GetItemId(0, 10) or 0 -- Get the currently equipped disguise itemId if any
        g_disguiseState = GetUnitDisguiseState("player") -- Get current player disguise state
        if g_disguiseState > 0 then g_disguiseState = 1 end -- Simplify all the various states into a basic 0 = false, 1 = true value
    end
end

function CA.RegisterAchievementsEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED)
    if CA.SV.Achievements then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED, CA.OnAchievementUpdated)
    end
end

function CA.RegisterXPEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LEVEL_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CHAMPION_POINT_UPDATE)
    if CA.SV.Experience or CA.SV.ExperienceLevelUp then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN, CA.OnExperienceGain)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LEVEL_UPDATE, CA.OnLevelUpdate)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CHAMPION_POINT_UPDATE, CA.OnChampionUpdate)

        CA.LevelUpdateHelper()
    end
end

function CA.RegisterGroupEvents()

    -- Group Events
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_INVITE_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_MEMBER_LEFT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_INVITE_RECEIVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_INVITE_RESPONSE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LEADER_UPDATE)
    -- Ready check and Group Finder Votekick Events
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_ELECTION_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_ELECTION_NOTIFICATION_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_ELECTION_RESULT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_ELECTION_REQUESTED)
    -- Group Finder Events
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUPING_TOOLS_LFG_JOINED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUPING_TOOLS_NO_LONGER_LFG)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUPING_TOOLS_FIND_REPLACEMENT_NOTIFICATION_NEW)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_STATUS_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACTIVITY_QUEUE_RESULT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED)
    if CA.SV.GroupChatMsg then
        local groupSize = GetGroupSize()
        if groupSize > 1 then g_areWeGrouped = true end
        -- Group Events
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_REMOVED, CA.GroupInviteRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_UPDATE, CA.GroupUpdate)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED, CA.OnGroupMemberJoined)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_LEFT,   CA.OnGroupMemberLeft)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_RECEIVED, CA.OnGroupInviteReceived)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_RESPONSE, CA.OnGroupInviteResponse)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LEADER_UPDATE, CA.OnGroupLeaderUpdate)
        --EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_ROLES_CHANGED, CA.GMRC) -- Possibly re-enable later if solution is found.
        --EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_CONNECTED_STATUS, CA.GMCS) -- Possibly re-enable later if solution is found.
        -- Ready check and Group Finder Votekick Events
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_ELECTION_FAILED, CA.VoteFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_ELECTION_NOTIFICATION_ADDED, CA.VoteNotify)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_ELECTION_RESULT, CA.VoteResult)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_ELECTION_REQUESTED, CA.VoteRequested)
        -- Group Finder Events
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_LFG_JOINED, CA.LFGJoined)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_NO_LONGER_LFG, CA.LFGLeft)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_FIND_REPLACEMENT_NOTIFICATION_NEW, CA.GroupFindReplacementNew)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE, CA.ActivityComplete)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, CA.ActivityStatusUpdate)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVITY_QUEUE_RESULT, CA.ActivityQueueResult)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED, CA.ReadyCheckCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED, CA.ReadyCheckUpdate)
    end
end

function CA.RegisterGoldEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MONEY_UPDATE)
    if CA.SV.GoldChange or CA.SV.MiscMail then -- Only register this event if the menu setting is true
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MONEY_UPDATE, CA.OnMoneyUpdate)
    end
    if CA.SV.MiscMail or CA.SV.LootMail or CA.SV.GoldChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED, CA.OnMailAttach)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED, CA.OnMailAttachRemove)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX, CA.OnMailCloseBox)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_SEND_FAILED, CA.OnMailFail)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS, CA.OnMailSuccess)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED, CA.MailMoneyChanged)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED, CA.MailCODChanged)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_REMOVED, CA.MailRemoved)
    end
end

function CA.RegisterVendorEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_BUY_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_SELL_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OPEN_FENCE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CLOSE_STORE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ITEM_LAUNDER_RESULT)
    if CA.SV.LootVendor then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT, CA.OnBuybackItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_BUY_RECEIPT, CA.OnBuyItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SELL_RECEIPT, CA.OnSellItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OPEN_FENCE, CA.FenceOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CLOSE_STORE, CA.StoreClose)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ITEM_LAUNDER_RESULT, CA.FenceSuccess)
    end
end

function CA.RegisterBankEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OPEN_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CLOSE_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OPEN_GUILD_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CLOSE_GUILD_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_REMOVED)
    if CA.SV.LootBank then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OPEN_BANK, CA.BankOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CLOSE_BANK, CA.BankClose)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OPEN_GUILD_BANK, CA.GuildBankOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CLOSE_GUILD_BANK, CA.GuildBankClose)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_ADDED, CA.GuildBankItemAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_REMOVED, CA.GuildBankItemRemoved)
    end
end

function CA.RegisterTradeEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_ITEM_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_ITEM_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_SUCCEEDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_WAITING)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_CONSIDERING)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_ACCEPTED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_ELEVATION_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_ITEM_ADD_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_CANCELED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_CANCELED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TRADE_INVITE_DECLINED)
    if CA.SV.MiscTrade and not CA.SV.LootTrade then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_SUCCEEDED, CA.OnTradeSuccess)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_WAITING, CA.TradeInviteWaiting)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_CONSIDERING, CA.TradeInviteConsidering)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_ACCEPTED, CA.TradeInviteAccepted)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_FAILED, CA.TradeInviteFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ELEVATION_FAILED, CA.TradeElevationFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_ADD_FAILED, CA.TradeItemAddFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_CANCELED, CA.TradeCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_FAILED, CA.TradeFail)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_CANCELED, CA.TradeInviteCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_DECLINED, CA.TradeInviteDecline)
    elseif CA.SV.LootTrade then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_ADDED, CA.OnTradeAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_REMOVED, CA.OnTradeRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_SUCCEEDED, CA.OnTradeSuccess)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_WAITING, CA.TradeInviteWaiting)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_CONSIDERING, CA.TradeInviteConsidering)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_ACCEPTED, CA.TradeInviteAccepted)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_FAILED, CA.TradeInviteFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ELEVATION_FAILED, CA.TradeElevationFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_ITEM_ADD_FAILED, CA.TradeItemAddFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_CANCELED, CA.TradeCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_FAILED, CA.TradeFail)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_CANCELED, CA.TradeInviteCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_DECLINED, CA.TradeInviteDecline)
    end
end

function CA.RegisterMailEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_READABLE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_SEND_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_REMOVED)
    if CA.SV.MiscMail or CA.SV.LootMail then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_READABLE, CA.OnMailReadable)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, CA.OnMailTakeAttachedItem)
    end
    if CA.SV.MiscMail or CA.SV.LootMail or CA.SV.GoldChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED, CA.OnMailAttach)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED, CA.OnMailAttachRemove)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX, CA.OnMailCloseBox)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_SEND_FAILED, CA.OnMailFail)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS, CA.OnMailSuccess)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED, CA.MailMoneyChanged)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED, CA.MailCODChanged)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_REMOVED, CA.MailRemoved)
    end
    if CA.SV.MiscMail or CA.SV.GoldChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MONEY_UPDATE, CA.OnMoneyUpdate)
    end
end

function CA.RegisterCraftEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, CA.CraftingOpen)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, CA.CraftingClose)
    if CA.SV.LootCraft then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, CA.CraftingOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, CA.CraftingClose)
    end
end

function CA.RegisterDestroyEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_RIDING_SKILL_IMPROVEMENT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_BAG_CAPACITY_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_BANK_CAPACITY_CHANGED)
    if CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RIDING_SKILL_IMPROVEMENT, CA.MiscAlertHorse)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_BAG_CAPACITY_CHANGED, CA.MiscAlertBags)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_BANK_CAPACITY_CHANGED, CA.MiscAlertBank)
        g_equippedStacks = {}
        g_inventoryStacks = {}
        CA.IndexEquipped()
        CA.IndexInventory()
    end
    if CA.SV.ShowDestroy then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED, CA.DestroyItem)
    end
    if CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.MiscConfiscate or CA.SV.ShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED, CA.JusticeStealRemove)
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
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOCKPICK_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS)
    if CA.SV.MiscLockpick then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_FAILED, CA.MiscAlertLockFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS, CA.MiscAlertLockSuccess)
    end
end

function CA.RegisterHorseEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_RIDING_SKILL_IMPROVEMENT)
    if CA.SV.MiscHorse then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RIDING_SKILL_IMPROVEMENT, CA.MiscAlertHorse)
    end
end

function CA.RegisterAlliancePointEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ALLIANCE_POINT_UPDATE)
    if CA.SV.AlliancePointChange then -- Only register this event if the menu setting is true
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ALLIANCE_POINT_UPDATE, CA.OnAlliancePointUpdate)
    end
end

function CA.RegisterTelVarStoneEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TELVAR_STONE_UPDATE)
    if CA.SV.TelVarStoneChange then -- Only register this event if the menu setting is true
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TELVAR_STONE_UPDATE, CA.OnTelVarStoneUpdate)
    end
end

function CA.RegisterWritVoucherEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_WRIT_VOUCHER_UPDATE)
    if CA.SV.WritVoucherChange then -- Only register this event if the menu setting is true
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_WRIT_VOUCHER_UPDATE, CA.OnWritVoucherUpdate)
    end
end

function CA.RegisterLootEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_RECEIVED)
    if CA.SV.Loot then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_RECEIVED, CA.OnLootReceived)
    end
end

-- Helper function called after receiving a group invite. This ensures we don't ever have any issues seeing the first group invite message by renabling the Event handler after the first message arrives.
-- Otherwise we would see both messages broadcast as 2 events fire at the player when a group invite is received.
function CA.RefreshGroupInviteEnable()
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_RECEIVED, CA.OnGroupInviteReceived)
end

function CA.GuildMemberAdded(eventCode, guildId, DisplayName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(DisplayName)
    local guildName = GetGuildName(guildId)

    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))

        if guildName == name then
            printToChat(strformat(GetString(SI_GUILD_ROSTER_ADDED), displayNameLink, guildNameAlliance))
            break
        end
    end
end

function CA.GuildMemberRemoved(eventCode, guildId, DisplayName, CharacterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(DisplayName)
    local guildName = GetGuildName(guildId)

    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))

        if guildName == name then
            printToChat(strformat(GetString(SI_GUILD_ROSTER_REMOVED), displayNameLink, guildNameAlliance))
            break
        end
    end
end

function CA.GuildMOTD(eventCode, guildId)
    local motd = GetGuildMotD(guildId)
    local guildName = GetGuildName(guildId)

    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))

        if guildName == name then
            printToChat(strformat(GetString(SI_LUIE_CA_GUILD_MOTD_CHANGED), guildNameAlliance, motd))
            break
        end
    end
end

function CA.GuildRank(eventCode, guildId, DisplayName, newRank)
    local currentRank = g_guildRankData[guildId].rank
    local hasPermission1 = DoesGuildRankHavePermission(guildId, currentRank, 4)
    local hasPermission2 = DoesGuildRankHavePermission(guildId, currentRank, 5)

    if ((hasPermission1 or hasPermission2) and DisplayName ~= g_playerDisplayName and CA.SV.GuildRankDisplayOptions == 2) or (CA.SV.GuildRankDisplayOptions == 3 and DisplayName ~= g_playerDisplayName) then
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(DisplayName)
        local rankName
        local rankNameDefault = GetDefaultGuildRankName(guildId, newRank)
        local rankNameCustom = GetGuildRankCustomName(guildId, newRank)

        if rankNameCustom == "" then
            rankName = rankNameDefault
        else
            rankName = rankNameCustom
        end

        local icon = GetGuildRankIconIndex(guildId, newRank)
        local icon = GetGuildRankLargeIcon(icon)
        local iconSize = 16
        local rankSyntax = CA.SV.MiscGuildIcon and zo_iconTextFormat(icon, iconSize, iconSize, ZO_SELECTED_TEXT:Colorize(rankName)) or (ZO_SELECTED_TEXT:Colorize(rankName))
        local guildName = GetGuildName(guildId)
        local guilds = GetNumGuilds()

        for i = 1,guilds do
            local id = GetGuildId(i)
            local name = GetGuildName(id)

            local guildAlliance = GetGuildAlliance(id)
            local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))

            if guildName == name then
                printToChat(strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED), displayNameLink, guildNameAlliance, rankSyntax))
                break
            end
        end
    end

    -- Cancel out if its not the player being promoted. It would be a little inefficient to index all guild members on initialize for this.
    if DisplayName == g_playerDisplayName then
        local rankName
        local rankNameDefault = GetDefaultGuildRankName(guildId, newRank)
        local rankNameCustom = GetGuildRankCustomName(guildId, newRank)
        if rankNameCustom == "" then
            rankName = rankNameDefault
        else
            rankName = rankNameCustom
        end

        local icon = GetGuildRankIconIndex(guildId, newRank)
        local icon = GetGuildRankLargeIcon(icon)
        local iconSize = 16
        local rankSyntax = CA.SV.MiscGuildIcon and zo_iconTextFormat(icon, iconSize, iconSize, ZO_SELECTED_TEXT:Colorize(rankName)) or (ZO_SELECTED_TEXT:Colorize(rankName))

        local guildName = GetGuildName(guildId)

        if currentRank > newRank then
            changestring = GetString(SI_LUIE_CA_GUILD_RANK_UP)
        end
        if currentRank < newRank then
            changestring = GetString(SI_LUIE_CA_GUILD_RANK_DOWN)
        end

        g_guildRankData[guildId].rank = newRank

        local guilds = GetNumGuilds()
        for i = 1,guilds do
            local id = GetGuildId(i)
            local name = GetGuildName(id)

            local guildAlliance = GetGuildAlliance(id)
            local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))

            if guildName == name then
                printToChat(strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED_SELF), changestring, rankSyntax, guildNameAlliance))
                break
            end
        end
    end
end

function CA.GuildAddedSelf(eventCode, guildId, guildName)
    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))

        if guildName == name then
            printToChat(strformat(GetString(SI_LUIE_CA_GUILD_JOIN_SELF), guildNameAlliance))
            break
        end
    end

    g_guildJoinFudger = true

    -- Reindex Guild Ranks
    g_guildRankData = {}
    if CA.SV.MiscGuildRank then
        for i = 1,5 do
            local guildId = GetGuildId(i)
            local memberIndex = GetPlayerGuildMemberIndex(guildId)
            local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
            g_guildRankData[guildId] = {rank=rankIndex}
        end
    end
end

function CA.GuildRemovedSelf(eventCode, guildId, guildName)
    local GuildIndexData = LUIE.GuildIndexData
    for i = 1,5 do
        local guild = GuildIndexData[i]
        if guild.name == guildName then
            local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guild.guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))
            printToChat(strformat(GetString(SI_LUIE_CA_GUILD_LEAVE_SELF), guildNameAlliance))
            break
        end
    end

    -- Reindex Guild Ranks
    g_guildRankData = {}
    if CA.SV.MiscGuildRank then
        for i = 1,5 do
            local guildId = GetGuildId(i)
            local memberIndex = GetPlayerGuildMemberIndex(guildId)
            local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
            g_guildRankData[guildId] = {rank=rankIndex}
        end
    end
end

function CA.GuildInviteAdded(eventCode, guildId, guildName, guildAlliance, inviterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterName)
    local guildNameAlliance = CA.SV.MiscGuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), 16, 16, ZO_SELECTED_TEXT:Colorize(guildName)) or (ZO_SELECTED_TEXT:Colorize(guildName))
    printToChat(strformat(GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST), displayNameLink, guildNameAlliance))
end

function CA.GuildInviteRemoved(eventCode, guildId)
    zo_callLater(CA.GuildInviteFudger, 100)
end

function CA.GuildInviteFudger()
    if not g_guildJoinFudger then
        printToChat(GetString(SI_LUIE_CA_GUILD_INVITE_DECLINED))
    end
    g_guildJoinFudger = false
end

function CA.FriendInviteFudger()
    if not FriendInviteFudger then
        printToChat(GetString(SI_LUIE_CA_FRIENDS_FRIEND_INVITE_DECLINED))
    end
    FriendInviteFudger = false
end

function CA.FriendAdded(eventCode, DisplayName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(DisplayName)
    printToChat(strformat(GetString(SI_LUIE_CA_FRIENDS_FRIEND_ADDED), displayNameLink))
    FriendInviteFudger = true
end

function CA.FriendRemoved(eventCode, DisplayName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(DisplayName)
    printToChat(strformat(GetString(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED), displayNameLink))
end

function CA.FriendInviteAdded(eventCode, inviterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterName)
    printToChat(strformat(GetString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST), displayNameLink))
end

function CA.FriendInviteRemoved(eventCode, inviterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterName)
    zo_callLater(CA.FriendInviteFudger, 100)
end

function CA.QuestShared (eventCode, questId)
    local questName, characterName, timeSinceRequestMs, displayName = GetOfferedQuestShareInfo(questId)
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(characterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
    local displayBothString = ( strformat("<<1>><<2>>", characterName, displayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, displayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        printToChat(strformat(GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE), displayNameLink, questName))
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        printToChat(strformat(GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE), characterNameLink, questName))
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        printToChat(strformat(GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE), displayBoth, questName))
    end
end

function CA.QuestShareRemoved(eventCode, questId)
    zo_callLater(CA.QuestShareMessageHelper, 50)
end

function CA.QuestAdded(eventCode, journalIndex, questName, objectiveName)
    g_QuestShareFudger = true
    zo_callLater(CA.QuestShareMessageReset, 100)
end

-- Checks to see if quest was accepted 50 ms after share is removed
function CA.QuestShareMessageHelper()
    if g_QuestShareFudger == false then
        printToChat(GetString(SI_LUIE_CA_GROUP_QUEST_SHARE_DECLINED))
    end
end

-- Reset message state after 100 ms
function CA.QuestShareMessageReset()
    g_QuestShareFudger = false
end

function CA.RegisterCustomStrings()
    if CA.SV.CustomStrings then
        -- Group String Replacements
        SafeAddString(SI_GROUPINVITERESPONSE0, GetString(SI_LUIE_CA_GROUPINVITERESPONSE0), 2)
        SafeAddString(SI_GROUPINVITERESPONSE1, GetString(SI_LUIE_CA_GROUPINVITERESPONSE1), 3)
        SafeAddString(SI_GROUPINVITERESPONSE2, GetString(SI_LUIE_CA_GROUPINVITERESPONSE2), 3)
        SafeAddString(SI_GROUPINVITERESPONSE3, GetString(SI_LUIE_CA_GROUPINVITERESPONSE3), 2)
        SafeAddString(SI_GROUPINVITERESPONSE4, GetString(SI_LUIE_CA_GROUPINVITERESPONSE4), 3)
        SafeAddString(SI_GROUPINVITERESPONSE5, GetString(SI_LUIE_CA_GROUPINVITERESPONSE5), 3)
        SafeAddString(SI_GROUPINVITERESPONSE8, GetString(SI_LUIE_CA_GROUPINVITERESPONSE8), 2)
        SafeAddString(SI_GROUPINVITERESPONSE9, GetString(SI_LUIE_CA_GROUPINVITERESPONSE9), 2)
        SafeAddString(SI_GROUPINVITERESPONSE10, GetString(SI_LUIE_CA_GROUPINVITERESPONSE10), 1)
        SafeAddString(SI_GROUPINVITERESPONSE13, GetString(SI_LUIE_CA_GROUPINVITERESPONSE13), 1)
        SafeAddString(SI_GROUPINVITERESPONSE14, GetString(SI_LUIE_CA_GROUPINVITERESPONSE14), 1)
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GROUP, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE_ALT), 1)
        SafeAddString(SI_GROUP_INVITE_MESSAGE, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE_ALT), 2)
        SafeAddString(SI_GROUPLEAVEREASON1, GetString(SI_LUIE_CA_GROUP_GROUPLEAVEREASON1), 3)
        SafeAddString(SI_GROUPLEAVEREASON2, GetString(SI_LUIE_CA_GROUP_MEMBER_DISBAND_MSG), 1)
        SafeAddString(SI_LUIE_CA_GROUP_INVITE_MESSAGE, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE_ALT), 1)
        SafeAddString(SI_LUIE_CA_GROUP_LEADER_CHANGED, GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_GROUP_MEMBER_JOIN, GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_GROUP_MEMBER_KICKED, GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_GROUP_MEMBER_LEAVE, GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_GROUP_NOTIFICATION_GROUP_LEADER_CHANGED, GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_ALT), 1)

        -- Group Finder String Replacements
        SafeAddString(SI_GROUPING_TOOLS_ALERT_LFG_JOINED, GetString(SI_LUIE_CA_GROUP_FINDER_ALERT_LFG_JOINED), 1)
        SafeAddString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_FAIL, GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_FAIL_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_START, GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_START_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_PASSED, GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_PASSED_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LFG_READY_CHECK_TEXT, GetString(SI_LUIE_CA_GROUP_FINDER_READY_CHECK_TEXT), 2)

        -- Mara String Replacements
        SafeAddString(SI_PLEDGEOFMARARESULT0, GetString(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT0), 1)
        SafeAddString(SI_PLEDGEOFMARARESULT1, GetString(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT1), 1)
        SafeAddString(SI_PLEDGEOFMARARESULT2, GetString(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT2), 1)
        SafeAddString(SI_PLEDGEOFMARARESULT3, GetString(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT3), 2)
        SafeAddString(SI_PLEDGEOFMARARESULT4, GetString(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT4), 2)
        SafeAddString(SI_PLEDGEOFMARARESULT6, GetString(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT6), 1)
        SafeAddString(SI_PLEDGEOFMARARESULT7, GetString(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT7), 1)

        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_RITUAL_OF_MARA, GetString(SI_PLEDGE_OF_MARA_MESSAGE), 1)
        SafeAddString(SI_PLAYER_TO_PLAYER_OUTGOING_RITUAL_OF_MARA, GetString(SI_PLEDGE_OF_MARA_SENDER_MESSAGE), 1)

        -- Quest Share String Replacements
        SafeAddString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE, GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_ALT), 1)
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_QUEST_SHARE, GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_ALT), 3)
        SafeAddString(SI_QUEST_SHARE_MESSAGE, GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_ALT), 1)

        -- Trade String Replacements
        SafeAddString(SI_TRADE_INVITE_CONFIRM, GetString(SI_LUIE_CA_TRADE_INVITE_CONFIRM), 1)
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_TRADE, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
        SafeAddString(SI_TRADE_INVITE_PROMPT, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
        SafeAddString(SI_TRADE_INVITE, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
        SafeAddString(SI_TRADE_INVITE_MESSAGE, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
        SafeAddString(SI_TRADEACTIONRESULT1, GetString(SI_LUIE_CA_TRADEACTIONRESULT1), 1)

        -- Friend Invite String Replacements
        SafeAddString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG, GetString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_FRIENDS_LIST_IGNORE_ADDED, GetString(SI_LUIE_CA_FRIENDS_LIST_IGNORE_ADDED), 1) -- Fixes default Ignore List messages to match our syntax.
        SafeAddString(SI_FRIENDS_LIST_IGNORE_REMOVED, GetString(SI_LUIE_CA_FRIENDS_LIST_IGNORE_REMOVED), 1) -- Fixes default Ignore List messages to match our syntax.
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_FRIEND_REQUEST, GetString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST), 1) -- Default ZOS string was missing a period.
        SafeAddString(SI_FRIENDS_LIST_FRIEND_LOGGED_ON, GetString(SI_LUIE_CA_FRIENDS_LIST_LOGGED_ON), 1)
        SafeAddString(SI_FRIENDS_LIST_FRIEND_CHARACTER_LOGGED_ON, GetString(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_ON), 1)
        SafeAddString(SI_FRIENDS_LIST_FRIEND_LOGGED_OFF, GetString(SI_LUIE_CA_FRIENDS_LIST_LOGGED_OFF), 1)
        SafeAddString(SI_FRIENDS_LIST_FRIEND_CHARACTER_LOGGED_OFF, GetString(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_OFF), 1)
        SafeAddString(SI_LUIE_CA_FRIENDS_FRIEND_ADDED, GetString(SI_LUIE_CA_FRIENDS_FRIEND_ADDED_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED, GetString(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST, GetString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST_ALT), 1) -- Replaces default syntax style string with LUIE style

        -- Guild Invite String Replacements
        SafeAddString(SI_GUILD_ROSTER_INVITED_MESSAGE, GetString(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE_ALT), 2)
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GUILD_REQUEST, GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST_ALT), 1)
        SafeAddString(SI_GUILD_INVITE_MESSAGE, GetString(SI_LUIE_CA_GUILD_INVITE_MESSAGE), 3)
        SafeAddString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST, GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST_ALT), 1) -- Replaces default syntax style string with LUIE style
        SafeAddString(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, GetString(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE_ALT), 1)
        SafeAddString(SI_GUILD_ROSTER_ADDED, GetString(SI_LUIE_CA_GUILD_ROSTER_ADDED), 2)
        SafeAddString(SI_GUILD_ROSTER_REMOVED, GetString(SI_LUIE_CA_GUILD_ROSTER_REMOVED), 2)
        SafeAddString(SI_LUIE_CA_GUILD_RANK_CHANGED, GetString(SI_LUIE_CA_GUILD_RANK_CHANGED_ALT), 1)

        -- Duel String Replacements
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_DUEL, GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), 1)
        SafeAddString(SI_DUEL_INVITE_MESSAGE, GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), 1)
        SafeAddString(SI_DUEL_INVITE_ACCEPTED, GetString(SI_LUIE_CA_DUEL_INVITE_ACCEPTED), 1)
        SafeAddString(SI_DUEL_INVITE_DECLINED, GetString(SI_LUIE_CA_DUEL_INVITE_DECLINED), 1)
        SafeAddString(SI_DUEL_INVITE_CANCELED, GetString(SI_LUIE_CA_DUEL_INVITE_CANCELED), 1)
        SafeAddString(SI_DUEL_INVITE_SENT, GetString(SI_LUIE_CA_DUEL_INVITE_SENT), 1)
        SafeAddString(SI_DUEL_INVITE_RECEIVED, GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), 1)
        SafeAddString(SI_PLAYER_TO_PLAYER_INVITE_DUEL, GetString(SI_LUIE_CA_DUEL_INVITE_PLAYER), 1)
        SafeAddString(SI_DUELING_COUNTDOWN_CSA, GetString(SI_LUIE_CA_DUEL_COUNTDOWN_CSA), 1)
        SafeAddString(SI_DUELING_NEAR_BOUNDARY_CSA, GetString(SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA), 1)
        SafeAddString(SI_DUELRESULT0, GetString(SI_LUIE_CA_DUEL_RESULT0), 1)
        SafeAddString(SI_DUELRESULT1, GetString(SI_LUIE_CA_DUEL_RESULT1), 1)
        SafeAddString(SI_DUELSTATE1, GetString(SI_LUIE_CA_DUEL_STATE1), 1)
        SafeAddString(SI_DUELSTATE1, GetString(SI_LUIE_CA_DUEL_STATE2), 1)
        SafeAddString(SI_DUELINVITEFAILREASON1, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON1), 1)
        SafeAddString(SI_DUELINVITEFAILREASON4, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON4), 1)
        SafeAddString(SI_DUELINVITEFAILREASON5, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON5), 1)
        SafeAddString(SI_DUELINVITEFAILREASON6, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON6), 1)
        SafeAddString(SI_DUELINVITEFAILREASON7, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON7), 1)
        SafeAddString(SI_DUELINVITEFAILREASON8, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON8), 1)
        SafeAddString(SI_DUELINVITEFAILREASON9, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON9), 1)
        SafeAddString(SI_DUELINVITEFAILREASON10, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON10), 1)
        SafeAddString(SI_DUELINVITEFAILREASON12, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON12), 1)
        SafeAddString(SI_DUELINVITEFAILREASON14, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON14), 1)
        SafeAddString(SI_DUELINVITEFAILREASON16, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON16), 1)
        SafeAddString(SI_DUELINVITEFAILREASON18, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON18), 1)
        SafeAddString(SI_DUELINVITEFAILREASON20, GetString(SI_LUIE_CA_DUEL_INVITE_FAILREASON20), 1)

        -- Regroup Replacement String
        SafeAddString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG, GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG_ALT), 1)
    end
end

function CA.LFGJoined(eventCode, locationName)
    printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_ALERT_LFG_JOINED), locationName))
    g_joinLFGOverride = true
end

function CA.LFGLeft(eventCode)
    g_leaveLFGOverride = true
end

function CA.CheckLFGStatusJoin()
    if not g_stopGroupLeaveQueue then
        if IsInLFGGroup() and not g_joinLFGOverride then
            printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF_LFG))
        elseif not IsInLFGGroup() and not g_joinLFGOverride then
            printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF))
        end
        g_joinLFGOverride = false
    end
end

function CA.PrintJoinStatusNotSelf(SendString)
    if not g_stopGroupLeaveQueue then
        printToChat(SendString)
    end
end

function CA.CheckLFGStatusLeave(SendString, WasKicked)
    if not g_stopGroupLeaveQueue then
        if SendString ~= "" then
            printToChat(SendString)
        end
        if not g_leaveLFGOverride then
            if WasKicked then
                printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED_SELF))
            end
            if GetGroupSize() == 0 then
                printToChat(GetString(SI_LUIE_CA_GROUP_QUIT))
            end
        elseif g_leaveLFGOverride and GetGroupSize() == 0 then
            printToChat(GetString(SI_LUIE_CA_GROUP_QUIT_LFG))
        end
    end
    g_leaveLFGOverride = false
end

function CA.GroupFindReplacementNew(eventCode)
    local activityType, activityIndex = GetLFGFindReplacementNotificationInfo()
    local name = GetLFGOption(activityType, activityIndex)
    printToChat(strformat(GetString(SI_LFG_FIND_REPLACEMENT_TEXT), name))
end

function CA.ActivityComplete(eventCode)
    printToChat(GetString(SI_ACTIVITY_FINDER_ACTIVITY_COMPLETE_ANNOUNCEMENT_TEXT))
end

function CA.ActivityStatusUpdate(eventCode, status)
    --d(status)
    if g_showActivityStatus then
        if status == ACTIVITY_FINDER_STATUS_NONE and g_weAreQueued == true then
            printToChat(GetString(SI_LUIE_CA_GROUP_FINDER_QUEUE_END))
            g_weAreQueued = false
            g_showStatusDropMember = false
        end
        if status == ACTIVITY_FINDER_STATUS_QUEUED then
            printToChat(GetString(SI_LUIE_CA_GROUP_FINDER_QUEUE_START))
            g_weAreQueued = true
            g_showStatusDropMember = true
        end
        if status == ACTIVITY_FINDER_STATUS_IN_PROGRESS and g_showStatusDropMember == true then
            printToChat(GetString(SI_LUIE_CA_GROUP_FINDER_QUEUE_END))
            g_weAreQueued = false
            g_showStatusDropMember = false
        end
    end

    if status == 0 then
        g_showRCUpdates = true
        g_fixJoinMessage = false
    end -- Should always trigger at the end result of a ready check failing.
    if status == 2 then
        g_fixJoinMessage = false
    end
    if status == 4 then
        g_showRCUpdates = false
    end

    if status == 5 then
        g_fixJoinMessage = true
    end
end

function CA.ActivityQueueResult(eventCode, result)
    if result == ACTIVITY_QUEUE_RESULT_INCOMPATIBLE_GROUP then
        printToChat(GetString(SI_ACTIVITYQUEUERESULT9))
    end

    if result == ACTIVITY_QUEUE_RESULT_MEMBERS_OFFLINE then
        printToChat(GetString(SI_ACTIVITYQUEUERESULT14))
    end

    if result == ACTIVITY_QUEUE_RESULT_ON_QUEUE_COOLDOWN then
        printToChat(GetString(SI_ACTIVITYQUEUERESULT12))
    end

    if result == ACTIVITY_QUEUE_RESULT_MEMBER_CANCELED_READY_CHECK then
        printToChat(GetString(SI_ACTIVITYQUEUERESULT19))
    end

    if result == ACTIVITY_QUEUE_RESULT_DLC_LOCKED then
        printToChat(GetString(SI_ACTIVITYQUEUERESULT6))
    end

    g_fixJoinMessage = false
    g_showRCUpdates = true
    g_weAreQueued = false
    g_showStatusDropMember = false
end

function CA.ReadyCheckCancel(eventCode, reason)
    if reason == LFG_READY_CHECK_CANCEL_REASON_GROUP_MEMBER_CANCELED then
        printToChat(GetString(SI_LFGREADYCHECKCANCELREASON3))
    end
    if reason == LFG_READY_CHECK_CANCEL_REASON_GROUP_NOT_VIABLE then
        printToChat(GetString(SI_LFGREADYCHECKCANCELREASON2))

    end
    if reason == LFG_READY_CHECK_CANCEL_REASON_GROUP_FORMED_SUCCESSFULLY then
        printToChat(GetString(SI_LFGREADYCHECKCANCELREASON4))
        g_stopGroupLeaveQueue = true
        zo_callLater(CA.ResetGroupLeaveQueue, 1000)

    end
    if reason == LFG_READY_CHECK_CANCEL_REASON_GROUP_READY then
        printToChat(GetString(SI_LUIE_CA_GROUP_FINDER_READY_CHECK_CANCELED))
    end

    g_fixJoinMessage = false
    g_showRCUpdates = true
    g_showActivityStatus = false
    g_showStatusDropMember = false
    g_weAreQueued = false
    zo_callLater(CA.ActivityStatusRefresh, 500)
end

function CA.ActivityStatusRefresh()
    g_showActivityStatus = true
end

function CA.ReadyCheckUpdate(eventCode)
    local activityType, playerRole = GetLFGReadyCheckNotificationInfo()
    local tanksAccepted, tanksPending, healersAccepted, healersPending, dpsAccepted, dpsPending = GetLFGReadyCheckCounts()
    --d(tanksAccepted .. " " .. tanksPending .. " " .. healersAccepted .. " " .. healersPending .. " " .. dpsAccepted .." " .. dpsPending)
    if g_showRCUpdates then
        local activityName

        if activityType == 0 then
            return
        end
        if activityType == LFG_ACTIVITY_AVA then
            activityName = GetString(SI_LFGACTIVITY1)
        end
        if activityType == LFG_ACTIVITY_BATTLE_GROUND then
            activityName = "Battleground" -- Not yet implemented yet
        end
        if activityType == LFG_ACTIVITY_DUNGEON then
            activityName = GetString(SI_LFGACTIVITY2)
        end
        if activityType == LFG_ACTIVITY_HOME_SHOW then
            activityName = GetString(SI_LFGACTIVITY6)
        end
        if activityType == LFG_ACTIVITY_MASTER_DUNGEON then
            activityName = GetString(SI_LFGACTIVITY3)
        end
        if activityType == LFG_ACTIVITY_TRIAL then
            activityName = GetString(SI_LFGACTIVITY4)
        end

        if playerRole ~= 0 then
            local roleIcon = (strformat("|t16:16:<<1>>|t", GetRoleIcon(playerRole)))
            local roleString = GetString("SI_LFGROLE", playerRole)
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_READY_CHECK_ACTIVITY_ROLE), activityName, roleIcon, roleString ))
        else
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_READY_CHECK_ACTIVITY), activityName))
        end
    end

    if not g_fixJoinMessage then
        if not g_showRCUpdates and (tanksAccepted == 0 and tanksPending == 0 and healersAccepted == 0 and healersPending == 0 and dpsAccepted == 0 and dpsPending == 0) then
            printToChat(GetString(SI_LFGREADYCHECKCANCELREASON3))
        elseif not g_showRCUpdates and (tanksAccepted > 0 or healersAccepted > 0 or dpsAccepted > 0)  and g_areWeGrouped == false then
            g_fixJoinMessage = true
        end
    end

    if g_fixJoinMessage then
        if not g_showRCUpdates and (tanksAccepted == 0 and healersAccepted == 0 and dpsAccepted == 0 and tanksPending == 0 and healersPending == 0 and dpsPending == 0) then
            printToChat(GetString(SI_LFGREADYCHECKCANCELREASON4))
            g_stopGroupLeaveQueue = true
            zo_callLater(CA.ResetGroupLeaveQueue, 1000)
        end
    end

    g_showRCUpdates = false
    g_weAreQueued = false
    g_showStatusDropMember = false
end

function CA.ResetGroupLeaveQueue()
    g_stopGroupLeaveQueue = false
end

function CA.VoteFailed( eventCode, failureReason, descriptor)
    printToChat(GetString("SI_GROUPELECTIONFAILURE", failureReason))
end

function CA.VoteNotify(eventCode)
    local electionType, timeRemainingSeconds, electionDescriptor, targetUnitTag = GetGroupElectionInfo()
    if electionType == 2 then -- Ready Check
        printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_MESSAGE)) -- "Are you ready?"
    end

    if electionType == 3 then -- Vote Kick
        local kickMemberName = GetUnitName(targetUnitTag)
        local kickMemberAccountName = GetUnitDisplayName(targetUnitTag)

        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(kickMemberName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(kickMemberAccountName)
        local displayBothString = ( strformat("<<1>><<2>>", kickMemberName, kickMemberAccountName) )
        local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, kickMemberAccountName)
        if CA.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_START), displayNameLink))
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_START), characterNameLink))
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_START), displayBoth))
        end
    end
end

function CA.VoteResult(eventCode, electionResult, descriptor)
    local electionType, timeRemainingSeconds, electionDescriptor, targetUnitTag = GetGroupElectionInfo()
    if descriptor == "[ZO_READY_CHECK]" then
        if electionResult == 1 then
            printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_FAILED)) -- "Someone in your group is not ready."
        end
        if electionResult == 4 then
            printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_PASSED)) -- "Everyone in your group is ready!"
        end
        if electionResult == 5 then
            printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_FAILED)) -- "Someone in your group is not ready."
        end
    end
    if descriptor == "[ZO_NONE]" then
        local KickCarry
        local kickMemberName = GetUnitName(targetUnitTag)
        local kickMemberAccountName = GetUnitDisplayName(targetUnitTag)

        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(kickMemberName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(kickMemberAccountName)
        local displayBothString = ( strformat("<<1>><<2>>", kickMemberName, kickMemberAccountName) )
        local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, kickMemberAccountName)

        if CA.SV.ChatPlayerDisplayOptions == 1 then
            KickCarry = displayNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            KickCarry = characterNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            KickCarry = displayBoth
        end

        if electionResult == 1 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_FAIL), KickCarry))
        end
        if electionResult == 2 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_FAIL), KickCarry))
        end
        if electionResult == 4 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_PASSED), KickCarry))
        end
        if electionResult == 5 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_FINDER_NOTIFY_VOTEKICK_FAIL), KickCarry))
        end
    end
end

function CA.VoteRequested(eventCode, descriptor)
    if descriptor == "[ZO_READY_CHECK]" then
        printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_REQUESTED))
    end
    if descriptor == "[ZO_NONE]" then
        printToChat(GetString(SI_GROUP_ELECTION_REQUESTED))
    end
end

-- Triggers when the player either accepts or declines an invite. We set g_groupJoinFudger to true here, and if the next event is GroupUpdate then it plays a message, if not, the next invite event resets it.
function CA.GroupInviteRemoved(eventCode)
    g_groupJoinFudger = true
end

-- Triggers when the group composition changes for a Party going from 2 people to 3+, we use this to display a message to the player joining the group.
function CA.GroupUpdate(eventCode)
    if g_groupJoinFudger then
        zo_callLater(CA.CheckLFGStatusJoin, 100)
    end
    g_groupJoinFudger = false
    local groupSize = GetGroupSize()
    if groupSize > 1 then g_areWeGrouped = true end
end

--[[ Would love to be able to use this function but its too buggy for now. Spams every single time someone updates their role, as well as when people join/leave group. If the player joins a large party for the first time then
this broadcasts the role of every single player in the party. Too bad this doesn't only trigger when someone in group actually updates their role instead.
No localization support yet.
function CA.GMRC(eventCode, unitTag, dps, healer, tank)

local updatedRoleName = GetUnitName(unitTag)
local updatedRoleAccountName = GetUnitDisplayName(unitTag)

local characterNameLink = ZO_LinkHandler_CreateCharacterLink(updatedRoleName)
local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(updatedRoleAccountName)
local displayBothString = ( strformat("<<1>><<2>>", updatedRoleName, updatedRoleAccountName) )
local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, updatedRoleAccountName)

local rolestring1 = ""
local rolestring2 = ""
local rolestring3 = ""
local message = ""

    -- Return here in case something happens
    if not (dps or healer or tank) then
        return
    end

    -- fill in strings for roles
    if dps then
        rolestring3 = "DPS"
    end
    if healer then
        rolestring2 = "Healer"
    end
    if tank then
        rolestring1 = "Tank"
    end

    -- Get appropriate 2nd string for role
    if dps and not (healer or tank) then
        message = (strformat("<<1>>", rolestring3) )
    elseif healer and not (dps or tank) then
        message = (strformat("<<1>>", rolestring2) )
    elseif tank and not (dps or healer) then
        message = (strformat("<<1>>", rolestring1) )
    elseif dps and healer and not tank then
        message = (strformat("<<1>>, <<2>>", rolestring2, rolestring3) )
    elseif dps and tank and not healer then
        message = (strformat("<<1>>, <<2>>", rolestring1, rolestring3) )
    elseif healer and tank and not dps then
        message = (strformat("<<1>>, <<2>>", rolestring1, rolestring2) )
    elseif dps and healer and tank then
        message = (strformat("<<1>>, <<2>>, <<3>>", rolestring1, rolestring2, rolestring3) )
    end

    if updatedRoleName ~= g_playerNameFormatted then
        if CA.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(strformat("|cFEFEFE<<1>>|r has updated their role: <<2>>", displayNameLink, message) )
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(strformat("|cFEFEFE<<1>>|r has updated their role: <<2>>", characterNameLink, message) )
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(strformat("|cFEFEFE<<1>>|r has updated their role: <<2>>", displayBoth, message) )
        end
    else
        printToChat(strformat("You have updated your role: <<1>>", message) )
    end
end
]]--

--[[ Would love to be able to use this function but its too buggy for now. When a single player disconnects for the first time in the group, another player will see a message for the online/offline status of every other
player in the group. Possibly reimplement and limit it to 2 player groups?
No localization support yet.
function CA.GMCS(eventCode, unitTag, isOnline)

    local onlineRoleName = GetUnitName(unitTag)
    local onlineRoleDisplayName = GetUnitDisplayName(unitTag)

    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(onlineRoleName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(onlineRoleDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", onlineRoleName, onlineRoleDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, onlineRoleDisplayName)


    if not isOnline and onlineRoleName ~=g_playerNameFormatted then
        if CA.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(strformat("|cFEFEFE<<1>>|r has disconnected.", displayNameLink) )
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(strformat("|cFEFEFE<<1>>|r has disconnected.", characterNameLink) )
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(strformat("|cFEFEFE<<1>>|r has disconnected.", displayBoth) )
        end
    elseif isOnline and onlineRoleName ~=g_playerNameFormatted then
        if CA.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(strformat("|cFEFEFE<<1>>|r has reconnected.", displayNameLink) )
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(strformat("|cFEFEFE<<1>>|r has reconnected.", characterNameLink) )
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(strformat("|cFEFEFE<<1>>|r has reconnected.", displayBoth) )
        end
    end
end
]]--

-- Prints a message to chat when another player sends us a group invite
function CA.OnGroupInviteReceived(eventCode, inviterName, inviterDisplayName)
    g_groupJoinFudger = false

    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(inviterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", inviterName, inviterDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, inviterDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        printToChat(strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), displayNameLink))
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        printToChat(strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), characterNameLink))
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        printToChat(strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), displayBoth))
    end
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_INVITE_RECEIVED) -- On receiving a group invite, it fires 2 events, we disable the event handler temporarily for this then re-enable it after.
    zo_callLater(CA.RefreshGroupInviteEnable, 100)
end

-- Prints a message to chat when invites are declined or failed.
-- Currently broken as of 2/9/2017 so we have to omit any names from this function until it returns the correct InviteeName and InviteeDisplayName instead
function CA.OnGroupInviteResponse(eventCode, inviterName, response, inviterDisplayName)
    local responseName
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(inviterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", inviterName, inviterDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, inviterDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        responseName = displayNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        responseName = characterNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        responseName = displayBoth
    end

    if response == 2 and (inviterName == "" or inviterDisplayName == "") then -- Stops blank [] response from printing out when the invited player is zoning
        return
    elseif response ~= 0 and response ~= 1 then
        printToChat(strformat(GetString("SI_GROUPINVITERESPONSE", response), responseName))
    elseif response == 1 and g_playerName ~= inviterName then
        g_groupFormFudger = true
        printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF))
    end
end

-- Prints a message to chat when the leader of the group is updated
function CA.OnGroupLeaderUpdate(eventCode, leaderTag)
    local groupLeaderName = GetUnitName(leaderTag)
    local groupLeaderAccount = GetUnitDisplayName(leaderTag)

    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(groupLeaderName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(groupLeaderAccount)
    local displayBothString = ( strformat("<<1>><<2>>", groupLeaderName, groupLeaderAccount) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, groupLeaderAccount)

    if g_playerNameFormatted ~= groupLeaderName then -- If another player became the leader
        if CA.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), displayNameLink))
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), characterNameLink))
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), displayBoth))
        end
    elseif g_playerNameFormatted == groupLeaderName then -- If the player character became the leader
        printToChat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_SELF))
    end
end

-- Prints a message to chat when a group member joins
function CA.OnGroupMemberJoined(eventCode, memberName)
    g_groupJoinFudger = false
    local g_partyStack = { }
    local joinedMemberName = ""
    local joinedMemberAccountName = ""

    -- Iterate through group member indices to get the relevant UnitTags
    for i = 1,40 do
        local memberTag = GetGroupUnitTagByIndex(i)
        if memberTag == nil then
            break -- Once we reach a nil value (aka no party member there, stop the loop)
        end
        g_partyStack[i] = { memberTag = memberTag }
    end

    -- Iterate through UnitTags to get the member who just joined
    for i = 1, #g_partyStack do
        local unitname = GetRawUnitName(g_partyStack[i].memberTag)
        if unitname == memberName then
            joinedMemberName = GetUnitName(g_partyStack[i].memberTag)
            joinedMemberAccountName = GetUnitDisplayName(g_partyStack[i].memberTag)
            break -- Break loop once we get the value we need
        end
    end

    if g_playerName ~= memberName then
        -- Can occur if event is before EVENT_PLAYER_ACTIVATED
        local groupJoinName
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(joinedMemberName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(joinedMemberAccountName)
        local displayBothString = ( strformat("<<1>><<2>>", joinedMemberName, joinedMemberAccountName) )
        local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, joinedMemberAccountName)
        if CA.SV.ChatPlayerDisplayOptions == 1 then groupJoinName = displayNameLink end
        if CA.SV.ChatPlayerDisplayOptions == 2 then groupJoinName = characterNameLink end
        if CA.SV.ChatPlayerDisplayOptions == 3 then groupJoinName = displayBoth end
        local SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN), groupJoinName))
        zo_callLater(function() CA.PrintJoinStatusNotSelf(SendString) end, 100)
    elseif g_playerName == memberName and not g_groupFormFudger then
        zo_callLater(CA.CheckLFGStatusJoin, 100)
    end

    g_partyStack = { }
    g_groupFormFudger = false
    g_areWeGrouped = true
end

-- Prints a message to chat when a group member leaves
function CA.OnGroupMemberLeft(eventCode, memberName, reason, isLocalPlayer, isLeader, memberDisplayName, actionRequiredVote)
    local memberLeftName
    local SendString
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(memberName,"%^%a+","") )
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(memberDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", gsub(memberName,"%^%a+",""), memberDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, memberDisplayName)

    if g_playerName == memberName then
        g_showStatusDropMember = false -- Resets variable for Group Finder events, just in case.
    end

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        memberLeftName = displayNameLink
    end

    if CA.SV.ChatPlayerDisplayOptions == 2 then
        memberLeftName = characterNameLink
    end

    if CA.SV.ChatPlayerDisplayOptions == 3 then
        memberLeftName = displayBoth
    end

    if reason == GROUP_LEAVE_REASON_VOLUNTARY then
        if g_playerName == memberName then
            g_areWeGrouped = false
            SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_SELF), memberLeftName))
            zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
        end
        if g_playerName ~= memberName then
            SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE), memberLeftName))
            zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
        end
    elseif reason == GROUP_LEAVE_REASON_KICKED then
        if g_playerName == memberName then
            g_areWeGrouped = false
            SendString = ("")
            local WasKicked = true
            zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
        end
        if g_playerName ~= memberName then
            SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED), memberLeftName))
            zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
        end
    elseif reason == GROUP_LEAVE_REASON_DISBAND and g_playerName == memberName then
        g_areWeGrouped = false
        SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_DISBAND_MSG), memberLeftName))
        zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
    end
    if msg then
        -- Can occur if event is before EVENT_PLAYER_ACTIVATED
        if CA.SV.ChatPlayerDisplayOptions == 1 then
            printToChat(strformat(msg, displayNameLink))
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            printToChat(strformat(msg, characterNameLink))
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            printToChat(strformat(msg, displayBoth))
        end
    end
end

-- Gold Change Announcements
function CA.OnMoneyUpdate(eventCode, newMoney, oldMoney, reason)

    g_comboString = ""
    local UpOrDown     = newMoney - oldMoney

    -- If the total gold change was 0 then we don't waste any more resoureces and end this now
    if UpOrDown == 0 then
        return
    end

    local currentMoney = ZO_LocalizeDecimalNumber(GetCurrentMoney())
    local color              -- Gets the value from ChangeUpColorize or ChangeDownColorize to color strings
    local changetype         -- Amount of currency gained or lost
    local bracket1           -- Leading bracket
    local bracket2           -- Trailing bracket
    local message            -- Combined String Part 1: Context Message
    local syntax             -- Combined String Part 2: Currency Change and Icon
    local total              -- Combined String Part 3: Total String
    local plural       = "s" -- Adds an "s" onto the end of plural values of currency when not using a set string
    local formathelper = " " -- Places a spacer between the amount of currency and the name used for currency. This spacer is overwritten based on certain currency name string situations.
    local mailHelper   = false

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

    -- Determine the color of the text based on whether we gained or lost gold
    if UpOrDown > 0 then
        color = ChangeUpColorize
        changetype = ZO_LocalizeDecimalNumber(newMoney - oldMoney)
    else
        color = ChangeDownColorize
        changetype = ZO_LocalizeDecimalNumber(oldMoney - newMoney)
    end

    -- If we only recieve or lose 1 Gold, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.GoldName == "" or CA.SV.GoldName == "Gold" or CA.SV.GoldName == "Currency" or CA.SV.GoldName == "GP" or CA.SV.GoldName == "gp" or CA.SV.GoldName == "G" or CA.SV.GoldName == "g" then
        plural = ""
    end

    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.GoldName == ( "" ) or CA.SV.GoldName == ( "g" ) or CA.SV.GoldName == ( "gp" )then
        formathelper = ""
    end

    -- Sell/Buy from a Merchant
    if reason == 1 and UpOrDown > 0 then
        message = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN)
    elseif reason == 1 and UpOrDown < 0 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SPENT)

    -- Receieve Money in the Mail
    elseif reason == 2 and UpOrDown > 0 then
        message = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN)

    -- Send money in the mail, values changed to compensate for COD!
    elseif reason == 2 and UpOrDown < 0 then
        if g_postageAmount == 0 and g_mailMoney == 0 and g_mailCOD == 0 then
            message = GetString(SI_LUIE_CA_MAIL_COD_PAYMENT_MSG)
        else
            message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SENT)
        end
        changetype = ZO_LocalizeDecimalNumber(oldMoney - newMoney - g_postageAmount)
        mailHelper = true

    -- Receive/Give Money in a Trade (Likely consolidate this later)
    elseif reason == 3 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_TRADED)

    -- Receive from Quest Reward (4), AH Refund (32), Sell to Fence (63)
    elseif reason == 4 or reason == 32 or reason == 63 then
        message = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN)

    -- Spend - NPC Conversation (5), Bag Space (8), Bank Space (9), Wayshrine (19), Mount Feed (28), Repairs (29), AH Listing Fee (33), Respec Skills (44), Respec Attributes (45),
    -- Unstuck (48), Edit Guild Heraldry (49), Buy Guild Tabard (50), Respec Morphs (55), Pay Fence (56), Launder (60), Champion Respec (61), Buyback (64)
    elseif reason == 5 or reason == 8 or reason == 9 or reason == 19 or reason == 28 or reason == 29 or reason == 33 or reason == 44 or reason == 45 or reason == 48 or reason == 49 or reason == 50 or reason == 55 or reason == 56 or reason == 60 or reason == 61 or reason == 64 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SPENT)

    -- Buy on AH (31)
    elseif reason == 31 then
        if CA.SV.GoldHideAHSpent then return end
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SPENT)

    -- Desposit in Bank (42) or Guild Bank (51)
    elseif reason == 42 or reason == 51 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)

    -- Withdraw from Bank (43) or Guild Bank (52)
    elseif reason == 43 or reason == 52 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)

    -- Confiscated -- Pay to Guard (47) or Killed by Guard (57)
    elseif reason == 47 or reason == 57 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_CONFISCATED)

    -- Pickpocketed (59)
    elseif reason == 59 then
        message = GetString(SI_GAMECAMERAACTIONTYPE21)

    -- Looted - From Chest (0), Looted (13), Stolen Gold (62)
    elseif reason == 0 or reason == 13 or reason == 62 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOOTED)

    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    elseif reason == 6 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 7 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 12 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 14 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 15 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 16 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 18 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 20 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 21 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 22 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 23 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 24 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 25 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 26 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 27 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 30 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 34 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 36 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 37 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 38 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 39 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 40 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 41 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 46 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 53 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 54 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 58 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 66 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    -- END DEBUG EVENTS
    -- ==============================================================================

    -- If none of these returned true, then we must have just looted the gold (Potentially a few currency change events I missed too may have to adjust later)
    else message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOOTED) end

    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ChangeUpColorize then
            message = CA.SV.CurrencyContextMessageUp
        else
            message = CA.SV.CurrencyContextMessageDown
        end
    end

    -- Creates initial message
    message = color:Colorize(strfmt("%s%s%s", bracket1, message, bracket2))

    -- Determines syntax based on whether icon is displayed or not, we use "ICON - GOLD CHANGE AMOUNT" if so, and "GOLD CHANGE AMOUNT - GOLD" if not
    if CA.SV.CurrencyIcons then
        syntax = GoldColorize:Colorize(strfmt(" |t16:16:/esoui/art/currency/currency_gold.dds|t %s%s%s%s", changetype, formathelper, CA.SV.GoldName, plural))
    else
        syntax = GoldColorize:Colorize(strfmt(" %s%s%s%s", changetype, formathelper, CA.SV.GoldName, plural))
    end

    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if not mailHelper then
        if CA.SV.TotalGoldChange and not CA.SV.CurrencyIcons then
            total = CA.SV.TotalGoldChange and strfmt(" %s %s", color:Colorize(CA.SV.CurrencyTotalMessage), GoldColorize:Colorize(currentMoney))
        elseif CA.SV.TotalGoldChange and CA.SV.CurrencyIcons then
            total = CA.SV.TotalGoldChange and strfmt(" %s |t16:16:/esoui/art/currency/currency_gold.dds|t %s", color:Colorize(CA.SV.CurrencyTotalMessage), GoldColorize:Colorize(currentMoney))
        else
            total = ""
        end
        -- Print a message to chat based off all the values we filled in above
        if CA.SV.GoldChange and CA.SV.LootCurrencyCombo and UpOrDown < 0 and (reason == 1 or reason == 63 or reason == 64) then
            g_comboString = ( strfmt(" → %s%s%s", message, syntax, total) )
        elseif CA.SV.MiscMail and reason == 2 then
            if not g_mailStop and g_mailStringPart1 ~= "" then
                if not CA.SV.GoldChange then
                    printToChat(strformat("<<1>><<2>><<3>> <<c:4>>.", g_mailStringPart1, GetString(SI_LIST_AND_SEPARATOR), changetype, GetString(SI_CURRENCY_GOLD)))
                else
                    printToChat(strformat("<<1>><<2>><<c:3>>.", g_mailStringPart1, GetString(SI_LIST_AND_SEPARATOR)), GetString(SI_CURRENCY_GOLD))
                end
            elseif not g_mailStop then
                if not CA.SV.GoldChange then
                    printToChat(strformat(GetString(SI_LUIE_CA_MAIL_RECEIVED_VAR_GOLD_MSG), changetype))
                else
                    printToChat(GetString(SI_LUIE_CA_MAIL_RECEIVED_GOLD_MSG))
                end
            end
            if CA.SV.GoldChange then
                printToChat(strfmt("%s%s%s", message, syntax, total))
            end
            g_mailStringPart1 = ""
        elseif CA.SV.GoldChange and reason == 3 and CA.SV.MiscTrade and UpOrDown < 0 then
            g_tradeString1 = ( strfmt("%s%s%s", message, syntax, total) )
        elseif CA.SV.GoldChange and reason == 3 and CA.SV.MiscTrade and UpOrDown > 0 then
            g_tradeString2 = ( strfmt("%s%s%s", message, syntax, total) )
        elseif CA.SV.GoldChange and CA.SV.LootCurrencyCombo and reason == 28 then
            g_comboString = ( strfmt(" → %s%s%s", message, syntax, total) )
        elseif CA.SV.GoldChange and reason == 47 then
            g_stealString = ( strfmt("%s%s%s", message, syntax, total) )
            local latency = GetLatency()
            latency = latency + 50
            zo_callLater(CA.JusticeStealRemove, latency)
         elseif CA.SV.GoldChange and reason == 57 then
            g_stealString = ( strfmt("%s%s%s", message, syntax, total) )
            local latency = GetLatency()
            latency = latency + 50
            zo_callLater(CA.JusticeStealRemove, latency)
        elseif CA.SV.GoldChange and CA.SV.LootCurrencyCombo and UpOrDown > 0 and (reason == 1 or reason == 63 or reason == 64) then
            g_comboString = ( strfmt(" ← %s%s%s", message, syntax, total) )
        elseif CA.SV.GoldChange and CA.SV.LootCurrencyCombo and CA.SV.MiscBags and (reason == 8 or reason == 9) then
            g_comboString = ( strfmt(" → %s%s%s", message, syntax, total) )
        elseif CA.SV.GoldChange and UpOrDown < 0 and reason == 60 then
            g_launderGoldstring = ( strfmt("%s%s%s", message, syntax, total) )
        else
            if CA.SV.GoldChange then
                printToChat(strfmt("%s%s%s", message, syntax, total))
            end
        end
    else
        g_mailCurrencyCheck = false
        local valuesent = ""
        local totalwithoutpostage = 0
        if g_postageAmount ~= 0 then
            totalWithoutPostage = ZO_LocalizeDecimalNumber ( oldMoney - g_postageAmount )
        else
            totalWithoutPostage = ZO_LocalizeDecimalNumber ( oldMoney )
        end

        if CA.SV.TotalGoldChange and not CA.SV.CurrencyIcons then
            total = CA.SV.TotalGoldChange and strfmt(" %s %s", color:Colorize(CA.SV.CurrencyTotalMessage), GoldColorize:Colorize(currentMoney))
        elseif CA.SV.TotalGoldChange and CA.SV.CurrencyIcons then
            total = CA.SV.TotalGoldChange and strfmt(" %s |t16:16:/esoui/art/currency/currency_gold.dds|t %s", color:Colorize(CA.SV.CurrencyTotalMessage), GoldColorize:Colorize(currentMoney))
        else
            total = ""
        end

        if CA.SV.MiscMail and g_postageAmount == 0 and g_mailMoney == 0 and g_mailCOD == 0 and not CA.SV.GoldChange then
            printToChat(strfmt(GetString(SI_LUIE_CA_MAIL_COD_VAR_GOLD_SENT1), changetype))
        end
        if CA.SV.MiscMail and g_postageAmount == 0 and g_mailMoney == 0 and g_mailCOD == 0 and CA.SV.GoldChange then
            printToChat(GetString(SI_LUIE_CA_MAIL_COD_GOLD_SENT))
        end
        if CA.SV.MiscMail and g_mailCOD == 0 and g_mailMoney == 0 and g_postageAmount >= 1 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_SUCCESS))
        end
        if CA.SV.MiscMail and g_mailMoney ~= 0 and not CA.SV.GoldChange then
            printToChat(strfmt(GetString(SI_LUIE_CA_MAIL_SENT_VAR_GOLD_MSG), g_mailMoney) )
        end
        if CA.SV.MiscMail and g_mailMoney ~= 0 and CA.SV.GoldChange then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_SUCCESS))
        end
        if CA.SV.MiscMail and g_mailCOD ~= 0 and not CA.SV.GoldChange then
            printToChat(strfmt(GetString(SI_LUIE_CA_MAIL_COD_GOLD_SENT2), g_mailCOD) )
        end
        if CA.SV.MiscMail and g_mailCOD ~= 0 and CA.SV.GoldChange then
            printToChat(GetString(SI_LUIE_CA_MAIL_COD_SENT_SUCCESS))
        end

        valuesent = ( strfmt("%s%s%s", message, syntax, total) )

        if g_postageAmount ~= 0 then
            local postagesyntax = CA.SV.CurrencyIcons and GoldColorize:Colorize(strfmt( " |t16:16:/esoui/art/currency/currency_gold.dds|t " .. g_postageAmount .. formathelper .. CA.SV.GoldName .. plural)) or GoldColorize:Colorize(strfmt( " " .. g_postageAmount .. formathelper .. CA.SV.GoldName .. plural))

            if CA.SV.TotalGoldChange and not CA.SV.CurrencyIcons then
                total = CA.SV.TotalGoldChange and strfmt(" %s %s", color:Colorize(CA.SV.CurrencyTotalMessage), GoldColorize:Colorize(totalWithoutPostage))
            elseif CA.SV.TotalGoldChange and CA.SV.CurrencyIcons then
                total = CA.SV.TotalGoldChange and strfmt(" %s |t16:16:/esoui/art/currency/currency_gold.dds|t %s", color:Colorize(CA.SV.CurrencyTotalMessage), GoldColorize:Colorize(totalWithoutPostage))
            else
                total = ""
            end
            if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
                message = color:Colorize(strfmt("%s%s%s", bracket1, CA.SV.CurrencyContextMessageDown, bracket2))
            else
                message = color:Colorize(strfmt("%s%s%s", bracket1, GetString(SI_GAMEPAD_MAIL_SEND_POSTAGE_LABEL), bracket2)) -- "Postage"
            end
            if CA.SV.GoldChange then
                printToChat(strfmt("%s%s%s", message, postagesyntax, total))
            end
        end

        if CA.SV.GoldChange and g_mailMoney ~= 0 then
            printToChat(valuesent)
        end
        if CA.SV.GoldChange and g_postageAmount == 0 and g_mailMoney == 0 and g_mailCOD == 0 then
            printToChat(valuesent) -- All these values will be zero for a COD payment sent, since none of them are updated.
        end
    end

    mailHelper = false
    g_postageAmount = 0
    g_mailMoney = 0
    g_mailCOD = 0
    if not g_mailCurrencyCheck then
        zo_callLater(CA.MailClearVariables, 500)
    end
end

-- Alliance Point Change Announcements
function CA.OnAlliancePointUpdate(eventCode, alliancePoints, playSound, difference)
    g_comboString = ""

    -- If the total AP change was 0 then we end this now
    if UpOrDown == alliancePoints then
        return
    end

    local UpOrDown     = alliancePoints + difference
    local color              -- Gets the value from ChangeUpColorize or ChangeDownColorize to color strings
    local changetype         -- Amount of currency gained or lost
    local bracket1           -- Leading bracket
    local bracket2           -- Trailing bracket
    local message            -- Combined String Part 1: Context Message
    local syntax             -- Combined String Part 2: Currency Change and Icon
    local total              -- Combined String Part 3: Total String
    local plural       = "s" -- Adds an "s" onto the end of plural values of currency when not using a set string
    local formathelper = " " -- Places a spacer between the amount of currency and the name used for currency. This spacer is overwritten based on certain currency name string situations.

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

    -- Determine the color and message of the text based on whether we gained or lost Alliance Points
    if UpOrDown > alliancePoints then
        color = ChangeUpColorize
        changetype = ZO_LocalizeDecimalNumber( difference )
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_EARNED)
    else
        color = ChangeDownColorize
        changetype = ZO_LocalizeDecimalNumber( difference * -1 )
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SPENT)
    end

    -- If we only recieve or lose 1 Alliance Point, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.AlliancePointName == "" or CA.SV.AlliancePointName == "AP" or CA.SV.AlliancePointName == "ap" or CA.SV.AlliancePointName == "A" or CA.SV.AlliancePointName == "a" then
        plural = ""
    end

    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.AlliancePointName == ( "" ) or CA.SV.AlliancePointName == ( "ap" ) or CA.SV.AlliancePointName == ( "a" ) then
        formathelper = ""
    end

    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ChangeUpColorize then
            message = CA.SV.CurrencyContextMessageUp
        else
            message = CA.SV.CurrencyContextMessageDown
        end
    end

    -- Creates initial message
    message = color:Colorize(strfmt("%s%s%s", bracket1, message, bracket2))

    -- Determines syntax based on whether icon is displayed or not
    if CA.SV.CurrencyIcons then
        syntax = APColorize:Colorize(strfmt(" |t16:16:/esoui/art/currency/alliancepoints.dds|t %s%s%s%s", changetype, formathelper, CA.SV.AlliancePointName, plural))
    else
        syntax = APColorize:Colorize(strfmt(" %s%s%s%s", changetype, formathelper, CA.SV.AlliancePointName, plural))
    end

    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if CA.SV.TotalAlliancePointChange and not CA.SV.CurrencyIcons then
        total = CA.SV.TotalGoldChange and strfmt(" %s %s", color:Colorize(CA.SV.CurrencyTotalMessage), APColorize:Colorize(ZO_LocalizeDecimalNumber(alliancePoints)))
    elseif CA.SV.TotalAlliancePointChange and CA.SV.CurrencyIcons then
        total = CA.SV.TotalGoldChange and strfmt(" %s |t16:16:/esoui/art/currency/currency_gold.dds|t %s", color:Colorize(CA.SV.CurrencyTotalMessage), APColorize:Colorize(ZO_LocalizeDecimalNumber(alliancePoints)))
    else
        total = ""
    end

    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    if reason == 6 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 7 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 12 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 14 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 15 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 16 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 18 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 20 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 21 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 22 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 23 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 24 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 25 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 26 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 27 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 30 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 34 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 36 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 37 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 38 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 39 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 40 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 41 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 46 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 53 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 54 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 58 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 66 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    end
    -- END DEBUG EVENTS
    -- ==============================================================================

    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and color == ChangeUpColorize then
        g_comboString = (strfmt(" → %s%s%s", message, syntax, total))
    else
        if difference > CA.SV.AlliancePointFilter then
            printToChat(strfmt("%s%s%s", message, syntax, total))
        end
    end
end

-- Tel Var Stones Change Announcements
function CA.OnTelVarStoneUpdate(eventCode, newTelvarStones, oldTelvarStones, reason)
    g_comboString = ""
    local UpOrDown = newTelvarStones - oldTelvarStones

    -- If the total Tel Var change was 0 or Reason 35 = Player Init (Triggers when player changes zones) - End Now
    if UpOrDown == 0 or reason == 35 then
        return
    end

    local currentTelvar = ZO_LocalizeDecimalNumber(newTelvarStones)
    local color              -- Gets the value from ChangeUpColorize or ChangeDownColorize to color strings
    local changetype         -- Amount of currency gained or lost
    local bracket1           -- Leading bracket
    local bracket2           -- Trailing bracket
    local message            -- Combined String Part 1: Context Message
    local syntax             -- Combined String Part 2: Currency Change and Icon
    local total              -- Combined String Part 3: Total String
    local plural       = "s" -- Adds an "s" onto the end of plural values of currency when not using a set string
    local formathelper = " " -- Places a spacer between the amount of currency and the name used for currency. This spacer is overwritten based on certain currency name string situations.

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

    -- Determine the color of the text based on whether we gained or lost gold
    if UpOrDown > 0 then
        color = ChangeUpColorize
        changetype = ZO_LocalizeDecimalNumber(newTelvarStones - oldTelvarStones)
    else
        color = ChangeDownColorize
        changetype = ZO_LocalizeDecimalNumber(oldTelvarStones - newTelvarStones)
    end

    -- If we only recieve or lose 1 Tel Var Stone, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.TelVarStoneName == "" or CA.SV.TelVarStoneName == "TV" or CA.SV.TelVarStoneName == "tv" or CA.SV.TelVarStoneName == "TVS" or CA.SV.TelVarStoneName == "tvs" or CA.SV.TelVarStoneName == "T" or CA.SV.TelVarStoneName == "t" or CA.SV.TelVarStoneName == "TelVar" or CA.SV.TelVarStoneName == "Tel Var" then
        plural = ""
    end

    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.TelVarStoneName == ( "" ) or CA.SV.TelVarStoneName == ( "tv" ) or CA.SV.TelVarStoneName == ( "t" ) or CA.SV.TelVarStoneName == ( "tvs" ) then
        formathelper = ""
    end

    -- Buy from a Merchant (no way to sell Tel Var)
    if reason == 1 and UpOrDown < 0 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SPENT)

    -- Desposit in Bank (42)
    elseif reason == 42 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)

    -- Withdraw from Bank (43)
    elseif reason == 43 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)

    -- Looted - From Chest (0) or from Player/NPC (65)
    elseif reason == 0 or reason == 65 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOOTED)

    -- Died to Player/NPC (67)
    elseif reason == 67 then
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOST)

    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    elseif reason == 6 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 7 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 12 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 14 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 15 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 16 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 18 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 20 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 21 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 22 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 23 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 24 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 25 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 26 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 27 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 30 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 34 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 36 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 37 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 38 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 39 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 40 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 41 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 46 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 53 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 54 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 58 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 66 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    -- END DEBUG EVENTS
    -- ==============================================================================

    -- If none of these returned true, then we must have just looted the Tel Var Stones
    else message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOOTED) end

    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ChangeUpColorize then
            message = CA.SV.CurrencyContextMessageUp
        else
            message = CA.SV.CurrencyContextMessageDown
        end
    end

    -- Creates initial message
    message = color:Colorize(strfmt("%s%s%s", bracket1, message, bracket2))

    -- Determines syntax based on whether icon is displayed or not
    if CA.SV.CurrencyIcons then
        syntax = TVColorize:Colorize(strfmt(" |t16:16:/esoui/art/currency/currency_telvar.dds|t %s%s%s%s", changetype, formathelper, CA.SV.TelVarStoneName, plural))
    else
        syntax = TVColorize:Colorize(strfmt(" %s%s%s%s", changetype, formathelper, CA.SV.TelVarStoneName, plural))
    end

    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if CA.SV.TotalTelVarStoneChange and not CA.SV.CurrencyIcons then
        total = CA.SV.TotalGoldChange and strfmt(" %s %s", color:Colorize(CA.SV.CurrencyTotalMessage), TVColorize:Colorize(currentTelvar))
    elseif CA.SV.TotalTelVarStoneChange and CA.SV.CurrencyIcons then
        total = CA.SV.TotalGoldChange and strfmt(" %s |t16:16:/esoui/art/currency/currency_gold.dds|t %s", color:Colorize(CA.SV.CurrencyTotalMessage), TVColorize:Colorize(currentTelvar))
    else
        total = ""
    end

    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and UpOrDown < 0 and reason == 1 then
        g_comboString = (strfmt(" → %s%s%s", message, syntax, total))
    elseif CA.SV.LootCurrencyCombo and UpOrDown > 0 and reason == 1 then
        g_comboString = (strfmt(" ← %s%s%s", message, syntax, total))
    else
        printToChat(strfmt("%s%s%s", message, syntax, total))
    end
end

-- Writ Voucher Change Announcements
function CA.OnWritVoucherUpdate(eventCode, newWritVouchers, oldWritVouchers, reason)

    -- If the total Writ Voucher change was 0 or Reason 35 = Player Init (Triggers when player changes zones) - End Now
    if UpOrDown == 0 or reason == 35 then
        return
    end

    g_comboString = ""
    local UpOrDown            = newWritVouchers - oldWritVouchers

    local currentWritVouchers = ZO_LocalizeDecimalNumber(newWritVouchers)
    local color              -- Gets the value from ChangeUpColorize or ChangeDownColorize to color strings
    local changetype         -- Amount of currency gained or lost
    local bracket1           -- Leading bracket
    local bracket2           -- Trailing bracket
    local message            -- Combined String Part 1: Context Message
    local syntax             -- Combined String Part 2: Currency Change and Icon
    local total              -- Combined String Part 3: Total String
    local plural       = "s" -- Adds an "s" onto the end of plural values of currency when not using a set string
    local formathelper = " " -- Places a spacer between the amount of currency and the name used for currency. This spacer is overwritten based on certain currency name string situations.

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

    -- Determine the color of the text based on whether we gained or lost gold
    if UpOrDown > 0 then
        color = ChangeUpColorize
        changetype = ZO_LocalizeDecimalNumber(newWritVouchers - oldWritVouchers)
        message = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN) -- "Receieved"
    else
        color = ChangeDownColorize
        changetype = ZO_LocalizeDecimalNumber(oldWritVouchers - newWritVouchers)
        message = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SPENT)
    end

    -- If we only recieve or lose 1 Writ Voucher, don't add an "s" onto the end of the name
    if UpOrDown == 1 or UpOrDown == -1 or CA.SV.WritVoucherName == "" or CA.SV.WritVoucherName == "WV" or CA.SV.WritVoucherName == "wv" or CA.SV.WritVoucherName == "W" or CA.SV.WritVoucherName == "w" or CA.SV.WritVoucherName == "V" or CA.SV.WritVoucherName == "v" then
        plural = ""
    end

    -- If the name is blank, don't add an additional spacer before it after the change value
    if CA.SV.WritVoucherName == ( "" ) or CA.SV.WritVoucherNAme == ( "wv" ) or CA.SV.WritVoucherNAme == ( "w" ) or CA.SV.WritVoucherNAme == ( "v" ) then
        formathelper = ""
    end

    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    if reason == 6 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 7 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 12 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 14 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 15 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 16 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 18 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 20 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 21 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 22 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 23 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 24 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 25 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 26 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 27 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 30 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 34 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 36 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 37 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 38 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 39 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 40 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 41 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 46 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 53 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 54 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 58 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 66 then message = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    end
    -- END DEBUG EVENTS
    -- ==============================================================================

    if CA.SV.CurrencyContextToggle then -- Override with custom string if enabled
        if color == ChangeUpColorize then
            message = CA.SV.CurrencyContextMessageUp
        else
            message = CA.SV.CurrencyContextMessageDown
        end
    end

    -- Creates initial message
    message = color:Colorize(strfmt("%s%s%s", bracket1, message, bracket2))

    -- Determines syntax based on whether icon is displayed or not
    if CA.SV.CurrencyIcons then
        syntax = WVColorize:Colorize(strfmt(" |t16:16:/esoui/art/currency/currency_writvoucher.dds|t %s%s%s%s", changetype, formathelper, CA.SV.WritVoucherName, plural))
    else
        syntax = WVColorize:Colorize(strfmt(" %s%s%s%s", changetype, formathelper, CA.SV.WritVoucherName, plural))
    end

    -- If Total Currency display is on, then this line is printed additionally on the end, if not then print a blank string
    if CA.SV.TotalWritVoucherChange and not CA.SV.CurrencyIcons then
        total = CA.SV.TotalGoldChange and strfmt(" %s %s", color:Colorize(CA.SV.CurrencyTotalMessage), WVColorize:Colorize(currentWritVouchers))
    elseif CA.SV.TotalWritVoucherChange and CA.SV.CurrencyIcons then
        total = CA.SV.TotalGoldChange and strfmt(" %s |t16:16:/esoui/art/currency/currency_gold.dds|t %s", color:Colorize(CA.SV.CurrencyTotalMessage), WVColorize:Colorize(currentWritVouchers))
    else
        total = ""
    end

    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and UpOrDown < 0 then
        g_comboString = (strfmt(" → %s%s%s", message, syntax, total))
    else
        printToChat(strfmt("%s%s%s", message, syntax, total))
    end
end

function CA.MiscAlertLockFailed(eventCode)
    printToChat(GetString(SI_LUIE_CA_LOCKPICK_FAILED))
end

function CA.MiscAlertLockSuccess(eventCode)
    printToChat(GetString(SI_LUIE_CA_LOCKPICK_SUCCESS))
end

function CA.MiscAlertHorse(eventCode, ridingSkillType, previous, current, source)
    if CA.SV.MiscHorse then
        local bracket1
        local bracket2
        local icon
        local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_PURCHASED) -- "Purchased"
        local skillstring

        if source == 2 then
            logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LEARNED)
        end

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

        if ridingSkillType == 1 and source == 1 then
            skillstring = "[Riding Speed Upgrade]"
        elseif ridingSkillType == 2 and source == 1  then
            skillstring = "[Riding Capacity Upgrade]"
        elseif ridingSkillType == 3 and source == 1  then
            skillstring = "[Riding Stamina Upgrade]"
        elseif ridingSkillType == 1 and source == 2  then
            skillstring = "|H1:item:64700:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
        elseif ridingSkillType == 2 and source == 2  then
            skillstring = "|H1:item:64702:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
        elseif ridingSkillType == 3 and source == 2  then
            skillstring = "|H1:item:64701:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
        end

        if CA.SV.LootIcons then
            if source == 1 then
                if ridingSkillType == 1 then
                    icon = "|t16:16:/esoui/art/mounts/ridingskill_speed.dds|t "
                elseif ridingSkillType == 2 then
                    icon = "|t16:16:/esoui/art/mounts/ridingskill_capacity.dds|t "
                elseif ridingSkillType == 3 then
                    icon = "|t16:16:/esoui/art/mounts/ridingskill_stamina.dds|t "
                end
            elseif source == 2 then
                if ridingSkillType == 1 then
                    icon = "|t16:16:/esoui/art/icons/store_ridinglessons_speed.dds|t "
                elseif ridingSkillType == 2 then
                    icon = "|t16:16:/esoui/art/icons/store_ridinglessons_capacity.dds|t "
                elseif ridingSkillType == 3 then
                    icon = "|t16:16:/esoui/art/icons/store_ridinglessons_stamina.dds|t "
                end
            end
        else
            icon = ""
        end

        if CA.SV.ItemContextToggle then
            logPrefix = CA.SV.ItemContextMessage
        end

        logPrefix = ChangeUpColorize:Colorize(strfmt("%s%s%s", bracket1, logPrefix, bracket2))

        if CA.SV.LootCurrencyCombo == true then
            printToChat(strfmt("%s %s%s |cFFFFFF%s/60|r%s", logPrefix, icon, skillstring, current, g_comboString))
            g_comboString = ""
        else
            printToChat(strformat("%s %s%s |cFFFFFF%s/60|r", logPrefix, icon, skillstring, current) )
        end
    end
end

function CA.MiscAlertBags(eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
    if CA.SV.MiscBags then
        local bracket1
        local bracket2
        local icon
        local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_PURCHASED) -- "Purchased"

        -- If this isn't a bag upgrade purchase then ignore this event. We have a separate event handling mount space upgrades.
        if currentUpgrade <= previousUpgrade then
            return
        end

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

        logPrefix = ChangeUpColorize:Colorize(strfmt("%s%s%s", bracket1, logPrefix, bracket2))

        if CA.SV.LootCurrencyCombo == true then
            printToChat(strfmt("%s %s[Bag Space Upgrade] |cFFFFFF%s/8|r%s", logPrefix, icon, currentUpgrade, g_comboString))
            g_comboString = ""
        else
            printToChat(strfmt("%s %s[Bag Space Upgrade] |cFFFFFF%s/8|r", logPrefix, icon, currentUpgrade))
        end
    end
end

function CA.MiscAlertBank(eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
    if CA.SV.MiscBags then
        local bracket1
        local bracket2
        local icon = ""
        local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_PURCHASED) -- "Purchased"

        if currentUpgrade < 1 then
            return
        end

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
            logPrefix = CA.SV.ItemContextMessage
        end

        logPrefix = ChangeUpColorize:Colorize(strfmt("%s%s%s", bracket1, logPrefix, bracket2))

        if CA.SV.LootCurrencyCombo == true then
            printToChat(strfmt("%s %s[Bank Space Upgrade] |cFFFFFF%s/8|r%s", logPrefix, icon, currentUpgrade, g_comboString))
            g_comboString = ""
        else
            printToChat(strfmt("%s %s[Bank Space Upgrade] |cFFFFFF%s/8|r", logPrefix, icon, currentUpgrade))
        end
    end
end

function CA.OnBuybackItem(eventCode, itemName, quantity, money, itemSound)
    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon

    icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

    local logPrefix = GetString(SI_ITEMFILTERTYPE8)
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    local receivedBy = ""
    local gainorloss = 1

    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss)
end

function CA.OnBuyItem(eventCode, itemName, entryType, quantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)

    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon

    icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_PURCHASED) -- "Purchased"
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    local receivedBy = ""
    local gainorloss = 1

    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss)
end

function CA.OnSellItem(eventCode, itemName, quantity, money)
    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon

    icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SOLD)
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    local receivedBy = ""
    local gainorloss = 2

    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss)
end

function CA.OnLootReceived(eventCode, receivedBy, itemName, quantity, itemSound, lootType, lootedBySelf, isPickpocketLoot, questItemIcon, itemId)
    g_comboString = ""

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
    icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

    local itemType, specializedItemType = GetItemLinkItemType(itemName)
    local itemQuality = GetItemLinkQuality(itemName)
    local itemIsSet = GetItemLinkSetInfo(itemName)

    -- Workaround for a ZOS bug: Daedric Embers are not flagged in-game as key fragments
    if (itemId == 69059) then
        specializedItemType = SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT
    end

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
        -- Trial non worthless junk
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
    if ( CA.SV.LootBlacklist and blacklistIDs[itemId] ) then
        return
    end

    -- Set prefix based on Looted/Pickpocket/Received
    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOOTED)

    if ( isPickpocketLoot ) then
        logPrefix = GetString(SI_GAMECAMERAACTIONTYPE21) -- "Pickpocket"
    end
    if ( receivedBy == nil ) then
        logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN) -- "Receieved"
    end
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    local gainorloss = 1

    if lootedBySelf then
        if CA.SV.LootOnlyNotable then
            -- Notable items are: any set items, any purple+ items, blue+ special items (e.g., treasure maps)
            if ( (itemIsSet) or
                 (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
                 (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
                 (lootType == LOOT_TYPE_COLLECTIBLE) or
                 (itemType == ITEMTYPE_COSTUME) or
                 (itemType == ITEMTYPE_DISGUISE) or
                 (notableIDs[itemId]) ) then

                CA.LogItem( logPrefix, icon, itemName, itemType, quantity, lootedBySelf and "" or receivedBy, gainorloss )
            end
        elseif CA.SV.LootNotTrash and ( itemQuality == ITEM_QUALITY_TRASH ) and not ( ( itemType == ITEMTYPE_ARMOR) or (itemType == ITEMTYPE_COSTUME) or (itemType == ITEMTYPE_DISGUISE) ) then
            return
        else
            CA.LogItem( logPrefix, icon, itemName, itemType, quantity, lootedBySelf and "" or receivedBy, gainorloss )
        end
    elseif CA.SV.LootGroup then
        if ( (lootType ~= LOOT_TYPE_ITEM and lootType ~= LOOT_TYPE_COLLECTIBLE) or
             (itemType == ITEMTYPE_CONTAINER) or -- Don't show containers for group members
             (itemQuality == ITEM_QUALITY_ARCANE and itemType == ITEMTYPE_RACIAL_STYLE_MOTIF) ) then -- Don't show blue motifs for group members
            return
        end
        if ( (itemIsSet) or
             (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
             (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
             (lootType == LOOT_TYPE_COLLECTIBLE) or
             (notableIDs[itemId]) ) then

            CA.LogItem( logPrefix, icon, itemName, itemType, quantity, self and "" or receivedBy, gainorloss )
        end
    end
end

function CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainorloss, istrade)
    --LoggedAnItem = true -- Set this to true, allows buffer to start!

    local bracket1
    local bracket2
    local color
    local message

    if gainorloss == 1 then color = ChangeUpColorize end
    if gainorloss == 2 then color = ChangeDownColorize end
    if gainorloss == 3 then color = ZO_SELECTED_TEXT end

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
    local formattedStyle = ""
    local arrowPointer       = ""

    if (receivedBy == "" or receivedBy == "CRAFT") then
        -- Don't display yourself
        formattedRecipient = ""
    else
       -- Selects direction of pointer based on whether item is gained for lost, reversed for Trade purposes.
        if gainorloss == 1 and not istrade then
            arrowPointer = " →"
        elseif gainorloss == 2 and not istrade then
            arrowPointer = " ←"
        elseif gainorloss == 1 and istrade then
            arrowPointer = " ←"
        else
            arrowPointer = " →"
        end
        -- Create a character link to make it easier to contact the recipient
        formattedRecipient = strfmt(
            "%s |c%06X|H0:character:%s|h%s|h|r",
            arrowPointer,
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

    local styleType = GetItemLinkItemStyle(itemName) -- Get Style of the item
    if (CA.SV.LootShowStyle and styleType ~= ITEMSTYLE_NONE and styleType ~= ITEMSTYLE_UNIQUE and styleType ~= ITEMSTYLE_UNIVERSAL and itemType ~= ITEMTYPE_STYLE_MATERIAL) then
        formattedStyle = strfmt(" |cFFFFFF(%s)|r", GetString("SI_ITEMSTYLE", styleType))
    end

    if g_oldItemLink ~= "" then
        itemName2 = (strfmt("%s → ", g_oldItemLink:gsub("^|H0", "|H1", 1)))
        g_oldItemLink = ""
    else
        itemName2 = ""
    end

    message = color:Colorize(strfmt("%s%s%s ", bracket1, logPrefix, bracket2))

    if receivedBy == "CRAFT"  and gainorloss == 1 then
        g_itemString1Gain = message

        if g_itemString2Gain ~= "" then g_itemString2Gain = strfmt("%s%s %s%s%s%s%s%s%s%s%s", g_itemString2Gain, color:Colorize(","), icon,
            itemName2,
            itemName:gsub("^|H0", "|H1", 1),
            formattedQuantity,
            formattedArmorType,
            formattedTrait,
            formattedStyle,
            formattedRecipient,
            g_comboString) end

        if g_itemString2Gain == "" then g_itemString2Gain = strfmt("%s%s%s%s%s%s%s%s%s", icon,
            itemName2,
            itemName:gsub("^|H0", "|H1", 1),
            formattedQuantity,
            formattedArmorType,
            formattedTrait,
            formattedStyle,
            formattedRecipient,
            g_comboString) end
        zo_callLater(CA.PrintMultiLineGain, 50)
    end

    if receivedBy == "CRAFT"  and gainorloss == 2 then
        g_itemString1Loss = message

        if g_itemString2Loss ~= "" then g_itemString2Loss = strfmt("%s%s %s%s%s%s%s%s%s%s%s", g_itemString2Loss, color:Colorize(","), icon,
            itemName2,
            itemName:gsub("^|H0", "|H1", 1),
            formattedQuantity,
            formattedArmorType,
            formattedTrait,
            formattedStyle,
            formattedRecipient,
            g_comboString) end

        if g_itemString2Loss == "" then g_itemString2Loss = strfmt("%s%s%s%s%s%s%s%s%s", icon,
            itemName2,
            itemName:gsub("^|H0", "|H1", 1),
            formattedQuantity,
            formattedArmorType,
            formattedTrait,
            formattedStyle,
            formattedRecipient,
            g_comboString) end
        zo_callLater(CA.PrintMultiLineLoss, 50)
    end

    if receivedBy ~= "CRAFT" then
        if not g_launderCheck then printToChat(strfmt(
            "%s%s%s%s%s%s%s%s%s%s",
            message,
            icon,
            itemName2,
            itemName:gsub("^|H0", "|H1", 1),
            formattedQuantity,
            formattedArmorType,
            formattedTrait,
            formattedStyle,
            formattedRecipient,
            g_comboString
        )) end

        if g_launderCheck then g_launderItemstring = (strfmt(
            "%s%s%s%s%s%s%s%s%s",
            message,
            icon,
            itemName2,
            itemName:gsub("^|H0", "|H1", 1),
            formattedQuantity,
            formattedArmorType,
            formattedTrait,
            formattedStyle,
            formattedRecipient
        )) end
    end

    g_launderCheck = false
    g_comboString = ""
end

function CA.PrintMultiLineGain()
    if g_itemString1Gain == "" then
        return
    end
    printToChat(g_itemString1Gain .. g_itemString2Gain)
    g_itemString1Gain = ""
    g_itemString2Gain = ""
end

function CA.PrintMultiLineLoss()
    if g_itemString1Loss == "" then
        return
    end
    printToChat(g_itemString1Loss .. g_itemString2Loss)
    g_itemString1Loss = ""
    g_itemString2Loss = ""
end

-- These 2 functions help us get the name of the person we are trading with regardless of who initiated the trade
function CA.TradeInviteWaiting(eventCode, inviteeCharacterName, inviteeDisplayName)
    g_tradeInvitee = inviteeCharacterName
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(inviteeCharacterName,"%^%a+","") )
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviteeDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", gsub(inviteeCharacterName,"%^%a+",""), inviteeDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, inviteeDisplayName)
    if CA.SV.MiscTrade and CA.SV.ChatPlayerDisplayOptions == 1 then
        printToChat(strformat(GetString(SI_TRADE_INVITE_CONFIRM), displayNameLink))
    end
    if CA.SV.MiscTrade and CA.SV.ChatPlayerDisplayOptions == 2 then
        printToChat(strformat(GetString(SI_TRADE_INVITE_CONFIRM), characterNameLink))
    end
    if CA.SV.MiscTrade and CA.SV.ChatPlayerDisplayOptions == 3 then
        printToChat(strformat(GetString(SI_TRADE_INVITE_CONFIRM), displayBoth))
    end
end

-- These 2 functions help us get the name of the person we are trading with regardless of who initiated the trade
function CA.TradeInviteConsidering(eventCode, inviterCharacterName, inviterDisplayName)
    g_tradeInviter = inviterCharacterName
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(inviterCharacterName,"%^%a+","") )
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterDisplayName)
    local displayBothString = ( strformat("<<1><<<2>>", gsub(inviterCharacterName,"%^%a+",""), inviterDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, inviterDisplayName)
    if CA.SV.MiscTrade and CA.SV.ChatPlayerDisplayOptions == 1 then
        printToChat(strformat(GetString(SI_TRADE_INVITE), displayNameLink))
    end
    if CA.SV.MiscTrade and CA.SV.ChatPlayerDisplayOptions == 2 then
        printToChat(strformat(GetString(SI_TRADE_INVITE), characterNameLink))
    end
    if CA.SV.MiscTrade and CA.SV.ChatPlayerDisplayOptions == 3 then
        printToChat(strformat(GetString(SI_TRADE_INVITE), displayBoth))
    end
end

function CA.TradeInviteAccepted(eventCode)
    if CA.SV.MiscTrade then
        printToChat(GetString(SI_LUIE_CA_TRADE_INVITE_ACCEPTED))
    end
end

function CA.TradeInviteFailed(eventCode, reason, inviteeCharacterName, inviteeDisplayName)
    if CA.SV.MiscTrade then
        local failName
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(inviteeCharacterName,"%^%a+","") )
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviteeDisplayName)
        local displayBothString = ( strformat("<<1>><<2>>", gsub(inviteeCharacterName,"%^%a+",""), inviteeDisplayName) )
        local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, inviteeDisplayName)

        if CA.SV.ChatPlayerDisplayOptions == 1 then failName = displayNameLink end
        if CA.SV.ChatPlayerDisplayOptions == 2 then failName = characterNameLink end
        if CA.SV.ChatPlayerDisplayOptions == 3 then failName = displayBoth end

        printToChat(strformat(GetString("SI_TRADEACTIONRESULT", reason), failName))
    end
end

function CA.TradeElevationFailed(eventCode, reason, itemName)
    if CA.SV.MiscTrade then printToChat(strformat(GetString("SI_TRADEACTIONRESULT", reason), itemName)) end
end

function CA.TradeItemAddFailed(eventCode, reason, itemName)
    if CA.SV.MiscTrade then printToChat(strformat(GetString("SI_TRADEACTIONRESULT", reason), itemName)) end
end

function CA.TradeInviteDecline(eventCode)
    if CA.SV.MiscTrade then
        printToChat(GetString(SI_TRADE_INVITE_DECLINE))
    end
    g_tradeStacksIn = {}
    g_tradeStacksOut = {}
    g_tradeInviter = ""
    g_tradeInvitee = ""
end

function CA.TradeInviteCancel(eventCode)
    if CA.SV.MiscTrade then
        printToChat(GetString(SI_TRADE_CANCEL_INVITE))
    end
    g_tradeStacksIn = {}
    g_tradeStacksOut = {}
    g_tradeInviter = ""
    g_tradeInvitee = ""
end

-- Adds item to index when they are added to the trade
function CA.OnTradeAdded(eventCode, who, tradeIndex, itemSoundCategory)
    -- d( "tradeIndex: " .. tradeIndex .. " --- WHO: " .. who )
    if who == 0 then
        local indexOut = tradeIndex
        local name, icon, stack = GetTradeItemInfo (who, tradeIndex)
        local tradeitemlink = GetTradeItemLink (who, tradeIndex, LINK_STYLE_DEFAULT)
        g_tradeStacksOut[indexOut] = {stack=stack, name=name, icon=icon, itemlink=tradeitemlink}
    else
        local indexIn = tradeIndex
        local name, icon, stack = GetTradeItemInfo (who, tradeIndex)
        local tradeitemlink = GetTradeItemLink (who, tradeIndex, LINK_STYLE_DEFAULT)
        g_tradeStacksIn[indexIn] = {stack=stack, name=name, icon=icon, itemlink=tradeitemlink}
    end
end

-- Removes items from index if they are removed from the trade
function CA.OnTradeRemoved(eventCode, who, tradeIndex, itemSoundCategory)
    if who == 0 then
        local indexOut = tradeIndex
        g_tradeStacksOut[indexOut] = nil
    else
        local indexIn = tradeIndex
        g_tradeStacksIn[indexIn] = nil
    end
end

-- Cleanup if a Trade is canceled/exited
function CA.TradeCancel(eventCode, cancelerName)
    if CA.SV.MiscTrade then
        printToChat(GetString(SI_TRADE_CANCELED))
    end
    g_tradeStacksIn = {}
    g_tradeStacksOut = {}
    g_tradeInviter = ""
    g_tradeInvitee = ""
end

function CA.TradeFail(eventCode, reason)
    if CA.SV.MiscTrade then
        printToChat(GetString("SI_TRADEACTIONRESULT", reason))
    end
    g_tradeStacksIn = {}
    g_tradeStacksOut = {}
    g_tradeInviter = ""
    g_tradeInvitee = ""
end

-- Sends results of the trade to the Item Log print function and clears variables so they are reset for next trade interactions
function CA.OnTradeSuccess(eventCode)
    g_comboString = ""

    if CA.SV.MiscTrade then
        printToChat(GetString(SI_TRADE_COMPLETE)) -- "Trade complete."
    end
    if CA.SV.MiscTrade and g_tradeString1 ~= "" then
        printToChat(g_tradeString1)
    end
    if CA.SV.MiscTrade and g_tradeString2 ~= "" then
        printToChat(g_tradeString2)
    end

    if CA.SV.LootTrade then
        if g_tradeInviter == "" then
            tradetarget = g_tradeInvitee
        end
        if g_tradeInvitee == "" then
            tradetarget = g_tradeInviter
        end
        for indexOut = 1,5 do
            if g_tradeStacksOut[indexOut] ~= nil then
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_TRADED)
                if CA.SV.ItemContextToggle then
                    logPrefix = ( CA.SV.ItemContextMessage )
                end
                local receivedBy = tradetarget
                local istrade = true
                local item = g_tradeStacksOut[indexOut]
                local itemType = GetItemLinkItemType(item.itemlink)
                icon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
                --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue) Hanging onto this for now
                CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainorloss, istrade)
            end
        end

        for indexIn = 1,5 do
            if g_tradeStacksIn[indexIn] ~= nil then
                local gainorloss = 1
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_TRADED)
                if CA.SV.ItemContextToggle then
                    logPrefix = ( CA.SV.ItemContextMessage )
                end
                local receivedBy = tradetarget
                local istrade = true
                local item = g_tradeStacksIn[indexIn]
                local itemType = GetItemLinkItemType(item.itemlink)
                icon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
                --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue) Hanging onto this for now
                CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainorloss, istrade)
            end
        end
    end

    g_tradeStacksIn = {}
    g_tradeStacksOut = {}
    g_tradeInviter = ""
    g_tradeInvitee = ""
    g_tradeString1 = ""
    g_tradeString2 = ""
end

function CA.MailMoneyChanged(eventCode, moneyAmount)
    g_mailMoney = moneyAmount
    g_mailCOD = 0
    g_postageAmount = GetQueuedMailPostage()
end

function CA.MailCODChanged(eventCode, codAmount)
    g_mailCOD = codAmount
    g_mailMoney = 0
    g_postageAmount = GetQueuedMailPostage()
end

function CA.MailRemoved(eventCode)
    if CA.SV.MiscMail then
        printToChat(GetString(SI_LUIE_CA_MAIL_DELETED_MSG))
    end
end

function CA.OnMailReadable(eventCode, mailId)
    g_mailStacks = {}

    local numAttachments = GetMailAttachmentInfo( mailId )

    for attachIndex = 1, numAttachments do
        local icon, stack = GetAttachedItemInfo( mailId,  attachIndex)
        local mailitemlink = GetAttachedItemLink( mailId,  attachIndex, LINK_STYLE_DEFAULT)
        g_mailStacks[attachIndex] = { stack=stack, icon=icon, itemlink=mailitemlink, }
    end
end

function CA.OnMailTakeAttachedItem(eventCode, mailId)
    g_comboString = ""
    local NumMails = 0
    local gainorloss = 1
    local logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN) -- "Received"
    local receivedBy = ""
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    for attachIndex = 1, #g_mailStacks do
        local item = g_mailStacks[attachIndex]
        local icon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
        local itemType = GetItemLinkItemType(item.itemlink)
        NumMails = NumMails+1
        --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue) Hanging onto this for now
        if CA.SV.LootMail then
            zo_callLater(function() CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainorloss) end , 50)
        end
    end

    local plural = "s"
    if NumMails == 1 then
        plural = ""
    end

    g_mailStringPart1 = (strformat(GetString(SI_LUIE_CA_MAIL_RECEIVED_ATTACHMENT), NumMails, plural) )
    zo_callLater(PrintMailAttachmentsIfNoGold, 25) -- We call this with a super short delay, it will return a string as long as a currency change event doesn't trigger beforehand!

    g_mailStacks = {}
end

function PrintMailAttachmentsIfNoGold()
    if CA.SV.MiscMail and g_mailStringPart1 ~= "" then
        printToChat(strformat("<<1>>.", g_mailStringPart1) ) -- Append a dot
    end
    g_mailStringPart1 = "" -- Important to clear this string, if we took a mail with only items attached, we don't want the next mail with gold to falsely show that attachments were taken!
end

function CA.OnMailAttach(eventCode, attachmentSlot)
    -- d(attachmentSlot) -- Debug
    g_postageAmount = GetQueuedMailPostage()
    local mailIndex = attachmentSlot
    local _, _, icon, stack = GetQueuedItemAttachmentInfo(attachmentSlot)
    local mailitemlink = GetMailQueuedAttachmentLink(attachmentSlot, LINK_STYLE_DEFAULT)
    g_mailStacksOut[mailIndex] = {stack=stack, name=name, icon=icon, itemlink=mailitemlink}
end

-- Removes items from index if they are removed from the trade
function CA.OnMailAttachRemove(eventCode, attachmentSlot)
    g_postageAmount = GetQueuedMailPostage()
    local mailIndex = attachmentSlot
    g_mailStacksOut[mailIndex] = nil
end

-- Cleanup if a Trade is canceled/exited
function CA.OnMailCloseBox(eventCode)
    g_mailStacksOut = {}
end

function CA.OnMailFail(eventCode, reason)
    if CA.SV.MiscMail then
        if reason == 2 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_FAILED_UNKNOWN_PLAYER))
        end
        if reason == 3 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_FAILED_RECIP_INBOX_FULL))
        end
        if reason == 4 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_FAILED_CANT_SEND_TO_RECIP))
        end
        if reason == 5 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_FAILED_NOT_ENOUGH_GOLD))
        end
        if reason == 11 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_FAILED_CANT_SEND_TO_SELF))
        end
        if reason == 9 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_FAILED_COD_NO_ATTACHMENT))
        end
        if reason == 7 then
            printToChat(GetString(SI_LUIE_CA_MAIL_SENT_FAILED_NO_SUB_BODY_ATTACHMENT))
        end
        g_mailStop = true
        zo_callLater(CA.MailClearVariables, 500)
    end
end

function CA.MailClearVariables()
    g_mailStop = false
    g_mailCurrencyCheck = true
end

-- Sends results of the trade to the Item Log print function and clears variables so they are reset for next trade interactions
function CA.OnMailSuccess(eventCode)
    g_comboString = ""
    local latency = GetLatency()
    latency = latency + 50
    zo_callLater(CA.FunctionMailCurrencyCheck, latency)

    if CA.SV.LootMail then
        for mailIndex = 1,6 do -- Have to iterate through all 6 possible mail attachments, otherwise nil values will bump later items off the list potentially.
            if g_mailStacksOut[mailIndex] ~= nil then
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SENT)
                    if CA.SV.ItemContextToggle then
                        logPrefix = ( CA.SV.ItemContextMessage )
                    end
                local receivedBy = ""
                local item = g_mailStacksOut[mailIndex]
                icon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
                local itemType = GetItemLinkItemType(item.itemlink)
                --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue) Hanging onto this for now
                CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainorloss)
            end
        end
    end

    g_mailStacksOut = {}
    g_mailCOD = 0
    g_mailMoney = 0
    g_postageAmount = 0
end

function CA.FunctionMailCurrencyCheck()
    if g_mailCurrencyCheck and CA.SV.MiscMail then
        printToChat(GetString(SI_LUIE_CA_MAIL_SENT_SUCCESS))
    end
end

function CA.LevelUpdateHelper()
    IsChampion = IsUnitChampion("player")

    if IsChampion then
        CurrentLevel = GetPlayerChampionPointsEarned()
        if CurrentLevel < 10 then
            CurrentLevel = 10  -- Probably don't really need this here, but it's not going to hurt.
        end
        XPLevel = GetNumChampionXPInChampionPoint(CurrentLevel)
        LevelContext = GetString(SI_MAIN_MENU_CHAMPION) -- "Champion"
    else
        CurrentLevel = GetUnitLevel ("player")
        XPLevel = GetNumExperiencePointsInLevel(CurrentLevel)
        LevelContext = GetString(SI_EXPERIENCE_LEVEL_LABEL) -- "Level"
    end
end

local function ExperiencePctToColour(xppct)
    return xppct == 100 and "71DE73" or xppct < 33.33 and "F27C7C" or xppct < 66.66 and "EDE858" or "CCF048"
end

function CA.PrintBufferedXP()
    if g_XPCombatBufferValue ~= 0 then
        printToChat(g_XPCombatBufferString) -- If we leveled up, then this variable will be true, and we want to smash all the buffered XP into the level up display!
        g_XPCombatBufferValue = 0
        g_XPCombatBufferString = ""
    end
end

function CA.OnLevelUpdate(eventCode, unitTag, level)
    if unitTag == ("player") then

        CA.LevelUpdateHelper()

        local icon = CA.SV.LevelUpIcon and ("|t16:16:LuiExtended/media/unitframes/unitframes_level_normal.dds|t ") or ( "" )
        local attribute
        local CurrentLevelFormatted = g_XP_BAR_COLORS:Colorize(LevelContext .. " " .. CurrentLevel)

        if IsChampion then
            attribute = GetChampionPointAttributeForRank( GetPlayerChampionPointsEarned()+1 )
            if attribute == ATTRIBUTE_NONE then
                icon = CA.SV.LevelUpIcon and ("|t16:16:LuiExtended/media/unitframes/unitframes_level_champion.dds|t ") or ( "" )
            end
            if attribute == ATTRIBUTE_HEALTH then
                icon = CA.SV.LevelUpIcon and ("|t16:16:/esoui/art/champion/champion_points_health_icon-hud-32.dds|t ") or ( "" )
            end
            if attribute == ATTRIBUTE_MAGICKA then
                icon = CA.SV.LevelUpIcon and ("|t16:16:/esoui/art/champion/champion_points_magicka_icon-hud-32.dds|t ") or ( "" )
            end
            if attribute == ATTRIBUTE_STAMINA then
                icon = CA.SV.LevelUpIcon and ("|t16:16:/esoui/art/champion/champion_points_stamina_icon-hud-32.ddst ") or ( "" )
            end
            CurrentLevelFormatted = g_CP_BAR_COLORS[attribute][2]:Colorize(LevelContext .. " " .. CurrentLevel)
        end

        if not g_levelChanged1 or g_crossover == 1 then
            if g_questString1 ~= "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString1)
                printToChat(g_questString2)
            elseif g_questString1 ~= "" and g_questString2 == "" and CA.SV.Experience then
                printToChat(g_questString1)
            elseif g_questString1 == "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString2)
            end

            if CA.SV.ExperienceLevelUp and g_crossover == 0 then
                if CA.SV.ExperienceColorLevel then
                    printToChat(strformat("<<1>><<2>><<3>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, CurrentLevelFormatted))
                else
                    printToChat(strformat("<<1>><<2>><<3>> <<4>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, LevelContext, CurrentLevel))
                end
            end
            if CA.SV.ExperienceLevelUp and g_crossover == 1 then
                if CA.SV.ExperienceColorLevel then
                    printToChat(strformat("<<1>><<2>><<3>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_CP), icon, CurrentLevelFormatted))
                else
                    printToChat(strformat("<<1>><<2>><<3>> <<4>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_CP), icon, LevelContext, CurrentLevel))
                end
            end
        else
            if g_questString1 ~= "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString1)
            elseif g_questString1 ~= "" and g_questString2 == "" and CA.SV.Experience then
                printToChat(g_questString1)
            elseif g_questString1 == "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString2)
            end

            if CA.SV.ExperienceLevelUp and g_crossover == 0 then
                if CA.SV.ExperienceColorLevel then
                    printToChat(strformat("<<1>><<2>><<3>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, CurrentLevelFormatted))
                else
                    printToChat(strformat("<<1>><<2>><<3>> <<4>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, LevelContext, CurrentLevel))
                end
            end
            if CA.SV.ExperienceLevelUp and g_crossover == 1 then
                if CA.SV.ExperienceColorLevel then
                    printToChat(strformat("<<1>><<2>><<3>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_CP), icon, CurrentLevelFormatted))
                else
                    printToChat(strformat("<<1>><<2>><<3>> <<4>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_CP), icon, LevelContext, CurrentLevel))
                end
            end

            if g_questString1 ~= "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString2)
            end
        end

    end
    g_weLeveled = 0
    g_crossover = 0
    g_questString1 = ""
    g_questString2 = ""
    g_questCombiner1 = ""
    g_questCombiner2 = ""
    g_questCombiner2Alt = ""
    g_levelChanged1 = false
    g_totalLevelAdjust = ""
    g_levelCarryOverValue = 0
end

function CA.OnChampionUpdate(eventCode, unitTag, oldChampionPoints, currentChampionPoints)
    if unitTag == ("player") then

        CA.LevelUpdateHelper()

        local attribute = GetChampionPointAttributeForRank( GetPlayerChampionPointsEarned()+1 )
        local icon
        if attribute == ATTRIBUTE_NONE then
            icon = CA.SV.LevelUpIcon and ("|t16:16:LuiExtended/media/unitframes/unitframes_level_champion.dds|t ") or ( "" )
        end
        if attribute == ATTRIBUTE_HEALTH then
            icon = CA.SV.LevelUpIcon and ("|t16:16:/esoui/art/champion/champion_points_health_icon-hud-32.dds|t ") or ( "" )
        end
        if attribute == ATTRIBUTE_MAGICKA then
            icon = CA.SV.LevelUpIcon and ("|t16:16:/esoui/art/champion/champion_points_magicka_icon-hud-32.dds|t ") or ( "" )
        end
        if attribute == ATTRIBUTE_STAMINA then
            icon = CA.SV.LevelUpIcon and ("|t16:16:/esoui/art/champion/champion_points_stamina_icon-hud-32.ddst ") or ( "" )
        end
        local CurrentLevelFormatted = g_CP_BAR_COLORS[attribute][2]:Colorize(LevelContext .. " " .. CurrentLevel)

        if not g_levelChanged1 or g_crossover == 1 then
            if g_questString1 ~= "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString1)
                printToChat(g_questString2)
            elseif g_questString1 ~= "" and g_questString2 == "" and CA.SV.Experience then
                printToChat(g_questString1)
            elseif g_questString1 == "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString2)
            end

            if CA.SV.ExperienceLevelUp then
                if CA.SV.ExperienceColorLevel then
                    printToChat(strformat(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, CurrentLevelFormatted))
                else
                    printToChat(strformat(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, LevelContext, CurrentLevel))
                end
            end
        else
            if g_questString1 ~= "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString1)
            elseif g_questString1 ~= "" and g_questString2 == "" and CA.SV.Experience then
                printToChat(g_questString1)
            elseif g_questString1 == "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString2)
            end

            if CA.SV.ExperienceLevelUp then
                if CA.SV.ExperienceColorLevel then
                    printToChat(strformat(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, CurrentLevelFormatted))
                else
                    printToChat(strformat(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), icon, LevelContext, CurrentLevel))
                end
            end

            if g_questString1 ~= "" and g_questString2 ~= "" and CA.SV.Experience then
                printToChat(g_questString2)
            end
        end

    end
    g_weLeveled = 0
    g_crossover = 0
    g_questString1 = ""
    g_questString2 = ""
    g_questCombiner1 = ""
    g_questCombiner2 = ""
    g_questCombiner2Alt = ""
    g_levelChanged1 = false
    g_totalLevelAdjust = ""
    g_levelCarryOverValue = 0
end

function CA.OnExperienceGain(eventCode, reason, level, previousExperience, currentExperience, championPoints)
    -- d("Experience Gain) previousExperience: " .. previousExperience .. " --- " .. "currentExperience: " .. currentExperience)
    local levelhelper = 0 -- Gives us the correct value of XP to use toward the next level when calculating progress after a level up

    -- Determines if we leveled up - Needs to be functioning even if we don't printout progress or current level
    if currentExperience >= XPLevel then
        if not IsChampion and CurrentLevel == 49 then -- If we are level 49 and we level up that means we've reached Champion Level, this means we need to update these values!
            g_crossover = 1 -- Variable incrementer to help us determine if we just reached Champion Level
            IsChampion = true
        end
        g_weLeveled = 1
        if IsChampion then
            CurrentLevel = GetPlayerChampionPointsEarned()
            if CurrentLevel < 10 then
                CurrentLevel = 10 -- Very important, if this player has never hit Champion level before, set the minimum possible value when hitting level 50.
            end
            XPLevel = GetNumChampionXPInChampionPoint(CurrentLevel)
            LevelContext = GetString(SI_MAIN_MENU_CHAMPION) -- "Champion"
        else
            CurrentLevel = CurrentLevel + 1
            XPLevel = GetNumExperiencePointsInLevel(CurrentLevel)
            LevelContext = GetString(SI_EXPERIENCE_LEVEL_LABEL) -- "Level"
        end
    end

    if IsChampion then
        levelhelper = GetPlayerChampionXP()
    else
        levelhelper = GetUnitXP ("player")
    end

    if g_crossover == 1 then
        levelhelper = GetNumExperiencePointsInLevel(49)
        XPLevel = GetNumExperiencePointsInLevel(49)
    end

        if CA.SV.Experience and ( not ( CA.SV.ExperienceHideCombat and reason == 0 ) or not reason == 0 ) then
            -- Change in Experience Points on gaining them
            local change = currentExperience - previousExperience
            local formathelper = " "
            local totallevel = ""
            local progressbrackets = ""
            local progress = "" -- String returned depending on whether Progress Option is toggled on or off

            -- Format Helper puts a space in if the player enters a value for Experience Name, this way they don't have to do this formatting themselves.
            if CA.SV.ExperienceName == ( "" ) then
                formathelper = ""
            end

            -- Displays an icon if enabled
            local icon = CA.SV.ExperienceIcon and ("|t16:16:/esoui/art/icons/icon_experience.dds|t " .. ZO_LocalizeDecimalNumber (change) .. formathelper .. CA.SV.ExperienceName ) or ( ZO_LocalizeDecimalNumber (change) .. formathelper .. CA.SV.ExperienceName )

            -- If quest turnin, we save the first part of this string to combine with another in case this is followed up by POI completion event too.
            if reason == 1 then
                g_levelCarryOverValue = currentExperience
                g_questCombiner1 = CA.SV.ExperienceIcon and ("|t16:16:/esoui/art/icons/icon_experience.dds|t " .. ZO_LocalizeDecimalNumber (change) .. formathelper .. CA.SV.ExperienceName ) or ( ZO_LocalizeDecimalNumber (change) .. formathelper .. CA.SV.ExperienceName )
            end

            -- Add to the throttled XP count if it is enabled
            if CA.SV.ExperienceThrottle > 0 and reason == 0 then
                g_XPCombatBufferValue = g_XPCombatBufferValue + change
                icon = CA.SV.ExperienceIcon and ("|t16:16:/esoui/art/icons/icon_experience.dds|t " .. ZO_LocalizeDecimalNumber (g_XPCombatBufferValue) .. formathelper .. CA.SV.ExperienceName ) or ( ZO_LocalizeDecimalNumber (g_XPCombatBufferValue) .. formathelper .. CA.SV.ExperienceName )
            end

            local xppct = 0    -- XP Percent
            local decimal = 0  -- If we're using a % value, this is the string that determines whether we have a decimal point or not.

            if CA.SV.ExperienceShowProgress then

                if CA.SV.ExperienceShowDecimal then
                        xppct = math.floor(10000*levelhelper/XPLevel) / 100
                else
                        xppct = math.floor(100*levelhelper/XPLevel)
                end

                if CA.SV.ExperienceShowPBrackets then -- If [Progress] display brackets are hidden, then the XP numbers will just print on the end
                    progressbrackets = strfmt( " %s", CA.SV.ExperienceProgressName )
                end

                -- Configures progress experience configuration options
                if CA.SV.ExperienceProgressColor then
                    decimal = strfmt( "|c%s%s", ExperiencePctToColour(xppct), xppct)
                else
                    decimal = strfmt( "%s", xppct)
                end

                if CA.SV.ExperienceDisplayOptions == 1 then
                    if CA.SV.ExperienceProgressColor then
                    progress = strfmt( "%s (|c%s%s|r/|c71DE73%s|r)", progressbrackets, ExperiencePctToColour(xppct), ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                    else
                    progress = strfmt( "%s (%s/%s)|r", progressbrackets, ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                    end
                elseif CA.SV.ExperienceDisplayOptions == 2 then
                    if CA.SV.ExperienceProgressColor then
                    progress = strfmt("%s (%s%%|r)", progressbrackets, decimal)
                    else
                    progress = strfmt("%s (%s%%|r)", progressbrackets, decimal)
                    end
                elseif CA.SV.ExperienceDisplayOptions == 3 then
                    if CA.SV.ExperienceProgressColor then
                    progress = strfmt("%s (%s%%|r - |c%s%s|r/|c71DE73%s|r)", progressbrackets, decimal, ExperiencePctToColour(xppct), ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                    else
                    progress = strfmt("%s (%s%%|r - %s/%s)|r", progressbrackets, decimal, ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                    end
                end

                --
                -- Big ass bullshit duplicate to create alternate string for Reason 2 on quest turnin with POI completion too
                if reason == 2 and g_questCombiner1 ~= "" then

                -- CALCULATION 1

                    levelhelper = levelhelper - change

                    if g_crossover == 1 then
                        levelhelper = XPLevel -- If we crossover XP on this level then we just auto set this to max xp/level value for 50.
                    end

                    if CA.SV.ExperienceShowDecimal then
                            xppct = math.floor(10000*levelhelper/XPLevel) / 100
                    else
                            xppct = math.floor(100*levelhelper/XPLevel)
                    end

                    -- Configures progress experience configuration options
                    if CA.SV.ExperienceProgressColor then
                        decimal = strfmt( "|c%s%s", ExperiencePctToColour(xppct), xppct)
                    else
                        decimal = strfmt( "%s", xppct)
                    end

                    if CA.SV.ExperienceDisplayOptions == 1 then
                        if CA.SV.ExperienceProgressColor then
                        g_questCombiner2 = strfmt( "%s (|c%s%s|r/|c71DE73%s|r)", progressbrackets, ExperiencePctToColour(xppct), ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                        else
                        g_questCombiner2 = strfmt( "%s (%s/%s)|r", progressbrackets, ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                        end
                    elseif CA.SV.ExperienceDisplayOptions == 2 then
                        if CA.SV.ExperienceProgressColor then
                        g_questCombiner2 = strfmt("%s (%s%%|r)", progressbrackets, decimal)
                        else
                        g_questCombiner2 = strfmt("%s (%s%%|r)", progressbrackets, decimal)
                        end
                    elseif CA.SV.ExperienceDisplayOptions == 3 then
                        if CA.SV.ExperienceProgressColor then
                        g_questCombiner2 = strfmt("%s (%s%%|r - |c%s%s|r/|c71DE73%s|r)", progressbrackets, decimal, ExperiencePctToColour(xppct), ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                        else
                        g_questCombiner2 = strfmt("%s (%s%%|r - %s/%s)|r", progressbrackets, decimal, ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevel) )
                        end
                    end

                -- CALCULATION 2

                    local XPLevelAlt

                    if IsChampion then
                        local AdjustLevel = GetPlayerChampionPointsEarned() -1
                        if AdjustLevel < 10 then
                            AdjustLevel = 10 -- Very important, if this player has never hit Champion level before, set the minimum possible value when hitting level 50.
                        end
                        XPLevelAlt = GetNumChampionXPInChampionPoint(AdjustLevel)
                        if g_crossover == 1 then
                            XPLevelAlt = GetNumExperiencePointsInLevel(49)
                        end
                    else
                        local AdjustLevel = CurrentLevel -1
                        XPLevelAlt = GetNumExperiencePointsInLevel(AdjustLevel)
                    end

                    levelhelper = g_levelCarryOverValue

                    if CA.SV.ExperienceShowDecimal then
                            xppct = math.floor(10000*levelhelper/XPLevelAlt) / 100
                    else
                            xppct = math.floor(100*levelhelper/XPLevelAlt)
                    end

                    -- Configures progress experience configuration options
                    if CA.SV.ExperienceProgressColor then
                        decimal = strfmt( "|c%s%s", ExperiencePctToColour(xppct), xppct)
                    else
                        decimal = strfmt( "%s", xppct)
                    end

                    if CA.SV.ExperienceDisplayOptions == 1 then
                        if CA.SV.ExperienceProgressColor then
                        g_questCombiner2Alt = strfmt( "%s (|c%s%s|r/|c71DE73%s|r)", progressbrackets, ExperiencePctToColour(xppct), ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevelAlt) )
                        else
                        g_questCombiner2Alt = strfmt( "%s (%s/%s)|r", progressbrackets, ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevelAlt) )
                        end
                    elseif CA.SV.ExperienceDisplayOptions == 2 then
                        if CA.SV.ExperienceProgressColor then
                        g_questCombiner2Alt = strfmt("%s (%s%%|r)", progressbrackets, decimal)
                        else
                        g_questCombiner2Alt = strfmt("%s (%s%%|r)", progressbrackets, decimal)
                        end
                    elseif CA.SV.ExperienceDisplayOptions == 3 then
                        if CA.SV.ExperienceProgressColor then
                        g_questCombiner2Alt = strfmt("%s (%s%%|r - |c%s%s|r/|c71DE73%s|r)", progressbrackets, decimal, ExperiencePctToColour(xppct), ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevelAlt) )
                        else
                        g_questCombiner2Alt = strfmt("%s (%s%%|r - %s/%s)|r", progressbrackets, decimal, ZO_LocalizeDecimalNumber (levelhelper), ZO_LocalizeDecimalNumber (XPLevelAlt) )
                        end
                    end
                -- End big ass bullshit duplicate function
                --

                end


            end

            if CA.SV.ExperienceShowLevel then
                local attribute
                if CA.SV.ExperienceColorLevel then
                    if IsChampion then
                        attribute = GetChampionPointAttributeForRank( GetPlayerChampionPointsEarned() +1)
                        totallevel = g_CP_BAR_COLORS[attribute][2]:Colorize(strfmt(" %s %s", LevelContext, CurrentLevel))
                    else
                        totallevel = g_XP_BAR_COLORS:Colorize(strfmt(" %s %s", LevelContext, CurrentLevel))
                    end
                else
                    totallevel = strfmt( " %s %s", LevelContext, CurrentLevel)
                end

                if g_questCombiner1 ~= "" then
                    if CA.SV.ExperienceColorLevel then
                        if IsChampion then
                            attribute = GetChampionPointAttributeForRank( GetPlayerChampionPointsEarned() )
                            g_totalLevelAdjust = g_CP_BAR_COLORS[attribute][2]:Colorize(strfmt(" %s %s", LevelContext, CurrentLevel -1))
                        else
                            g_totalLevelAdjust = g_XP_BAR_COLORS:Colorize(strfmt(" %s %s", LevelContext, CurrentLevel -1))
                        end
                    else
                        g_totalLevelAdjust = strfmt( " %s %s", LevelContext, CurrentLevel -1)
                    end
                end
            else
                if g_questCombiner1 ~= "" then
                    g_totalLevelAdjust = ""
                end
            end

            --[[ Crossover from Normal XP --> Champion XP modifier ]] --
            if g_crossover == 1 then
                -- progress = (progressbrackets .. " (Level 50)")
                totallevel = g_XP_BAR_COLORS:Colorize( strformat(" <<1>> 50", GetString(SI_EXPERIENCE_LEVEL_LABEL)) ) -- "Level"
                if g_questCombiner1 ~= "" then
                    -- g_questCombiner2 = (progressbrackets .. " (Level 50)")
                    if CA.SV.ExperienceShowLevel then
                        if CA.SV.ExperienceColorLevel then
                            g_totalLevelAdjust = g_XP_BAR_COLORS:Colorize( strformat(" <<1>> 49", GetString(SI_EXPERIENCE_LEVEL_LABEL)) )
                        else
                            g_totalLevelAdjust = strformat(" <<1>> 49", GetString(SI_EXPERIENCE_LEVEL_LABEL)) -- "Level"
                        end
                    end
                end
            end

        -- If we gain experience from a non combat source, and our buffer function holds a value, then we need to immediately dump this value before the next XP update is processed.
        if reason ~= 0 and CA.SV.ExperienceThrottle > 0 and g_XPCombatBufferValue > 0 then
            g_XPCombatBufferValue = 0
            printToChat(g_XPCombatBufferString)
        end

        if reason == 1 then
            if g_weLeveled == 1 then
                g_levelChanged1 = true
            end
            g_questString1 = ( strfmt("%s %s%s%s", CA.SV.ExperienceContextName, icon, progress, totallevel) )
            zo_callLater(CA.PrintQuestExperienceHelper, 100)
        elseif reason == 2 then
            if g_questCombiner1 ~= "" then
                if g_weLeveled == 1 and not g_levelChanged1 then
                    g_questString1 = ( strfmt("%s %s%s%s", CA.SV.ExperienceContextName, g_questCombiner1, g_questCombiner2Alt, g_totalLevelAdjust) )
                else
                    g_questString1 = ( strfmt("%s %s%s%s", CA.SV.ExperienceContextName, g_questCombiner1, g_questCombiner2, totallevel) )
                end
            end
            g_questString2 = ( strfmt("%s %s%s%s", CA.SV.ExperienceContextName, icon, progress, totallevel) )
            zo_callLater(CA.PrintQuestExperienceHelper, 100)
        elseif reason == 0 then
            if change > CA.SV.ExperienceFilter and CA.SV.ExperienceThrottle == 0 then
                printToChat(strfmt("%s %s%s%s", CA.SV.ExperienceContextName, icon, progress, totallevel) )
            elseif CA.SV.ExperienceThrottle > 0 then
                g_XPCombatBufferString = ( strfmt("%s %s%s%s", CA.SV.ExperienceContextName, icon, progress, totallevel) )
                local timer = CA.SV.ExperienceThrottle
                zo_callLater(CA.PrintBufferedXP, 5000)
            end
        else
            printToChat(strfmt("%s %s%s%s", CA.SV.ExperienceContextName, icon, progress, totallevel) )
        end
    end
end

function CA.PrintQuestExperienceHelper()
    if g_weLeveled == 1 then
        return
    end

    if g_questString1 ~= "" and g_questString2 ~= "" and CA.SV.Experience then
        printToChat(g_questString1)
        printToChat(g_questString2)
    elseif g_questString1 ~= "" and g_questString2 == "" and CA.SV.Experience then
        printToChat(g_questString1)
    elseif g_questString1 == "" and g_questString2 ~= "" and CA.SV.Experience then
        printToChat(g_questString2)
    end

    g_questString1 = ""
    g_questString2 = ""
    g_questCombiner1 = ""
    g_questCombiner2 = ""
    g_questCombiner2Alt = ""
    g_levelChanged1 = false
    g_totalLevelAdjust = ""
    g_levelCarryOverValue = 0
end

-- Helper function to return colour (without |c prefix) according to current percentage
local function AchievementPctToColour(pct)
    return pct == 1 and "71DE73" or pct < 0.33 and "F27C7C" or pct < 0.66 and "EDE858" or "CCF048"
end

function CA.OnAchievementUpdated(eventCode, aId)
    local topLevelIndex, categoryIndex, achievementIndex = GetCategoryInfoFromAchievementId(aId)

    -- Bail out if this achievement comes from unwanted category
    if topLevelIndex == 1 and not CA.SV.AchievementCategory1 then return end
    if topLevelIndex == 2 and not CA.SV.AchievementCategory2 then return end
    if topLevelIndex == 3 and not CA.SV.AchievementCategory3 then return end
    if topLevelIndex == 4 and not CA.SV.AchievementCategory4 then return end
    if topLevelIndex == 5 and not CA.SV.AchievementCategory5 then return end
    if topLevelIndex == 6 and not CA.SV.AchievementCategory6 then return end
    if topLevelIndex == 7 and not CA.SV.AchievementCategory7 then return end
    if topLevelIndex == 8 and not CA.SV.AchievementCategory8 then return end
    if topLevelIndex == 9 and not CA.SV.AchievementCategory9 then return end
    if topLevelIndex == 10 and not CA.SV.AchievementCategory10 then return end
    if topLevelIndex == 11 and not CA.SV.AchievementCategory11 then return end
    if topLevelIndex == 12 and not CA.SV.AchievementCategory12 then return end

    local link = strformat(GetAchievementLink(aId, LINK_STYLE_BRACKETS))
    local catName = GetAchievementCategoryInfo(topLevelIndex)

    local totalCmp = 0
    local totalReq = 0
    local showInfo = false

    local numCriteria = GetAchievementNumCriteria(aId)
    local cmpInfo = {}
    for i = 1, numCriteria do
        local name, numCompleted, numRequired = GetAchievementCriterion(aId, i)

        table.insert(cmpInfo, { strformat(name), numCompleted, numRequired })

        -- Collect the numbers to calculate the correct percentage
        totalCmp = totalCmp + numCompleted
        totalReq = totalReq + numRequired

        -- Show the achievement on every special achievement because it's a rare event
        if numRequired == 1 and numCompleted == 1 then
            showInfo = true
        end
    end

    if not showInfo then
        -- Achievement completed
        -- This is the first numCompleted value
        -- Show every time
        if ( totalCmp == totalReq ) or ( totalCmp == 1 ) or ( CA.SV.AchievementsStep == 0 ) then
            showInfo = true
        else
            -- Achievement step hit
            local percentage = math.floor( 100 / totalReq * totalCmp )

            if percentage > 0 and percentage % CA.SV.AchievementsStep == 0 and g_lastPercentage[aId] ~= percentage then
                showInfo = true
                g_lastPercentage[aId] = percentage
            end
        end
    end

    -- Bail out here if this achievement update event is not going to be printed to chat
    if not showInfo then
        return
    end

    -- Prepare details information
    local details
    if CA.SV.AchievementsDetails then
        -- Skyshards needs separate treatment otherwise text become too long
        -- We also put this short information for achievements that has too many subitems
        if topLevelIndex == 9 or #cmpInfo > 12 then
            details = strfmt( " > |c%s%d|c87B7CC/|c71DE73%d|c87B7CC.", AchievementPctToColour(totalCmp/totalReq), totalCmp, totalReq )
        else
            for i = 1, #cmpInfo do
                -- Boolean achievement stage
                if cmpInfo[i][3] == 1 then
                    cmpInfo[i] = strfmt( "|c%s%s", AchievementPctToColour(cmpInfo[i][2]), cmpInfo[i][1] )
                -- Others
                else
                    local pct = cmpInfo[i][2] / cmpInfo[i][3]
                    cmpInfo[i] = strfmt( "%s |c%s%d|c87B7CC/|c71DE73%d", cmpInfo[i][1], AchievementPctToColour(pct), cmpInfo[i][2], cmpInfo[i][3] )
                end
            end
            details = " > " .. table.concat(cmpInfo, "|c87B7CC, ") .. "|c87B7CC."
        end
    end

    printToChat( strfmt("|c87B7CC%s %s - |c%s%d%%|c87B7CC [%s]%s|r",
                            (totalCmp == totalReq) and "[Achivement Completed]" or "[Achievement Updated]",
                            link,
                            AchievementPctToColour(totalCmp/totalReq),
                            math.floor(100*totalCmp/totalReq),
                            catName,
                            details or "." )
                )
end

function CA.GuildBankItemAdded(eventCode, slotId)
    CA.LogItem(g_guildBankCarryLogPrefix, g_guildBankCarryIcon, g_guildBankCarryItemLink, g_guildBankCarryItemType, g_guildBankCarryStackCount or 1, g_guildBankCarryReceivedBy, g_guildBankCarryGainorloss)
    g_guildBankCarryLogPrefix = ""
    g_guildBankCarryIcon = ""
    g_guildBankCarryItemLink = ""
    g_guildBankCarryStackCount = 1
    g_guildBankCarryReceivedBy = ""
    g_guildBankCarryGainorloss = ""
    g_guildBankCarryItemType = ""
end

function CA.GuildBankItemRemoved(eventCode, slotId)
    CA.LogItem(g_guildBankCarryLogPrefix, g_guildBankCarryIcon, g_guildBankCarryItemLink, g_guildBankCarryItemType, g_guildBankCarryStackCount or 1, g_guildBankCarryReceivedBy, g_guildBankCarryGainorloss)
    g_guildBankCarryLogPrefix = ""
    g_guildBankCarryIcon = ""
    g_guildBankCarryItemLink = ""
    g_guildBankCarryStackCount = 1
    g_guildBankCarryReceivedBy = ""
    g_guildBankCarryGainorloss = ""
    g_guildBankCarryItemType = ""
end

function CA.IndexInventory()
    --d("Debug - Inventory Indexed!")
    local bagsize = GetBagSize(1)

    for i = 0,bagsize do
        local icon, stack = GetItemInfo(1, i)
        local bagitemlink = GetItemLink(1, i, LINK_STYLE_DEFAULT)
        if bagitemlink ~= "" then
            g_inventoryStacks[i] = { icon=icon, stack=stack, itemlink=bagitemlink}
        end
    end
end

function CA.IndexEquipped()
    --d("Debug - Equipped Items Indexed!")
    local bagsize = GetBagSize(0)

    for i = 0,bagsize do
        local icon, stack = GetItemInfo(0, i)
        local bagitemlink = GetItemLink(0, i, LINK_STYLE_DEFAULT)
        if bagitemlink ~= "" then
            g_equippedStacks[i] = { icon=icon, stack=stack, itemlink=bagitemlink}
        end
    end
end

function CA.IndexBank()
    --d("Debug - Bank Indexed!")
    local bagsizebank = GetBagSize(2)

    for i = 0,bagsizebank do
        local icon, stack = GetItemInfo(2, i)
        local bagitemlink = GetItemLink(2, i, LINK_STYLE_DEFAULT)
        if bagitemlink ~= "" then
            g_bankStacks[i] = { icon=icon, stack=stack, itemlink=bagitemlink}
        end
    end
end

function CA.CraftingOpen(eventCode, craftSkill, sameStation)
    g_inventoryStacks = {}
    g_bankStacks = {}
    CA.IndexInventory() -- Index Inventory
    CA.IndexBank() -- Index Bank
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateCraft)
end

function CA.CraftingClose(eventCode, craftSkill)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise) then
        g_inventoryStacks = {}
    end
    g_bankStacks = {}
end

function CA.BankOpen(eventCode)
    g_inventoryStacks = {}
    g_bankStacks = {}
    CA.IndexInventory() -- Index Inventory
    CA.IndexBank() -- Index Bank
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateBank)
end

function CA.BankClose(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise) then
        g_inventoryStacks = {}
    end
    g_bankStacks = {}
end

function CA.GuildBankOpen(eventCode)
    g_inventoryStacks = {}
    CA.IndexInventory() -- Index Inventory
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateGuildBank)
end

function CA.GuildBankClose(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise) then
        g_inventoryStacks = {}
    end
end

function CA.FenceOpen(eventCode, allowSell, allowLaunder)
    g_inventoryStacks = {}
    CA.IndexInventory() -- Index Inventory
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateFence)
end

function CA.StoreClose(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise) then
        g_inventoryStacks = {}
    end
end

function CA.FenceSuccess(eventCode, result)
    if result == 1 then
        g_isValidLaunder = true
        CA.FenceHelper() -- Can probably consolidate this, however leaving the functions separated until no bugs confirmed. Was thinking about putting a 50 ms delay on it just to make sure everything has time to go through.
    end
end

function CA.FenceHelper()
    if not CA.SV.LootCurrencyCombo then
        printToChat(g_launderGoldstring)
        printToChat(g_launderItemstring)
    else
        printToChat(strformat("<<1>> → <<2>>", g_launderItemstring, g_launderGoldstring))
    end

    g_launderGoldstring = ""
    g_launderItemstring = ""
    g_isValidLaunder = false
end

-- Only active if destroyed items is enabled, flags the next item that is removed from inventory as destroyed.
function CA.DestroyItem(eventCode, itemSoundCategory)
    g_itemWasDestroyed = true
end

-- Helper function for Craft Bag
function CA.GetItemLinkFromItemId(itemId)
    local name = GetItemLinkName(ZO_LinkHandler_CreateLink("Test Trash", nil, ITEM_LINK_TYPE,itemId, 1, 26, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 10000, 0))
    return ZO_LinkHandler_CreateLink(strformat("<<t:1>>", name), nil, ITEM_LINK_TYPE,itemId, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
end

-- Only used if the option to see destroyed items or items lost from a guard is turned on
function CA.InventoryUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    if bagId == BAG_WORN then
        local receivedBy = ""
        if not g_equippedStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_equippedStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_equippedStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainorloss = 3
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DISGUISE_EQUIP)
            if CA.SV.ShowDisguise and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss) end

        elseif g_equippedStacks[slotId] then -- EXISTING ITEM
            -- Means item was modified (enchanted, etc)
            if stackCountChange == 0 then -- For equipment, stackCountChange 0 is also applied when gear is swapped out. This means we need to update the index on this change.
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                g_equippedStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                if CA.SV.ShowDisguise and slotId == 10 then
                    local item = g_equippedStacks[slotId]
                    local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
                    local itemType = GetItemLinkItemType(item.itemlink)
                    local gainorloss = 3
                    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DISGUISE_EQUIP)
                    if (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss) end
                end
            end

            local item = g_equippedStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainorloss = 1
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_GAINEDSTACK)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                -- CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                g_equippedStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 3
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DISGUISE_UNEQUIP)
                local change = (stackCountChange * -1)
                local endcount = g_equippedStacks[slotId].stack - change
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                    if CA.SV.ShowDisguise and not g_itemWasDestroyed and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                        if IsUnitInCombat("player") then
                            logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DISGUISE_DESTROYED)
                            gainorloss = 2
                        end
                        CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                    end
                    if CA.SV.ShowDestroy and g_itemWasDestroyed then
                        logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                        gainorloss = 2
                        CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                    end
                    g_equippedStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_equippedStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
    end

    if bagId == BAG_BACKPACK then
        local receivedBy = ""
        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainorloss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOOTEDITEM)
            -- CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)

        elseif g_inventoryStacks[slotId] then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            -- Means item was modified (enchanted, etc)
            if stackCountChange == 0 then
                return
            end

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainorloss = 1
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_GAINEDSTACK)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                -- CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}
            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                    if CA.SV.ShowDestroy and g_itemWasDestroyed then
                        CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                    end
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
    end

    g_itemWasDestroyed = false
end

function CA.InventoryUpdateCraft(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local receivedBy = "CRAFT"
        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainorloss = 1
            local logPrefix = GetString(SI_ITEM_FORMAT_STR_CRAFTED)

            if itemType == ITEMTYPE_ADDITIVE
            or itemType == ITEMTYPE_ARMOR_BOOSTER
            or itemType == ITEMTYPE_ARMOR_TRAIT
            or itemType == ITEMTYPE_BLACKSMITHING_BOOSTER
            or itemType == ITEMTYPE_BLACKSMITHING_MATERIAL
            or itemType == ITEMTYPE_CLOTHIER_BOOSTER
            or itemType == ITEMTYPE_CLOTHIER_MATERIAL
            or itemType == ITEMTYPE_ENCHANTING_RUNE_ASPECT
            or itemType == ITEMTYPE_ENCHANTING_RUNE_ESSENCE
            or itemType == ITEMTYPE_ENCHANTING_RUNE_POTENCY
            or itemType == ITEMTYPE_ENCHANTMENT_BOOSTER
            or itemType == ITEMTYPE_INGREDIENT
            or itemType == ITEMTYPE_POISON_BASE
            or itemType == ITEMTYPE_POTION_BASE
            or itemType == ITEMTYPE_REAGENT
            or itemType == ITEMTYPE_STYLE_MATERIAL
            or itemType == ITEMTYPE_WEAPON_BOOSTER
            or itemType == ITEMTYPE_WEAPON_TRAIT
            or itemType == ITEMTYPE_WOODWORKING_BOOSTER
            or itemType == ITEMTYPE_WOODWORKING_MATERIAL then
                logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN) end -- "Receieved"

            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
        elseif g_inventoryStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            g_oldItemLink = g_inventoryStacks[slotId].itemlink -- Sends over to LogItem to do an upgrade string!
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainorloss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED)
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainorloss)
        elseif g_inventoryStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
               local gainorloss = 1
               local logPrefix = GetString(SI_ITEM_FORMAT_STR_CRAFTED)

                if itemType == ITEMTYPE_ADDITIVE
                or itemType == ITEMTYPE_ARMOR_BOOSTER
                or itemType == ITEMTYPE_ARMOR_TRAIT
                or itemType == ITEMTYPE_BLACKSMITHING_BOOSTER
                or itemType == ITEMTYPE_BLACKSMITHING_MATERIAL
                or itemType == ITEMTYPE_CLOTHIER_BOOSTER
                or itemType == ITEMTYPE_CLOTHIER_MATERIAL
                or itemType == ITEMTYPE_ENCHANTING_RUNE_ASPECT
                or itemType == ITEMTYPE_ENCHANTING_RUNE_ESSENCE
                or itemType == ITEMTYPE_ENCHANTING_RUNE_POTENCY
                or itemType == ITEMTYPE_ENCHANTMENT_BOOSTER
                or itemType == ITEMTYPE_INGREDIENT
                or itemType == ITEMTYPE_POISON_BASE
                or itemType == ITEMTYPE_POTION_BASE
                or itemType == ITEMTYPE_REAGENT
                or itemType == ITEMTYPE_STYLE_MATERIAL
                or itemType == ITEMTYPE_WEAPON_BOOSTER
                or itemType == ITEMTYPE_WEAPON_TRAIT
                or itemType == ITEMTYPE_WOODWORKING_BOOSTER
                or itemType == ITEMTYPE_WOODWORKING_MATERIAL then
                    logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN) end -- "Receieved"

               local icon, stack = GetItemInfo(bagId, slotId)
               local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
               CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
               g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DECONSTRUCTED)

                if itemType == ITEMTYPE_ADDITIVE
                or itemType == ITEMTYPE_ARMOR_BOOSTER
                or itemType == ITEMTYPE_ARMOR_TRAIT
                or itemType == ITEMTYPE_BLACKSMITHING_BOOSTER
                or itemType == ITEMTYPE_BLACKSMITHING_MATERIAL
                or itemType == ITEMTYPE_CLOTHIER_BOOSTER
                or itemType == ITEMTYPE_CLOTHIER_MATERIAL
                or itemType == ITEMTYPE_ENCHANTING_RUNE_ASPECT
                or itemType == ITEMTYPE_ENCHANTING_RUNE_ESSENCE
                or itemType == ITEMTYPE_ENCHANTING_RUNE_POTENCY
                or itemType == ITEMTYPE_ENCHANTMENT_BOOSTER
                or itemType == ITEMTYPE_INGREDIENT
                or itemType == ITEMTYPE_POISON_BASE
                or itemType == ITEMTYPE_POTION_BASE
                or itemType == ITEMTYPE_REAGENT
                or itemType == ITEMTYPE_STYLE_MATERIAL
                or itemType == ITEMTYPE_WEAPON_BOOSTER
                or itemType == ITEMTYPE_WEAPON_TRAIT
                or itemType == ITEMTYPE_WOODWORKING_BOOSTER
                or itemType == ITEMTYPE_WOODWORKING_MATERIAL then
                    logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_USED)
                elseif itemType == ITEMTYPE_BLACKSMITHING_RAW_MATERIAL
                or itemType == ITEMTYPE_CLOTHIER_RAW_MATERIAL
                or itemType == ITEMTYPE_WOODWORKING_RAW_MATERIAL then
                    logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_REFINED) end

                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                if logPrefix ~= GetString(SI_LUIE_CA_PREFIX_MESSAGE_USED) or CA.SV.ShowCraftUse then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                end
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
    end

    ---------------------------------- BANK ----------------------------------
    if bagId == BAG_BANK then
        local receivedBy = "CRAFT"
        if not g_bankStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainorloss = 1
            local logPrefix = strformat("<<1>> - <<2>>", GetString(SI_ITEM_FORMAT_STR_CRAFTED), GetString(SI_INTERACT_OPTION_BANK))
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
        elseif g_bankStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            g_oldItemLink = g_bankStacks[slotId].itemlink -- Sends over to LogItem to do an upgrade string!
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainorloss = 1
            local logPrefix = strformat("<<1>> - <<2>>", GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED), GetString(SI_INTERACT_OPTION_BANK))
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainorloss)
        elseif g_bankStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
               local gainorloss = 1
               local logPrefix = strformat("<<1>> - <<2>>", GetString(SI_ITEM_FORMAT_STR_CRAFTED), GetString(SI_INTERACT_OPTION_BANK))
               local icon, stack = GetItemInfo(bagId, slotId)
               local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
               CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
               g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 2
                local logPrefix = strformat("<<1>> - <<2>>", GetString(SI_LUIE_CA_PREFIX_MESSAGE_DECONSTRUCTED), GetString(SI_INTERACT_OPTION_BANK))

        if itemType == ITEMTYPE_ADDITIVE
        or itemType == ITEMTYPE_ARMOR_BOOSTER
        or itemType == ITEMTYPE_ARMOR_TRAIT
        or itemType == ITEMTYPE_BLACKSMITHING_BOOSTER
        or itemType == ITEMTYPE_BLACKSMITHING_MATERIAL
        or itemType == ITEMTYPE_CLOTHIER_BOOSTER
        or itemType == ITEMTYPE_CLOTHIER_MATERIAL
        or itemType == ITEMTYPE_ENCHANTING_RUNE_ASPECT
        or itemType == ITEMTYPE_ENCHANTING_RUNE_ESSENCE
        or itemType == ITEMTYPE_ENCHANTING_RUNE_POTENCY
        or itemType == ITEMTYPE_ENCHANTMENT_BOOSTER
        or itemType == ITEMTYPE_INGREDIENT
        or itemType == ITEMTYPE_POISON_BASE
        or itemType == ITEMTYPE_POTION_BASE
        or itemType == ITEMTYPE_REAGENT
        or itemType == ITEMTYPE_STYLE_MATERIAL
        or itemType == ITEMTYPE_WEAPON_BOOSTER
        or itemType == ITEMTYPE_WEAPON_TRAIT
        or itemType == ITEMTYPE_WOODWORKING_BOOSTER
        or itemType == ITEMTYPE_WOODWORKING_MATERIAL then
            logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_USED)
        elseif itemType == ITEMTYPE_BLACKSMITHING_RAW_MATERIAL
        or itemType == ITEMTYPE_CLOTHIER_RAW_MATERIAL
        or itemType == ITEMTYPE_WOODWORKING_RAW_MATERIAL then
            logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_REFINED) end

                local change = (stackCountChange * -1)
                local endcount = g_bankStacks[slotId].stack - change
                if logPrefix ~= GetString(SI_LUIE_CA_PREFIX_MESSAGE_USED) or CA.SV.ShowCraftUse then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                end
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                    g_bankStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
    end

    ---------------------------------- CRAFTING BAG ----------------------------------
    if bagId == BAG_VIRTUAL then
        local itemlink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemlink)
        icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
        local receivedBy = "CRAFT"
        local gainorloss = 1
        local logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN) -- "Received"
        local stack = stackCountChange
        local itemType = GetItemLinkItemType(itemlink)

        if stackCountChange < 1 then
            gainorloss = 2
            logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_USED)
            stack = stackCountChange * -1
            if itemType == ITEMTYPE_BLACKSMITHING_RAW_MATERIAL or itemType == ITEMTYPE_CLOTHIER_RAW_MATERIAL or itemType == ITEMTYPE_WOODWORKING_RAW_MATERIAL then
                logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_REFINED)
            end
        end

        if logPrefix ~= GetString(SI_LUIE_CA_PREFIX_MESSAGE_USED) or CA.SV.ShowCraftUse then
            CA.LogItem(logPrefix, icon, itemlink, itemType, stack or 1, receivedBy, gainorloss)
        end
    end

    g_itemWasDestroyed = false
end

function CA.InventoryUpdateBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local receivedBy = ""
        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainorloss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
            if InventoryOn then
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                InventoryOn = false
            end
        --[[elseif g_inventoryStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainorloss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED)
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainorloss) -- Shouldn't need this for anything, but just in case. ]]-- Shouldn't be neccesary
        elseif g_inventoryStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainorloss = 1
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                if InventoryOn then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                    InventoryOn = false
                end
               g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                if CA.SV.ShowDestroy and g_itemWasDestroyed then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                end
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index
                    -- if InventoryOn then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss) InventoryOn = false end
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
        if not g_itemWasDestroyed then
            BankOn = true
        end
        if not g_itemWasDestroyed then
            InventoryOn = false
        end
        if not g_itemWasDestroyed then
            zo_callLater(CA.BankFixer, 50)
        end
    end

    ---------------------------------- BANK ----------------------------------
    if bagId == BAG_BANK then
        local receivedBy = ""
        if not g_bankStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainorloss = 2
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
            if BankOn then
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                BankOn = false
            end
        --[[elseif g_bankStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            g_oldItemLink = g_bankStacks[slotId].itemlink -- Sends over to LogItem to do an upgrade string!
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainorloss = 1
            local logPrefix = "Upgraded - Bank"]]--
        elseif g_bankStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                if BankOn then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                    BankOn = false
                end
                g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 2
                local logPrefix = strformat("<<1>> - <<2>>", GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED), GetString(SI_INTERACT_OPTION_BANK) )
                local change = (stackCountChange * -1)
                local endcount = g_bankStacks[slotId].stack - change
                if CA.SV.ShowDestroy and g_itemWasDestroyed then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                end
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                    -- if BankOn then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss) BankOn = false end
                    g_bankStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
            if not g_itemWasDestroyed then
                InventoryOn = true
            end
            if not g_itemWasDestroyed then
                BankOn = false
            end
            if not g_itemWasDestroyed then
                zo_callLater(CA.BankFixer, 50)
            end
        end
    end

    --[[
    POSSIBLY ADD MORE SUPPORT HERE FOR CRAFT BAG EXTENDED, RIGHT NOW STOWING OR RETRIEVING MATERIALS TO PLAYER BAG SHOWS DEPOSIT/WITHDRAW MESSAGE
    --]]

    if bagId == BAG_VIRTUAL then
        local itemlink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemlink)
        icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
        local receivedBy = ""
        local gainorloss = 1
        local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
        local stack = stackCountChange
        local itemType = GetItemLinkItemType(itemlink)

        if stackCountChange < 1 then
            gainorloss = 2
            logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
            stack = stackCountChange * -1
        end

        CA.LogItem(logPrefix, icon, itemlink, itemType, stack or 1, receivedBy, gainorloss)
    end

    g_itemWasDestroyed = false
end

function CA.InventoryUpdateGuildBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local receivedBy = ""
        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            g_guildBankCarryIcon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            g_guildBankCarryGainorloss = 1
            g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
            g_guildBankCarryReceivedBy = ""
            g_guildBankCarryItemLink = item.itemlink
            g_guildBankCarryStackCount = stackCountChange or 1
            g_guildBankCarryItemType = GetItemLinkItemType(item.itemlink)
        --[[elseif g_inventoryStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainorloss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED)
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainorloss) -- Shouldn't need this for anything, but just in case. ]]-- Shouldn't be neccesary
        elseif g_inventoryStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
               local icon, stack = GetItemInfo(bagId, slotId)
               local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
               g_guildBankCarryIcon = seticon
               g_guildBankCarryGainorloss = 1
               g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
               g_guildBankCarryReceivedBy = ""
               g_guildBankCarryItemLink = item.itemlink
               g_guildBankCarryStackCount = stackCountChange or 1
               g_guildBankCarryItemType = GetItemLinkItemType(item.itemlink)
               g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                g_guildBankCarryIcon = seticon
                g_guildBankCarryGainorloss = 2
                g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
                g_guildBankCarryReceivedBy = ""
                g_guildBankCarryItemLink = item.itemlink
                g_guildBankCarryStackCount = change or 1
                g_guildBankCarryItemType = GetItemLinkItemType(item.itemlink)
                if CA.SV.ShowDestroy and g_itemWasDestroyed
                    then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                end
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
    end

    ---------------------------------- CRAFTING BAG ----------------------------------
    if bagId == BAG_VIRTUAL then
        local receivedBy = ""
        local gainorloss = 1
        local logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN) -- "Received"
        local itemlink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemlink)
        local seticon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

        g_guildBankCarryIcon = seticon
        g_guildBankCarryGainorloss = 1
        g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
        g_guildBankCarryReceivedBy = ""
        g_guildBankCarryItemLink = itemlink
        g_guildBankCarryStackCount = stackCountChange or 1
    end

    g_itemWasDestroyed = false
end

function CA.InventoryUpdateFence(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local receivedBy = ""
        if not g_inventoryStacks[slotId] and stackCountChange > 0 then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainorloss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
            g_launderCheck = true
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
        elseif g_inventoryStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local itemType = GetItemLinkItemType(item.itemlink)
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainorloss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
            g_launderCheck = true
            if itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR or itemType == ITEMTYPE_JEWELRY then
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainorloss)
            end
        elseif g_inventoryStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainorloss = 1
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                g_launderCheck = true
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainorloss)
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}
            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                --CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                    if CA.SV.ShowDestroy and g_itemWasDestroyed then
                        CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainorloss)
                    end
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_DEFAULT)
                    g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
    end

    ---------------------------------- CRAFTING BAG ----------------------------------
    if bagId == BAG_VIRTUAL then
        local itemlink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemlink)
        icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
        local receivedBy = ""
        local gainorloss = 1
        local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
        local stack = stackCountChange
        local itemType = GetItemLinkItemType(itemlink)

        -- Laundering won't ever remove things from the bag, so ignore
        if stackCountChange < 1 then
            return
        end

        g_launderCheck = true
        CA.LogItem(logPrefix, icon, itemlink, itemType, stack or 1, receivedBy, gainorloss)
    end

    g_itemWasDestroyed = false
    g_comboString = ""
    g_launderCheck = false
end

-- Makes it so bank withdraw/deposit events only occur when we can confirm the item is crossing over.
function CA.BankFixer()
    InventoryOn = false
    BankOn = false
end

function CA.JusticeStealRemove(eventCode)
    local ConfiscateMessage = GetString(SI_LUIE_CA_JUSTICE_CONFISCATED_MSG)
    if CA.SV.MiscConfiscate and eventCode == 131555 then
        ConfiscateMessage = GetString(SI_LUIE_CA_JUSTICE_CONFISCATED_BOUNTY_ITEMS_MSG)
    end

    if g_stealString == "" then
        return
    end

    if CA.SV.MiscConfiscate then
        printToChat(ConfiscateMessage)
    end

    printToChat(g_stealString)
    g_stealString = ""
    ConfiscateMessage = (GetString(SI_LUIE_CA_JUSTICE_CONFISCATED_MSG))

    if CA.SV.ShowConfiscate then
        zo_callLater(CA.JusticeRemovePrint, 50)
    end
end

function CA.JusticeRemovePrint()
    -- PART 1 -- INVENTORY
    local bagsize = GetBagSize(1)

    for i = 1,bagsize do
        local icon, stack = GetItemInfo(1, i)
        local bagitemlink = GetItemLink(1, i, LINK_STYLE_DEFAULT)
        if bagitemlink ~= "" then
            g_JusticeStacks[i] = {icon=icon, stack=stack, itemlink=bagitemlink}
        end
    end

    for i = 1,bagsize do
        local inventoryitem = g_inventoryStacks[i]
        local justiceitem = g_JusticeStacks[i]
        if inventoryitem ~= nil then
            if justiceitem == nil then
                local seticon = ( CA.SV.LootIcons and inventoryitem.icon and inventoryitem.icon ~= "" ) and ("|t16:16:" .. inventoryitem.icon .. "|t ") or ""
                local itemType = GetItemLinkItemType(inventoryitem.itemlink)
                local stack = inventoryitem.stack
                local receivedBy = ""
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_CONFISCATED)
                if CA.SV.ShowConfiscate then
                    CA.LogItem(logPrefix, seticon, inventoryitem.itemlink, itemType, stack or 1, receivedBy, gainorloss)
                end
            end
        end
    end


    -- Reset Justice Stacks to reuse for equipped
    g_JusticeStacks = {}

    -- PART 2 -- EQUIPPED
    bagsize = GetBagSize(0)

        -- We have to determine the currently active weapon, and swap the slots because of some wierd interaction when your equipped weapon is confiscated.
        -- This works even if the other weapon slot is empty or both slots have a stolen weapon.
        local weaponInfo = GetActiveWeaponPairInfo()

        -- Save weapons
        local W1 = g_equippedStacks[4]
        local W2 = g_equippedStacks[5]
        local W3 = g_equippedStacks[20]
        local W4 = g_equippedStacks[21]

        -- Swap weapons depending on currently equipped pair
        if WeaponInfo == 1 then
        g_equippedStacks[4] = W3
        g_equippedStacks[5] = W4
        end

        if WeaponInfo == 2 then
        g_equippedStacks[20] = W1
        g_equippedStacks[21] = W2
        end


    for i = 1,bagsize do
        local icon, stack = GetItemInfo(0, i)
        local bagitemlink = GetItemLink(0, i, LINK_STYLE_DEFAULT)
        if bagitemlink ~= "" then
            g_JusticeStacks[i] = {icon=icon, stack=stack, itemlink=bagitemlink}
        end
    end

    for i = 1,bagsize do
        local inventoryitem = g_equippedStacks[i]
        local justiceitem = g_JusticeStacks[i]
        if inventoryitem ~= nil then
            if justiceitem == nil then
                local seticon = ( CA.SV.LootIcons and inventoryitem.icon and inventoryitem.icon ~= "" ) and ("|t16:16:" .. inventoryitem.icon .. "|t ") or ""
                local itemType = GetItemLinkItemType(inventoryitem.itemlink)
                local stack = inventoryitem.stack
                local receivedBy = ""
                local gainorloss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_CONFISCATEDEQUIPPED)
                if CA.SV.ShowConfiscate then
                    CA.LogItem(logPrefix, seticon, inventoryitem.itemlink, itemType, stack or 1, receivedBy, gainorloss)
                end
            end
        end
    end

    g_JusticeStacks = {} -- Clear the Justice Item Stacks since we don't need this for anything else!
    g_equippedStacks = {}
    g_inventoryStacks = {}
    CA.IndexEquipped()
    CA.IndexInventory() -- Reindex the inventory with the correct values!
end

--[[ I would have liked to have this optional feature, but it gets out of snyc sometimes so kind of ruins it
function CA.DuelCountdown(eventCode, startTimeMS)
    local duelcounter = 6

    local function DuelCountdown()
        duelcounter = duelcounter - 1
        printToChat(strformat(GetString(SI_DUELING_COUNTDOWN_CSA), duelcounter))
    end

    printToChat(strformat(GetString(SI_DUELING_COUNTDOWN_CSA), duelcounter))
    zo_callLater(DuelCountdown, 1000)
    zo_callLater(DuelCountdown, 2000)
    zo_callLater(DuelCountdown, 3000)
    zo_callLater(DuelCountdown, 4000)
    zo_callLater(DuelCountdown, 5000)
end
]]--

function CA.DuelInviteReceived(eventCode, inviterCharacterName, inviterDisplayName)
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(inviterCharacterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", inviterCharacterName, inviterDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, inviterDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        printToChat(strformat(GetString(SI_DUEL_INVITE_RECEIVED), displayNameLink))
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        printToChat(strformat(GetString(SI_DUEL_INVITE_RECEIVED), characterNameLink))
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        printToChat(strformat(GetString(SI_DUEL_INVITE_RECEIVED), displayBoth))
    end
end

function CA.DuelInviteAccepted(eventCode)
    printToChat(GetString(SI_DUEL_INVITE_ACCEPTED))
end

function CA.DuelInviteSent(eventCode, inviteeCharacterName, inviteeDisplayName)
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(inviteeCharacterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviteeDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", inviteeCharacterName, inviteeDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, inviteeDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        printToChat(strformat(GetString(SI_DUEL_INVITE_SENT), displayNameLink))
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        printToChat(strformat(GetString(SI_DUEL_INVITE_SENT), characterNameLink))
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        printToChat(strformat(GetString(SI_DUEL_INVITE_SENT), displayBoth))
    end
end

function CA.DuelFinished(eventCode, duelResult, wasLocalPlayersResult, opponentCharacterName, opponentDisplayName, opponentAlliance, opponentGender, opponentClassId, opponentRaceId)
    local resultName

    if wasLocalPlayersResult then -- Possibly replace this with just a simple string assignment of "You"
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(g_playerName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(g_playerDisplayName)
        local displayBothString = ( strformat("<<1>><<2>>", g_playerName, g_playerDisplayName) )
        local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, g_playerDisplayName)

        if CA.SV.ChatPlayerDisplayOptions == 1 then
            resultName = displayNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            resultName = characterNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            resultName = displayBoth
        end
    else
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(opponentCharacterName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(opponentDisplayName)
        local displayBothString = ( strformat("<<1>><<2>>", opponentCharacterName, opponentDisplayName) )
        local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, opponentDisplayName)

        if CA.SV.ChatPlayerDisplayOptions == 1 then
            resultName = displayNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            resultName = characterNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            resultName = displayBoth
        end
    end

    if duelResult == 0 then
        printToChat(strformat(GetString(SI_DUELRESULT0), resultName))
    else
        printToChat(strformat(GetString(SI_DUELRESULT1), resultName))
    end
end

function CA.DuelInviteFailed(eventCode, reason, targetCharacterName, targetDisplayName)
    local reasonName
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(targetCharacterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(targetDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", targetCharacterName, targetDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, targetDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        reasonName = displayNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        reasonName = characterNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        reasonName = displayBoth
    end

    printToChat(strformat(GetString("SI_DUELINVITEFAILREASON", reason), reasonName))
end

function CA.DuelInviteDeclined(eventCode)
    printToChat(GetString(SI_DUEL_INVITE_DECLINED))
end

function CA.DuelInviteCanceled(eventCode)
    printToChat(GetString(SI_DUEL_INVITE_CANCELED))
end

function CA.DuelNearBoundary(eventCode, isInWarningArea)
    if isInWarningArea then
        printToChat(GetString(SI_DUELING_NEAR_BOUNDARY_CSA))
    end
end

function CA.DuelStarted(eventCode)
    printToChat(GetString(SI_LUIE_CA_DUEL_STARTED))
end

function CA.DisguiseState(eventCode, unitTag, disguiseState)
        if CA.SV.MiscDisguiseAlert and disguiseState == DISGUISE_STATE_DANGER then
            printToChat("Danger! Sentry nearby!")
        end
        
        if CA.SV.MiscDisguiseAlert and disguiseState == DISGUISE_STATE_SUSPICIOUS then
            printToChat("Danger! You are arousing suspicion!")
        end

        -- If we're still disguised and g_disguiseState is true then don't waste resources and end the function
        if g_disguiseState == 1 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            return
        end

        if g_disguiseState == 1 and (disguiseState == DISGUISE_STATE_NONE) then
            printToChat ("You are no longer disguised " .. E.DisguiseIcons[g_currentDisguise].description)
        end

        if g_disguiseState == 0 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
            g_currentDisguise = GetItemId(0, 10) or 0
            printToChat ("You are now disguised " .. E.DisguiseIcons[g_currentDisguise].description)
        end

        g_disguiseState = GetUnitDisguiseState("player")
        
        if g_disguiseState > 0 then
            g_disguiseState = 1
        end
end

function CA.MaraOffer(eventCode, targetCharacterName, isSender, targetDisplayName)
    local maraName
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(targetCharacterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(targetDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", targetCharacterName, targetDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, targetDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then maraName = displayNameLink end
    if CA.SV.ChatPlayerDisplayOptions == 2 then maraName = characterNameLink end
    if CA.SV.ChatPlayerDisplayOptions == 3 then maraName = displayBoth end

    if isSender then
        printToChat(strformat(GetString(SI_PLAYER_TO_PLAYER_OUTGOING_RITUAL_OF_MARA), maraName))
    else
        printToChat(strformat(GetString(SI_PLAYER_TO_PLAYER_INCOMING_RITUAL_OF_MARA), maraName))
    end
end

function CA.MaraResult (eventCode, reason, targetCharacterName, targetDisplayName)
    local maraName
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(targetCharacterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(targetDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", targetCharacterName, targetDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, targetDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then maraName = displayNameLink end
    if CA.SV.ChatPlayerDisplayOptions == 2 then maraName = characterNameLink end
    if CA.SV.ChatPlayerDisplayOptions == 3 then maraName = displayBoth end

    printToChat(strformat(GetString("SI_PLEDGEOFMARARESULT", reason), maraName))

    -- TODO : this item link doesn't show crafted status or correctly display inventory placement, possibly just index instead?
    if reason == 3 and CA.SV.Loot then
        local logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN)
        local receivedBy = ""
        local gainorloss = 1
        local icon = CA.SV.LootIcons and "|t16:16:esoui/art/icons/entitlement_002.dds|t " or ""
        local itemlink = '|H1:item:44904:1:1:0:0:0:0:0:0:0:0:0:0:0:0:36:0:0:0:0:0|h|h'
        CA.LogItem(logPrefix, icon, itemlink, itemType, 1, receivedBy, gainorloss)
    end
end

function CA.NewCollectible(eventCode, collectibleId)
    local bracket1
    local bracket2
    local message

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

    local _, _, icon, _, _, _, _, categoryType = GetCollectibleInfo(collectibleId)
    local link = GetCollectibleLink(collectibleId, LINK_STYLE_BRACKETS)
    categoryType = GetString("SI_COLLECTIBLECATEGORYTYPE", categoryType)

    if CA.SV.LootIcons then
        icon = strfmt(" |t16:16:%s|t", icon)
    else
        icon = ("")
    end

    message = CollectibleColorize:Colorize(strfmt("%s%s %s%s", bracket1, categoryType, GetString(SI_LUIE_CA_PREFIX_MESSAGE_ADDED), bracket2))

    printToChat(strfmt("%s%s %s", message, icon, link))
end