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

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------

-- Default Variable Setup
CA.D = {
    AchievementCategory1          = true,
    AchievementCategory10         = true,
    AchievementCategory11         = true,
    --AchievementCategory12         = true,
    AchievementCategory2          = true,
    AchievementCategory3          = true,
    AchievementCategory4          = true,
    AchievementCategory5          = true,
    AchievementCategory6          = true,
    AchievementCategory7          = true,
    AchievementCategory8          = true,
    AchievementCategory9          = true,
    AchievementsProgressMsg       = "[Achievement Updated]",
    AchievementsCompleteMsg       = "[Achievement Completed]",
    AchievementsColorProgress     = true,
    AchievementsColor             = { 0.25, 0.5, 1, 1 },
    AchievementsCompPercentage     = false,
    AchievementsProgress          = true,
    AchievementsComplete          = true,
    AchievementsIcon              = true,
    AchievementsCategory          = true,
    AchievementsSubcategory       = true,
    AchievementsDetails           = true,
    AchievementsBracketOptions    = 1,
    AchievementsStep              = 10,

    
    ChatPlayerDisplayOptions      = 2,
    CurrencyIcons                 = true,
    DisguiseAlertColor            = { 1, 0, 0, 1 },
    EnableCustomStrings           = true,
    GroupChatMsg                  = false,
    GroupLFG                      = false,
    GroupLFGComplete              = false,
    GroupRaid                     = false,
    GroupRaidScore                = false,
    GroupRaidBestScore            = false,
    GroupRaidRevive               = false,
    GroupVote                     = false,
    GuildRankDisplayOptions       = 1,
    ItemBracketDisplayOptions     = 1,
    ItemContextMessage            = "",
    ItemContextToggle             = false,
    LevelTotalIcon                = true,
    Loot                          = true,
    LootBank                      = true,
    LootBlacklist                 = false,
    LootTotal                     = false,
    LootTotalString               = GetString(SI_LUIE_CA_DEFAULTVARS_CURRENCYTOTALMESSAGE),
    
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
    MiscDisguise                  = true,
    MiscDisguiseAlert             = true,
    MiscDisguiseOption            = 3,
    MiscDuel                      = false,
    MiscDuelStartOptions          = 1,
    MiscGuild                     = false,
    MiscGuildIcon                 = false,
    MiscGuildMOTD                 = false,
    MiscGuildRank                 = false,
    MiscHorse                     = false,
    MiscLockpick                  = false,
    MiscMail                      = false,
    MiscMara                      = false,
    MiscSocial                    = false,
    MiscTrade                     = false,
    MiscStuck                     = false,
    Quest                         = false,
    QuestCSA                      = true,
    QuestFailure                  = false,
    QuestPOICompleted             = false,
    QuestPOIDiscovery             = false,
    QuestObjectiveDiscovery       = false,
    QuestShare                    = true,
    ShowConfiscate                = false,
    ShowCraftUse                  = false,
    ShowDestroy                   = false,
    ShowDisguise                  = false,
    ShowLockpickBreak             = false,
    ShowLootFail                  = false,
    
    -----------------------
    -- UPDATED CODE
    -----------------------
    
    -- Storage / Riding Upgrades
    StorageRidingColor            = { 1, 1, 1, 1 },
    StorageRidingCA               = true,
    StorageRidingCSA              = true,
    StorageRidingAlert            = true,
    
    StorageBagColor               = { 1, 1, 1, 1 },
    StorageBagCA                  = true,
    StorageBagCSA                 = true,
    StorageBagAlert               = true,
    
    -- Collectibles/Lorebooks:
    CollectibleCA                 = true,
    CollectibleCSA                = true,
    CollectibleAlert              = false,
    CollectibleBracket            = 4,
    CollectiblePrefix             = GetString(SI_LUIE_CA_COLLECTIBLE),
    CollectibleIcon               = true,
    CollectibleColor1             = { 0, .5, 1, 1 },
    CollectibleColor2             = { 1, 1, 1, 1 },
    CollectibleCategory           = true,
    
    LorebookCA                    = true, -- Display a CA for Lorebooks
    LorebookCSA                   = true, -- Display a CSA for Lorebooks
    LorebookAlert                 = false, -- Display a ZO_Alert for Lorebooks
    
    LorebookCollectionCA          = true,
    LorebookCollectionCSA         = true,
    LorebookCollectionAlert       = false,
    LorebookCollectionPrefix      = GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE),
    
    LorebookPrefix1               = GetString(SI_LUIE_CA_LOREBOOK_BOOK),
    LorebookPrefix2               = GetString(SI_LORE_LIBRARY_ANNOUNCE_BOOK_LEARNED),
    
    LorebookBracket               = 4, -- Bracket Options
    LorebookColor1                = { 0, .5, 1, 1 }, -- Lorebook Message Color 1
    LorebookColor2                = { 1, 1, 1, 1 }, -- Lorebook Message Color 2
    
    LorebookIcon                  = false, -- Display an icon for Lorebook CA
    LorebookShowHidden            = false, -- Display books even when they are hidden in the journal menu
    LorebookCategory              = false, -- Display "added to X category" message
    
    --Lorebook                      = false,
    --LorebookPrefix1               = "Lorebook Discovered:",
    --LorebookPrefix2               = "Motif Learned:",
    --LorebookPrefix3               = "Book Discovered:",
    --LorebookIcon                  = false,
    --LorebookNoShowHide            = false,
    --LorebookCategory              = false,
    --LorebookNumber                = false,
    --LorebookNumberColor           = false,
    -------------
    
    -- QUEST
    QuestColorLocName               = { 1, 1, 1, 1 },
    QuestColorLocDescription        = { 1, 1, 0, 1 },
    QuestColorName                  = { 1, 0.647058, 0, 1 },
    QuestColorDescription           = { 1, 1, 0, 1 },
    
    QuestLocLong                    = true,
    QuestIcon                       = true,
    QuestLogFull                    = true,
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
    ExperienceEnlightened           = false,
    
    ExperienceLevelUpCA             = true,
    ExperienceLevelUpCSA            = true,
    ExperienceLevelUpAlert          = false,
    ExperienceLevelUpCSAExpand      = false,
    ExperienceLevelUpIcon           = true,
    ExperienceLevelColorByLevel     = true,
    ExperienceLevelUpColor          = { 1, 1, 1, 1 },
    
    Experience                      = true,
    ExperienceIcon                  = true,
    ExperienceMessage               = GetString(SI_LUIE_CA_EXPERIENCE_MESSAGE),
    ExperienceName                  = GetString(SI_LUIE_CA_EXPERIENCE_NAME),
    ExperienceHideCombat            = false,
    ExperienceFilter                = 0,
    ExperienceThrottle              = 0,
    ExperienceColorMessage          = { 1, 1, 1, 1 },
    ExperienceColorName             = { 1, 1, 1, 1 },
    
    -- SKILL POINT
    SkillPointCA                    = true,
    SkillPointCSA                   = true,
    SkillPointAlert                 = false,
    SkillPointSkyshardMsg           = GetString(SI_SKYSHARD_GAINED),
    SkillPointBracket               = 4,
    ShowSkillPointsPartial          = false,
    SkillPointColor1                = { 0, 1, 1, 1 },
    SkillPointColor2                = { 1, 1, 1, 1 },
    
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
    SkillLineColor                  = { .75, .75, .75, 1},
    
    SkillGuildFighters              = false,
    SkillGuildMages                 = false,
    SkillGuildUndaunted             = false,
    SkillGuildThieves               = false,
    SkillGuildDarkBrotherhood       = false,
    SkillGuildIcon                  = true,
    SkillGuildMsg                   = GetString(SI_LUIE_CA_SKILL_GUILD_MSG),
    SkillGuildRepName               = GetString(SI_LUIE_CA_SKILL_GUILD_REPUTATION),
    SkillGuildColor                 = { .75, .75, .75, 1},
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
    CurrencyAPShowChange            = true,
    CurrencyAPShowTotal             = true,
    CurrencyAPThrottle              = 0,
    CurrencyColor                   = { 1, 1, 1, 1},
    CurrencyColorDown               = { 0.7, 0, 0, 1 },
    CurrencyColorUp                 = { 0.043137, 0.380392, 0.043137, 1 },
    CurrencyContextColor            = true,
    CurrencyGoldChange              = true,
    CurrencyGoldColor               = { 1, 1, 0.2, 1 },
    CurrencyGoldFilter              = 0,
    CurrencyGoldHideAH              = false,
    CurrencyGoldName                = GetString(SI_LUIE_CA_CURRENCY_GOLD),
    CurrencyGoldShowTotal           = true,
    CurrencyGoldThrottle            = true,
    CurrencyMessageConfiscate       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_CONFISCATE),
    CurrencyMessageDeposit          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSIT),
    CurrencyMessageEarn             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_EARN),
    CurrencyMessageLoot             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LOOT),
    CurrencyMessageLost             = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_LOST),
    CurrencyMessagePickPocket       = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_PICKPOCKET),
    CurrencyMessageReceive          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_RECEIVE),
    CurrencyMessageSpend            = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_SPEND),
    CurrencyMessageTotalAP          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALAP),
    CurrencyMessageTotalGold        = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALGOLD),
    CurrencyMessageTotalTV          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALTV),
    CurrencyMessageTotalWV          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TOTALWV),
    CurrencyMessageTradeIn          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEIN),
    CurrencyMessageTradeOut         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_TRADEOUT),
    CurrencyMessageWithdraw         = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAW),
    CurrencyMessageStable           = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STABLE),
    CurrencyMessageStorage          = GetString(SI_LUIE_CA_CURRENCY_MESSAGE_STORAGE),
    CurrencyTVChange                = true,
    CurrencyTVColor                 = { 0.368627, 0.643137, 1, 1 },
    CurrencyTVFilter                = 0,
    CurrencyTVName                  = GetString(SI_LUIE_CA_CURRENCY_TELVAR_STONE),
    CurrencyTVShowTotal             = true,
    CurrencyTVThrottle              = 0,
    CurrencyWVChange                = true,
    CurrencyWVColor                 = { 1, 1, 1, 1 },
    CurrencyWVName                  = GetString(SI_LUIE_CA_CURRENCY_WRIT_VOUCHER),
    CurrencyWVShowTotal             = true,
    
    -- LOOT
    LootMessageLoot                 = GetString(SI_LUIE_CA_LOOT_MESSAGE_LOOT),
    LootMessageReceive              = GetString(SI_LUIE_CA_LOOT_MESSAGE_RECEIVE),
    LootMessageTradeIn              = GetString(SI_LUIE_CA_LOOT_MESSAGE_TRADEIN),
    LootMessageTradeOut             = GetString(SI_LUIE_CA_LOOT_MESSAGE_TRADEOUT),
    LootMessageDeposit              = GetString(SI_LUIE_CA_LOOT_MESSAGE_DEPOSIT),
    LootMessageWithdraw             = GetString(SI_LUIE_CA_LOOT_MESSAGE_WITHDRAW),
    LootMessageSell                 = GetString(SI_LUIE_CA_LOOT_MESSAGE_SELL),
    LootMessageBuy                  = GetString(SI_LUIE_CA_LOOT_MESSAGE_BUY),
    LootMessagePickpocket           = GetString(SI_LUIE_CA_LOOT_MESSAGE_PICKPOCKET),
    LootMessageLaunder              = GetString(SI_LUIE_CA_LOOT_MESSAGE_LAUNDER),
    LootMessageConfiscate           = GetString(SI_LUIE_CA_LOOT_MESSAGE_CONFISCATE),
    LootMessageLose                 = GetString(SI_LUIE_CA_LOOT_MESSAGE_LOSE),
    LootMessageUse                  = GetString(SI_LUIE_CA_LOOT_MESSAGE_USE),
    LootMessageCraft                = GetString(SI_LUIE_CA_LOOT_MESSAGE_CRAFT),
    LootMessageExtract              = GetString(SI_LUIE_CA_LOOT_MESSAGE_EXTRACT),
    LootMessageUpgrade              = GetString(SI_LUIE_CA_LOOT_MESSAGE_UPGRADE),
    LootMessageRefine               = GetString(SI_LUIE_CA_LOOT_MESSAGE_REFINE),
    LootMessageDeconstruct          = GetString(SI_LUIE_CA_LOOT_MESSAGE_DECONSTRUCT),
    LootMessageResearch             = GetString(SI_LUIE_CA_LOOT_MESSAGE_RESEARCH),
    LootMessageDestroy              = GetString(SI_LUIE_CA_LOOT_MESSAGE_DESTROY),
    LootMessageLockpick             = GetString(SI_LUIE_CA_LOOT_MESSAGE_LOCKPICK),
    
    LootMessageDisguiseEquip        = GetString(SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_EQUIP),
    LootMessageDisguiseRemove       = GetString(SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_REMOVE),
    LootMessageDisguiseDestroy      = GetString(SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_DESTROY),
}

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------

-- CA Local Variable Setup
local g_tradeDisablePrint         = false -- Toggled on when a trade is completed, causing item updates to be suspended to allow our trade item changes printing to work.
local g_isLooted                  = false -- This value is false by default, and toggled on only by on_loot_received being triggered. It replaces the [Received] context message in Item updates with [Looted]
local g_weAreInAStore             = false -- Toggled on when the player opens a store, this sends information to our indexing function to not show changes to inventory and let sell events handle it
local g_currentDisguise
local g_disguiseState
local g_bankStacks                = {} -- Called for indexing on opening crafting window (If the player decons an item from the bank - not needed for bank, since we don't care about items in the bank)
local g_banksubStacks             = {} -- Called for indexing on opening crafting window (If the player decons an item from the bank - not needed for bank, since we don't care about items in the bank)
local g_equippedStacks            = {} -- Called for indexing on init
local g_inventoryStacks           = {} -- Called for indexing on init
local g_JusticeStacks             = {} -- Filled during justice confiscation to compare item changes
local g_comboString               = "" -- String is filled by the EVENT_CURRENCY_CHANGE events and amended onto the end of purchase/sales from LootLog component if toggled on!
local g_craftStacks               = {}
local g_areWeGrouped              = false
local g_stopGroupLeaveQueue       = false
local g_groupFormFudger           = false
local g_groupJoinFudger           = false -- Controls message for group join
local g_joinLFGOverride           = false
local g_leaveLFGOverride          = false
local g_guildBankCarrygainOrLoss  = ""
local g_guildBankCarryIcon        = ""
local g_guildBankCarryItemLink    = ""
local g_guildBankCarryItemType    = ""
local g_guildBankCarryLogPrefix   = ""
local g_guildBankCarryReceivedBy  = ""
local g_guildBankCarryStackCount  = 1
local g_guildJoinFudger           = false
local g_guildRankData             = {} -- Variable to store local player guild ranks, for guild rank changes.
local g_isValidLaunder            = false
local g_itemReceivedIsQuestReward = false -- Variable gets set to true when a quest reward is received, flags in loot function to update the context string.

local g_lastPercentage            = {} -- Here we will store last displayed percentage for achievement
local g_launderCheck              = false
local g_launderGoldstring         = ""
local g_launderItemstring         = ""
local g_mailCOD                   = 0
local g_mailCODBackup             = 0 -- Saved value if mail sent results in an error, restores correct values
local g_mailCurrencyCheck         = true
local g_mailMoney                 = 0
local g_mailMoneyBackup           = 0 -- Saved value if mail sent results in an error, restores correct values
local g_mailStacks                = 0
local g_mailStacksOut             = {}
local g_mailStop                  = false
local g_mailStringPart1           = ""
local g_oldItem                   = { }
local g_playerName                = nil
local g_playerNameFormatted       = nil
local g_postageAmount             = 0
local g_questIndex                = { }
local g_QuestShareFudger          = false
local g_saveMailId                = "" -- If the player takes a mail and cannot loot all the items, the index is cleared. This value will save the ID of the last opened mail and reuse it if the mail still has more items to loot.
local g_showActivityStatus        = true
local g_showRCUpdates             = true
local g_stealString               = ""
local g_savedQueueValue           = 0 -- Variable to determine if we are in queue
local g_smithing                  = {} -- Table for smithing mode
local g_enchanting                = {} -- Table for enchanting mode
local g_weAreInMail               = false -- Toggled on when looting mail to prevent notable item display from hiding items acquired.
local g_rcSpamPrevention          = false -- Stops LFG failed ready checks from spamming the player
local g_LFGJoinAntiSpam           = false -- Stops LFG join messages from spamming the player when a group already in an activity is queueing
local g_rcUpdateDeclineOverride   = false -- Variable set to true for 5 seconds when a LFG group joing event happens, this prevents RC declined messages from erroneously appearing after solo joining an in progress LFG group.
local g_lfgDisableGroupEvents     = false

-- Variables used for Trade Functions
local g_tradeInvitee              = ""
local g_tradeInviter              = ""
local g_tradeStacksIn             = {}
local g_tradeStacksOut            = {}
local g_tradeString1              = ""
local g_tradeString2              = ""

-- Colorize values (We don't define here, just when the call needs to be made)
local CurrencyColorize
local CurrencyUpColorize
local CurrencyDownColorize
local CurrencyGoldColorize
local APColorize
local TVColorize
local WVColorize
local DisguiseAlertColorize
local AchievementsColorize
local ExperienceMessageColorize
local ExperienceNameColorize
local LevelUpColorize
local SkillPointColorize1
local SkillPointColorize2
local SkillLineColorize

local SkillGuildColorize
local SkillGuildColorizeFG
local SkillGuildColorizeMG
local SkillGuildColorizeUD
local SkillGuildColorizeTG
local SkillGuildColorizeDB

-----------------------------------
-- UPDATED CODE (VARIABLES)
-----------------------------------


-- Basic
local g_queuedMessages              = { } -- Table to hold messages for the 50 ms tick function to print them.
local g_queuedMessagesCounter       = 1 -- Counter value for queued message printer

-- Currency
local g_currencyGoldThrottleValue   = 0 -- Held value for gold throttle (counter)
local g_currencyGoldThrottleTotal   = 0 -- Held value for gold throttle (total gold)
local g_currencyAPThrottleValue     = 0 -- Held value for AP throttle (counter)
local g_currencyAPThrottleTotal     = 0 -- Held value for AP throttle (total gold)
local g_currencyTVThrottleValue     = 0 -- Held value for TV throttle (counter)
local g_currencyTVThrottleTotal     = 0 -- Held value for TV throttle (total gold)

-- Loot
local g_itemCounterGain             = 0 -- Counter value for items created via crafting
local g_itemStringGain              = "" -- Counter value for items created via crafting
local g_itemCounterLoss             = 0 -- Counter value for items removed via crafting
local g_itemStringLoss              = "" -- Combined string variable for items removed via crafting
local g_itemWasDestroyed            = false
local g_lockpickBroken              = false

-- Experience
local g_xpCombatBufferValue         = 0
local g_guildSkillThrottle          = 0
-----------------------------------
-- UPDATED CODE (COLORIZE VALUES)
-----------------------------------

-- Collectibles
local CollectibleColorize1
local CollectibleColorize2

-- Lorebooks
local LorebookColorize1
local LorebookColorize2

local QuestColorLocNameColorize
local QuestColorLocDescriptionColorize
local QuestColorNameColorize
local QuestColorDescriptionColorize

local StorageRidingColorize
local StorageBagColorize

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------

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

local g_enchant_prefix_pos = { }
local g_enchant_prefix_neg = { }
local g_enchant_smithing_pos = { }
local g_enchant_smithing_neg = { }

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

    -- Posthook Crafting Interface (Keyboard)
    CA.CraftModeOverrides()

    -- Register events
    CA.RegisterGroupEvents()
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
    
    CA.RegisterHorseEvents()
    CA.RegisterGuildEvents()
    CA.RegisterSocialEvents()
    CA.RegisterCustomStrings()
    CA.RegisterDuelEvents()
    CA.RegisterDisguiseEvents()
    CA.RegisterMaraEvents()
    CA.RegisterCollectibleEvents()
    CA.RegisterColorEvents()
    CA.RegisterStuckEvents()
    CA.RegisterQuestEvents()
    
    --
    CA.AlertStyleLearned()
    
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
        [4] = CA.SV.LootMessageDestroy,
        [5] = CA.SV.LootMessageResearch,
        [6] = CA.SV.LootMessageUse,
    }

end

function CA.RegisterColorEvents()
    CurrencyColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyColor))
    CurrencyUpColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyColorUp))
    CurrencyDownColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyColorDown))
    CollectibleColorize1 = ZO_ColorDef:New(unpack(CA.SV.CollectibleColor1))
    CollectibleColorize2 = ZO_ColorDef:New(unpack(CA.SV.CollectibleColor2))
    CurrencyGoldColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyGoldColor))
    APColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyAPColor))
    TVColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyTVColor))
    WVColorize = ZO_ColorDef:New(unpack(CA.SV.CurrencyWVColor))
    DisguiseAlertColorize = ZO_ColorDef:New(unpack(CA.SV.DisguiseAlertColor))
    AchievementsColorize = ZO_ColorDef:New(unpack(CA.SV.AchievementsColor))
    LorebookColorize1 = ZO_ColorDef:New(unpack(CA.SV.LorebookColor1))
    LorebookColorize2 = ZO_ColorDef:New(unpack(CA.SV.LorebookColor2))
    ExperienceMessageColorize = ZO_ColorDef:New(unpack(CA.SV.ExperienceColorMessage)):ToHex()
    ExperienceNameColorize = ZO_ColorDef:New(unpack(CA.SV.ExperienceColorName)):ToHex()
    LevelUpColorize = ZO_ColorDef:New(unpack(CA.SV.ExperienceLevelUpColor))
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
    QuestColorNameColorize = ZO_ColorDef:New(unpack(CA.SV.QuestColorName)):ToHex()
    QuestColorDescriptionColorize = ZO_ColorDef:New(unpack(CA.SV.QuestColorDescription)):ToHex()
    
    StorageRidingColorize = ZO_ColorDef:New(unpack(CA.SV.StorageRidingColor))
    StorageBagColorize = ZO_ColorDef:New(unpack(CA.SV.StorageBagColor))
    
end

function CA.RegisterCollectibleEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_COLLECTIBLE_NOTIFICATION_NEW)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LORE_BOOK_LEARNED)
    if CA.SV.Collectible then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COLLECTIBLE_UPDATED, CA.CollectibleUpdated)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COLLECTIBLES_UPDATED, CA.CollectiblesUpdated)
    end
    if CA.SV.Lorebook then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LORE_BOOK_LEARNED, CA.LoreBookLearned)
    end
end

function CA.RegisterSocialEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_FRIEND_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_FRIEND_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_REMOVED)
    if CA.SV.MiscSocial then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_FRIEND_ADDED, CA.FriendAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_FRIEND_REMOVED, CA.FriendRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_ADDED, CA.FriendInviteAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INCOMING_FRIEND_INVITE_REMOVED, CA.FriendInviteRemoved)
    end
end

function CA.RegisterQuestEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_SHARED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_SHARE_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_COMPLETE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_CONDITION_COUNTER_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OBJECTIVE_COMPLETED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_POI_DISCOVERED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DISCOVERY_EXPERIENCE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_LOG_IS_FULL)

    if CA.SV.QuestShare then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_SHARED, CA.QuestShared)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_SHARE_REMOVED, CA.QuestShareRemoved)
    end
    if CA.SV.Quest or CA.SV.QuestShare then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_ADDED, CA.QuestAdded)
    end
    if CA.SV.Quest or CA.SV.QuestCSA then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_REMOVED, CA.QuestRemoved)
    end
    if CA.SV.Quest or CA.SV.Loot then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_COMPLETE, CA.QuestComplete)
    end
    if CA.SV.QuestFailure then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_CONDITION_COUNTER_CHANGED, CA.QuestFailed)
    end
    if CA.SV.QuestPOICompleted then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OBJECTIVE_COMPLETED, CA.QuestObjectiveComplete)
    end
    if CA.SV.QuestPOIDiscovery then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DISCOVERY_EXPERIENCE, CA.DiscoveryExperience)
    end
    if CA.SV.QuestObjectiveDiscovery then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_POI_DISCOVERED, CA.POIDiscovered)
    end
    if CA.SV.QuestLogFull then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_LOG_IS_FULL, CA.QuestLogFull)
    end
    
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
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MEMBER_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MEMBER_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MEMBER_RANK_CHANGED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_INVITE_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_INVITE_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GUILD_MOTD_CHANGED)
    if CA.SV.MiscGuild then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_ADDED, CA.GuildMemberAdded)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_REMOVED, CA.GuildMemberRemoved)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, CA.GuildAddedSelf)
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
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED)
    if CA.SV.MiscDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, CA.OnPlayerActivated)
        EVENT_MANAGER:RegisterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED, CA.DisguiseState )
        EVENT_MANAGER:AddFilterForEvent(moduleName .. "player", EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
        g_currentDisguise = GetItemId(0, 10) or 0 -- Get the currently equipped disguise itemId if any
        g_disguiseState = GetUnitDisguiseState("player") -- Get current player disguise state
        if g_disguiseState > 0 then
            g_disguiseState = 1 -- Simplify all the various states into a basic 0 = false, 1 = true value
            zo_callLater(CA.DisplayDisguiseOnLoad, 50)
        end
    end
end

function CA.DisplayDisguiseOnLoad()
    if CA.SV.MiscDisguiseOption == 1 or CA.SV.MiscDisguiseOption == 3 then
        printToChat(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description))
    end
    if CA.SV.MiscDisguiseOption == 2 or CA.SV.MiscDisguiseOption == 3 then
        local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
        messageParams:SetText(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description))
        messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
        CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
    end
end

function CA.RegisterAchievementsEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACHIEVEMENT_AWARDED)
    if CA.SV.AchievementsProgress then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACHIEVEMENT_UPDATED, CA.OnAchievementUpdated)
    end
    if CA.SV.AchievementsComplete then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACHIEVEMENT_AWARDED, CA.OnAchievementAwarded)
    end
end

function CA.RegisterXPEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN)
    if CA.SV.Experience or CA.SV.ExperienceLevelUp then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_EXPERIENCE_GAIN, CA.OnExperienceGain)
    end
    if CA.SV.ShowSkillPoints then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SKILL_POINTS_CHANGED, CA.SkillPointsChanged)
    end
end

function CA.RegisterStuckEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_STUCK_BEGIN)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_STUCK_ERROR_ALREADY_IN_PROGRESS)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_STUCK_ERROR_INVALID_LOCATION)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_STUCK_ERROR_IN_COMBAT)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_STUCK_ERROR_ON_COOLDOWN)
    if CA.SV.MiscStuck then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_STUCK_BEGIN, CA.StuckBegin)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_STUCK_ERROR_ALREADY_IN_PROGRESS, CA.StuckAlreadyInProgress)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_STUCK_ERROR_INVALID_LOCATION, CA.StuckInvalidLocation)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_STUCK_ERROR_IN_COMBAT, CA.StuckInCombat)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_STUCK_ERROR_ON_COOLDOWN, CA.StuckOnCooldown)
    end
end

function CA.Broadcast(eventCode, message)
    --d("Broadcast deteceted!")
    printToChat(message)
end

function CA.RegisterGroupEvents()
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_BROADCAST, CA.Broadcast)
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
    -- Raid Events
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_RAID_TRIAL_COMPLETE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_RAID_TRIAL_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_RAID_TRIAL_STARTED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_RAID_TRIAL_NEW_BEST_SCORE)
    if CA.SV.GroupChatMsg then
        local groupSize = GetGroupSize()
        if groupSize > 1 then
            g_areWeGrouped = true
        end
        if IsInLFGGroup() then
            g_LFGJoinAntiSpam = true
        end
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
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_STATUS_UPDATE, CA.ActivityStatusUpdate)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVITY_QUEUE_RESULT, CA.ActivityQueueResult)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_CANCELLED, CA.ReadyCheckCancel)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUPING_TOOLS_READY_CHECK_UPDATED, CA.ReadyCheckUpdate)
    end
    if CA.SV.GroupLFGComplete then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTIVITY_FINDER_ACTIVITY_COMPLETE, CA.ActivityComplete)
    end
    if CA.SV.GroupRaid then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RAID_TRIAL_COMPLETE, CA.TrialComplete)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RAID_TRIAL_FAILED, CA.TrialFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RAID_TRIAL_STARTED, CA.TrialStarted)
    end
    if CA.SV.GroupRaidScore then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RAID_TRIAL_SCORE_UPDATE, CA.TrialScore)
    end
    if CA.SV.GroupRaidBestScore then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RAID_TRIAL_NEW_BEST_SCORE, CA.TrialBestScore)
    end
    if CA.SV.GroupRaidRevive then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RAID_REVIVE_COUNTER_UPDATE, CA.TrialReviveCounter)
    end
end

function CA.RegisterGoldEvents()

    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CARRIED_CURRENCY_UPDATE, CA.OnCurrencyUpdate)

    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MONEY_UPDATE)
     -- Only register this event if the menu setting is true
    if CA.SV.MiscMail or CA.SV.LootMail or CA.SV.CurrencyGoldChange then
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

function CA.RegisterMailEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_READABLE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_OPEN_MAILBOX)
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
    if CA.SV.MiscMail or CA.SV.LootMail or CA.SV.CurrencyGoldChange then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_ADDED, CA.OnMailAttach)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_ATTACHMENT_REMOVED, CA.OnMailAttachRemove)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_SEND_FAILED, CA.OnMailFail)
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
    -- LOOT RECEIVED
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_RECEIVED)
    -- QUEST REWARD CONTEXT
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_COMPLETE)
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
    -- TRADE
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
    -- CRAFT
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, CA.CraftingOpen)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, CA.CraftingClose)
    -- JUSTICE/DESTROY
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED)
    -- LOCKPICK
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOCKPICK_BROKE)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INTERACTABLE_IMPOSSIBLE_TO_PICK)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INTERACTABLE_LOCKED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOCKPICK_FAILED)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS)
    -- LOOT FAILED
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_COMPLETE_ATTEMPT_FAILED_INVENTORY_FULL)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_IS_FULL)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED)

    -- LOOT RECEIVED
    if CA.SV.Loot then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_RECEIVED, CA.OnLootReceived)
    end
    -- QUEST REWARD CONTEXT
    if CA.SV.Loot or CA.SV.Quest then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_COMPLETE, CA.QuestComplete)
    end
    -- INDEX
    if CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak then
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
    if CA.SV.MiscTrade or CA.SV.LootTrade or CA.SV.Loot then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TRADE_SUCCEEDED, CA.OnTradeSuccess)
    end
    if CA.SV.MiscTrade and not CA.SV.LootTrade then
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
    -- CRAFT
    if CA.SV.Loot or CA.SV.LootCraft then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_CRAFTING_STATION_INTERACT, CA.CraftingOpen)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_END_CRAFTING_STATION_INTERACT, CA.CraftingClose)
    end
    -- JUSTICE/DESTROY
    if CA.SV.ShowDestroy then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_ITEM_DESTROYED, CA.DestroyItem)
    end
    if CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.MiscConfiscate or CA.SV.ShowDisguise then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_JUSTICE_STOLEN_ITEMS_REMOVED, CA.JusticeStealRemove)
    end
    -- LOCKPICK
    if CA.SV.ShowLockpickBreak then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_BROKE, CA.MiscAlertLockBroke)
    end
    if CA.SV.MiscLockpick then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INTERACTABLE_IMPOSSIBLE_TO_PICK, CA.MiscAlertLockImpossible)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INTERACTABLE_LOCKED, CA.MiscAlertLockLocked)
    end
    if CA.SV.MiscLockpick or CA.SV.ShowLockpickBreak then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_FAILED, CA.MiscAlertLockFailed)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOCKPICK_SUCCESS, CA.MiscAlertLockSuccess)
    end
    if CA.SV.ShowLootFail then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_COMPLETE_ATTEMPT_FAILED_INVENTORY_FULL, CA.InventoryFullQuest)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_IS_FULL, CA.InventoryFull)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_ITEM_FAILED, CA.LootItemFailed)
    end
end

function CA.RegisterBagEvents()

end

function CA.RegisterHorseEvents()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_RIDING_SKILL_IMPROVEMENT)
    if CA.SV.MiscHorse then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_RIDING_SKILL_IMPROVEMENT, CA.MiscAlertHorse)
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

-- We don't register this event here because its important that it is called before reindexing is applied in LUIE base.
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
end

function CA.QuestRemoved(eventCode, isCompleted, journalIndex, questName, zoneIndex, poiIndex, questID)
end

function CA.QuestObjectiveComplete(eventCode, zoneIndex, poiIndex, level, previousExperience, currentExperience, championPoints)

    --[[
    local function ReactivateObjectiveComplete()
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_OBJECTIVE_COMPLETED, CA.QuestObjectiveComplete)
    end

    local name, _, _, finishedDescription = GetPOIInfo(zoneIndex, poiIndex)
    local nameFormatted
    local formattedText

    if CA.SV.QuestObjectiveLong and finishedDescription ~= "" then
        nameFormatted = (strformat("|cFEFEFE<<1>>:|r <<2>>", name, finishedDescription))
    else
        nameFormatted = (strformat("|cFEFEFE<<1>>|r", name))
    end

    formattedText = strformat(SI_NOTIFYTEXT_OBJECTIVE_COMPLETE, nameFormatted)

    printToChat(formattedText)

    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_OBJECTIVE_COMPLETED)
    zo_callLater(ReactivateObjectiveComplete, 100)
    ]]--
end

function CA.DiscoveryExperience(eventCode, areaName, level, previousExperience, currentExperience, championPoints)

end

function CA.POIDiscovered(eventCode,zoneIndex, poiIndex)

end

function CA.QuestLogFull(eventCode)
    printToChat(GetString(SI_ERROR_QUEST_LOG_FULL))
end

function CA.QuestComplete(eventCode, questName, level, previousExperience, currentExperience, championPoints, questType, instanceDisplayType)
--[[

    d("Quest Complete")
    
    local function ReactivateQuestComplete()
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_QUEST_COMPLETE, CA.QuestComplete)
    end

    local function ResetQuestRewardStatus()
        g_itemReceivedIsQuestReward = false
    end

    if CA.SV.Quest then
        local questNameFormatted = (strformat("|cFFA500<<1>>|r", questName))
        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)
        local formattedString
        if iconTexture and CA.SV.QuestIcon then
            formattedString = strformat(SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON), zo_iconFormat(iconTexture, 16, 16), questNameFormatted)
        else
            formattedString = strformat(SI_NOTIFYTEXT_QUEST_COMPLETE, questNameFormatted)
        end
        printToChat(formattedString)
        -- Have to unregister the event here to prevent it from spamming us twice.
        EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_QUEST_COMPLETE)
        zo_callLater(ReactivateQuestComplete, 100)
    end

    if CA.SV.Loot then
        -- We set this variable to true in order to override the [Looted] message syntax that would be applied to a quest reward normally.
        g_itemReceivedIsQuestReward = true
        zo_callLater(ResetQuestRewardStatus, 500)
    end
    
    ]]--
end

-- EVENT_QUEST_CONDITION_COUNTER_CHANGED

function CA.QuestFailed(eventCode, journalIndex, questName, conditionText, conditionType, currConditionVal, newConditionVal, conditionMax, isFailCondition, stepOverrideText, isPushed, isComplete, isConditionComplete, isStepHidden)
    -- We're only interested in this event for failure condition
    
    --[[
    if not isFailCondition or conditionText == "TRACKER GOAL TEXT" then --TODO: Localize this string
        return
    end

    if stepOverrideText == "" then
        if conditionMax > 1 then
            printToChat(strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL, conditionText, newConditionVal, conditionMax))
        else
            printToChat(strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, conditionText))
        end
    else
        printToChat(strformat(SI_ALERTTEXT_QUEST_CONDITION_FAIL_NO_COUNT, stepOverrideText))
    end
    ]]--
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
    if CA.SV.EnableCustomStrings then
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
        SafeAddString(SI_GROUPINVITERESPONSE15, GetString(SI_LUIE_CA_GROUPINVITERESPONSE15), 1)
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GROUP, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE_ALT), 1)
        SafeAddString(SI_GROUP_INVITE_MESSAGE, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE_ALT), 2)
        SafeAddString(SI_GROUPLEAVEREASON1, GetString(SI_LUIE_CA_GROUP_GROUPLEAVEREASON1), 3)
        SafeAddString(SI_GROUPLEAVEREASON2, GetString(SI_LUIE_CA_GROUP_MEMBER_DISBAND_MSG), 1)
        SafeAddString(SI_LUIE_CA_GROUP_INVITE_MESSAGE, GetString(SI_LUIE_CA_GROUP_INVITE_MESSAGE_ALT), 1)
        SafeAddString(SI_LUIE_CA_GROUP_LEADER_CHANGED, GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_ALT), 1)
        SafeAddString(SI_LUIE_CA_GROUP_MEMBER_JOIN, GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_ALT), 1)
        SafeAddString(SI_LUIE_CA_GROUP_MEMBER_KICKED, GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED_ALT), 1)
        SafeAddString(SI_LUIE_CA_GROUP_MEMBER_LEAVE, GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_ALT), 1)
        SafeAddString(SI_GROUP_NOTIFICATION_GROUP_LEADER_CHANGED, GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_ALT), 1)
        -- Trial String Replacement
        SafeAddString(SI_TRIAL_STARTED, GetString(SI_LUIE_CA_GROUP_TRIAL_STARTED), 1)
        SafeAddString(SI_TRIAL_FAILED, GetString(SI_LUIE_CA_GROUP_TRIAL_FAILED), 1)
        SafeAddString(SI_REVIVE_COUNTER_UPDATED_LARGE, GetString(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED_LARGE), 2)
        SafeAddString(SI_TRIAL_SCORE_UPDATED_LARGE, GetString(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED_LARGE), 1)
        -- Group Finder String Replacements
        SafeAddString(SI_GROUPING_TOOLS_ALERT_LFG_JOINED, GetString(SI_LUIE_CA_GROUPFINDER_ALERT_LFG_JOINED), 1)
        SafeAddString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL, GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL_ALT), 1)
        SafeAddString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START, GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START_ALT), 1)
        SafeAddString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED, GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED_ALT), 1)
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
        SafeAddString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG, GetString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG_ALT), 1)
        SafeAddString(SI_FRIENDS_LIST_IGNORE_ADDED, GetString(SI_LUIE_CA_FRIENDS_LIST_IGNORE_ADDED), 1)
        SafeAddString(SI_FRIENDS_LIST_IGNORE_REMOVED, GetString(SI_LUIE_CA_FRIENDS_LIST_IGNORE_REMOVED), 1)
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_FRIEND_REQUEST, GetString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST), 1)
        SafeAddString(SI_FRIENDS_LIST_FRIEND_LOGGED_ON, GetString(SI_LUIE_CA_FRIENDS_LIST_LOGGED_ON), 1)
        SafeAddString(SI_FRIENDS_LIST_FRIEND_CHARACTER_LOGGED_ON, GetString(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_ON), 1)
        SafeAddString(SI_FRIENDS_LIST_FRIEND_LOGGED_OFF, GetString(SI_LUIE_CA_FRIENDS_LIST_LOGGED_OFF), 1)
        SafeAddString(SI_FRIENDS_LIST_FRIEND_CHARACTER_LOGGED_OFF, GetString(SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_OFF), 1)
        SafeAddString(SI_LUIE_CA_FRIENDS_FRIEND_ADDED, GetString(SI_LUIE_CA_FRIENDS_FRIEND_ADDED_ALT), 1)
        SafeAddString(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED, GetString(SI_LUIE_CA_FRIENDS_FRIEND_REMOVED_ALT), 1)
        SafeAddString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST, GetString(SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST_ALT), 1)
        -- Guild Invite String Replacements
        SafeAddString(SI_GUILD_ROSTER_INVITED_MESSAGE, GetString(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE_ALT), 2)
        SafeAddString(SI_PLAYER_TO_PLAYER_INCOMING_GUILD_REQUEST, GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST_ALT), 1)
        SafeAddString(SI_GUILD_INVITE_MESSAGE, GetString(SI_LUIE_CA_GUILD_INVITE_MESSAGE), 3)
        SafeAddString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST, GetString(SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST_ALT), 1)
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
        -- Mail String Replacements
        SafeAddString(SI_SENDMAILRESULT2, GetString(SI_LUIE_CA_MAIL_SENDMAILRESULT2), 1)
        SafeAddString(SI_SENDMAILRESULT3, GetString(SI_LUIE_CA_MAIL_SENDMAILRESULT3), 1)
        -- Regroup Replacement String
        SafeAddString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG, GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG_ALT), 1)
        
        -- Quest String Replacements
        SafeAddString(SI_ERROR_QUEST_LOG_FULL, GetString(SI_LUIE_CA_QUEST_LOG_FULL), 1) -- Add a period. TODO: Remove

    end
end

function CA.LFGJoined(eventCode, locationName)
    
    -- DEBUG OPTIONS
    --d("LFG JOINED")
    --if IsInLFGGroup() then d("We are in an LFG group") else d ("We are not in an LFG group") end
    
    if CA.SV.GroupLFG and not g_LFGJoinAntiSpam then
        printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_ALERT_LFG_JOINED), locationName))
        zo_callLater (function() g_rcUpdateDeclineOverride = false end, 5000)
        g_lfgDisableGroupEvents = true
        zo_callLater (function() g_lfgDisableGroupEvents = false end, 2500)
    end
    g_joinLFGOverride = true
    g_LFGJoinAntiSpam = true
    g_rcUpdateDeclineOverride = true
end

function CA.LFGLeft(eventCode)
    g_leaveLFGOverride = true
end

function CA.CheckLFGStatusJoin()
    if not g_stopGroupLeaveQueue then
        if not g_lfgDisableGroupEvents then
            if IsInLFGGroup() and not g_joinLFGOverride then
                printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF_LFG))
            elseif not IsInLFGGroup() and not g_joinLFGOverride then
                printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF))
            end
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
    if not (g_stopGroupLeaveQueue and g_lfgDisableGroupEvents) then
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
    -- This event sometimes fires when forming a group and will display with Type 0 and Index 1 (Craglorn)
    local name = GetLFGOption(activityType, activityIndex)
    if name == "Craglorn" then return end -- TODO: Localize - note can't use numbers here because if Type is nil it also returns as Craglorn

    
    local function printNameLater(name)
        printToChat(strformat(GetString(SI_LFG_FIND_REPLACEMENT_TEXT), name))
    end
    
    if CA.SV.GroupLFG then
        zo_callLater(function() printNameLater(name) end, 100)
    end
end

function CA.ActivityComplete(eventCode)
    printToChat(GetString(SI_ACTIVITY_FINDER_ACTIVITY_COMPLETE_ANNOUNCEMENT_TEXT))
end

function CA.ActivityStatusUpdate(eventCode, status)
    --d("status: " .. status)
    if g_showActivityStatus then
        -- If we are NOT queued and were formerly queued, forming group, or in a ready check, display left queue message.
        if status == ACTIVITY_FINDER_STATUS_NONE and (g_savedQueueValue == 1 or g_savedQueueValue == 4) then
            if CA.SV.GroupLFG then printToChat(GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_END)) end
        end
        -- If we are queued and previously we were not queued then display a message.
        if status == ACTIVITY_FINDER_STATUS_QUEUED and (g_savedQueueValue == 0 or g_savedQueueValue == 2) then
            if CA.SV.GroupLFG then printToChat(GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_START)) end
        end
        -- If we were in the queue and are now in progress without a ready check triggered, we left the queue to find a replacement member so this should be displayed.
        if status == ACTIVITY_FINDER_STATUS_IN_PROGRESS and (g_savedQueueValue == 1) then
            if CA.SV.GroupLFG then printToChat(GetString(SI_LUIE_CA_GROUPFINDER_QUEUE_END)) end
        end
        if g_savedQueueValue == 5 and status == 1 then status = 5 end -- Fixes an error that occurs when joining an LFG instance while already in an LFG group.    
    end

    if status == 0 then
        g_showRCUpdates = true
    end -- Should always trigger at the end result of a ready check failing.
    if status == 4 then
        g_showRCUpdates = false
    end

    -- Prevents potential consecutive events from spamming
    if status == 5 and g_savedQueueValue ~= 5 then
        printToChat(GetString(SI_LFGREADYCHECKCANCELREASON4))
        g_stopGroupLeaveQueue = true
        g_showRCUpdates = true
        g_LFGJoinAntiSpam = false
        g_showActivityStatus = false
        zo_callLater(CA.ActivityStatusRefresh, 1000)
        zo_callLater(CA.ResetGroupLeaveQueue, 1000)
    end
    
    g_savedQueueValue = status
    
end

function CA.ActivityQueueResult(eventCode, result)
    if CA.SV.GroupLFG then
        printToChat(GetString("SI_ACTIVITYQUEUERESULT", result))
    end   
    --[[ Old Option just in case this is printing duplicate messages or anything
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
    end
    ]]--

    g_showRCUpdates = true
end

function CA.ReadyCheckCancel(eventCode, reason)
    --d("Ready check cancel")

    if reason ~= LFG_READY_CHECK_CANCEL_REASON_NOT_IN_READY_CHECK and reason ~= LFG_READY_CHECK_CANCEL_REASON_GROUP_FORMED_SUCCESSFULLY then
        if CA.SV.GroupLFG then printToChat(GetString("SI_LFGREADYCHECKCANCELREASON", reason)) end
    end
    
    -- Sometimes if another player cancels slightly before a player in your group cancels, the "you have been placed in the front of the queue message displays. If this is the case, we want to show queue left for that event."
    if reason ~= LFG_READY_CHECK_CANCEL_REASON_GROUP_REPLACED_IN_QUEUE then
        g_showActivityStatus = false
        zo_callLater(CA.ActivityStatusRefresh, 1000)
    end
    
    g_showRCUpdates = true
end

function CA.ActivityStatusRefresh()
    g_showActivityStatus = true
end

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

        if playerRole ~= 0 then
            local roleIcon = (strformat("|t16:16:<<1>>|t", GetRoleIcon(playerRole)))
            local roleString = GetString("SI_LFGROLE", playerRole)
            if CA.SV.GroupLFG then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY_ROLE), activityName, roleIcon, roleString ))
            end
        else
            if CA.SV.GroupLFG then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY), activityName))
            end
        end
    end
    
    g_showRCUpdates = false
    
    if not g_showRCUpdates and (tanksAccepted == 0 and tanksPending == 0 and healersAccepted == 0 and healersPending == 0 and dpsAccepted == 0 and dpsPending == 0) and not g_rcUpdateDeclineOverride then
        if CA.SV.GroupLFG and g_rcSpamPrevention == false then
            printToChat(GetString(SI_LFGREADYCHECKCANCELREASON3))
            g_rcSpamPrevention = true
            zo_callLater(CA.ResetRCSpamPrevention, 1000)
            g_showActivityStatus = false
            zo_callLater(CA.ActivityStatusRefresh, 1000)
            g_showRCUpdates = true
        end
    end
    
end

function CA.ResetGroupLeaveQueue()
    g_stopGroupLeaveQueue = false
end

function CA.ResetRCSpamPrevention()
    g_rcSpamPrevention = false
end

function CA.VoteFailed( eventCode, failureReason, descriptor)
    if CA.SV.GroupVote then
        printToChat(GetString("SI_GROUPELECTIONFAILURE", failureReason))
    end
end

function CA.VoteNotify(eventCode)
    local electionType, timeRemainingSeconds, electionDescriptor, targetUnitTag = GetGroupElectionInfo()
    if electionType == 2 then -- Ready Check
        if CA.SV.GroupVote then
            printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_MESSAGE))
        end
    end

    if electionType == 3 then -- Vote Kick
        if CA.SV.GroupVote then
            local kickMemberName = GetUnitName(targetUnitTag)
            local kickMemberAccountName = GetUnitDisplayName(targetUnitTag)

            local characterNameLink = ZO_LinkHandler_CreateCharacterLink(kickMemberName)
            local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(kickMemberAccountName)
            local displayBothString = ( strformat("<<1>><<2>>", kickMemberName, kickMemberAccountName) )
            local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, kickMemberAccountName)
            if CA.SV.ChatPlayerDisplayOptions == 1 then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START), displayNameLink))
            end
            if CA.SV.ChatPlayerDisplayOptions == 2 then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START), characterNameLink))
            end
            if CA.SV.ChatPlayerDisplayOptions == 3 then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_START), displayBoth))
            end
        end
    end
end

function CA.VoteResult(eventCode, electionResult, descriptor)
    local electionType, timeRemainingSeconds, electionDescriptor, targetUnitTag = GetGroupElectionInfo()
    if descriptor == "[ZO_READY_CHECK]" then
        if CA.SV.GroupVote then
            if electionResult == 1 then
                printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_FAILED))
            end
            if electionResult == 4 then
                printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_PASSED))
            end
            if electionResult == 5 then
                printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_FAILED))
            end
        end
    end
    if descriptor == "[ZO_NONE]" then
        if CA.SV.GroupVote then
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
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL), KickCarry))
            end
            if electionResult == 2 then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL), KickCarry))
            end
            if electionResult == 4 then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED), KickCarry))
            end
            if electionResult == 5 then
                printToChat(strformat(GetString(SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL), KickCarry))
            end
        end
    end
end

function CA.VoteRequested(eventCode, descriptor)
    if CA.SV.GroupVote then
        if descriptor == "[ZO_READY_CHECK]" then
            printToChat(GetString(SI_GROUP_ELECTION_READY_CHECK_REQUESTED))
        end
        if descriptor == "[ZO_NONE]" then
            printToChat(GetString(SI_GROUP_ELECTION_REQUESTED))
        end
    end
end

function CA.TrialStarted(eventCode, trialName, weekly)
    local formattedName = strformat("|cFEFEFE<<1>>|r", trialName)
    printToChat(strformat(SI_TRIAL_STARTED, formattedName))
end

function CA.TrialComplete(eventCode, trialName, score, totalTime)
    local formattedName = strformat("|cFEFEFE<<1>>|r", trialName)
    printToChat(strformat(SI_TRIAL_COMPLETED_LARGE, formattedName))

    -- SI_LUIE_CA_GROUP_TRIAL_SCORETALLY          -- "Final Score <<1>> Total Time <<2>> Vitality Bonus <<3>> <<4>>"

    local wasUnderTargetTime = totalTime <= GetRaidTargetTime()
    local formattedTime = ZO_FormatTimeMilliseconds(totalTime, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_SECONDS)
    local vitalityBonus = GetCurrentRaidLifeScoreBonus()
    local currentCount = GetRaidReviveCountersRemaining()
    local maxCount = GetCurrentRaidStartingReviveCounters()

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

    printToChat(strformat(SI_LUIE_CA_GROUP_TRIAL_SCORETALLY, FinalScore, formattedTime, vitalityBonus, VitalityCounterString))
end

function CA.TrialFailed(eventCode, trialName, score)
    local formattedName = strformat("|cFEFEFE<<1>>|r", trialName)
    printToChat(strformat(SI_TRIAL_FAILED, formattedName))
end

function CA.TrialScore(eventCode, scoreType, scoreAmount, totalScore) 

    -- Table from ZOS code, determines icon based off criteria. Leaving sound here as well for the time being.
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

    local reasonAssets = TRIAL_SCORE_REASON_TO_ASSETS[scoreType]
    if reasonAssets then
        printToChat(strformat(SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED, reasonAssets.icon, scoreAmount))
    end

end

function CA.TrialBestScore(eventCode, trialName, score, isWeekly)
    local formattedString
    local formattedName = strformat("|cFEFEFE<<1>>|r", trialName)
    if isWeekly then
        formattedString = strformat(SI_TRIAL_NEW_BEST_SCORE_WEEKLY, formattedName)
    else
        formattedString = strformat(SI_TRIAL_NEW_BEST_SCORE_LIFETIME, formattedName)
    end

    -- Delay presumably in place so this message comes AFTER completion message.
    local function PrintTrialBestScore()
        printToChat(formattedString)
    end

    zo_callLater(PrintTrialBestScore, 50)
end

function CA.TrialReviveCounter(eventCode, currentCounter, countDelta)
    -- TODO: revisit this once there is a way to properly handle this in client/server code (from ZOS code, might be noteworthy)
    if not IsRaidInProgress() then
        return
    end
    
    if countDelta < 0 then
        printToChat(strformat(SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED, "EsoUI/Art/Trials/VitalityDepletion.dds"))
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
    if groupSize > 1 then
        g_areWeGrouped = true
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
function CA.OnGroupInviteResponse(eventCode, inviterName, response, inviterDisplayName)
    
    local link
    local nameToUse = ZO_GetPrimaryPlayerName(inviterDisplayName, inviterName)
                if nameToUse == "" then
                    nameToUse = ZO_GetSecondaryPlayerName(inviterDisplayName, inviterName)
                    link = ZO_LinkHandler_CreateDisplayNameLink(nameToUse)
                else
                    link = ZO_LinkHandler_CreateCharacterLink(nameToUse)
                end

    if nameToUse ~= "" then
        if response ~= 0 and response ~= 1 then
            printToChat(strformat(GetString("SI_GROUPINVITERESPONSE", response), link)) --or GetString(SI_PLAYER_BUSY)
        elseif response == 1 and g_playerName ~= inviterName then
            g_groupFormFudger = true
            printToChat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF))
        end
    end
end

-- Prints a message to chat when the leader of the group is updated
function CA.OnGroupLeaderUpdate(eventCode, leaderTag)
    local groupLeaderName = GetUnitName(leaderTag)
    local groupLeaderAccount = GetUnitDisplayName(leaderTag)
    
    -- Just in case we can't get a value (seems to happen sometimes in LFG)
    if groupLeaderName == "" or groupLeaderName == nil then return end

    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(groupLeaderName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(groupLeaderAccount)
    local displayBothString = ( strformat("<<1>><<2>>", groupLeaderName, groupLeaderAccount) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, groupLeaderAccount)
    
    local displayString
    local function displayGroupLeaderUpdate()
        if not g_lfgDisableGroupEvents then
            printToChat(displayString)
        end
    end
        
    if g_playerNameFormatted ~= groupLeaderName then -- If another player became the leader
        if CA.SV.ChatPlayerDisplayOptions == 1 then
            displayString = (strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), displayNameLink))
            zo_callLater(displayGroupLeaderUpdate, 100)
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            displayString = (strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), characterNameLink))
            zo_callLater(displayGroupLeaderUpdate, 100)
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            displayString = (strformat(GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED), displayBoth))
            zo_callLater(displayGroupLeaderUpdate, 100)
        end
    elseif g_playerNameFormatted == groupLeaderName then -- If the player character became the leader
        displayString = (GetString(SI_LUIE_CA_GROUP_LEADER_CHANGED_SELF))
        zo_callLater(displayGroupLeaderUpdate, 100)
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

    if joinedMemberName ~= "" and joinedMemberName ~= nil then
        if g_playerName ~= memberName then
            -- Can occur if event is before EVENT_PLAYER_ACTIVATED
            local groupJoinName
            local characterNameLink = ZO_LinkHandler_CreateCharacterLink(joinedMemberName)
            local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(joinedMemberAccountName)
            local displayBothString = ( strformat("<<1>><<2>>", joinedMemberName, joinedMemberAccountName) )
            local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, joinedMemberAccountName)
            if CA.SV.ChatPlayerDisplayOptions == 1 then
                groupJoinName = displayNameLink
            end
            if CA.SV.ChatPlayerDisplayOptions == 2 then
                groupJoinName = characterNameLink
            end
            if CA.SV.ChatPlayerDisplayOptions == 3 then
                groupJoinName = displayBoth
            end
            local SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_JOIN), groupJoinName))
            zo_callLater(function() CA.PrintJoinStatusNotSelf(SendString) end, 100)
        elseif g_playerName == memberName and not g_groupFormFudger then
            zo_callLater(CA.CheckLFGStatusJoin, 100)
        end
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

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        memberLeftName = displayNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        memberLeftName = characterNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        memberLeftName = displayBoth
    end

    if memberName ~= "" and memberName ~= nil then
        if reason == GROUP_LEAVE_REASON_VOLUNTARY then
            if g_playerName == memberName then
                g_areWeGrouped = false
                SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_LEAVE_SELF), memberLeftName))
                zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
                g_LFGJoinAntiSpam = false -- Variable for LFG Messages
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
                g_LFGJoinAntiSpam = false -- Variable for LFG Messages
            end
            if g_playerName ~= memberName then
                SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_KICKED), memberLeftName))
                zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
            end
        elseif reason == GROUP_LEAVE_REASON_DISBAND and g_playerName == memberName then
            g_areWeGrouped = false
            SendString = (strformat(GetString(SI_LUIE_CA_GROUP_MEMBER_DISBAND_MSG), memberLeftName))
            zo_callLater(function() CA.CheckLFGStatusLeave(SendString, WasKicked) end , 100)
            g_LFGJoinAntiSpam = false -- Variable for LFG Messages
        end
    end
end


------ TEMP TODO

-- Note, sentvalue here is an additional variable called when certain reasons are pushed through to this function to generate strings.
function CA.OnCurrencyUpdate(eventCode, currency, newValue, oldValue, reason)

    local UpOrDown = newValue - oldValue
    --[[ DEBUG
    d("currency: " .. currency)
    d("NV: " .. newValue)
    d("OV: " .. oldValue)
    d("reason: " .. reason)
    ]]
    
    -- TODO: Need to add more detailed filters here for certain conditionals!
    -- If the total gold change was 0 or (Reason 2 = Receieve Money in the Mail) or (Reason 7 = Command) or (Reason 28 = Mount Feed) or (Reason 35 = Player Init) - End Now
    if UpOrDown == 0 or reason == 2 or reason == 7 or reason == 28 or reason == 35 then
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
        if CA.SV.CurrencyGoldThrottle and (reason == 0 or reason == 13 or reason == 62) then
            -- TODO: Register Event here instead
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedGold")
            -- NOTE: Unlike other throttle events, we used zo_callLater here because we have to make the call immediately (if some of the gold is looted after items, the message will appear after the loot if we don't use zo_callLater instead of a RegisterForUpdate)
            zo_callLater( CA.CurrencyGoldThrottlePrinter, 50 )
            g_currencyGoldThrottleValue = g_currencyGoldThrottleValue + UpOrDown
            g_currencyGoldThrottleTotal = GetCarriedCurrencyAmount(1)
            return
        end
        
        -- If looted gold is below the filter value, end now.
        if CA.SV.CurrencyGoldFilter > 0 and (reason == 0 or reason == 13 or reason == 62) then
            if UpOrDown < CA.SV.CurrencyGoldFilter then
                return
            end
        end

        currencyTypeColor = CurrencyGoldColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
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
        
        currencyTypeColor = APColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/alliancepoints.dds|t" or ""
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
        
        currencyTypeColor = TVColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/currency_telvar.dds|t" or ""
        currencyName = strformat(CA.SV.CurrencyTVName, UpOrDown)
        currencyTotal = CA.SV.CurrencyTVShowTotal
        messageTotal = CA.SV.CurrencyMessageTotalTV

    elseif currency == 4 then -- Writ Vouchers
        currencyTypeColor = WVColorize:ToHex()
        currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/currency_writvoucher.dds|t" or ""
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
        changeType = ZO_LocalizeDecimalNumber(newValue - oldValue)
    elseif UpOrDown < 0 then
        if CA.SV.CurrencyContextColor then
            changeColor = CurrencyDownColorize:ToHex()
        else
            changeColor = CurrencyColorize:ToHex()
        end
        changeType = ZO_LocalizeDecimalNumber(oldValue - newValue)
    end

    -- Determine syntax based on reason
    -- Sell/Buy from a Merchant
    if reason == 1 and UpOrDown > 0 then
        messageChange = CA.SV.CurrencyMessageReceive
    elseif reason == 1 and UpOrDown < 0 then
        messageChange = CA.SV.CurrencyMessageSpend
    -- Receive/Give Money in a Trade (Likely consolidate this later)
    elseif reason == 3 and UpOrDown > 0 then
        messageChange = CA.SV.CurrencyMessageTradeIn
    elseif reason == 3 and UpOrDown < 0 then
        messageChange = CA.SV.CurrencyMessageTradeOut
    -- Receive from Quest Reward (4), Medal (21), AH Refund (32), Sell to Fence (63)
    elseif reason == 4 or reason == 21 or reason == 32 or reason == 63 then
        messageChange = CA.SV.CurrencyMessageReceive
    -- Bag Space (8)
    elseif reason == 8 then
        messageChange = CA.SV.CurrencyMessageStorage
        type = "LUIE_CURRENCY_BAG"
    -- Bank Space (9)
    elseif reason == 9 then
        messageChange = CA.SV.CurrencyMessageStorage
        type = "LUIE_CURRENCY_BANK"
    -- Spend - NPC Conversation (5), Wayshrine (19), Repairs (29), AH Listing Fee (33), Respec Skills (44), Respec Attributes (45),
    -- Unstuck (48), Edit Guild Heraldry (49), Buy Guild Tabard (50), Respec Morphs (55), Pay Fence (56), Launder (60), Champion Respec (61), Buyback (64)
    elseif reason == 5 or reason == 19 or reason == 29 or reason == 33 or reason == 44 or reason == 45 or reason == 48 or reason == 49 or reason == 50 or reason == 55 or reason == 56 or reason == 60 or reason == 61 or reason == 64 then
        messageChange = CA.SV.CurrencyMessageSpend
    -- Keep Reward (14), Keep Repair (40), PVP Resurrect (41)
    elseif reason == 14 or reason == 40 or reason == 41 then
        messageChange = CA.SV.CurrencyMessageEarn
    -- Buy on AH (31)
    elseif reason == 31 then
        if CA.SV.CurrencyGoldHideAH then return end
        messageChange = CA.SV.CurrencyMessageSpend
    -- Desposit in Bank (42) or Guild Bank (51)
    elseif reason == 42 or reason == 51 then
        messageChange = CA.SV.CurrencyMessageDeposit
    -- Withdraw from Bank (43) or Guild Bank (52)
    elseif reason == 43 or reason == 52 then
        messageChange = CA.SV.CurrencyMessageWithdraw
    -- Confiscated -- Pay to Guard (47) or Killed by Guard (57)
    elseif reason == 47 or reason == 57 then
        messageChange = CA.SV.CurrencyMessageConfiscate
    -- Pickpocketed (59)
    elseif reason == 59 then
        messageChange = GetString(SI_GAMECAMERAACTIONTYPE21)
    -- Looted - From Chest (0), Stolen Gold (62), Looted from Player/NPC (65)
    elseif reason == 0 or reason == 62 or reason == 65 then
        messageChange = CA.SV.CurrencyMessageLoot
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
function CA.CurrencyPrinter(formattedValue, changeColor, changeType, currencyTypeColor, currencyIcon, currencyName, currencyTotal, messageChange, messageTotal, type)

    local messageP1                                                     -- First part of message - Change
    local messageP2                                                     -- Second part of the message (if enabled) - Total

    messageP1 = ("|r|c" .. currencyTypeColor .. currencyIcon .. " " .. changeType .. currencyName .. "|r|c" .. changeColor)

    if currencyTotal then
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
                bagType = GetString(SI_LUIE_CA_STORAGE_BAGTYPE1)
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/icons/store_upgrade_bag.dds|t " or ""
            end
            if type == "LUIE_CURRENCY_BANK" then
                bagType = GetString(SI_LUIE_CA_STORAGE_BAGTYPE2)
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/icons/store_upgrade_bank.dds|t " or ""
            end
            return strfmt("|r" .. icon .. "|cFFFFFF" .. bagType .. "|r|c" .. changeColor)
        end
        formattedMessageP1 = (strfmt(messageChange, ResolveStorageType(), messageP1))
    elseif type == "LUIE_CURRENCY_RIDING_SPEED" or type == "LUIE_CURRENCY_RIDING_CAPACITY" or type == "LUIE_CURRENCY_RIDING_STAMINA" then
        local function ResolveRidingStats()
            -- if somevar then icon = else no
            local skillType
            local icon
            if type == "LUIE_CURRENCY_RIDING_SPEED" then
                skillType = GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE1)
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_speed.dds|t " or ""
            elseif type == "LUIE_CURRENCY_RIDING_CAPACITY" then
                skillType = GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE2)
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_capacity.dds|t " or ""
            elseif type == "LUIE_CURRENCY_RIDING_STAMINA" then
                skillType = GetString(SI_LUIE_CA_STORAGE_RIDINGTYPE3)
                icon = CA.SV.LootIcons and "|t16:16:/esoui/art/mounts/ridingskill_stamina.dds|t " or ""
            end
            return strfmt("|r" .. icon .. "|cFFFFFF" .. skillType .. "|r|c" .. changeColor)
        end
        formattedMessageP1 = (strfmt(messageChange, ResolveRidingStats(), messageP1))
    else
        formattedMessageP1 = (strfmt(messageChange, messageP1))
    end
    local formattedMessageP2 = (strfmt(messageTotal, messageP2))
    local finalMessage
    if currencyTotal then
        finalMessage = strfmt("|c%s%s|r |c%s%s|r", changeColor, formattedMessageP1, changeColor, formattedMessageP2)
    else
        finalMessage = strfmt("|c%s%s|r", changeColor, formattedMessageP1)
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
        local changeColor = CurrencyUpColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyGoldThrottleValue)
        local currencyTypeColor = CurrencyGoldColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
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
        local changeColor = CurrencyUpColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyAPThrottleValue)
        local currencyTypeColor = APColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/alliancepoints.dds|t" or ""
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
        local changeColor = CurrencyUpColorize:ToHex()
        local changeType = ZO_LocalizeDecimalNumber(g_currencyTVThrottleValue)
        local currencyTypeColor = TVColorize:ToHex()
        local currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/currency_telvar.dds|t" or ""
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

-- Writ Voucher Change Announcements
function CA.OnWritVoucherUpdate(eventCode, newWritVouchers, oldWritVouchers, reason)
--[[
    -- Print a message to chat based off all the values we filled in above
    if CA.SV.LootCurrencyCombo and UpOrDown < 0 then
        g_comboString = (strfmt(" → %s%s%s", message, syntax, total))
    else
        printToChat(strfmt("%s%s%s", message, syntax, total))
    end
    ]]--
end

local function ResetLockpickBroken()
    g_lockpickBroken = false
end

function CA.MiscAlertLockBroke(eventCode, inactivityLengthMs)
    if CA.SV.ShowLockpickBreak then
        g_lockpickBroken = true
        zo_callLater(ResetLockpickBroken, 200)
    end
end

function CA.MiscAlertLockFailed(eventCode)
    if CA.SV.MiscLockpick then
        printToChat(GetString(SI_LUIE_CA_LOCKPICK_FAILED))
    end
    if CA.SV.ShowLockpickBreak then
        g_lockpickBroken = true
        zo_callLater(ResetLockpickBroken, 200)
    end
end

function CA.MiscAlertLockSuccess(eventCode)
    if CA.SV.MiscLockpick then
        printToChat(GetString(SI_LUIE_CA_LOCKPICK_SUCCESS))
    end
    if CA.SV.ShowLockpickBreak then
        g_lockpickBroken = true
        zo_callLater(ResetLockpickBroken, 200)
    end
end

function CA.MiscAlertLockImpossible(eventCode, interactableName)
    printToChat(strformat(GetString(SI_LOCKPICK_IMPOSSIBLE_LOCK), interactableName))
end

function CA.MiscAlertLockLocked(eventCode, interactableName)
    printToChat(strformat(GetString(SI_LOCKPICK_NO_KEY_AND_NO_LOCK_PICKS), interactableName))
end

function CA.MiscAlertHorse(eventCode, ridingSkillType, previous, current, source)
  
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
    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon

    icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

    local logPrefix = GetString(SI_ITEMFILTERTYPE8)
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    local receivedBy = ""
    local gainOrLoss = 1

    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainOrLoss)
end

function CA.OnBuyItem(eventCode, itemName, entryType, quantity, money, specialCurrencyType1, specialCurrencyInfo1, specialCurrencyQuantity1, specialCurrencyType2, specialCurrencyInfo2, specialCurrencyQuantity2, itemSoundCategory)
    local icon
    local itemIcon,_,_,_,_ = GetItemLinkInfo(itemName)
    icon = itemIcon

    icon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_PURCHASED)
    if CA.SV.ItemContextToggle then
        logPrefix = ( CA.SV.ItemContextMessage )
    end

    local receivedBy = ""
    local gainOrLoss = 1

    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainOrLoss)
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
    local gainOrLoss = 2

    CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainOrLoss)
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

        if CA.SV.ChatPlayerDisplayOptions == 1 then
            failName = displayNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 2 then
            failName = characterNameLink
        end
        if CA.SV.ChatPlayerDisplayOptions == 3 then
            failName = displayBoth
        end

        printToChat(strformat(GetString("SI_TRADEACTIONRESULT", reason), failName))
    end
end

function CA.TradeElevationFailed(eventCode, reason, itemName)
    if CA.SV.MiscTrade then
        printToChat(strformat(GetString("SI_TRADEACTIONRESULT", reason), itemName))
    end
end

function CA.TradeItemAddFailed(eventCode, reason, itemName)
    if CA.SV.MiscTrade then
        printToChat(strformat(GetString("SI_TRADEACTIONRESULT", reason), itemName))
    end
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
        local tradeitemlink = GetTradeItemLink (who, tradeIndex, LINK_STYLE_BRACKETS)
        g_tradeStacksOut[indexOut] = {stack=stack, name=name, icon=icon, itemlink=tradeitemlink}
    else
        local indexIn = tradeIndex
        local name, icon, stack = GetTradeItemInfo (who, tradeIndex)
        local tradeitemlink = GetTradeItemLink (who, tradeIndex, LINK_STYLE_BRACKETS)
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
    d("Trade Complete Event")
    g_comboString = ""

    g_tradeDisablePrint = true
    -- Disables print to chat from item indexing momentarily while out trade results process!
    local function ResetItemPrinting()
        g_tradeDisablePrint = false
    end

    zo_callLater(ResetItemPrinting, 500)

    if CA.SV.MiscTrade then
        printToChat(GetString(SI_TRADE_COMPLETE))
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
                local gainOrLoss = 2
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
                CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainOrLoss, istrade)
            end
        end

        for indexIn = 1,5 do
            if g_tradeStacksIn[indexIn] ~= nil then
                local gainOrLoss = 1
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
                CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainOrLoss, istrade)
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
    g_mailMoneyBackup = moneyAmount
    g_mailCOD = 0
    g_mailCODBackup = 0
    g_postageAmount = GetQueuedMailPostage()
end

function CA.MailCODChanged(eventCode, codAmount)
    g_mailCOD = codAmount
    g_mailCODBackup = codAmount
    g_mailMoney = 0
    g_mailMoneyBackup = 0
    g_postageAmount = GetQueuedMailPostage()
end

function CA.MailRemoved(eventCode)
    if CA.SV.MiscMail then
        printToChat(GetString(SI_LUIE_CA_MAIL_DELETED_MSG))
    end
    g_saveMailId = ""
end

function CA.OnMailReadable(eventCode, mailId)
    g_mailStacks = 0

    local numAttachments = GetMailAttachmentInfo( mailId )

    for i = 1, numAttachments do
        g_mailStacks = g_mailStacks + 1
    end
    g_saveMailId = mailId
end

function CA.OnMailTakeAttachedItem(eventCode, mailId)
    d("Attachment Removed")
    local plural = "s"
    if g_mailStacks == 1 then
        plural = ""
    end
    -- If we've already looted an item from this indexed mail and our inventory was full, don't try to print another message
    if g_mailStacks == 0 then
        return
    end

    g_mailStringPart1 = (strformat(GetString(SI_LUIE_CA_MAIL_RECEIVED_ATTACHMENT), g_mailStacks, plural) )
    zo_callLater(PrintMailAttachmentsIfNoGold, 25) -- We call this with a super short delay, it will return a string as long as a currency change event doesn't trigger beforehand!

    g_mailStacks = 0
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
    local mailitemlink = GetMailQueuedAttachmentLink(attachmentSlot, LINK_STYLE_BRACKETS)
    g_mailStacksOut[mailIndex] = {stack=stack, name=name, icon=icon, itemlink=mailitemlink}
end

-- Removes items from index if they are removed from the trade
function CA.OnMailAttachRemove(eventCode, attachmentSlot)
    g_postageAmount = GetQueuedMailPostage()
    local mailIndex = attachmentSlot
    g_mailStacksOut[mailIndex] = nil
end

function CA.OnMailOpenBox(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.LootMail then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
        g_inventoryStacks = {}
        CA.IndexInventory() -- Index Inventory
    end
    if g_saveMailId ~= "" then
        CA.OnMailReadable(eventCode, g_saveMailId)
    end
    g_weAreInMail = true
end

function CA.OnMailCloseBox(eventCode)
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE)
    if CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak) then
        g_inventoryStacks = {}
    end
    g_mailStacksOut = {}
    g_weAreInMail = false
end

function CA.OnMailFail(eventCode, reason)
    local function RestoreMailBackupValues()
        g_postageAmount = GetQueuedMailPostage()
        g_mailCOD = g_mailCODBackup
        g_mailMoney = g_mailMoneyBackup
        g_mailCODBackup = 0
        g_mailMoneyBackup = 0
    end

    if CA.SV.MiscMail then
        printToChat(GetString("SI_SENDMAILRESULT", reason))
        g_mailStop = true -- Prevents mail received message from firing on a failed sent mail
        zo_callLater(CA.MailClearVariables, 50)
    end
    zo_callLater(RestoreMailBackupValues, 50) -- Prevents values from being cleared by failed message (when inbox is full, the currency change fires first regardless and then is refunded)
end

function CA.MailClearVariables()
    g_mailStop = false
    g_mailCurrencyCheck = true
end

-- Sends results of the trade to the Item Log print function and clears variables so they are reset for next trade interactions
function CA.OnMailSuccess(eventCode)
    d("Mail sent event")
    g_comboString = ""
    zo_callLater(CA.FunctionMailCurrencyCheck, 50)

    if CA.SV.LootMail then
        for mailIndex = 1,6 do -- Have to iterate through all 6 possible mail attachments, otherwise nil values will bump later items off the list potentially.
            if g_mailStacksOut[mailIndex] ~= nil then
                local gainOrLoss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_SENT)
                if CA.SV.ItemContextToggle then
                    logPrefix = ( CA.SV.ItemContextMessage )
                end
                local receivedBy = ""
                local item = g_mailStacksOut[mailIndex]
                icon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
                local itemType = GetItemLinkItemType(item.itemlink)
                --CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false, _, _, tradevalue) Hanging onto this for now
                CA.LogItem(logPrefix, icon, item.itemlink, itemType, item.stack or 1, receivedBy, gainOrLoss)
            end
        end
    end

    g_mailStacksOut = {}
    g_mailCOD = 0
    g_mailCODBackup = 0
    g_mailMoney = 0
    g_mailMoneyBackup = 0
    g_postageAmount = 0
end

function CA.FunctionMailCurrencyCheck()
    if g_mailCurrencyCheck and CA.SV.MiscMail then
        printToChat(GetString(SI_LUIE_CA_MAIL_SENT_SUCCESS))
    end
end

function CA.OnChampionUpdate(eventCode, unitTag, oldChampionPoints, currentChampionPoints)

    --"Gained <<1[$d Champion Point/$d Champion Points]>>", -- SI_CHAMPION_POINT_EARNED
    --"<<1>> |t16:16:<<X:2>>|t <<3>> <<1[Point/Points]>>", -- SI_CHAMPION_POINT_TYPE
    
    -- adding one so that we are starting from the first gained point instead of the starting champion points
    
    --[[
    local pointsEarned = currentChampionPoints - oldChampionPoints
    local endingPoints = currentChampionPoints
    local startingPoints = oldChampionPoints + 1
    local championPointsByType = { 0, 0, 0 }

    while startingPoints <= endingPoints do
        local pointType = GetChampionPointAttributeForRank(startingPoints)
        championPointsByType[pointType] = championPointsByType[pointType] + 1
        startingPoints = startingPoints + 1
    end
    
    printToChat(LevelUpColorize:Colorize(strformat(SI_CHAMPION_POINT_EARNED, oldChampionPoints)) .. "(" .. GetString(SI_MAIN_MENU_CHAMPION) .. currentChampionPoints .. ")")
    
    for pointType,amount in pairs(championPointsByType) do
        if amount > 0 then
            local icon = CA.SV.ExperienceLevelUpIcon and strformat(" |t16:16:<<X:1>>|t", GetChampionPointAttributeHUDIcon(pointType)) or ( " " )
            local constellationGroupName = ZO_Champion_GetUnformattedConstellationGroupNameFromAttribute(pointType)
            if CA.SV.ExperienceLevelColorByLevel then
                printToChat(ZO_CP_BAR_GRADIENT_COLORS[pointType][2]:Colorize(strformat(SI_LUIE_CHAMPION_POINT_TYPE, amount, icon, constellationGroupName)))
            else
                printToChat(LevelUpColorize:Colorize(strformat(SI_LUIE_CHAMPION_POINT_TYPE, amount, icon, constellationGroupName)))
            end
        end
    end
    
    ]]
end

function CA.SkillPointsChanged(eventCode, pointsBefore, pointsNow, partialPointsBefore, partialPointsNow)

-- TODO: Unregister, remove!

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
        -- TODO: Possibly integrate this XP dump into something else too? Currently this fires after other events like the Wayshrine discovery message so it looks odd still.
        if CA.SV.ExperienceThrottle > 0 and g_xpCombatBufferValue > 0 and (reason ~= 0 and reason ~= 99) then
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "BufferedXP")
            CA.PrintBufferedXP()
        end
        
        CA.PrintExperienceGain(change)

    end
end

function CA.PrintExperienceGain(change)
    local icon = CA.SV.ExperienceIcon and ("|t16:16:/esoui/art/icons/icon_experience.dds|t ") or ""
    local messageP1 = ("|r|c" .. ExperienceNameColorize .. icon .. ZO_LocalizeDecimalNumber(change) .. " " .. CA.SV.ExperienceName .. "|r|c" .. ExperienceMessageColorize)
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

function CA.PrintAchievementDetails(stringpart1, stringpart2, stringpart3, stringpart4)
    printToChat( strfmt("%s%s%s%s", stringpart1, stringpart2, stringpart3, stringpart4))
end

function CA.OnAchievementUpdated(eventCode, id)
    --d("Achievement Updated")

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
        if ( totalCmp == totalReq ) or ( totalCmp == 1 ) or ( CA.SV.AchievementsStep == 0 ) then
            showInfo = true
        else
            -- Achievement step hit
            local percentage = math.floor( 100 / totalReq * totalCmp )

            if percentage > 0 and percentage % CA.SV.AchievementsStep == 0 and g_lastPercentage[id] ~= percentage then
                showInfo = true
                g_lastPercentage[id] = percentage
            end
        end
    end

    -- Bail out here if this achievement update event is not going to be printed to chat
    if not showInfo then
        return
    end
    
    local bracket1
    local bracket2

    if CA.SV.AchievementsBracketOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.AchievementsBracketOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.AchievementsBracketOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.AchievementsBracketOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end
    
    local link = strformat(GetAchievementLink(id, LINK_STYLE_BRACKETS))
    local catName = GetAchievementCategoryInfo(topLevelIndex)
    local subcatName = categoryIndex ~= nil and GetAchievementSubCategoryInfo(topLevelIndex, categoryIndex) or "General"
    local _, _, _, icon = GetAchievementInfo(id)
    icon = CA.SV.AchievementsIcon and ("|t16:16:" .. icon .. "|t ") or ""
    
    local stringpart1 = AchievementsColorize:Colorize(strfmt("%s %s%s (", CA.SV.AchievementsProgressMsg, icon, link))
    
    local stringpart2 = CA.SV.AchievementsColorProgress and strfmt("|c%s%d%%|r", AchievementPctToColour(totalCmp/totalReq), math.floor(100*totalCmp/totalReq)) or AchievementsColorize:Colorize(strfmt("%d%%", math.floor(100*totalCmp/totalReq)))
    
    local stringpart3
    if CA.SV.AchievementsCategory and CA.SV.AchievementsSubcategory then
        stringpart3 = AchievementsColorize:Colorize(strfmt(") %s%s - %s%s", bracket1, catName, subcatName, bracket2))
    elseif CA.SV.AchievementsCategory and not CA.SV.AchievementsSubcategory then
        stringpart3 = AchievementsColorize:Colorize(strfmt(") %s%s%s", bracket1, catName, bracket2))
    else
        stringpart3 = AchievementsColorize:Colorize(")")
    end
    
    -- Prepare details information
    local stringpart4 = ""
    if CA.SV.AchievementsDetails then
        -- Skyshards needs separate treatment otherwise text become too long
        -- We also put this short information for achievements that has too many subitems
        if topLevelIndex == 9 or #cmpInfo > 12 then
            stringpart4 = CA.SV.AchievementsColorProgress and strfmt( " %s|c%s%d|r%s|c71DE73%d|c87B7CC|r%s", AchievementsColorize:Colorize("("), AchievementPctToColour(totalCmp/totalReq), totalCmp, AchievementsColorize:Colorize("/"), totalReq, AchievementsColorize:Colorize(")") ) or AchievementsColorize:Colorize(strfmt( " (%d/%d)", totalCmp, totalReq))
        else
            for i = 1, #cmpInfo do
                -- Boolean achievement stage
                if cmpInfo[i][3] == 1 then
                    cmpInfo[i] = CA.SV.AchievementsColorProgress and strfmt( "|c%s%s", AchievementPctToColour(cmpInfo[i][2]), cmpInfo[i][1] ) or AchievementsColorize:Colorize(strfmt( "%s%s", cmpInfo[i][2], cmpInfo[i][1] ))
                -- Others
                else
                    local pct = cmpInfo[i][2] / cmpInfo[i][3]
                    cmpInfo[i] = CA.SV.AchievementsColorProgress and strfmt( "%s %s|c%s%d|r%s|c71DE73%d|r%s", AchievementsColorize:Colorize(cmpInfo[i][1]), AchievementsColorize:Colorize("("), AchievementPctToColour(pct), cmpInfo[i][2], AchievementsColorize:Colorize("/"), cmpInfo[i][3], AchievementsColorize:Colorize(")") ) or AchievementsColorize:Colorize(strfmt( "%s (%d/%d)", cmpInfo[i][1], cmpInfo[i][2], cmpInfo[i][3] ))
                end
            end
            stringpart4 = " " .. table.concat(cmpInfo, AchievementsColorize:Colorize(", ")) .. ""
        end
    end
    zo_callLater(function() CA.PrintAchievementDetails(stringpart1, stringpart2, stringpart3, stringpart4) end, 100)
end

function CA.OnAchievementAwarded(eventCode, name, points, id, link)
    --d("Achievement Completed!")

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
    
    local bracket1
    local bracket2

    if CA.SV.AchievementsBracketOptions == 1 then
        bracket1 = "["
        bracket2 = "]"
    elseif CA.SV.AchievementsBracketOptions == 2 then
        bracket1 = "("
        bracket2 = ")"
    elseif CA.SV.AchievementsBracketOptions == 3 then
        bracket1 = ""
        bracket2 = " -"
    elseif CA.SV.AchievementsBracketOptions == 4 then
        bracket1 = ""
        bracket2 = ""
    end
    
    link = strformat(GetAchievementLink(id, LINK_STYLE_BRACKETS))
    local catName = GetAchievementCategoryInfo(topLevelIndex)
    local subcatName = categoryIndex ~= nil and GetAchievementSubCategoryInfo(topLevelIndex, categoryIndex) or "General"
    local _, _, _, icon = GetAchievementInfo(id)
    icon = CA.SV.AchievementsIcon and ("|t16:16:" .. icon .. "|t ") or ""
    
    local stringpart1 = AchievementsColorize:Colorize(strfmt("%s %s%s", CA.SV.AchievementsCompleteMsg, icon, link))
    
    local stringpart2
    if CA.SV.AchievementsCompPercentage then 
        stringpart2 = CA.SV.AchievementsColorProgress and strfmt(" %s|c71DE73%s|r%s", AchievementsColorize:Colorize("("), ("100%"), AchievementsColorize:Colorize(")")) or AchievementsColorize:Colorize (" (100%)")
    else
        stringpart2 = ""
    end
    
    local stringpart3
    if CA.SV.AchievementsCategory and CA.SV.AchievementsSubcategory then
        stringpart3 = AchievementsColorize:Colorize(strfmt(" %s%s - %s%s", bracket1, catName, subcatName, bracket2))
    elseif CA.SV.AchievementsCategory and not CA.SV.AchievementsSubcategory then
        stringpart3 = AchievementsColorize:Colorize(strfmt(" %s%s%s", bracket1, catName, bracket2))
    else
        stringpart3 = AchievementsColorize:Colorize("")
    end
    local stringpart4 = ""
    
    zo_callLater(function() CA.PrintAchievementDetails(stringpart1, stringpart2, stringpart3, stringpart4) end, 100)
    
end

function CA.GuildBankItemAdded(eventCode, slotId)
    zo_callLater(CA.LogGuildBankChange, 50)
end

function CA.GuildBankItemRemoved(eventCode, slotId)
    zo_callLater(CA.LogGuildBankChange, 50)
end

function CA.LogGuildBankChange()
    CA.LogItem(g_guildBankCarryLogPrefix, g_guildBankCarryIcon, g_guildBankCarryItemLink, g_guildBankCarryItemType, g_guildBankCarryStackCount or 1, g_guildBankCarryReceivedBy, g_guildBankCarrygainOrLoss)
    g_guildBankCarryLogPrefix   = ""
    g_guildBankCarryIcon        = ""
    g_guildBankCarryItemLink    = ""
    g_guildBankCarryStackCount  = 1
    g_guildBankCarryReceivedBy  = ""
    g_guildBankCarrygainOrLoss  = ""
    g_guildBankCarryItemType    = ""
end

function CA.IndexInventory()
    --d("Debug - Inventory Indexed!")
    local bagsize = GetBagSize(1)

    for i = 0,bagsize do
        local icon, stack = GetItemInfo(1, i)
        local itemType = GetItemType(1, i)
        local itemId = GetItemId(1, i)
        local itemLink = GetItemLink(1, i, LINK_STYLE_BRACKETS)
        if itemlink ~= "" then
            g_inventoryStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink}
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
        local itemLink = GetItemLink(0, i, LINK_STYLE_BRACKETS)
        if itemLink ~= "" then
            g_equippedStacks[i] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink}
        end
    end
end

function CA.IndexBank()
    --d("Debug - Bank Indexed!")
    local bagsizebank = GetBagSize(2)
    local bagsizesubbank = GetBagSize(6)

    for i = 0,bagsizebank do
        local icon, stack = GetItemInfo(2, i)
        local bagitemlink = GetItemLink(2, i, LINK_STYLE_BRACKETS)
        if bagitemlink ~= "" then
            g_bankStacks[i] = { icon=icon, stack=stack, itemlink=bagitemlink}
        end
    end
    
    for i = 0,bagsizesubbank do
        local icon, stack = GetItemInfo(6, i)
        local bagitemlink = GetItemLink(6, i, LINK_STYLE_BRACKETS)
        if bagitemlink ~= "" then
            g_banksubStacks[i] = { icon=icon, stack=stack, itemlink=bagitemlink}
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
    if CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak) then
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
    if CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak) then
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
    if CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak) then
        g_inventoryStacks = {}
    end
end

function CA.FenceOpen(eventCode, allowSell, allowLaunder)
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
    if CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, CA.InventoryUpdate)
    end
    if not (CA.SV.Loot or CA.SV.ShowDestroy or CA.SV.ShowConfiscate or CA.SV.ShowDisguise or CA.SV.ShowLockpickBreak) then
        g_inventoryStacks = {}
    end
    g_weAreInAStore = false
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

-- TODO: Replace
function CA.PrintInventoryIndexChanges(itemId, seticon, item, itemType, stackCountChange, receivedBy, gainOrLoss)

end

function CA.OnLootReceived(eventCode, receivedBy, itemLink, quantity, itemSound, lootType, lootedBySelf, isPickpocketLoot, questItemIcon, itemId)

    g_comboString = ""
    if lootedBySelf then
        --d("Loot Received (Self)")
        g_isLooted = true
        
        local function ResetIsLooted()
            g_isLooted = false
            EVENT_MANAGER:UnregisterForUpdate(moduleName .. "ResetLooted")
        end
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "ResetLooted", 200, ResetIsLooted )
    else
        --d("Another dude looted")
    end

    -- If we didn't receive the loot, and we don't have Only Notable loot shown then we ignore the rest of this event and everything is passed to Index functions
    if lootedBySelf and lootType ~= LOOT_TYPE_QUEST_ITEM then
        return
    end
    if not CA.SV.LootGroup then
        return
    end

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

    local gainOrLoss = 1

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
end

function CA.LogItem(logPrefix, icon, itemName, itemType, quantity, receivedBy, gainOrLoss, istrade)

    --[[
    if g_oldItemLink ~= "" then
        itemName2 = (strfmt("%s → ", g_oldItemLink:gsub("^|H0", "|H1", 1)))
        g_oldItemLink = ""
    else
        itemName2 = ""
    end
    ]]

    --[[
    if receivedBy == "CRAFT"  and gainOrLoss == 1 then
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

    if receivedBy == "CRAFT"  and gainOrLoss == 2 then
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
            "%s%s%s%s%s%s%s%s%s%s%s",
            message,
            icon,
            itemName2,
            itemName:gsub("^|H0", "|H1", 1),
            formattedQuantity,
            formattedArmorType,
            formattedTrait,
            formattedStyle,
            formattedRecipient,
            total,
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
            formattedRecipient,
            total
        )) end
    end

    g_launderCheck = false
    g_comboString = ""
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
    elseif gainOrLoss == 3 then
        color = ZO_SELECTED_TEXT:ToHex()
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
        formattedRecipient = strfmt(
            "%s |c%06X|H0:character:%s|h%s|h|r",
            arrowPointer,
            HashString(receivedBy) % 0x1000000, -- Use the hash of the name for the color so that is random, but consistent
            receivedBy,
            receivedBy:gsub("%^%a+$", "", 1)
        )
    end
    
    if (stack > 1) then
        formattedQuantity = strfmt(" |cFFFFFFx%d|r", stack)
    else
        formattedQuantity = ""
    end
    
    local armorType = GetItemLinkArmorType(itemLink) -- Get Armor Type of item
    formattedArmorType = (CA.SV.LootShowArmorType and armorType ~= ARMORTYPE_NONE and logPrefix ~= GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED) ) and strfmt(" |cFFFFFF(%s)|r", GetString("SI_ARMORTYPE", armorType)) or ""
    
    local traitType = GetItemLinkTraitInfo(itemLink) -- Get Trait type of item
    formattedTrait = (CA.SV.LootShowTrait and traitType ~= ITEM_TRAIT_TYPE_NONE and itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT and logPrefix ~= GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED) ) and strfmt(" |cFFFFFF(%s)|r", GetString("SI_ITEMTRAITTYPE", traitType)) or ""
    
    local styleType = GetItemLinkItemStyle(itemLink) -- Get Style of the item
    formattedStyle = (CA.SV.LootShowStyle 
        and styleType ~= ITEMSTYLE_NONE 
        and styleType ~= ITEMSTYLE_UNIQUE 
        and styleType ~= ITEMSTYLE_UNIVERSAL 
        and itemType ~= ITEMTYPE_STYLE_MATERIAL
        and itemType ~= ITEMTYPE_GLYPH_ARMOR 
        and itemType ~= ITEMTYPE_GLYPH_JEWELRY 
        and itemType ~= ITEMTYPE_GLYPH_WEAPON 
        and logPrefix ~= GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED) )
    and strfmt(" |cFFFFFF(%s)|r", GetItemStyleName(styleType)) or ""
    
    local formattedTotal = ""
    if CA.SV.LootTotal and formattedRecipient == "" and receivedBy ~= "LUIE_INVENTORY_UPDATE_DISGUISE" then
        local total1, total2, total3 = GetItemLinkStacks(itemLink)
        local total = total1 + total2 + total3
        if total > 1 then
            formattedTotal = strfmt(" |c%s%s|r %s|cFEFEFE%s|r", color, CA.SV.LootTotalString, formattedIcon, ZO_LocalizeDecimalNumber(total))
        end
    end
    
    local itemString = strfmt("%s%s%s%s%s%s", formattedIcon, itemLink, formattedQuantity, formattedArmorType, formattedTrait, formattedStyle)
    
    -- Printer function, seperate handling for listed entires (from crafting) or simple function that sends a message over to the printer.
    if receivedBy == "CRAFT" and gainOrLoss == 1 then
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
    elseif receivedBy == "CRAFT" and gainOrLoss == 2 then
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
        if g_isLooted and not g_itemReceivedIsQuestReward then
            logPrefix = CA.SV.LootMessageLoot
            -- reset variables that control looted, or at least ZO_CallLater them
        else
            logPrefix = CA.SV.LootMessageReceive
        end
    end
    
    local formattedMessageP1
    local formattedMessageP2
    
    -- Adds additional string for previous variant of an item when an item is upgraded.
    if logPrefix == GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED) and g_oldItem ~= nil and g_oldItem.itemLink ~= "" then
        local formattedIcon = (CA.SV.LootIcons and g_oldItem.icon ~= "") and zo_strformat("<<1>> ", zo_iconFormat(g_oldItem.icon, 16, 16)) or ""
        local formattedMessageUpgrade = ("|r" .. formattedIcon .. g_oldItem.itemLink .. "|c" .. color)
        formattedMessageP1 = ("|r" .. message .. "|c" .. color)
        formattedMessageP2 = strfmt(logPrefix, formattedMessageUpgrade, formattedMessageP1)
        g_oldItem = { }
    else
        formattedMessageP1 = ("|r" .. message .. "|c" .. color)
        formattedMessageP2 = strfmt(logPrefix, formattedMessageP1)
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
	local zos_Smithing = SMITHING.SetMode
	SMITHING.SetMode = function(...)
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
    local zos_Enchanting = ENCHANTING.SetEnchantingMode
	ENCHANTING.SetEnchantingMode = function(...)
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
end

    
function CA.InventoryUpdate(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end

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
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_equippedStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            if CA.SV.ShowDisguise and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                gainOrLoss = 3
                receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                logPrefix = CA.SV.LootMessageDisguiseEquip
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            end
        -- EXISTING ITEM    
        elseif g_equippedStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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
                if CA.SV.ShowDisguise and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
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
                if g_itemWasDestroyed and CA.SV.ShowDestroy then
                    gainOrLoss = 2
                    logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if CA.SV.ShowDisguise and not g_itemWasDestroyed and slotId == 10 and (itemType == ITEMTYPE_COSTUME or itemType == ITEMTYPE_DISGUISE) then
                    if IsUnitInCombat("player") then
                        logPrefix = CA.SV.LootMessageDisguiseDestroy
                        receivedBy = "LUIE_INVENTORY_UPDATE_DISGUISE"
                        gainOrLoss = 2
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
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = 1
            logPrefix = ""
            if not g_weAreInAStore and CA.SV.Loot and isNewItem then
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
            end
        -- EXISTING ITEM    
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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
                gainOrLoss = 1
                logPrefix = ""
                if not g_weAreInAStore and CA.SV.Loot and isNewItem then
                    CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
                end
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                if g_itemWasDestroyed and CA.SV.ShowDestroy then
                    gainOrLoss = 2
                    logPrefix = CA.SV.LootMessageDestroy
                    CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
                end
                if CA.SV.ShowLockpickBreak and g_lockpickBroken then
                    logPrefix = CA.SV.LootMessageLockpick
                    gainOrLoss = 2
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
    
    if bagId == BAG_VIRTUAL then
        local gainOrLoss = 1
        local logPrefix = ""
        local itemLink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemLink)
        local itemType = GetItemLinkItemType(itemLink) 
        local itemId = slotId
        local itemQuality = GetItemLinkQuality(itemLink)
        
        if not g_weAreInAStore and CA.SV.Loot and isNewItem then
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, true)
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
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = 1
            logPrefix = logPrefixPos
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM    
        elseif g_inventoryStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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
                gainOrLoss = 1
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = 1
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = 2
                logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
                if logPrefix ~= CA.SV.LootMessageUse or CA.SV.ShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
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
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = 1
            logPrefix = logPrefixPos
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM    
        elseif g_bankStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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
                gainOrLoss = 1
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = 1
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = 2
                logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
                if logPrefix ~= CA.SV.LootMessageUse or CA.SV.ShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
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
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_banksubStacks[slotId] = { icon=icon, stack=stack, itemId=itemId, itemType=itemType, itemLink=itemLink }
            gainOrLoss = 1
            logPrefix = logPrefixPos
            CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        -- EXISTING ITEM    
        elseif g_banksubStacks[slotId] then
            itemLink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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
                gainOrLoss = 1
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED UP
            elseif stackCountChange > 0 then
                gainOrLoss = 1
                logPrefix = logPrefixPos
                CA.ItemPrinter(icon, stackCountChange, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
            -- STACK COUNT INCREMENTED DOWN
            elseif stackCountChange < 0 then
                local change = stackCountChange * -1
                gainOrLoss = 2
                logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
                if logPrefix ~= CA.SV.LootMessageUse or CA.SV.ShowCraftUse then -- If the logprefix isn't (used) then this is a deconstructed message, otherwise only display if used item display is enabled.
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
            gainOrLoss = 1
            logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageReceive or logPrefixPos
            change = stackCountChange
        end
        
        if stackCountChange < 0 then
            gainOrLoss = 2
            logPrefix = ResolveCraftingUsed(itemType) and CA.SV.LootMessageUse or logPrefixNeg
            change = stackCountChange * -1
        end

        if logPrefix ~= CA.SV.LootMessageUse or CA.SV.ShowCraftUse then
            CA.ItemPrinter(icon, change, itemType, itemId, itemLink, receivedBy, logPrefix, gainOrLoss, false)
        end
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function CA.InventoryUpdateBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    -- End right now if this is any other reason (durability loss, etc)
    if inventoryUpdateReason ~= INVENTORY_UPDATE_REASON_DEFAULT then return end
    d("Inventory UPDATE BANK" .. bagId)
    if isNewItem then d("This is a new item wow wiggity wew") end

    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local receivedBy = ""
        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainOrLoss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
            if InventoryOn then
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
                InventoryOn = false
            end
        --[[elseif g_inventoryStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainOrLoss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED)
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainOrLoss) -- Shouldn't need this for anything, but just in case. ]]-- Shouldn't be neccesary
        elseif g_inventoryStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainOrLoss = 1
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
                if InventoryOn then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
                    InventoryOn = false
                end
               g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainOrLoss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                if CA.SV.ShowDestroy and g_itemWasDestroyed then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss)
                end
                -- If the change in stacks resulted in a 0 balance, then we remove the item from the index
                if endcount <= 0 then
                    -- if InventoryOn then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss) InventoryOn = false end
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainOrLoss = 2
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
            if BankOn then
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
                BankOn = false
            end
        --[[elseif g_bankStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            g_oldItemLink = g_bankStacks[slotId].itemlink -- Sends over to LogItem to do an upgrade string!
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainOrLoss = 1
            local logPrefix = "Upgraded - Bank"]]--
        elseif g_bankStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_bankStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainOrLoss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
                if BankOn then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
                    BankOn = false
                end
                g_bankStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainOrLoss = 2
                local logPrefix = strformat("<<1>> - <<2>>", GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED), GetString(SI_INTERACT_OPTION_BANK) )
                local change = (stackCountChange * -1)
                local endcount = g_bankStacks[slotId].stack - change
                if CA.SV.ShowDestroy and g_itemWasDestroyed then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss)
                end
                -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                if endcount <= 0 then
                    -- if BankOn then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss) BankOn = false end
                    g_bankStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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

    ---------------------------------- SUBSCRIBER BANK ----------------------------------
    if bagId == BAG_SUBSCRIBER_BANK then
        local receivedBy = ""
        if not g_banksubStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_banksubStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_banksubStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainOrLoss = 2
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
            if BankOn then
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
                BankOn = false
            end
        --[[elseif g_banksubStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            g_oldItemLink = g_banksubStacks[slotId].itemlink -- Sends over to LogItem to do an upgrade string!
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_banksubStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_banksubStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainOrLoss = 1
            local logPrefix = "Upgraded - Bank"]]--
        elseif g_banksubStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_banksubStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainOrLoss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
                if BankOn then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
                    BankOn = false
                end
                g_banksubStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainOrLoss = 2
                local logPrefix = strformat("<<1>> - <<2>>", GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED), GetString(SI_INTERACT_OPTION_BANK) )
                local change = (stackCountChange * -1)
                local endcount = g_banksubStacks[slotId].stack - change
                if CA.SV.ShowDestroy and g_itemWasDestroyed then
                    CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss)
                end
                -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                if endcount <= 0 then
                    -- if BankOn then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss) BankOn = false end
                    g_banksubStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
                    g_banksubStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
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
        local gainOrLoss = 1
        local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
        local stack = stackCountChange
        local itemType = GetItemLinkItemType(itemlink)

        if stackCountChange < 1 then
            gainOrLoss = 2
            logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
            stack = stackCountChange * -1
        end

        CA.LogItem(logPrefix, icon, itemlink, itemType, stack or 1, receivedBy, gainOrLoss)
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function CA.InventoryUpdateGuildBank(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    d("Inventory UPDATE GBANK" .. bagId)
    if isNewItem then d("This is a new item wow wiggity wew") end
    
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local receivedBy = ""
        if not g_inventoryStacks[slotId] then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            g_guildBankCarryIcon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            g_guildBankCarrygainOrLoss = 1
            g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
            g_guildBankCarryReceivedBy = ""
            g_guildBankCarryItemLink = item.itemlink
            g_guildBankCarryStackCount = stackCountChange or 1
            g_guildBankCarryItemType = GetItemLinkItemType(item.itemlink)
        --[[elseif g_inventoryStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainOrLoss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_UPGRADED)
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainOrLoss) -- Shouldn't need this for anything, but just in case. ]]-- Shouldn't be neccesary
        elseif g_inventoryStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
               local icon, stack = GetItemInfo(bagId, slotId)
               local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
               g_guildBankCarryIcon = seticon
               g_guildBankCarrygainOrLoss = 1
               g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
               g_guildBankCarryReceivedBy = ""
               g_guildBankCarryItemLink = item.itemlink
               g_guildBankCarryStackCount = stackCountChange or 1
               g_guildBankCarryItemType = GetItemLinkItemType(item.itemlink)
               g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}

            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainOrLoss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                g_guildBankCarryIcon = seticon
                g_guildBankCarrygainOrLoss = 2
                g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DEPOSITED)
                g_guildBankCarryReceivedBy = ""
                g_guildBankCarryItemLink = item.itemlink
                g_guildBankCarryStackCount = change or 1
                g_guildBankCarryItemType = GetItemLinkItemType(item.itemlink)
                if CA.SV.ShowDestroy and g_itemWasDestroyed
                    then CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss)
                end
                if endcount <= 0 then -- If the change in stacks resulted in a 0 balance, then we remove the item from the index
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
                    g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
                end
            end
        end
    end

    ---------------------------------- CRAFTING BAG ----------------------------------
    if bagId == BAG_VIRTUAL then
        local receivedBy = ""
        local gainOrLoss = 1
        local logPrefix = GetString(SI_MAIL_INBOX_RECEIVED_COLUMN)
        local itemlink = CA.GetItemLinkFromItemId(slotId)
        local icon = GetItemLinkInfo(itemlink)
        local seticon = ( CA.SV.LootIcons and icon and icon ~= "" ) and ("|t16:16:" .. icon .. "|t ") or ""

        g_guildBankCarryIcon = seticon
        g_guildBankCarrygainOrLoss = 1
        g_guildBankCarryLogPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_WITHDREW)
        g_guildBankCarryReceivedBy = ""
        g_guildBankCarryItemLink = itemlink
        g_guildBankCarryStackCount = stackCountChange or 1
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
end

function CA.InventoryUpdateFence(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    d("Inventory UPDATE FENCE" .. bagId)
    if isNewItem then d("This is a new item wow wiggity wew") end
    
    ---------------------------------- INVENTORY ----------------------------------
    if bagId == BAG_BACKPACK then
        local receivedBy = ""
        if not g_inventoryStacks[slotId] and stackCountChange > 0 then -- NEW ITEM
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)
            local gainOrLoss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
            g_launderCheck = true
            CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
        elseif g_inventoryStacks[slotId] and stackCountChange == 0 then -- UPDGRADE
            local icon, stack = GetItemInfo(bagId, slotId)
            local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
            g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink }
            local item = g_inventoryStacks[slotId]
            local itemType = GetItemLinkItemType(item.itemlink)
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local gainOrLoss = 1
            local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
            g_launderCheck = true
            if itemType == ITEMTYPE_WEAPON or itemType == ITEMTYPE_ARMOR or itemType == ITEMTYPE_JEWELRY then
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, 1, receivedBy, gainOrLoss)
            end
        elseif g_inventoryStacks[slotId] and stackCountChange ~= 0 then -- EXISTING ITEM
            local item = g_inventoryStacks[slotId]
            local seticon = ( CA.SV.LootIcons and item.icon and item.icon ~= "" ) and ("|t16:16:" .. item.icon .. "|t ") or ""
            local itemType = GetItemLinkItemType(item.itemlink)

            if stackCountChange >= 1 then -- STACK COUNT INCREMENTED UP
                local gainOrLoss = 1
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
                local icon, stack = GetItemInfo(bagId, slotId)
                local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
                g_launderCheck = true
                CA.LogItem(logPrefix, seticon, item.itemlink, itemType, stackCountChange or 1, receivedBy, gainOrLoss)
                g_inventoryStacks[slotId] = { icon=icon, stack=stack, itemlink=bagitemlink}
            elseif stackCountChange < 0 then -- STACK COUNT INCREMENTED DOWN
                local gainOrLoss = 2
                local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_DESTROYED)
                local change = (stackCountChange * -1)
                local endcount = g_inventoryStacks[slotId].stack - change
                --CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss)
                -- If the change in stacks resulted in a 0 balance, then we remove the item from the index!
                if endcount <= 0 then
                    if CA.SV.ShowDestroy and g_itemWasDestroyed then
                        CA.LogItem(logPrefix, seticon, item.itemlink, itemType, change or 1, receivedBy, gainOrLoss)
                    end
                    g_inventoryStacks[slotId] = nil
                else
                    local icon, stack = GetItemInfo(bagId, slotId)
                    local bagitemlink = GetItemLink(bagId, slotId, LINK_STYLE_BRACKETS)
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
        local gainOrLoss = 1
        local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_LAUNDERED)
        local stack = stackCountChange
        local itemType = GetItemLinkItemType(itemlink)

        -- Laundering won't ever remove things from the bag, so ignore
        if stackCountChange < 1 then
            return
        end

        g_launderCheck = true
        CA.LogItem(logPrefix, icon, itemlink, itemType, stack or 1, receivedBy, gainOrLoss)
    end

    g_itemWasDestroyed = false
    g_lockpickBroken = false
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

    zo_callLater(CA.JusticeRemovePrint, 50)
end

function CA.JusticeRemovePrint()
    -- PART 1 -- INVENTORY
    if CA.SV.ShowConfiscate then
        local bagsize = GetBagSize(1)

        for i = 1,bagsize do
            local icon, stack = GetItemInfo(1, i)
            local bagitemlink = GetItemLink(1, i, LINK_STYLE_BRACKETS)
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
                    local gainOrLoss = 2
                    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_CONFISCATED)
                    if CA.SV.ShowConfiscate then
                        CA.LogItem(logPrefix, seticon, inventoryitem.itemlink, itemType, stack or 1, receivedBy, gainOrLoss)
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
            local bagitemlink = GetItemLink(0, i, LINK_STYLE_BRACKETS)
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
                    local gainOrLoss = 2
                    local logPrefix = GetString(SI_LUIE_CA_PREFIX_MESSAGE_CONFISCATEDEQUIPPED)
                    if CA.SV.ShowConfiscate then
                        CA.LogItem(logPrefix, seticon, inventoryitem.itemlink, itemType, stack or 1, receivedBy, gainOrLoss)
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

-- TODO: Interface this with the CSA handler to fix!
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
    
    local formattedIcon = zo_iconFormat("EsoUI/Art/HUD/HUD_Countdown_Badge_Dueling.dds", 16, 16)
    
    if CA.SV.MiscDuelStartOptions == 1 then
        printToChat(strformat(GetString(SI_LUIE_CA_DUEL_STARTED_WITH_ICON), formattedIcon))
    elseif CA.SV.MiscDuelStartOptions == 2 then
        printToChat(GetString(SI_LUIE_CA_DUEL_STARTED))
    elseif CA.SV.MiscDuelStartOptions == 3 then
        printToChat(strformat("<<1>>", formattedIcon))
    else
        return
    end
    
end

function CA.DisguiseState(eventCode, unitTag, disguiseState)
    if CA.SV.MiscDisguiseAlert and disguiseState == DISGUISE_STATE_DANGER then
        if CA.SV.MiscDisguiseOption == 1 or CA.SV.MiscDisguiseOption == 3 then
            printToChat(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER))
        end
        if CA.SV.MiscDisguiseOption == 2 or CA.SV.MiscDisguiseOption == 3 then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.GROUP_ELECTION_REQUESTED)
            messageParams:SetText(DisguiseAlertColorize:Colorize(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER)))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    end

    if CA.SV.MiscDisguiseAlert and disguiseState == DISGUISE_STATE_SUSPICIOUS then
        if CA.SV.MiscDisguiseOption == 1 or CA.SV.MiscDisguiseOption == 3 then
            printToChat(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS))
        end
        if CA.SV.MiscDisguiseOption == 2 or CA.SV.MiscDisguiseOption == 3 then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_MAJOR_TEXT, SOUNDS.GROUP_ELECTION_REQUESTED)
            messageParams:SetText(DisguiseAlertColorize:Colorize(GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS)))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    end

    -- If we're still disguised and g_disguiseState is true then don't waste resources and end the function
    if g_disguiseState == 1 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
        return
    end

    if g_disguiseState == 1 and (disguiseState == DISGUISE_STATE_NONE) then
        if CA.SV.MiscDisguiseOption == 1 or CA.SV.MiscDisguiseOption == 3 then
            printToChat(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), E.DisguiseIcons[g_currentDisguise].description))
        end
        if CA.SV.MiscDisguiseOption == 2 or CA.SV.MiscDisguiseOption == 3 then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetText(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), E.DisguiseIcons[g_currentDisguise].description))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
    end

    if g_disguiseState == 0 and ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
        g_currentDisguise = GetItemId(0, 10) or 0
        if CA.SV.MiscDisguiseOption == 1 or CA.SV.MiscDisguiseOption == 3 then
            printToChat(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description))
        end
        if CA.SV.MiscDisguiseOption == 2 or CA.SV.MiscDisguiseOption == 3 then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
            messageParams:SetText(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description))
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
    -- Displays disguise status change when zoning, if enabled
    if g_disguiseState == 0 then
        g_disguiseState = GetUnitDisguiseState("player")
        if g_disguiseState == 0 then
            return
        elseif g_disguiseState ~= 0 then
            g_disguiseState = 1
            g_currentDisguise = GetItemId(0, 10) or 0
            if CA.SV.MiscDisguiseOption == 1 or CA.SV.MiscDisguiseOption == 3 then
                printToChat(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description))
            end
            if CA.SV.MiscDisguiseOption == 2 or CA.SV.MiscDisguiseOption == 3 then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
                messageParams:SetText(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED), E.DisguiseIcons[g_currentDisguise].description))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_COUNTDOWN)
                CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
            end
            return
        end
    elseif g_disguiseState == 1 then
        g_disguiseState = GetUnitDisguiseState("player")
        if g_disguiseState == 0 then
            if CA.SV.MiscDisguiseOption == 1 or CA.SV.MiscDisguiseOption == 3 then
                printToChat(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), E.DisguiseIcons[g_currentDisguise].description))
            end
            if CA.SV.MiscDisguiseOption == 2 or CA.SV.MiscDisguiseOption == 3 then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_SMALL_TEXT)
                messageParams:SetText(strformat("<<1>> <<2>>", GetString(SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE), E.DisguiseIcons[g_currentDisguise].description))
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


function CA.MaraOffer(eventCode, targetCharacterName, isSender, targetDisplayName)
    local maraName
    local characterNameLink = ZO_LinkHandler_CreateCharacterLink(targetCharacterName)
    local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(targetDisplayName)
    local displayBothString = ( strformat("<<1>><<2>>", targetCharacterName, targetDisplayName) )
    local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, targetDisplayName)

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        maraName = displayNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        maraName = characterNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        maraName = displayBoth
    end

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

    if CA.SV.ChatPlayerDisplayOptions == 1 then
        maraName = displayNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 2 then
        maraName = characterNameLink
    end
    if CA.SV.ChatPlayerDisplayOptions == 3 then
        maraName = displayBoth
    end

    printToChat(strformat(GetString("SI_PLEDGEOFMARARESULT", reason), maraName))
end

function CA.StuckBegin(eventCode)
    printToChat(GetString(SI_FIXING_STUCK_TEXT))
end

function CA.StuckAlreadyInProgress(eventCode)
    printToChat(GetString(SI_STUCK_ERROR_ALREADY_IN_PROGRESS))
end

function CA.StuckInvalidLocation(eventCode)
    printToChat(GetString(SI_INVALID_STUCK_LOCATION))
end

function CA.StuckInCombat(eventCode)
    printToChat(GetString(SI_STUCK_ERROR_IN_COMBAT))
end

function CA.StuckOnCooldown(eventCode)
    local cooldownText = ZO_FormatTime(GetStuckCooldown(), TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TWELVE_HOUR)
    local cooldownRemainingText = ZO_FormatTimeMilliseconds(GetTimeUntilStuckAvailable(), TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TWELVE_HOUR)
    printToChat(strformat(GetString(SI_STUCK_ERROR_ON_COOLDOWN), cooldownText, cooldownRemainingText ))
end

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

-- EVENT_LORE_BOOK_LEARNED
-- This handler fires when a lorebook (or any lore library entry) is unlocked.
-- We add some custom handling here to deal with crafting and standard books.

function CA.LoreBookLearned(eventCode, categoryIndex, collectionIndex, bookIndex, guildIndex, isMaxRank)

end
--[[
    local collectionName, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
    
    if hidden and CA.SV.LorebookNoShowHide then
        return
    end

    local prefix
    if categoryIndex == 1 then
        prefix = CA.SV.LorebookPrefix1
    -- Special handling here, as the standard motif styles without chapters are lumped into this category as well.
    elseif (categoryIndex == 2 and collectionIndex ~= 1) or (categoryIndex == 2 and collectionIndex == 1 and bookIndex >= 3 and bookIndex <= 16) or (categoryIndex == 2 and collectionIndex == 1 and bookIndex == 23) then
        prefix = CA.SV.LorebookPrefix2
    else
        prefix = CA.SV.LorebookPrefix3
    end

    local title, icon = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
    
    local category
    if CA.SV.LorebookCategory and not hidden then
        local message1 = strfmt(" %s%s%s", bracket1, collectionName, bracket2)
        if CA.SV.LorebookNumber then
            --local percentage = math.floor( 100 / numKnownBooks * totalBooks )
            if CA.SV.LorebookNumberColor then
                category = strfmt(" %s|c%s%s|r%s|c71DE73%s|r%s%s", LorebookColorize:Colorize("("), AchievementPctToColour(numKnownBooks/totalBooks), numKnownBooks, LorebookColorize:Colorize("/"), totalBooks, LorebookColorize:Colorize(")"), LorebookColorize:Colorize(message1)) 
            else
                category = LorebookColorize:Colorize(strfmt(" (%s/%s)%s", numKnownBooks, totalBooks, message1))
            end
        else
        category = LorebookColorize:Colorize(message1)
        end
    else
        category = ""
    end

    local bookName = strfmt("[%s]", title)
    local bookLink = strfmt("|H1:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)

    printToChat(strfmt("%s %s%s%s", LorebookColorize:Colorize(prefix), icon, bookLink, category))
    
    stringPart1 = LorebookColorize:Colorize(strfmt("<<1>><<2>>", stringPrefixCA, formattedIcon))
    stringPart2 = LorebookColorize:Colorize(strfmt(SI_LUIE_CA_LOREBOOK_ADDED_CSA, bookLink, collectionName))
    printToChat strfmt(stringPart1, stringPart2)

end
]]--

local bracket1 = {
    [1] = "[",
    [2] = "(",
    [3] = "",
    [4] = "",
    [5] = "",
}
    
local bracket2 = {
    [1] = "]",
    [2] = ")",
    [3] = " -",
    [4] = ":",
    [5] = "",
}


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
function CA.AlertStyleLearned()
    
    local handlers = ZO_AlertText_GetHandlers()
    
    --[[
    local original = handlers[alert]
    handlers[alert] = function(styleIndex, chapterIndex, isDefaultRacialStyle, ...)
            d(styleIndex)
            d(chapterIndex)
            printToChat("Is this thing on?")
            
            return original(styleIndex, chapterIndex, isDefaultRacialStyle, ...)
    end
    ]]--
    
    -- Style book learned
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
    ZO_PreHook(handlers, EVENT_STYLE_LEARNED, StyleLearnedHook)
    
    -- TODO: We'll probably hide this event because it's kind of pointless - This will only trigger VERY occasionally when a lorebook is used and doesn't immediately fade away before the player can interact with it again (I guess just when Server lags).
    local function AlreadyKnowBookHook(bookTitle)
        printToChat(strformat(SI_LORE_LIBRARY_ALREADY_KNOW_BOOK, bookTitle))
        return ERROR, strformat(SI_LORE_LIBRARY_ALREADY_KNOW_BOOK, bookTitle)
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
                local changeColor = CurrencyUpColorize:ToHex()
                local changeType = ZO_LocalizeDecimalNumber(250)
                local currencyTypeColor = CurrencyGoldColorize:ToHex()
                local currencyIcon = CA.SV.CurrencyIcons and "|t16:16:/esoui/art/currency/currency_gold.dds|t" or ""
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
    
    ZO_PreHook(handlers, EVENT_LORE_BOOK_ALREADY_KNOWN, AlreadyKnowBookHook)
    ZO_PreHook(handlers, EVENT_RIDING_SKILL_IMPROVEMENT, RidingSkillImprovementAlertHook)
    
    
    
    
    
    
    

	local csaHandlers = ZO_CenterScreenAnnounce_GetHandlers()
    
    local function LoreBookHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, isMaxRank)
        if guildReputationIndex == 0 or isMaxRank then
            -- We only want to fire this event if a player is not part of the guild or if they've reached max level in the guild.
            -- Otherwise, the _SKILL_EXPERIENCE version of this event will send a center screen message instead.
            
            local collectionName, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            
            if not hidden or CA.SV.LorebookShowHidden then
                
                local title, icon = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
                local bookName = strfmt("[%s]", title)
                local bookLink = strfmt("|H1:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
                
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
	
	local function LoreBookXPHook(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, skillType, skillIndex, rank, previousXP, currentXP)
        if guildReputationIndex > 0 then
        
            local collectionName, _, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            local title, icon = GetLoreBookInfo(categoryIndex, collectionIndex, bookIndex)
            local bookName = strfmt("[%s]", title)
            local bookLink = strfmt("|H1:LINK_TYPE_LUIBOOK:%s:%s:%s|h%s|h", categoryIndex, collectionIndex, bookIndex, bookName)
            
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
                local link = GetCollectibleLink(collectibleId, LINK_STYLE_BRACKETS)
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
        local questType = GetJournalQuestType(journalIndex)
        local instanceDisplayType = GetJournalInstanceDisplayType(journalIndex)
        local questJournalObject = SYSTEMS:GetObject("questJournal")
        local iconTexture = questJournalObject:GetIconTexture(questType, instanceDisplayType)
        
        -- When a quest is shared if this value is not detected as true then
        -- TODO: Fix this!
        if CA.SV.QuestShare then
            g_QuestShareFudger = true
            zo_callLater(CA.QuestShareMessageReset, 100)
        end
        
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
                questNameFormatted = (strformat("|c<<1>><<2>>:|r |c<<3>><<4>>|r", QuestColorNameColorize, questName, QuestColorDescriptionColorize, stepText))
            else
                questNameFormatted = (strformat("|c<<1>><<2>>|r", QuestColorNameColorize, questName))
            end
            if iconTexture and CA.SV.QuestIcon then
                formattedString = strformat(SI_LUIE_CA_QUEST_ACCEPT_WITH_ICON, zo_iconFormat(iconTexture, 16, 16), questNameFormatted)
            else
                formattedString = strformat(SI_NOTIFYTEXT_QUEST_ACCEPT, questNameFormatted)
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
            if iconTexture then
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
            if iconTexture then
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
            
            local message = strformat ("|c<<1>><<2>>|r", QuestColorDescriptionColorize, text)
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
            if CA.SV.Quest or CA.SV.QuestCSA then
            
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
                    if iconTexture and CA.SV.QuestIcon then
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
                    CurrentLevelFormatted = LevelUpColorize:Colorize(GetString(SI_GAMEPAD_QUEST_JOURNAL_QUEST_LEVEL) .. " " .. CurrentLevel)
                end

                local formattedString
                if CA.SV.ExperienceLevelColorByLevel then
                    formattedString = strformat("<<1>><<2>> <<3>><<4>>", LevelUpColorize:Colorize(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP)), icon, CurrentLevelFormatted, LevelUpColorize:Colorize("!"))
                else
                    formattedString = strformat("<<1>><<2>> <<3>><<4>>", LevelUpColorize:Colorize(GetString(SI_LUIE_CA_LVL_ANNOUNCE_XP)), icon, CurrentLevelFormatted, LevelUpColorize:Colorize("!"))
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
        formattedString = strformat("<<1>>! <<2>>", GetString(SI_ENLIGHTENED_STATE_GAINED_HEADER), GetString(SI_ENLIGHTENED_STATE_GAINED_DESCRIPTION))
        g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        
        if IsEnlightenedAvailableForCharacter() then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ENLIGHTENED_STATE_GAINED)
            messageParams:SetText(zo_strformat(SI_ENLIGHTENED_STATE_GAINED_HEADER), zo_strformat(SI_ENLIGHTENED_STATE_GAINED_DESCRIPTION))
            if not LUIE.SV.HideXPBar then
                local barParams = GetCurrentChampionPointsBarParams()
                messageParams:SetBarParams(barParams)
            end
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ENLIGHTENMENT_GAINED)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
        end
        return true
    end

    local function EnlightenLossHook()
        formattedString = strformat("<<1>>!", GetString(SI_ENLIGHTENED_STATE_LOST_HEADER))
        g_queuedMessages[g_queuedMessagesCounter] = { message = formattedString, type = "EXPERIENCE" }
        g_queuedMessagesCounter = g_queuedMessagesCounter + 1
        EVENT_MANAGER:RegisterForUpdate(moduleName .. "Printer", 50, CA.PrintQueuedMessages )
        
        if IsEnlightenedAvailableForCharacter() then
            local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.ENLIGHTENED_STATE_LOST)
            if not LUIE.SV.HideXPBar then
                messageParams:SetBarParams(GetCurrentChampionPointsBarParams())
            end
            messageParams:SetText(zo_strformat(SI_ENLIGHTENED_STATE_LOST_HEADER))
            messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_ENLIGHTENMENT_LOST)
            CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(messageParams)
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
                        bookString = "|H1:item:64700:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_speed.dds|t "
                    elseif ridingSkill == 2 then
                        bookString = "|H1:item:64702:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_capacity.dds|t "
                    elseif ridingSkill == 3 then
                        bookString = "|H1:item:64701:1:1:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0:0|h|h"
                        icon = "|t16:16:/esoui/art/icons/store_ridinglessons_stamina.dds|t "
                    end
                    
                    local messageP1 = CA.SV.LootIcons and (icon .. bookString) or (bookString)
                    local finalMessage = strfmt("|cFFFFFF" .. learnString, messageP1, value .. ".|r")
                
                    
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
            local formattedString = LevelUpColorize:Colorize(zo_strformat("<<1>>!", GetString(SI_CHAMPION_ANNOUNCEMENT_UNLOCKED, formattedIcon)))
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
                    local barParams = CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, championPoints, currentChampionXP, currentChampionXP)
                    barParams:SetShowNoGain(true)
                    messageParams:SetBarParams(barParams)
                else
                    local totalChampionPoints = GetPlayerChampionPointsEarned()
                    local championXPGained = 0;
                    for i = 0, (totalChampionPoints - 1) do
                        championXPGained = championXPGained + GetNumChampionXPInChampionPoint(i)
                    end
                    messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(PPB_CP, 0, 0, championXPGained))
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
            local formattedString = LevelUpColorize:Colorize(zo_strformat("<<1>>:", GetString(SI_CHAMPION_POINT_EARNED, pointDelta)))
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
                        formattedString = LevelUpColorize:Colorize(strformat(SI_LUIE_CHAMPION_POINT_TYPE, amount, formattedIcon, constellationGroupName))
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
    
    -- Unregister the ZOS events for handling Quest Removal/Advanced/Added to replace with our own functions
    EVENT_MANAGER:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_REMOVED)
    EVENT_MANAGER:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADVANCED)
    EVENT_MANAGER:UnregisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADDED)
    EVENT_MANAGER:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_REMOVED, OnQuestRemoved)
    EVENT_MANAGER:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADVANCED, OnQuestAdvanced)
    EVENT_MANAGER:RegisterForEvent("CSA_MiscellaneousHandlers", EVENT_QUEST_ADDED, OnQuestAdded)
    
    
   
    ZO_PreHook(csaHandlers, EVENT_LORE_BOOK_LEARNED, LoreBookHook)
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
    
   -- ZO_PreHook(csaHandlers, loreEvents[3], LoreCollectionHook)
   -- ZO_PreHook(csaHandlers, loreEvents[4], LoreCollectionXPHook)
    
    --[[
  
    CSH[EVENT_LORE_COLLECTION_COMPLETED] = function(categoryIndex, collectionIndex, bookIndex, guildReputationIndex, isMaxRank)
        if guildReputationIndex == 0 or isMaxRank then
            -- Only fire this message if we're not part of the guild or at max level within the guild.
            local collectionName, description, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            if not hidden then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_COLLECTION_COMPLETED)
                messageParams:SetText(GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE), strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_COLLECTION_COMPLETED)
                return messageParams
            end
        end
    end

    CSH[EVENT_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE] = function(categoryIndex, collectionIndex, guildReputationIndex, skillType, skillIndex, rank, previousXP, currentXP)
        if guildReputationIndex > 0 then
            local collectionName, description, numKnownBooks, totalBooks, hidden = GetLoreCollectionInfo(categoryIndex, collectionIndex)
            if not hidden then
                local messageParams = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.BOOK_COLLECTION_COMPLETED)
                local barType = PLAYER_PROGRESS_BAR:GetBarType(PPB_CLASS_SKILL, skillType, skillIndex)
                local rankStartXP, nextRankStartXP = GetSkillLineRankXPExtents(skillType, skillIndex, rank)
                messageParams:SetBarParams(CENTER_SCREEN_ANNOUNCE:CreateBarParams(barType, rank, previousXP - rankStartXP, currentXP - rankStartXP))
                messageParams:SetText(GetString(SI_LORE_LIBRARY_COLLECTION_COMPLETED_LARGE), strformat(SI_LORE_LIBRARY_COLLECTION_COMPLETED_SMALL, collectionName))
                messageParams:SetCSAType(CENTER_SCREEN_ANNOUNCE_TYPE_LORE_COLLECTION_COMPLETED_SKILL_EXPERIENCE)
                return messageParams
            end
        end
    end
    
    ]]
	
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

-- TEMP COPIED FROM NO THANK YOU TO SEE
--[[
local function BossAlertTextsHook()
	local handlers = ZO_AlertText_GetHandlers()

	local abilityErrorIds = {
		[162] = true, --"Flying creatures are immune to snares."
		[177] = true, --"This target is too powerful for that effect."
	}
	local function AbilityEventHook(errorStringId)
		if SV.boss then
			return abilityErrorIds[errorStringId]
		end
	end
	ZO_PreHook(handlers, EVENT_ABILITY_REQUIREMENTS_FAIL, AbilityEventHook)

	local actionResults = {
		[ACTION_RESULT_MISSING_EMPTY_SOUL_GEM] = true, -- "You must have a valid empty soul gem."
	}
	local function CombatEventHook(result, isError, ...)
		if isError and SV.boss then
			return actionResults[result]
		end
	end
	ZO_PreHook(handlers, EVENT_COMBAT_EVENT, CombatEventHook)
end

]]--

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
            if g_queuedMessages[i].type == "LOOT" then
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
