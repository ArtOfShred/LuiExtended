--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Performance Enhancement
local SCB           = LUIE.SpellCastBuffs
local CI            = LUIE.CombatInfo
local UI            = LUIE.UI
local E             = LUIE.Effects
local T             = LUIE.Tooltips
local A             = LUIE.GetAbility()
local printToChat   = LUIE.PrintToChat
local strfmt        = string.format
local strformat     = zo_strformat

local eventManager  = EVENT_MANAGER
local sceneManager  = SCENE_MANAGER
local windowManager = WINDOW_MANAGER

local callLater     = zo_callLater
local iconFormat    = zo_iconFormat

local moduleName    = LUIE.name .. "_SpellCastBuffs"

local hidePlayerEffects = { } -- Table of Effects to hide on Player - generated on load or updated from Menu
local hideTargetEffects = { } -- Table of Effects to hide on Target - generated on load or updated from Menu

local windowTitles = {
    playerb             = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERBUFFS),
    playerd             = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERDEBUFFS),
    player1             = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERBUFFS),
    player2             = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERDEBUFFS),
    player_long         = GetString(SI_LUIE_SCB_WINDOWTITLE_PLAYERLONGTERMEFFECTS),
    targetb             = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETBUFFS),
    targetd             = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETDEBUFFS),
    target1             = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETBUFFS),
    target2             = GetString(SI_LUIE_SCB_WINDOWTITLE_TARGETDEBUFFS),
    prominentbuffs      = GetString(SI_LUIE_SCB_WINDOWTITLE_PROMINENTBUFFS),
    prominentdebuffs    = GetString(SI_LUIE_SCB_WINDOWTITLE_PROMINENTDEBUFFS),
}

-- TODO -- TODO -- TODO -- Duplicated in SCB base right now
local g_currentDuelTarget            = nil -- Saved Duel Target for generating Battle Spirit icon when enabled

-- EVENT_DUEL_STARTED handler for creating Battle Spirit Icon on Target
function SCB.DuelStart()
    local duelState, characterName = GetDuelInfo()
    if duelState == 3 and not SCB.SV.IgnoreBattleSpiritTarget then
        g_currentDuelTarget = strformat(SI_UNIT_NAME, characterName)
        SCB.ReloadEffects("reticleover")
    end
end

-- EVENT_DUEL_FINISHED handler for removing Battle Spirit Icon on Target
function SCB.DuelEnd()
    g_currentDuelTarget = nil
    SCB.ReloadEffects("reticleover")
end
