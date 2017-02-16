--LibMediaProvider-1.0 is inspired by and borrows from LibSharedMedia-3.0 for World of Warcraft by Elkano
--LibSharedMedia-3.0 and LibMediaProvider-1.0 are under the LGPL-2.1 license

local MAJOR, MINOR = "LibMediaProvider-1.0", 8 -- remember to increase manually on changes
local LMP = LibStub:NewLibrary(MAJOR, MINOR)
if not LMP then return end

local cm = CALLBACK_MANAGER
local tinsert = table.insert
local tsort = table.sort
local pairs = pairs

LMP.DefaultMedia = LMP.DefaultMedia or {}
LMP.MediaList = LMP.MediaList or {}
LMP.MediaTable = LMP.MediaTable or {}
if not LMP.MediaType then
	LMP.MediaType = {
		BACKGROUND = "background",	-- background textures
		BORDER = "border",			-- border textures
		FONT = "font",				-- fonts
		STATUSBAR = "statusbar",	-- statusbar textures
		SOUND = "sound",			-- sound files
	}
end
local defaultMedia = LMP.DefaultMedia
local mediaList = LMP.MediaList
local mediaTable = LMP.MediaTable

--DEFAULT UI MEDIA--
-- BACKGROUND
LMP.MediaTable.background = LMP.MediaTable.background or {}
--commented out because it still leaves a white texture behind - addons can use alpha to hide the background
--LMP.MediaTable.background["None"]				= ""
LMP.MediaTable.background["ESO Black"]			= "EsoUI/Art/Miscellaneous/borderedinset_center.dds"
LMP.MediaTable.background["ESO Chat"]			= "EsoUI/Art/chatwindow/chat_bg_center.dds"
LMP.MediaTable.background["ESO Gray"]			= "EsoUI/Art/itemtooltip/simpleprogbarbg_center.dds"
LMP.MediaTable.background["Solid"]				= ""
--LMP.DefaultMedia.background = "None"
LMP.DefaultMedia.background = "Solid"

-- BORDER
LMP.MediaTable.border = LMP.MediaTable.border or {}
--commented out because it still leaves a white texture behind - addons can use alpha to hide the border
--LMP.MediaTable.border["None"]					= ""
LMP.MediaTable.border["ESO Gold"]				= "EsoUI/Art/Miscellaneous/borderedinsettransparent_edgefile.dds"
LMP.MediaTable.border["ESO Chat"]				= "EsoUI/Art/chatwindow/chat_bg_edge.dds"
LMP.MediaTable.border["ESO Rounded"]			= "EsoUI/Art/miscellaneous/interactkeyframe_edge.dds"
LMP.MediaTable.border["ESO Blue Highlight"]		= "EsoUI/Art/miscellaneous/textentry_highlight_edge.dds"
LMP.MediaTable.border["ESO Blue Glow"]			= "EsoUI/Art/crafting/crafting_tooltip_glow_edge_blue64.dds"
LMP.MediaTable.border["ESO Red Glow"]			= "EsoUI/Art/crafting/crafting_tooltip_glow_edge_red64.dds"
LMP.MediaTable.border["ESO Red Overlay"]		= "EsoUI/Art/uicombatoverlay/uicombatoverlayedge.dds"
--LMP.DefaultMedia.border = "None"
LMP.DefaultMedia.border = "ESO Gold"

-- FONT
LMP.MediaTable.font = LMP.MediaTable.font or {}
LMP.MediaTable.font["ProseAntique"]				= "EsoUI/Common/Fonts/ProseAntiquePSMT.otf"
LMP.MediaTable.font["Consolas"]					= "EsoUI/Common/Fonts/consola.ttf"
LMP.MediaTable.font["Futura Condensed"]			= "EsoUI/Common/Fonts/FTN57.otf"
LMP.MediaTable.font["Futura Condensed Bold"]	= "EsoUI/Common/Fonts/FTN87.otf"
LMP.MediaTable.font["Futura Condensed Light"]	= "EsoUI/Common/Fonts/FTN47.otf"
LMP.MediaTable.font["Skyrim Handwritten"]		= "EsoUI/Common/Fonts/Handwritten_Bold.otf"
LMP.MediaTable.font["Trajan Pro"]				= "EsoUI/Common/Fonts/trajanpro-regular.otf"
LMP.MediaTable.font["Univers 55"]				= "EsoUI/Common/Fonts/univers55.otf"
LMP.MediaTable.font["Univers 57"]				= "EsoUI/Common/Fonts/univers57.otf"
LMP.MediaTable.font["Univers 67"]				= "EsoUI/Common/Fonts/univers67.otf"
LMP.DefaultMedia.font = "Univers 55"

-- STATUSBAR
LMP.MediaTable.statusbar = LMP.MediaTable.statusbar or {}
--LMP.MediaTable.statusbar["ESO Basic"]			= "EsoUI/Art/miscellaneous/progressbar_genericfill_tall.dds"
LMP.MediaTable.statusbar["ESO Basic"]			= ""
LMP.DefaultMedia.statusbar = "ESO Basic"

-- SOUND
LMP.MediaTable.sound = LMP.MediaTable.sound or {}
LMP.MediaTable.sound["None"]					= ""
LMP.MediaTable.sound["AvA Gate Open"]			= SOUNDS.AVA_GATE_OPENED
LMP.MediaTable.sound["AvA Gate Close"]			= SOUNDS.AVA_GATE_CLOSED
LMP.MediaTable.sound["Emperor Coronated"]		= SOUNDS.EMPEROR_CORONATED_DAGGERFALL
LMP.MediaTable.sound["Level Up"]				= SOUNDS.LEVEL_UP
LMP.MediaTable.sound["Skill Gained"]			= SOUNDS.SKILL_GAINED
LMP.MediaTable.sound["Ability Purchased"]		= SOUNDS.ABILITY_SKILL_PURCHASED
LMP.MediaTable.sound["Book Acquired"]			= SOUNDS.BOOK_ACQUIRED
LMP.MediaTable.sound["Unlock"]					= SOUNDS.LOCKPICKING_UNLOCKED
LMP.MediaTable.sound["Enchanting Extract"]		= SOUNDS.ENCHANTING_EXTRACT_START_ANIM
LMP.MediaTable.sound["Enchanting Create"]		= SOUNDS.ENCHANTING_CREATE_TOOLTIP_GLOW
LMP.MediaTable.sound["Blacksmith Improve"]		= SOUNDS.BLACKSMITH_IMPROVE_TOOLTIP_GLOW_SUCCESS
LMP.DefaultMedia.sound = "None"

local function rebuildMediaList(mediatype)
	local mtable = mediaTable[mediatype]
	if not mtable then return end
	if not mediaList[mediatype] then mediaList[mediatype] = {} end
	local mlist = mediaList[mediatype]
	-- list can only get larger, so simply overwrite it
	local i = 0
	for k in pairs(mtable) do
		i = i + 1
		mlist[i] = k
	end
	tsort(mlist)
end

function LMP:Register(mediatype, key, data)
	if type(mediatype) ~= "string" then
		error(MAJOR..":Register(mediatype, key, data) - mediatype must be string, got "..type(mediatype))
	end
	if type(key) ~= "string" then
		error(MAJOR..":Register(mediatype, key, data) - key must be string, got "..type(key))
	end
	mediatype = mediatype:lower()
	if not mediaTable[mediatype] then
		mediaTable[mediatype] = {}
	end
	
	local mtable = mediaTable[mediatype]
	if mtable[key] then
		return false
	end
	mtable[key] = data
	rebuildMediaList(mediatype)
	cm:FireCallbacks("LibMediaProvider_Registered", mediatype, key)
	return true
end

function LMP:Fetch(mediatype, key)
	local mtt = mediaTable[mediatype]
	local result = (mtt and mtt[key]) or (defaultMedia[mediatype] and mtt[defaultMedia[mediatype]])
	return result ~= "" and result or nil
end

function LMP:IsValid(mediatype, key)
	return mediaTable[mediatype] and (not key or mediaTable[mediatype][key]) and true or false
end

function LMP:HashTable(mediatype)
	return mediaTable[mediatype]
end

function LMP:List(mediatype)
	if not mediaTable[mediatype] then
		return nil
	end
	if not mediaList[mediatype] then
		rebuildMediaList(mediatype)
	end
	return mediaList[mediatype]
end

function LMP:GetDefault(mediatype)
	return defaultMedia[mediatype]
end

function LMP:SetDefault(mediatype, key)
	if mediaTable[mediatype] and mediaTable[mediatype][key] and not defaultMedia[mediatype] then
		defaultMedia[mediatype] = key
		return true
	else
		return false
	end
end
