-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LUIE

local zo_strformat = zo_strformat
local eventManager = GetEventManager()

-- Load saved settings.
local function LoadSavedVars()
    -- Addon options
    LUIE.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, nil, LUIE.Defaults)
    if LUIE.SV.CharacterSpecificSV then
        LUIE.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, nil, LUIE.Defaults)
    end
end

-- Startup Info string.
local function LoadScreen()
    eventManager:UnregisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED)
    -- Set Positions for moved Default UI elements
    LUIE.SetElementPosition()
    if not LUIE.SV.StartupInfo then
        LUIE.PrintToChat(zo_strformat("|cFFFFFF<<1>> by|r |c00C000<<2>>|r |cFFFFFFv<<3>>|r", LUIE.name, LUIE.author, LUIE.version), true)
    end
end

-- Register events.
local function RegisterEvents()
    eventManager:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LoadScreen)
    -- Existing event registrations
    if LUIE.SV.SlashCommands_Enable or LUIE.SV.ChatAnnouncements_Enable then
        LUIE.UpdateGuildData()
        eventManager:RegisterForEvent(LUIE.name .. "ChatAnnouncements", EVENT_GUILD_SELF_JOINED_GUILD, LUIE.UpdateGuildData)
        eventManager:RegisterForEvent(LUIE.name .. "ChatAnnouncements", EVENT_GUILD_SELF_LEFT_GUILD, LUIE.UpdateGuildData)
    end
end

local function CreateSettings()
    LUIE.CreateSettings()
    LUIE.ChatAnnouncements.CreateSettings()
    LUIE.CombatInfo.CreateSettings()
    LUIE.CombatText.CreateSettings()
    LUIE.InfoPanel.CreateSettings()
    LUIE.UnitFrames.CreateSettings()
    LUIE.SpellCastBuffs.CreateSettings()
    LUIE.SlashCommands.CreateSettings()
    LUIE.SlashCommands.MigrateSettings()
end

local function Initialize()
    -- Initialize this addon modules according to user preferences
    LUIE.ChatAnnouncements.Initialize(LUIE.SV.ChatAnnouncements_Enable)
    LUIE.CombatInfo.Initialize(LUIE.SV.CombatInfo_Enabled)
    LUIE.CombatText.Initialize(LUIE.SV.CombatText_Enabled)
    LUIE.InfoPanel.Initialize(LUIE.SV.InfoPanel_Enabled)
    LUIE.UnitFrames.Initialize(LUIE.SV.UnitFrames_Enabled)
    LUIE.SpellCastBuffs.Initialize(LUIE.SV.SpellCastBuff_Enable)
    LUIE.SlashCommands.Initialize(LUIE.SV.SlashCommands_Enable)
end

-- LuiExtended Initialization.
eventManager:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, function (eventCode, addonName)
    -- Only initialize our own addon
    if LUIE.name ~= addonName then
        return
    end
    -- Once we know it's ours, lets unregister the event listener
    eventManager:UnregisterForEvent(addonName, eventCode)
    -- Load saved variables
    LoadSavedVars()
    -- Initialize Hooks
    LUIE.InitializeHooks()
    -- Toggle Alert Frame Visibility if needed
    LUIE.SetupAlertFrameVisibility()

    Initialize()

    -- Load Timestamp Color
    LUIE.UpdateTimeStampColor()
    -- Create settings menus for our addon
    CreateSettings()
    -- Display changelog screen
    LUIE.ChangelogScreen()
    -- Register global event listeners
    RegisterEvents()
end)
