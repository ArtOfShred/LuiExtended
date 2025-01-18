-- -----------------------------------------------------------------------------
--  LuiExtended
--  Distributed under The MIT License (MIT) (see LICENSE file)
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
--- @field name string The addon name
--- @field author string The addon author
--- @field version string The addon version
--- @field SVName string SavedVariables name
--- @field SVVer number SavedVariables version
--- @field Defaults table Default settings
--- @field SV table Current saved variables
local LUIE = LUIE

-- Local references for better performance
local zo_strformat = zo_strformat
local eventManager = GetEventManager()

--- Loads and initializes saved variables for the addon
--- @return nil
local function LoadSavedVars()
    -- Initialize account-wide settings first
    LUIE.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, nil, LUIE.Defaults)

    -- Override with character-specific settings if enabled
    if LUIE.SV.CharacterSpecificSV then
        LUIE.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, nil, LUIE.Defaults)
    end
end

--- Handles the player activation event and displays startup information
--- @return nil
local function LoadScreen()
    -- Cleanup event listener
    eventManager:UnregisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED)

    -- Initialize UI element positions
    LUIE.SetElementPosition()

    -- Display startup message if enabled
    if not LUIE.SV.StartupInfo then
        LUIE.PrintToChat(zo_strformat("|cFFFFFF<<1>> by|r |c00C000<<2>>|r |cFFFFFFv<<3>>|r",
            LUIE.name, LUIE.author, LUIE.version), true)
    end
end

--- Registers all necessary event handlers for the addon
--- @return nil
local function RegisterEvents()
    -- Register player activation handler
    eventManager:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LoadScreen)

    -- Register guild-related events if needed features are enabled
    if LUIE.SV.SlashCommands_Enable or LUIE.SV.ChatAnnouncements_Enable then
        LUIE.UpdateGuildData()
        local eventNamespace = LUIE.name .. "ChatAnnouncements"
        eventManager:RegisterForEvent(eventNamespace, EVENT_GUILD_SELF_JOINED_GUILD, LUIE.UpdateGuildData)
        eventManager:RegisterForEvent(eventNamespace, EVENT_GUILD_SELF_LEFT_GUILD, LUIE.UpdateGuildData)
    end
end

--- Creates and initializes all addon settings menus
--- @return nil
local function CreateSettings()
    -- Initialize core settings
    LUIE.CreateSettings()

    -- Initialize module-specific settings
    LUIE.ChatAnnouncements.CreateSettings()
    LUIE.CombatInfo.CreateSettings()
    LUIE.CombatText.CreateSettings()
    LUIE.InfoPanel.CreateSettings()
    LUIE.UnitFrames.CreateSettings()
    LUIE.SpellCastBuffs.CreateSettings()
    LUIE.SlashCommands.CreateSettings()

    -- Handle settings migration
    LUIE.SlashCommands.MigrateSettings()
end

--- Initializes all addon modules based on user preferences
--- @return nil
local function Initialize()
    -- Initialize each module with its enabled state from saved variables
    LUIE.ChatAnnouncements.Initialize(LUIE.SV.ChatAnnouncements_Enable)
    LUIE.CombatInfo.Initialize(LUIE.SV.CombatInfo_Enabled)
    LUIE.CombatText.Initialize(LUIE.SV.CombatText_Enabled)
    LUIE.InfoPanel.Initialize(LUIE.SV.InfoPanel_Enabled)
    LUIE.UnitFrames.Initialize(LUIE.SV.UnitFrames_Enabled)
    LUIE.SpellCastBuffs.Initialize(LUIE.SV.SpellCastBuff_Enable)
    LUIE.SlashCommands.Initialize(LUIE.SV.SlashCommands_Enable)
end

-- Main Initialization Handler
--- @param eventCode number The event code that triggered this callback
--- @param addonName string The name of the addon that was loaded
local function OnAddonLoaded(eventCode, addonName)
    if LUIE.name ~= addonName then
        return
    end

    eventManager:UnregisterForEvent(addonName, eventCode)
    -- -----------------------------------------------------------------------------
    LUIE.PlayerNameRaw = GetRawUnitName("player")
    -- -----------------------------------------------------------------------------
    LUIE.PlayerNameFormatted = zo_strformat(SI_UNIT_NAME, GetUnitName("player"))
    -- -----------------------------------------------------------------------------
    LUIE.PlayerDisplayName = zo_strformat(SI_UNIT_NAME, GetUnitDisplayName("player"))
    -- -----------------------------------------------------------------------------
    LUIE.PlayerFaction = GetUnitAlliance("player")
    -- -----------------------------------------------------------------------------

    LoadSavedVars()
    LUIE.InitializeHooks()
    LUIE.SetupAlertFrameVisibility()
    Initialize()
    LUIE.UpdateTimeStampColor()
    CreateSettings()
    LUIE.ChangelogScreen()
    RegisterEvents()
end

-- Register the addon loaded event handler
eventManager:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, OnAddonLoaded)

-- Optional Profiling Support (Commented out by default)
--[[
local AddonProfiler = _G["AddonProfiler"]

local function OnAddonLoadedWithProfiling(eventCode, addonName)
    if LUIE.name ~= addonName then return end

    if AddonProfiler then
        AddonProfiler:Start(LUIE.name)
        AddonProfiler:MarkEvent("Initialization Start")
    end

    eventManager:UnregisterForEvent(addonName, eventCode)

    -- Profile initialization sequence
    if AddonProfiler then AddonProfiler:MarkEvent("SavedVars Start") end
    LoadSavedVars()
    if AddonProfiler then AddonProfiler:MarkEvent("SavedVars End") end

    if AddonProfiler then AddonProfiler:MarkEvent("Hooks Start") end
    LUIE.InitializeHooks()
    if AddonProfiler then AddonProfiler:MarkEvent("Hooks End") end

    if AddonProfiler then AddonProfiler:MarkEvent("AlertFrame Start") end
    LUIE.SetupAlertFrameVisibility()
    if AddonProfiler then AddonProfiler:MarkEvent("AlertFrame End") end

    if AddonProfiler then AddonProfiler:MarkEvent("Main Initialize Start") end
    Initialize()
    if AddonProfiler then AddonProfiler:MarkEvent("Main Initialize End") end

    if AddonProfiler then AddonProfiler:MarkEvent("TimeStamp Start") end
    LUIE.UpdateTimeStampColor()
    if AddonProfiler then AddonProfiler:MarkEvent("TimeStamp End") end

    if AddonProfiler then AddonProfiler:MarkEvent("Settings Start") end
    CreateSettings()
    if AddonProfiler then AddonProfiler:MarkEvent("Settings End") end

    if AddonProfiler then AddonProfiler:MarkEvent("Changelog Start") end
    LUIE.ChangelogScreen()
    if AddonProfiler then AddonProfiler:MarkEvent("Changelog End") end

    if AddonProfiler then AddonProfiler:MarkEvent("Events Start") end
    RegisterEvents()
    if AddonProfiler then AddonProfiler:MarkEvent("Events End") end

    if AddonProfiler then
        AddonProfiler:MarkEvent("Initialization Complete")
        zo_callLater(function() AddonProfiler:Stop() end, 1000)
    end
end
]]
--
