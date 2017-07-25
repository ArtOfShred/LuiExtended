--[[
Author: Ayantir
Filename: LibAnnyoingUpdateNotificationInGame.lua
Version: 3
]]--

--[[

This software is under : CreativeCommons CC BY-NC-SA 4.0
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

You are free to:

    Share — copy and redistribute the material in any medium or format
    Adapt — remix, transform, and build upon the material
    The licensor cannot revoke these freedoms as long as you follow the license terms.


Under the following terms:

    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial — You may not use the material for commercial purposes.
    ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
    No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


Please read full licence at : 
http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode

]]--

local libLoaded
local LIB_NAME, VERSION = "Launig", 4
local Launig, oldminor = LibStub:NewLibrary(LIB_NAME, VERSION)
if not Launig then return end

local GRACE_PERIOD = 86400 * 10
local REPEAT_EVERY = 86400 * 30

local UPDATE_WEBSITE = "http://www.esoui.com"

local SV_HOST = ZO_Ingame_SavedVariables
local wm = WINDOW_MANAGER
local lang = {}
local platform

local function GetLangStrings(language)

	if language == "de" then
		return {
			TITLE = "Addons veraltet",
			DESC = {
				[1] = "Vielen Dank, dass Du Elder Scrolls Online Erweiterungen verwendest\n\nAllerdings sind einige davon veraltet\n\nVergiss nicht zu aktualisieren",
				[2] = "Vielen Dank, dass Du Elder Scrolls Online Erweiterungen verwendest\nAllerdings sind einige davon veraltet\n\nVergiss nicht zu aktualisieren",
			},
			NOW = "Aktualisieren",
			LATER = "Später",
		}
	elseif language == "fr" then
		return {
			TITLE = "Extensions obsolètes",
			DESC = {
				[1] = "Merci d'utiliser les extensions d'Elder Scrolls Online\n\nIl apparait cependant que certaines d'entre elles soient obsolètes\n\nN'oubliez pas de les mettre à jour",
				[2] = "Merci d'utiliser les extensions d'Elder Scrolls Online\nIl apparait cependant que certaines d'entre elles soient obsolètes\n\nN'oubliez pas de les mettre à jour",
			},
			NOW = "Mettre à Jour",
			LATER = "Plus tard",
		}
	else
		return {
			TITLE = "Outdated add-ons",
			DESC = {
				[1] = "Thank you for using Elder Scrolls Online add-ons\n\nHowever, it looks like some of them are now out of date\n\nDon't forget to update",
				[2] = "Thank you for using Elder Scrolls Online add-ons\nHowever, it looks like some of them are now out of date\n\nDon't forget to update",
			},
			NOW = "Update",
			LATER = "Later",
		}
	end

end

local function GetDLCTextures()
	
	local picts = {}
	for dlcIndex = 1 , GetTotalCollectiblesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_DLC) do
		local collectibleId = GetCollectibleIdFromType(COLLECTIBLE_CATEGORY_TYPE_DLC, dlcIndex) 
		local pict = GetCollectibleGamepadBackgroundImage(collectibleId)
		table.insert(picts, pict)
	end
	
	for chapterIndex = 1 , GetTotalCollectiblesByCategoryType(COLLECTIBLE_CATEGORY_TYPE_CHAPTER) do
		local collectibleId = GetCollectibleIdFromType(COLLECTIBLE_CATEGORY_TYPE_CHAPTER, chapterIndex) 
		local pict = GetCollectibleGamepadBackgroundImage(collectibleId)
		table.insert(picts, pict)
	end
	
	return picts
    
end

local function PushDialog()
	PushActionLayerByName(GetString(SI_KEYBINDINGS_LAYER_DIALOG))
end

local function ReleaseDialog()
	ZO_Dialogs_ReleaseDialog("LAUNIG", true)
	RemoveActionLayerByName(GetString(SI_KEYBINDINGS_LAYER_DIALOG))
end

local function CloseAnnouncement()
	ReleaseDialog()
	if IsGameCameraUIModeActive() then
		SetGameCameraUIMode(false)
	end
end

local function GoOnUpdateWebsite()
	RequestOpenUnsafeURL(UPDATE_WEBSITE)
end

local function DrawKeyboardUI(tlw)

	local textures = GetDLCTextures()

	local container = wm:CreateControl("$(parent)Container", tlw, CT_CONTROL)
	container:SetAnchor(RIGHT, nil, RIGHT, -80, 0)
	container:SetDimensions(600, 725)
	
		local background = CreateControlFromVirtual("$(parent)BG", container, "ZO_DefaultBackdrop")
		
		local title = wm:CreateControl("$(parent)Title", container, CT_LABEL)
		title:SetAnchor(TOP, nil, TOP, 0, 15)
		title:SetFont("ZoFontWinH1")
		title:SetModifyTextType(MODIFY_TEXT_TYPE_UPPERCASE)
		title:SetText(lang.TITLE)
		
		local divider = CreateControlFromVirtual("$(parent)Divider", container, "ZO_Options_Divider")
		divider:SetAnchor(TOP, nil, TOP, 0, 50)
		
		local pict = wm:CreateControl("$(parent)Pict", container, CT_TEXTURE)
		pict:SetAnchor(TOP, nil, TOP, 0, 65)
		pict:SetDimensions(575, 550)
		pict:SetTexture(textures[zo_random(1, #textures)])
		pict:SetTextureCoords(0, 407 / 512, 0, 1)
		
		local description = wm:CreateControl("$(parent)Description", container, CT_LABEL)
		description:SetAnchor(BOTTOMLEFT, nil, BOTTOMLEFT, 20, -55)
		description:SetFont("ZoFontGameLargeBold")
		description:SetColor(ZO_NORMAL_TEXT:UnpackRGBA())
		description:SetText(lang.DESC[platform])
		
		local keybinds = wm:CreateControl("$(parent)Keybinds", container, CT_CONTROL)
		keybinds:SetAnchor(BOTTOMRIGHT, nil, BOTTOMRIGHT, -10, -10)
		
			local updatenow = CreateControlFromVirtual("$(parent)UpdateNow", keybinds, "ZO_KeybindButton")
			updatenow:SetAnchor(BOTTOMRIGHT, nil, BOTTOMRIGHT, 0, 0)
			updatenow:SetKeybind("DIALOG_PRIMARY")
			updatenow:SetCallback(GoOnUpdateWebsite)
			
				local updatenowlbl = GetControl(updatenow, "NameLabel")
				updatenowlbl:SetText(lang.NOW)

			local updatelater = CreateControlFromVirtual("$(parent)UpdateLater", keybinds, "ZO_KeybindButton")
			updatelater:SetAnchor(RIGHT, updatenow, LEFT, -10, 0)
			updatelater:SetKeybind("DIALOG_NEGATIVE")
			updatelater:SetCallback(CloseAnnouncement)
		
				local updatelaterlbl = GetControl(updatelater, "NameLabel")
				updatelaterlbl:SetText(lang.LATER)
			
end

local function InitializeAnnouncement()

	local tlw = wm:CreateTopLevelWindow("Launig")
	tlw:SetDrawLayer(DL_OVERLAY)
	tlw:SetDrawTier(DT_HIGH)
	tlw:SetAnchorFill()
	tlw:SetHidden(true)
	
	tlw:SetHandler("OnEffectivelyShown", PushDialog)
	tlw:SetHandler("OnEffectivelyHidden", ReleaseDialog)
	
	if IsInGamepadPreferredMode() then
		platform = 1
		lang = GetLangStrings(GetCVar("Language.2"))
	else
		platform = 2
		lang = GetLangStrings(GetCVar("Language.2"))
		DrawKeyboardUI(tlw)
	end
	
	ZO_Dialogs_RegisterCustomDialog("LAUNIG",
	{
		gamepadInfo = {
			dialogType = GAMEPAD_DIALOGS.BASIC,
			allowShowOnNextScene = true,
			shouldShowTooltip = true,
		},
		customControl = tlw,
		title =
		{
			text = lang.TITLE,
		},
		mainText = {
			text = lang.DESC[platform]
		},
		buttons =
		{
			{
				control = GetControl(tlw, "ContainerKeybindsUpdateNow"),
				text = lang.NOW,
				keybind = "DIALOG_PRIMARY",
				callback = GoOnUpdateWebsite,
			},  
			{
				control = GetControl(tlw, "ContainerKeybindsUpdateLater"),
				text = lang.LATER,
				keybind = "DIALOG_NEGATIVE",
				callback = CloseAnnouncement,
			},
		}
	})
	
end

local function ShowAnnouncement()
	ZO_Dialogs_ShowPlatformDialog("LAUNIG")
end

local function HaveOutdatedAddons()
	
	local AddOnManager = GetAddOnManager()
	local haveOutdatedAddons
	
	for addonIndex = 1, AddOnManager:GetNumAddOns() do
		local _, _, _, _, enabled, state, isOutOfDate = AddOnManager:GetAddOnInfo(addonIndex)
		haveOutdatedAddons = enabled and isOutOfDate and state == ADDON_STATE_ENABLED or false -- addons can be enabled and state ~= ADDON_STATE_ENABLED
		if haveOutdatedAddons then
			return haveOutdatedAddons
		end
	end
	
	return true
	
end

local function OnPlayerActivated()
	if SCENE_MANAGER:GetCurrentScene():GetName() ~= "marketAnnouncement" then
		EVENT_MANAGER:UnregisterForEvent(LIB_NAME, EVENT_PLAYER_ACTIVATED)
		ShowAnnouncement()
	end
end

function Launig:Init()
	
	local apiVersion = GetAPIVersion()
	local now = GetTimeStamp()
	if GetWorldName() ~= "PTS" then
		if SV_HOST then
			if not SV_HOST.Launig or apiVersion > SV_HOST.Launig.a then
				SV_HOST.Launig = { t = now, a = apiVersion, d = false } -- time, api, displayed
			elseif HaveOutdatedAddons() then
				local remindPeriod = GRACE_PERIOD
				if SV_HOST.Launig.d then
					remindPeriod = REPEAT_EVERY
				end
				if now > SV_HOST.Launig.t + remindPeriod then
					SV_HOST.Launig.t = now
					SV_HOST.Launig.d = true
					InitializeAnnouncement()
					EVENT_MANAGER:RegisterForEvent(LIB_NAME, EVENT_PLAYER_ACTIVATED, OnPlayerActivated)
				end
			end
		end
	end
	
end

local function OnAddonLoaded()
	if not libLoaded then
		libLoaded = true
		local LAUNIG = LibStub('Launig')
		LAUNIG:Init()
		EVENT_MANAGER:UnregisterForEvent(LIB_NAME, EVENT_ADD_ON_LOADED)
	end
end

EVENT_MANAGER:RegisterForEvent(LIB_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)