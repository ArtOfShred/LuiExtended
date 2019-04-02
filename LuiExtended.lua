--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- LUIE namespace
LUIE             = {}
LUIE.name        = "LuiExtended"
LUIE.author      = "ArtOfShred, psypanda & SpellBuilder"
LUIE.version     = "5.8.1"
LUIE.website     = "http://www.esoui.com/downloads/info818-LuiExtended.html"
LUIE.github      = "https://github.com/ArtOfShred/LuiExtended"

-- Saved variables options
LUIE.SV          = nil
LUIE.SVVer       = 2
LUIE.SVName      = "LUIESV"

-- Performance Enhancement
local strfmt        = string.format
local strformat     = zo_strformat

local eventManager  = EVENT_MANAGER

local TimeStampColorize

-- Default Settings
LUIE.D = {
    CharacterSpecificSV         = false,
    StartupInfo                 = false,
    HideXPBar                   = false,
    TempAlertHome               = false,
    TempAlertCampaign           = false,
    TempAlertOutfit             = false,
    WelcomeVersion              = 0,

    -- Modules
    UnitFrames_Enabled          = true,
    InfoPanel_Enabled           = true,
    CombatInfo_Enabled          = true,
    CombatText_Enabled          = true,
    SpellCastBuff_Enable        = true,
    ChatAnnouncements_Enable    = true,
    SlashCommands_Enable        = true,
}

-- Global fonts table to use in other parts of this addon
LUIE.Fonts = {
    ["ProseAntique"]            = ZoFontBookPaper:GetFontInfo(),
    ["Consolas"]                = "/EsoUI/Common/Fonts/consola.ttf",
    ["Futura Condensed"]        = "/EsoUI/Common/Fonts/FTN57.otf",
    ["Futura Condensed Bold"]   = "/EsoUI/Common/Fonts/FTN87.otf",
    ["Futura Condensed Light"]  = "/EsoUI/Common/Fonts/FTN47.otf",
    ["Skyrim Handwritten"]      = ZoFontBookLetter:GetFontInfo(),
    ["Trajan Pro"]              = ZoFontBookTablet:GetFontInfo(),
    ["Univers 55"]              = "/EsoUI/Common/Fonts/univers55.otf",
    ["Univers 57"]              = ZoFontGame:GetFontInfo(),
    ["Univers 67"]              = ZoFontWinH1:GetFontInfo(),
    ["Fontin Bold"]             = "/LuiExtended/media/fonts/Fontin/fontin_sans_b.otf",
    ["Fontin Italic"]           = "/LuiExtended/media/fonts/Fontin/fontin_sans_i.otf",
    ["Fontin Regular"]          = "/LuiExtended/media/fonts/Fontin/fontin_sans_r.otf",
    ["Fontin SmallCaps"]        = "/LuiExtended/media/fonts/Fontin/fontin_sans_sc.otf",
    ["Trajan Pro Bold"]         = "/LuiExtended/media/fonts/TrajanPro/TrajanProBold.otf",
    ["EnigmaReg"]               = "/LuiExtended/media/fonts/Enigma/EnigmaReg.ttf",
    ["EnigmaBold"]              = "/LuiExtended/media/fonts/Enigma/EnigmaBold.ttf",
    ["Adventure"]               = "/LuiExtended/media/fonts/Adventure/adventure.ttf",
    ["Bazooka"]                 = "/LuiExtended/media/fonts/Bazooka/bazooka.ttf",
    ["Cooline"]                 = "/LuiExtended/media/fonts/Cooline/cooline.ttf",
    ["Diogenes"]                = "/LuiExtended/media/fonts/Diogenes/diogenes.ttf",
    ["Ginko"]                   = "/LuiExtended/media/fonts/Ginko/ginko.ttf",
    ["Heroic"]                  = "/LuiExtended/media/fonts/Heroic/heroic.ttf",
    ["Metamorphous"]            = "/LuiExtended/media/fonts/Metamorphous/metamorphous.otf",
    ["Porky"]                   = "/LuiExtended/media/fonts/Porky/porky.ttf",
    ["Roboto Bold"]             = "/LuiExtended/media/fonts/Roboto/Roboto-Bold.ttf",
    ["Roboto Bold Italic"]      = "/LuiExtended/media/fonts/Roboto/Roboto-BoldItalic.ttf",
    ["Talisman"]                = "/LuiExtended/media/fonts/Talisman/talisman.ttf",
    ["Transformers"]            = "/LuiExtended/media/fonts/Transformers/transformers.ttf",
    ["Yellowjacket"]            = "/LuiExtended/media/fonts/Yellowjacket/yellowjacket.ttf",
    ["ProFontWindows"]          = "/LuiExtended/media/fonts/ProFontWindows/ProFontWindows.ttf",
}

LUIE.Sounds = {
    ["Death Recap Killing Blow"]  = SOUNDS.DEATH_RECAP_KILLING_BLOW_SHOWN,
}

LUIE.StatusbarTextures = {
    ["Aluminium"]               = "/LuiExtended/media/unitframes/textures/Aluminium.dds",
    ["Elder Scrolls Gradient"]  = "/LuiExtended/media/unitframes/textures/ElderScrollsGrad.dds",
    ["Glass"]                   = "/LuiExtended/media/unitframes/textures/Glass.dds",
    ["Glaze"]                   = "/LuiExtended/media/unitframes/textures/Glaze.dds",
    ["Horizontal Gradient 1"]   = "/LuiExtended/media/unitframes/textures/HorizontalGrad.dds",
    ["Horizontal Gradient 2"]   = "/LuiExtended/media/unitframes/textures/HorizontalGradV2.dds",
    ["Inner Glow"]              = "/LuiExtended/media/unitframes/textures/InnerGlow.dds",
    ["Inner Shadow"]            = "/LuiExtended/media/unitframes/textures/InnerShadow.dds",
    ["Inner Shadow Glossy"]     = "/LuiExtended/media/unitframes/textures/InnerShadowGloss.dds",
    ["Minimalistic"]            = "/LuiExtended/media/unitframes/textures/Minimalistic.dds",
    ["Round"]                   = "/LuiExtended/media/unitframes/textures/Round.dds",
    ["Sand Paper 1"]            = "/LuiExtended/media/unitframes/textures/SandPaper.dds",
    ["Sand Paper 2"]            = "/LuiExtended/media/unitframes/textures/SandPaperV2.dds",
    ["Shadow"]                  = "/LuiExtended/media/unitframes/textures/Shadow.dds",
    ["Smooth"]                  = "/LuiExtended/media/unitframes/textures/Smooth.dds",
    ["Plain"]                   = "/LuiExtended/media/unitframes/textures/Plain.dds",
}

-- Load saved settings
local function LUIE_LoadSavedVars()
    -- Addon options
    LUIE.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, nil, LUIE.D)

    if LUIE.SV.CharacterSpecificSV then
        LUIE.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, nil, LUIE.D)
    end
end

-- Load additional fonts and status bar textures from LMP if it is present in environment
local function LUIE_LoadMedia()
    local LMP = LibStub("LibMediaProvider-1.0")
    if LMP == nil then
        return
    end

    -- Update Fonts
    for _, f in pairs(LMP:List(LMP.MediaType.FONT)) do
        if not LUIE.Fonts[f] then
            LUIE.Fonts[f] = LMP:Fetch(LMP.MediaType.FONT, f)
        end
    end

    -- Update StatusBar textures
    for _, s in pairs(LMP:List(LMP.MediaType.STATUSBAR)) do
        if not LUIE.StatusbarTextures[s] then
            LUIE.StatusbarTextures[s] = LMP:Fetch(LMP.MediaType.STATUSBAR, s)
        end
    end

    for _, a in pairs(LMP:List(LMP.MediaType.SOUND)) do
        if not LUIE.StatusbarTextures[a] then
            LUIE.Sounds[a] = LMP:Fetch(LMP.MediaType.SOUND, a)
        end
    end
end

-- Startup Info string
local function LUIE_LoadScreen()
    eventManager:UnregisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED)

    if not LUIE.SV.StartupInfo then
        LUIE.PrintToChat(strfmt("|cFEFEFE%s by|r |c00C000%s|r |cFEFEFEv%s|r", LUIE.name, LUIE.author, LUIE.version), true)
    end
end

local function LUIE_RegisterEvents()
    eventManager:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LUIE_LoadScreen)
    -- Keep track of guilds for the /ginvite commands & Chat Announcement EVENT_GUILD_SELF_LEFT_GUILD handler
    if LUIE.SV.SlashCommands_Enable or LUIE.SV.ChatAnnouncements_Enable then
        LUIE.UpdateGuildData()
        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, LUIE.UpdateGuildData)
        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD, LUIE.UpdateGuildData)
    end
end

-- LuiExtended Initialization
local function LUIE_OnAddOnLoaded(eventCode, addonName)
    -- Only initialize our own addon
    if LUIE.name ~= addonName then
        return
    end
    -- Once we know it's ours, lets unregister the event listener
    eventManager:UnregisterForEvent(addonName, eventCode)

    -- Load additional media from LMP and other addons
    LUIE_LoadMedia()

    -- Load saved variables
    LUIE_LoadSavedVars()

    -- Display changelog screen
    LUIE_ChangelogScreen()

    LUIE.PlayerNameRaw = GetRawUnitName("player")
    LUIE.PlayerNameFormatted = strformat(SI_UNIT_NAME, GetUnitName("player"))
    LUIE.PlayerDisplayName = strformat(SI_UNIT_NAME, GetUnitDisplayName("player"))

    -- Initialize this addon modules according to user preferences
    LUIE.ChatAnnouncements.Initialize( LUIE.SV.ChatAnnouncements_Enable )
    LUIE.CombatInfo.Initialize( LUIE.SV.CombatInfo_Enabled )
    LUIE.CombatText.Initialize ( LUIE.SV.CombatText_Enabled )
    LUIE.InfoPanel.Initialize( LUIE.SV.InfoPanel_Enabled )
    LUIE.UnitFrames.Initialize( LUIE.SV.UnitFrames_Enabled )
    LUIE.SpellCastBuffs.Initialize( LUIE.SV.SpellCastBuff_Enable )
    LUIE.SlashCommands.Initialize( LUIE.SV.SlashCommands_Enable )

    -- Load Timetamp Color
    LUIE.UpdateTimeStampColor()

    -- Create settings menu for our addon
    LUIE.CreateSettings()

    -- Register global event listeners
    LUIE_RegisterEvents()

    -- Hooks
    LUIE.Hooks()

end

-- Called from the menu and on initialization to update timestamp color when changed.
function LUIE.UpdateTimeStampColor()
    TimeStampColorize = ZO_ColorDef:New(unpack(LUIE.ChatAnnouncements.SV.TimeStampColor)):ToHex()
end

-- Return a formatted time
-- Stolen from pChat, thanks @Ayantir
function LUIE.CreateTimestamp(timeStr, formatStr)
    local formatStr = formatStr or LUIE.ChatAnnouncements.SV.TimeStampFormat

    -- Split up default timestamp
    local hours, minutes, seconds = timeStr:match("([^%:]+):([^%:]+):([^%:]+)")
    local hoursNoLead = tonumber(hours) -- Hours without leading zero
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
    timestamp = timestamp:gsub("H",  hoursNoLead)
    timestamp = timestamp:gsub("hh", hours12)
    timestamp = timestamp:gsub("h",  hours12NoLead)
    timestamp = timestamp:gsub("m",  minutes)
    timestamp = timestamp:gsub("s",  seconds)
    timestamp = timestamp:gsub("A",  pUp)
    timestamp = timestamp:gsub("a",  pLow)

    return timestamp
end

-- FormatMessage helper function
function LUIE.FormatMessage(msg, doTimestamp)
    local msg = msg or ""
    if doTimestamp then
        local timestring = GetTimeString()
        -- Color Code to match pChat default
        msg = strfmt("|c%s[%s]|r %s", TimeStampColorize, LUIE.CreateTimestamp(timestring), msg)
    end
    return msg
end

-- Easy Print to Chat
function LUIE.PrintToChat(msg, isSystem)
    if LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" then
        if not LUIE.ChatAnnouncements.SV.ChatBypass and CHAT_SYSTEM.primaryContainer then
            local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
            -- Add timestamps if bypass is not enabled
            CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
        else
            -- Otherwise send as a normal message and let other addons handle this.
            CHAT_SYSTEM:AddMessage(msg)
        end
    else
        -- If we have system messages sent to display in all windows then just print to all windows at once, otherwise send messages to individual tabs.
        if CHAT_SYSTEM.primaryContainer then
            if isSystem and LUIE.ChatAnnouncements.SV.ChatSystemAll then
                local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                -- Post as a System message so that it can appear in multiple tabs.
                CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
            else
                local chatContainer = CHAT_SYSTEM.primaryContainer
                for i = 1, #chatContainer.windows do
                    if LUIE.ChatAnnouncements.SV.ChatTab[i] == true then
                        local chatWindow = CHAT_SYSTEM.primaryContainer["windows"][i]
                        local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                        chatContainer:AddEventMessageToWindow(chatWindow, msg, CHAT_CATEGORY_SYSTEM)
                    end
                end
            end
        end
    end
end

-- Returns a formatted number with commas
-- Function no comma to be added in a later date.
function LUIE.AbbreviateNumber(number, shorten, comma)
    if number > 0 and shorten then
        local value
        local suffix

        if number >= 1000000000 then
            value = number / 1000000000
            suffix = "G"
        elseif number >= 1000000 then
            value = number / 1000000
            suffix = "M"
        elseif number >= 1000 then
            value = number / 1000
            suffix = "k"
        else
            value = number
        end

        -- If we could not conver even to "G", return full number
        if value >= 1000 then
            if comma then
                value = ZO_LocalizeDecimalNumber(number)
                return value
            else
                return number
            end
        elseif value >= 100 or suffix == nil then
            value = strfmt("%d", value)
        else
            value = strfmt("%.1f", value)
        end

        if suffix ~= nil then
            value = value .. suffix
        end

        return value
    end

    -- Add commas if needed
    if comma then
        local value = ZO_LocalizeDecimalNumber(number)
        return value
    end

    return number
end

function LUIE.UpdateGuildData()
    local GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

-- Simple function to check veteran difficult (VMA isn't considered being in a Veteran Dungeon so we have to do some filtering)
function LUIE.ResolveVeteranDifficulty()
    if GetGroupSize() <= 1 and IsUnitUsingVeteranDifficulty('player') then
        return true
    elseif GetCurrentZoneDungeonDifficulty() == 2 or IsGroupUsingVeteranDifficulty() == true then
        return true
    else
        return false
    end
end

-- Hook initialization
eventManager:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, LUIE_OnAddOnLoaded)
