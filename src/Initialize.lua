--[[
    LuiExtended
    License: The MIT License (MIT)
]]

---@class (partial) LuiExtended
---@field Combat LUIE.CombatInfo
local LUIE = LUIE;

local zo_strformat = zo_strformat;
local eventManager = GetEventManager();
-- Ensure LibMediaProvider is initialized
local LMP = LibMediaProvider;
if not LMP then
    error('LibMediaProvider is not initialized', 2);
end;

-- Reference to CALLBACK_MANAGER for registering callbacks
local cm = CALLBACK_MANAGER;

--[[
    Load saved settings.
]]
local function LoadSavedVars()
    -- Addon options
    LUIE.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, nil, LUIE.Defaults);
    if LUIE.SV.CharacterSpecificSV then
        LUIE.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, nil, LUIE.Defaults);
    end;
end;

--[[
    Load additional fonts from LMP.
]]
local function UpdateFonts()
    for _, f in pairs(LMP:List(LMP.MediaType.FONT)) do
        if not LUIE.Fonts[f] then
            LUIE.Fonts[f] = LMP:Fetch(LMP.MediaType.FONT, f);
        end;
    end;
end;

--[[
    Load additional status bar textures from LMP.
]]
local function UpdateStatusbarTextures()
    for _, s in pairs(LMP:List(LMP.MediaType.STATUSBAR)) do
        if not LUIE.StatusbarTextures[s] then
            LUIE.StatusbarTextures[s] = LMP:Fetch(LMP.MediaType.STATUSBAR, s);
        end;
    end;
end;

--[[
    Load additional sounds from LMP.
]]
local function UpdateSounds()
    for _, a in pairs(LMP:List(LMP.MediaType.SOUND)) do
        if not LUIE.Sounds[a] then
            LUIE.Sounds[a] = LMP:Fetch(LMP.MediaType.SOUND, a);
        end;
    end;
end;

--[[
    Load additional media from LMP.
]]
local function LoadMedia()
    UpdateFonts();
    UpdateStatusbarTextures();
    UpdateSounds();
end;

--[[
    Startup Info string.
]]
local function LoadScreen()
    eventManager:UnregisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED);
    -- Set Positions for moved Default UI elements
    LUIE.SetElementPosition();
    if not LUIE.SV.StartupInfo then
        LUIE.PrintToChat(zo_strformat('|cFFFFFF<<1>> by|r |c00C000<<2>>|r |cFFFFFFv<<3>>|r', LUIE.name, LUIE.author, LUIE.version), true);
    end;
end;

--[[
    Register events.
]]
local function RegisterEvents()
    eventManager:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LoadScreen);

    -- Register for LibMediaProvider media registration callbacks
    if LMP then
        cm:RegisterCallback('LibMediaProvider_Registered', function (mediatype, key)
            if mediatype == LMP.MediaType.FONT then
                LUIE.Fonts[key] = LMP:Fetch(mediatype, key);
            elseif mediatype == LMP.MediaType.STATUSBAR then
                LUIE.StatusbarTextures[key] = LMP:Fetch(mediatype, key);
            elseif mediatype == LMP.MediaType.SOUND then
                LUIE.Sounds[key] = LMP:Fetch(mediatype, key);
            end;
        end);
    end;

    -- Existing event registrations
    if LUIE.SV.SlashCommands_Enable or LUIE.SV.ChatAnnouncements_Enable then
        LUIE.UpdateGuildData();
        eventManager:RegisterForEvent(LUIE.name .. 'ChatAnnouncements', EVENT_GUILD_SELF_JOINED_GUILD, LUIE.UpdateGuildData);
        eventManager:RegisterForEvent(LUIE.name .. 'ChatAnnouncements', EVENT_GUILD_SELF_LEFT_GUILD, LUIE.UpdateGuildData);
    end;

    -- Load additional media from LMP and other addons
    LoadMedia();
end;

--[[
    LuiExtended Initialization.
]]
local function OnAddonOnLoaded(eventCode, addonName)
    -- Only initialize our own addon
    if LUIE.name ~= addonName then
        return;
    end;
    -- Once we know it's ours, lets unregister the event listener
    eventManager:UnregisterForEvent(addonName, eventCode);

    -- Load saved variables
    LoadSavedVars();
    -- Initialize Hooks
    LUIE.InitializeHooks();
    -- Toggle Alert Frame Visibility if needed
    LUIE.SetupAlertFrameVisibility();
    LUIE.PlayerNameRaw = GetRawUnitName('player');
    LUIE.PlayerNameFormatted = zo_strformat('<<C:1>>', GetUnitName('player'));
    LUIE.PlayerDisplayName = zo_strformat('<<C:1>>', GetUnitDisplayName('player'));
    LUIE.PlayerFaction = GetUnitAlliance('player');
    -- Initialize this addon modules according to user preferences
    LUIE.ChatAnnouncements.Initialize(LUIE.SV.ChatAnnouncements_Enable);
    LUIE.CombatInfo.Initialize(LUIE.SV.CombatInfo_Enabled);
    LUIE.CombatText.Initialize(LUIE.SV.CombatText_Enabled);
    LUIE.InfoPanel.Initialize(LUIE.SV.InfoPanel_Enabled);
    LUIE.UnitFrames.Initialize(LUIE.SV.UnitFrames_Enabled);
    LUIE.SpellCastBuffs.Initialize(LUIE.SV.SpellCastBuff_Enable);
    LUIE.SlashCommands.Initialize(LUIE.SV.SlashCommands_Enable);
    -- Load Timestamp Color
    LUIE.UpdateTimeStampColor();
    -- Create settings menus for our addon
    LUIE.CreateSettings();
    LUIE.ChatAnnouncements.CreateSettings();
    LUIE.CombatInfo.CreateSettings();
    LUIE.CombatText.CreateSettings();
    LUIE.InfoPanel.CreateSettings();
    LUIE.UnitFrames.CreateSettings();
    LUIE.SpellCastBuffs.CreateSettings();
    LUIE.SlashCommands.CreateSettings();
    LUIE.SlashCommands.MigrateSettings();
    -- Display changelog screen
    LUIE.ChangelogScreen();
    -- Register global event listeners
    RegisterEvents();
end;

-- Hook initialization
eventManager:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, OnAddonOnLoaded);
