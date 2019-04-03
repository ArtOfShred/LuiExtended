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

local g_currentDisguise -- Tracks the currently equipped disguise

-- Handles long term Disguise Item Icon (appears when wearing a disguise even if not in a disguised state)
function SCB.DisguiseItem(eventCode, bagId, slotId, isNewItem, itemSoundCategory, inventoryUpdateReason, stackCountChange)

    -- Remove buff first
    LUIE.EffectsList.player1["DisguiseType"] = nil

    -- If slotId isn't the disguise/tabard slot then return
    if slotId ~= 10 or SCB.SV.IgnoreDisguise or SCB.SV.HidePlayerBuffs then
        return
    end

    -- Set current disguise
    g_currentDisguise = GetItemId(0, 10) or 0

    -- If we don't have a disguise equipped, have a Monk's Disguise (already has buff icon) or Guild Tabard then bail out
    if g_currentDisguise == 0 or g_currentDisguise == 79332 or g_currentDisguise == 55262 then
        return
    end

    local name = GetItemName(0, 10)
    local icon = E.DisguiseIcons[g_currentDisguise].icon
    local id = E.DisguiseIcons[g_currentDisguise].id or "Fake"
    LUIE.EffectsList.player1["DisguiseType"] = {
        target="player", type=1,
        id=id, name=name, icon=icon,
        dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
        forced = "long",
        restart=true, iconNum=0
    }

end

-- Handles disguise changes for player/reticleover
function SCB.DisguiseStateChanged ( eventCode, unitTag, disguiseState )

    -- Bail out if we don't have disguise or unitTag buffs enabled
    if unitTag == "player" and ( not SCB.SV.DisguiseStatePlayer or SCB.SV.HidePlayerBuffs) then
        return
    elseif unitTag == "reticleover" and ( not SCB.SV.DisguiseStatePlayer or SCB.SV.HideTargetBuffs) then
        return
    end

    -- Bail out if for some reason we have no value for disguiseState
    if disguiseState == nil then
        return
    end

    -- Get context
    local context = unitTag .. "1"

    -- Remove buff first
    LUIE.EffectsList[context][50602] = nil

    -- Add disguise icon if we are in any state of disguise
    if ( disguiseState == DISGUISE_STATE_DISGUISED or disguiseState == DISGUISE_STATE_DANGER or disguiseState == DISGUISE_STATE_SUSPICIOUS or disguiseState == DISGUISE_STATE_DISCOVERED ) then
        LUIE.EffectsList[context][50602] = {
            target=unitTag, type=1,
            id=50602, name=A.Innate_Disguised, icon="LuiExtended/media/icons/abilities/ability_innate_disguised.dds",
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "short",
            restart=true, iconNum=0
        }
    end

end

-- Handles stealth state changes for player/reticleover
function SCB.StealthStateChanged(eventCode, unitTag, stealthState)

    -- Bail out if we don't have stealth or unitTag buffs enabled
    if unitTag == "player" and ( not SCB.SV.StealthStatePlayer or SCB.SV.HidePlayerBuffs) then
        return
    elseif unitTag == "reticleover" and ( not SCB.SV.StealthStateTarget or SCB.SV.HideTargetBuffs) then
        return
    end

    -- Bail out if for some reason we have no value for stealthState
    if stealthState == nil then
        return
    end

    -- Get context
    local context = unitTag .. "1"

    -- Remove buff first
    LUIE.EffectsList[context][20299] = nil

    -- Add hidden icon if we are hidden
    if ( stealthState == STEALTH_STATE_HIDDEN or stealthState == STEALTH_STATE_HIDDEN_ALMOST_DETECTED) then
        LUIE.EffectsList[context][20299] = {
            target=unitTag, type=1,
            id = 20299, name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_hidden.dds",
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "short",
            restart=true, iconNum=0
        }
    -- Add invisible icon if we are invisible
    elseif ( stealthState == STEALTH_STATE_STEALTH or stealthState == STEALTH_STATE_STEALTH_ALMOST_DETECTED ) then
        LUIE.EffectsList[context][20299] = {
            target=unitTag, type=1,
            id = 20309, name=A.Innate_Hidden, icon="LuiExtended/media/icons/abilities/ability_innate_invisible.dds",
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "short",
            restart=true, iconNum=0
        }
    end

end
