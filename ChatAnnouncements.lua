------------------
-- ChatAnnouncements namespace
LUIE.ChatAnnouncements = {}

-- Performance Enhancement
local CA			= LUIE.ChatAnnouncements
local CommaValue	= LUIE.CommaValue
local strformat		= zo_strformat
local strfmt		= string.format
local strsub		= string.sub 
local gsub			= string.gsub
local tinsert		= table.insert

local moduleName	= LUIE.name .. '_ChatAnnouncements'

CA.D = {
	TimeStamp		= true,
	TimeStampFormat = "HH:m",
	GroupChatMsg	= true,
	GoldChange		= true,
	Loot			= true,
	LootIcons		= true,
	LootShowTrait	= true,
	LootGroup		= true,
	LootOnlyNotable = false,
	LootBlacklist	= false,
	Experience		= true,
	Achievements	= false,
	AchievementsStep = 2,
	AchievementsDetails = true,
	AchIgnoreList	= {}, -- inverted list of achievements to be tracked
}

local g_playerName = nil

function CA.Initialize()
	-- load settings
	CA.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, 'ChatAnnouncements', CA.D )

	-- Read current player toon name
	g_playerName = GetRawUnitName('player')

	-- register events
	CA.RegisterGroupEvents()
	CA.RegisterGoldEvents()
	CA.RegisterLootEvents()
	CA.RegisterAchievementsEvent()
end

--[[----------------------------------------------------------
	Display group join/leave in chat
--]]----------------------------------------------------------
function CA.RegisterGroupEvents()
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED)
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_GROUP_MEMBER_LEFT)
	if CA.SV.GroupChatMsg then
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED, CA.OnGroupMemberJoined)
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_LEFT,	  CA.OnGroupMemberLeft)
	end
end

function CA.OnGroupMemberJoined(eventCode, memberName)
	if g_playerName ~= memberName then
		-- Can occur if event is before EVENT_PLAYER_ACTIVATED
		local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(memberName,"%^%a+","") )
		if CHAT_SYSTEM then
			printToChat(strfmt('|cFEFEFE%s|r has joined your group.', characterNameLink))
		end
	end
end

function CA.OnGroupMemberLeft(eventCode, memberName, reason, wasLocalPlayer)
	local characterNameLink = ZO_LinkHandler_CreateCharacterLink( gsub(memberName,"%^%a+","") )
	local msg = nil
	if reason == GROUP_LEAVE_REASON_VOLUNTARY then
		msg = g_playerName == memberName and 'You have left the group.' or '|cFEFEFE%s|r has left your group.'
	elseif reason == GROUP_LEAVE_REASON_KICKED then
		msg = g_playerName == memberName and 'You were kicked from the group.' or '|cFEFEFE%s|r was kicked from your group.'
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
--[[ Leaving the old code here for reference
local function printToChat(msg)
	local msg = CA.FormatMessage(msg or 'no message', CA.SV.TimeStamp)
	-- We will print into first window of primary container
	local pc = CHAT_SYSTEM.primaryContainer
	pc.windows[1].buffer:AddMessage(msg)
	if pc.windows[1].buffer == pc.currentBuffer then
		pc:SyncScrollToBuffer()
	end
end
]]--
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
	Gold change into chat
--]]----------------------------------------------------------
local g_goldQueue = {}
local g_goldQueueName = moduleName .. '_GoldQueue'

function CA.RegisterGoldEvents()
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MONEY_UPDATE)
	if CA.SV.GoldChange then
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MONEY_UPDATE, CA.OnMoneyUpdate)
	end
end

function CA.PrintGoldChange()
	EVENT_MANAGER:UnregisterForUpdate(g_goldQueueName)

	local sumG, sumL = 0, 0
	for i = 1, #g_goldQueue do
		local value = g_goldQueue[i]
		if value > 0 then
			sumG = sumG + value
		elseif value < 0 then
			sumL = sumL - value
		end
	end

	g_goldQueue = {}

	local currentMoney = CommaValue( GetCurrentMoney() )
	local icon = CA.SV.LootIcons and ' |t16:16:/esoui/art/currency/currency_gold.dds|t' or '.'
	if sumG > 0 then printToChat( "|c32DF41Received Gold: |cCCCC33" .. CommaValue(sumG) .. "|c32DF41" .. icon .. " New total: |cCCCC33" .. currentMoney .. "|c32DF41" .. icon .. "|r" ) end
	if sumL > 0 then printToChat(	 "|cDF3241Spent Gold: |cCCCC33" .. CommaValue(sumL) .. "|cDF3241" .. icon .. " New total: |cCCCC33" .. currentMoney .. "|cDF3241" .. icon .. "|r" ) end
end

function CA.OnMoneyUpdate(eventCode, newMoney, oldMoney, reason)
	if #g_goldQueue == 0 then
		EVENT_MANAGER:RegisterForUpdate(g_goldQueueName, 66, CA.PrintGoldChange)
	end
	tinsert( g_goldQueue, (newMoney - oldMoney) )
end

--[[----------------------------------------------------------
	Loot Announcements
--]]----------------------------------------------------------
function CA.RegisterLootEvents()
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_LOOT_RECEIVED)
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_READABLE)
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS)
	if CA.SV.Loot then
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_LOOT_RECEIVED, CA.OnLootReceived)
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_READABLE, CA.OnMailReadable)
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_MAIL_TAKE_ATTACHED_ITEM_SUCCESS, CA.OnMailTakeAttachedItem)
	end
end

function CA.OnLootReceived(eventCode, receivedBy, itemName, quantity, itemSound, lootType, lootedBySelf, isPickpocketLoot, questItemIcon, itemId)
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
		[56862] = true,	-- [Fortified Nirncrux]
		[56863] = true,	-- [Potent Nirncrux]
		[68342] = true,	-- [Hakeijo]
	}
	
	-- List of items to blacklist
	blacklistIDs = {
		[64713]	 = true,	-- [Laurel]
		[114427] = true,	-- [Undaunted Plunder]
		[81180]	 = true,	-- [The Serpent's Egg-Tooth]
		[74453]	 = true,	-- [The Rid-Thar's Moon Pearls]
		[87701]	 = true,	-- [Star-Studded Champion's Baldric]
		[87700]	 = true,	-- [Periapt of Elinhir]
		[69432]	 = true,	-- [Glass Style Motif Fragment]
		-- Mercenary Motif Pages
		[64716]	 = true,	-- [Mercenary Motif]
		[64717]	 = true,	-- [Mercenary Motif]
		[64718]	 = true,	-- [Mercenary Motif]
		[64719]	 = true,	-- [Mercenary Motif]
		[64720]	 = true,	-- [Mercenary Motif]
		[64721]	 = true,	-- [Mercenary Motif]
		[64722]	 = true,	-- [Mercenary Motif]
		[64723]	 = true,	-- [Mercenary Motif]
		[64724]	 = true,	-- [Mercenary Motif]
		[64725]	 = true,	-- [Mercenary Motif]
		[64726]	 = true,	-- [Mercenary Motif]
		[64727]	 = true,	-- [Mercenary Motif]
		[64728]	 = true,	-- [Mercenary Motif]
		[64729]	 = true,	-- [Mercenary Motif]
	}
	
	-- Check for Blacklisted loot
	if ( CA.SV.LootBlacklist and blacklistIDs[itemId] ) then return end
	
	-- Set prefix based on Looted/Pickpocket/Received 
	local logPrefix = "|c0B610B[Looted]|r "
	if ( isPickpocketLoot ) then logPrefix = "|c0B610B[Pickpocket]|r " end
	if ( receivedBy == nil ) then logPrefix = "|c0B610B[Received]|r " end
	
	if lootedBySelf then
		if CA.SV.LootOnlyNotable then
			-- Notable items are: any set items, any purple+ items, blue+ special items (e.g., treasure maps)
			if ( (itemIsSet) or
				 (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
				 (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
				 (lootType == LOOT_TYPE_COLLECTIBLE) or
				 (notableIDs[itemId]) ) then
				
				CA.LogItem(logPrefix, icon, itemName, itemType, quantity, lootedBySelf and "" or receivedBy)
			end
		else
			CA.LogItem(logPrefix, icon, itemName, itemType, quantity, lootedBySelf and "" or receivedBy)
		end
	elseif CA.SV.LootGroup then
		if ( lootType ~= LOOT_TYPE_ITEM and lootType ~= LOOT_TYPE_COLLECTIBLE ) then return end
		local itemQuality = GetItemLinkQuality(itemName)
		if ( (itemIsSet) or
			 (itemQuality >= ITEM_QUALITY_ARCANE and itemIsSpecial) or
			 (itemQuality >= ITEM_QUALITY_ARTIFACT and not itemIsKeyFragment) or
			 (lootType == LOOT_TYPE_COLLECTIBLE) or
			 (notableIDs[itemId]) ) then

			CA.LogItem(logPrefix, icon, itemName, itemType, quantity, self and "" or receivedBy)
		end
	end
end

function CA.LogItem( logPrefix, icon, itemName, itemType, quantity, receivedBy )
	local formattedRecipient
	local formattedQuantity = ""
	local formattedTrait = ""
 
	if (receivedBy == "") then
		-- Don't display yourself
		-- TODO: Can maybe make a Setting or something
		formattedRecipient = ""
	else
		-- Create a character link to make it easier to contact the recipient
		formattedRecipient = strfmt("→ |c%06X|H0:character:%s|h%s|h|r",
			HashString(receivedBy) % 0x1000000, -- Use the hash of the name for the color so that is random, but consistent
			receivedBy,
			receivedBy:gsub("%^%a+$", "", 1)
		) 
	end
 
	if (quantity > 1) then
		formattedQuantity = strfmt("|cFFFFFFx%d|r", quantity)
	end
 
	local traitType = GetItemLinkTraitInfo(itemName)
	if (CA.SV.LootShowTrait and traitType ~= ITEM_TRAIT_TYPE_NONE and itemType ~= ITEMTYPE_ARMOR_TRAIT and itemType ~= ITEMTYPE_WEAPON_TRAIT) then
		formattedTrait = strfmt(" |cFFFFFF(%s)|r", GetString("SI_ITEMTRAITTYPE", traitType))
	end
   
	printToChat(strfmt(
		"%s%s%s%s%s %s",
		logPrefix,
		icon,
		itemName:gsub("^|H0", "|H1", 1),
		formattedQuantity,
		formattedTrait,
		formattedRecipient
	))
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

	for attachIndex = 1, #g_MailStacks do
		local item = g_MailStacks[attachIndex]
		CA.OnLootReceived(eventCode, nil, item.itemlink, item.stack or 1, nil, LOOT_TYPE_ITEM, true, false)
	end

	g_MailStacks = {}
end


--[[----------------------------------------------------------
	Experience changes
--]]----------------------------------------------------------
local xpReason = {
--	[PROGRESS_REASON_NONE]						= "none",
--	[PROGRESS_REASON_KILL]						= "Kill",
	[PROGRESS_REASON_QUEST]						= "Quest Completion",
	[PROGRESS_REASON_COMPLETE_POI]				= "POI Completion",
	[PROGRESS_REASON_DISCOVER_POI]				= "POI Discovery",
--?	[PROGRESS_REASON_COMMAND]					= "Command",
--?	[PROGRESS_REASON_KEEP_REWARD]				= "Keep Reward",
--?	[PROGRESS_REASON_BATTLEGROUND]				= "Battleground",
	[PROGRESS_REASON_SCRIPTED_EVENT]			= "Scripted Event",
--	[PROGRESS_REASON_MEDAL]						= "Medal",
--	[PROGRESS_REASON_FINESSE]					= "Finesse",
	[PROGRESS_REASON_LOCK_PICK]					= "Lock Picking",
--	[PROGRESS_REASON_COLLECT_BOOK]				= "Book",
--	[PROGRESS_REASON_BOOK_COLLECTION_COMPLETE]	= "Book Collection",
--	[PROGRESS_REASON_ACTION]					= "Action",
--	[PROGRESS_REASON_GUILD_REP]					= "Guild Reputation",
--?	[PROGRESS_REASON_AVA]						= "Skill AVA",
--	[PROGRESS_REASON_TRADESKILL]				= "Tradeskill",
	[PROGRESS_REASON_REWARD]					= "Reward",
--	[PROGRESS_REASON_TRADESKILL_ACHIEVEMENT]	= "Tradeskill Achievement",
--	[PROGRESS_REASON_TRADESKILL_QUEST]			= "Tradeskill Quest",
--	[PROGRESS_REASON_TRADESKILL_CONSUME]		= "Tradeskill Consume",
--	[PROGRESS_REASON_TRADESKILL_HARVEST]		= "Tradeskill Harvest",
--	[PROGRESS_REASON_TRADESKILL_RECIPE]			= "Tradeskill Recipe",
--	[PROGRESS_REASON_TRADESKILL_TRAIT]			= "Tradeskill Trait",
--	[PROGRESS_REASON_OVERLAND_BOSS_KILL]		= "Overland Boss Kill",
	[PROGRESS_REASON_ACHIEVEMENT]				= "Achievement",
--	[PROGRESS_REASON_BOSS_KILL]					= "Boss Kill",
	[PROGRESS_REASON_EVENT]						= "Event",
--	[PROGRESS_REASON_DARK_ANCHOR_CLOSED]		= "Dark Anchor Closed",
--	[PROGRESS_REASON_DARK_FISSURE_CLOSED]		= "Dark Fissure Closed",
--	[PROGRESS_REASON_SKILL_BOOK]				= "Skill Book",
--	[PROGRESS_REASON_OTHER]						= "Other",
--	[PROGRESS_REASON_GRANT_REPUTATION]			= "Grant Reputation",
--?	[PROGRESS_REASON_ALLIANCE_POINTS]			= "Alliance Points",
--	[PROGRESS_REASON_PVP_EMPEROR]				= "PvP Emperror",
	[PROGRESS_REASON_DUNGEON_CHALLENGE]			= "Dungeon Challenge",
--	[PROGRESS_REASON_JUSTICE_SKILL_EVENT]		= "Justice Skill Event",
}
function CA.PrintXPChange( reason, value, cxp )
	if CA.SV.Experience and xpReason[reason] then
		printToChat( strfmt('|cF0F000XP gain: |cF0F0F0+%d|cF0F000 for |cF0F044%s|cF0F000%s|r', value, xpReason[reason], cxp and ( " (|cF0F0F0+" .. cxp .. " CXP|cF0F000)" ) or '.' ) )
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

	local link = strformat( GetAchievementLink(aId, LINK_STYLE_DEFAULT) )
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

	printToChat( strfmt("|c87B7CC%s: %s [|c%s%d%%|c87B7CC] (%s)%s|r",
							(totalCmp == totalReq) and "Completed" or "Updated",
							link,
							AchievementPctToColour(totalCmp/totalReq),
							math.floor(100*totalCmp/totalReq),
							catName,
							details or '.' )
				)
end
