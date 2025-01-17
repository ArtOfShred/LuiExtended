-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- **LuiExtended** namespace
---
--- @class (partial) LuiExtended
--- @field __index LuiExtended
--- @field Combat LUIE.CombatInfo
--- @field SpellCastBuffs LUIE.SpellCastBuffs
--- @field name string The addon name
--- @field log_to_chat boolean Whether to output logs to chat
--- @field logger LibDebugLogger|NOP The logger instance
LUIE = {}
LUIE.__index = LUIE
LUIE.__newindex = NewIndexHandler
-- -----------------------------------------------------------------------------
--- @class (partial) LuiExtended
local LUIE = LUIE
-- -----------------------------------------------------------------------------
LUIE.tag = "LUIE"
LUIE.name = "LuiExtended"
LUIE.version = "6.8.0"
LUIE.author = "ArtOfShred, DakJaniels, psypanda, Saenic & SpellBuilder"
LUIE.website = "https://www.esoui.com/downloads/info818-LuiExtended.html"
LUIE.github = "https://github.com/ArtOfShredLuiExtended"
LUIE.feedback = "https://github.com/ArtOfShredLuiExtended/issues"
LUIE.translation = "https://github.com/ArtOfShred/LuiExtended/tree/translations"
LUIE.donation = "https://paypal.me/dakjaniels"
-- -----------------------------------------------------------------------------
-- Saved variables options
LUIE.SV = ...
LUIE.SVVer = 2
LUIE.SVName = "LUIESV"
-- -----------------------------------------------------------------------------
-- Callbacks
LUIE.callbackObject = ZO_CallbackObject:New()
-- -----------------------------------------------------------------------------
-- Components
LUIE.Components = {}
-- -----------------------------------------------------------------------------
--- @class (partial) Data
LUIE.Data = LuiData.Data
-- -----------------------------------------------------------------------------
-- Default Settings
LUIE.Defaults =
{
    CharacterSpecificSV = false,
    StartupInfo = false,
    HideAlertFrame = false,
    AlertFrameAlignment = 3,
    -- CustomIcons_Enabled = true,
    HideXPBar = false,
    TempAlertHome = false,
    TempAlertCampaign = false,
    TempAlertOutfit = false,
    WelcomeVersion = 0,

    -- Modules
    UnitFrames_Enabled = true,
    InfoPanel_Enabled = true,
    CombatInfo_Enabled = true,
    CombatText_Enabled = true,
    SpellCastBuff_Enable = true,
    ChatAnnouncements_Enable = true,
    SlashCommands_Enable = true,
}
-- -----------------------------------------------------------------------------
LUIE.PlayerNameRaw = GetRawUnitName("player")
-- -----------------------------------------------------------------------------
LUIE.PlayerNameFormatted = zo_strformat("<<C:1>>", GetUnitName("player"))
-- -----------------------------------------------------------------------------
LUIE.PlayerDisplayName = zo_strformat("<<C:1>>", GetUnitDisplayName("player"))
-- -----------------------------------------------------------------------------
LUIE.PlayerFaction = GetUnitAlliance("player")
-- -----------------------------------------------------------------------------

-- DEVS
local DEVS =
{
    ["@ArtOfShred"] =
    {
        enabled = true,
        debug = true,
    },
    ["@ArtOfShredPTS"] =
    {
        enabled = true,
        debug = true,
    },
    ["@ArtOfShredLegacy"] =
    {
        enabled = true,
        debug = true,
    },
    ["@HammerOfGlory"] =
    {
        enabled = true,
        debug = true,
    },
    ["@dack_janiels"] =
    {
        enabled = true,
        debug = true,
    },
}
LUIE.DEVS = DEVS
-- -----------------------------------------------------------------------------
-- Helper function to check if debug is enabled for current user
function LUIE.IsDevDebugEnabled()
    local currentUser = GetDisplayName()
    return DEVS[currentUser] and DEVS[currentUser].enabled and DEVS[currentUser].debug
end
-- -----------------------------------------------------------------------------
-- -----------------------------------------------------------------------------
