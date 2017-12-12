------------------
-- ChatAnnouncements namespace
LUIE.ChatAnnouncements = {}

-- Performance Enhancement
local CA             = LUIE.ChatAnnouncements
local E              = LUIE.Effects
local printToChat    = LUIE.PrintToChat
local strfmt         = string.format
local strformat      = zo_strformat
local gsub           = string.gsub

local moduleName     = LUIE.name .. "_ChatAnnouncements"
CA.Enabled = false

------------------------------------------------
-- DEFAULT VARIABLE SETUP ----------------------
------------------------------------------------

CA.D = {

    -- TODO: ShowLootFail         = false, -- Replace with error alert_handler hooks

    -- Base Options
    ChatPlayerDisplayOptions      = 2,
    NotificationColor             = { .75, .75, .75, 1 },
    
    BracketOptionCharacter        = 2,
    BracketOptionItem             = 2,
    BracketOptionLorebook         = 2,
    BracketOptionCollectible      = 2,
    BracketOptionAchievement      = 2,
    
    -- Achievement
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
    --AchievementCategory12       = true,
    AchievementProgressMsg        = GetString(SI_LUIE_CA_ACHIEVEMENT_PROGRESS_MSG),
    AchievementCompleteMsg        = GetString(SI_ACHIEVEMENT_AWARDED_CENTER_SCREEN),
    AchievementColorProgress      = true,
    AchievementColor1             = { .75, .75, .75, 1 },
    AchievementColor2             = { 1, 1, 1, 1 },
    AchievementCompPercentage     = false,
    AchievementUpdateCA           = false,
    AchievementUpdateAlert        = false,
    
    AchievementCompleteCA         = true,
    AchievementCompleteCSA        = true,
    AchievementCompleteAlert      = false,
    
    AchievementIcon               = true,
    AchievementCategory           = true,
    AchievementSubcategory        = true,
    AchievementDetails            = true,
    AchievementBracketOptions     = 4,
    AchievementCatBracketOptions  = 2,
    AchievementStep               = 10,
    
    -- Group
    GroupCA                       = true,
    GroupAlert                    = false,
    GroupLFGCA                    = true,
    GroupLFGAlert                 = false,
    GroupLFGQueueCA               = true,
    GroupLFGQueueAlert            = false,
    GroupLFGCompleteCA            = false,
    GroupLFGCompleteCSA           = true,
    GroupLFGCompleteAlert         = false,
    GroupVoteCA                   = true,
    GroupVoteAlert                = true,
    GroupRaidCA                   = false,
    GroupRaidCSA                  = true,
    GroupRaidAlert                = false,
    GroupRaidScoreCA              = false,
    GroupRaidScoreCSA             = true,
    GroupRaidScoreAlert           = false,
    GroupRaidBestScoreCA          = false,
    GroupRaidBestScoreCSA         = true,
    GroupRaidBestScoreAlert       = false,
    GroupRaidReviveCA             = false,
    GroupRaidReviveCSA            = true,
    GroupRaidReviveAlert          = false,
    
    -- Guild
    GuildCA                       = true,
    GuildAlert                    = false,
    GuildRankCA                   = true,
    GuildRankAlert                = false,
    GuildManageCA                 = false,
    GuildManageAlert              = false,
    GuildIcon                     = true,
    GuildAllianceColor            = true,
    GuildColor                    = { 1, 1, 1, 1 },
    GuildRankDisplayOptions       = 1,
    
    -- Friend
    FriendIgnoreCA                = true,
    FriendIgnoreAlert             = false,
    FriendStatusCA                = true,
    FriendStatusAlert             = false,
    
    -- TODO: These vars are accounted for but need slimmed down and edited in the menu to be more logical. Event handlers need condensed. More events should be registered regardless of setting in order to prevent issues from occuring.
    -- LOOT
    Loot                          = true,
    LootBank                      = true,
    LootBlacklist                 = false,
    LootTotal                     = false,
    LootTotalString               = GetString(SI_LUIE_CA_LOOT_MESSAGE_TOTAL),
    LootCraft                     = true,
    LootGroup                     = true,
    LootIcons                     = true,
    LootMail                      = true,
    LootNotTrash                  = true,
    LootOnlyNotable               = false,
    LootShowArmorType             = false,
    LootShowStyle                 = false,
    LootShowTrait                 = false,
    LootConfiscate                = true,
    LootTrade                     = true,
    LootVendor                    = true,
    LootVendorCurrency            = true,
    LootVendorTotalCurrency       = false,
    LootVendorTotalItems          = false,
    LootShowCraftUse              = false,
    LootShowDestroy               = true,
    LootShowDisguise              = true,
    LootShowLockpick              = true,
    LootQuestAdd                  = true,
    LootQuestRemove               = false,
    
    -- Notifications
    NotificationConfiscateCA      = true,
    NotificationConfiscateAlert   = false,
    
    NotificationLockpickCA        = true,
    NotificationLockpickAlert     = false,
    
    NotificationMailCA            = false,
    NotificationMailAlert         = false,
    
    NotificationTradeCA           = true,
    NotificationTradeAlert        = false,
    
    NotificationRespecCA          = true,
    NotificationRespecCSA         = true,
    NotificationRespecAlert       = false,
    
    NotificationGroupAreaCA       = false,
    NotificationGroupAreaCSA      = true,
    NotificationGroupAreaAlert    = false,
    
    -- Disguise
    DisguiseCA                    = false,
    DisguiseCSA                   = true,
    DisguiseAlert                 = false,
    DisguiseWarnCA                = false,
    DisguiseWarnCSA               = true,
    DisguiseWarnAlert             = false,
    DisguiseAlertColor            = { 1, 0, 0, 1 },
    
    -- Duel
    DuelCA                        = true,
    DuelAlert                     = false,
    DuelBoundaryCA                = false,
    DuelBoundaryCSA               = true,
    DuelBoundaryAlert             = false,
    DuelWonCA                     = false,
    DuelWonCSA                    = true,
    DuelWonAlert                  = false,
    DuelStartCA                   = false,
    DuelStartCSA                  = true,
    DuelStartAlert                = false,
    DuelStartOptions              = 1,
    
    -- Pledge of Mara
    PledgeOfMaraCA                = true,
    PledgeOfMaraCSA               = true,
    PledgeOfMaraAlert             = false,
    PledgeOfMaraAlertOnlyFail     = true,

    -- Storage / Riding Upgrades
    StorageRidingColor            = { .75, .75, .75, 1 },
    StorageRidingBookColor        = { .75, .75, .75, 1 },
    StorageRidingCA               = true,
    StorageRidingCSA              = true,
    StorageRidingAlert            = false,
    
    StorageBagColor               = { .75, .75, .75, 1 },
    StorageBagCA                  = true,
    StorageBagCSA                 = true,
    StorageBagAlert               = false,
    
    -- Collectible
    CollectibleCA                 = true,
    CollectibleCSA                = true,
    CollectibleAlert              = false,
    CollectibleBracket            = 4,
    CollectiblePrefix             = GetString(SI_LUIE_CA_COLLECTIBLE),
    CollectibleIcon               = true,
    CollectibleColor1             = { .75, .75, .75, 1 },
    CollectibleColor2             = { .75, .75, .75, 1 },
    CollectibleCategory           = true,
    
    -- Lorebook
    LorebookCA                    = true, -- Display a CA for Lorebooks
    LorebookCSA                   = true, -- Display a CSA for Lorebooks
    LorebookAlert                 = false, -- Display a ZO_Alert for Lorebooks
    LorebookCollectionCA          = true,
    LorebookCollectionCSA         = true,
    LorebookCollectionAlert       = false,
    LorebookCollectionPrefix      = GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE),
    LorebookPrefix1               = GetString(SI_LORE_LIBRARY_ANNOUNCE_BOOK_LEARNED),
    LorebookPrefix2               = GetString(SI_LUIE_CA_LOREBOOK_BOOK),
    LorebookBracket               = 4, -- Bracket Options
    LorebookColor1                = { .75, .75, .75, 1 }, -- Lorebook Message Color 1
    LorebookColor2                = { .75, .75, .75, 1 }, -- Lorebook Message Color 2
    LorebookIcon                  = true, -- Display an icon for Lorebook CA
    LorebookShowHidden            = false, -- Display books even when they are hidden in the journal menu
    LorebookCategory              = true, -- Display "added to X category" message

    -- QUEST
    QuestShareCA                  = true,
    QuestShareAlert               = false,
    
    QuestColorLocName               = { 1, 1, 1, 1 },
    QuestColorLocDescription        = { .75, .75, .75, 1 },
    QuestColorName                  = { 1, 0.647058, 0, 1 },
    QuestColorDescription           = { .75, .75, .75, 1 },
    
    QuestLocLong                    = true,
    QuestIcon                       = true,
    QuestLong                       = true,
    
    QuestLocDiscoveryCA             = true,
    QuestLocDiscoveryCSA            = true,
    QuestLocDiscoveryAlert          = false,
    QuestLocObjectiveCA             = true,
    QuestLocObjectiveCSA            = true,
    QuestLocObjectiveAlert          = false,
    QuestLocCompleteCA              = true,
    QuestLocCompleteCSA             = true,
    QuestLocCompleteAlert           = false,
    QuestAcceptCA                   = true,
    QuestAcceptCSA                  = true,
    QuestAcceptAlert                = false,
    QuestCompleteCA                 = true,
    QuestCompleteCSA                = true,
    QuestCompleteAlert              = false,
    QuestAbandonCA                  = true,
    QuestAbandonCSA                 = true,
    QuestAbandonAlert               = false,
    QuestFailCA                     = true,
    QuestFailCSA                    = true,
    QuestFailAlert                  = false,
    QuestObjCompleteCA              = false,
    QuestObjCompleteCSA             = true,
    QuestObjCompleteAlert           = false,
    QuestObjUpdateCA                = false,
    QuestObjUpdateCSA               = true,
    QuestObjUpdateAlert             = false,
    
    -- EXPERIENCE
    ExperienceEnlightenedCA         = false,
    ExperienceEnlightenedCSA        = true,
    ExperienceEnlightenedAlert      = false,
    
    ExperienceLevelUpCA             = true,
    ExperienceLevelUpCSA            = true,
    ExperienceLevelUpAlert          = false,
    ExperienceLevelUpCSAExpand      = true,
    ExperienceLevelUpIcon           = true,
    ExperienceLevelColorByLevel     = true,
    ExperienceLevelUpColor          = { .75, .75, .75, 1 },
    
    Experience                      = true,
    ExperienceIcon                  = true,
    ExperienceMessage               = GetString(SI_LUIE_CA_EXPERIENCE_MESSAGE),
    ExperienceName                  = GetString(SI_LUIE_CA_EXPERIENCE_NAME),
    ExperienceHideCombat            = false,
    ExperienceFilter                = 0,
    ExperienceThrottle              = 0,
    ExperienceColorMessage          = { .75, .75, .75, 1 },
    ExperienceColorName             = { .75, .75, .75, 1 },
    
    -- SKILL POINT
    SkillPointCA                    = true,
    SkillPointCSA                   = true,
    SkillPointAlert                 = false,
    SkillPointSkyshardMsg           = GetString(SI_SKYSHARD_GAINED),
    SkillPointBracket               = 4,
    ShowSkillPointsPartial          = true,
    SkillPointColor1                = { .75, .75, .75, 1 },
    SkillPointColor2                = { .75, .75, .75, 1 },
    
    SkillLineUnlockCA               = true,
    SkillLineUnlockCSA              = true,
    SkillLineUnlockAlert            = false,
    SkillLineCA                     = false,
    SkillLineCSA                    = true,
    SkillLineAlert                  = false,
    SkillAbilityCA                  = false,
    SkillAbilityCSA                 = true,
    SkillAbilityAlert               = false,
    SkillLineIcon                   = true,
    SkillLineColor                  = { .75, .75, .75, 1 },
    
    SkillGuildFighters              = true,
    SkillGuildMages                 = true,
    SkillGuildUndaunted             = true,
    SkillGuildThieves               = true,
    SkillGuildDarkBrotherhood       = true,
    SkillGuildIcon                  = true,
    SkillGuildMsg                   = GetString(SI_LUIE_CA_SKILL_GUILD_MSG),
    SkillGuildRepName               = GetString(SI_LUIE_CA_SKILL_GUILD_REPUTATION),
    SkillGuildColor                 = { .75, .75, .75, 1 },
    SkillGuildColorFG               = { .75, .37, 0, 1},
    SkillGuildColorMG               = { 0, .52, .75, 1},
    SkillGuildColorUD               = { .58, .75, 0, 1},
    SkillGuildColorTG               = { .29, .27, .42, 1},
    SkillGuildColorDB               = { .70, 0, .19, 1},
    
    SkillGuildThrottle              = 0,
    SkillGuildThreshold             = 0,
    SkillGuildAlert                 = false,

    -- CURRENCY
    CurrencyAPColor                 = { 0.164706, 0.862745, 0.133333, 1 },
    CurrencyAPFilter                = 0,
    CurrencyAPName                  = GetString(SI_LUIE_CA_CURRENCY_ALLIANCE_POINT),
    CurrencyIcon                    = true,
    CurrencyAPShowChange            = true,
    CurrencyAPShowTotal             = false,
    CurrencyAPThrottle              = 0,
    CurrencyColor                   = { .75, .75, .75, 1 },
    CurrencyColorDown               = { 0.7, 0, 0, 1 },
    CurrencyColorUp                 = { 0.043137, 0.380392, 0.043137, 1 },
    CurrencyContextColor            = true,
    CurrencyGoldChange              = true,
    CurrencyGoldColor               = { 1, 1, 0.2, 1 },
    CurrencyGoldFilter              = 0,
    CurrencyGoldHideAH              = false,
    CurrencyGoldName                = GetString(SI_LUIE_CA_CURRENCY_GOLD),
    CurrencyGoldShowTotal           = false,
    CurrencyGoldThrottle            = true,
    CurrencyMessageConfiscate       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CONFISCATE),
    CurrencyMessageDeposit          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSIT),
    CurrencyMessageDepositGuild     = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSITGUILD),
    CurrencyMessageEarn             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_EARN),
    CurrencyMessageLoot             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LOOT),
    CurrencyMessageSteal            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STEAL),
    CurrencyMessageLost             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LOST),
    CurrencyMessagePickpocket       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_PICKPOCKET),
    CurrencyMessageReceive          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_RECEIVE),
    CurrencyMessageSpend            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_SPEND),
    CurrencyMessageTotalAP          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALAP),
    CurrencyMessageTotalGold        = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALGOLD),
    CurrencyMessageTotalTV          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALTV),
    CurrencyMessageTotalWV          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALWV),
    CurrencyMessageTradeIn          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEIN),
    CurrencyMessageTradeOut         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEOUT),
    CurrencyMessageMailIn           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILIN),
    CurrencyMessageMailOut          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILOUT),
    CurrencyMessageMailCOD          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MAILCOD),
    CurrencyMessagePostage          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_POSTAGE),
    CurrencyMessageWithdraw         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAW),
    CurrencyMessageWithdrawGuild    = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAWGUILD),
    CurrencyMessageStable           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STABLE),
    CurrencyMessageStorage          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STORAGE),
    CurrencyMessageWayshrine        = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WAYSHRINE),
    CurrencyMessageUnstuck          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_UNSTUCK),
    CurrencyMessageChampion         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CHAMPION),
    CurrencyMessageAttributes       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_ATTRIBUTES),
    CurrencyMessageSkills           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_SKILLS),
    CurrencyMessageMorphs           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_MORPHS),
    CurrencyMessageBounty           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_BOUNTY),
    CurrencyMessageTrader           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADER),
    CurrencyMessageRepair           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_REPAIR),
    CurrencyMessageListing          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LISTING),
    
    CurrencyTVChange                = true,
    CurrencyTVColor                 = { 0.368627, 0.643137, 1, 1 },
    CurrencyTVFilter                = 0,
    CurrencyTVName                  = GetString(SI_LUIE_CA_CURRENCY_TELVAR_STONE),
    CurrencyTVShowTotal             = false,
    CurrencyTVThrottle              = 0,
    CurrencyWVChange                = true,
    CurrencyWVColor                 = { 1, 1, 1, 1 },
    CurrencyWVName                  = GetString(SI_LUIE_CA_CURRENCY_WRIT_VOUCHER),
    CurrencyWVShowTotal             = false,
    
    -- LOOT
    LootMessageLoot                 = GetString(SI_LUIE_CA_LOOT_MESSAGE_LOOT),
    LootMessageReceive              = GetString(SI_LUIE_CA_LOOT_MESSAGE_RECEIVE),
    LootMessageTradeIn              = GetString(SI_LUIE_CA_LOOT_MESSAGE_TRADEIN),
    LootMessageTradeOut             = GetString(SI_LUIE_CA_LOOT_MESSAGE_TRADEOUT),
    LootMessageMailIn               = GetString(SI_LUIE_CA_LOOT_MESSAGE_MAILIN),
    LootMessageMailOut              = GetString(SI_LUIE_CA_LOOT_MESSAGE_MAILOUT),
    LootMessageDeposit              = GetString(SI_LUIE_CA_LOOT_MESSAGE_DEPOSIT),
    LootMessageDepositGuild         = GetString(SI_LUIE_CA_LOOT_MESSAGE_DEPOSITGUILD),
    LootMessageWithdraw             = GetString(SI_LUIE_CA_LOOT_MESSAGE_WITHDRAW),
    LootMessageWithdrawGuild        = GetString(SI_LUIE_CA_LOOT_MESSAGE_WITHDRAWGUILD),
    LootMessageSteal                = GetString(SI_LUIE_CA_LOOT_MESSAGE_STEAL),
    LootMessageFence                = GetString(SI_LUIE_CA_LOOT_MESSAGE_FENCE),
    LootMessageSellNoV              = GetString(SI_LUIE_CA_LOOT_MESSAGE_SELL),
    LootMessageBuyNoV               = GetString(SI_LUIE_CA_LOOT_MESSAGE_BUY),
    LootMessageBuybackNoV           = GetString(SI_LUIE_CA_LOOT_MESSAGE_BUYBACK),
    LootMessageSell                 = GetString(SI_LUIE_CA_LOOT_MESSAGE_SELL_VALUE),
    LootMessageBuy                  = GetString(SI_LUIE_CA_LOOT_MESSAGE_BUY_VALUE),
    LootMessageBuyback              = GetString(SI_LUIE_CA_LOOT_MESSAGE_BUYBACK_VALUE),
    LootMessagePickpocket           = GetString(SI_LUIE_CA_LOOT_MESSAGE_PICKPOCKET),
    LootMessageLaunder              = GetString(SI_LUIE_CA_LOOT_MESSAGE_LAUNDER),
    LootMessageConfiscate           = GetString(SI_LUIE_CA_LOOT_MESSAGE_CONFISCATE),
    LootMessageUse                  = GetString(SI_LUIE_CA_LOOT_MESSAGE_USE),
    LootMessageCraft                = GetString(SI_LUIE_CA_LOOT_MESSAGE_CRAFT),
    LootMessageExtract              = GetString(SI_LUIE_CA_LOOT_MESSAGE_EXTRACT),
    LootMessageUpgrade              = GetString(SI_LUIE_CA_LOOT_MESSAGE_UPGRADE),
    LootMessageUpgradeFail          = GetString(SI_LUIE_CA_LOOT_MESSAGE_UPGRADE_FAIL),
    LootMessageRefine               = GetString(SI_LUIE_CA_LOOT_MESSAGE_REFINE),
    LootMessageDeconstruct          = GetString(SI_LUIE_CA_LOOT_MESSAGE_DECONSTRUCT),
    LootMessageResearch             = GetString(SI_LUIE_CA_LOOT_MESSAGE_RESEARCH),
    LootMessageDestroy              = GetString(SI_LUIE_CA_LOOT_MESSAGE_DESTROY),
    LootMessageLockpick             = GetString(SI_LUIE_CA_LOOT_MESSAGE_LOCKPICK),
    
    LootMessageDisguiseEquip        = GetString(SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_EQUIP),
    LootMessageDisguiseRemove       = GetString(SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_REMOVE),
    LootMessageDisguiseDestroy      = GetString(SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_DESTROY),
}

------------------------------------------------
-- LOCAL (GLOBAL) VARIABLE SETUP ---------------
------------------------------------------------

-- Basic
local g_playerName                  = nil
local g_playerNameFormatted         = nil
local g_playerDisplayName           = nil
local g_activatedFirstLoad          = true

-- Message Printer
local g_queuedMessages              = { }           -- Table to hold messages for the 50 ms tick function to print them.
local g_queuedMessagesCounter       = 1             -- Counter value for queued message printer

-- Loot/Currency
local g_savedPurchase               = {}
local g_isLooted                    = false         -- Toggled on to modify loot notification to "looted."
local g_isPickpocketed              = false         -- Toggled on to modify loot notification to "pickpocketed."
local g_isStolen                    = false         -- Toggled on to modify loot notification to "stolen."
local g_itemReceivedIsQuestReward   = false         -- Toggled on to modify loot notification to "received." This overrides the "looted" tag applied to quest item rewards.
local g_itemsConfiscated            = false         -- Toggled on when items are confiscated to modify the notification message.
local g_weAreInAStore               = false         -- Toggled on when the player opens a store.
local g_weAreInAFence               = false         -- Toggled on when the player opens a fence.
local g_itemWasDestroyed            = false         -- Tracker for item being destroyed
local g_lockpickBroken              = false         -- Tracker for lockpick being broken

-- Currency Throttle
local g_currencyGoldThrottleValue   = 0             -- Held value for gold throttle (counter)
local g_currencyGoldThrottleTotal   = 0             -- Held value for gold throttle (total gold)
local g_currencyAPThrottleValue     = 0             -- Held value for AP throttle (counter)
local g_currencyAPThrottleTotal     = 0             -- Held value for AP throttle (total gold)
local g_currencyTVThrottleValue     = 0             -- Held value for TV throttle (counter)
local g_currencyTVThrottleTotal     = 0             -- Held value for TV throttle (total gold)

-- Loot (Crafting)
local g_smithing                    = {}            -- Table for smithing mode
local g_enchanting                  = {}            -- Table for enchanting mode
local g_enchant_prefix_pos          = {}
local g_enchant_prefix_neg          = {}
local g_smithing_prefix_pos         = {}
local g_smithing_prefix_neg         = {}
local g_itemCounterGain             = 0             -- Counter value for items created via crafting
local g_itemStringGain              = ""            -- Counter value for items created via crafting
local g_itemCounterLoss             = 0             -- Counter value for items removed via crafting
local g_itemStringLoss              = ""            -- Combined string variable for items removed via crafting
local g_oldItem                     = { }           -- Saved old item for crafting upgrades

-- Experience
local g_xpCombatBufferValue         = 0             -- Buffered XP Value
local g_guildSkillThrottle          = 0             -- Buffered Fighter's Guild Reputation Value

-- Mail
local g_mailCOD                     = 0             -- Tracks COD amount
local g_postageAmount               = 0             -- Tracks Postage amount
local g_mailCODPresent              = false         -- Tracks whether the currently opened mail has a COD value present. On receiving items from the mail this will modify the message displayed.
local g_inMail                      = false         -- Toggled on when looting mail to prevent notable item display from hiding items acquired.
local g_mailTarget                  = ""            -- Target of mail being sent

-- Disguise
local g_currentDisguise             = nil           -- Holds current disguise itemId
local g_disguiseState               = nil           -- Holds current disguise state

-- Indexing
local g_bankStacks                  = {}            -- Bank Inventory Index 
local g_banksubStacks               = {}            -- Subscriber Bank Inventory Index
local g_equippedStacks              = {}            -- Equipped Items Index
local g_inventoryStacks             = {}            -- Inventory Index
local g_JusticeStacks               = {}            -- Justice Items Index (only filled as a comparison table when items are confiscated)
local g_guildBankCarry              = nil           -- Saves item data when an item is removed/deposited into the guild bank.

-- Group
local currentGroupLeaderRawName     = nil           -- Tracks current Group Leader Name
local currentGroupLeaderDisplayName = nil           -- Tracks current Group Leader Display Name

-- LFG
local g_stopGroupLeaveQueue         = false         -- Stops group notification messages from printing for a short time an LFG group is formed - Implemented due to odd behavior on LFG group formation.
local g_lfgDisableGroupEvents       = false         -- Stops group notification messages from printing for a short time an LFG group is formed - Implemented due to odd behavior on LFG group formation.
local g_groupJoinFudger             = false         -- Toggled on when a group invite is accepted. Controls display of group join message.
local g_joinLFGOverride             = false         -- Toggled on to stop display of standard group join message when joining an LFG group. Instead an alternate message with the LFG activity name will display.
local g_leaveLFGOverride            = false         -- Toggled on to modify group leave message to display "You are no longer in an LFG group."
local g_showActivityStatus          = true          -- Variable to control display of LFG quest
local g_showRCUpdates               = true          -- Variable to control display of LFG Ready Check Announcements
local g_savedQueueValue             = 0             -- Saved LFG queue status
local g_rcSpamPrevention            = false         -- Stops LFG failed ready checks from spamming the player
local g_LFGJoinAntiSpam             = false         -- Stops LFG join messages from spamming the player when a group already in an activity is queueing
local g_rcUpdateDeclineOverride     = false         -- Variable set to true for 5 seconds when a LFG group joing event happens, this prevents RC declined messages from erroneously appearing after solo joining an in progress LFG group.

-- Guild
local g_selectedGuild               = 1             -- Set selected guild to 1 by default, whenever the player reloads their first guild will always be selected
local g_guildRankData               = {}            -- Variable to store local player guild ranks, for guild rank changes.

-- Achievements
local g_achievementLastPercentage   = {}            -- Here we will store last displayed percentage for achievement

-- Quest
local g_questIndex                  = { }           -- Index of all current quests. Allows us to read the index so that all quest notifications can use the difficulty icon.

-- Trade
local g_tradeTarget                 = ""            -- Saves name of target player being traded with.

------------------------------------------------
-- COLORIZE VALUES -----------------------------
------------------------------------------------

-- Basic
local NotificationColorize

-- Guild
local GuildColorize

-- Currency
local CurrencyColorize
local CurrencyUpColorize
local CurrencyDownColorize
local CurrencyGoldColorize
local CurrencyAPColorize
local CurrencyTVColorize
local CurrencyWVColorize

-- Disguise
local DisguiseAlertColorize

-- Achievements
local AchievementColorize1
local AchievementColorize2

-- Experience
local ExperienceMessageColorize
local ExperienceNameColorize
local ExperienceLevelUpColorize

-- Skill Point/Lines
local SkillPointColorize1
local SkillPointColorize2
local SkillLineColorize

-- Guild Skills
local SkillGuildColorize
local SkillGuildColorizeFG
local SkillGuildColorizeMG
local SkillGuildColorizeUD
local SkillGuildColorizeTG
local SkillGuildColorizeDB

-- Collectibles
local CollectibleColorize1
local CollectibleColorize2

-- Lorebooks
local LorebookColorize1
local LorebookColorize2

-- Quests
local QuestColorLocNameColorize
local QuestColorLocDescriptionColorize
local QuestColorQuestNameColorize
local QuestColorQuestDescriptionColorize

-- Storage
local StorageRidingColorize
local StorageRidingBookColorize
local StorageBagColorize

------------------------------------------------
-- BRACKET OPTIONS -----------------------------
------------------------------------------------

-- 5 Option Bracket (1)
local bracket1 = {
    [1] = "[",
    [2] = "(",
    [3] = "",
    [4] = "",
    [5] = "",
}

-- 5 Option Bracket (2)
local bracket2 = {
    [1] = "]",
    [2] = ")",
    [3] = " -",
    [4] = ":",
    [5] = "",
}

-- 4 Option Bracket (1)
local bracket3 = {
    [1] = "[",
    [2] = "(",
    [3] = "- ",
    [4] = "",

}

-- 4 Option Bracket (2)
local bracket4 = {
    [1] = "]",
    [2] = ")",
    [3] = "",
    [4] = "",
}

------------------------------------------------
-- LINK BRACKET OPTIONS ------------------------
------------------------------------------------

local linkBrackets = {
    [1] = LINK_STYLE_DEFAULT,
    [2] = LINK_STYLE_BRACKETS,
}

local linkBracket1 = {
    [1] = "",
    [2] = "[",
}

local linkBracket2 = {
    [1] = "",
    [2] = "]",
}

------------------------------------------------
-- ITEM BLACKLIST ------------------------------
------------------------------------------------

-- List of items to whitelist as notable loot
local g_notableIDs = {
    [56862]  = true,    -- Fortified Nirncrux
    [56863]  = true,    -- Potent Nirncrux
    [68342]  = true,    -- Hakeijo
}

-- List of items to blacklist as annyoing loot
local g_blacklistIDs = {
    [64713]  = true,    -- Laurel
    [64690]  = true,    -- Malachite Shard
    [69432]  = true,    -- Glass Style Motif Fragment
    -- Trial non worthless junk
    [114427] = true,    -- Undaunted Plunder
    [81180]  = true,    -- The Serpent's Egg-Tooth
    [74453]  = true,    -- The Rid-Thar's Moon Pearls
    [87701]  = true,    -- Star-Studded Champion's Baldric
    [87700]  = true,    -- Periapt of Elinhir
    -- Mercenary Motif Pages
    [64716]  = true,    -- Mercenary Motif
    [64717]  = true,    -- Mercenary Motif
    [64718]  = true,    -- Mercenary Motif
    [64719]  = true,    -- Mercenary Motif
    [64720]  = true,    -- Mercenary Motif
    [64721]  = true,    -- Mercenary Motif
    [64722]  = true,    -- Mercenary Motif
    [64723]  = true,    -- Mercenary Motif
    [64724]  = true,    -- Mercenary Motif
    [64725]  = true,    -- Mercenary Motif
    [64726]  = true,    -- Mercenary Motif
    [64727]  = true,    -- Mercenary Motif
    [64728]  = true,    -- Mercenary Motif
    [64729]  = true,    -- Mercenary Motif
}

local guildAllianceColors = {

[1] = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ALLIANCE, ALLIANCE_ALDMERI_DOMINION)),
[2] = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ALLIANCE, ALLIANCE_DAGGERFALL_COVENANT)),
[3] = ZO_ColorDef:New(GetInterfaceColor(INTERFACE_COLOR_TYPE_ALLIANCE, ALLIANCE_EBONHEART_PACT)),

}

function CA.Initialize(enabled)
    -- Load settings
    CA.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "ChatAnnouncements", CA.D )

    -- Disable if setting not toggled on
    if not enabled then
        return
    end

    CA.Enabled = true

    -- Read current player name and get current group leader
    g_playerName = GetRawUnitName("player")
    g_playerNameFormatted = strformat(SI_UNIT_NAME, GetUnitName("player"))
    g_playerDisplayName = strformat(SI_UNIT_NAME, GetUnitDisplayName("player"))
    currentGroupLeaderRawName = GetRawUnitName(GetGroupLeaderUnitTag())
    currentGroupLeaderDisplayName = GetUnitDisplayName(GetGroupLeaderUnitTag())
    
    -- Setup group variables
    if IsInLFGGroup() then
        g_LFGJoinAntiSpam = true
    end

    -- Posthook Crafting Interface (Keyboard)
    CA.CraftModeOverrides()

    -- Register events
    CA.RegisterGoldEvents()
    CA.RegisterLootEvents()
    CA.RegisterMailEvents()
    CA.RegisterXPEvents()
    CA.RegisterAchievementsEvent()
    -- TODO: Possibly don't register these unless enabled, I'm not sure -- at least move to better sorted order
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_BAG_CAPACITY_CHANGED, CA.StorageBag)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_BANK_CAPACITY_CHANGED, CA.StorageBank)
    -- TODO: Move these too:
    LINK_HANDLER:RegisterCallback(LINK_HANDLER.LINK_MOUSE_UP_EVENT, LUIE.HandleClickEvent) 
    LINK_HANDLER:RegisterCallback(LINK_HANDLER.LINK_CLICKED_EVENT, LUIE.HandleClickEvent)
    
    -- TODO: also move this
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SKILL_XP_UPDATE, CA.SkillXPUpdate)
    
    CA.RegisterGuildEvents()
    CA.RegisterSocialEvents()
    CA.RegisterDisguiseEvents()
    CA.RegisterColorEvents()
    CA.RegisterQuestEvents()
    
    --
    CA.HookFunction()
    
end

---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
-- EVENT HANDLER AND COLOR REGISTRATION -----------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

function CA.RegisterColorEvents()
    CurrencyColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyColor))
    CurrencyUpColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyColorUp))
    CurrencyDownColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyColorDown))
    CollectibleColorize1 = ZO_ColorDef:New(unpack(CA.SV.CollectibleColor1))
    CollectibleColorize2 = ZO_ColorDef:New(unpack(CA.SV.CollectibleColor2))
    CurrencyGoldColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyGoldColor))
    CurrencyAPColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyAPColor))
    CurrencyTVColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyTVColor))
    CurrencyWVColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyWVColor))
    DisguiseAlertColorize = ZO_ColorDef:New(unpack(CA.SV.DisguiseAlertColor))
    AchievementColorize1 = ZO_ColorDef:New(unpack(CA.SV.AchievementColor1))
    AchievementColorize2 = ZO_ColorDef:New(unpack(CA.SV.AchievementColor2))
    LorebookColorize1 = ZO_ColorDef:New(unpack(CA.SV.LorebookColor1))
    LorebookColorize2 = ZO_ColorDef:New(unpack(CA.SV.LorebookColor2))
    ExperienceMessageColorize = ZO_ColorDef:New(unpack(CA.SV.ExperienceColorMessage)):ToHex()
    ExperienceNameColorize = ZO_ColorDef:New(unpack(CA.SV.ExperienceColorName)):ToHex()
    ExperienceLevelUpColorize = ZO_ColorDef:New(unpack(CA.SV.ExperienceLevelUpColor))
    SkillPointColorize1 = ZO_ColorDef:New(unpack(CA.SV.SkillPointColor1))
    SkillPointColorize2 = ZO_ColorDef:New(unpack(CA.SV.SkillPointColor2))
    SkillLineColorize = ZO_ColorDef:New(unpack(CA.SV.SkillLineColor))
    
    SkillGuildColorize = ZO_ColorDef:New(unpack(CA.SV.SkillGuildColor)):ToHex()
    SkillGuildColorizeFG = ZO_ColorDef:New(unpack(CA.SV.SkillGuildColorFG)):ToHex()
    SkillGuildColorizeMG = ZO_ColorDef:New(unpack(CA.SV.SkillGuildColorMG)):ToHex()
    SkillGuildColorizeUD = ZO_ColorDef:New(unpack(CA.SV.SkillGuildColorUD)):ToHex()
    SkillGuildColorizeTG = ZO_ColorDef:New(unpack(CA.SV.SkillGuildColorTG)):ToHex()
    SkillGuildColorizeDB = ZO_ColorDef:New(unpack(CA.SV.SkillGuildColorDB)):ToHex()
    
    QuestColorLocNameColorize = ZO_ColorDef:New(unpack(CA.SV.QuestColorLocName)):ToHex()
    QuestColorLocDescriptionColorize = ZO_ColorDef:New(unpack(CA.SV.QuestColorLocDescription)):ToHex()
    QuestColorQuestNameColorize = ZO_ColorDef:New(unpack(CA.SV.QuestColorName))
    QuestColorQuestDescriptionColorize = ZO_ColorDef:New(unpack(CA.SV.QuestColorDescription)):ToHex()
    
    StorageRidingColorize = ZO_ColorDef:New(unpack(CA.SV.StorageRidingColor))
    StorageRidingBookColorize = ZO_ColorDef:New(unpack(CA.SV.StorageRidingBookColor))
    StorageBagColorize = ZO_ColorDef:New(unpack(CA.SV.StorageBagColor))
    
    NotificationColorize = ZO_ColorDef:New(unpack(CA.SV.NotificationColor))
    
    GuildColorize = ZO_ColorDef:New(unpack(CA.SV.GuildColor))
    
end

function CA.RegisterSocialEvents()
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_FRIEND_ADDED, CA.FriendAdded)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_FRIEND_REMOVED, CA.FriendRemoved)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_ADDED, CA.FriendInviteAdded)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_IGNORE_ADDED, CA.IgnoreAdded)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_IGNORE_REMOVED, CA.IgnoreRemoved)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_FRIEND_PLAYER_STATUS_CHANGED, CA.FriendPlayerStatus)
end

function CA.RegisterQuestEvents()
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_SHARED, CA.QuestShared)
    
    -- Create a table for quests
    for i = 1, 25 do
        if IsValidQuestIndex(i) then
            local name = GetJournalQuestName(i)
            local questType = GetJournalQuestType(i)
            local instanceDisplayType = GetJournalQuestInstanceDisplayType(i)

            if name == "" then
                name = GetString(SI_QUEST_JOURNAL_UNKNOWN_QUEST_NAME)
            end

            g_questIndex[name] =
                {
                    questType = questType,
                    instanceDisplayType = instanceDisplayType
                }
        end
    end
    
end

function CA.RegisterGuildEvents()

-- Possibly implement conditionals here again in the future

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, CA.GuildAddedSelf)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_INVITE_ADDED, CA.GuildInviteAdded)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_RANK_CHANGED, CA.GuildRank)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_HERALDRY_SAVED, CA.GuildHeraldrySaved)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_RANKS_CHANGED, CA.GuildRanksSaved)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_RANK_CHANGED, CA.GuildRankSaved)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_DESCRIPTION_CHANGED, CA.GuildTextChanged)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MOTD_CHANGED, CA.GuildTextChanged)
    -- Index Guild Ranks
    g_guildRankData = {}
    if CA.SV.GuildRankCA or CA.SV.GuildRankAlert then
        for i = 1,5 do
            local guildId = GetGuildId(i)
            local memberIndex = GetPlayerGuildMemberIndex(guildId)
            local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
            g_guildRankData[guildId] = {rank=rankIndex}
        end
    end
    
end

function CA.RegisterAchievementsEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED)
    if CA.SV.AchievementUpdateCA or CA.SV.AchievementUpdateAlert then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED, CA.OnAchievementUpdated)
    end
end

function CA.RegisterXPEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN)
    if CA.SV.Experience or CA.SV.ExperienceLevelUp then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN, CA.OnExperienceGain)
    end
end

function CA.RegisterGoldEvents()

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CARRIED_CURRENCY_UPDATE, CA.OnCurrencyUpdate)

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED, CA.OnMailAttach)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED, CA.OnMailAttachRemove)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX, CA.OnMailCloseBox)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS, CA.OnMailSuccess)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED, CA.MailMoneyChanged)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED, CA.MailCODChanged)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_REMOVED, CA.MailRemoved)
end

function CA.RegisterMailEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_READABLE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_OPEN_MAILBOX)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_REMOVED)
    if CA.SV.MiscMail or CA.SV.LootMail then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_READABLE, CA.OnMailReadable)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, CA.OnMailTakeAttachedItem)
    end
    if CA.SV.MiscMail or CA.SV.LootMail or CA.SV.CurrencyGoldChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED, CA.OnMailAttach)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED, CA.OnMailAttachRemove)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_SEND_SUCCESS, CA.OnMailSuccess)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHED_MONEY_CHANGED, CA.MailMoneyChanged)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_COD_CHANGED, CA.MailCODChanged)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_REMOVED, CA.MailRemoved)
    end
    if CA.SV.Loot or CA.SV.MiscMail or CA.SV.LootMail or CA.SV.CurrencyGoldChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_OPEN_MAILBOX, CA.OnMailOpenBox)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_CLOSE_MAILBOX, CA.OnMailCloseBox)
    end
end

function CA.RegisterLootEvents()

    -- NON CONDITIONAL EVENTS
    
    -- LOCKPICK
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_BROKE, CA.MiscAlertLockBroke)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS, CA.MiscAlertLockSuccess)
    -- LOOT RECEIVED
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_RECEIVED)
    -- QUEST REWARD CONTEXT
    -- INDEX
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    -- VENDOR
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_BUY_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_SELL_RECEIPT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OPEN_FENCE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CLOSE_STORE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OPEN_STORE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ITEM_LAUNDER_RESULT)
    -- BANK
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OPEN_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CLOSE_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OPEN_GUILD_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CLOSE_GUILD_BANK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_REMOVED)
    -- CRAFT
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, CA.CraftingOpen)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, CA.CraftingClose)
    -- JUSTICE/DESTROY
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED)
    -- LOOT FAILED
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_COMPLETE_ATTEMPT_FAILED_INVENTORY_FULL)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_IS_FULL)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED)

    -- LOOT RECEIVED
    if CA.SV.Loot or CA.SV.LootQuestAdd or CA.SV.LootQuestRemove then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_RECEIVED, CA.OnLootReceived)
    end
    -- QUEST LOOT
    if CA.SV.LootQuestAdd or CA.SV.LootQuestRemove then
        CA.AddQuestItemsToIndex()
    end
    -- INDEX
    if CA.SV.Loot or CA.SV.LootShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
        g_equippedStacks = {}
        g_inventoryStacks = {}
        CA.IndexEquipped()
        CA.IndexInventory()
    end
    -- VENDOR
    if CA.SV.LootVendor then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_BUYBACK_RECEIPT, CA.OnBuybackItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_BUY_RECEIPT, CA.OnBuyItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SELL_RECEIPT, CA.OnSellItem)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ITEM_LAUNDER_RESULT, CA.FenceSuccess)
    end
    if CA.SV.Loot or CA.SV.LootVendor then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OPEN_FENCE, CA.FenceOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OPEN_STORE, CA.StoreOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CLOSE_STORE, CA.StoreClose)
    end
    -- BANK
    if CA.SV.LootBank then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_ADDED, CA.GuildBankItemAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_BANK_ITEM_REMOVED, CA.GuildBankItemRemoved)
    end
    if CA.SV.Loot or CA.SV.LootBank then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OPEN_BANK, CA.BankOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CLOSE_BANK, CA.BankClose)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OPEN_GUILD_BANK, CA.GuildBankOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CLOSE_GUILD_BANK, CA.GuildBankClose)
    end
    -- TRADE
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_INVITE_ACCEPTED, CA.TradeInviteAccepted)
    -- CRAFT
    if CA.SV.Loot or CA.SV.LootCraft then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, CA.CraftingOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, CA.CraftingClose)
    end
    -- JUSTICE/DESTROY
    if CA.SV.LootShowDestroy then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED, CA.DestroyItem)
    end
    if CA.SV.Loot or CA.SV.NotificationConfiscateCA or CA.SV.NotificationConfiscateAlert or CA.SV.LootShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED, CA.JusticeStealRemove)
    end
    
    --[[if CA.SV.ShowLootFail then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_COMPLETE_ATTEMPT_FAILED_INVENTORY_FULL, CA.InventoryFullQuest)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_IS_FULL, CA.InventoryFull)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED, CA.LootItemFailed)
    end]]
end

function CA.RegisterDisguiseEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED)
    if CA.SV.Disguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, CA.OnPlayerActivated)
        EVENT_MANAGER:RegisterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED, CA.DisguiseState )
        EVENT_MANAGER:AddFilterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
        g_currentDisguise = GetItemId(0, 10) or 0 -- Get the currently equipped disguise itemId if any
        if g_activatedFirstLoad then
            g_disguiseState = 0
            g_activatedFirstLoad = false
        else
            g_disguiseState = GetUnitDisguiseState("player") -- Get current player disguise state
            if g_disguiseState > 0 then
                g_disguiseState = 1 -- Simplify all the various states into a basic 0 = false, 1 = true value
            end
        end
    end
end

---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------

-- Called by most functions that use character or display name to resolve LINK display method.
function CA.ResolveNameLink(characterName, displayName)

    local nameLink

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        if CA.SV.BracketOptionCharacter == 1 then
            nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(characterName, nil, CHARACTER_LINK_TYPE, characterName)
        else
            nameLink = ZO_LinkHandler_CreateLink(characterName, nil, CHARACTER_LINK_TYPE, characterName)
        end
    elseif CA.SV.ChatPlayerDisplayOptions == 2 then
        if CA.SV.BracketOptionCharacter == 1 then
            nameLink = ZO_LinkHandler_CreateLinkWithoutBrackets(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            nameLink = ZO_LinkHandler_CreateLink(displayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
    elseif CA.SV.ChatPlayerDisplayOptions == 3 then
        local displayBothString = strformat("<<1>><<2>>", characterName, displayName)
        if CA.SV.BracketOptionCharacter == 1 then
            nameLink = ZO_LinkHandler_CreateLinkWithBrackets(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            nameLink = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
    end
    
    return nameLink
end

-- Called by most functions that use character or display name to resolve NON-LINK display method (mostly used for alerts).
function CA.ResolveNameNoLink(characterName, displayName)
    
    local nameLink
    if CA.SV.ChatPlayerDisplayOptions == 1 then
        nameLink = characterName
    elseif CA.SV.ChatPlayerDisplayOptions == 2 then
        nameLink = displayName
    elseif CA.SV.ChatPlayerDisplayOptions == 3 then
        nameLink = strformat("<<1>><<2>>", characterName, displayName)
    end
    
    return nameLink

end

function CA.GuildHeraldrySaved()

    if CA.SV.CurrencyGoldChange then
        local type = "LUIE_CURRENCY_HERALDRY"
        local formattedValue = nil -- Un-needed, we're not going to try to show the total guild bank gold here.
        local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(1000)
        local currencyTypeColor = CurrencyGoldColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        local currencyName = strformat(CA.SV.CurrencyGoldName, 1000)
        local currencyTotal = nil
        local messageTotal = ""
        local messageChange = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_HERALDRY)
        CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end

    if g_selectedGuild ~= nil then
        local id = g_selectedGuild
        local guildName = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
        local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
        local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

        if CA.SV.GuildManageCA then
            local finalMessage = strformat(GetString(SI_LUIE_CA_GUILD_HERALDRY_UPDATE), guildNameAlliance)
            g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "SYSTEM" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end
        if CA.SV.GuildManageAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_HERALDRY_UPDATE), guildNameAllianceAlert))
        end
    end
end

function CA.GuildRanksSaved(eventCode, guildId)

    local guildName = GetGuildName(guildId)

    local guildAlliance = GetGuildAlliance(guildId)
    local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

    if CA.SV.GuildManageCA then
        local finalMessage = strformat(GetString(SI_LUIE_CA_GUILD_RANKS_UPDATE), guildNameAlliance)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "SYSTEM" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    end
    if CA.SV.GuildManageAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_RANKS_UPDATE), guildNameAllianceAlert))
    end

end

function CA.GuildRankSaved(eventCode, guildId, rankIndex)

    local rankName
    local rankNameDefault = GetDefaultGuildRankName(guildId, rankIndex)
    local rankNameCustom = GetGuildRankCustomName(guildId, rankIndex)

    if rankNameCustom == "" then
        rankName = rankNameDefault
    else
        rankName = rankNameCustom
    end

    local icon = GetGuildRankIconIndex(guildId, rankIndex)
    local icon = GetGuildRankLargeIcon(icon)
    local guildName = GetGuildName(guildId)
    local guildAlliance = GetGuildAlliance(guildId)
    local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
    local rankSyntax = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(icon, 16, 16), rankName)) or (guildColor:Colorize(rankName))
    local rankSyntaxAlert = CA.SV.GuildIcon and zo_iconTextFormat(icon, "100%", "100%", rankName) or rankName

    if CA.SV.GuildManageCA then
        printToChat(strformat(GetString(SI_LUIE_CA_GUILD_RANK_UPDATE), rankSyntax, guildNameAlliance))
    end
    if CA.SV.GuildManageAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_RANK_UPDATE), rankSyntaxAlert, guildNameAllianceAlert))
    end

end

function CA.GuildTextChanged(eventCode, guildId)

    local guildName = GetGuildName(guildId)

    local guildAlliance = GetGuildAlliance(guildId)
    local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
    -- Depending on event code set message context.
    local messageString = eventCode == EVENT_GUILD_DESCRIPTION_CHANGED and SI_LUIE_CA_GUILD_DESCRIPTION_CHANGED or EVENT_GUILD_MOTD_CHANGED and SI_LUIE_CA_GUILD_MOTD_CHANGED or nil
    
    if messageString ~= nil then
        if CA.SV.GuildManageCA then
            local finalMessage = strformat(GetString(messageString), guildNameAlliance)
            g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "SYSTEM" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end
        if CA.SV.GuildManageAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(messageString), guildNameAllianceAlert))
        end
    end
    
end

function CA.GuildRank(eventCode, guildId, DisplayName, newRank)
    local currentRank = g_guildRankData[guildId].rank
    local hasPermission1 = DoesGuildRankHavePermission(guildId, currentRank, GUILD_PERMISSION_PROMOTE)
    local hasPermission2 = DoesGuildRankHavePermission(guildId, currentRank, GUILD_PERMISSION_DEMOTE)

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
        local guildName = GetGuildName(guildId)
        local guilds = GetNumGuilds()

        for i = 1,guilds do
            local id = GetGuildId(i)
            local name = GetGuildName(id)

            local guildAlliance = GetGuildAlliance(id)
            local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
            local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
            local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
            local rankSyntax = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(icon, 16, 16), rankName)) or (guildColor:Colorize(rankName))
            local rankSyntaxAlert = CA.SV.GuildIcon and zo_iconTextFormat(icon, "100%", "100%", rankName) or rankName

            if guildName == name then
                if CA.SV.GuildRankCA then
                    printToChat(strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED), displayNameLink, guildNameAlliance, rankSyntax))
                end
                if CA.SV.GuildRankAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED), DisplayName, guildNameAllianceAlert, rankSyntaxAlert))
                end
                break
            end
        end
    end

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
            local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
            local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
            local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
            local rankSyntax = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(icon, 16, 16), rankName)) or (guildColor:Colorize(rankName))
            local rankSyntaxAlert = CA.SV.GuildIcon and zo_iconTextFormat(icon, "100%", "100%", rankName) or rankName

            if guildName == name then
                if CA.SV.GuildRankCA then
                    printToChat(strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED_SELF), changestring, rankSyntax, guildNameAlliance))
                end
                if CA.SV.GuildRankAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_RANK_CHANGED_SELF), changestring, rankSyntaxAlert, guildNameAllianceAlert))
                end
                break
            end
        end
    end
end

-- EVENT_GUILD_SELF_JOINED_GUILD
function CA.GuildAddedSelf(eventCode, guildId, guildName)
    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)

        local guildAlliance = GetGuildAlliance(id)
        local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
        local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
        local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

        if guildName == name then
            if CA.SV.GuildCA then
                printToChat(strformat(GetString(SI_LUIE_CA_GUILD_JOIN_SELF), guildNameAlliance))
            end
            if CA.SV.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_JOIN_SELF), guildNameAllianceAlert))
            end
            break
        end
    end

    -- Reindex Guild Ranks
    g_guildRankData = {}
    if CA.SV.GuildRankCA or CA.SV.GuildRankAlert then
        for i = 1,5 do
            local guildId = GetGuildId(i)
            local memberIndex = GetPlayerGuildMemberIndex(guildId)
            local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
            g_guildRankData[guildId] = {rank=rankIndex}
        end
    end
end

-- EVENT_GUILD_INVITE_ADDED
function CA.GuildInviteAdded(eventCode, guildId, guildName, guildAlliance, inviterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(inviterName)
    local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
    if CA.SV.GuildCA then
        printToChat(strformat(GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST), displayNameLink, guildNameAlliance))
    end
    if CA.SV.GuildAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST), inviterName, guildNameAllianceAlert))
    end
end

function CA.FriendAdded(eventCode, displayName)
    if CA.SV.FriendIgnoreCA then
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
        printToChat(strformat(SI_LUIE_CA_FRIENDS_FRIEND_ADDED, displayNameLink))
    end
    if CA.SV.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(SI_LUIE_CA_FRIENDS_FRIEND_ADDED, displayName))
    end
end

function CA.FriendRemoved(eventCode, displayName)
    if CA.SV.FriendIgnoreCA then
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
        printToChat(strformat(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED, displayNameLink))
    end
    if CA.SV.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED, displayName))
    end
end

function CA.FriendInviteAdded(eventCode, displayName)
    if CA.SV.FriendIgnoreCA then
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
        printToChat(strformat(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST, displayNameLink))
    end
    if CA.SV.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST, displayName))
    end
end

function CA.IgnoreAdded(eventCode, displayName)
    if CA.SV.FriendIgnoreCA then
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
        printToChat(zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_ADDED, displayNameLink))
    end
    if CA.SV.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_ADDED, displayName))
    end
end

function CA.IgnoreRemoved(eventCode, displayName)
    if CA.SV.FriendIgnoreCA then
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
        printToChat(zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_REMOVED, displayNameLink))
    end
    if CA.SV.FriendIgnoreAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_FRIENDS_LIST_IGNORE_REMOVED, displayName))
    end
end

function CA.FriendPlayerStatus(eventCode, displayName, characterName, oldStatus, newStatus)
    local wasOnline = oldStatus ~= PLAYER_STATUS_OFFLINE
    local isOnline = newStatus ~= PLAYER_STATUS_OFFLINE

    if wasOnline ~= isOnline then
        local chatText
        local alertText
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(characterName)
        if isOnline then
            if characterName ~= "" then
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_ON, displayNameLink, characterNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_ON, displayName, characterName)
            else
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_ON, displayNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_ON, displayName)
            end
        else
            if characterName ~= "" then
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_OFF, displayNameLink, characterNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_OFF, displayName, characterName)
            else
                chatText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_OFF, displayNameLink)
                alertText = zo_strformat(SI_LUIE_CA_FRIENDS_LIST_LOGGED_OFF, displayName)
            end
        end
        
        if CA.SV.FriendStatusCA then
            printToChat(chatText)
        end
        if CA.SV.FriendStatusAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
        end
    end
end

function CA.QuestShared (eventCode, questId)
    if CA.SV.QuestShareCA or CA.SV.QuestShareAlert then
        local questName, characterName, timeSinceRequestMs, displayName = GetOfferedQuestShareInfo(questId)
        
        local finalName = CA.ResolveNameLink(characterName, displayName)

        local message = strformat(GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE), finalName, QuestColorQuestNameColorize:Colorize(questName))
        local alertMessage = strformat(GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_P2P), finalName, questName)
       
        if CA.SV.QuestShareCA then
            printToChat(message)
        end
        if CA.SV.QuestShareAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
        end
    end
end

-- EVENT_ACTIVITY_FINDER_STATUS_UPDATE
function CA.ActivityStatusUpdate(eventCode, status)
    --d("status: " .. status)
    if g_showActivityStatus then
        local message
        -- If we are NOT queued and were formerly queued, forming group, or in a ready check, display left queue message.
        if status == ACTIVITY_FINDER_STATUS_NONE and (g_savedQueueValue == 1 or g_savedQueueValue == 4) then
                message = (GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_END)) 
        end
        -- If we are queued and previously we were not queued then display a message.
        if status == ACTIVITY_FINDER_STATUS_QUEUED and (g_savedQueueValue == 0 or g_savedQueueValue == 2) then
                message = (GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_START)) 
        end
        -- If we were in the queue and are now in progress without a ready check triggered, we left the queue to find a replacement member so this should be displayed.
        if status == ACTIVITY_FINDER_STATUS_IN_PROGRESS and (g_savedQueueValue == 1) then
                message = (GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_END)) 
        end
        if g_savedQueueValue == 5 and status == 1 then status = 5 end -- Fixes an error that occurs when joining an LFG instance while already in an LFG group.  

        if message then
            if CA.SV.GroupLFGQueueCA then
                printToChat(message)
            end
            if CA.SV.GroupLFGQueueAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
        end
    end

    if status == 0 then
        g_showRCUpdates = true
    end -- Should always trigger at the end result of a ready check failing.
    if status == 4 then
        g_showRCUpdates = false
    end

    -- Prevents potential consecutive events from spamming
    if status == 5 and g_savedQueueValue ~= 5 then
        message = (GetString(SI_LFGREADYCHECKCANCELREASON4))
        if message then
            if CA.SV.GroupLFGCA then
                printToChat(message)
            end
            if CA.SV.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
        end
        g_stopGroupLeaveQueue = true
        g_showRCUpdates = true
        g_LFGJoinAntiSpam = false
        g_showActivityStatus = false
        zo_callLater(function() g_showActivityStatus = true end, 1000)
        zo_callLater(function() g_stopGroupLeaveQueue = false end, 1000)
    end
    
    g_savedQueueValue = status
    
end

-- EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED
function CA.ReadyCheckUpdate(eventCode)
    --d("ready check update")

    local activityType, playerRole = GetLFGReadyCheckNotificationInfo()
    local tanksAccepted, tanksPending, healersAccepted, healersPending, dpsAccepted, dpsPending = GetLFGReadyCheckCounts()
    --d(tanksAccepted .. " " .. tanksPending .. " " .. healersAccepted .. " " .. healersPending .. " " .. dpsAccepted .." " .. dpsPending)
    if g_showRCUpdates then
        local activityName

        if activityType == 0 then
            return
        end
        if activityType == LFG_ACTIVITY_AVA then
            activityName = GetString(SI_LFGACTIVITY1) -- TODO: Untested
        end
        if activityType == LFG_ACTIVITY_BATTLE_GROUND_NON_CHAMPION then
            activityName = strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY7), GetString(SI_BATTLEGROUND_FINDER_GENERAL_ACTIVITY_DESCRIPTOR)) -- Not yet implemented yet
        end
        if activityType == LFG_ACTIVITY_BATTLE_GROUND_CHAMPION then
            activityName = strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY5), GetString(SI_BATTLEGROUND_FINDER_GENERAL_ACTIVITY_DESCRIPTOR)) -- Not yet implemented yet
        end
        if activityType == LFG_ACTIVITY_BATTLE_GROUND_LOW_LEVEL then
            activityName = strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY8), GetString(SI_BATTLEGROUND_FINDER_GENERAL_ACTIVITY_DESCRIPTOR)) -- Not yet implemented yet
        end
        if activityType == LFG_ACTIVITY_DUNGEON then
            activityName = strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY2), GetString(SI_DUNGEON_FINDER_GENERAL_ACTIVITY_DESCRIPTOR))
        end
        if activityType == LFG_ACTIVITY_HOME_SHOW then
            activityName = GetString(SI_LFGACTIVITY6) -- TODO: Untested
        end
        if activityType == LFG_ACTIVITY_MASTER_DUNGEON then
            activityName = strformat("<<1>> <<2>>", GetString(SI_LFGACTIVITY3), GetString(SI_DUNGEON_FINDER_GENERAL_ACTIVITY_DESCRIPTOR))
        end
        if activityType == LFG_ACTIVITY_TRIAL then
            activityName = GetString(SI_LFGACTIVITY4) -- TODO: Untested
        end

        local message
        local alertText
        if playerRole ~= 0 then
            local roleIconSmall = zo_strformat("<<1>> ", zo_iconFormat(GetRoleIcon(playerRole), 16, 16)) or ""
            local roleIconLarge =zo_strformat("<<1>> ", zo_iconFormat(GetRoleIcon(playerRole), "100%", "100%")) or ""
            local roleString = GetString("SI_LFGROLE", playerRole)
            message = strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY_ROLE), activityName, roleIconSmall, roleString )
            alertText = strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY_ROLE), activityName, roleIconLarge, roleString )
            if CA.SV.GroupLFGCA then
                printToChat(message)
            end
            if CA.SV.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
            end
        else
            message = strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY), activityName)
            alertText = strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY), activityName)
            if CA.SV.GroupLFGCA then
                printToChat(message)
            end
            if CA.SV.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
            end
        end
    end
    
    g_showRCUpdates = false
    
    if not g_showRCUpdates and (tanksAccepted == 0 and tanksPending == 0 and healersAccepted == 0 and healersPending == 0 and dpsAccepted == 0 and dpsPending == 0) and not g_rcUpdateDeclineOverride then
        if g_rcSpamPrevention == false then
            local message
            message = (GetString(SI_LFGREADYCHECKCANCELREASON3))
            if CA.SV.GroupLFGCA then
                printToChat(message)
            end
            if CA.SV.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
            g_rcSpamPrevention = true
            zo_callLater(function() g_rcSpamPrevention = false end, 1000)
            g_showActivityStatus = false
            zo_callLater(function() g_showActivityStatus = true end, 1000)
            g_showRCUpdates = true
        end
    end
    
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

local RESPEC_TYPE_CHAMPION = 1
local RESPEC_TYPE_ATTRIBUTES = 2
local RESPEC_TYPE_SKILLS = 3
local RESPEC_TYPE_MORPHS = 4

local LUIE_AttributeDisplayType = {
    [RESPEC_TYPE_CHAMPION] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_CHAMPION),
    [RESPEC_TYPE_ATTRIBUTES] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_ATTRIBUTES),
    [RESPEC_TYPE_SKILLS] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_SKILLS),
    [RESPEC_TYPE_MORPHS] = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_MORPHS),
}

function CA.PointRespecDisplay(respecType)
    
    local message = LUIE_AttributeDisplayType[respecType] .. "."
    local messageCSA = LUIE_AttributeDisplayType[respecType]
    
    if CA.SV.NotificationRespecCA then
        printToChat(message)
    end
    
    if CA.SV.NotificationRespecCSA then
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
        messageParams:SetText(messageCSA)
        messageParams:SetSound(SOUNDS.DISPLAY_ANNOUNCEMENT)
        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
    end
    
    if CA.SV.NotificationRespecAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
    end
    
end

    

function CA.OnCurrencyUpdate(eventCode, currency, newValue, oldValue, reason)
    local UpOrDown = newValue - oldValue
    
    --[[ DEBUG
    d("currency: " .. currency)
    d("NV: " .. newValue)
    d("OV: " .. oldValue)
    d("reason: " .. reason)
    ]]

    -- If the total gold change was 0 or (Reason 7 = Command) or (Reason 28 = Mount Feed) or (Reason 35 = Player Init) - End Now
    if UpOrDown == 0 or UpOrDown + g_postageAmount == 0 or UpOrDown - g_postageAmount == 0 or reason == 7 or reason == 28 or reason == 35 then
        return
    end
    
    local formattedValue = ZO_LocalizeDecimalNumber(newValue)
    local changeColor                                                   -- Gets the value from CurrencyUpColorize or CurrencyDownColorize to color strings
    local changeType                                                    -- Amount of currency gained or lost
    local currencyTypeColor                                             -- Determines color to use for colorization of currency based off currency type.
    local currencyIcon                                                  -- Determines icon to use for currency based off currency type.
    local currencyName                                                  -- Determines name to use for currency based off type.
    local currencyTotal                                                 -- Determines if the total should be displayed based off type.
    local messageChange                                                 -- Set to a string value based on the reason code.
    local messageTotal                                                  -- Set to a string value based on the currency type.
    local type
    
    -- Resolve Currency Type (TODO: Use CURRENCY_TYPE when implemented rather than # values)
    if currency == 1 then -- Gold
        -- Send change info to the throttle printer and end function now if we throttle gold from loot.
        if CA.SV.CurrencyGoldThrottle and (reason == 0 or reason == 13) then
            -- TODO: Register Event here instead
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedGold")
            -- NOTE: Unlike other throttle events, we used zo_callLater here because we have to make the call immediately (if some of the gold is looted after items, the message will appear after the loot if we don't use zo_callLater instead of a RegisterForUpdate)
            zo_callLater( CA.CurrencyGoldThrottlePrinter, 50 )
            g_currencyGoldThrottleValue = g_currencyGoldThrottleValue + UpOrDown
            g_currencyGoldThrottleTotal = GetCarriedCurrencyAmount(1)
            return
        end
        
        -- If looted gold is below the filter value, end now.
        if CA.SV.CurrencyGoldFilter > 0 and (reason == 0 or reason == 13) then
            if UpOrDown < CA.SV.CurrencyGoldFilter then
                return
            end
        end

        currencyTypeColor = CurrencyGoldColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        currencyName = strformat(CA.SV.CurrencyGoldName, UpOrDown)
        currencyTotal = CA.SV.CurrencyGoldShowTotal
        messageTotal = CA.SV.CurrencyMessageTotalGold

    elseif currency == 2 then -- Alliance Points
        -- TODO -- We need to find all Alliance Point gain values so we can determine what keep rewards, etc are and print those out immediately! (and also reset the throttle with those)
        -- Send change info to the throttle printer and end function now if we throttle Alliance Points Gained
        if CA.SV.CurrencyAPThrottle > 0 and reason == 13 then
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedAP")
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "BufferedAP", CA.SV.CurrencyAPThrottle, CA.CurrencyAPThrottlePrinter )
            g_currencyAPThrottleValue = g_currencyAPThrottleValue + UpOrDown
            g_currencyAPThrottleTotal = GetCarriedCurrencyAmount(2)
            return
        end
        
        -- If earned AP is below the filter value, end now.
        if CA.SV.CurrencyAPFilter > 0 and reason == 13 then
            if UpOrDown < CA.SV.CurrencyAPFilter then
                return
            end
        end
        
        -- Immediately print value if another source of AP is gained (or spent)
        if CA.SV.CurrencyAPThrottle > 0 and reason ~= 13 then
            CA.CurrencyAPThrottlePrinter()
        end
        
        currencyTypeColor = CurrencyAPColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/alliancepoints.dds|t" or ""
        currencyName = strformat(CA.SV.CurrencyAPName, UpOrDown)
        currencyTotal = CA.SV.CurrencyAPShowTotal
        messageTotal = CA.SV.CurrencyMessageTotalAP

    elseif currency == 3 then -- TelVar Stones
    
        -- Send change info to the throttle printer and end function now if we throttle Tel Var Gained
        if CA.SV.CurrencyTVThrottle > 0 and (reason == 0 or reason == 65) then
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedTV")
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "BufferedTV", CA.SV.CurrencyTVThrottle, CA.CurrencyTVThrottlePrinter )
            g_currencyTVThrottleValue = g_currencyTVThrottleValue + UpOrDown
            g_currencyTVThrottleTotal = GetCarriedCurrencyAmount(3)
            return
        end
        
        -- If earned Tel Var is below the filter value, end now.
        if CA.SV.CurrencyTVFilter > 0 and (reason == 0 or reason == 65) then
            if UpOrDown < CA.SV.CurrencyTVFilter then
                return
            end
        end
        
        -- Immediately print value if another source of TV is gained or lost
        if CA.SV.CurrencyTVThrottle > 0 and (reason ~= 0 and reason ~= 65) then
            CA.CurrencyTVThrottlePrinter()
        end
        
        currencyTypeColor = CurrencyTVColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_telvar.dds|t" or ""
        currencyName = strformat(CA.SV.CurrencyTVName, UpOrDown)
        currencyTotal = CA.SV.CurrencyTVShowTotal
        messageTotal = CA.SV.CurrencyMessageTotalTV

    elseif currency == 4 then -- Writ Vouchers
        currencyTypeColor = CurrencyWVColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_writvoucher.dds|t" or ""
        currencyName = strformat(CA.SV.CurrencyWVName, UpOrDown)
        currencyTotal = CA.SV.CurrencyWVShowTotal
        messageTotal = CA.SV.CurrencyMessageTotalWV
        
    else -- If for some reason there is no currency type, end the function now
        return
    end
    
    -- Did we gain or lose currency
    if UpOrDown > 0 then
        if CA.SV.CurrencyContextColor then
            changeColor = CurrencyUpColorize:ToHex()
        else
            changeColor = CurrencyColorize:ToHex()
        end
        changeType = ZO_LocalizeDecimalNumber(newValue - oldValue + g_postageAmount)
    elseif UpOrDown < 0 then
        if CA.SV.CurrencyContextColor then
            changeColor = CurrencyDownColorize:ToHex()
        else
            changeColor = CurrencyColorize:ToHex()
        end
        changeType = ZO_LocalizeDecimalNumber(oldValue - newValue - g_postageAmount)
    end
    
    -- Determine syntax based on reason
    -- Sell/Buy from a Merchant
    if reason == 1 and UpOrDown > 0 then
        messageChange = CA.SV.CurrencyMessageReceive
        if CA.SV.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    elseif reason == 1 and UpOrDown < 0 then
        messageChange = CA.SV.CurrencyMessageSpend
        if CA.SV.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Mail (2)
    elseif reason == 2 and UpOrDown > 0  then
        messageChange = CA.SV.CurrencyMessageMailIn
        type = "LUIE_CURRENCY_MAIL"
    elseif reason == 2 and UpOrDown < 0  then
        if g_mailCODPresent then
            messageChange = CA.SV.CurrencyMessageMailCOD
        else
            messageChange = CA.SV.CurrencyMessageMailOut
        end
        type = "LUIE_CURRENCY_MAIL"
    -- Buyback (64)
    elseif reason == 64 then
        messageChange = CA.SV.CurrencyMessageSpend
        if CA.SV.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Receive/Give Money in a Trade (Likely consolidate this later)
    elseif reason == 3 and UpOrDown > 0 then
        messageChange = CA.SV.CurrencyMessageTradeIn
        type = "LUIE_CURRENCY_TRADE"
    elseif reason == 3 and UpOrDown < 0 then
        messageChange = CA.SV.CurrencyMessageTradeOut
        type = "LUIE_CURRENCY_TRADE"
    -- Receive from Quest Reward (4), Medal (21), AH Refund (32)
    elseif reason == 4 or reason == 21 or reason == 32 then
        messageChange = CA.SV.CurrencyMessageReceive
    -- Sell to Fence (63)
    elseif reason == 63 then
        messageChange = CA.SV.CurrencyMessageReceive
        if CA.SV.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Bag Space (8)
    elseif reason == 8 then
        messageChange = CA.SV.CurrencyMessageStorage
        type = "LUIE_CURRENCY_BAG"
    -- Bank Space (9)
    elseif reason == 9 then
        messageChange = CA.SV.CurrencyMessageStorage
        type = "LUIE_CURRENCY_BANK"
    -- Spend - NPC Conversation (5), Edit Guild Heraldry (49), Buy Guild Tabard (50)
    elseif reason == 5 or reason == 49 or reason == 50 then
        messageChange = CA.SV.CurrencyMessageSpend
    -- Wayshrine (19)
    elseif reason == 19 then
        messageChange = CA.SV.CurrencyMessageWayshrine
    -- Repairs (29)
    elseif reason == 29 then
        messageChange = CA.SV.CurrencyMessageRepair
    -- Listing Fee (33)
    elseif reason == 33 then
        messageChange = CA.SV.CurrencyMessageListing
    -- Respec Skills (44)
    elseif reason == 44 then
        CA.PointRespecDisplay(RESPEC_TYPE_SKILLS)
        messageChange = CA.SV.CurrencyMessageSkills
    -- Respec Attributes (45)
    elseif reason == 45 then
        CA.PointRespecDisplay(RESPEC_TYPE_ATTRIBUTES)
        messageChange = CA.SV.CurrencyMessageAttributes
    -- Unstuck (48)
    elseif reason == 48 then
        messageChange = CA.SV.CurrencyMessageUnstuck
    -- Respec Morphs (55)
    elseif reason == 55 then
        CA.PointRespecDisplay(RESPEC_TYPE_MORPHS)
        messageChange = CA.SV.CurrencyMessageMorphs
    -- Pay Fence (56)
    elseif reason == 56 then
        messageChange = CA.SV.CurrencyMessageBounty
    -- Champion Point Respec (61)
    elseif reason == 61 then
        CA.PointRespecDisplay(RESPEC_TYPE_CHAMPION)
        messageChange = CA.SV.CurrencyMessageChampion
    --  Launder (60)
    elseif reason == 60 then
         messageChange = CA.SV.CurrencyMessageSpend
        if CA.SV.LootVendorCurrency then
            g_savedPurchase.changeType=changeType
            g_savedPurchase.formattedValue=formattedValue
            g_savedPurchase.currencyTypeColor=currencyTypeColor
            g_savedPurchase.currencyIcon=currencyIcon
            g_savedPurchase.currencyName=currencyName
            g_savedPurchase.currencyTotal=currencyTotal
            g_savedPurchase.messageTotal=messageTotal
            return
        end
    -- Keep Reward (14), Keep Repair (40), PVP Resurrect (41)
    elseif reason == 14 or reason == 40 or reason == 41 then
        messageChange = CA.SV.CurrencyMessageEarn
    -- Buy on AH (31)
    elseif reason == 31 then
        if CA.SV.CurrencyGoldHideAH then return end
        messageChange = CA.SV.CurrencyMessageSpend
    -- Desposit in Bank (42)
    elseif reason == 42 then
        messageChange = CA.SV.CurrencyMessageDeposit
    -- Desposit in Guild Bank (51)
    elseif reason == 51 then
        messageChange = CA.SV.CurrencyMessageDepositGuild
    -- Withdraw from Bank (43)
    elseif reason == 43 then
        messageChange = CA.SV.CurrencyMessageWithdraw
    -- Withdraw from Guild Bank (52)
    elseif reason == 52 then
        messageChange = CA.SV.CurrencyMessageWithdrawGuild
    -- Confiscated -- Pay to Guard (47), Killed by Guard (57)
    elseif reason == 47 or reason == 57 then
        messageChange = CA.SV.CurrencyMessageConfiscate
        zo_callLater(CA.JusticeDisplayConfiscate, 50)
    -- Pickpocketed (59)
    elseif reason == 59 then
        messageChange = CA.SV.CurrencyMessagePickpocket
    -- Looted - From Chest (0), Looted from Player/NPC (65)
    elseif reason == 0 or reason == 65 then
        messageChange = CA.SV.CurrencyMessageLoot
    -- Looted - Stolen Gold (62)
    elseif reason == 62 then
        messageChange = CA.SV.CurrencyMessageSteal
    -- Looted (13)
    elseif reason == 13 then
        if currency == 2 then
            messageChange = CA.SV.CurrencyMessageEarn
        else
            messageChange = CA.SV.CurrencyMessageLoot
        end
    -- Died to Player/NPC (67)
    elseif reason == 67 then
        messageChange = CA.SV.CurrencyMessageLost

    -- ==============================================================================
    -- DEBUG EVENTS WE DON'T KNOW YET
    -- TODO -- Need to add support for AP messages here. Also, in the case of AP gain we also need to adjust looted to earned if the reason code ends up being 0
    elseif reason == 6 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 12 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 15 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason) -- Keep Upgrade
    elseif reason == 16 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 18 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 20 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 22 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 23 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 24 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 25 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 26 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 27 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 30 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 34 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 36 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 37 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 38 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 39 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 46 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 53 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 54 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 58 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    elseif reason == 66 then messageChange = strformat(GetString(SI_LUIE_CA_DEBUG_MSG_CURRENCY), reason)
    -- END DEBUG EVENTS
    -- ==============================================================================
    -- If none of these returned true, then we must have just looted the gold (Potentially a few currency change events I missed too may have to adjust later)
    else messageChange = CA.SV.CurrencyMessageLoot end
    
    -- Send relevant values over to the currency printer
    CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    
end

-- Printer function receives values from currency update or from other functions that display currency updates.
-- Type here refers to an LUIE_CURRENCY_TYPE
function CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type, carriedItem, carriedItemTotal)

    local messageP1                                                     -- First part of message - Change
    local messageP2                                                     -- Second part of the message (if enabled) - Total

    messageP1 = ("|r|c" .. currencyTypeColor .. currencyIcon .. " " .. changeType .. currencyName .. "|r|c" .. changeColor)

    if currencyTotal and type ~= "LUIE_CURRENCY_HERALDRY" then
        messageP2 = ("|r|c" .. currencyTypeColor .. currencyIcon .. " " .. formattedValue .. "|r|c" .. changeColor)
    else
        messageP2 = "|r"
    end

    local formattedMessageP1
    if type == "LUIE_CURRENCY_BAG" or type == "LUIE_CURRENCY_BANK" then
        local function ResolveStorageType()
            local bagType
            local icon
            if type == "LUIE_CURRENCY_BAG" then
                bagType = strfmt(linkBracket1[CA.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_BAGTYPE1) .. linkBracket2[CA.SV.BracketOptionItem])
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/icons/store_upgrade_bag.dds|t " or ""
            end
            if type == "LUIE_CURRENCY_BANK" then
                bagType = strfmt(linkBracket1[CA.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_BAGTYPE2) .. linkBracket2[CA.SV.BracketOptionItem])
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/icons/store_upgrade_bank.dds|t " or ""
            end
            return strfmt("|r" .. icon .. "|cFFFFFF" .. bagType .. "|r|c" .. changeColor)
        end
        formattedMessageP1 = (strfmt(messageChange, ResolveStorageType(), messageP1))
    elseif type == "LUIE_CURRENCY_HERALDRY" then
        local icon = CA.SV.LootIcons and "|t16:16:LuiExtended/media/unitframes/ca_heraldry.dds|t " or ""
        local heraldryMessage = strfmt("|r" .. icon .. "|cFFFFFF" .. linkBracket1[CA.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_CURRENCY_NAME_HERALDRY) .. linkBracket2[CA.SV.BracketOptionItem] .. "|r|c" .. changeColor)
        formattedMessageP1 = (strfmt(messageChange, messageP1, heraldryMessage)) 
    elseif type == "LUIE_CURRENCY_RIDING_SPEED" or type == "LUIE_CURRENCY_RIDING_CAPACITY" or type == "LUIE_CURRENCY_RIDING_STAMINA" then
        local function ResolveRidingStats()
            -- if somevar then icon = else no
            local skillType
            local icon
            if type == "LUIE_CURRENCY_RIDING_SPEED" then
                skillType = strfmt(linkBracket1[CA.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE1) .. linkBracket2[CA.SV.BracketOptionItem])
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_speed.dds|t " or ""
            elseif type == "LUIE_CURRENCY_RIDING_CAPACITY" then
                skillType = strfmt(linkBracket1[CA.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE2) .. linkBracket2[CA.SV.BracketOptionItem])
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_capacity.dds|t " or ""
            elseif type == "LUIE_CURRENCY_RIDING_STAMINA" then
                skillType = strfmt(linkBracket1[CA.SV.BracketOptionItem] .. GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE3) .. linkBracket2[CA.SV.BracketOptionItem])
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_stamina.dds|t " or ""
            end
            return strfmt("|r" .. icon .. "|cFFFFFF" .. skillType .. "|r|c" .. changeColor)
        end
        formattedMessageP1 = (strfmt(messageChange, ResolveRidingStats(), messageP1))
        
    elseif type == "LUIE_CURRENCY_VENDOR" then
        item = strfmt("|r" .. carriedItem .. "|c" .. changeColor)
        formattedMessageP1 = (strfmt(messageChange, item, messageP1))
    elseif type == "LUIE_CURRENCY_TRADE" then
        name = strfmt("|r" .. g_tradeTarget .. "|c" .. changeColor)
        formattedMessageP1 = (strfmt(messageChange, messageP1, name))
    elseif type == "LUIE_CURRENCY_MAIL" then
        name = strfmt("|r" .. g_mailTarget .. "|c" .. changeColor)
        formattedMessageP1 = (strfmt(messageChange, messageP1, name))
    else
        formattedMessageP1 = (strfmt(messageChange, messageP1))
    end
    local formattedMessageP2 = (strfmt(messageTotal, messageP2))
    local finalMessage
    if currencyTotal and type ~= "LUIE_CURRENCY_HERALDRY" and type ~= "LUIE_CURRENCY_VENDOR" and type ~= "LUIE_CURRENCY_POSTAGE" or (type == "LUIE_CURRENCY_VENDOR" and CA.SV.LootVendorTotalCurrency) then
        if type == "LUIE_CURRENCY_VENDOR" then
            finalMessage = strfmt("|c%s%s|r%s |c%s%s|r", changeColor, formattedMessageP1, carriedItemTotal, changeColor, formattedMessageP2)
        else
            finalMessage = strfmt("|c%s%s|r |c%s%s|r", changeColor, formattedMessageP1, changeColor, formattedMessageP2)
        end
    else
        if type == "LUIE_CURRENCY_VENDOR" then
            finalMessage = strfmt("|c%s%s|r%s", changeColor, formattedMessageP1, carriedItemTotal)
        else
            finalMessage = strfmt("|c%s%s|r", changeColor, formattedMessageP1)
        end
    end
    
    -- If this value is being sent from the Throttle Printer, do not throttle the printout of the value
    if type == "LUIE_CURRENCY_THROTTLE" then
        printToChat(finalMessage)
    -- Otherwise sent to our Print Queued Messages function to be processed on a 50 ms delay.
    else
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "CURRENCY" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    end

end

function CA.CurrencyGoldThrottlePrinter()
    if g_currencyGoldThrottleValue > 0 and g_currencyGoldThrottleValue > CA.SV.CurrencyGoldFilter then
        local formattedValue = ZO_LocalizeDecimalNumber(GetCarriedCurrencyAmount(1))
        local changeColor = CA.SV.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyGoldThrottleValue)
        local currencyTypeColor = CurrencyGoldColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        local currencyName = strformat(CA.SV.CurrencyGoldName, g_currencyGoldThrottleValue)
        local currencyTotal = CA.SV.CurrencyGoldShowTotal
        local messageTotal = CA.SV.CurrencyMessageTotalGold
        local messageChange = CA.SV.CurrencyMessageLoot
        local type = "LUIE_CURRENCY_THROTTLE"
        CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end
    g_currencyGoldThrottleValue = 0
    g_currencyGoldThrottleTotal = 0
end

function CA.CurrencyAPThrottlePrinter()
    if g_currencyAPThrottleValue > 0 and g_currencyAPThrottleValue > CA.SV.CurrencyAPFilter then
        local formattedValue = ZO_LocalizeDecimalNumber(g_currencyAPThrottleTotal)
        local changeColor = CA.SV.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyAPThrottleValue)
        local currencyTypeColor = CurrencyAPColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/alliancepoints.dds|t" or ""
        local currencyName = strformat(CA.SV.CurrencyAPName, g_currencyAPThrottleValue)
        local currencyTotal = CA.SV.CurrencyAPShowTotal
        local messageTotal = CA.SV.CurrencyMessageTotalAP
        local messageChange = CA.SV.CurrencyMessageEarn
        local type = "LUIE_CURRENCY_THROTTLE"
        CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end
    EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedAP")
    g_currencyAPThrottleValue = 0
    g_currencyAPThrottleTotal = 0
end

function CA.CurrencyTVThrottlePrinter()
    if g_currencyTVThrottleValue > 0 and g_currencyTVThrottleValue > CA.SV.CurrencyTVFilter then
        local formattedValue = ZO_LocalizeDecimalNumber(g_currencyTVThrottleTotal)
        local changeColor = CA.SV.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyTVThrottleValue)
        local currencyTypeColor = CurrencyTVColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_telvar.dds|t" or ""
        local currencyName = strformat(CA.SV.CurrencyTVName, g_currencyTVThrottleValue)
        local currencyTotal = CA.SV.CurrencyTVShowTotal
        local messageTotal = CA.SV.CurrencyMessageTotalTV
        local messageChange = CA.SV.CurrencyMessageEarn
        local type = "LUIE_CURRENCY_THROTTLE"
        CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end
    EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedTV")
    g_currencyTVThrottleValue = 0
    g_currencyTVThrottleTotal = 0
end

function CA.MiscAlertLockBroke(eventCode, inactivityLengthMs)
    g_lockpickBroken = true
    zo_callLater (function() g_lockpickBroken = false end, 200)
end

function CA.MiscAlertLockSuccess(eventCode)
    if CA.SV.NotificationLockpickCA then
        printToChat(GetString(SI_LUIE_CA_LOCKPICK_SUCCESS))
    end
    if CA.SV.NotificationLockpickAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_LOCKPICK_SUCCESS))
    end
    g_lockpickBroken = true
    zo_callLater (function() g_lockpickBroken = false end, 200)
end

function CA.StorageBag(eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
    if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
        if CA.SV.StorageBagCA then
            local formattedString = StorageBagColorize:Colorize(zo_strformat(SI_INVENTORY_BAG_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "STORAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end

        if CA.SV.StorageBagAlert then
            local text = zo_strformat(SI_LUIE_CA_STORAGE_BAG_UPGRADE)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
    end
end

function CA.StorageBank(eventCode, previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
    if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
        if CA.SV.StorageBagCA then
            local formattedString = StorageBagColorize:Colorize(zo_strformat(SI_INVENTORY_BANK_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "STORAGE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end

        if CA.SV.StorageBagAlert then
            local text = zo_strformat(SI_LUIE_CA_STORAGE_BANK_UPGRADE)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
    end
end

function CA.OnBuybackItem(eventCode, itemName, quantity, money, itemSound)
    local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    local icon = itemIcon
    local formattedIcon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
    local type = "LUIE_CURRENCY_VENDOR"
    local messageChange = (money ~= 0 and CA.SV.LootVendorCurrency) and CA.SV.LootMessageBuyback or CA.SV.LootMessageBuybackNoV
    local itemCount = quantity > 1 and (" |cFFFFFFx" .. quantity .. "|r") or ""
    local carriedItem
    if CA.SV.BracketOptionItem == 1 then
        carriedItem = ( formattedIcon .. itemName ..  itemCount )
    else
        carriedItem = ( formattedIcon .. itemName:gsub("^|H0", "|H1", 1) ..  itemCount )
    end
    
    local carriedItemTotal = ""
    if CA.SV.LootTotal and CA.SV.LootVendorTotalItems then
        local total1, total2, total3 = GetItemLinkStacks(itemName)
        local total = total1 + total2 + total3
        if total > 1 then
            carriedItemTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end
    
    if money ~= 0 and CA.SV.LootVendorCurrency then
        CA.CurrencyPrinter(g_savedPurchase.formattedValue, changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, messageChange, g_savedPurchase.messageTotal, type, carriedItem, carriedItemTotal)
    else
        local finalMessageP1 = strfmt(carriedItem .. "|r|c" .. changeColor)
        local finalMessageP2 = strfmt(messageChange, finalMessageP1)
        local finalMessage = strfmt("|c%s%s|r%s", changeColor, finalMessageP2, carriedItemTotal)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "CURRENCY" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    end
    g_savedPurchase = { }
end

function CA.OnBuyItem(eventCode, itemName, entryType, quantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)
    local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    local icon = itemIcon
    local formattedIcon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
    local type = "LUIE_CURRENCY_VENDOR"
    local messageChange = (money ~= 0 and CA.SV.LootVendorCurrency) and CA.SV.LootMessageBuy or CA.SV.LootMessageBuyNoV
    local itemCount = quantity > 1 and (" |cFFFFFFx" .. quantity .. "|r") or "" 
    local carriedItem
    if CA.SV.BracketOptionItem == 1 then
        carriedItem = ( formattedIcon .. itemName ..  itemCount )
    else
        carriedItem = ( formattedIcon .. itemName:gsub("^|H0", "|H1", 1) ..  itemCount )
    end
    
    local carriedItemTotal = ""
    if CA.SV.LootTotal and CA.SV.LootVendorTotalItems then
        local total1, total2, total3 = GetItemLinkStacks(itemName)
        local total = total1 + total2 + total3
        if total > 1 then
            carriedItemTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end
    
    if money ~= 0 and CA.SV.LootVendorCurrency then
        CA.CurrencyPrinter(g_savedPurchase.formattedValue, changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, messageChange, g_savedPurchase.messageTotal, type, carriedItem, carriedItemTotal)
    else
        local finalMessageP1 = strfmt(carriedItem .. "|r|c" .. changeColor)
        local finalMessageP2 = strfmt(messageChange, finalMessageP1)
        local finalMessage = strfmt("|c%s%s|r%s", changeColor, finalMessageP2, carriedItemTotal)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "CURRENCY" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    end
    g_savedPurchase = { }
end

function CA.OnSellItem(eventCode, itemName, quantity, money)
    local changeColor = CA.SV.CurrencyContextColor and CurrencyUpColorize:ToHex() or CurrencyColorize:ToHex()
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    local icon = itemIcon
    local formattedIcon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
    local type = "LUIE_CURRENCY_VENDOR"
    local messageChange
    if g_weAreInAFence then
        messageChange = CA.SV.LootMessageFence
    else
        messageChange = (money ~= 0 and CA.SV.LootVendorCurrency) and CA.SV.LootMessageSell or CA.SV.LootMessageSellNoV
    end
    local itemCount = quantity > 1 and (" |cFFFFFFx" .. quantity .. "|r") or "" 
    local carriedItem
    if CA.SV.BracketOptionItem == 1 then
        carriedItem = ( formattedIcon .. itemName ..  itemCount )
    else
        carriedItem = ( formattedIcon .. itemName:gsub("^|H0", "|H1", 1) ..  itemCount )
    end
    
    local carriedItemTotal = ""
    if CA.SV.LootTotal and CA.SV.LootVendorTotalItems then
        local total1, total2, total3 = GetItemLinkStacks(itemName)
        local total = total1 + total2 + total3
        if total > 1 then
            carriedItemTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end
    
    if money ~= 0 and CA.SV.LootVendorCurrency then
        CA.CurrencyPrinter(g_savedPurchase.formattedValue, changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, messageChange, g_savedPurchase.messageTotal, type, carriedItem, carriedItemTotal)
    else
        local finalMessageP1 = strfmt(carriedItem .. "|r|c" .. changeColor)
        local finalMessageP2 = strfmt(messageChange, finalMessageP1)
        local finalMessage = strfmt("|c%s%s|r%s", changeColor, finalMessageP2, carriedItemTotal)
        g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "CURRENCY" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    end
    g_savedPurchase = { }
end

function CA.MailMoneyChanged(eventCode)
    g_mailCOD = 0
    g_postageAmount = GetQueuedMailPostage()
end

function CA.MailCODChanged(eventCode)
    g_mailCOD = GetQueuedCOD()
    g_postageAmount = GetQueuedMailPostage()
end

function CA.MailRemoved(eventCode)
    if CA.SV.NotificationMailCA or CA.SV.NotificationMailAlert then
        if CA.SV.NotificationMailCA then
            printToChat(GetString(SI_LUIE_CA_MAIL_DELETED_MSG))
        end
        if CA.SV.NotificationMailAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_MAIL_DELETED_MSG))
        end
    end
end

function CA.OnMailReadable(eventCode, mailId)
    
    local senderDisplayName, senderCharacterName, _, _, _, fromSystem, fromCustomerService, _, _, _, codAmount = GetMailItemInfo ( mailId )

    -- Use different color if the mail is from System (Hireling Mail, Rewards for the Worthy, etc)
    if fromSystem or fromCustomerService then 
        g_mailTarget = ZO_GAME_REPRESENTATIVE_TEXT:Colorize(senderDisplayName)
    elseif senderDisplayName ~= "" and senderCharacterName ~= "" then
        local finalName = CA.ResolveNameLink(senderCharacterName, senderDisplayName)
        g_mailTarget = ZO_SELECTED_TEXT:Colorize(finalName)
    else
        local finalName
        if CA.SV.BracketOptionCharacter == 1 then
            finalName = ZO_LinkHandler_CreateLinkWithoutBrackets(inviterDisplayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        else
            finalName = ZO_LinkHandler_CreateLink(inviterDisplayName, nil, DISPLAY_NAME_LINK_TYPE, displayName)
        end
        g_mailTarget = ZO_SELECTED_TEXT:Colorize(finalName)
    end

    if codAmount > 0 then
        g_mailCODPresent = true
    end

end

function CA.OnMailTakeAttachedItem(eventCode, mailId)
    
    if CA.SV.NotificationMailCA or CA.SV.NotificationMailAlert then
        local mailString
        if g_mailCODPresent then 
            mailString = GetString(SI_LUIE_CA_MAIL_RECEIVED_COD)
        else
            mailString = GetString(SI_LUIE_CA_MAIL_RECEIVED)
        end
        if CA.SV.NotificationMailCA then
            printToChat(mailString)
        end
        if CA.SV.NotificationMailAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, mailString)
        end
    end
    
    g_mailCODPresent = false
end

function CA.OnMailAttach(eventCode, attachmentSlot)
    g_postageAmount = GetQueuedMailPostage()
end

-- Removes items from index if they are removed from the trade
function CA.OnMailAttachRemove(eventCode, attachmentSlot)
    g_postageAmount = GetQueuedMailPostage()
end

function CA.OnMailOpenBox(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.LootMail then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
        g_inventoryStacks = {}
        CA.IndexInventory() -- Index Inventory
    end
    g_inMail = true
end

function CA.OnMailCloseBox(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.Loot or CA.SV.LootShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    g_inMail = false
end

-- Hook MAIL_SEND.Send to get name of player we send to.
MAIL_SEND.Send = function(self)
    WINDOW_MANAGER:SetFocusByName("")
    if not self.sendMoneyMode and GetQueuedCOD() == 0 then
        if CA.SV.NotificationMailCA then
            printToChat(GetString(SI_LUIE_CA_MAIL_ERROR_NO_COD_VALUE))
        end
        if CA.SV.NotificationMailAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_LUIE_CA_MAIL_ERROR_NO_COD_VALUE))
        end
        PlaySound(SOUNDS.NEGATIVE_CLICK)
    else
        SendMail(self.to:GetText(), self.subject:GetText(), self.body:GetText())
        
        local mailTarget = self.to:GetText()
        local nameLink
        -- Here we look for @ character in the sent mail, if the player send to an account then we want the link to be an account name link, otherwise, it's a character name link.
        if string.match(mailTarget, "@") == "@" then
            nameLink = ZO_LinkHandler_CreateDisplayNameLink(mailTarget)
        else
            nameLink = ZO_LinkHandler_CreateCharacterLink(mailTarget)
        end
        
        g_mailTarget = ZO_SELECTED_TEXT:Colorize(nameLink)
    end
end

-- Sends results of the trade to the Item Log print function and clears variables so they are reset for next trade interactions
function CA.OnMailSuccess(eventCode)

    if g_postageAmount > 0 then
        local type = "LUIE_CURRENCY_POSTAGE"
        local formattedValue = ZO_LocalizeDecimalNumber(GetCarriedCurrencyAmount(1))
        local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_postageAmount)
        local currencyTypeColor = CurrencyGoldColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
        local currencyName = strformat(CA.SV.CurrencyGoldName, g_postageAmount)
        local currencyTotal = CA.SV.CurrencyGoldShowTotal
        local messageTotal = CA.SV.CurrencyMessageTotalGold
        local messageChange = CA.SV.CurrencyMessagePostage
        CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
    end
    
    if CA.SV.NotificationMailCA or CA.SV.NotificationMailAlert then
        local mailString
        if g_mailCOD > 1 then
            mailString = GetString(SI_LUIE_CA_MAIL_SENT_COD)
        else
            mailString = GetString(SI_LUIE_CA_MAIL_SENT)
        end
        if CA.SV.NotificationMailCA then
            printToChat(mailString)
        end
        if CA.SV.NotificationMailAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, mailString)
        end
    end
        
    g_mailCOD = 0
    g_postageAmount = 0
end

function CA.OnExperienceGain(eventCode, reason, level, previousExperience, currentExperience, championPoints)

    -- d("Experience Gain) previousExperience: " .. previousExperience .. " --- " .. "currentExperience: " .. currentExperience)
    
    if CA.SV.Experience and ( not ( CA.SV.ExperienceHideCombat and reason == 0 ) or not reason == 0 ) then
    
        local change = currentExperience - previousExperience -- Change in Experience Points on gaining them
        
        -- If throttle is enabled, save value and end function here
        if CA.SV.ExperienceThrottle > 0 and reason == 0 then
            g_xpCombatBufferValue = g_xpCombatBufferValue + change
            -- We unregister the event, then re-register it, this keeps the buffer at a constant X throttle after XP is gained.
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "BufferedXP", CA.SV.ExperienceThrottle, CA.PrintBufferedXP )
            return
        end
        
        -- If filter is enabled and value is below filter then end function here
        if CA.SV.ExperienceFilter > 0 and reason == 0 then
            if change < CA.SV.ExperienceFilter then
                return
            end
        end

        -- If we gain experience from a non combat source, and our buffer function holds a value, then we need to immediately dump this value before the next XP update is processed.
        if CA.SV.ExperienceThrottle > 0 and g_xpCombatBufferValue > 0 and (reason ~= 0 and reason ~= 99) then
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
            CA.PrintBufferedXP()
        end
        
        CA.PrintExperienceGain(change)

    end
end

function CA.PrintExperienceGain(change)
    local icon = CA.SV.ExperienceIcon and ("|t16:16:/esoui/art/icons/icon_experience.dds|t ") or ""
    local xpName = strformat(CA.SV.ExperienceName, change)
    local messageP1 = ("|r|c" .. ExperienceNameColorize .. icon .. ZO_LocalizeDecimalNumber(change) .. " " .. xpName .. "|r|c" .. ExperienceMessageColorize)
    local formattedMessageP1 = (strfmt(CA.SV.ExperienceMessage, messageP1))
    local finalMessage = strfmt("|c%s%s|r", ExperienceMessageColorize, formattedMessageP1)

    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "EXPERIENCE" }
    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
end

function CA.PrintBufferedXP()
    if g_xpCombatBufferValue > 0 and g_xpCombatBufferValue > CA.SV.ExperienceFilter then
        local change = g_xpCombatBufferValue
        CA.PrintExperienceGain(change)
    end
    EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
    g_xpCombatBufferValue = 0
end

-- Helper function to return color (without |c prefix) according to current percentage
local function AchievementPctToColour(pct)
    return pct == 1 and "71DE73" or pct < 0.33 and "F27C7C" or pct < 0.66 and "EDE858" or "CCF048"
end

-- Printer function for achievement CA
function CA.PrintAchievementDetails(stringpart1, stringpart2, stringpart3, stringpart4)
    printToChat( strfmt("%s%s%s%s", stringpart1, stringpart2, stringpart3, stringpart4))
end

function CA.OnAchievementUpdated(eventCode, id)

    local topLevelIndex, categoryIndex, achievementIndex = GetCategoryInfoFromAchievementId(id)

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
    --if topLevelIndex == 12 and not CA.SV.AchievementCategory12 then return end

    if CA.SV.AchievementUpdateCA or CA.SV.AchievementUpdateAlert then
        local totalCmp = 0
        local totalReq = 0
        local showInfo = false

        local numCriteria = GetAchievementNumCriteria(id)
        local cmpInfo = {}
        for i = 1, numCriteria do
            local name, numCompleted, numRequired = GetAchievementCriterion(id, i)

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
            if ( totalCmp == totalReq ) or ( totalCmp == 1 ) or ( CA.SV.AchievementStep == 0 ) then
                showInfo = true
            else
                -- Achievement step hit
                local percentage = math.floor( 100 / totalReq * totalCmp )

                if percentage > 0 and percentage % CA.SV.AchievementStep == 0 and g_achievementLastPercentage[id] ~= percentage then
                    showInfo = true
                    g_achievementLastPercentage[id] = percentage
                end
            end
        end

        -- Bail out here if this achievement update event is not going to be printed to chat
        if not showInfo then
            return
        end
        
        local link = strformat(GetAchievementLink(id, linkBrackets[CA.SV.BracketOptionAchievement]))
        local name = strformat(GetAchievementNameFromLink(link))
        
        if CA.SV.AchievementUpdateCA then
            local catName = GetAchievementCategoryInfo(topLevelIndex)
            local subcatName = categoryIndex ~= nil and GetAchievementSubCategoryInfo(topLevelIndex, categoryIndex) or "General"
            local _, _, _, icon = GetAchievementInfo(id)
            icon = CA.SV.AchievementIcon and ("|t16:16:" .. icon .. "|t ") or ""
            
            local stringpart1 = AchievementColorize1:Colorize(strfmt("%s%s%s %s%s", bracket1[CA.SV.AchievementBracketOptions], CA.SV.AchievementProgressMsg, bracket2[CA.SV.AchievementBracketOptions], icon, link))
            
            local stringpart2 = CA.SV.AchievementColorProgress and strfmt(" %s|c%s%d%%|r", AchievementColorize2:Colorize("("), AchievementPctToColour(totalCmp/totalReq), math.floor(100*totalCmp/totalReq)) or AchievementColorize2:Colorize(strfmt("%d%%", math.floor(100*totalCmp/totalReq)))
            
            local stringpart3
            if CA.SV.AchievementCategory and CA.SV.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(strfmt(") %s%s - %s%s", bracket3[CA.SV.AchievementCatBracketOptions], catName, subcatName, bracket4[CA.SV.AchievementCatBracketOptions]))
            elseif CA.SV.AchievementCategory and not CA.SV.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(strfmt(") %s%s%s", bracket3[CA.SV.AchievementCatBracketOptions], catName, bracket4[CA.SV.AchievementCatBracketOptions]))
            else
                stringpart3 = AchievementColorize2:Colorize(")")
            end
            
            -- Prepare details information
            local stringpart4 = ""
            if CA.SV.AchievementDetails then
                -- Skyshards needs separate treatment otherwise text become too long
                -- We also put this short information for achievements that has too many subitems
                if topLevelIndex == 9 or #cmpInfo > 12 then
                    stringpart4 = CA.SV.AchievementColorProgress and strfmt( " %s|c%s%d|r%s|c71DE73%d|c87B7CC|r%s", AchievementColorize2:Colorize("("), AchievementPctToColour(totalCmp/totalReq), totalCmp, AchievementColorize2:Colorize("/"), totalReq, AchievementColorize2:Colorize(")") ) or AchievementColorize2:Colorize(strfmt( " (%d/%d)", totalCmp, totalReq))
                else
                    for i = 1, #cmpInfo do
                        -- Boolean achievement stage
                        if cmpInfo[i][3] == 1 then
                            cmpInfo[i] = CA.SV.AchievementColorProgress and strfmt( "|c%s%s", AchievementPctToColour(cmpInfo[i][2]), cmpInfo[i][1] ) or AchievementColorize2:Colorize(strfmt( "%s%s", cmpInfo[i][2], cmpInfo[i][1] ))
                        -- Others
                        else
                            local pct = cmpInfo[i][2] / cmpInfo[i][3]
                            cmpInfo[i] = CA.SV.AchievementColorProgress and strfmt( "%s %s|c%s%d|r%s|c71DE73%d|r%s", AchievementColorize2:Colorize(cmpInfo[i][1]), AchievementColorize2:Colorize("("), AchievementPctToColour(pct), cmpInfo[i][2], AchievementColorize2:Colorize("/"), cmpInfo[i][3], AchievementColorize2:Colorize(")") ) or AchievementColorize2:Colorize(strfmt( "%s (%d/%d)", cmpInfo[i][1], cmpInfo[i][2], cmpInfo[i][3] ))
                        end
                    end
                    stringpart4 = " " .. table.concat(cmpInfo, AchievementColorize2:Colorize(", ")) .. ""
                end
            end
            zo_callLater(function() CA.PrintAchievementDetails(stringpart1, stringpart2, stringpart3, stringpart4) end, 100)
        end
        
        if CA.SV.AchievementUpdateAlert then
            local alertMessage = zo_strformat("<<1>>: <<2>>", CA.SV.AchievementProgressMsg, name)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
        end
        
    end
    
end

function CA.GuildBankItemAdded(eventCode, slotId)
    zo_callLater(CA.LogGuildBankChange, 50)
end

function CA.GuildBankItemRemoved(eventCode, slotId)
    zo_callLater(CA.LogGuildBankChange, 50)
end

function CA.LogGuildBankChange()
    if g_guildBankCarry ~= nil then
        CA.ItemPrinter(g_guildBankCarry.icon, g_guildBankCarry.stack, g_guildBankCarry.itemType, g_guildBankCarry.itemId, g_guildBankCarry.itemLink, g_guildBankCarry.receivedBy, g_guildBankCarry.logPrefix, g_guildBankCarry.gainOrLoss, false)
    end
    g_guildBankCarry = nil
end

function CA.IndexInventory()
    --d("Debug - Inventory Indexed!")
    local bagsize = GetBagSize(1)

    for i = 0,bagsize do
        local icon, stack = GetItemInfo(1, i)
        local itemType = GetItemType(1, i)
        local itemId = GetItemId(1, i)
        local itemLink = GetItemLink(1, i, linkBrackets[CA.SV.BracketOptionItem])
        if itemLink ~= "" then
            g_inventoryStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end
end

function CA.IndexEquipped()
    --d("Debug - Equipped Items Indexed!")
    local bagsize = GetBagSize(0)

    for i = 0,bagsize do
        local icon, stack = GetItemInfo(0, i)
        local itemType = GetItemType(0, i)
        local itemId = GetItemId(0, i)
        local itemLink = GetItemLink(0, i, linkBrackets[CA.SV.BracketOptionItem])
        if itemLink ~= "" then
            g_equippedStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end
end

function CA.IndexBank()
    --("Debug - Bank Indexed!")
    local bagsizebank = GetBagSize(2)
    local bagsizesubbank = GetBagSize(6)

    for i = 0,bagsizebank do
        local icon, stack = GetItemInfo(2, i)
        local bagitemlink = GetItemLink(2, i, linkBrackets[CA.SV.BracketOptionItem])
        local itemId = GetItemId(2, i)
        local itemLink = GetItemLink(2, i, linkBrackets[CA.SV.BracketOptionItem])
        if bagitemlink ~= "" then
            g_bankStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end
    
    for i = 0,bagsizesubbank do
        local icon, stack = GetItemInfo(6, i)
        local bagitemlink = GetItemLink(6, i, linkBrackets[CA.SV.BracketOptionItem])
        local itemId = GetItemId(6, i)
        local itemLink = GetItemLink(6, i, linkBrackets[CA.SV.BracketOptionItem])
        if bagitemlink ~= "" then
            g_banksubStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        end
    end 
    
end

function CA.CraftingOpen(eventCode, craftSkill, sameStation)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.LootCraft then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateCraft)
        g_inventoryStacks = {}
        g_bankStacks = {}
        g_banksubStacks = {}
        CA.IndexInventory() -- Index Inventory
        CA.IndexBank() -- Index Bank
    end
end

function CA.CraftingClose(eventCode, craftSkill)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.Loot or CA.SV.LootShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    g_bankStacks = {}
    g_banksubStacks = {}
end

function CA.BankOpen(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.LootBank then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateBank)
        g_inventoryStacks = {}
        g_bankStacks = {}
        g_banksubStacks = {}
        CA.IndexInventory() -- Index Inventory
        CA.IndexBank() -- Index Bank
    end
end

function CA.BankClose(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.Loot or CA.SV.LootShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    g_bankStacks = {}
    g_banksubStacks = {}
end

function CA.GuildBankOpen(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.LootBank then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateGuildBank)
        g_inventoryStacks = {}
        CA.IndexInventory() -- Index Inventory
    end
end

function CA.GuildBankClose(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.Loot or CA.SV.LootShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.LootShowDisguise) then
        g_inventoryStacks = {}
    end
end

function CA.FenceOpen(eventCode, allowSell, allowLaunder)
    g_weAreInAFence = true
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.LootVendor then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdateFence)
        g_inventoryStacks = {}
        CA.IndexInventory() -- Index Inventory
    end
end

function CA.StoreOpen(eventCode)
    g_weAreInAStore = true
end

function CA.StoreClose(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.Loot or CA.SV.LootShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.LootShowDisguise) then
        g_inventoryStacks = {}
    end
    g_weAreInAStore = false
    g_weAreInAFence = false
end

function CA.FenceSuccess(eventCode, result)
    if result == 1 then
        CA.CurrencyPrinter(g_savedPurchase.formattedValue, g_savedPurchase.changeColor, g_savedPurchase.changeType, g_savedPurchase.currencyTypeColor, g_savedPurchase.currencyIcon, g_savedPurchase.currencyName, g_savedPurchase.currencyTotal, g_savedPurchase.messageChange, g_savedPurchase.messageTotal, g_savedPurchase.type, g_savedPurchase.carriedItem, g_savedPurchase.carriedItemTotal)
        g_savedPurchase = { }
    end
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

local questItemIndex = { }

function CA.AddQuestItemsToIndex()

    questItemIndex = { }

    local function AddQuests(questIndex)
    
        local inventory = PLAYER_INVENTORY.inventories[INVENTORY_QUEST_ITEM]
        local itemTable = inventory.slots[questIndex]
        if itemTable then
            --remove all quest items from search
            for i = 1, #itemTable do
                local itemId = itemTable[i].questItemId
                local stackCount = itemTable[i].stackCount
                local icon = itemTable[i].iconFile
                questItemIndex[itemId] = { stack = stackCount, counter = 0, icon = icon }
            end
        end
    end
    
    for questIndex = 1, MAX_JOURNAL_QUESTS do
        AddQuests(questIndex)
    end
    
end

function CA.ResolveQuestItemChange()

    for itemId, _ in pairs(questItemIndex) do
    
        local countChange = nil
        local newValue = questItemIndex[itemId].stack + questItemIndex[itemId].counter
        
        -- Only if the value changes
        if newValue > questItemIndex[itemId].stack or newValue < questItemIndex[itemId].stack then
        
            local icon = questItemIndex[itemId].icon
            local formattedIcon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
            local itemLink = strfmt("|H1:quest_item:" .. itemId .. "|h|h")
            
            
            local color
            local logPrefix
            local total = questItemIndex[itemId].stack + questItemIndex[itemId].counter
            local totalString
            
            local formattedMessageP1
            local formattedMessageP2
            local finalMessage
        
            -- Higher
            if newValue > questItemIndex[itemId].stack then
                countChange = newValue - questItemIndex[itemId].stack
                
                if CA.SV.LootQuestAdd then 
                    if CA.SV.CurrencyContextColor then
                        color = CurrencyUpColorize:ToHex()
                    else
                        color = CurrencyColorize:ToHex()
                    end
                    
                    if g_isLooted and not g_itemReceivedIsQuestReward and not g_isPickpocketed and not g_isStolen then
                        logPrefix = CA.SV.LootMessageLoot
                        -- reset variables that control looted, or at least ZO_CallLater them
                    elseif g_isPickpocketed then
                        logPrefix = CA.SV.LootMessagePickpocket
                    elseif g_isStolen and not g_isPickpocketed then
                        logPrefix = CA.SV.LootMessageSteal
                    else
                        logPrefix = CA.SV.LootMessageReceive
                    end
                    
                    local quantity = countChange > 1 and (" |cFFFFFFx" .. countChange .. "|r") or ""
                    
                    formattedMessageP1 = ("|r" .. formattedIcon .. itemLink .. quantity .. "|c" .. color)
                    formattedMessageP2 = strfmt(logPrefix, formattedMessageP1)
                    
                    if CA.SV.LootTotal and total > 1 then
                        totalString = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", color, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                    else
                        totalString = ""
                    end
                    
                    finalMessage = strfmt("|c%s%s|r%s", color, formattedMessageP2, totalString)
                    d(finalMessage)
                end
            
            end
            
            -- Lower
            if newValue < questItemIndex[itemId].stack then
                countChange = newValue + questItemIndex[itemId].counter
                
                if CA.SV.LootQuestRemove then 
                    if CA.SV.CurrencyContextColor then
                        color = CurrencyDownColorize:ToHex()
                    else
                        color = CurrencyColorize:ToHex()
                    end
                    
                    logPrefix = CA.SV.LootMessageDestroy
                    local quantity = countChange < 1 and (" |cFFFFFFx" .. (countChange * -1) .. "|r") or ""
                    
                    formattedMessageP1 = ("|r" .. formattedIcon .. itemLink .. quantity .. "|c" .. color)
                    formattedMessageP2 = strfmt(logPrefix, formattedMessageP1)
                    
                    if CA.SV.LootTotal and total > 1 then
                        totalString = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", color, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                    else
                        totalString = ""
                    end
                    
                    finalMessage = strfmt("|c%s%s|r%s", color, formattedMessageP2, totalString)
                    
                    d(finalMessage)
                end
            end
        end
        
        -- If count changed, update it
        if countChange then 
            
            questItemIndex[itemId].stack = newValue
            questItemIndex[itemId].counter = 0
            --d("New Stack Value = " .. questItemIndex[itemId].stack)
            
            if questItemIndex[itemId].stack < 1 then
                questItemIndex[itemId] = nil
                --d("Item reached 0 or below stacks, removing")
            end
        end
        
    end
    
end

local function DisplayQuestItem(itemId, stackCount, icon, reset)

    if not questItemIndex[itemId] then
        questItemIndex[itemId] = { stack = 0, counter = 0, icon = icon }
        --d("New item created with 0 stack")
    end
    
    if reset then
        --d(itemId .. " - Decrement by: " .. stackCount)
        questItemIndex[itemId].counter = questItemIndex[itemId].counter - stackCount
    else
        --d(itemId .. " - Increment by: " .. stackCount)
        questItemIndex[itemId].counter = questItemIndex[itemId].counter + stackCount
    end

    g_queuedMessages[g_queuedMessagesCounter] = { message = "", type = "QUESTLOOT" }
    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    
end

PLAYER_INVENTORY.AddQuestItem = function(self, questItem, searchType)
    local inventory = self.inventories[INVENTORY_QUEST_ITEM]

    questItem.inventory = inventory
    --store all tools and items in a subtable under the questIndex for faster access
    local questIndex = questItem.questIndex
    if not inventory.slots[questIndex] then
        inventory.slots[questIndex] = {}
    end
    table.insert(inventory.slots[questIndex], questItem)

    local index = #inventory.slots[questIndex]

    if(searchType == SEARCH_TYPE_QUEST_ITEM) then
        questItem.searchData = {type = SEARCH_TYPE_QUEST_ITEM, questIndex = questIndex, stepIndex = questItem.stepIndex, conditionIndex = questItem.conditionIndex, index = index }
    else
        questItem.searchData = {type = SEARCH_TYPE_QUEST_TOOL, questIndex = questIndex, toolIndex = questItem.toolIndex, index = index }
    end
    
    inventory.stringSearch:Insert(questItem.searchData)
    -- Display Item if set to display
    if CA.SV.LootQuestAdd or CA.SV.LootQuestRemove then
        DisplayQuestItem(questItem.questItemId, questItem.stackCount, questItem.iconFile, false)
    end
end

PLAYER_INVENTORY.ResetQuest = function(self, questIndex)
    local inventory = self.inventories[INVENTORY_QUEST_ITEM]
    local itemTable = inventory.slots[questIndex]
    if itemTable then
        --remove all quest items from search
        for i = 1, #itemTable do
            inventory.stringSearch:Remove(itemTable.searchData)
            -- Display Item if set to display
            if CA.SV.LootQuestAdd or CA.SV.LootQuestRemove then
                local itemId = itemTable[i].questItemId
                local stackCount = itemTable[i].stackCount
                local icon = itemTable[i].iconFile
                DisplayQuestItem(itemId, stackCount, icon, true)
            end
        end
    end

    inventory.slots[questIndex] = nil
end

function CA.OnLootReceived(eventCode, receivedBy, itemLink, quantity, itemSound, lootType, lootedBySelf, isPickpocketLoot, questItemIcon, itemId, isStolen)

    -- If the player loots an item
    if not isPickpocketLoot and lootedBySelf then
        g_isLooted = true
        
        local function ResetIsLooted()
            g_isLooted = false
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "ResetLooted")
        end
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "ResetLooted", 200, ResetIsLooted )
    end
    
    -- If the player pickpockets an item
    if isPickpocketLoot and lootedBySelf then
        g_isPickpocketed = true
        
        local function ResetIsPickpocketed()
            g_isPickpocketed = false
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "ResetPickpocket")
        end
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "ResetPickpocket", 200, ResetIsPickpocketed )
    end

    -- Return right now if we don't have group loot set to display
    if not CA.SV.LootGroup then
        return
    end

    --[[
    
    local icon
    -- fix Icon for missing quest items
    if lootType == LOOT_TYPE_QUEST_ITEM then
        icon = questItemIcon
    elseif lootType == LOOT_TYPE_COLLECTIBLE then
        local collectibleId = GetCollectibleIdFromLink(itemLink)
        local _,_,collectibleIcon = GetCollectibleInfo(collectibleId)
        icon = collectibleIcon
    else
        -- Get Icon
        local itemIcon,_,_,_,_ = GetItemLinkInfo(itemLink)
        icon = itemIcon
    end
    
    -- Create Icon string if icon exists and corresponding setting is ON
    icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

    local itemType, specializedItemType = GetItemLinkItemType(itemLink)
    local itemQuality = GetItemLinkQuality(itemLink)
    local itemIsSet = GetItemLinkSetInfo(itemLink)

    -- Workaround for a ZOS bug: Daedric Embers are not flagged in-game as key fragments
    if (itemId == 69059) then
        specializedItemType = SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT
    end

    local itemIsKeyFragment = (itemType == ITEMTYPE_TROPHY) and (specializedItemType == SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT)
    local itemIsSpecial = (itemType == ITEMTYPE_TROPHY and not itemIsKeyFragment) or (itemType == ITEMTYPE_COLLECTIBLE) or IsItemLinkConsumable(itemLink)

    -- Check for Blacklisted loot
    if ( CA.SV.LootBlacklist and g_blacklistIDs[itemId] ) then
        return
    end

    -- Set prefix based on Looted/Pickpocket/Received
    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LOOTED)
    if ( isPickpocketLoot ) then
        logPrefix = GetString(SI_GAMECAMERAACTIONTYPE21)
    end
    if ( receivedBy == nil ) then
        logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN)
    end
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    local gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3

    if ( (lootType ~= LOOT_TYPE_ITEM and lootType ~= LOOT_TYPE_COLLECTIBLE) or
         (itemType == ITEMTYPE_CONTAINER) or -- Don't show containers for group members
         (itemQuality == ITEM_QUALITY_ARCANE and itemType == ITEMTYPE_RACIAL_STYLE_MOTIF) ) then -- Don't show blue motifs for group members
        return
    end
    if ( (itemIsSet) or
         (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
         (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
         (lootType == LOOT_TYPE_COLLECTIBLE) or
         (g_notableIDs[itemId]) ) then

        CA.LogItem( logPrefix, icon, itemLink, itemType, quantity, self and "" or receivedBy, gainOrLoss )
    end
    
    ]]--
end

-- If filter is true, we run the item through this function to determine if we should display it. Filter only gets set to true for relevant loot functions, mail, trade, stores, etc don't apply the filter.
function CA.ItemFilter(itemType, itemId, itemLink)

    if ( CA.SV.LootBlacklist and g_blacklistIDs[itemId] ) then
        return false
    end
    
    local _, specializedItemType = GetItemLinkItemType(itemLink)
    local itemQuality = GetItemLinkQuality(itemLink)
    local itemIsSet = GetItemLinkSetInfo(itemId)
    
    -- TODO: Not sure if still needed
    if (itemId == 69059) then
        specializedItemType = SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT
    end
    
    local itemIsKeyFragment = (itemType == ITEMTYPE_TROPHY) and (specializedItemType == SPECIALIZED_ITEMTYPE_TROPHY_KEY_FRAGMENT)
    local itemIsSpecial = (itemType == ITEMTYPE_TROPHY and not itemIsKeyFragment) or (itemType == ITEMTYPE_COLLECTIBLE) or IsItemLinkConsumable(item)
    
    if CA.SV.LootOnlyNotable then
        -- Notable items are: any set items, any purple+ items, blue+ special items (e.g., treasure maps)
        if ( (itemIsSet) or
             (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
             (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
             (itemType == ITEMTYPE_COSTUME) or
             (itemType == ITEMTYPE_DISGUISE) or
             (g_notableIDs[itemId]) ) then

            return true
        end
    elseif CA.SV.LootNotTrash and ( itemQuality == ITEM_QUALITY_TRASH ) and not ( ( itemType == ITEMTYPE_ARMOR) or (itemType == ITEMTYPE_COSTUME) or (itemType == ITEMTYPE_DISGUISE) ) then
        return false
    else
        return true
    end
    
end

-- TODO: Make this work
local LUIE_EXCLUDE_STYLES = {

    ITEMTYPE_ADDITIVE = true,
    ITEMTYPE_ARMOR_BOOSTER = true,
    ITEMTYPE_ARMOR_TRAIT = true,
    ITEMTYPE_BLACKSMITHING_BOOSTER = true,
    ITEMTYPE_BLACKSMITHING_MATERIAL = true,
    ITEMTYPE_CLOTHIER_BOOSTER = true,
    ITEMTYPE_CLOTHIER_MATERIAL = true,
    ITEMTYPE_ENCHANTING_RUNE_ASPECT = true,
    ITEMTYPE_ENCHANTING_RUNE_ESSENCE = true,
    ITEMTYPE_ENCHANTING_RUNE_POTENCY = true,
    ITEMTYPE_ENCHANTMENT_BOOSTER = true,
    ITEMTYPE_INGREDIENT = true,
    ITEMTYPE_POISON_BASE = true,
    ITEMTYPE_POTION_BASE = true,
    ITEMTYPE_REAGENT = true,
    ITEMTYPE_STYLE_MATERIAL = true,
    ITEMTYPE_WEAPON_BOOSTER = true,
    ITEMTYPE_WEAPON_TRAIT = true,
    ITEMTYPE_WOODWORKING_BOOSTER = true,
    ITEMTYPE_WOODWORKING_MATERIAL = true,
    ITEMTYPE_GLYPH_ARMOR = true,
    ITEMTYPE_GLYPH_JEWELRY = true,
    ITEMTYPE_GLYPH_WEAPON  = true,

}

function CA.ItemPrinter(icon, stack, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, filter)

    if filter then 
        -- If filter returns false then bail out right now, we're not displaying this item.
        if not CA.ItemFilter(itemType, itemId, itemLink) then return end
    end
    
    local formattedIcon = (CA.SV.LootIcons and icon ~= "") and zo_strformat("<<1>> ", zo_iconFormat(icon, 16, 16)) or ""
    local color
    if gainOrLoss == 1 then
        color = CurrencyUpColorize:ToHex()
    elseif gainOrLoss == 2 then
        color = CurrencyDownColorize:ToHex()
    -- 3 = Gain no color, 4 = Loss no color (differentiation only exists for Crafting Strings)
    elseif gainOrLoss == 3 or gainOrLoss == 4 then
        color = CurrencyColorize:ToHex()
    end
    
    local formattedRecipient
    local formattedQuantity
    local formattedTrait
    local formattedArmorType
    local formattedStyle
    
    if (receivedBy == "" or receivedBy == "CRAFT" or receivedBy == "LUIE_INVENTORY_UPDATE_DISGUISE") then
        -- Don't display yourself
        formattedRecipient = ""
    else
        -- Create a character link to make it easier to contact the recipient
        -- TODO edit this to be a standard character link instead
        --[[formattedRecipient = strfmt(
            "%s |c%06X|H0:character:%s|h%s|h|r",
            arrowPointer,
            HashString(receivedBy) % 0x1000000, -- Use the hash of the name for the color so that is random, but consistent
            receivedBy,
            receivedBy:gsub("%^%a+$", "", 1)
        )]]--
        formattedRecipient = receivedBy
    end
    
    if (stack > 1) then
        formattedQuantity = strfmt(" |cFFFFFFx%d|r", stack)
    else
        formattedQuantity = ""
    end
    
    local armorType = GetItemLinkArmorType(itemLink) -- Get Armor Type of item
    formattedArmorType = (CA.SV.LootShowArmorType and armorType ~= ARMORTYPE_NONE and logPrefix ~= CA.SV.LootMessageUpgrade ) and strfmt(" |cFFFFFF(%s)|r", GetString("SI_ARMORTYPE", armorType)) or ""
    
    local traitType = GetItemLinkTraitInfo(itemLink) -- Get Trait type of item
    formattedTrait = (CA.SV.LootShowTrait and traitType ~= ITEM_TRAIT_TYPE_NONE and itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT and logPrefix ~= CA.SV.LootMessageUpgrade ) and strfmt(" |cFFFFFF(%s)|r", GetString("SI_ITEMTRAITTYPE", traitType)) or ""
    
    local styleType = GetItemLinkItemStyle(itemLink) -- Get Style of the item
    local unformattedStyle = strformat("<<1>>", GetItemStyleName(styleType))
    formattedStyle = (CA.SV.LootShowStyle 
        and styleType ~= ITEMSTYLE_NONE 
        and styleType ~= ITEMSTYLE_UNIQUE 
        and styleType ~= ITEMSTYLE_UNIVERSAL 
        and itemType ~= ITEMTYPE_STYLE_MATERIAL
        and itemType ~= ITEMTYPE_GLYPH_ARMOR 
        and itemType ~= ITEMTYPE_GLYPH_JEWELRY 
        and itemType ~= ITEMTYPE_GLYPH_WEAPON 
        and logPrefix ~= CA.SV.LootMessageUpgrade )
    and strfmt(" |cFFFFFF(%s)|r", unformattedStyle) or ""
    
    local formattedTotal = ""
    if CA.SV.LootTotal and receivedBy ~= "LUIE_INVENTORY_UPDATE_DISGUISE" then
        local total1, total2, total3 = GetItemLinkStacks(itemLink)
        local total = total1 + total2 + total3
        if total > 1 then
            formattedTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", color, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end
    
    local itemString = strfmt("%s%s%s%s%s%s", formattedIcon, itemLink, formattedQuantity, formattedArmorType, formattedTrait, formattedStyle)
    
    -- Printer function, seperate handling for listed entires (from crafting) or simple function that sends a message over to the printer.
    if receivedBy == "CRAFT" and (gainOrLoss == 1 or gainOrLoss == 3) and logPrefix ~= CA.SV.LootMessageUpgradeFail then
        local itemString2 = itemString
        
        if g_itemStringGain ~= "" then
            g_itemStringGain = strfmt("%s|c%s,|r %s", g_itemStringGain, color, itemString2)
        end
        if g_itemStringGain == "" then
            g_itemStringGain = itemString
        end
        
        if g_itemCounterGain == 0 then g_itemCounterGain = g_queuedMessagesCounter end
        if g_queuedMessagesCounter -1 == g_itemCounterGain then g_queuedMessagesCounter = g_itemCounterGain end
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        g_queuedMessages[g_itemCounterGain] = { message=g_itemStringGain, type = "LOOT", formattedRecipient=formattedRecipient, color=color, logPrefix=logPrefix, totalString="" }
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    elseif receivedBy == "CRAFT" and (gainOrLoss == 2 or gainOrLoss == 4) and logPrefix ~= CA.SV.LootMessageUpgradeFail then
        local itemString2 = itemString
        if g_itemStringLoss ~= "" then
            g_itemStringLoss = strfmt("%s|c%s,|r %s", g_itemStringLoss, color, itemString2)
        end
        if g_itemStringLoss == "" then
            g_itemStringLoss = itemString
        end
        if g_itemCounterLoss == 0 then g_itemCounterLoss = g_queuedMessagesCounter end
        if g_queuedMessagesCounter -1 == g_itemCounterLoss then g_queuedMessagesCounter = g_itemCounterLoss end
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        g_queuedMessages[g_itemCounterLoss] = { message=g_itemStringLoss, type = "LOOT", formattedRecipient=formattedRecipient, color=color, logPrefix=logPrefix, totalString=""}
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    else
        local totalString = formattedTotal
        g_queuedMessages[g_queuedMessagesCounter] = { message=itemString, type = "LOOT", formattedRecipient=formattedRecipient, color=color, logPrefix=logPrefix, totalString=totalString }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
    end
    
end

-- Simple function combines our strings or modifies the prefix if RECEIEVED instead of looted
function CA.ResolveItemMessage(message, formattedRecipient, color, logPrefix, totalString)

    -- Conditions for looted/quest item rewards to adjust string prefix.
    if logPrefix == "" then
        if g_isLooted and not g_itemReceivedIsQuestReward and not g_isPickpocketed and not g_isStolen then
            logPrefix = CA.SV.LootMessageLoot
            -- reset variables that control looted, or at least ZO_CallLater them
        elseif g_isPickpocketed then
            logPrefix = CA.SV.LootMessagePickpocket
        elseif g_isStolen and not g_isPickpocketed then
            logPrefix = CA.SV.LootMessageSteal
        else
            logPrefix = CA.SV.LootMessageReceive
        end
    end
    
    local formattedMessageP1
    local formattedMessageP2
    
    -- Adds additional string for previous variant of an item when an item is upgraded.
    if logPrefix == CA.SV.LootMessageUpgrade and g_oldItem ~= nil and g_oldItem.itemLink ~= "" then
        local formattedIcon = (CA.SV.LootIcons and g_oldItem.icon ~= "") and zo_strformat("<<1>> ", zo_iconFormat(g_oldItem.icon, 16, 16)) or ""
        local formattedMessageUpgrade = ("|r" .. formattedIcon .. g_oldItem.itemLink .. "|c" .. color)
        formattedMessageP1 = ("|r" .. message .. "|c" .. color)
        formattedMessageP2 = strfmt(logPrefix, formattedMessageUpgrade, formattedMessageP1)
        g_oldItem = { }
    else
        formattedMessageP1 = ("|r" .. message .. "|c" .. color)
        if formattedRecipient == "" then
            formattedMessageP2 = strfmt(logPrefix, formattedMessageP1)
        else
            local recipient = ("|r" .. formattedRecipient .. "|c" .. color)
            formattedMessageP2 = strfmt(logPrefix, formattedMessageP1, recipient)
        end
    end

    local finalMessage = strfmt("|c%s%s|r%s", color, formattedMessageP2, totalString)
    
    printToChat(finalMessage)
    
    -- Reset variables for crafted item counter
    g_itemCounterGain = 0
    g_itemCounterLoss = 0
    g_itemStringGain = ""
    g_itemStringLoss = ""
    
   -- "You loot %s."
   -- "You receive %s."
end


-- Simple posthook into ZOS crafting mode functions, based off MultiCraft, thanks Ayantir!
function CA.CraftModeOverrides()
    -- Set mode on Smithing Station interaction
	local zos_Smithing = ZO_Smithing.SetMode
	ZO_Smithing.SetMode = function(...)
		zos_Smithing(...)
        if GetCraftingInteractionType() == CRAFTING_TYPE_SMITHNG then
            mode = g_smithing:GetMode()
        end
	end

    -- Get SMITHING mode
	g_smithing.GetMode = function()
		return SMITHING.mode
	end

    -- Set mode on Enchanting Station interaction
    local zos_Enchanting = ZO_Enchanting.SetEnchantingMode
	ZO_Enchanting.SetEnchantingMode = function(...)
		zos_Enchanting(...)
        if GetCraftingInteractionType() == CRAFTING_TYPE_ENCHANTING then
            mode = g_enchanting:GetMode() 
        end
    end

    -- Get ENCHANTING mode
    g_enchanting.GetMode = function()
		return ENCHANTING:GetEnchantingMode()
	end

    -- NOTE: Alchemy and provisioning don't matter, as the only options are to craft and use materials.
    
    -- Crafting Mode Syntax (Enchanting - Item Gain)
    g_enchant_prefix_pos = {
        [1] = CA.SV.LootMessageCraft,
        [2] = CA.SV.LootMessageReceive,
        [3] = CA.SV.LootMessageCraft,
    }

    -- Crafting Mode Syntax (Enchanting - Item Loss)
    g_enchant_prefix_neg = {
        [1] = CA.SV.LootMessageUse,
        [2] = CA.SV.LootMessageExtract,
        [3] = CA.SV.LootMessageUse,
    }

    -- Crafting Mode Syntax (Blacksmithing - Item Gain)
    g_smithing_prefix_pos = {
        [1] = CA.SV.LootMessageReceive,
        [2] = CA.SV.LootMessageCraft,
        [3] = CA.SV.LootMessageReceive,
        [4] = CA.SV.LootMessageUpgrade,
        [5] = "",
        [6] = CA.SV.LootMessageCraft,
    }

    -- Crafting Mode Syntax (Blacksmithing - Item Loss)
    g_smithing_prefix_neg = {
        [1] = CA.SV.LootMessageRefine,
        [2] = CA.SV.LootMessageUse,
        [3] = CA.SV.LootMessageDeconstruct,
        [4] = CA.SV.LootMessageUpgradeFail,
        [5] = CA.SV.LootMessageResearch,
        [6] = CA.SV.LootMessageUse,
    }
end

    
function CA.InventoryUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end

    if IsItemStolen(bagId, slotId) then 
        g_isStolen = true
        local function ResetIsStolen()
            g_isStolen = false
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "ResetStolen")
        end
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "ResetStolen", 200, ResetIsStolen )
    end     
    
    local receivedBy = ""
    if bagId == BAG_WORN then
    
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_equippedStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_equippedStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            if CA.SV.LootShowDisguise and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                gainOrLoss = 3
                receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                logPrefix = CA.SV.LootMessageDisguiseEquip
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM    
        elseif g_equippedStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_equippedStacks[slotId].icon
                stack = g_equippedStacks[slotId].stack
                itemType = g_equippedStacks[slotId].itemType
                itemId = g_equippedStacks[slotId].itemId
                itemLink = g_equippedStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT REMAINED THE SAME (GEAR SWAPPED)
            if stackCountChange == 0 then
                if CA.SV.LootShowDisguise and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                    gainOrLoss = 3
                    receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                    logPrefix = CA.SV.LootMessageDisguiseEquip
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                -- TODO: Remove, nothing to do here!
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.LootShowDestroy then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if CA.SV.LootShowDisguise and not g_itemWasDestroyed and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                    if IsUnitInCombat("player") then
                        logPrefix = CA.SV.LootMessageDisguiseDestroy
                        receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                        gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    else
                        logPrefix = CA.SV.LootMessageDisguiseRemove
                        receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                        gainOrLoss = 3
                    end
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_equippedStacks[slotId] then 
                    g_equippedStacks[slotId] = nil
                end
            else
                g_equippedStacks[slotId] = { icon=icon, stack=stack, itemId =itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_BACKPACK then
    
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            if g_inTrade then 
                logPrefix = CA.SV.LootMessageTradeIn
            elseif g_inMail then
                logPrefix = CA.SV.LootMessageMailIn
            else
                logPrefix = ""
            end
            if not g_weAreInAStore and CA.SV.Loot and isNewItem and not g_inTrade and not g_inMail then
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
            end
            if g_inTrade then
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_tradeTarget, logPrefix, gainOrLoss, false)
            end
            if g_inMail then
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM    
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                if g_inTrade then 
                    logPrefix = CA.SV.LootMessageTradeIn
                elseif g_inMail then
                    logPrefix = CA.SV.LootMessageMailIn
                else
                    logPrefix = ""
                end
                if not g_weAreInAStore and CA.SV.Loot and isNewItem and not g_inTrade and not g_inMail then
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
                end
                if g_inTrade then
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_tradeTarget, logPrefix, gainOrLoss, false)
                end
                if g_inMail then
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.LootShowDestroy then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDestroy
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if CA.SV.LootShowLockpick and g_lockpickBroken then
                    logPrefix = CA.SV.LootMessageLockpick
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if g_inTrade and not g_itemWasDestroyed then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageTradeOut
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, g_tradeTarget, logPrefix, gainOrLoss, false)
                end
                if g_inMail and not g_itemWasDestroyed then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageMailOut
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_inventoryStacks[slotId] then 
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end
    
    if bagId == BAG_VIRTUAL then
        local gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
        local logPrefix
        if g_inTrade then 
            logPrefix = CA.SV.LootMessageTradeIn
        elseif g_inMail then
            logPrefix = CA.SV.LootMessageMailIn
        else
            logPrefix = ""
        end
        local itemLink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink) 
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)
        
        if not g_weAreInAStore and CA.SV.Loot and isNewItem and not g_inTrade and not g_inMail then
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
        end
        if g_inTrade then
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_tradeTarget, logPrefix, gainOrLoss, false)
        end
        if g_inMail then
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, g_mailTarget, logPrefix, gainOrLoss, false)
        end
    end
    
    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function CA.InventoryUpdateCraft(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)
    
    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end
    
    local function ResolveCraftingUsed(itemType)
        if (GetCraftingInteractionType() == CRAFTING_TYPE_BLACKSMITHING or GetCraftingInteractionType() == CRAFTING_TYPE_CLOTHIER or GetCraftingInteractionType() == CRAFTING_TYPE_WOODWORKING) and g_smithing.GetMode() == 4 then
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
                return true
            end
        end
    end
    
    -- TODO: Edit this string to be something more complex, otherwise if for some reason a player was named Craft and looted something it would cause problems.
    local receivedBy = "CRAFT" -- This keyword tells our item printer to print the items in a list separated by commas, to conserve space for the display of crafting mats consumed.
    local logPrefixPos = CA.SV.LootMessageCraft
    local logPrefixNeg = CA.SV.LootMessageUse

    -- Get string values from our crafting hook function
    if GetCraftingInteractionType() == CRAFTING_TYPE_ENCHANTING then
        logPrefixPos = g_enchant_prefix_pos[g_enchanting.GetMode()]
        logPrefixNeg = g_enchant_prefix_neg[g_enchanting.GetMode()]
    end
    if (GetCraftingInteractionType() == CRAFTING_TYPE_BLACKSMITHING or GetCraftingInteractionType() == CRAFTING_TYPE_CLOTHIER or GetCraftingInteractionType() == CRAFTING_TYPE_WOODWORKING) then
        logPrefixPos = g_smithing_prefix_pos[g_smithing.GetMode()]
        logPrefixNeg = g_smithing_prefix_neg[g_smithing.GetMode()]
    end
    
    -- If the hook function didn't return a string value (for example because the player was in Gamepad mode), then we use a default override.
    if logPrefixPos == nil then logPrefixPos = CA.SV.LootMessageCraft end
    if logPrefixNeg == nil then logPrefixNeg = CA.SV.LootMessageDeconstruct end
    
    if bagId == BAG_BACKPACK then
    
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = logPrefixPos
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM    
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT CHANGE = 0 (UPGRADE)
            if stackCountChange == 0 then
                g_oldItem = { itemLink=g_inventoryStacks[slotId].itemLink, icon=icon } -- Sends over to LogItem to do an upgrade string! (TODO: Needs update!)
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
                if logPrefix ~= CA.SV.LootMessageUse or CA.SV.LootShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_inventoryStacks[slotId] then 
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_BANK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_bankStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = logPrefixPos
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM    
        elseif g_bankStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_bankStacks[slotId].icon
                stack = g_bankStacks[slotId].stack
                itemType = g_bankStacks[slotId].itemType
                itemId = g_bankStacks[slotId].itemId
                itemLink = g_bankStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT CHANGE = 0 (UPGRADE)
            if stackCountChange == 0 then
                g_oldItem = { itemLink=g_bankStacks[slotId].itemLink, icon=icon } -- Sends over to LogItem to do an upgrade string! (TODO: Needs update!)
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
                if logPrefix ~= CA.SV.LootMessageUse or CA.SV.LootShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_bankStacks[slotId] then 
                    g_bankStacks[slotId] = nil
                end
            else
                g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end
    
    if bagId == BAG_SUBSCRIBER_BANK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_banksubStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = logPrefixPos
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM    
        elseif g_banksubStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_banksubStacks[slotId].icon
                stack = g_banksubStacks[slotId].stack
                itemType = g_banksubStacks[slotId].itemType
                itemId = g_banksubStacks[slotId].itemId
                itemLink = g_banksubStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT CHANGE = 0 (UPGRADE)
            if stackCountChange == 0 then
                g_oldItem = { itemLink=g_banksubStacks[slotId].itemLink, icon=icon } -- Sends over to LogItem to do an upgrade string! (TODO: Needs update!)
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
                if logPrefix ~= CA.SV.LootMessageUse or CA.SV.LootShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_banksubStacks[slotId] then 
                    g_banksubStacks[slotId] = nil
                end
            else
                g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end

    if bagId == BAG_VIRTUAL then
        local gainOrLoss
        local localPrefix
        local itemLink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink) 
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)
        local change

        if stackCountChange > 0 then
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageReceive or logPrefixPos
            change = stackCountChange
        end
        
        if stackCountChange < 0 then
            gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
            logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
            change = stackCountChange * -1
        end

        if logPrefix ~= CA.SV.LootMessageUse or CA.SV.LootShowCraftUse then
            CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        end
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function CA.InventoryUpdateBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

-- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end

    local receivedBy = ""
    if bagId == BAG_BACKPACK then
    
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = CA.SV.LootMessageWithdraw
            if InventoryOn then
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
            end
        -- EXISTING ITEM    
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = CA.SV.LootMessageWithdraw
                if InventoryOn then
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.LootShowDestroy then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDestroy
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if InventoryOn and not g_itemWasDestroyed then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDesposit
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_inventoryStacks[slotId] then 
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
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
    end
    
    if bagId == BAG_BANK then
    
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_bankStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
            logPrefix = CA.SV.LootMessageDeposit
            if BankOn then
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
            end
        -- EXISTING ITEM    
        elseif g_bankStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_bankStacks[slotId].icon
                stack = g_bankStacks[slotId].stack
                itemType = g_bankStacks[slotId].itemType
                itemId = g_bankStacks[slotId].itemId
                itemLink = g_bankStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                logPrefix = CA.SV.LootMessageDeposit
                if BankOn then
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.LootShowDestroy then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDestroy
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if BankOn and not g_itemWasDestroyed then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDeposit
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_bankStacks[slotId] then 
                    g_bankStacks[slotId] = nil
                end
            else
                g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
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
    
    if bagId == BAG_SUBSCRIBER_BANK then
    
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_banksubStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
            logPrefix = CA.SV.LootMessageDeposit
            if BankOn then
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
            end
        -- EXISTING ITEM    
        elseif g_banksubStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_banksubStacks[slotId].icon
                stack = g_banksubStacks[slotId].stack
                itemType = g_banksubStacks[slotId].itemType
                itemId = g_banksubStacks[slotId].itemId
                itemLink = g_banksubStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            -- STACK COUNT INCREMENTED UP
            if stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                logPrefix = CA.SV.LootMessageDeposit
                if BankOn then
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.LootShowDestroy then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDestroy
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if BankOn and not g_itemWasDestroyed then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDeposit
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
            end
            
            if removed then
                if g_banksubStacks[slotId] then 
                    g_banksubStacks[slotId] = nil
                end
            else
                g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
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
    
    if bagId == BAG_VIRTUAL then
        local gainOrLoss
        local stack
        local logPrefix
        local itemLink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink) 
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)
        
        if stackCountChange < 1 then
            gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
            logPrefix = CA.SV.LootMessageDeposit
            stack = stackCountChange * -1
        else
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = CA.SV.LootMessageWithdraw
            stack = stackCountChange
        end
        
        CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
    end
    
    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function CA.InventoryUpdateGuildBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    local receivedBy = ""
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        
        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = CA.SV.LootMessageWithdrawGuild
            g_guildBankCarry = { }
            g_guildBankCarry.icon = icon
            g_guildBankCarry.stack = stack
            g_guildBankCarry.gainOrLoss = gainOrLoss
            g_guildBankCarry.logPrefix = logPrefix
            g_guildBankCarry.receivedBy = receivedBy
            g_guildBankCarry.itemLink = itemLink
            g_guildBankCarry.itemId = itemId
            g_guildBankCarry.itemType = itemType

        elseif g_inventoryStacks[slotId] then -- EXISTING ITEM
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end

            if stackCountChange > 0 then -- STACK COUNT INCREMENTED UP
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = CA.SV.LootMessageWithdrawGuild
                g_guildBankCarry = { }
                g_guildBankCarry.icon = icon
                g_guildBankCarry.stack = stack
                g_guildBankCarry.gainOrLoss = gainOrLoss
                g_guildBankCarry.logPrefix = logPrefix
                g_guildBankCarry.receivedBy = receivedBy
                g_guildBankCarry.itemLink = itemLink
                g_guildBankCarry.itemId = itemId
                g_guildBankCarry.itemType = itemType
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.LootShowDestroy then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDestroy
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if not g_itemWasDestroyed then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDepositGuild
                    g_guildBankCarry = { }
                    g_guildBankCarry.icon = icon
                    g_guildBankCarry.stack = stack
                    g_guildBankCarry.gainOrLoss = gainOrLoss
                    g_guildBankCarry.logPrefix = logPrefix
                    g_guildBankCarry.receivedBy = receivedBy
                    g_guildBankCarry.itemLink = itemLink
                    g_guildBankCarry.itemId = itemId
                    g_guildBankCarry.itemType = itemType
                end
            end
            
            if removed then
                if g_inventoryStacks[slotId] then 
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
            
        end
    end

    ---------------------------------- CRAFTING BAG ----------------------------------
    if bagId == BAG_VIRTUAL then
        local gainOrLoss
        local stack
        local logPrefix
        local itemLink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink) 
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)
        
        if stackCountChange < 1 then
            gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
            logPrefix = CA.SV.LootMessageDepositGuild
            stack = stackCountChange * -1
        else
            gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
            logPrefix = CA.SV.LootMessageWithdrawGuild
            stack = stackCountChange
        end

        g_guildBankCarry = { }
        g_guildBankCarry.icon = icon
        g_guildBankCarry.stack = stack
        g_guildBankCarry.gainOrLoss = gainOrLoss
        g_guildBankCarry.logPrefix = logPrefix
        g_guildBankCarry.receivedBy = receivedBy
        g_guildBankCarry.itemLink = itemLink
        g_guildBankCarry.itemId = itemId
        g_guildBankCarry.itemType = itemType
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function CA.InventoryUpdateFence(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end
    
    local receivedBy = ""
    if bagId == BAG_BACKPACK then
    
        local gainOrLoss
        local logPrefix
        local icon
        local stack
        local itemType
        local itemId
        local itemLink
        local removed
        -- NEW ITEM
        if not g_inventoryStacks[slotId] then
            icon, stack = GetItemInfo(bagId, slotId)
            itemType = GetItemType(bagId, slotId)
            itemId = GetItemId(bagId, slotId)
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
        -- EXISTING ITEM    
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, linkBrackets[CA.SV.BracketOptionItem])
            if itemLink == nil or itemLink == "" then
                -- If we get a nil or blank item link, the item was destroyed and we need to use the saved value here to fill in the blanks
                icon = g_inventoryStacks[slotId].icon
                stack = g_inventoryStacks[slotId].stack
                itemType = g_inventoryStacks[slotId].itemType
                itemId = g_inventoryStacks[slotId].itemId
                itemLink = g_inventoryStacks[slotId].itemLink
                removed = true
            else
                -- If we get a value for itemLink, then we want to use bag info to fill in the blanks
                icon, stack = GetItemInfo(bagId, slotId)
                itemType = GetItemType(bagId, slotId)
                itemId = GetItemId(bagId, slotId)
                removed = false
            end
            
            if stackCountChange == 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = CA.SV.LootMessageLaunder
                if not g_weAreInAStore and CA.SV.Loot then
                    local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
                    local type = "LUIE_CURRENCY_VENDOR"
                    local messageChange = CA.SV.LootMessageLaunder
                    
                    local formattedIcon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
                    local itemCount = stack > 1 and (" |cFFFFFFx" .. stack .. "|r") or "" 
                    local carriedItem = ( formattedIcon .. itemLink ..  itemCount )
                    local carriedItemTotal = ""
                    if CA.SV.LootTotal and CA.SV.LootVendorTotalItems then
                        local total1, total2, total3 = GetItemLinkStacks(itemLink)
                        local total = total1 + total2 + total3
                        if total > 1 then
                            carriedItemTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                        end
                    end
                    
                    g_savedPurchase.changeColor = changeColor
                    g_savedPurchase.messageChange = messageChange
                    g_savedPurchase.type = type
                    g_savedPurchase.carriedItem = carriedItem
                    g_savedPurchase.carriedItemTotal = carriedItemTotal
                end
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                logPrefix = CA.SV.LootMessageLaunder
                if not g_weAreInAStore and CA.SV.Loot then
                    --CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.LootShowDestroy then
                    gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    logPrefix = CA.SV.LootMessageDestroy
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                else
                    gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
                    logPrefix = CA.SV.LootMessageLaunder
                    local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
                    local type = "LUIE_CURRENCY_VENDOR"
                    local messageChange = CA.SV.LootMessageLaunder
                    
                    local formattedIcon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
                    local itemCount = stack > 1 and (" |cFFFFFFx" .. stack .. "|r") or "" 
                    local carriedItem = ( formattedIcon .. itemLink ..  itemCount )
                    local carriedItemTotal = ""
                    if CA.SV.LootTotal and CA.SV.LootVendorTotalItems then
                        local total1, total2, total3 = GetItemLinkStacks(itemLink)
                        local total = total1 + total2 + total3
                        if total > 1 then
                            carriedItemTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                        end
                    end
                    
                    g_savedPurchase.changeColor = changeColor
                    g_savedPurchase.messageChange = messageChange
                    g_savedPurchase.type = type
                    g_savedPurchase.carriedItem = carriedItem
                    g_savedPurchase.carriedItemTotal = carriedItemTotal
                end
            end
            
            if removed then
                if g_inventoryStacks[slotId] then 
                    g_inventoryStacks[slotId] = nil
                end
            else
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end
    end
    
    if bagId == BAG_VIRTUAL then
        local gainOrLoss = CA.SV.CurrencyContextColor and 1 or 3
        local logPrefix = CA.SV.LootMessageLaunder
        local itemLink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink) 
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)
        
        if not g_weAreInAStore and CA.SV.Loot then
            local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
            local type = "LUIE_CURRENCY_VENDOR"
            local messageChange = CA.SV.LootMessageLaunder
            
            local formattedIcon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""
            local itemCount = stackCountChange > 1 and (" |cFFFFFFx" .. stackCountChange .. "|r") or "" 
            local carriedItem = ( formattedIcon .. itemLink ..  itemCount )
            local carriedItemTotal = ""
            if CA.SV.LootTotal and CA.SV.LootVendorTotalItems then
                local total1, total2, total3 = GetItemLinkStacks(itemLink)
                local total = total1 + total2 + total3
                if total > 1 then
                    carriedItemTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", changeColor, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
                end
            end
            
            g_savedPurchase.changeColor = changeColor
            g_savedPurchase.messageChange = messageChange
            g_savedPurchase.type = type
            g_savedPurchase.carriedItem = carriedItem
            g_savedPurchase.carriedItemTotal = carriedItemTotal
        end
    end
    
    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

-- Makes it so bank withdraw/deposit events only occur when we can confirm the item is crossing over.
function CA.BankFixer()
    InventoryOn = false
    BankOn = false
end

function CA.JusticeStealRemove(eventCode)

    zo_callLater(CA.JusticeRemovePrint, 50)
    
end

function CA.JusticeDisplayConfiscate()
    if CA.SV.NotificationConfiscateCA or CA.SV.NotificationConfiscateAlert then
        local ConfiscateMessage
        if g_itemsConfiscated then
            ConfiscateMessage = GetString(SI_LUIE_CA_JUSTICE_CONFISCATED_BOUNTY_ITEMS_MSG)
        else
            ConfiscateMessage = GetString(SI_LUIE_CA_JUSTICE_CONFISCATED_MSG)
        end
        
        if CA.SV.NotificationConfiscateCA then
            printToChat(ConfiscateMessage)
        else
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, ConfiscateMessage)
        end
    end
    g_itemsConfiscated = false
end

function CA.JusticeRemovePrint()

    g_itemsConfiscated = true
    
    -- PART 1 -- INVENTORY
    if CA.SV.LootConfiscate then
        local bagsize = GetBagSize(1)

        for i = 0,bagsize do
            local icon, stack = GetItemInfo(1, i)
            local itemType = GetItemType(1, i)
            local itemId = GetItemId(1, i)
            local itemLink = GetItemLink(1, i, linkBrackets[CA.SV.BracketOptionItem])
            
            if itemLink ~= "" then
                g_JusticeStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end

        for i = 0,bagsize do
            local inventoryitem = g_inventoryStacks[i]
            local justiceitem = g_JusticeStacks[i]
            if inventoryitem ~= nil then
                if justiceitem == nil then
                    local receivedBy = ""
                    local gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    local logPrefix = CA.SV.CurrencyMessageConfiscate
                    if CA.SV.LootConfiscate then
                        CA.ItemPrinter(inventoryitem.icon, inventoryitem.stack, inventoryitem.itemType, inventoryitem.itemId, inventoryitem.itemLink, receivedBy, logPrefix, gainOrLoss, false)
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

        for i = 0,bagsize do
            local icon, stack = GetItemInfo(0, i)
            local itemType = GetItemType(0, i)
            local itemId = GetItemId(0, i)
            local itemLink = GetItemLink(0, i, linkBrackets[CA.SV.BracketOptionItem])
            
            if itemLink ~= "" then
                g_JusticeStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            end
        end

        for i = 0,bagsize do
            local inventoryitem = g_equippedStacks[i]
            local justiceitem = g_JusticeStacks[i]
            if inventoryitem ~= nil then
                if justiceitem == nil then
                    local receivedBy = ""
                    local gainOrLoss = CA.SV.CurrencyContextColor and 2 or 4
                    local logPrefix = CA.SV.CurrencyMessageConfiscate
                    if CA.SV.LootConfiscate then
                        CA.ItemPrinter(inventoryitem.icon, inventoryitem.stack, inventoryitem.itemType, inventoryitem.itemId, inventoryitem.itemLink, receivedBy, logPrefix, gainOrLoss, false)
                    end
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

function CA.DisguiseState(eventCode, unitTag, disguiseState)
    if disguiseState == DISGUISE_STATE_DANGER then
        if CA.SV.DisguiseWarnCA then
            printToChat(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER))
        end
        if CA.SV.DisguiseWarnCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.GROUP_ELECTION_REQUESTED)
            messageParams:SetText(DisguiseAlertColorize:Colorize(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER)))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        if CA.SV.DisguiseWarnAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER))
        end
        
        if (CA.SV.DisguiseWarnCA or CA.SV.DisguiseWarnAlert) and not CA.SV.DisguiseWarnCSA then
            PlaySound(SOUNDS.GROUP_ELECTION_REQUESTED)
        end
    end

    if disguiseState == DISGUISE_STATE_SUSPICIOUS then
        if CA.SV.DisguiseWarnCA then
            printToChat(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS))
        end
        if CA.SV.DisguiseWarnCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.GROUP_ELECTION_REQUESTED)
            messageParams:SetText(DisguiseAlertColorize:Colorize(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS)))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        if CA.SV.DisguiseWarnAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS))
        end
        if (CA.SV.DisguiseWarnCA or CA.SV.DisguiseWarnAlert) and not CA.SV.DisguiseWarnCSA then
            PlaySound(SOUNDS.GROUP_ELECTION_REQUESTED)
        end
    end

    -- If we're still disguised and g_disguiseState is true then don't waste resources and end the function
    if g_disguiseState == 1 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
        return
    end

    if g_disguiseState == 1 and (disguiseState == DISGUISE_STATE_NONE) then
        local message = strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), E.DisguiseIcons[g_currentDisguise].description)
        if CA.SV.DisguiseCA then
            printToChat(message)
        end
        if CA.SV.DisguiseAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
        if CA.SV.DisguiseCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetText(message)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    end

    if g_disguiseState == 0 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
        g_currentDisguise = GetItemId(0, 10) or 0
        local message = strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description)
        if CA.SV.DisguiseCA then
            printToChat(message)
        end
        if CA.SV.DisguiseAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
        if CA.SV.DisguiseCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetText(message)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    end

    g_disguiseState = GetUnitDisguiseState("player")

    if g_disguiseState > 0 then
        g_disguiseState = 1
    end
end

function CA.OnPlayerActivated(eventCode, initial)
    
    if g_disguiseState == 0 then
        g_disguiseState = GetUnitDisguiseState("player")
        if g_disguiseState == 0 then
            return
        elseif g_disguiseState ~= 0 then
            g_disguiseState = 1
            g_currentDisguise = GetItemId(0, 10) or 0
            local message = strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description)
            if CA.SV.DisguiseCA then
                printToChat(message)
            end
            if CA.SV.DisguiseAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
            if CA.SV.DisguiseCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
                messageParams:SetText(message)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            return
        end
    elseif g_disguiseState == 1 then
        g_disguiseState = GetUnitDisguiseState("player")
        if g_disguiseState == 0 then
            local message = strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), E.DisguiseIcons[g_currentDisguise].description)
            if CA.SV.DisguiseCA then
                printToChat(message)
            end
            if CA.SV.DisguiseAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
            end
            if CA.SV.DisguiseCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
                messageParams:SetText(message)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            return
        elseif g_disguiseState ~= 0 then
            g_disguiseState = 1
            g_currentDisguise = GetItemId(0, 10) or 0
            return
        end
    end
end

--[[ STUCK REFERENCE
function CA.StuckOnCooldown(eventCode)
    local cooldownText = ZO_FormatTime(GetStuckCooldown(), TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TWELVE_HOUR)
    local cooldownRemainingText = ZO_FormatTimeMilliseconds(GetTimeUntilStuckAvailable(), TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TWELVE_HOUR)
    printToChat(strformat(GetString(SI_STUCK_ERROR_ON_COOLDOWN), cooldownText, cooldownRemainingText ))
end
]]

-- TODO: Replace/Remove

--[[
function CA.InventoryFullQuest(eventCode)
    printToChat(GetString(SI_INVENTORY_ERROR_INVENTORY_FULL))
end

function CA.InventoryFull(eventCode, numSlotsRequested, numSlotsFree)
    local function DisplayItemFailed()
        if numSlotsRequested == 1 then
            printToChat(GetString(SI_INVENTORY_ERROR_INVENTORY_FULL))
        else
            printToChat(strformat(GetString(SI_INVENTORY_ERROR_INSUFFICIENT_SPACE), (numSlotsRequested - numSlotsFree) ))
        end
    end

    zo_callLater(DisplayItemFailed, 100)
end

function CA.LootItemFailed(eventCode, reason, itemName)
    -- Stop Spam
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED)

    local function ReactivateLootItemFailed()
    printToChat(strformat(GetString("SI_LOOTITEMRESULT", reason), itemName))
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED, CA.LootItemFailed)
    end

    zo_callLater(ReactivateLootItemFailed, 100)
end
]]

-------------------------------------------------------------------------
-- UPDATED CODE
-------------------------------------------------------------------------

-- LINK_HANDLER.LINK_MOUSE_UP_EVENT
-- LINK_HANDLER.LINK_CLICKED_EVENT
-- Custom Link Handlers to deal with when a book link in chat is clicked, this will open the book rather than the default link that only shows whether a lore entry has been read or not.
function LUIE.HandleClickEvent(rawLink, mouseButton, linkText, linkStyle, linkType, categoryIndex, collectionIndex, bookIndex)
  if linkType == "LINK_TYPE_LUIBOOK" then
    -- Read the book
    ZO_LoreLibrary_ReadBook(categoryIndex, collectionIndex, bookIndex)
    return true
  end
end

-- Function needed to display XP bar updates
local function GetRelevantBarParams(level, previousExperience, currentExperience, championPoints)
    local championXpToNextPoint
    if CanUnitGainChampionPoints("player") then
        championXpToNextPoint = GetNumChampionXPInChampionPoint(championPoints)
    end  
    if(championXpToNextPoint ~= nil and currentExperience > previousExperience) then
        return CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, championPoints, previousExperience, currentExperience)
    else
        local levelSize
        if(level) then
            levelSize = GetNumExperiencePointsInLevel(level)
        end
        if(levelSize ~= nil and currentExperience >  previousExperience) then
            return CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_XP, level, previousExperience, currentExperience)
        end
    end
end

local function GetCurrentChampionPointsBarParams()
    local championPoints = GetPlayerChampionPointsEarned()
    local currentChampionXP = GetPlayerChampionXP()
    local barParams = CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, championPoints, currentChampionXP, currentChampionXP)
    barParams:SetShowNoGain(true)
    return barParams
end

-- local vars for EVENT_SKILL_XP

local GUILD_SKILL_SHOW_REASONS =
{
    [PROGRESS_REASON_DARK_ANCHOR_CLOSED] = true,
    [PROGRESS_REASON_DARK_FISSURE_CLOSED] = true,
    [PROGRESS_REASON_BOSS_KILL] = true,
}

local GUILD_SKILL_SHOW_SOUNDS =
{
    [PROGRESS_REASON_DARK_ANCHOR_CLOSED] = SOUNDS.SKILL_XP_DARK_ANCHOR_CLOSED,
    [PROGRESS_REASON_DARK_FISSURE_CLOSED] = SOUNDS.SKILL_XP_DARK_FISSURE_CLOSED,
    [PROGRESS_REASON_BOSS_KILL] = SOUNDS.SKILL_XP_BOSS_KILLED,
}

local GUILD_SKILL_ICONS =
{

    [1] = "esoui/art/icons/mapkey/mapkey_fightersguild.dds",
    [2] = "esoui/art/icons/mapkey/mapkey_magesguild.dds",
    [3] = "esoui/art/icons/mapkey/mapkey_undaunted.dds",
    [4] = "esoui/art/icons/mapkey/mapkey_thievesguild.dds",
    [5] = "esoui/art/icons/mapkey/mapkey_darkbrotherhood.dds",
}


-- Alert Prehooks
function CA.HookFunction()
    
    local alertHandlers = ZO_AlertText_GetHandlers()

    -- Style book learned
    --[[
    local function StyleLearnedHook(styleIndex, chapterIndex, isDefaultRacialStyle)
        if not isDefaultRacialStyle then
            local itemStyle = select(5, GetSmithingStyleItemInfo(styleIndex))
            if chapterIndex == ITEM_STYLE_CHAPTER_ALL then
                printToChat(strformat(SI_NEW_STYLE_LEARNED, GetString("SI_ITEMSTYLE", itemStyle)))
                return ALERT, strformat(SI_NEW_STYLE_LEARNED, GetString("SI_ITEMSTYLE", itemStyle))
            else
                printToChat(strformat(SI_NEW_STYLE_CHAPTER_LEARNED, GetString("SI_ITEMSTYLE", itemStyle), GetString("SI_ITEMSTYLECHAPTER", chapterIndex)))
                return ALERT, strformat(SI_NEW_STYLE_CHAPTER_LEARNED, GetString("SI_ITEMSTYLE", itemStyle), GetString("SI_ITEMSTYLECHAPTER", chapterIndex))
                
            end
        end
    end
    ZO_PreHook(alertHandlers, EVENT_STYLE_LEARNED, StyleLearnedHook)
    ]]--
    
    -- TODO: We'll probably hide this event because it's kind of pointless - This will only trigger VERY occasionally when a lorebook is used and doesn't immediately fade away before the player can interact with it again (I guess just when Server lags).
    local function AlreadyKnowBookHook(bookTitle)
        --printToChat(strformat(SI_LORE_LIBRARY_ALREADY_KNOW_BOOK, bookTitle))
        --return ERROR, strformat(SI_LORE_LIBRARY_ALREADY_KNOW_BOOK, bookTitle)
        return true
    end
    
    local function RidingSkillImprovementAlertHook(ridingSkill, previous, current, source)
        
        if source == RIDING_TRAIN_SOURCE_STABLES then
            -- If we purchased from the stables, display a currency announcement if relevant
            if CA.SV.StorageRidingCA then
                -- TODO: Currency conditional here!!!!
            
                local type
                if ridingSkill == 1 then
                    type = "LUIE_CURRENCY_RIDING_SPEED"
                elseif ridingSkill == 2 then
                    type = "LUIE_CURRENCY_RIDING_CAPACITY"
                elseif ridingSkill == 3 then
                    type = "LUIE_CURRENCY_RIDING_STAMINA"
                end
                local formattedValue = ZO_LocalizeDecimalNumber(GetCarriedCurrencyAmount(1) + 250)
                local changeColor = CA.SV.CurrencyContextColor and CurrencyDownColorize:ToHex() or CurrencyColorize:ToHex()
                local changeType = ZO_LocalizeDecimalNumber(250)
                local currencyTypeColor = CurrencyGoldColorize:ToHex()
                local currencyIcon = CA.SV.CurrencyIcon and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
                local currencyName = strformat(CA.SV.CurrencyGoldName, 250)
                local currencyTotal = CA.SV.CurrencyGoldShowTotal
                local messageTotal = CA.SV.CurrencyMessageTotalGold
                local messageChange = CA.SV.CurrencyMessageStable
                CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)
                
                local formattedString = StorageRidingColorize:Colorize(zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "STORAGE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            
            if CA.SV.StorageRidingCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_RIDING_SKILL_ANNOUCEMENT_BANNER), zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RIDING_SKILL_IMPROVEMENT)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end

        -- Display Alert (Detailed alert if purchased at the stables, simple alert if using skill upgrade books to avoid spam)
        if CA.SV.StorageRidingAlert then
            local text
            if source == RIDING_TRAIN_SOURCE_ITEM then
                text = zo_strformat(SI_RIDING_SKILL_IMPROVEMENT_ALERT, GetString("SI_RIDINGTRAINTYPE", ridingSkill))
            else
                text = zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current)
            end
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
        
        return true
    
    end
    
    local function LoreBookLearnedAlertHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, isMaxRank)
        if guildReputationIndex == 0 or isMaxRank then
            -- We only want to fire this event if a player is not part of the guild or if they've reached max level in the guild.
            -- Otherwise, the _SKILL_EXPERIENCE version of this event will send a center screen message instead.
            
            local collectionName, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            
            if not hidden or CA.SV.LorebookShowHidden then
                
                local title, icon = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
                local bookName
                local bookLink
                if CA.SV.BracketOptionLorebook == 1 then
                    bookName = strfmt("%s", title)
                    bookLink = strfmt("|H0:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
                else
                    bookName = strfmt("[%s]", title)
                    bookLink = strfmt("|H1:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
                end
                
                local stringPrefix
                local csaPrefix
                if categoryIndex == 1 then 
                    -- Is a lore book
                    stringPrefix = CA.SV.LorebookPrefix1
                    csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_ANNOUNCE_BOOK_LEARNED)
                else
                    -- Is a normal book
                    stringPrefix = CA.SV.LorebookPrefix2
                    csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LUIE_CA_LOREBOOK_BOOK)
                end
                
                -- Chat Announcement
                if CA.SV.LorebookCA then
                    local formattedIcon = CA.SV.LorebookIcon and ("|t16:16:" .. icon .. "|t ") or ""
                    local stringPart1
                    local stringPart2
                    if stringPrefix ~= "" then 
                        stringPart1 = LorebookColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.LorebookBracket], stringPrefix, bracket2[CA.SV.LorebookBracket]))
                    else
                        stringPart1 = ""
                    end
                    if CA.SV.LorebookCategory then
                        stringPart2 = collectionName ~= "" and LorebookColorize2:Colorize(strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName)) or LorebookColorize2:Colorize(strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                    else
                        stringPart2 = ""
                    end
                
                    local finalMessage = strformat("<<1>><<2>><<3>><<4>>", stringPart1, formattedIcon, bookLink, stringPart2)
                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "LOREBOOK" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                end
                
                -- Alert Announcement
                if CA.SV.LorebookAlert then
                    local text = collectionName ~= "" and strformat("<<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName) or strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY))
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat("<<1>> <<2>>", title, text))
                end
                
                -- Center Screen Announcement 
                if CA.SV.LorebookCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_ACQUIRED)
                    if collectionName ~= "" then
                        messageParams:SetText(csaPrefix, strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, collectionName))
                    else
                        messageParams:SetText(csaPrefix, strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                    end
                    messageParams:SetIconData(icon, "EsoUI/Art/Achievements/achievements_iconBG.dds")
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_BOOK_LEARNED)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                if not CA.SV.LorebookCSA then
                    PlaySound(SOUNDS.BOOK_ACQUIRED)
                end
            end
        end
        return true
    end
    
        -----------------------------
    -- DUEL ALERTS --------------
    -----------------------------
        
    -- EVENT_DUEL_INVITE_RECEIVED - ALERT HANDLER
    local function DuelInviteReceivedAlert(inviterCharacterName, inviterDisplayName)
        
        -- Display CA
        if CA.SV.DuelCA then
            local finalName = CA.ResolveNameLink(inviterCharacterName, inviterDisplayName)
            printToChat(strformat(GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), finalName))
        end
        
        -- Display Alert
        if CA.SV.DuelAlert then
            local finalAlertName = CA.ResolveNameNoLink(inviterCharacterName, inviterDisplayName)
            local formattedString = strformat(GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), finalAlertName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
        end
        
        return true
        
    end

    -- EVENT_DUEL_INVITE_ACCEPTED - ALERT HANDLER
    local function DuelInviteAcceptedAlert()
    
        -- Display CA
        if CA.SV.DuelCA then
            printToChat(GetString(SI_LUIE_CA_DUEL_INVITE_ACCEPTED))
        end
        
        -- Display Alert
        if CA.SV.DuelAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, SOUNDS.DUEL_ACCEPTED, GetString(SI_LUIE_CA_DUEL_INVITE_ACCEPTED) )
        end
        
        -- Play sound if we don't have the Alert turned on
        if not CA.SV.DuelAlert then
            PlaySound(SOUNDS.DUEL_ACCEPTED)
        end
        return true
    end

    -- EVENT_DUEL_INVITE_SENT - ALERT HANDLER
    local function DuelInviteSentAlert(inviteeCharacterName, inviteeDisplayName)
    
        -- Display CA
        if CA.SV.DuelCA then
            local finalName = CA.ResolveNameLink(inviteeCharacterName, inviteeDisplayName)
            printToChat(strformat(GetString(SI_LUIE_CA_DUEL_INVITE_SENT), finalName))
        end
        
        -- Display Alert
        if CA.SV.DuelAlert then
            local finalAlertName = CA.ResolveNameNoLink(inviteeCharacterName, inviteeDisplayName)
            local formattedString = strformat(GetString(SI_LUIE_CA_DUEL_INVITE_SENT), finalAlertName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
        end
        return true
    end

    -- Register Strings here for Alert and CSA Handlers
    
    -- Player to Player replacement strings for Duels
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_DUEL, GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), 5)
    SafeAddString(SI_DUEL_INVITE_MESSAGE, GetString(SI_LUIE_CA_DUEL_INVITE_RECEIVED), 5)
    SafeAddString(SI_PLAYER_TO_PLAYER_INVITE_DUEL, GetString(SI_LUIE_CA_DUEL_INVITE_PLAYER), 5)
    -- TODO - These are likely a standard error response string for Duels
    SafeAddString(SI_DUELSTATE1, GetString(SI_LUIE_CA_DUEL_STATE1), 5)
    SafeAddString(SI_DUELSTATE1, GetString(SI_LUIE_CA_DUEL_STATE2), 5)
    -- Group Player to Player notification replacement
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GROUP, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), 5)
    -- Guild Invite Player to Player notification replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GUILD_REQUEST, GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST), 1)
    SafeAddString(SI_GUILD_INVITE_MESSAGE, GetString(SI_LUIE_CA_GUILD_INVITE_MESSAGE), 3)
    -- Friend Invite String Replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_FRIEND_REQUEST, GetString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST), 5)
    -- Quest Share String Replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_QUEST_SHARE, GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_P2P), 5)
    SafeAddString(SI_QUEST_SHARE_MESSAGE, GetString(SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_P2P), 5)
    -- Trade String Replacements
    SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_TRADE, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
    SafeAddString(SI_TRADE_INVITE_MESSAGE, GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), 1)
    -- Mail String Replacements
    SafeAddString(SI_SENDMAILRESULT2, GetString(SI_LUIE_CA_MAIL_SENDMAILRESULT2), 5)
    SafeAddString(SI_SENDMAILRESULT3, GetString(SI_LUIE_CA_MAIL_SENDMAILRESULT3), 5)
    
    -- EVENT_DUEL_INVITE_FAILED -- ALERT HANDLER
    local function DuelInviteFailedAlert(reason, targetCharacterName, targetDisplayName)
    
        local userFacingName = ZO_GetPrimaryPlayerNameWithSecondary(targetDisplayName, targetCharacterName)
        -- Display CA
        if CA.SV.DuelCA then
            local reasonName
            local finalName = CA.ResolveNameLink(targetDisplayName, targetCharacterName)
            if userFacingName then
                printToChat(strformat(GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason), finalName))
            else
                printToChat(strformat(GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason)))
            end
        end
        
        -- Display Alert
        if CA.SV.DuelAlert then
            local finalAlertName = CA.ResolveNameNoLink(targetDisplayName, targetCharacterName)
            local formattedString = strformat(GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason), finalAlertName)
            if userFacingName then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, formattedString)
            else
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString("SI_LUIE_CA_DUEL_INVITE_FAILREASON", reason)))
            end
        end
        
        -- Play sound if we don't have the Alert turned on
        if not CA.SV.DuelAlert then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- EVENT_DUEL_INVITE_DECLINED -- ALERT HANDLER
    local function DuelInviteDeclinedAlert()
        -- Display CA
        if CA.SV.DuelCA then
            printToChat(GetString(SI_LUIE_CA_DUEL_INVITE_DECLINED))
        end
        
        -- Display Alert
        if CA.SV.DuelAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, GetString(SI_LUIE_CA_DUEL_INVITE_DECLINED))
        end
        
        -- Play sound if we don't have the Alert turned on
        if not CA.SV.DuelAlert then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- EVENT_DUEL_INVITE_CANCELED -- ALERT HANDLER
    local function DuelInviteCanceledAlert()
        -- Display CA
        if CA.SV.DuelCA then
            printToChat(GetString(SI_LUIE_CA_DUEL_INVITE_CANCELED))
        end
        
        -- Display Alert
        if CA.SV.DuelAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, GetString(SI_LUIE_CA_DUEL_INVITE_CANCELED))
        end
        
        -- Play sound if we don't have the Alert turned on
        if not CA.SV.DuelAlert then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end
    
    -- EVENT_PLEDGE_OF_MARA_RESULT -- ALERT HANDLER
    local function PledgeOfMaraResultAlert(result, characterName, displayName)
        -- Replace everything here and move it all into the CSA handler event
        return true
    end
    
    -- EVENT_GROUP_INVITE_RESPONSE -- ALERT HANDLER
    local function GroupInviteResponseAlert(characterName, response, displayName)
        
        local finalName
        local finalAlertName
        
        local nameCheck1 = ZO_GetPrimaryPlayerName(displayName, characterName)
        local nameCheck2 = ZO_GetSecondaryPlayerName(displayName, characterName)
        
        if nameCheck1 == "" then
            finalName = displayName
            finalAlertName = displayName
        elseif nameCheck2 == "" then
            finalName = characterName
            finalAlertName = characterName
        elseif nameCheck1 ~= "" and nameCheck2 ~= "" then
            finalName = CA.ResolveNameLink(characterName, displayName)
            finalAlertName = CA.ResolveNameNoLink(characterName, displayName)
        else
            finalName = ""
            finalAlertName = ""
        end
        
        if(response ~= GROUP_INVITE_RESPONSE_ACCEPTED and response ~= GROUP_INVITE_RESPONSE_CONSIDERING_OTHER) then
            
            local message
            local alertMessage
            
            if response == GROUP_INVITE_RESPONSE_ALREADY_GROUPED and (g_playerNameFormatted == characterName or g_playerDisplayName == displayName) then
                message = zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_SELF_INVITE))
                alertMessage = zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_SELF_INVITE))
            elseif response == GROUP_INVITE_RESPONSE_ALREADY_GROUPED and (IsPlayerInGroup(characterName) or IsPlayerInGroup(displayName)) then
                message = GetString(SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER)
                alertMessage = GetString(SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER)
            elseif response == GROUP_INVITE_RESPONSE_IGNORED then
                message = finalName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalName) or GetString(SI_PLAYER_BUSY)
                alertMessage = finalAlertName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalAlertName) or GetString(SI_PLAYER_BUSY)
            else
                message = finalName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalName) or GetString(SI_PLAYER_BUSY)
                alertMessage = finalAlertName ~= "" and zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", response), finalAlertName) or GetString(SI_PLAYER_BUSY)
            end

            if CA.SV.GroupCA or response == GROUP_INVITE_RESPONSE_ALREADY_GROUPED or response == GROUP_INVITE_RESPONSE_IGNORED or response == GROUP_INVITE_RESPONSE_PLAYER_NOT_FOUND then
                printToChat(message)
            end
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            
        end
        return true
        
    end

    -- EVENT_GROUP_INVITE_ACCEPT_RESPONSE_TIMEOUT -- ALERT HANDLER
    local function GroupInviteTimeoutAlert()
        printToChat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_GENERIC_JOIN_FAILURE))
        if CA.SV.GroupAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_GENERIC_JOIN_FAILURE))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return true
    end

    -- EVENT_GROUP_NOTIFICATION_MESSAGE -- ALERT HANDLER
    local function GroupNotificationMessageAlert(groupMessageCode)
        if groupMessageCode == GROUP_MSG_YOU_ARE_NOT_IN_A_GROUP then
            printToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        elseif groupMessageCode == GROUP_MSG_YOU_ARE_NOT_THE_LEADER then
            printToChat(GetString(SI_GROUP_NOTIFICATION_GROUP_MSG_INVALID_MEMBER))
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        elseif groupMessageCode == GROUP_MSG_INVALID_MEMBER then
            printToChat(GetString(SI_GROUP_NOTIFICATION_GROUP_MSG_INVALID_MEMBER))
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString(SI_GROUP_NOTIFICATION_GROUP_MSG_INVALID_MEMBER))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end

    -- EVENT_GROUP_UPDATE -- ALERT HANDLER
    local function GroupUpdateAlert()
        currentGroupLeaderRawName = ""
        currentGroupLeaderDisplayName = ""
        
        if g_groupJoinFudger then
            zo_callLater(CA.CheckLFGStatusJoin, 100)
        end
        g_groupJoinFudger = false
    end

    -- EVENT_GROUP_MEMBER_LEFT -- ALERT HANDLER
    local function GroupMemberLeftAlert(characterName, reason, isLocalPlayer, isLeader, displayName, actionRequiredVote)
        local message = nil
        local alert = nil
        local message2 = nil
        local alert2 = nil
        local sound = nil
        
        local finalName = CA.ResolveNameLink(characterName, displayName)
        local finalAlertName = CA.ResolveNameNoLink(characterName, displayName)
        
        -- Used to check for valid links
        local characterNameLink = ZO_LinkHandler_CreateCharacterLink(characterName)
        local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)

        
        local hasValidNames = characterNameLink ~= "" and displayNameLink ~= ""
        local useDefaultReasonText = false
        if reason == GROUP_LEAVE_REASON_DISBAND then
            if isLeader and not isLocalPlayer then
                useDefaultReasonText = true
            elseif isLeader and isLocalPlayer then
                message = zo_strformat(SI_LUIE_GROUPDISBANDLEADER)
                alert = zo_strformat(SI_LUIE_GROUPDISBANDLEADER)
                g_LFGJoinAntiSpam = false
                zo_callLater(function() CA.CheckLFGStatusLeave(false) end , 100)
            elseif isLocalPlayer then
            --
            g_LFGJoinAntiSpam = false
            zo_callLater(function() CA.CheckLFGStatusLeave(false) end , 100)
            --
            end

            sound = SOUNDS.GROUP_DISBAND
        elseif reason == GROUP_LEAVE_REASON_KICKED then
            if actionRequiredVote then
                if isLocalPlayer then
                    --
                    g_LFGJoinAntiSpam = false
                    zo_callLater(function() CA.CheckLFGStatusLeave(true) end , 100)
                    --
                    message = zo_strformat(SI_GROUP_ELECTION_KICK_PLAYER_PASSED)
                    alert = zo_strformat(SI_GROUP_ELECTION_KICK_PLAYER_PASSED)
                elseif hasValidNames then
                    --
                    zo_callLater(function() CA.CheckLFGStatusLeave(false) end , 100)
                    --
                    message = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED, finalName)
                    alert = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED, finalAlertName)
                    message2 = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED), finalName))
                    alert2 =  (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED), finalAlertName))
                end
            else
                if isLocalPlayer then
                    --
                    g_LFGJoinAntiSpam = false
                    zo_callLater(function() CA.CheckLFGStatusLeave(true) end , 100)
                    --
                    message = zo_strformat(SI_GROUP_NOTIFICATION_GROUP_SELF_KICKED)
                    alert = zo_strformat(SI_GROUP_NOTIFICATION_GROUP_SELF_KICKED)
                else
                    --
                    zo_callLater(function() CA.CheckLFGStatusLeave(false) end , 100)
                    --
                    useDefaultReasonText = true
                end
            end

            sound = SOUNDS.GROUP_KICK
        elseif reason == GROUP_LEAVE_REASON_VOLUNTARY or reason == GROUP_LEAVE_REASON_LEFT_BATTLEGROUND then
            if not isLocalPlayer then
                useDefaultReasonText = true
                --
                zo_callLater(function() CA.CheckLFGStatusLeave(false) end , 100)
                --
            else
                --
                g_LFGJoinAntiSpam = false
                message = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_SELF), finalName))
                alert = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_SELF), finalAlertName))
                zo_callLater(function() CA.CheckLFGStatusLeave(false) end , 100)
                --
            end

            sound = SOUNDS.GROUP_LEAVE
        elseif reason == GROUP_LEAVE_REASON_DESTROYED then
            --do nothing, we don't want to show additional alerts for this case
        end

        if useDefaultReasonText and hasValidNames then
            message = zo_strformat(GetString("SI_LUIE_GROUPLEAVEREASON", reason), finalName)
            alert = zo_strformat(GetString("SI_LUIE_GROUPLEAVEREASON", reason), finalAlertName)
        end

        if isLocalPlayer then
            currentGroupLeaderRawName = ""
            currentGroupLeaderDisplayName = ""
        end

        if message ~= nil then
            if CA.SV.GroupCA then
                printToChat(message)
            end
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alert)
            end
            if sound ~= nil then PlaySound(sound) end
        end
        
        if message2 ~= nil then
            if CA.SV.GroupCA then
                printToChat(message2)
            end
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alert2)
            end
        end

        return true
    end

    -- EVENT_LEADER_UPDATE -- ALERT HANDLER
    -- This event only fires if the characterId of the leader has changed (it's a new leader)
    local function LeaderUpdateAlert(leaderTag)
        local leaderRawName = GetRawUnitName(leaderTag)
        local showAlert = leaderRawName ~= "" and currentGroupLeaderRawName ~= ""
        currentGroupLeaderRawName = leaderRawName
        currentGroupLeaderDisplayName = GetUnitDisplayName(leaderTag)
        
        local displayString
        local alertString
        local finalName = CA.ResolveNameLink(currentGroupLeaderRawName, currentGroupLeaderDisplayName)
        local finalAlertName = CA.ResolveNameNoLink(currentGroupLeaderRawName, currentGroupLeaderDisplayName)

        if g_playerName ~= currentGroupLeaderRawName then -- If another player became the leader
            displayString = (strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), finalName))
            alertString = (strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), finalAlertName))
        elseif g_playerName == currentGroupLeaderRawName then -- If the player character became the leader
            displayString = (GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_SELF))
            alertString = (GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_SELF))
        end

        if showAlert then
            if CA.SV.GroupCA then
                printToChat(displayString)
            end
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
            end
            PlaySound(SOUNDS.GROUP_PROMOTE)
        end
        return true
    end

    -- EVENT_GROUPING_TOOLS_LFG_JOINED -- ALERT HANDLER
    local function GroupingToolsLFGJoinedAlert(locationName)

        if not g_LFGJoinAntiSpam then
            if CA.SV.GroupLFGCA then
                printToChat(zo_strformat(SI_LUIE_CA_GROUPFINDER_ALERT_LFG_JOINED, locationName))
            end
            if CA.SV.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUPFINDER_ALERT_LFG_JOINED, locationName))
            end
            zo_callLater (function() g_rcUpdateDeclineOverride = false end, 5000)
            g_lfgDisableGroupEvents = true
            zo_callLater (function() g_lfgDisableGroupEvents = false end, 2500)
        end
        g_joinLFGOverride = true
        g_LFGJoinAntiSpam = true
        g_rcUpdateDeclineOverride = true
        
        return true
    end

    -- EVENT_ACTIVITY_QUEUE_RESULT -- ALERT HANDLER
    local function ActivityQueueResultAlert(result)
        if result ~= ACTIVITY_QUEUE_RESULT_SUCCESS then
            if CA.SV.GroupLFGCA then
                printToChat(GetString("SI_ACTIVITYQUEUERESULT", result))
            end
            if CA.SV.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_ACTIVITYQUEUERESULT", result))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        g_showRCUpdates = true
        
        return true
    end
    
    -- EVENT_GROUP_ELECTION_FAILED -- ALERT HANDLER
    local function GroupElectionFailedAlert(failureType, descriptor)
        if failureType ~= GROUP_ELECTION_FAILURE_NONE then
            if CA.SV.GroupVoteCA then
                printToChat(GetString("SI_GROUPELECTIONFAILURE", failureType))
            end
            if CA.SV.GroupVoteAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_GROUPELECTIONFAILURE", failureType))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end
    
    -- Variables for EVENT_GROUP_ELECTION_RESULT
    local GroupElectionResultToSoundId =
{
    [GROUP_ELECTION_RESULT_ELECTION_WON] = SOUNDS.GROUP_ELECTION_RESULT_WON,
    [GROUP_ELECTION_RESULT_ELECTION_LOST] = SOUNDS.GROUP_ELECTION_RESULT_LOST,
    [GROUP_ELECTION_RESULT_ABANDONED] = SOUNDS.GROUP_ELECTION_RESULT_LOST,
}

    -- EVENT_GROUP_ELECTION_RESULT -- ALERT HANDLER
    local function GroupElectionResultAlert(resultType, descriptor)
        if resultType ~= GROUP_ELECTION_RESULT_IN_PROGRESS and resultType ~= GROUP_ELECTION_RESULT_NOT_APPLICABLE then
            resultType = ZO_GetSimplifiedGroupElectionResultType(resultType)
            local alertText
            local message

            --Try to find override messages based on the descriptor
            local alertTextOverrideLookup = ZO_GroupElectionResultToAlertTextOverrides[resultType]
            if alertTextOverrideLookup then
                message = alertTextOverrideLookup[descriptor]
                alertText = alertTextOverrideLookup[descriptor]
            end

            --No override found
            if not alertText then
                local electionType, _, _, targetUnitTag = GetGroupElectionInfo()
                if electionType == GROUP_ELECTION_TYPE_KICK_MEMBER then
                    if resultType == GROUP_ELECTION_RESULT_ELECTION_LOST then
                        local kickMemberName = GetUnitName(targetUnitTag)
                        local kickMemberAccountName = GetUnitDisplayName(targetUnitTag)

                        local kickFinalName = CA.ResolveNameLink(kickMemberName, kickMemberAccountName)
                        local kickfinalAlertName = CA.ResolveNameNoLink(kickMemberName, kickMemberAccountName)
                        
                        message = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL, kickFinalName)
                        alertText = zo_strformat(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL, kickfinalAlertName)
                    else
                        --Successful kicks are handled in the GROUP_MEMBER_LEFT alert
                        return true
                    end
                end
            end

            --No specific behavior found, so just do the generic alert for the result
            if not alertText then
                message = GetString("SI_GROUPELECTIONRESULT", resultType)
                alertText = GetString("SI_GROUPELECTIONRESULT", resultType)
            end

            if alertText ~= "" then
                if type(alertText) == "function" then
                    alertText = alertText()
                    message = message()
                end
                
                if CA.SV.GroupVoteCA then
                    printToChat(message)
                end
                if CA.SV.GroupVoteAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
                end
                PlaySound(GroupElectionResultToSoundId[resultType])
            end
        end
        return true
    end

    -- EVENT_GROUP_ELECTION_REQUESTED -- ALERT HANDLER
    local function GroupElectionRequestedAlert(descriptor)
        local alertText
        if descriptor then
            alertText = ZO_GroupElectionDescriptorToRequestAlertText[descriptor]
        end

        if not alertText then
            alertText = ZO_GroupElectionDescriptorToRequestAlertText[ZO_GROUP_ELECTION_DESCRIPTORS.NONE]
        end

        if CA.SV.GroupVoteCA then
            printToChat(alertText)
        end
        if CA.SV.GroupVoteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
        end
        PlaySound(SOUNDS.GROUP_ELECTION_REQUESTED)
        return true
    end
    
    -- EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED -- ALERT HANDLER
    local function GroupReadyCheckCancelAlert(reason)
        --[[
        if reason ~= LFG_READY_CHECK_CANCEL_REASON_NOT_IN_READY_CHECK then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LFGREADYCHECKCANCELREASON", reason))
            d(GetString("SI_LFGREADYCHECKCANCELREASON", reason))
        end]]--
        
        if reason ~= LFG_READY_CHECK_CANCEL_REASON_NOT_IN_READY_CHECK and reason ~= LFG_READY_CHECK_CANCEL_REASON_GROUP_FORMED_SUCCESSFULLY then
            if CA.SV.GroupLFGCA then
                printToChat(GetString("SI_LFGREADYCHECKCANCELREASON", reason))
            end
            if CA.SV.GroupLFGAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LFGREADYCHECKCANCELREASON", reason))
            end
        end
    
        -- Sometimes if another player cancels slightly before a player in your group cancels, the "you have been placed in the front of the queue message displays. If this is the case, we want to show queue left for that event."
        if reason ~= LFG_READY_CHECK_CANCEL_REASON_GROUP_REPLACED_IN_QUEUE then
            g_showActivityStatus = false
            zo_callLater(function() g_showActivityStatus = true end, 1000)
        end
        
        g_showRCUpdates = true
    end
    
    -- EVENT_GROUP_VETERAN_DIFFICULTY_CHANGED -- ALERT HANDLER
    local function GroupDifficultyChangeAlert(isVeteranDifficulty)
        local message
        local sound
        if isVeteranDifficulty then
            message = GetString(SI_DUNGEON_DIFFICULTY_CHANGED_TO_VETERAN)
            sound = SOUNDS.DUNGEON_DIFFICULTY_VETERAN
        else
            message = GetString(SI_DUNGEON_DIFFICULTY_CHANGED_TO_NORMAL)
            sound = SOUNDS.DUNGEON_DIFFICULTY_NORMAL
        end
        
        if CA.SV.GroupCA then
            printToChat(message)
        end
        if CA.SV.GroupAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
        PlaySound(sound)
        
        return true
    end
    
    -- EVENT_GUILD_SELF_LEFT_GUILD -- ALERT HANDLER
    local function GuildSelfLeftAlert(guildId, guildName)
        local GuildIndexData = LUIE.GuildIndexData
        for i = 1,5 do
            local guild = GuildIndexData[i]
            if guild.name == guildName then
                local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guild.guildAlliance) or GuildColorize
                local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guild.guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
                local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guild.guildAlliance), "100%", "100%", guildName) or guildName
                local messageString = (ShouldDisplaySelfKickedFromGuildAlert(guildId)) and SI_GUILD_SELF_KICKED_FROM_GUILD or SI_LUIE_CA_GUILD_LEAVE_SELF
                local sound = (ShouldDisplaySelfKickedFromGuildAlert(guildId)) and SOUNDS.GENERAL_ALERT_ERROR or SOUNDS.GUILD_SELF_LEFT
                if CA.SV.GuildCA then
                    printToChat(strformat(GetString(messageString), guildNameAlliance))
                end
                if CA.SV.GuildAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(messageString), guildNameAllianceAlert))
                end
                PlaySound(sound)
                break
            end
        end

        -- Reindex Guild Ranks
        g_guildRankData = {}
        if CA.SV.GuildRankCA or CA.SV.GuildRankAlert then
            for i = 1,5 do
                local guildId = GetGuildId(i)
                local memberIndex = GetPlayerGuildMemberIndex(guildId)
                local _, _, rankIndex = GetGuildMemberInfo(guildId, memberIndex)
                g_guildRankData[guildId] = {rank=rankIndex}
            end
        end
        return true
    end
    
    -- EVENT_SAVE_GUILD_RANKS_RESPONSE -- ALERT HANDLER
    local function GuildRanksResponseAlert(guildId, result)
        if result ~= SOCIAL_RESULT_NO_ERROR then
            if CA.SV.GuildCA then
                printToChat(GetString("SI_SOCIALACTIONRESULT", result))
            elseif CA.SV.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_SOCIALACTIONRESULT", result))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        return true
    end
    
    local function LockpickFailedAlert(result)
        if CA.SV.NotificationLockpickCA then
            printToChat(GetString(SI_LUIE_CA_LOCKPICK_FAILED))
        end
        if CA.SV.NotificationLockpickAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_LOCKPICK_FAILED))
        end
        g_lockpickBroken = true
        zo_callLater (function() g_lockpickBroken = false end, 200)
        return true
    end
    
    local function LockpickLockedAlert(interactableName)
        printToChat(zo_strformat(SI_LOCKPICK_NO_KEY_AND_NO_LOCK_PICKS, interactableName))
        if CA.SV.NotificationLockpickAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, zo_strformat(SI_LOCKPICK_NO_KEY_AND_NO_LOCK_PICKS, interactableName))
        end
        PlaySound(SOUNDS.LOCKPICKING_NO_LOCKPICKS)
        return true
    end

    local function LockpickImpossibleAlert(interactableName)
        printToChat(zo_strformat(SI_LOCKPICK_IMPOSSIBLE_LOCK, interactableName))
        if CA.SV.NotificationLockpickAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, zo_strformat(SI_LOCKPICK_IMPOSSIBLE_LOCK, interactableName))
        end
        PlaySound(SOUNDS.LOCKPICKING_NO_LOCKPICKS)
        return true
    end

    -- EVENT_TRADE_INVITE_FAILED
    local function TradeInviteFailedAlert(errorReason, inviteeCharacterName, inviteeDisplayName)
        if CA.SV.NotificationTradeCA or CA.SV.NotificationTradeAlert then
            local finalName = CA.ResolveNameLink(inviteeCharacterName, inviteeDisplayName)
            local finalAlertName = CA.ResolveNameNoLink(inviteeCharacterName, inviteeDisplayName)

            if CA.SV.NotificationTradeCA then
                printToChat(strformat(GetString("SI_LUIE_CA_TRADEACTIONRESULT", errorReason), finalName))
            end
            
            if CA.SV.NotificationTradeAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString("SI_LUIE_CA_TRADEACTIONRESULT", errorReason), finalAlertName))
            end
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        g_tradeTarget = ""
        return true
    end

    -- EVENT_TRADE_INVITE_CONSIDERING
    local function TradeInviteConsideringAlert(inviterCharacterName, inviterDisplayName)
        if CA.SV.NotificationTradeCA or CA.SV.NotificationTradeAlert then
            local finalName = CA.ResolveNameLink(inviterCharacterName, inviterDisplayName)
            local finalAlertName = CA.ResolveNameNoLink(inviterCharacterName, inviterDisplayName)
            g_tradeTarget = ZO_SELECTED_TEXT:Colorize(finalName)
            
            if CA.SV.NotificationTradeCA then
                printToChat(strformat(GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), finalName))
            end
            if CA.SV.NotificationTradeAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_TRADE_INVITE_MESSAGE), finalAlertName))
            end
        end
       return true
    end

    -- EVENT_TRADE_INVITE_WAITING
    local function TradeInviteWaitingAlert(inviteeCharacterName, inviteeDisplayName)
    
        if CA.SV.NotificationTradeCA or CA.SV.NotificationTradeAlert then
            local finalName = CA.ResolveNameLink(inviteeCharacterName, inviteeDisplayName)
            local finalAlertName = CA.ResolveNameNoLink(inviteeCharacterName, inviteeDisplayName)
            g_tradeTarget = ZO_SELECTED_TEXT:Colorize(finalName)
            
            if CA.SV.NotificationTradeCA then
                printToChat(strformat(GetString(SI_LUIE_CA_TRADE_INVITE_CONFIRM), finalName))
            end
            if CA.SV.NotificationTradeAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_TRADE_INVITE_CONFIRM), finalAlertName))
            end

        end
        return true
    end

    -- EVENT_TRADE_INVITE_DECLINED
    local function TradeInviteDeclinedAlert()
        if CA.SV.NotificationTradeCA then
            printToChat(GetString(SI_LUIE_CA_TRADE_INVITE_DECLINED))
        end
        if CA.SV.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_TRADE_INVITE_DECLINED))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        g_tradeTarget = ""
        return true
    end

    -- EVENT_TRADE_INVITE_CANCELED
    local function TradeInviteCanceledAlert()
        if CA.SV.NotificationTradeCA then
            printToChat(GetString(SI_LUIE_CA_TRADE_INVITE_CANCELED))
        end
        if CA.SV.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_TRADE_INVITE_CANCELED))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        g_tradeTarget = ""
        return true
    end

    -- EVENT_TRADE_CANCELED
    local function TradeCanceledAlert()
        if CA.SV.NotificationTradeCA then
            printToChat(GetString(SI_TRADE_CANCELED))
        end
        if CA.SV.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_TRADE_CANCELED))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        
        EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
        if CA.SV.Loot or CA.SV.LootShowDisguise then
            EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
        end
        if not (CA.SV.Loot or CA.SV.LootShowDisguise) then
            g_inventoryStacks = {}
        end
        
        g_tradeTarget = ""
        g_inTrade = false
        return true
    end

    -- EVENT_TRADE_FAILED
    local function TradeFailedAlert(reason)
        if CA.SV.NotificationTradeCA then
            printToChat(GetString("SI_LUIE_CA_TRADEACTIONRESULT", reason))
        end
        if CA.SV.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LUIE_CA_TRADEACTIONRESULT", reason))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)

        g_tradeTarget = ""
        return true
    end

    -- EVENT_TRADE_SUCCEEDED
    local function TradeSucceededAlert()
        if CA.SV.NotificationTradeCA then
            printToChat(GetString(SI_TRADE_COMPLETE))
        end
        if CA.SV.NotificationTradeAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_TRADE_COMPLETE))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        
        
        EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
        if CA.SV.Loot or CA.SV.LootShowDisguise then
            EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
        end
        if not (CA.SV.Loot or CA.SV.LootShowDisguise) then
            g_inventoryStacks = {}
        end
        
        g_tradeTarget = ""
        g_inTrade = false
        return true
    end
    
    local function MailSendFailedAlert(reason)
        
        local function RestoreMailBackupValues()
            g_postageAmount = GetQueuedMailPostage()
            g_mailCOD = GetQueuedCOD()
        end

        if CA.SV.NotificationMailCA then
            printToChat(GetString("SI_SENDMAILRESULT", reason))
        end
        if CA.SV.NotificationMailAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, GetString("SI_SENDMAILRESULT", reason))
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    
        zo_callLater(RestoreMailBackupValues, 50) -- Prevents values from being cleared by failed message (when inbox is full, the currency change fires first regardless and then is refunded)
        return true
    end
    
    ZO_PreHook(alertHandlers, EVENT_LORE_BOOK_ALREADY_KNOWN, AlreadyKnowBookHook)
    ZO_PreHook(alertHandlers, EVENT_RIDING_SKILL_IMPROVEMENT, RidingSkillImprovementAlertHook)
    
    ZO_PreHook(alertHandlers, EVENT_LORE_BOOK_LEARNED, LoreBookLearnedAlertHook)
    
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_RECEIVED, DuelInviteReceivedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_SENT, DuelInviteSentAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_ACCEPTED, DuelInviteAcceptedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_FAILED, DuelInviteFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_DECLINED, DuelInviteDeclinedAlert)
    ZO_PreHook(alertHandlers, EVENT_DUEL_INVITE_CANCELED, DuelInviteCanceledAlert)
    ZO_PreHook(alertHandlers, EVENT_PLEDGE_OF_MARA_RESULT, PledgeOfMaraResultAlert)
    
    
    ZO_PreHook(alertHandlers, EVENT_GROUP_INVITE_RESPONSE, GroupInviteResponseAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_INVITE_ACCEPT_RESPONSE_TIMEOUT, GroupInviteTimeoutAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_NOTIFICATION_MESSAGE, GroupNotificationMessageAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_UPDATE, GroupUpdateAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_MEMBER_LEFT, GroupMemberLeftAlert)
    ZO_PreHook(alertHandlers, EVENT_LEADER_UPDATE, LeaderUpdateAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUPING_TOOLS_LFG_JOINED, GroupingToolsLFGJoinedAlert)
    ZO_PreHook(alertHandlers, EVENT_ACTIVITY_QUEUE_RESULT, ActivityQueueResultAlert)
    
    ZO_PreHook(alertHandlers, EVENT_GROUP_ELECTION_FAILED, GroupElectionFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_ELECTION_RESULT, GroupElectionResultAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_ELECTION_REQUESTED, GroupElectionRequestedAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED, GroupReadyCheckCancelAlert)
    ZO_PreHook(alertHandlers, EVENT_GROUP_VETERAN_DIFFICULTY_CHANGED, GroupDifficultyChangeAlert)
    
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_REMOVED, CA.GroupInviteRemoved)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED, CA.OnGroupMemberJoined)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_INVITE_RECEIVED, CA.OnGroupInviteReceived)
    
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_TYPE_CHANGED, CA.OnGroupTypeChanged)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_ELECTION_NOTIFICATION_ADDED, CA.VoteNotify)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_NO_LONGER_LFG, CA.LFGLeft)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, CA.ActivityStatusUpdate)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED, CA.ReadyCheckUpdate)
    
    ZO_PreHook(alertHandlers, EVENT_GUILD_SELF_LEFT_GUILD, GuildSelfLeftAlert)
    ZO_PreHook(alertHandlers, EVENT_SAVE_GUILD_RANKS_RESPONSE, GuildRanksResponseAlert)
    
    ZO_PreHook(alertHandlers, EVENT_LOCKPICK_FAILED, LockpickFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_INTERACTABLE_LOCKED, LockpickLockedAlert)
    ZO_PreHook(alertHandlers, EVENT_INTERACTABLE_IMPOSSIBLE_TO_PICK, LockpickImpossibleAlert)
    
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_FAILED, TradeInviteFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_CONSIDERING, TradeInviteConsideringAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_WAITING, TradeInviteWaitingAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_DECLINED, TradeInviteDeclinedAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_INVITE_CANCELED, TradeInviteCanceledAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_CANCELED, TradeCanceledAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_FAILED, TradeFailedAlert)
    ZO_PreHook(alertHandlers, EVENT_TRADE_SUCCEEDED, TradeSucceededAlert)
    ZO_PreHook(alertHandlers, EVENT_MAIL_SEND_FAILED, MailSendFailedAlert)

    
    
    
    

	local csaHandlers = ZO_CenterScreenAnnounce_GetHandlers()
    
    local chatHandlers = ZO_ChatSystem_GetEventHandlers()

	local function LoreBookXPHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, skillType, skillIndex, rank, previousXP, currentXP)
        if guildReputationIndex > 0 then
        
            local collectionName, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            local title, icon = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
            local bookName
            local bookLink
            if CA.SV.BracketOptionLorebook == 1 then
                bookName = strfmt("%s", title)
                bookLink = strfmt("|H0:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
            else
                bookName = strfmt("[%s]", title)
                bookLink = strfmt("|H1:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
            end
            
            local stringPrefix
            local csaPrefix
            if categoryIndex == 1 then 
                -- Is a lore book
                stringPrefix = CA.SV.LorebookPrefix1
                csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_ANNOUNCE_BOOK_LEARNED)
            else
                -- Is a normal book
                stringPrefix = CA.SV.LorebookPrefix2
                csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LUIE_CA_LOREBOOK_BOOK)
            end
            
            -- Chat Announcement
            if CA.SV.LorebookCA then
                local formattedIcon = CA.SV.LorebookIcon and ("|t16:16:" .. icon .. "|t ") or ""
                local stringPart1
                local stringPart2
                if stringPrefix ~= "" then 
                    stringPart1 = LorebookColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.LorebookBracket], stringPrefix, bracket2[CA.SV.LorebookBracket]))
                else
                    stringPart1 = ""
                end
                if CA.SV.LorebookCategory then
                    stringPart2 = collectionName ~= "" and LorebookColorize2:Colorize(strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName)) or LorebookColorize2:Colorize(strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                else
                    stringPart2 = ""
                end
            
                local finalMessage = strformat("<<1>><<2>><<3>><<4>>", stringPart1, formattedIcon, bookLink, stringPart2)
                g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "LOREBOOK" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            
            -- Alert Announcement
            if CA.SV.LorebookAlert then
                local text = collectionName ~= "" and strformat("<<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), collectionName) or strformat(" <<1>> <<2>>.", GetString(SI_LUIE_CA_LOREBOOK_ADDED_CA), GetString(SI_WINDOW_TITLE_LORE_LIBRARY))
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat("<<1>> <<2>>", title, text))
            end
            
            -- Center Screen Announcement
            if CA.SV.LorebookCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_ACQUIRED)
                if not LUIE.SV.HideXPBar then
                    local barType = PLAYER_PROGRESS_BAR:GetBarType(PPB_CLASS_SKILL, skillType, skillIndex)
                    local rankStartXP, nextRankStartXP = GetSkillLineRankXPExtents(skillType, skillIndex, rank)
                    messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(barType, rank, previousXP - rankStartXP, currentXP - rankStartXP))
                end
                if collectionName ~= "" then
                    messageParams:SetText(csaPrefix, strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, collectionName))
                else
                    messageParams:SetText(csaPrefix, strformat(SI_LUIE_CA_LOREBOOK_ADDED_CSA, title, GetString(SI_WINDOW_TITLE_LORE_LIBRARY)))
                end
                messageParams:SetIconData(icon, "EsoUI/Art/Achievements/achievements_iconBG.dds")
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_BOOK_LEARNED_SKILL_EXPERIENCE)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            if not CA.SV.LorebookCSA then
                PlaySound(SOUNDS.BOOK_ACQUIRED)
            end
        end
        return true
    end
    
    local function LoreCollectionHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, isMaxRank)
        if guildReputationIndex == 0 or isMaxRank then
            -- Only fire this message if we're not part of the guild or at max level within the guild.
            -- TODO: Fix, this condition doesn't work
            local collectionName, description, numKnownBooks, totalBooks, hidden , textureName = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            local stringPrefix = CA.SV.LorebookCollectionPrefix
            local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE)
            if not hidden or CA.SV.LorebookShowHidden then
                
                if CA.SV.LorebookCollectionCA then
                    local formattedIcon
                    local stringPart1
                    local stringPart2
                    if stringPrefix ~= "" then
                        stringPart1 = LorebookColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.LorebookBracket], stringPrefix, bracket2[CA.SV.LorebookBracket]))
                    else
                        stringPart1 = ""
                    end
                    if textureName ~= "" and textureName ~= nil then
                        formattedIcon = CA.SV.LorebookIcon and ("|t16:16:" .. textureName .. "|t ") or ""
                    end
                    if CA.SV.LorebookCategory then
                        stringPart2 = LorebookColorize2:Colorize(zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    else
                        stringPart2 = ""
                    end
                    
                    local finalMessage = strformat("<<1>><<2>><<3>>", stringPart1, formattedIcon, stringPart2)
                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "LOREBOOK" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                end
                
                if CA.SV.LorebookCollectionCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_COLLECTION_COMPLETED)
                    messageParams:SetText(csaPrefix, zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    messageParams:SetIconData(textureName)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_COLLECTION_COMPLETED)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                
                if CA.SV.LorebookCollectionAlert then
                   local text = zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName)
                   ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
                end
                if not CA.SV.LorebookCSA then
                    PlaySound(SOUNDS.BOOK_COLLECTION_COMPLETED)
                end
                
            end
        end
        return true
    end

    local function LoreCollectionXPHook(categoryIndex, collectionIndex, guildReputationIndex, skillType, skillIndex, rank, previousXP, currentXP)
        if guildReputationIndex > 0 then
            local collectionName, description, numKnownBooks, totalBooks, hidden, textureName = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            local stringPrefix = CA.SV.LorebookCollectionPrefix
            local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE)
            if not hidden or CA.SV.LorebookShowHidden then
            
                if CA.SV.LorebookCollectionCA then
                    local formattedIcon
                    local stringPart1
                    local stringPart2
                    if stringPrefix ~= "" then
                        stringPart1 = LorebookColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.LorebookBracket], stringPrefix, bracket2[CA.SV.LorebookBracket]))
                    else
                        stringPart1 = ""
                    end
                    if textureName ~= "" and textureName ~= nil then
                        formattedIcon = CA.SV.LorebookIcon and zo_strformat("<<1>> ", zo_iconFormatInheritColor(textureName, 16, 16)) or ""
                    end
                    if CA.SV.LorebookCategory then
                        stringPart2 = LorebookColorize2:Colorize(zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    else
                        stringPart2 = ""
                    end
                    
                    local finalMessage = strformat("<<1>><<2>><<3>>", stringPart1, formattedIcon, stringPart2)
                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "LOREBOOK" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                end
            
                if CA.SV.LorebookCollectionCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_COLLECTION_COMPLETED)
                    if not LUIE.SV.HideXPBar then
                        local barType = PLAYER_PROGRESS_BAR:GetBarType(PPB_CLASS_SKILL, skillType, skillIndex)
                        local rankStartXP, nextRankStartXP = GetSkillLineRankXPExtents(skillType, skillIndex, rank)
                        messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(barType, rank, previousXP - rankStartXP, currentXP - rankStartXP))
                    end
                    messageParams:SetText(csaPrefix, zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                    messageParams:SetIconData(textureName)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                
                if CA.SV.LorebookCollectionAlert then
                   local text = zo_strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName)
                   ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
                end
                if not CA.SV.LorebookCSA then
                    PlaySound(SOUNDS.BOOK_COLLECTION_COMPLETED)
                end
                
            end
        end
        return true
    end
    
    local function SkillPointsChangedHook(oldPoints, newPoints, oldPartialPoints, newPartialPoints)
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
        local stringPrefix = CA.SV.SkillPointSkyshardMsg
        local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_SKYSHARD_GAINED)
        
        local stringPart1 -- CA
        local stringPart2 -- CA
        local finalMessage -- CA
        local finalText -- Alert
        local sound -- All
        
        if oldPartialPoints ~= newPartialPoints then
            sound = SOUNDS.SKYSHARD_GAINED
            if newPartialPoints == 0 then
                if newPoints <= oldPoints then
                    return
                end
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_POINTS_GAINED)
                messageParams:SetText(csaPrefix, zo_strformat(SI_SKILL_POINT_GAINED, newPoints - oldPoints))
                text = zo_strformat(SI_SKILL_POINT_GAINED, newPoints - oldPoints)
                finalText = zo_strformat("<<1>> (3/3)", csaPrefix)
                
                if stringPrefix ~= "" then
                    stringPart1 = SkillPointColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.SkillPointBracket], stringPrefix, bracket2[CA.SV.SkillPointBracket]))
                else
                    stringPart1 = ""
                end
                stringPart2 = SkillPointColorize2:Colorize(zo_strformat(SI_SKILL_POINT_GAINED, newPoints - oldPoints))
                finalMessage = strformat("<<1>><<2>>.", stringPart1, stringPart2)
            else
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_POINTS_PARTIAL_GAINED)
                messageParams:SetText(csaPrefix, zo_strformat(SI_SKYSHARD_GAINED_POINTS, newPartialPoints, NUM_PARTIAL_SKILL_POINTS_FOR_FULL))
                textPart1 = (stringPrefix .. ": ")
                finalText = zo_strformat("<<1>> (<<2>>/3)", csaPrefix, newPoints-oldPoints)
                
                if stringPrefix ~= "" then
                    if CA.SV.ShowSkillPointsPartial then
                        stringPart1 = SkillPointColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.SkillPointBracket], stringPrefix, bracket2[CA.SV.SkillPointBracket]))
                    else
                        stringPart1 = SkillPointColorize1:Colorize(strformat("<<1>>!", stringPrefix))
                    end
                else
                    stringPart1 = ""
                end
                if CA.SV.ShowSkillPointsPartial then
                    stringPart2 = SkillPointColorize2:Colorize(zo_strformat(SI_SKYSHARD_GAINED_POINTS, newPartialPoints, NUM_PARTIAL_SKILL_POINTS_FOR_FULL))
                else
                    stringPart2 = ""
                end
                finalMessage = strformat("<<1>><<2>>", stringPart1, stringPart2)
            end
        elseif newPoints > oldPoints then
            sound = SOUNDS.SKILL_GAINED
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_POINTS_GAINED)
            messageParams:SetText(zo_strformat(SI_SKILL_POINT_GAINED, newPoints - oldPoints))
            
            finalMessage = SkillPointColorize2:Colorize(zo_strformat(SI_SKILL_POINT_GAINED, newPoints - oldPoints) .. ".")
            finalText = zo_strformat(SI_SKILL_POINT_GAINED, newPoints - oldPoints) .. "."
        end
        
        if CA.SV.SkillPointCA then
            if finalMessage ~= "" then
                g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "SKILL" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
        end
        if CA.SV.SkillPointCSA then
            messageParams:SetSound(sound)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        if CA.SV.SkillPointAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, finalText)
        end
        if not CA.SV.SkillPointCSA then
            PlaySound(Sound)
        end
        return true
    end

    local function SkillLineAddedHook(skillType, lineIndex)
        local lineName = GetSkillLineInfo(skillType, lineIndex)
        local icon = select(4, ZO_Skills_GetIconsForSkillType(skillType))
        
        if CA.SV.SkillLineUnlockCA then
            local formattedIcon = CA.SV.SkillLineIcon and zo_strformat("<<1>> ", zo_iconFormatInheritColor(icon, 16, 16)) or ""
            local formattedString = SkillLineColorize:Colorize(zo_strformat(SI_LUIE_CA_SKILL_LINE_ADDED, formattedIcon, lineName))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            
        end
        
        local discoverIcon = zo_iconFormat(icon, 32, 32)
        if CA.SV.SkillLineUnlockCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.SKILL_LINE_ADDED)
            local formattedIcon = zo_iconFormat(icon, 32, 32)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_LINE_ADDED)
            messageParams:SetText(zo_strformat(SI_SKILL_LINE_ADDED, formattedIcon, lineName))
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.SkillLineUnlockAlert then
            local formattedIcon = zo_iconFormat(icon, "75%", "75%")
            local text = zo_strformat(SI_SKILL_LINE_ADDED, formattedIcon, lineName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
        if not CA.SV.SkillLineUnlockCSA then
            PlaySound(SOUNDS.SKILL_LINE_ADDED)
        end
        return true
    end
 
    local function AbilityProgressionRankHook(progressionIndex, rank, maxRank, morph)
        local _, _, _, atMorph = GetAbilityProgressionXPInfo(progressionIndex)
        local name = GetAbilityProgressionAbilityInfo(progressionIndex, morph, rank)
        
        if atMorph then
            if CA.SV.SkillAbilityCA then
                formattedString = SkillLineColorize:Colorize(zo_strformat(SI_MORPH_AVAILABLE_ANNOUNCEMENT, name) .. ".")
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            
            if CA.SV.SkillAbilityCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ABILITY_MORPH_AVAILABLE)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ABILITY_PROGRESSION_RANK_MORPH)
                messageParams:SetText(zo_strformat(SI_MORPH_AVAILABLE_ANNOUNCEMENT, name))
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.SkillAbilityAlert then
                local text = zo_strformat(SI_MORPH_AVAILABLE_ANNOUNCEMENT, name) .. "."
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end
            
            if not CA.SV.SkillAbilityCSA then
                PlaySound(SOUNDS.ABILITY_MORPH_AVAILABLE)
            end   
        else
            if CA.SV.SkillAbilityCA then
                formattedString = SkillLineColorize:Colorize(zo_strformat(SI_LUIE_CA_ABILITY_RANK_UP, name, rank) .. ".")
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            
            if CA.SV.SkillAbilityCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.ABILITY_RANK_UP)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ABILITY_PROGRESSION_RANK_UPDATE)
                messageParams:SetText(zo_strformat(SI_LUIE_CA_ABILITY_RANK_UP, name, rank))
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.SkillAbilityAlert then
                local text = zo_strformat(SI_LUIE_CA_ABILITY_RANK_UP, name, rank) .. "."
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end
            
            if not CA.SV.SkillAbilityCSA then
                PlaySound(SOUNDS.ABILITY_RANK_UP)
            end   
            
        end
        return true
    end
    
    local function SkillRankUpdateHook(skillType, lineIndex, rank)
        -- crafting skill updates get deferred if they're increased while crafting animations are in progress
        -- ZO_Skills_TieSkillInfoHeaderToCraftingSkill handles triggering the deferred center screen announce in that case
        if skillType ~= SKILL_TYPE_RACIAL and (skillType ~= SKILL_TYPE_TRADESKILL or not ZO_CraftingUtils_IsPerformingCraftProcess()) then
            local lineName, _, discovered = GetSkillLineInfo(skillType, lineIndex)
            if discovered then
                
                if CA.SV.SkillLineCA then
                    local formattedString = SkillLineColorize:Colorize(zo_strformat(SI_SKILL_RANK_UP, lineName, rank) .. ".")
                    g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "SKILL" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                end
                
                if CA.SV.SkillLineCSA then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.SKILL_LINE_LEVELED_UP)
                    messageParams:SetText(zo_strformat(SI_SKILL_RANK_UP, lineName, rank))
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_RANK_UPDATE)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                
                if CA.SV.SkillLineAlert then
                    local formattedText = zo_strformat(SI_SKILL_RANK_UP, lineName, rank) .. "."
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedText)
                end
                
                if not CA.SV.SkillLineCSA then
                    PlaySound(SOUNDS.SKILL_LINE_LEVELED_UP)
                end
                
            end
        end
        return true
    end

    local function SkillXPUpdateHook(skillType, skillIndex, reason, rank, previousXP, currentXP)
        if (skillType == SKILL_TYPE_GUILD and GUILD_SKILL_SHOW_REASONS[reason]) or reason == PROGRESS_REASON_JUSTICE_SKILL_EVENT then
            if not LUIE.SV.HideXPBar then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_NO_TEXT)
                local barType = PLAYER_PROGRESS_BAR:GetBarType(PPB_CLASS_SKILL, skillType, skillIndex)
                local rankStartXP, nextRankStartXP = GetSkillLineRankXPExtents(skillType, skillIndex, rank)
                local sound = GUILD_SKILL_SHOW_SOUNDS[reason]
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SKILL_XP_UPDATE)
                messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(barType, rank, previousXP - rankStartXP, currentXP - rankStartXP, sound))
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        return true
        
    end
    
    local COLLECTIBLE_EMERGENCY_BACKGROUND = "EsoUI/Art/Guild/guildRanks_iconFrame_selected.dds"
    local function CollectibleUnlockedHook(collectibleId, justUnlocked)
        if not justUnlocked then
            return
        end
        
        local stringPrefix = CA.SV.CollectiblePrefix
        local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_TITLE)
        
        local collectibleName, _, iconFile = GetCollectibleInfo(collectibleId)
        local isPlaceholder = IsCollectiblePlaceholder(collectibleId)
        if not isPlaceholder then
        
            local categoryIndex, subcategoryIndex = GetCategoryInfoFromCollectibleId(collectibleId)

            local categoryName = GetCollectibleCategoryInfo(categoryIndex)
            local subcategoryName = subcategoryIndex and GetCollectibleSubCategoryInfo(categoryIndex, subcategoryIndex) or nil
            local displayedCategory = subcategoryName and subcategoryName or categoryName

            if CA.SV.CollectibleCA then
                local link = GetCollectibleLink(collectibleId, linkBrackets[CA.SV.BracketOptionCollectible])
                local formattedIcon = CA.SV.CollectibleIcon and strfmt("|t16:16:%s|t ", iconFile) or ""
            
                local string1
                if stringPrefix ~= "" then 
                    string1 = CollectibleColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.CollectibleBracket], stringPrefix, bracket2[CA.SV.CollectibleBracket]))
                else
                    string1 = ""
                end
                local string2
                if CA.SV.CollectibleCategory then
                    string2 = CollectibleColorize2:Colorize(strformat(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_BODY, link, displayedCategory) .. ".")
                else
                    string2 = link
                end
                printToChat(strformat("<<1>><<2>><<3>>", string1, formattedIcon, string2))
            end
            
            if CA.SV.CollectibleCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.COLLECTIBLE_UNLOCKED)
                messageParams:SetText(csaPrefix, zo_strformat(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_BODY, collectibleName, displayedCategory))
                messageParams:SetIconData(iconFile, COLLECTIBLE_EMERGENCY_BACKGROUND)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SINGLE_COLLECTIBLE_UPDATED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.CollectibleAlert then
                local text = zo_strformat(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_BODY, collectibleName, displayedCategory .. ".")
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end
            
        end
        return true
    end

    local function CollectiblesUnlockedHook(numJustUnlocked)
        if numJustUnlocked > 0 then
        
            local stringPrefix = CA.SV.CollectiblePrefix
            local csaPrefix = stringPrefix ~= "" and stringPrefix or GetString(SI_COLLECTIONS_UPDATED_ANNOUNCEMENT_TITLE)
            
            if CA.SV.CollectibleCA then
                local string1
                if stringPrefix ~= "" then 
                    string1 = CollectibleColorize1:Colorize(strformat("<<1>><<2>><<3>> ", bracket1[CA.SV.CollectibleBracket], stringPrefix, bracket2[CA.SV.CollectibleBracket]))
                else
                    string1 = ""
                end
                local string2 = CollectibleColorize2:Colorize(strformat(SI_COLLECTIBLES_UPDATED_ANNOUNCEMENT_BODY, numJustUnlocked) .. ".")
                printToChat(strformat("<<1>><<2>>", string1, string2))
            end
        
            if CA.SV.CollectibleCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.COLLECTIBLE_UNLOCKED)
                messageParams:SetText(csaPrefix, zo_strformat(SI_COLLECTIBLES_UPDATED_ANNOUNCEMENT_BODY, numJustUnlocked))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COLLECTIBLES_UPDATED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.CollectibleAlert then
                local text = zo_strformat(SI_COLLECTIBLES_UPDATED_ANNOUNCEMENT_BODY, numJustUnlocked) .. "."
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end
            
        end
        return true
    end 
    
    local function QuestAddedHook(journalIndex, questName, objectiveName)
    
        EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
        CA.PrintBufferedXP()
    
        local questType = GetJournalQuestType(journalIndex)
        local instanceDisplayType = GetJournalInstanceDisplayType(journalIndex)
        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)
        
        local questType = GetJournalQuestType(journalIndex)
        local instanceDisplayType = GetJournalInstanceDisplayType(journalIndex)
        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)
        
        -- Add quest to index
        g_questIndex[questName] =
            {
                questType = questType,
                instanceDisplayType = instanceDisplayType
            }
        
        if CA.SV.QuestAcceptCA then
            local questNameFormatted
            local stepText = GetJournalQuestStepInfo(journalIndex, 1)
            local formattedString

            if CA.SV.QuestLong then
                questNameFormatted = (strformat("|c<<1>><<2>>:|r |c<<3>><<4>>|r", QuestColorQuestNameColorize:ToHex(), questName, QuestColorQuestDescriptionColorize, stepText))
            else
                questNameFormatted = (strformat("|c<<1>><<2>>|r", QuestColorQuestNameColorize:ToHex(), questName))
            end
            if iconTexture and CA.SV.QuestIcon then
                formattedString = strfmt(GetString(SI_LUIE_CA_QUEST_ACCEPT) .. zo_iconFormat(iconTexture, 16, 16) .. " " .. questNameFormatted)
            else
                formattedString = strfmt("%s%s", GetString(SI_LUIE_CA_QUEST_ACCEPT), questNameFormatted)
            end
        
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end
        
        if CA.SV.QuestAcceptCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.QUEST_ACCEPTED)
            if iconTexture then
                messageParams:SetText(zo_strformat(SI_LUIE_CA_QUEST_ACCEPT_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName))
            else
                messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_QUEST_ACCEPT, questName))
            end
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_ADDED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.QuestAcceptAlert then
            local alertString
            if iconTexture and CA.SV.QuestIcon then
                alertString = zo_strformat(SI_LUIE_CA_QUEST_ACCEPT_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
            else
                alertString = zo_strformat(SI_NOTIFYTEXT_QUEST_ACCEPT, questName)
            end
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
        end
        
        -- If we don't have either CSA or Alert on (then we want to play a sound here)
        if not CA.SV.QuestAcceptCSA then
            PlaySound(SOUNDS.QUEST_ACCEPTED)
        end
        return true
        
    end
    
    local function QuestCompleteHook(questName, level, previousExperience, currentExperience, championPoints, questType, instanceDisplayType)
        
        EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
        CA.PrintBufferedXP()
        
        local function ResetQuestRewardStatus()
            g_itemReceivedIsQuestReward = false
        end

        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)
        
        if CA.SV.QuestCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.QUEST_COMPLETED)
            if iconTexture then
                messageParams:SetText(zo_strformat(SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName))
            else
                messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_QUEST_COMPLETE, questName))
            end
            if not LUIE.SV.HideXPBar then
                messageParams:SetBarParams(GetRelevantBarParams(level, previousExperience, currentExperience, championPoints))
            end
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_COMPLETE)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.QuestCompleteAlert then
            local alertString
            if iconTexture and CA.SV.QuestIcon then
                alertString = zo_strformat(SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
            else
                alertString = zo_strformat(SI_NOTIFYTEXT_QUEST_COMPLETE, questName)
            end
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
        end
        
        if CA.SV.QuestCompleteCA then
            local questNameFormatted = (strformat("|cFFA500<<1>>|r", questName))
            local formattedString
            if iconTexture and CA.SV.QuestIcon then
                formattedString = strformat(SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON, zo_iconFormat(iconTexture, 16, 16), questNameFormatted)
            else
                formattedString = strformat(SI_NOTIFYTEXT_QUEST_COMPLETE, questNameFormatted)
            end
            -- This event double fires on quest completion, if an equivalent message is already detected in queue, then abort!
            for i = 1, #g_queuedMessages do
                if g_queuedMessages[i].message == formattedString then
                    return true
                end
            end
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end
        
        -- If we don't have either CSA or Alert on (then we want to play a sound here)
        if not CA.SV.QuestCompleteCSA then
            PlaySound(SOUNDS.QUEST_COMPLETED)
        end
        
        -- We set this variable to true in order to override the [Looted] message syntax that would be applied to a quest reward normally.
        if CA.SV.Loot then
            g_itemReceivedIsQuestReward = true
            zo_callLater(ResetQuestRewardStatus, 500)
        end
        
        return true
        
    end
    
    local function ObjectiveCompletedHook(zoneIndex, poiIndex, level, previousExperience, currentExperience, championPoints)
        local name, _, _, finishedDescription = GetPOIInfo(zoneIndex, poiIndex)
        local nameFormatted
        local formattedText

        if CA.SV.QuestLocLong and finishedDescription ~= "" then
            nameFormatted = (strformat("|c<<1>><<2>>:|r |c<<3>><<4>>|r", QuestColorLocNameColorize, name, QuestColorLocDescriptionColorize, finishedDescription))
        else
            nameFormatted = (strformat("|c<<1>><<2>>|r", QuestColorLocNameColorize, name))
        end
        formattedText = strformat(SI_NOTIFYTEXT_OBJECTIVE_COMPLETE, nameFormatted)
        
        if CA.SV.QuestCompleteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_COMPLETE, name))
        end
        
        if CA.SV.QuestCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.OBJECTIVE_COMPLETED)
            if not LUIE.SV.HideXPBar then
                messageParams:SetBarParams(GetRelevantBarParams(level, previousExperience, currentExperience, championPoints))
            end
            messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_COMPLETE, name), finishedDescription)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_OBJECTIVE_COMPLETED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.QuestCompleteCA then
            -- This event double fires on quest completion, if an equivalent message is already detected in queue, then abort!
            for i = 1, #g_queuedMessages do
                if g_queuedMessages[i].message == formattedText then
                    return true
                end
            end
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedText, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end

        return true
    end
    
    -- For failure and updates (gonna need to punch a bunch of stuff in here to divide it up)
    local function ConditionCounterHook(journalIndex, questName, conditionText, conditionType, currConditionVal, newConditionVal, conditionMax, isFailCondition, stepOverrideText, isPushed, isComplete, isConditionComplete, isStepHidden)
        if isStepHidden or (isPushed and isComplete) or (currConditionVal >= newConditionVal) then
        return true
    end

        local type -- This variable represents whether this message is an objective update or failure state message (1 = update, 2 = failure) There are too many conditionals to resolve what we need to print inside them so we do it after setting the formatting.
        local alertMessage -- Variable for alert message
        local formattedMessage -- Variable for CA Message
        local sound -- Set correct sound based off context
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
        
        if newConditionVal ~= currConditionVal and not isFailCondition then
            sound = isConditionComplete and SOUNDS.QUEST_OBJECTIVE_COMPLETE or SOUNDS.QUEST_OBJECTIVE_INCREMENT
            messageParams:SetSound(sound)
        end

        if isConditionComplete and conditionType == QUEST_CONDITION_TYPE_GIVE_ITEM then
             messageParams:SetText(zo_strformat(SI_TRACKED_QUEST_STEP_DONE, conditionText))
             alertMessage = zo_strformat(SI_TRACKED_QUEST_STEP_DONE, conditionText)
             formattedMessage = zo_strformat(SI_TRACKED_QUEST_STEP_DONE, conditionText)
             type = 1
        elseif stepOverrideText == "" then
            if isFailCondition then
                if conditionMax > 1 then
                    messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL, conditionText, newConditionVal, conditionMax))
                    alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL, conditionText, newConditionVal, conditionMax)
                    formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL, conditionText, newConditionVal, conditionMax)
                else
                   messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, conditionText))
                   alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, conditionText)
                   formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, conditionText)
                end
                type = 2
            else
                if conditionMax > 1 and newConditionVal < conditionMax then
                    messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE, conditionText, newConditionVal, conditionMax))
                    alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE, conditionText, newConditionVal, conditionMax)
                    formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE, conditionText, newConditionVal, conditionMax)
                else
                    messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, conditionText))
                    alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, conditionText)
                    formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, conditionText)
                end
                type = 1
            end
        else
            if isFailCondition then
                messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, stepOverrideText))
                alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, stepOverrideText)
                formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, stepOverrideText)
                type = 2
            else
                messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, stepOverrideText))
                alertMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, stepOverrideText)
                formattedMessage = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, stepOverrideText)
                type = 1
            end
        end
        
        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_CONDITION_COUNTER_CHANGED)
        
        if type == 1 then
            if CA.SV.QuestObjCompleteCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedMessage, type = "QUEST" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            if CA.SV.QuestObjCompleteCSA then
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            if CA.SV.QuestObjCompleteAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
            end
            if not CA.SV.QuestObjCompleteCSA then
                PlaySound(sound)
            end
        end
        
        if type == 2 then
            if CA.SV.QuestFailCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedMessage, type = "QUEST" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            if CA.SV.QuestFailCSA then
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            if CA.SV.QuestFailAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
            end
            if not CA.SV.QuestFailCSA then
                PlaySound(sound)
            end
        end
        
        return true
    end
    
    local function OptionalStepHook(text)
        if text ~= "" then
            
            local message = strformat ("|c<<1>><<2>>|r", QuestColorQuestDescriptionColorize, text)
            local formattedString = zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, message)
            
            if CA.SV.QuestObjCompleteCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            
            if CA.SV.QuestObjCompleteCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.QUEST_OBJECTIVE_COMPLETE)
                messageParams:SetText(zo_strformat(SI_ALERTTEXT_QUEST_CONDITION_UPDATE_NO_COUNT, text))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_OPTIONAL_STEP_ADVANCED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.QuestObjCompleteAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
            end
            if not CA.SV.QuestObjCompleteCSA then
                PlaySound(SOUNDS.QUEST_OBJECTIVE_COMPLETE)
            end
        end
        return true
    end

    local function OnQuestRemoved(eventId, isCompleted, journalIndex, questName, zoneIndex, poiIndex)
    
        if not isCompleted then
            if CA.SV.QuestAbandonCA or CA.SV.QuestAbandonCSA or CA.SV.QuestAbandonAlert then
            
                local iconTexture
                
                if g_questIndex[questName] then
                    local questJournalObject = SYSTEMS:GetObject("questJournal")
                    local questType = g_questIndex[questName].questType
                    local instanceDisplayType = g_questIndex[questName].instanceDisplayType
                    iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)
                end
            
                if CA.SV.QuestAbandonCA then
                    local questNameFormatted = (strformat("|cFFA500<<1>>|r", questName))
                    local formattedString
                    if iconTexture and CA.SV.QuestIcon then
                        formattedString = strformat(SI_LUIE_CA_QUEST_ABANDONED_WITH_ICON, zo_iconFormat(iconTexture, 16, 16), questNameFormatted)
                    else
                        formattedString = strformat(SI_LUIE_CA_QUEST_ABANDONED, questNameFormatted)
                    end
                    g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                end

                if CA.SV.QuestAbandonCSA then
                    local formattedString
                    if iconTexture then
                        formattedString = strformat(SI_LUIE_CA_QUEST_ABANDONED_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
                    else
                        formattedString = strformat(SI_LUIE_CA_QUEST_ABANDONED, questName)
                    end
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.QUEST_ABANDONED)
                    messageParams:SetText(formattedString)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_ADDED)
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
                
                if CA.SV.QuestAbandonAlert then
                    local formattedString
                    if iconTexture and CA.SV.QuestIcon then
                        formattedString = strformat(SI_LUIE_CA_QUEST_ABANDONED_WITH_ICON, zo_iconFormat(iconTexture, "75%", "75%"), questName)
                    else
                        formattedString = strformat(SI_LUIE_CA_QUEST_ABANDONED, questName)
                    end
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
                end
                    
            end
            if not CA.SV.QuestAbandonCSA then
                PlaySound(SOUNDS.QUEST_ABANDONED)
            end
        end
        g_questIndex[questName] = nil
    end

    -- Quest Advancement displays all the "appropriate" conditions that the player needs to do to advance the current step
    local function OnQuestAdvanced(eventId, questIndex, questName, isPushed, isComplete, mainStepChanged, soundOverride)

        if(not mainStepChanged) then return end
        
        local sound = SOUNDS.QUEST_OBJECTIVE_STARTED

        for stepIndex = QUEST_MAIN_STEP_INDEX, GetJournalQuestNumSteps(questIndex) do
            local _, visibility, stepType, stepOverrideText, conditionCount = GetJournalQuestStepInfo(questIndex, stepIndex)

            if visibility == nil or visibility == QUEST_STEP_VISIBILITY_OPTIONAL then
                if stepOverrideText ~= "" then
                    if CA.SV.QuestObjUpdateCA then
                        g_queuedMessages[g_queuedMessagesCounter] = { message = stepOverrideText, type = "QUEST" }
                        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                    end
                    if CA.SV.QuestObjUpdateCSA then
                        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, sound)
                        messageParams:SetText(stepOverrideText)
                        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_OPTIONAL_STEP_ADVANCED)
                        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                        sound = nil -- no longer needed, we played it once
                    end
                    if CA.SV.QuestObjUpdateAlert then
                        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, stepOverrideText)
                    end
                else
                    for conditionIndex = 1, conditionCount do
                        local conditionText, curCount, maxCount, isFailCondition, isConditionComplete, _, isVisible  = GetJournalQuestConditionInfo(questIndex, stepIndex, conditionIndex)

                        if not (isFailCondition or isConditionComplete) and isVisible then
                            if CA.SV.QuestObjUpdateCA then
                                g_queuedMessages[g_queuedMessagesCounter] = { message = conditionText, type = "QUEST" }
                                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                            end
                            if CA.SV.QuestObjUpdateCSA then
                                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, sound)
                                messageParams:SetText(conditionText)
                                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_QUEST_OPTIONAL_STEP_ADVANCED)
                                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                                sound = nil -- no longer needed, we played it once
                            end
                            if CA.SV.QuestObjUpdateAlert then
                                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, conditionText)
                            end
                        end
                    end
                end
                -- We send soundOverride = true from OnQuestAdded in order to stop the sound from spamming if CSA isn't on and a quest is accepted.
                if not CA.SV.QuestObjUpdateCSA and not soundOverride then
                    PlaySound(SOUNDS.QUEST_OBJECTIVE_STARTED)
                end
            end
        end
    end

    local function OnQuestAdded(eventId, questIndex)
        OnQuestAdvanced(EVENT_QUEST_ADVANCED, questIndex, nil, nil, nil, true, true)
    end
    
    local function DiscoveryExperienceHook(subzoneName, level, previousExperience, currentExperience, championPoints)
    
        EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
        CA.PrintBufferedXP()
        
        if CA.SV.QuestLocDiscoveryCA then
            local nameFormatted = (strformat("|c<<1>><<2>>|r", QuestColorLocNameColorize, subzoneName))
            local formattedString = strformat(SI_LUIE_CA_QUEST_DISCOVER, nameFormatted)
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end
        
        if CA.SV.QuestLocDiscoveryCSA and not INTERACT_WINDOW:IsShowingInteraction() then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.OBJECTIVE_DISCOVERED)
            if currentExperience > previousExperience then
                if not LUIE.SV.HideXPBar then
                    messageParams:SetBarParams(GetRelevantBarParams(level, previousExperience, currentExperience, championPoints))
                end
            end
            messageParams:SetText(zo_strformat(SI_LUIE_CA_QUEST_DISCOVER, subzoneName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISCOVERY_EXPERIENCE)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.QuestLocDiscoveryAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_QUEST_DISCOVER, subzoneName))
        end
        
        if not CA.SV.QuestLocDiscoveryCSA then
            PlaySound(SOUNDS.OBJECTIVE_DISCOVERED)
        end
        return true
    end

    local function PoiDiscoveredHook(zoneIndex, poiIndex)
    
        EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
        CA.PrintBufferedXP()
    
        local name, _, startDescription = GetPOIInfo(zoneIndex, poiIndex)
        
        if CA.SV.QuestLocObjectiveCA then
            local formattedString = (strformat("|c<<1>><<2>>:|r |c<<3>><<4>>|r", QuestColorLocNameColorize, name, QuestColorLocDescriptionColorize, startDescription))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "QUEST_POI" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            
        end
        
        if CA.SV.QuestLocObjectiveCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.OBJECTIVE_ACCEPTED)
            messageParams:SetText(zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_DISCOVERED, name), startDescription)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_POI_DISCOVERED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.QuestLocObjectiveAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_NOTIFYTEXT_OBJECTIVE_DISCOVERED, name), startDescription)
        end
        return true
    end
    
    local XP_GAIN_SHOW_REASONS =
    {
        [PROGRESS_REASON_PVP_EMPEROR] = true,
        [PROGRESS_REASON_DUNGEON_CHALLENGE] = true,
        [PROGRESS_REASON_OVERLAND_BOSS_KILL] = true,
        [PROGRESS_REASON_SCRIPTED_EVENT] = true,
        [PROGRESS_REASON_LOCK_PICK] = true,
        [PROGRESS_REASON_LFG_REWARD] = true,
    }

    local XP_GAIN_SHOW_SOUNDS =
    {
        [PROGRESS_REASON_OVERLAND_BOSS_KILL] = SOUNDS.OVERLAND_BOSS_KILL,
        [PROGRESS_REASON_LOCK_PICK] = SOUNDS.LOCKPICKING_SUCCESS_CELEBRATION,
    }
    
    -- This function is prehooked in order to allow the XP bar popup to be hidden. In addition we shift the sound over 
    local function ExperienceGainHook(reason, level, previousExperience, currentExperience, championPoints)
        
        local sound = XP_GAIN_SHOW_SOUNDS[reason]
        
        if XP_GAIN_SHOW_REASONS[reason] and not LUIE.SV.HideXPBar then
            local barParams = GetRelevantBarParams(level, previousExperience, currentExperience, championPoints)
            if barParams then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_NO_TEXT)
                barParams:SetSound(sound)
                messageParams:SetBarParams(barParams)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_EXPERIENCE_GAIN)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        
        -- We want to play a sound still even if the bar popup is hidden, but the delay needs to remain intact so we add a blank CSA with sound.
        if XP_GAIN_SHOW_REASONS[reason] and LUIE.SV.HideXPBar and sound ~= nil then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetSound(sound)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_EXPERIENCE_GAIN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end

        -- Level up notification
        local levelSize = GetNumExperiencePointsInLevel(level)
        if levelSize ~= nil and currentExperience >= levelSize then
        
            local CurrentLevel = level + 1
            if CA.SV.ExperienceLevelUpCA then
                local icon
                if CA.SV.ExperienceLevelColorByLevel then
                    icon = CA.SV.ExperienceLevelUpIcon and ZO_XP_BAR_GRADIENT_COLORS[2]:Colorize(" " .. zo_iconFormatInheritColor("LuiExtended/media/unitframes/unitframes_level_normal.dds", 16, 16)) or ""
                else
                    icon = CA.SV.ExperienceLevelUpIcon and (" " .. zo_iconFormat("LuiExtended/media/unitframes/unitframes_level_normal.dds", 16, 16)) or ""
                end
                
                local CurrentLevelFormatted = ""
                if CA.SV.ExperienceLevelColorByLevel then
                    CurrentLevelFormatted = ZO_XP_BAR_GRADIENT_COLORS[2]:Colorize(GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL) .. " " .. CurrentLevel)
                else
                    CurrentLevelFormatted = ExperienceLevelUpColorize:Colorize(GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL) .. " " .. CurrentLevel)
                end

                local formattedString
                if CA.SV.ExperienceLevelColorByLevel then
                    formattedString = strformat("<<1>><<2>> <<3>><<4>>", ExperienceLevelUpColorize:Colorize(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP)), icon, CurrentLevelFormatted, ExperienceLevelUpColorize:Colorize("!"))
                else
                    formattedString = strformat("<<1>><<2>> <<3>><<4>>", ExperienceLevelUpColorize:Colorize(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP)), icon, CurrentLevelFormatted, ExperienceLevelUpColorize:Colorize("!"))
                end
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
        
            if CA.SV.ExperienceLevelUpCSA then
                local iconCSA = (" " .. zo_iconFormat("LuiExtended/media/unitframes/unitframes_level_up.dds", "100%", "100%")) or ""
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.LEVEL_UP)
                if CA.SV.ExperienceLevelUpCSAExpand then
                    local levelUpExpanded = zo_strformat("<<1>><<2>> <<3>> <<4>>", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), iconCSA, GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL), CurrentLevel)
                    messageParams:SetText(zo_strformat(SI_LEVEL_UP_NOTIFICATION), levelUpExpanded)
                else
                    messageParams:SetText(GetString(SI_LEVEL_UP_NOTIFICATION))
                end
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LEVEL_GAIN)
                if not LUIE.SV.HideXPBar then
                    local barParams = CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_XP, level + 1, currentExperience - levelSize, currentExperience - levelSize)
                    barParams:SetShowNoGain(true)
                    messageParams:SetBarParams(barParams)
                end
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.ExperienceLevelUpAlert then
                local iconAlert = CA.SV.ExperienceLevelUpIcon and (" " .. zo_iconFormat("LuiExtended/media/unitframes/unitframes_level_up.dds", "75%", "75%")) or ""
                local text = zo_strformat("<<1>><<2>> <<3>> <<4>>!", GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP), iconAlert, GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL), CurrentLevel)
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
            end
            
            -- Play Sound even if CSA is disabled
            if not CA.SV.ExperienceLevelUpCSA then
                PlaySound(SOUNDS.LEVEL_UP)
            end
            
        end
        
        return true
    end
    
    local function EnlightenGainHook()
        
        if IsEnlightenedAvailableForCharacter() then
        
            formattedString = strformat("<<1>>! <<2>>", GetString(SI_ENLIGHTENED_STATE_GAINED_HEADER), GetString(SI_ENLIGHTENED_STATE_GAINED_DESCRIPTION))
            
            if CA.SV.ExperienceEnlightenedCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
            
            if CA.SV.ExperienceEnlightenedCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ENLIGHTENED_STATE_GAINED)
                messageParams:SetText(zo_strformat(SI_ENLIGHTENED_STATE_GAINED_HEADER), zo_strformat(SI_ENLIGHTENED_STATE_GAINED_DESCRIPTION))
                if not LUIE.SV.HideXPBar then
                    local barParams = GetCurrentChampionPointsBarParams()
                    messageParams:SetBarParams(barParams)
                end
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ENLIGHTENMENT_GAINED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.ExperienceEnlightenedAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
            end
            
            if not CA.SV.ExperienceEnlightenedCSA then
                PlaySound(SOUNDS.ENLIGHTENED_STATE_GAINED)
            end
        end
        
        return true
    end

    local function EnlightenLossHook()
        
        if IsEnlightenedAvailableForCharacter() then
        
            formattedString = strformat("<<1>>!", GetString(SI_ENLIGHTENED_STATE_LOST_HEADER))
            
            if CA.SV.ExperienceEnlightenedCA then
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
        
            if CA.SV.ExperienceEnlightenedCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ENLIGHTENED_STATE_LOST)
                if not LUIE.SV.HideXPBar then
                    messageParams:SetBarParams(GetCurrentChampionPointsBarParams())
                end
                messageParams:SetText(zo_strformat(SI_ENLIGHTENED_STATE_LOST_HEADER))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ENLIGHTENMENT_LOST)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.ExperienceEnlightenedAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, formattedString)
            end
                
            if not CA.SV.ExperienceEnlightenedCSA then
                PlaySound(SOUNDS.ENLIGHTENED_STATE_LOST)
            end
            
        end
        
        return true
    end
    
    local firstActivation = true
    local function PlayerActivatedHook()
        if firstActivation then
            firstActivation = false

            if IsEnlightenedAvailableForCharacter() and GetEnlightenedPool() > 0 then
                EnlightenGainHook()
            end
        end
        return true
    end
    
    -- Note: This function is effected by a throttle in centerscreenannouncehandlers, we resolve any message that needs to be throttled in this function.
    local function RidingSkillImprovementHook(ridingSkill, previous, current, source)
       
        if source == RIDING_TRAIN_SOURCE_ITEM then 
            if CA.SV.StorageRidingCA then
            
                -- TODO: if ca.sv.loot or whatever
                    local icon
                    local bookString
                    local value = current - previous
                    local learnString = GetString(SI_LUIE_CA_STORAGE_LEARN)
                    
                    if ridingSkill == 1 then
                        if CA.SV.BracketOptionItem == 1 then
                            bookString = "|H0:item:64700:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        else
                            bookString = "|H1:item:64700:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        end
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_speed.dds|t "
                    elseif ridingSkill == 2 then
                        if CA.SV.BracketOptionItem == 1 then
                            bookString = "|H0:item:64702:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        else
                            bookString = "|H1:item:64702:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        end
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_capacity.dds|t "
                    elseif ridingSkill == 3 then
                        if CA.SV.BracketOptionItem == 1 then
                            bookString = "|H0:item:64701:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        else
                            bookString = "|H1:item:64701:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        end
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_stamina.dds|t "
                    end
                    
                    local messageP1 = CA.SV.LootIcons and (icon .. bookString) or (bookString)
                    local finalMessage = strfmt(StorageRidingBookColorize:Colorize(learnString), messageP1) .. ZO_SELECTED_TEXT:Colorize(" x" .. value)
                
                    
                    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "STORAGE" }
                    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                -----
            
                local formattedString = StorageRidingColorize:Colorize(zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "STORAGE" }
                g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
            end
        
            if CA.SV.StorageRidingCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_RIDING_SKILL_ANNOUCEMENT_BANNER), zo_strformat(SI_RIDING_SKILL_ANNOUCEMENT_SKILL_INCREASE, GetString("SI_RIDINGTRAINTYPE", ridingSkill), previous, current))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RIDING_SKILL_IMPROVEMENT)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end

        return true
    end
    
    local function InventoryBagCapacityHook(previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
        if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
            if CA.SV.StorageBagCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_INVENTORY_BAG_UPGRADE_ANOUNCEMENT_TITLE), zo_strformat(SI_INVENTORY_BAG_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_BAG_CAPACITY_CHANGED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        return true
    end

    local function InventoryBankCapacityHook(previousCapacity, currentCapacity, previousUpgrade, currentUpgrade)
        if previousCapacity > 0 and previousCapacity ~= currentCapacity and previousUpgrade ~= currentUpgrade then
            if CA.SV.StorageBagCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                messageParams:SetText(GetString(SI_INVENTORY_BANK_UPGRADE_ANOUNCEMENT_TITLE), zo_strformat(SI_INVENTORY_BANK_UPGRADE_ANOUNCEMENT_DESCRIPTION, previousCapacity, currentCapacity))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_BANK_CAPACITY_CHANGED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        return true
    end
    
    local function ChampionLevelAchievedHook(wasChampionSystemUnlocked)
    
        local icon = GetChampionPointsIcon()
        
        if CA.SV.ExperienceLevelUpCA then
            local formattedIcon = CA.SV.ExperienceLevelUpIcon and zo_strformat("<<1>> ", zo_iconFormatInheritColor(icon, 16, 16)) or ""
            local formattedString = ExperienceLevelUpColorize:Colorize(zo_strformat("<<1>>!", GetString(SI_CHAMPION_ANNOUNCEMENT_UNLOCKED), formattedIcon))
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end
        
        if CA.SV.ExperienceLevelUpCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.CHAMPION_POINT_GAINED)
            local formattedIcon = zo_strformat("<<1>> ", zo_iconFormat(icon, "100%", "100%"))
            messageParams:SetText(zo_strformat(SI_CHAMPION_ANNOUNCEMENT_UNLOCKED, formattedIcon))
            if not LUIE.SV.HideXPBar then
                if wasChampionSystemUnlocked then
                    local championPoints = GetPlayerChampionPointsEarned()
                    local currentChampionXP = GetPlayerChampionXP()
                    if not LUIE.SV.HideXPBar then
                        local barParams = CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, championPoints, currentChampionXP, currentChampionXP)
                        barParams:SetShowNoGain(true)
                        messageParams:SetBarParams(barParams)
                    end
                else
                    local totalChampionPoints = GetPlayerChampionPointsEarned()
                    local championXPGained = 0;
                    for i = 0, (totalChampionPoints - 1) do
                        championXPGained = championXPGained + GetNumChampionXPInChampionPoint(i)
                    end
                    if not LUIE.SV.HideXPBar then
                        messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, 0, 0, championXPGained))
                    end
                    messageParams:SetLifespanMS(12000)
                end
            end
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_CHAMPION_LEVEL_ACHIEVED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.ExperienceLevelUpAlert then
            local formattedIcon = CA.SV.ExperienceLevelUpIcon and zo_strformat("<<1>> ", zo_iconFormat(icon, "75%", "75%")) or ""
            local text = zo_strformat("<<1>>!", GetString(SI_CHAMPION_ANNOUNCEMENT_UNLOCKED, formattedIcon))
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
        
        if not CA.SV.ExperienceLevelUpCSA then
            PlaySound(SOUNDS.CHAMPION_POINT_GAINED)
        end
        
        return true
    end

    local function ChampionPointGainedHook(pointDelta)
        -- adding one so that we are starting from the first gained point instead of the starting champion points
        local endingPoints = GetPlayerChampionPointsEarned()
        local startingPoints = endingPoints - pointDelta + 1
        local championPointsByType = { 0, 0, 0 }

        while startingPoints <= endingPoints do
            local pointType = GetChampionPointAttributeForRank(startingPoints)
            championPointsByType[pointType] = championPointsByType[pointType] + 1
            startingPoints = startingPoints + 1
        end
        
        if CA.SV.ExperienceLevelUpCA then
            local formattedString = ExperienceLevelUpColorize:Colorize(zo_strformat(SI_CHAMPION_POINT_EARNED, pointDelta) .. ": ")
            g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
            g_queuedMessagesCounter = g_queuedMessagesCounter + 1
            EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        end

        local secondLine = ""
        if CA.SV.ExperienceLevelUpCA or CA.SV.ExperienceLevelUpCSA then
            for pointType,amount in pairs(championPointsByType) do
                if amount > 0 then
                    local icon = GetChampionPointAttributeHUDIcon(pointType)
                    local formattedIcon = CA.SV.ExperienceLevelUpIcon and strformat(" <<1>>", zo_iconFormat(icon, 16, 16)) or ""
                    local constellationGroupName = ZO_Champion_GetUnformattedConstellationGroupNameFromAttribute(pointType)
                    if CA.SV.ExperienceLevelColorByLevel then
                        formattedString = ZO_CP_BAR_GRADIENT_COLORS[pointType][2]:Colorize(strformat(SI_LUIE_CHAMPION_POINT_TYPE, amount, formattedIcon, constellationGroupName))
                    else
                        formattedString = ExperienceLevelUpColorize:Colorize(strformat(SI_LUIE_CHAMPION_POINT_TYPE, amount, formattedIcon, constellationGroupName))
                    end
                    if CA.SV.ExperienceLevelUpCA then
                        g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
                        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
                        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
                    end
                    if CA.SV.ExperienceLevelUpCSA then
                        secondLine = secondLine .. zo_strformat(SI_CHAMPION_POINT_TYPE, amount, icon, constellationGroupName) .. "\n"
                    end
                end
            end
        end
        
        if CA.SV.ExperienceLevelUpCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.CHAMPION_POINT_GAINED)
            messageParams:SetText(zo_strformat(SI_CHAMPION_POINT_EARNED, pointDelta), secondLine)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_CHAMPION_POINT_GAINED)
            messageParams:MarkSuppressIconFrame()
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.ExperienceLevelUpAlert then
            local text = zo_strformat("<<1>>!", GetString(SI_CHAMPION_POINT_EARNED, pointDelta))
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
        
        if not CA.SV.ExperienceLevelUpCSA then
            PlaySound(SOUNDS.CHAMPION_POINT_GAINED)
        end
        
        return true

            
    end
    
    -- Extra Functions for EVENT_DUEL_NEAR_BOUNDARY
    local DUEL_BOUNDARY_WARNING_LIFESPAN_MS = 2000
    local DUEL_BOUNDARY_WARNING_UPDATE_TIME_MS = 2100
    local lastEventTime = 0
    local function CheckBoundary()
        if IsNearDuelBoundary() then
            -- Display CA
            if CA.SV.DuelBoundaryCA then
                printToChat(GetString(SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA))
            end
        
            -- Display CSA
            if CA.SV.DuelBoundaryCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.DUEL_BOUNDARY_WARNING)
                messageParams:SetText(GetString(SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA))
                messageParams:SetLifespanMS(DUEL_BOUNDARY_WARNING_LIFESPAN_MS)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DUEL_NEAR_BOUNDARY)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            -- Display Alert
            if CA.SV.DuelBoundaryAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, (GetString(SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA)))
            end
            
            -- Play Sound if CSA if off
            if not CA.SV.DuelBoundaryCSA then
                PlaySound(SOUNDS.DUEL_BOUNDARY_WARNING)
            end
        end
    end

    -- EVENT_DUEL_NEAR_BOUNDARY -- CSA HANDLER
    local function DuelNearBoundaryHook(isInWarningArea)
        if isInWarningArea then
            local nowEventTime = GetFrameTimeMilliseconds()
            EVENT_MANAGER:RegisterForUpdate("EVENT_DUEL_NEAR_BOUNDARY_LUIE", DUEL_BOUNDARY_WARNING_UPDATE_TIME_MS, CheckBoundary)
            if nowEventTime > lastEventTime + DUEL_BOUNDARY_WARNING_UPDATE_TIME_MS then
                lastEventTime = nowEventTime
                CheckBoundary()
            end
        else
            EVENT_MANAGER:UnregisterForUpdate("EVENT_DUEL_NEAR_BOUNDARY_LUIE")
        end
        return true
    end    
    
    -- EVENT_DUEL_FINISHED -- CSA HANDLER
    local function DuelFinishedHook(result, wasLocalPlayersResult, opponentCharacterName, opponentDisplayName)
        
        -- Setup result format, name, and result sound
        local resultString = wasLocalPlayersResult and GetString("SI_LUIE_CA_DUEL_SELF_RESULT", result) or GetString("SI_LUIE_CA_DUEL_RESULT", result)

        local localPlayerWonDuel = (result == DUEL_RESULT_WON and wasLocalPlayersResult) or (result == DUEL_RESULT_FORFEIT and not wasLocalPlayersResult)
        local localPlayerForfeitDuel = (result == DUEL_RESULT_FORFEIT and wasLocalPlayersResult)
        local resultSound = nil
        if localPlayerWonDuel then
            resultSound = SOUNDS.DUEL_WON
        elseif localPlayerForfeitDuel then
            resultSound = SOUNDS.DUEL_FORFEIT
        end
        
        -- Display CA
        if CA.SV.DuelWonCA then
            local finalName = CA.ResolveNameLink(opponentCharacterName, opponentDisplayName)
            local resultChatString
            if wasLocalPlayersResult then
                resultChatString = resultString
            else
                resultChatString = zo_strformat(resultString, finalName)
            end
            printToChat(resultChatString)
        end
        
        if CA.SV.DuelWonCSA or CA.SV.DuelWonAlert then
            -- Setup String for CSA/Alert
            local finalAlertName = CA.ResolveNameNoLink(opponentCharacterName, opponentDisplayName)
            local resultCSAString
            if wasLocalPlayersResult then
                resultCSAString = resultString
            else
                resultCSAString = zo_strformat(resultString, finalAlertName)
            end
                
            -- Display CSA
            if CA.SV.DuelWonCSA then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, resultSound)
                messageParams:SetText(resultCSAString)
                messageParams:MarkShowImmediately()
                messageParams:MarkQueueImmediately()
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DUEL_FINISHED)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            -- Display Alert
            if CA.SV.DuelWonAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, resultCSAString)
            end
        end
        
        -- Play sound if CSA is not enabled
        if not CA.SV.DuelWonCSA then
            PlaySound(resultSound)
        end      
        return true

    end

    -- EVENT_DUEL_COUNTDOWN -- CSA HANDLER
    local function DuelCountdownHook(startTimeMS)
        -- Display CSA
        if CA.SV.DuelStartCSA then
            local displayTime = startTimeMS - GetFrameTimeMilliseconds()
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_COUNTDOWN_TEXT, SOUNDS.DUEL_START)
            messageParams:SetLifespanMS(displayTime)
            messageParams:SetIconData("EsoUI/Art/HUD/HUD_Countdown_Badge_Dueling.dds")
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
        end
        return true
    end
    
    -- EVENT_RAID_TRIAL_STARTED -- CSA HANDLER
    local function RaidStartedHook(raidName, isWeekly)
    
        -- Display CA
        if CA.SV.GroupRaidCA then
            local formattedName = strformat("|cFEFEFE<<1>>|r", raidName)
            printToChat(strformat(SI_LUIE_CA_GROUP_TRIAL_STARTED, formattedName))
        end
        
        -- Display CSA
        if CA.SV.GroupRaidCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.RAID_TRIAL_STARTED)
            messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_STARTED, raidName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        -- Display Alert
        if CA.SV.GroupRaidAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUP_TRIAL_STARTED, raidName) )
        end
        
        -- Play sound if CSA is not enabled
        if not CA.SV.GroupRaidCSA then
            PlaySound(SOUNDS.RAID_TRIAL_STARTED)
        end
        return true
    end

    local TRIAL_COMPLETE_LIFESPAN_MS = 10000
    -- EVENT_RAID_TRIAL_COMPLETE -- CSA HANDLER
    local function RaidCompleteHook(raidName, score, totalTime)
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_RAID_COMPLETE_TEXT, SOUNDS.RAID_TRIAL_COMPLETED)
        local wasUnderTargetTime = GetRaidDuration() <= GetRaidTargetTime()
        local formattedTime = ZO_FormatTimeMilliseconds(totalTime, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_SECONDS)
        local vitalityBonus = GetCurrentRaidLifeScoreBonus()
        local currentCount = GetRaidReviveCountersRemaining()
        local maxCount = GetCurrentRaidStartingReviveCounters()
        
        -- Display CA
        if CA.SV.GroupRaidCA then
            local formattedName = strformat("|cFEFEFE<<1>>|r", raidName)
            local VitalityCounterString = strformat("<<1>> <<2>>/<<3>>", zo_iconFormatInheritColor("esoui/art/trials/vitalitydepletion.dds", 16, 16), currentCount, maxCount )
            local FinalScore = ZO_DEFAULT_ENABLED_COLOR:Colorize(score)
            vitalityBonus = ZO_DEFAULT_ENABLED_COLOR:Colorize(vitalityBonus)
            if currentCount == 0 then
                VitalityCounterString = ZO_DISABLED_TEXT:Colorize(VitalityCounterString)
            else
                VitalityCounterString = ZO_DEFAULT_ENABLED_COLOR:Colorize(VitalityCounterString)
            end
            if wasUnderTargetTime then
                formattedTime = ZO_DEFAULT_ENABLED_COLOR:Colorize(formattedtime)
            else
                formattedTime = ZO_ERROR_COLOR:Colorize(formattedtime)
            end
            
            printToChat(strformat(SI_LUIE_CA_GROUP_TRIAL_COMPLETED_LARGE, formattedName))
            printToChat(strformat(SI_LUIE_CA_GROUP_TRIAL_SCORETALLY, FinalScore, formattedTime, vitalityBonus, VitalityCounterString))
        end

        -- Display CSA
        if CA.SV.GroupRaidCSA then
            messageParams:SetEndOfRaidData({ score, formattedTime, wasUnderTargetTime, vitalityBonus, zo_strformat(SI_REVIVE_COUNTER_REVIVES_USED, currentCount, maxCount) })
            messageParams:SetText(zo_strformat(SI_TRIAL_COMPLETED_LARGE, raidName))
            messageParams:SetLifespanMS(TRIAL_COMPLETE_LIFESPAN_MS)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        -- Display Alert
        if CA.SV.GroupRaidAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_TRIAL_COMPLETED_LARGE, raidName) )
        end
        
        -- Play sound if CSA is not enabled
        if not CA.SV.GroupRaidCSA then
            PlaySound(SOUNDS.RAID_TRIAL_COMPLETE)
        end
        return true
    end

    -- EVENT_RAID_TRIAL_FAILED -- CSA HANDLER
    local function RaidFailedHook(raidName, score)
    
        -- Display CA
        if CA.SV.GroupRaidCA then
            local formattedName = strformat("|cFEFEFE<<1>>|r", trialName)
            printToChat(strformat(SI_LUIE_CA_GROUP_TRIAL_FAILED, formattedName))
        end
        
        -- Display CSA
        if CA.SV.GroupRaidCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.RAID_TRIAL_FAILED)
            messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_FAILED, raidName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        -- Display Alert
        if CA.SV.GroupRaidAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GROUP_TRIAL_FAILED, raidName) )
        end
        
        -- Play sound if CSA is not enabled
        if not CA.SV.GroupRaidCSA then
            PlaySound(SOUNDS.RAID_TRIAL_FAILED)
        end
        return true
    end

    -- EVENT_RAID_TRIAL_NEW_BEST_SCORE -- CSA HANDLER
    local function RaidBestScoreHook(raidName, score, isWeekly)
    
        -- Display CA
        if CA.SV.GroupRaidBestScoreCA then
            local formattedName = strformat("|cFEFEFE<<1>>|r", trialName)
            local formattedString = isWeekly and strformat(SI_TRIAL_NEW_BEST_SCORE_WEEKLY, formattedName) or strformat(SI_TRIAL_NEW_BEST_SCORE_LIFETIME, formattedName)
            printToChat(formattedString)
        end
        
        -- Display CSA
        if CA.SV.GroupRaidBestScoreCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.RAID_TRIAL_NEW_BEST)
            messageParams:SetText(zo_strformat(isWeekly and SI_TRIAL_NEW_BEST_SCORE_WEEKLY or SI_TRIAL_NEW_BEST_SCORE_LIFETIME, raidName))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        -- Display Alert
        if CA.SV.GroupRaidBestScoreAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(isWeekly and SI_TRIAL_NEW_BEST_SCORE_WEEKLY or SI_TRIAL_NEW_BEST_SCORE_LIFETIME, raidName) )
        end
        
        -- Play sound ONLY if normal score is not set to display, otherwise the audio will overlap
        if not CA.SV.GroupRaidBestScoreCSA and not (CA.SV.GroupRaidScoreCA and CA.SV.GroupRaidScoreCSA and CA.SV.GroupRaidScoreAlert) then
            PlaySound(SOUNDS.RAID_TRIAL_NEW_BEST)
        end
        return true
    end

    -- EVENT_RAID_REVIVE_COUNTER_UPDATE -- CSA HANDLER
    local function RaidReviveCounterHook(currentCount, countDelta)
        if not IsRaidInProgress() then
            return
        end
        if countDelta < 0 then
            if CA.SV.GroupRaidReviveCA then
                local iconCA = zo_iconFormat("EsoUI/Art/Trials/VitalityDepletion.dds", 16, 16)
                printToChat(strformat(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED, iconCA))
            end
            
            if CA.SV.GroupRaidReviveCSA then
                local iconCSA = zo_iconFormat("EsoUI/Art/Trials/VitalityDepletion.dds", "100%", "100%")
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.RAID_TRIAL_COUNTER_UPDATE)
                messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED, iconCSA))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            if CA.SV.GroupRaidReviveAlert then
                local iconAlert = zo_iconFormat("EsoUI/Art/Trials/VitalityDepletion.dds", "75%", "75%")
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED, iconAlert) )
            end
            
            -- Play Sound if CSA is not enabled
            if not CA.SV.GroupRaidReviveCSA then
                PlaySound(SOUNDS.RAID_TRIAL_COUNTER_UPDATE)
            end
        end
        return true
    end

    local TRIAL_SCORE_REASON_TO_ASSETS =
    {
        [RAID_POINT_REASON_KILL_MINIBOSS]           = { icon = "EsoUI/Art/Trials/trialPoints_normal.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_NORMAL },
        [RAID_POINT_REASON_KILL_BOSS]               = { icon = "EsoUI/Art/Trials/trialPoints_veryHigh.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_HIGH },

        [RAID_POINT_REASON_BONUS_ACTIVITY_LOW]      = { icon = "EsoUI/Art/Trials/trialPoints_veryLow.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_LOW },
        [RAID_POINT_REASON_BONUS_ACTIVITY_MEDIUM]   = { icon = "EsoUI/Art/Trials/trialPoints_low.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_LOW },
        [RAID_POINT_REASON_BONUS_ACTIVITY_HIGH]     = { icon = "EsoUI/Art/Trials/trialPoints_high.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_HIGH },

        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_ONE]   = { icon = "EsoUI/Art/Trials/trialPoints_veryLow.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_LOW },
        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_TWO]   = { icon = "EsoUI/Art/Trials/trialPoints_low.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_LOW },
        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_THREE] = { icon = "EsoUI/Art/Trials/trialPoints_normal.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_NORMAL },
        [RAID_POINT_REASON_SOLO_ARENA_PICKUP_FOUR]  = { icon = "EsoUI/Art/Trials/trialPoints_high.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_HIGH },
        [RAID_POINT_REASON_SOLO_ARENA_COMPLETE]     = { icon = "EsoUI/Art/Trials/trialPoints_veryHigh.dds", soundId = SOUNDS.RAID_TRIAL_SCORE_ADDED_VERY_HIGH },
    }

    -- EVENT_RAID_TRIAL_SCORE_UPDATE -- CSA HANDLER
    local function RaidScoreUpdateHook(scoreUpdateReason, scoreAmount, totalScore)
        local reasonAssets = TRIAL_SCORE_REASON_TO_ASSETS[scoreUpdateReason]
        
        if reasonAssets then
        
            -- Display CA
            if CA.SV.GroupRaidScoreCA then
                local iconCA = zo_iconFormat(reasonAssets.icon, 16, 16)
                printToChat(strformat(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED, iconCA, scoreAmount))
            end
            
            -- Display CSA
            if CA.SV.GroupRaidScoreCSA then
                local iconCSA = zo_iconFormat(reasonAssets.icon, "100%", "100%")
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, reasonAssets.soundId)
                messageParams:SetText(zo_strformat(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED, iconCSA, scoreAmount))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_RAID_TRIAL)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            
            -- Display Alert
            if CA.SV.GroupRaidScoreAlert then
                local iconAlert = zo_iconFormat(reasonAssets.icon, "75%", "75%")
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED, iconAlert, scoreAmount) )
            end
            
            -- Play Sound if CSA is not enabled
            if not CA.SV.GroupRaidScoreCSA then
                PlaySound(reasonAssets.soundId)
            end 
        end
        return true
    end

    -- EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE -- CSA HANDLER
    local function ActivityFinderCompleteHook()
    
        local message = GetString(SI_ACTIVITY_FINDER_ACTIVITY_COMPLETE_ANNOUNCEMENT_TEXT)
        if CA.SV.GroupLFGCompleteCA then
            printToChat(message)
        end
        
        if CA.SV.GroupLFGCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.LFG_COMPLETE_ANNOUNCEMENT)
            messageParams:SetText(message)
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ACTIVITY_COMPLETE)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        
        if CA.SV.GroupLFGCompleteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
        
        if not CA.SV.GroupLFGCompleteCSA then
            PlaySound(SOUNDS.LFG_COMPLETE_ANNOUNCEMENT)
        end
        
        return true
    end
    
    local overrideDisplayAnnouncementTitle = {
    
    [GetString(SI_SKILLS_FORCE_RESPEC_TITLE)] = { ca = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_SKILLS) .. ".", csa = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_SKILLS), announceType = "RESPEC" },
    [GetString(SI_ATTRIBUTE_FORCE_RESPEC_TITLE)] = { ca = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_ATTRIBUTES) .. ".", csa = GetString(SI_LUIE_CA_CURRENCY_NOTIFY_ATTRIBUTES), announceType = "RESPEC" },
    [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_D)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_D), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_C), announceType = "GROUPAREA" },
    }
    
    local overrideDisplayAnnouncementDescription = {
        [GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_D)] = { ca = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_D), csa = GetString(SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_C), announceType = "GROUPAREA" },
    }
    
    -- EVENT_DISPLAY_ANNOUNCEMENT -- CSA HANDLER
    local function DisplayAnnouncementHook(title, description)
        
        -- TEMPORARY DEBUG
        if (title ~= "" and not overrideDisplayAnnouncementTitle[title]) or (description ~= "" and not overrideDisplayAnnouncementDescription[description]) then
            d("EVENT_DISPLAY_ANNOUNCEMENT")
            d("TEMPORARY: Please let me know where you see this message, and the context or notification ")
        end
        
        local flagCA
        local flagCSA
        local flagAlert
        
        -- Resolve whether flags are true
        -- Temporary double conditional here until we resolve all Display Announcement types
        if (title ~= "" and overrideDisplayAnnouncementTitle[title]) or (description ~= "" and overrideDisplayAnnouncementDescription[description]) then
            local reference
            if title ~= "" and overrideDisplayAnnouncementTitle[title] then reference = overrideDisplayAnnouncementTitle[title].announceType end
            if description ~= "" and overrideDisplayAnnouncementDescription[description] then reference = overrideDisplayAnnouncementDescription[description].announceType end
            if reference == "RESPEC" then
                flagCA = CA.SV.NotificationRespecCA and true or false
                flagCSA = CA.SV.NotificationRespecCSA and true or false
                flagAlert = CA.SV.NotificationRespecAlert and true or false
            elseif reference == "GROUPAREA" then
                flagCA = CA.SV.NotificationGroupAreaCA and true or false
                flagCSA = CA.SV.NotificationGroupAreaCSA and true or false
                flagAlert = CA.SV.NotificationGroupAreaAlert and true or false
            end
        else
            -- Temporary until we gather data on all events - if there are any display announcements in addition to Respec/Group Area Notifications then conditionals will be added to support them, but for now, only display default CSA.
            flagCA = false
            flagCSA = true
            flagAlert = false
        end
        
        local titleCA
        local titleCSA
        local descriptionCA
        local descriptionCSA
        -- Replace message text when needed
        if title ~= "" and overrideDisplayAnnouncementTitle[title] then
            titleCA = overrideDisplayAnnouncementTitle[title].ca
            titleCSA = overrideDisplayAnnouncementTitle[title].csa
        elseif title ~= "" then
            titleCA = title
            titleCSA = title
        end
        
        if description ~= "" and overrideDisplayAnnouncementDescription[description] then
            descriptionCA = overrideDisplayAnnouncementDescription[description].ca
            descriptionCSA = overrideDisplayAnnouncementDescription[description].csa
        elseif description ~= "" then
            descriptionCA = title
            descriptionCSA = title
        end
        
        local messageParams
        local message
        if title ~= "" and description ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        elseif title ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        elseif description ~= "" then
            messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.DISPLAY_ANNOUNCEMENT)
        end
        
        if flagCA then
            if title ~= "" and description ~= "" then
                printToChat(titleCA)
                printToChat(descriptionCA)
            elseif title ~= "" then
                printToChat(titleCA)
            elseif description ~= "" then
                printToChat(descriptionCA)
            end
        end
        
        if flagCSA then
            if messageParams then
                messageParams:SetText(titleCSA, descriptionCSA)
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_DISPLAY_ANNOUNCEMENT)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
        end
        
        if flagAlert then
            if title ~= "" and description ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, titleCA)
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, descriptionCA)
            elseif title ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, titleCA)
            elseif description ~= "" then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, descriptionCA)
            end
        end
        
        if (flagCA or flagAlert) and not flagCSA then
            PlaySound(SOUNDS.DISPLAY_ANNOUNCEMENT)
        end
        
        return true
    end

    -- EVENT BROADCAST -- CSA HANDLER
    local function BroadcastHook(message)
        d("EVENT_BROADCAST")
    
        -- CA
        printToChat(string.format("|cffff00%s|r", message))
    
        -- CSA
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT, SOUNDS.MESSAGE_BROADCAST)
        messageParams:SetText(string.format("|cffff00%s|r", message))
        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_SYSTEM_BROADCAST)
        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        
        -- Alert
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        return true
    end
    
    -- EVENT_ACHIEVEMENT_AWARDED
    local function AchievementAwardedHook(name, points, id, link)
    
        -- Display CSA
        if CA.SV.AchievementCompleteCSA then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ACHIEVEMENT_AWARDED)
            local icon = select(4, GetAchievementInfo(id))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ACHIEVEMENT_AWARDED)
            messageParams:SetText(CA.SV.AchievementCompleteMsg, zo_strformat(name))
            messageParams:SetIconData(icon, "EsoUI/Art/Achievements/achievements_iconBG.dds")
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    
        -- Play sound if CSA is disabled
        if not CA.SV.AchievementCompleteCSA then
            PlaySound(SOUNDS.ACHIEVEMENT_AWARDED)
        end
        
        local topLevelIndex, categoryIndex, achievementIndex = GetCategoryInfoFromAchievementId(id)
        -- Bail out if this achievement comes from unwanted category
        if topLevelIndex == 1 and not CA.SV.AchievementCategory1 then return true end
        if topLevelIndex == 2 and not CA.SV.AchievementCategory2 then return true end
        if topLevelIndex == 3 and not CA.SV.AchievementCategory3 then return true end
        if topLevelIndex == 4 and not CA.SV.AchievementCategory4 then return true end
        if topLevelIndex == 5 and not CA.SV.AchievementCategory5 then return true end
        if topLevelIndex == 6 and not CA.SV.AchievementCategory6 then return true end
        if topLevelIndex == 7 and not CA.SV.AchievementCategory7 then return true end
        if topLevelIndex == 8 and not CA.SV.AchievementCategory8 then return true end
        if topLevelIndex == 9 and not CA.SV.AchievementCategory9 then return true end
        if topLevelIndex == 10 and not CA.SV.AchievementCategory10 then return true end
        if topLevelIndex == 11 and not CA.SV.AchievementCategory11 then return true end
        --if topLevelIndex == 12 and not CA.SV.AchievementCategory12 then return end
    
        if CA.SV.AchievementCompleteCA then
            
            link = strformat(GetAchievementLink(id, linkBrackets[CA.SV.BracketOptionAchievement]))
            local catName = GetAchievementCategoryInfo(topLevelIndex)
            local subcatName = categoryIndex ~= nil and GetAchievementSubCategoryInfo(topLevelIndex, categoryIndex) or "General"
            local _, _, _, icon = GetAchievementInfo(id)
            icon = CA.SV.AchievementIcon and ("|t16:16:" .. icon .. "|t ") or ""
            
            local stringpart1 = AchievementColorize1:Colorize(strfmt("%s%s%s %s%s", bracket1[CA.SV.AchievementBracketOptions], CA.SV.AchievementCompleteMsg, bracket2[CA.SV.AchievementBracketOptions], icon, link))
            
            local stringpart2
            if CA.SV.AchievementCompPercentage then 
                stringpart2 = CA.SV.AchievementColorProgress and strfmt(" %s|c71DE73%s|r%s", AchievementColorize2:Colorize("("), ("100%"), AchievementColorize2:Colorize(")")) or AchievementColorize2:Colorize (" (100%)")
            else
                stringpart2 = ""
            end
            
            local stringpart3
            if CA.SV.AchievementCategory and CA.SV.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(strfmt(" %s%s - %s%s", bracket1[CA.SV.AchievementCatBracketOptions], catName, subcatName, bracket2[CA.SV.AchievementCatBracketOptions]))
            elseif CA.SV.AchievementCategory and not CA.SV.AchievementSubcategory then
                stringpart3 = AchievementColorize2:Colorize(strfmt(" %s%s%s", bracket1[CA.SV.AchievementCatBracketOptions], catName, bracket2[CA.SV.AchievementCatBracketOptions]))
            else
                stringpart3 = ""
            end
            local stringpart4 = ""
            
            -- TODO: Replace with Chat Printer function!!!
            zo_callLater(function() CA.PrintAchievementDetails(stringpart1, stringpart2, stringpart3, stringpart4) end, 100)
        end
        
        -- Display Alert
        if CA.SV.AchievementCompleteAlert then
            local alertMessage = zo_strformat("<<1>>: <<2>>", CA.SV.AchievementCompleteMsg, name)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertMessage)
        end
        
        return true
        
    end
    
    local function PledgeOfMaraHook(result, characterName, displayName)

        -- Display CA (Success or Failure)
        if CA.SV.PledgeOfMaraCA then
            local finalName = CA.ResolveNameLink(characterName, displayName)
            printToChat(strformat(GetString("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT", result), finalName))
        end
        
        if CA.SV.PledgeOfMaraAlert or CA.SV.PledgeOfMaraCSA then
            local finalAlertName = CA.ResolveNameNoLink(characterName, displayName)
        
            -- Display CSA (Success Only)
            if CA.SV.PledgeOfMaraCSA then
                if result == PLEDGE_OF_MARA_RESULT_PLEDGED then
                    local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT)
                    messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_PLEDGE_OF_MARA_RESULT)
                    messageParams:SetText(GetString(SI_RITUAL_OF_MARA_COMPLETION_ANNOUNCE_LARGE), zo_strformat(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT3, finalAlertName))
                    CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
                end
            end
            
            -- Alert (Success or Failure)
            if CA.SV.PledgeOfMaraAlert then
                -- If the menu setting to only display Alert on Failure state is toggled, then do not display an Alert on successful Mara Event
                if result == PLEDGE_OF_MARA_RESULT_PLEDGED and not CA.SV.PledgeOfMaraAlertOnlyFail then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_MARA_PLEDGEOFMARARESULT3, finalAlertName))
                elseif(result ~= PLEDGE_OF_MARA_RESULT_PLEDGED and result ~= PLEDGE_OF_MARA_RESULT_BEGIN_PLEDGE) then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, zo_strformat(GetString("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT", result), finalAlertName))
                end
            end
        end
        
        -- Play alert sound if Alert is disabled (Note: A sound seems to be played from success regardless of the CSA being on/off here)
        if not CA.SV.PledgeOfMaraAlert and (result ~= PLEDGE_OF_MARA_RESULT_PLEDGED and result ~= PLEDGE_OF_MARA_RESULT_BEGIN_PLEDGE) then
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        
        return true
    end

    
    -- Unregister the ZOS events for handling Quest Removal/Advanced/Added to replace with our own functions
    EVENT_MANAGER:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_REMOVED)
    EVENT_MANAGER:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADVANCED)
    EVENT_MANAGER:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADDED)
    EVENT_MANAGER:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_REMOVED, OnQuestRemoved)
    EVENT_MANAGER:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADVANCED, OnQuestAdvanced)
    EVENT_MANAGER:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADDED, OnQuestAdded)
    
    ZO_PreHook(csaHandlers, EVENT_LORE_BOOK_LEARNED_SKILL_EXPERIENCE, LoreBookXPHook)
    
    ZO_PreHook(csaHandlers, EVENT_LORE_COLLECTION_COMPLETED, LoreCollectionHook)
    ZO_PreHook(csaHandlers, EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE, LoreCollectionXPHook)
    
    ZO_PreHook(csaHandlers, EVENT_SKILL_POINTS_CHANGED, SkillPointsChangedHook)
    ZO_PreHook(csaHandlers, EVENT_SKILL_LINE_ADDED, SkillLineAddedHook)
    ZO_PreHook(csaHandlers, EVENT_ABILITY_PROGRESSION_RANK_UPDATE, AbilityProgressionRankHook)
    ZO_PreHook(csaHandlers, EVENT_SKILL_RANK_UPDATE, SkillRankUpdateHook)
    
    ZO_PreHook(csaHandlers, EVENT_SKILL_XP_UPDATE, SkillXPUpdateHook)
    
    ZO_PreHook(csaHandlers, EVENT_QUEST_ADDED, QuestAddedHook)
    ZO_PreHook(csaHandlers, EVENT_QUEST_COMPLETE, QuestCompleteHook)
    ZO_PreHook(csaHandlers, EVENT_OBJECTIVE_COMPLETED, ObjectiveCompletedHook)
    ZO_PreHook(csaHandlers, EVENT_QUEST_CONDITION_COUNTER_CHANGED, ConditionCounterHook)
    ZO_PreHook(csaHandlers, EVENT_QUEST_OPTIONAL_STEP_ADVANCED, OptionalStepHook)
    ZO_PreHook(csaHandlers, EVENT_DISCOVERY_EXPERIENCE, DiscoveryExperienceHook)
    ZO_PreHook(csaHandlers, EVENT_POI_DISCOVERED, PoiDiscoveredHook)
    ZO_PreHook(csaHandlers, EVENT_EXPERIENCE_GAIN, ExperienceGainHook)
    
    ZO_PreHook(csaHandlers, EVENT_ENLIGHTENED_STATE_GAINED, EnlightenGainHook)
    ZO_PreHook(csaHandlers, EVENT_ENLIGHTENED_STATE_LOST, EnlightenLostHook)
    
    ZO_PreHook(csaHandlers, EVENT_PLAYER_ACTIVATED, PlayerActivatedHook)
    
    ZO_PreHook(csaHandlers, EVENT_RIDING_SKILL_IMPROVEMENT, RidingSkillImprovementHook)
    
    ZO_PreHook(csaHandlers, EVENT_INVENTORY_BAG_CAPACITY_CHANGED, InventoryBagCapacityHook)
    ZO_PreHook(csaHandlers, EVENT_INVENTORY_BANK_CAPACITY_CHANGED, InventoryBankCapacityHook)
    
    ZO_PreHook(csaHandlers, EVENT_COLLECTIBLE_UPDATED, CollectibleUnlockedHook)
    ZO_PreHook(csaHandlers, EVENT_COLLECTIBLES_UPDATED, CollectiblesUnlockedHook)
    
    ZO_PreHook(csaHandlers, EVENT_CHAMPION_LEVEL_ACHIEVED, ChampionLevelAchievedHook)
    ZO_PreHook(csaHandlers, EVENT_CHAMPION_POINT_GAINED, ChampionPointGainedHook)
    
    ZO_PreHook(csaHandlers, EVENT_DUEL_NEAR_BOUNDARY, DuelNearBoundaryHook)
    ZO_PreHook(csaHandlers, EVENT_DUEL_FINISHED, DuelFinishedHook)
    ZO_PreHook(csaHandlers, EVENT_DUEL_COUNTDOWN, DuelCountdownHook)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DUEL_STARTED, CA.DuelStarted)
    
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_STARTED, RaidStartedHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_COMPLETE, RaidCompleteHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_FAILED, RaidFailedHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_NEW_BEST_SCORE, RaidBestScoreHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_REVIVE_COUNTER_UPDATE, RaidReviveCounterHook)
    ZO_PreHook(csaHandlers, EVENT_RAID_TRIAL_SCORE_UPDATE, RaidScoreUpdateHook)
    ZO_PreHook(csaHandlers, EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE, ActivityFinderCompleteHook)
    
    ZO_PreHook(csaHandlers, EVENT_DISPLAY_ANNOUNCEMENT, DisplayAnnouncementHook)
    ZO_PreHook(csaHandlers, EVENT_BROADCAST, BroadcastHook)
    
    ZO_PreHook(csaHandlers, EVENT_ACHIEVEMENT_AWARDED, AchievementAwardedHook)
    
    ZO_PreHook(csaHandlers, EVENT_PLEDGE_OF_MARA_RESULT, PledgeOfMaraHook)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLEDGE_OF_MARA_OFFER, CA.MaraOffer)
    
    -- TODO: Allow these to use their default conditions if Saved Variable option for CA is not turned on
    local function GroupTypeChangedChatHook()
        return true
    end
    
    local function GroupInviteChatHook()
        return true
    end
    
    local function GroupMemberLeftChatHook()
        return true
    end
    
    local function SocialErrorHook()
        return true
    end
    
    local function FriendStatusHook()
        return true
    end
    
    local function IgnoreAddedHook()
        return true
    end
    
    local function IgnoreRemovedHook()
        return true
    end
    
    ZO_PreHook(chatHandlers, EVENT_GROUP_TYPE_CHANGED, GroupTypeChangedChatHook)
    ZO_PreHook(chatHandlers, EVENT_GROUP_INVITE_RESPONSE, GroupInviteChatHook)
    ZO_PreHook(chatHandlers, EVENT_GROUP_MEMBER_LEFT, GroupMemberLeftChatHook)
    ZO_PreHook(chatHandlers, EVENT_SOCIAL_ERROR, SocialErrorHook)
    ZO_PreHook(chatHandlers, EVENT_FRIEND_PLAYER_STATUS_CHANGED, FriendStatusHook)
    ZO_PreHook(chatHandlers, EVENT_IGNORE_ADDED, IgnoreAddedHook)
    ZO_PreHook(chatHandlers, EVENT_IGNORE_REMOVED, IgnoreRemovedHook)
    
    -- HOOK PLAYER_TO_PLAYER Group Notifications to edit Ignore alert
    local KEYBOARD_INTERACT_ICONS =
    {
        [SI_PLAYER_TO_PLAYER_WHISPER] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_whisper_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_whisper_over.dds",
            disabledNormal =  "EsoUI/Art/HUD/radialIcon_whisper_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_whisper_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_inviteGroup_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_inviteGroup_over.dds",
            disabledNormal =  "EsoUI/Art/HUD/radialIcon_inviteGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_inviteGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_REMOVE_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_removeFromGroup_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_removeFromGroup_over.dds",
            disabledNormal =  "EsoUI/Art/HUD/radialIcon_removeFromGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_removeFromGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_FRIEND] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_addFriend_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_addFriend_over.dds",
            disabledNormal = "EsoUI/Art/HUD/radialIcon_addFriend_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_addFriend_disabled.dds",
        },
        [SI_CHAT_PLAYER_CONTEXT_REPORT] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_reportPlayer_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_reportPlayer_over.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_DUEL] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_duel_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_duel_over.dds",
            disabledNormal = "EsoUI/Art/HUD/radialIcon_duel_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_duel_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_TRADE] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_trade_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_trade_over.dds",
            disabledNormal = "EsoUI/Art/HUD/radialIcon_trade_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/radialIcon_trade_disabled.dds",
        },
        [SI_RADIAL_MENU_CANCEL_BUTTON] =
        {
            enabledNormal = "EsoUI/Art/HUD/radialIcon_cancel_up.dds",
            enabledSelected = "EsoUI/Art/HUD/radialIcon_cancel_over.dds",
        },
    }

    local GAMEPAD_INTERACT_ICONS =
    {
        [SI_PLAYER_TO_PLAYER_WHISPER] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_down.dds",
            disabledNormal =  "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_whisper_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_down.dds",
            disabledNormal =  "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_inviteGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_REMOVE_GROUP] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_down.dds",
            disabledNormal =  "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_removeFromGroup_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_ADD_FRIEND] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_down.dds",
            disabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_disabled.dds", 
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_addFriend_disabled.dds",
        },
        [SI_CHAT_PLAYER_CONTEXT_REPORT] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_reportPlayer_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_reportPlayer_down.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_DUEL] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_down.dds",
            disabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_duel_disabled.dds",
        },
        [SI_PLAYER_TO_PLAYER_INVITE_TRADE] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_down.dds",
            disabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_disabled.dds",
            disabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_trade_disabled.dds",
        },
        [SI_RADIAL_MENU_CANCEL_BUTTON] =
        {
            enabledNormal = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds",
            enabledSelected = "EsoUI/Art/HUD/Gamepad/gp_radialIcon_cancel_down.dds",
        },
    }
    
    local function AlertIgnored(SendString)
        local alertString = IsConsoleUI() and SI_PLAYER_TO_PLAYER_BLOCKED or SendString
        printToChat(GetString(alertString))
        if CA.SV.GroupAlert then
            ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, alertString)
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
    end

    PLAYER_TO_PLAYER.ShowPlayerInteractMenu = function(self, isIgnored)
        local currentTargetCharacterName = self.currentTargetCharacterName
        local currentTargetCharacterNameRaw = self.currentTargetCharacterNameRaw
        local currentTargetDisplayName = self.currentTargetDisplayName
        local primaryName = ZO_GetPrimaryPlayerName(currentTargetDisplayName, currentTargetCharacterName);
        local primaryNameInternal = ZO_GetPrimaryPlayerName(currentTargetDisplayName, currentTargetCharacterName, USE_INTERNAL_FORMAT);
        local formattedPlayerNames = ZO_GetPrimaryPlayerNameWithSecondary(currentTargetDisplayName, currentTargetCharacterName);
        local platformIcons = IsInGamepadPreferredMode() and GAMEPAD_INTERACT_ICONS or KEYBOARD_INTERACT_ICONS
        local ENABLED = true
        local DISABLED = false
        local ENABLED_IF_NOT_IGNORED = not isIgnored
    
        --Gamecard--
        if IsConsoleUI() then
            self:AddShowGamerCard(currentTargetDisplayName, currentTargetCharacterName)
        end

        --Whisper--
        if IsChatSystemAvailableForCurrentPlatform() then
            local nameToUse = IsConsoleUI() and currentTargetDisplayName or primaryNameInternal
            local function WhisperOption() StartChatInput(nil, CHAT_CHANNEL_WHISPER, nameToUse) end
            local function WhisperIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_WHISPER) end
            local whisperFunction = ENABLED_IF_NOT_IGNORED and WhisperOption or WhisperIgnore
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_WHISPER), platformIcons[SI_PLAYER_TO_PLAYER_WHISPER], ENABLED_IF_NOT_IGNORED, whisperFunction)
        end

        --Group--
        local isGroupModificationAvailable = IsGroupModificationAvailable()
        local groupModicationRequiresVoting = DoesGroupModificationRequireVote()
        local isSoloOrLeader = IsUnitSoloOrGroupLeader("player")

        local function AlertGroupDisabled()
            printToChat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE))
            if CA.SV.GroupAlert then
                ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end
        
        local function AlertGroupKickDisabled()
            printToChat(GetString(SI_LUIE_CA_GROUP_LEADERKICK_ERROR))
            if CA.SV.GroupAlert then
                ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_LEADERKICK_ERROR))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        end

        if IsPlayerInGroup(currentTargetCharacterNameRaw) then
            local groupKickEnabled = isGroupModificationAvailable and isSoloOrLeader and not groupModicationRequiresVoting or IsInLFGGroup()
            local lfgKick = IsInLFGGroup()
            local groupKickFunction = nil
            if groupKickEnabled then
                if lfgKick then
                    groupKickFunction = function() LUIE.SlashVoteKick(currentTargetCharacterName) end
                else
                    groupKickFunction = function() GroupKickByName(currentTargetCharacterNameRaw) end
                end
            else
                groupKickFunction = AlertGroupKickDisabled
            end
            
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_REMOVE_GROUP), platformIcons[SI_PLAYER_TO_PLAYER_REMOVE_GROUP], groupKickEnabled, groupKickFunction)
        else
            local groupInviteEnabled = ENABLED_IF_NOT_IGNORED and isGroupModificationAvailable and isSoloOrLeader
            local groupInviteFunction = nil
            if groupInviteEnabled then
                groupInviteFunction = function()
                    local NOT_SENT_FROM_CHAT = false
                    local DISPLAY_INVITED_MESSAGE = true
                    TryGroupInviteByName(primaryNameInternal, NOT_SENT_FROM_CHAT, DISPLAY_INVITED_MESSAGE, true)
                end
            else
                if ENABLED_IF_NOT_IGNORED then
                    groupInviteFunction = AlertGroupDisabled
                else
                    local function GroupIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_GROUP) end
                    groupInviteFunction = GroupIgnore
                end
            end

            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_ADD_GROUP), platformIcons[SI_PLAYER_TO_PLAYER_ADD_GROUP], groupInviteEnabled, groupInviteFunction)
        end
        
        --Friend--
        if IsFriend(currentTargetCharacterNameRaw) then
            local function AlreadyFriendsWarning()
                printToChat(GetString("SI_SOCIALACTIONRESULT", SOCIAL_RESULT_ACCOUNT_ALREADY_FRIENDS))
                if CA.SV.FriendIgnoreAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_SOCIALACTIONRESULT", SOCIAL_RESULT_ACCOUNT_ALREADY_FRIENDS))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_ADD_FRIEND), platformIcons[SI_PLAYER_TO_PLAYER_ADD_FRIEND], DISABLED, AlreadyFriendsWarning)
        else
            local function RequestFriendOption()
                if IsConsoleUI() then
                    ZO_ShowConsoleAddFriendDialog(currentTargetCharacterName)
                else
                    RequestFriend(currentTargetDisplayName, nil, true)
                end
                local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(currentTargetDisplayName)
                printToChat(strformat(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG_LINK, displayNameLink))
                if CA.SV.FriendIgnoreAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG_LINK, currentTargetDisplayName))
                end
            end
            local function FriendIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_FRIEND) end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_ADD_FRIEND), platformIcons[SI_PLAYER_TO_PLAYER_ADD_FRIEND], ENABLED_IF_NOT_IGNORED, ENABLED_IF_NOT_IGNORED and RequestFriendOption or FriendIgnore)
        end

        --Report--
        local function ReportCallback()
            local nameToReport = IsInGamepadPreferredMode() and currentTargetDisplayName or primaryName
            ZO_HELP_GENERIC_TICKET_SUBMISSION_MANAGER:OpenReportPlayerTicketScene(nameToReport)
        end
        self:AddMenuEntry(GetString(SI_CHAT_PLAYER_CONTEXT_REPORT), platformIcons[SI_CHAT_PLAYER_CONTEXT_REPORT], ENABLED, ReportCallback)
        
        --Duel--
        local duelState, partnerCharacterName, partnerDisplayName = GetDuelInfo()
        if duelState ~= DUEL_STATE_IDLE then
            local function AlreadyDuelingWarning(duelState, characterName, displayName)
                return function()
                    local userFacingPartnerName = ZO_GetPrimaryPlayerNameWithSecondary(displayName, characterName)
                    local statusString = GetString("SI_DUELSTATE", duelState)
                    statusString = zo_strformat(statusString, userFacingPartnerName)
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, statusString)    
                end
            end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_INVITE_DUEL), platformIcons[SI_PLAYER_TO_PLAYER_INVITE_DUEL], DISABLED, AlreadyDuelingWarning(duelState, partnerCharacterName, partnerDisplayName))
        else
            local function DuelInviteOption()
                ChallengeTargetToDuel(currentTargetCharacterName)
            end
            local function DuelIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_DUEL) end
            self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_INVITE_DUEL), platformIcons[SI_PLAYER_TO_PLAYER_INVITE_DUEL], ENABLED_IF_NOT_IGNORED, ENABLED_IF_NOT_IGNORED and DuelInviteOption or DuelIgnore)
        end

        --Trade--
        local function TradeInviteOption() TRADE_WINDOW:InitiateTrade(primaryNameInternal) end
        local function TradeIgnore() AlertIgnored(SI_LUIE_IGNORE_ERROR_TRADE) end
        local tradeInviteFunction = ENABLED_IF_NOT_IGNORED and TradeInviteOption or TradeIgnore
        self:AddMenuEntry(GetString(SI_PLAYER_TO_PLAYER_INVITE_TRADE), platformIcons[SI_PLAYER_TO_PLAYER_INVITE_TRADE], ENABLED_IF_NOT_IGNORED, tradeInviteFunction)

        --Cancel--
        self:AddMenuEntry(GetString(SI_RADIAL_MENU_CANCEL_BUTTON), platformIcons[SI_RADIAL_MENU_CANCEL_BUTTON], ENABLED)

        self:GetRadialMenu():Show()
    end

    --local INTERACT_TYPE_TRADE_INVITE = 3
    local INTERACT_TYPE_GROUP_INVITE = 4
    local INTERACT_TYPE_QUEST_SHARE = 5
    local INTERACT_TYPE_FRIEND_REQUEST = 6
    local INTERACT_TYPE_GUILD_INVITE = 7
    
    local INCOMING_MESSAGE_TEXT = {
        --[INTERACT_TYPE_TRADE_INVITE] = GetString(SI_LUIE_NOTIFICATION_TRADE_INVITE),
        [INTERACT_TYPE_GROUP_INVITE] = GetString(SI_LUIE_NOTIFICATION_GROUP_INVITE),
        [INTERACT_TYPE_QUEST_SHARE] = GetString(SI_LUIE_NOTIFICATION_SHARE_QUEST_INVITE),
        [INTERACT_TYPE_FRIEND_REQUEST] = GetString(SI_LUIE_NOTIFICATION_FRIEND_INVITE),
        [INTERACT_TYPE_GUILD_INVITE] = GetString(SI_LUIE_NOTIFICATION_GUILD_INVITE)
    }
    
    local function DisplayNotificationMessage(message, data)
        local typeString = INCOMING_MESSAGE_TEXT[data.incomingType]
        if typeString then
            -- Group Invite
            if data.incomingType == INTERACT_TYPE_GROUP_INVITE then
                if CA.SV.GroupCA then
                    printToChat(zo_strformat(message, typeString))
                end
                if CA.SV.GroupAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            end
            -- Guild Invite
            if data.incomingType == INTERACT_TYPE_GUILD_INVITE then
                if CA.SV.GuildCA then
                    printToChat(zo_strformat(message, typeString))
                end
                if CA.SV.GuildAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            end
            
            -- Friend Invite
            if data.incomingType == INTERACT_TYPE_FRIEND_REQUEST then
                if CA.SV.FriendIgnoreCA then
                    printToChat(zo_strformat(message, typeString))
                end
                if CA.SV.FriendIgnoreAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            end
            
            -- Quest Shared
            if data.incomingType == INTERACT_TYPE_QUEST_SHARE then
                if CA.SV.QuestShareCA then
                    printToChat(zo_strformat(message, typeString))
                end
                if CA.SV.QuestShareAlert then
                    ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
                end
            end
            
            --[[
            if data.incomingType == INTERACT_TYPE_TRADE_INVITE then
                printToChat(zo_strformat(message, typeString))
                ZO_AlertNoSuppression(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(message, typeString))
            end
            ]]--
        end
       
    end
    
    local function NotificationAccepted(data)
        data.pendingResponse = false
        if data.acceptCallback then
            data.acceptCallback()
            if data.uniqueSounds then
                PlaySound(data.uniqueSounds.accept)
            else
                PlaySound(SOUNDS.DIALOG_ACCEPT)
            end
            DisplayNotificationMessage(GetString(SI_NOTIFICATION_ACCEPTED), data)
        end
    end

    local function NotificationDeclined(data)
        data.pendingResponse = false
        if data.declineCallback then
            data.declineCallback()
            if data.uniqueSounds then
                PlaySound(data.uniqueSounds.decline)
            else
                PlaySound(SOUNDS.DIALOG_DECLINE)
            end
            DisplayNotificationMessage(GetString(SI_NOTIFICATION_DECLINED), data)
        end
    end
    
    PLAYER_TO_PLAYER.Accept = function(self, incomingEntry)
        local index = self:GetIndexFromIncomingQueue(incomingEntry)
        if index then
            self:RemoveEntryFromIncomingQueueTable(index)
            NotificationAccepted(incomingEntry)
        else
            self:OnPromptAccepted()
        end
    end
    
    PLAYER_TO_PLAYER.Decline = function(self, incomingEntry)
        local index = self:GetIndexFromIncomingQueue(incomingEntry)
        if index then
            self:RemoveEntryFromIncomingQueueTable(index)
            NotificationDeclined(incomingEntry)
        else
            self:OnPromptDeclined()
        end
    end
    
    --With proper timing, both of these events can fire in the same frame, making it possible to be responding but having already cleared the incoming queue
    PLAYER_TO_PLAYER.OnPromptAccepted = function(self)
        if(self.responding and #self.incomingQueue > 0) then
            local incomingEntryToRespondTo = self:RemoveEntryFromIncomingQueueTable(1)
            NotificationAccepted(incomingEntryToRespondTo)
        end
    end

    PLAYER_TO_PLAYER.OnPromptDeclined = function(self)
        if(self.responding and #self.incomingQueue > 0) then
            local incomingEntryToRespondTo = self:RemoveEntryFromIncomingQueueTable(1)
            NotificationDeclined(incomingEntryToRespondTo)
        end
    end

end

-- Called by hooked TryGroupInviteByName function
local function CompleteGroupInvite(characterOrDisplayName, sentFromChat, displayInvitedMessage, isMenu)
    local isLeader = IsUnitGroupLeader("player")
    local groupSize = GetGroupSize()
    
    if isLeader and groupSize == SMALL_GROUP_SIZE_THRESHOLD then
        ZO_Dialogs_ShowPlatformDialog("LARGE_GROUP_INVITE_WARNING", characterOrDisplayName, { mainTextParams = { SMALL_GROUP_SIZE_THRESHOLD } })
    else
        GroupInviteByName(characterOrDisplayName)

        ZO_Menu_SetLastCommandWasFromMenu(not sentFromChat)
        if isMenu then
            local link = ZO_LinkHandler_CreateCharacterLink(characterOrDisplayName)
            printToChat(zo_strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MENU), link))
            if CA.SV.GroupAlert then
                ZO_Alert(ALERT, nil, zo_strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MENU), ZO_FormatUserFacingCharacterOrDisplayName(characterOrDisplayName)))
            end
        else
            printToChat(zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_INVITED), ZO_FormatUserFacingCharacterOrDisplayName(characterOrDisplayName)))
            if CA.SV.GroupAlert then
                ZO_Alert(ALERT, nil, zo_strformat(GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_INVITED), ZO_FormatUserFacingCharacterOrDisplayName(characterOrDisplayName)))
            end
        end
    end
end

-- HOOK Group Invite function so we can modify CA/Alert here
TryGroupInviteByName = function(characterOrDisplayName, sentFromChat, displayInvitedMessage, isMenu)
    if IsPlayerInGroup(characterOrDisplayName) then
        printToChat(GetString(SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER))
        if CA.SV.GroupAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, SI_GROUP_ALERT_INVITE_PLAYER_ALREADY_MEMBER)
        end
        PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
        return
    end

    local isLeader = IsUnitGroupLeader("player")
    local groupSize = GetGroupSize()

    if not isLeader and groupSize > 0 then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString("SI_LUIE_CA_GROUPINVITERESPONSE", GROUP_INVITE_RESPONSE_ONLY_LEADER_CAN_INVITE))
        return
    end

    if IsConsoleUI() then
        local displayName = characterOrDisplayName

        local function GroupInviteCallback(success)
            if success then
                CompleteGroupInvite(displayName, sentFromChat, displayInvitedMessage, isMenu)
            end
        end

        ZO_ConsoleAttemptInteractOrError(GroupInviteCallback, displayName, ZO_PLAYER_CONSOLE_INFO_REQUEST_DONT_BLOCK, ZO_CONSOLE_CAN_COMMUNICATE_ERROR_ALERT, ZO_ID_REQUEST_TYPE_DISPLAY_NAME, displayName)
    else
        if IsIgnored(characterOrDisplayName) then
            printToChat(GetString(SI_LUIE_IGNORE_ERROR_GROUP))
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, SI_LUIE_IGNORE_ERROR_GROUP)
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            return
        end

        CompleteGroupInvite(characterOrDisplayName, sentFromChat, displayInvitedMessage, isMenu)
    end    
end

-- Hook for EVENT_GUILD_MEMBER_ADDED
GUILD_ROSTER_MANAGER.OnGuildMemberAdded = function(self, guildId, displayName)
    self:RefreshData()
    
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
    local guildName = GetGuildName(guildId)

    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        
        if guildName == name then
            local guildAlliance = GetGuildAlliance(id)
            local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
            local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
            local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName

            if CA.SV.GuildCA then
                printToChat(strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_ADDED), displayNameLink, guildNameAlliance))
            end
            if CA.SV.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_ADDED), displayName, guildNameAllianceAlert))
            end
            PlaySound(SOUNDS.GUILD_ROSTER_ADDED)
            break
        end
    end
    
end

-- Hook for EVENT_GUILD_MEMBER_REMOVED
GUILD_ROSTER_MANAGER.OnGuildMemberRemoved = function(self, guildId, rawCharacterName, displayName)

    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(displayName)
    local guildName = GetGuildName(guildId)

    local guilds = GetNumGuilds()
    for i = 1,guilds do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        
        if guildName == name then
            local guildAlliance = GetGuildAlliance(id)
            local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
            local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
            local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
            
            if CA.SV.GuildCA then
                printToChat(strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_LEFT), displayNameLink, guildNameAlliance))
            end
            if CA.SV.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_LEFT), displayName, guildNameAllianceAlert))
            end
            PlaySound(SOUNDS.GUILD_ROSTER_REMOVED)
            break
        end
    end
    self:RefreshData()
    
end

-- Hook for Guild Invite function used from Guild Menu
ZO_TryGuildInvite = function(guildId, displayName, sentFromChat)

    if not DoesPlayerHaveGuildPermission(guildId, GUILD_PERMISSION_INVITE) then
        ZO_AlertEvent(EVENT_SOCIAL_ERROR, SOCIAL_RESULT_NO_INVITE_PERMISSION)
        return
    end

    if GetNumGuildMembers(guildId) == MAX_GUILD_MEMBERS then
        ZO_AlertEvent(EVENT_SOCIAL_ERROR, SOCIAL_RESULT_NO_ROOM)
        return
    end

    local guildName = GetGuildName(guildId)
    local guildAlliance = GetGuildAlliance(guildId)
    local guildColor = CA.SV.GuildAllianceColor and GetAllianceColor(guildAlliance) or GuildColorize
    local guildNameAlliance = CA.SV.GuildIcon and guildColor:Colorize(zo_strformat("<<1>> <<2>>", zo_iconFormatInheritColor(GetAllianceBannerIcon(guildAlliance), 16, 16), guildName)) or (guildColor:Colorize(guildName))
    local guildNameAllianceAlert = CA.SV.GuildIcon and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), "100%", "100%", guildName) or guildName
    
    if IsConsoleUI() then
        local function GuildInviteCallback(success)
            if success then
                GuildInvite(guildId, displayName)
                if CA.SV.GuildCA then
                    printToChat(zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, UndecorateDisplayName(displayName), guildNameAlliance))
                end
                if CA.SV.GuildAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, UndecorateDisplayName(displayName), guildNameAllianceAlert))
                end
            end
        end

        ZO_ConsoleAttemptInteractOrError(GuildInviteCallback, displayName, ZO_PLAYER_CONSOLE_INFO_REQUEST_DONT_BLOCK, ZO_CONSOLE_CAN_COMMUNICATE_ERROR_ALERT, ZO_ID_REQUEST_TYPE_DISPLAY_NAME, displayName)
    else
        -- We can't stop the player from inviting players to guild by Character Name if sent from chat so, might as well not block it. This also makes it consistent with group invites. Can't invite from the radial menu but can use the slash command.
        if IsIgnored(displayName) and not sentFromChat then
            if CA.SV.GuildCA then
                printToChat(GetString(SI_LUIE_IGNORE_ERROR_GUILD))
            end
            if CA.SV.GuildAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_IGNORE_ERROR_GUILD))
            end
            PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
            return
        end

        GuildInvite(guildId, displayName)
        if CA.SV.GuildCA then
            printToChat(zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, displayName, guildNameAlliance))
        end
        if CA.SV.GuildAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, zo_strformat(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE, displayName, guildNameAllianceAlert))
        end
    end    
end

-- Called when changing guilds in the Guild tab
GUILD_SHARED_INFO.SetGuildId = function(self, guildId)
    self.guildId = guildId
    self:Refresh(guildId)
    -- Set selected guild for use when resolving Rank/Heraldry updates
    g_selectedGuild = guildId
end

-- Called when changing guilds in the Guild tab or leaving/joining a guild
GUILD_SHARED_INFO.Refresh = function(self, guildId)
    if(self.guildId and self.guildId == guildId) then
        local count = GetControl(self.control, "Count")
        local numGuildMembers, numOnline = GetGuildInfo(guildId)

        count:SetText(zo_strformat(SI_GUILD_NUM_MEMBERS_ONLINE_FORMAT, numOnline, numGuildMembers))

        self.canDepositToBank = DoesGuildHavePrivilege(guildId, GUILD_PRIVILEGE_BANK_DEPOSIT)
        if(self.canDepositToBank) then
            self.bankIcon:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
        else
            self.bankIcon:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
        end

        self.canUseTradingHouse = DoesGuildHavePrivilege(guildId, GUILD_PRIVILEGE_TRADING_HOUSE)
        if(self.canUseTradingHouse) then
            self.tradingHouseIcon:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
        else
            self.tradingHouseIcon:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
        end

        self.canUseHeraldry = DoesGuildHavePrivilege(guildId, GUILD_PRIVILEGE_HERALDRY)
        if(self.canUseHeraldry) then
            self.heraldryIcon:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
        else
            self.heraldryIcon:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
        end
    end
    -- Set selected guild for use when resolving Rank/Heraldry updates
    g_selectedGuild = guildId
end

function CA.TradeInviteAccepted(eventCode)
    if CA.SV.NotificationTradeCA then
        printToChat(GetString(SI_LUIE_CA_TRADE_INVITE_ACCEPTED))
    end
    if CA.SV.NotificationTradeAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_TRADE_INVITE_ACCEPTED))
    end
    
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.LootTrade then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
        g_inventoryStacks = {}
        CA.IndexInventory() -- Index Inventory
    end
    g_inTrade = true
    
end

-- Called on player joining a group to determine if message syntax should show group or LFG group.
function CA.CheckLFGStatusJoin()
    if not g_stopGroupLeaveQueue then
        if not g_lfgDisableGroupEvents then
            if IsInLFGGroup() and not g_joinLFGOverride then
                if CA.SV.GroupCA then
                    printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF_LFG))
                end
                if CA.SV.GroupAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF_LFG))
                end
            elseif not IsInLFGGroup() and not g_joinLFGOverride then
                if CA.SV.GroupCA then
                    printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF))
                end
                if CA.SV.GroupAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF))
                end
            end
        end
        g_joinLFGOverride = false
    end
end

-- Called when another player joins the group.
function CA.PrintJoinStatusNotSelf(SendMessage, SendAlert)
    if not g_stopGroupLeaveQueue then
        if CA.SV.GroupCA then
            printToChat(SendMessage)
        end
        if CA.SV.GroupAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, SendAlert)
        end
    end
end

-- Called on player leaving a group to determine if message syntax should show group or LFG group.
function CA.CheckLFGStatusLeave(WasKicked)
    if not (g_stopGroupLeaveQueue and g_lfgDisableGroupEvents) then
        if not g_leaveLFGOverride then
            if WasKicked then
                if CA.SV.GroupCA then
                    printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED_SELF))
                end
                if CA.SV.GroupAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED_SELF))
                end
            end
            if GetGroupSize() == 0 then
                --printToChat(GetString(SI_LUIE_CA_GROUP_QUIT)) -- TODO: Maybe re-enable later
            end
        elseif g_leaveLFGOverride and GetGroupSize() == 0 then
            if CA.SV.GroupCA then
                printToChat(GetString(SI_LUIE_CA_GROUP_QUIT_LFG))
            end
            if CA.SV.GroupAlert then
                ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_LUIE_CA_GROUP_QUIT_LFG))
            end
        end
    end
    g_leaveLFGOverride = false
end

-- EVENT_GROUP_INVITE_REMOVED
function CA.GroupInviteRemoved(eventCode)
    g_groupJoinFudger = true
end

-- EVENT_GROUP_INVITE_RECEIVED
function CA.OnGroupInviteReceived(eventCode, inviterName, inviterDisplayName)
    g_groupJoinFudger = false
    
    if CA.SV.GroupCA then
        local finalName = CA.ResolveNameLink(inviterName, inviterDisplayName)
        local message = strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), finalName)
        printToChat(message)
    end
    if CA.SV.GroupAlert then
        local finalAlertName = CA.ResolveNameNoLink(inviterName, inviterDisplayName)
        local alertText = strformat(GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE), finalAlertName)
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
    end
end

-- EVENT_GROUP_MEMBER_JOINED
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

    if joinedMemberName ~= "" and joinedMemberName ~= nil then
        if g_playerName ~= memberName then
            -- Can occur if event is before EVENT_PLAYER_ACTIVATED
            local finalName = CA.ResolveNameLink(joinedMemberName, joinedMemberAccountName)
            local finalAlertName = CA.ResolveNameNoLink(joinedMemberName, joinedMemberAccountName)
            local SendMessage = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN), finalName))
            local SendAlert = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN), finalAlertName))
            zo_callLater(function() CA.PrintJoinStatusNotSelf(SendMessage, SendAlert) end, 100)
        elseif g_playerName == memberName then
            zo_callLater(CA.CheckLFGStatusJoin, 100)
        end
    end

    g_partyStack = { }
end

-- EVENT_GROUP_TYPE_CHANGED
function CA.OnGroupTypeChanged(eventCode, largeGroup)
    local message
    if largeGroup then
        message = GetString(SI_CHAT_ANNOUNCEMENT_IN_LARGE_GROUP)
    else
        message = GetString(SI_CHAT_ANNOUNCEMENT_IN_SMALL_GROUP)
    end
    
    if CA.SV.GroupCA then
        printToChat(message)
    end
    if CA.SV.GroupAlert then
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
    end
end

-- EVENT_GROUP_ELECTION_NOTIFICATION_ADDED
function CA.VoteNotify(eventCode)
    local electionType, timeRemainingSeconds, electionDescriptor, targetUnitTag = GetGroupElectionInfo()
    if electionType == 2 then -- Ready Check
        if CA.SV.GroupVoteCA then
            printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_MESSAGE))
        end
        if CA.SV.GroupVoteAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, GetString(SI_GROUP_ELECTION_READY_CHECK_MESSAGE))
        end
    end

    if electionType == 3 then -- Vote Kick

        local kickMemberName = GetUnitName(targetUnitTag)
        local kickMemberAccountName = GetUnitDisplayName(targetUnitTag)
        
        if CA.SV.GroupVoteCA then
            local finalName = CA.ResolveNameLink(kickMemberName, kickMemberAccountName)
            local message = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START), finalName)
            printToChat(message)
        end
        if CA.SV.GroupVoteAlert then
            local finalAlertName = CA.ResolveNameNoLink(kickMemberName, kickMemberAccountName)
            local alertText = zo_strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START), finalAlertName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertText)
        end
    end
end

-- EVENT_GROUPING_TOOLS_NO_LONGER_LFG
function CA.LFGLeft(eventCode)
    g_leaveLFGOverride = true
end

-- EVENT_PLEDGE_OF_MARA_OFFER - EVENT HANDLER
function CA.MaraOffer(eventCode, characterName, isSender, displayName)

    -- Display CA
    if CA.SV.PledgeOfMaraCA then
        local finalName = CA.ResolveNameLink(characterName, displayName)
        if isSender then
            printToChat(strformat(GetString(SI_PLEDGE_OF_MARA_SENDER_MESSAGE), finalName))
        else
            printToChat(strformat(GetString(SI_PLEDGE_OF_MARA_MESSAGE), finalName))
        end
    end
    
    -- Display Alert
    if CA.SV.PledgeOfMaraAlert then
        local finalAlertName = CA.ResolveNameNoLink(characterName, displayName)
        local alertString
        if isSender then
            alertString = strformat(GetString(SI_PLEDGE_OF_MARA_SENDER_MESSAGE), finalAlertName)
        else
            alertString = strformat(GetString(SI_PLEDGE_OF_MARA_MESSAGE), finalAlertName)
        end
        ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, alertString)
    end
end

-- EVENT_DUEL_STARTED -- EVENT HANDLER
function CA.DuelStarted(eventCode)
    
    -- Display CA
    if CA.SV.DuelStartCA or CA.SV.DuelStartAlert then
        local message
        local formattedIcon = zo_iconFormat("EsoUI/Art/HUD/HUD_Countdown_Badge_Dueling.dds", 16, 16)
        if CA.SV.DuelStartOptions == 1 then
            message = strformat(GetString(SI_LUIE_CA_DUEL_STARTED_WITH_ICON), formattedIcon)
        elseif CA.SV.DuelStartOptions == 2 then
            message = GetString(SI_LUIE_CA_DUEL_STARTED)
        elseif CA.SV.DuelStartOptions == 3 then
            message = strformat("<<1>>", formattedIcon)
        end
    
        if CA.Sv.DuelStartCA then
            printToChat(message)
        end
        
        if CA.SV.DuelStartAlert then
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, message)
        end
    end
    
    -- Play sound if CSA is not enabled
    if not CA.SV.DuelStartCSA then
        PlaySound(SOUNDS.DUEL_START)
    end
    
end      

function CA.SkillXPUpdate(eventCode, skillType, skillIndex, reason, rank, previousXP, currentXP)
    if (skillType == SKILL_TYPE_GUILD) then

        -- Bail out early if a certain type is not set to be displayed
        if skillIndex == 1 and not CA.SV.SkillGuildFighters then
            return
        elseif skillIndex == 2 and not CA.SV.SkillGuildMages then
           return
        elseif skillIndex == 3 and not CA.SV.SkillGuildUndaunted then
           return
        elseif skillIndex == 4 and not CA.SV.SkillGuildThieves then
           return
        elseif skillIndex == 5 and not CA.SV.SkillGuildDarkBrotherhood then
           return
        end
        
        local change = currentXP - previousXP
        local lineName = GetSkillLineInfo(skillType, skillIndex)
        
        if CA.SV.SkillGuildAlert then
            local text = zo_strformat(GetString(SI_LUIE_CA_SKILL_GUILD_ALERT), lineName)
            ZO_Alert(UI_ALERT_CATEGORY_ALERT, nil, text)
        end
        
        -- Bail out or save value if Throttle/Threshold conditions are met
        if skillIndex == 1 and CA.SV.SkillGuildFighters then
            -- Only throttle values 5 or lower (FG Dailies give +10 skill)
            if CA.SV.SkillGuildThrottle > 0 and change <= 5 then
                g_guildSkillThrottle = g_guildSkillThrottle + change
                EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedRep")
                EVENT_MANAGER:RegisterForUpdate(moduleName .. "BufferedRep", CA.SV.SkillGuildThrottle, CA.PrintBufferedGuildRep )
                return
            end
            
            -- If throttle wasn't triggered and the value was below threshold then bail out.
            if change <= CA.SV.SkillGuildThreshold then 
                return
            end
        end
        
        CA.PrintGuildRep(change, lineName, skillIndex)

     end
end

function CA.PrintGuildRep(change, lineName, skillIndex)
    -- TODO: Move this (not sure where to since putting it in the base function makes it populate before colors are defined)
    local GUILD_SKILL_COLOR_TABLE =
    {
        [1] = SkillGuildColorizeFG,
        [2] = SkillGuildColorizeMG,
        [3] = SkillGuildColorizeUD,
        [4] = SkillGuildColorizeTG,
        [5] = SkillGuildColorizeDB,
    }
    
    local icon = zo_iconFormatInheritColor(GUILD_SKILL_ICONS[skillIndex], 16, 16)
    local formattedIcon = CA.SV.SkillGuildIcon and (icon .. " ") or ""
    
    local guildString = zo_strformat(CA.SV.SkillGuildRepName, change)
    local colorize = GUILD_SKILL_COLOR_TABLE[skillIndex]
    local messageP1 = ("|r|c" .. colorize .. formattedIcon .. change .. " " .. lineName .. " " .. guildString .. "|r|c" .. SkillGuildColorize)
    local formattedMessageP1 = (strfmt(CA.SV.SkillGuildMsg, messageP1))
    local finalMessage = strfmt("|c%s%s|r", SkillGuildColorize, formattedMessageP1)
    
    g_queuedMessages[g_queuedMessagesCounter] = { message = finalMessage, type = "SKILL" }
    g_queuedMessagesCounter = g_queuedMessagesCounter + 1
    EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
end

function CA.PrintBufferedGuildRep()
    if (g_guildSkillThrottle > 0 and g_guildSkillThrottle > CA.SV.SkillGuildThreshold) then
        local skillIndex = 1
        local lineName = GetSkillLineInfo(SKILL_TYPE_GUILD, skillIndex)
        CA.PrintGuildRep(g_guildSkillThrottle, lineName, skillIndex)
    end
    EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedRep")
    g_guildSkillThrottle = 0
end

function CA.PrintQueuedMessages()
    -- TODO: Replace with table.sort function to print. Although POSSIBLY print a few sets and remove them first in order to preserve order.

    -- Resolve achievement update messages first
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type == "ACHIEVEMENT" then
            printToChat(g_queuedMessages[i].message)
        end
    end
    
    -- Resolve quest POI added
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type == "QUEST_POI" then
            printToChat(g_queuedMessages[i].message)
        end
    end
    
    -- Next display Quest/Objective Completion and Experience
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type == "QUEST" or g_queuedMessages[i].type == "EXPERIENCE" then
            printToChat(g_queuedMessages[i].message)
        end
    end

    -- Display the rest
    for i=1, #g_queuedMessages do
        if g_queuedMessages[i] ~= "" and g_queuedMessages[i].type ~= "QUEST" and g_queuedMessages[i].type ~= "EXPERIENCE" and g_queuedMessages[i].type ~= "ACHIEVEMENT" and g_queuedMessages[i].type ~= "QUEST_POI" then
            if g_queuedMessages[i].type == "QUESTLOOT" then
                CA.ResolveQuestItemChange()
            elseif g_queuedMessages[i].type == "LOOT" then
                CA.ResolveItemMessage(g_queuedMessages[i].message, g_queuedMessages[i].formattedRecipient, g_queuedMessages[i].color, g_queuedMessages[i].logPrefix, g_queuedMessages[i].totalString)
            else
                printToChat(g_queuedMessages[i].message)
            end
        end
    end
    
    -- Clear Messages and Unregister Print Event
    g_queuedMessages = { }
    g_queuedMessagesCounter = 1
    EVENT_MANAGER:UnregisterForUpdate(moduleName .. "Printer")
end
