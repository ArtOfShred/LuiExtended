--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- SpellCastBuffs namespace
LUIE.SpellCastBuffs = {}

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

SCB.Enabled = false
SCB.D = {
    IconSize                         = 40,
    LabelPosition                    = 0,
    BuffFontFace                     = "Fontin Regular",
    BuffFontStyle                    = "outline",
    BuffFontSize                     = 16,
    BuffShowLabel                    = true,
    Alignment                        = "Centered",
    AlignmentLongVert                = "Top",
    AlignmentLongHorz                = "Centered",
    SortDirection                    = "Left to Right",
    GlowIcons                        = false,
    RemainingText                    = true,
    RemainingTextColoured            = false,
    RemainingTextMillis              = true,
    RemainingCooldown                = true,
    FadeOutIcons                     = false,
    lockPositionToUnitFrames         = true,
    LongTermEffects_Player           = true,
    LongTermEffects_Target           = true,
    IgnoreMundusPlayer               = false,
    IgnoreMundusTarget               = false,
    IgnoreVampPlayer                 = false,
    IgnoreVampTarget                 = false,
    IgnoreLycanPlayer                = false,
    IgnoreLycanTarget                = false,
    IgnoreDiseasePlayer              = false,
    IgnoreDiseaseTarget              = false,
    IgnoreBitePlayer                 = false,
    IgnoreBiteTarget                 = false,
    IgnoreCyrodiilPlayer             = false,
    IgnoreCyrodiilTarget             = false,
    IgnoreBattleSpiritPlayer         = false,
    IgnoreBattleSpiritTarget         = false,
    IgnoreEsoPlusPlayer              = true,
    IgnoreEsoPlusTarget              = true,
    IgnoreSoulSummonsPlayer          = false,
    IgnoreSoulSummonsTarget          = false,
    IgnoreSetICDPlayer               = false,
    IgnoreSetICDTarget               = false,
    IgnoreFoodPlayer                 = false,
    IgnoreFoodTarget                 = false,
    IgnoreExperiencePlayer           = false,
    IgnoreExperienceTarget           = false,
    IgnoreDisguise                   = false,
    IgnoreCostume                    = true,
    IgnoreHat                        = true,
    IgnoreSkin                       = true,
    IgnorePolymorph                  = true,
    IgnoreAssistant                  = true,
    IgnorePet                        = true,
    IgnoreMount                      = false,
    MountGenericIcon                 = false,
    LongTermEffectsSeparate          = true,
    LongTermEffectsReverse           = true,
    LongTermEffectsSeparateAlignment = 2,
    ShowBlockPlayer                  = true,
    ShowBlockTarget                  = true,
    StealthStatePlayer               = true,
    StealthStateTarget               = true,
    DisguiseStatePlayer              = true,
    DisguiseStateTarget              = true,
    ShowSprint                       = true,
    ShowGallop                       = true,
    ShowResurrectionImmunity         = true,
    ShowRecall                       = true,
    ShowWerewolf                     = true,
    HidePlayerBuffs                  = false,
    HidePlayerDebuffs                = false,
    HideTargetBuffs                  = false,
    HideTargetDebuffs                = false,
    HideGroundEffects                = false,
    ExtraBuffs                       = true,
    ExtraConsolidate                 = false,
    ExtraExpanded                    = false,
    ShowDebugCombat                  = false,
    ShowDebugEffect                  = false,
    ShowDebugFilter                  = false,
    ShowDebugAbilityId               = false,
    HideReduce                       = true,
    GroundDamageAura                 = true,
    ProminentLabel                   = true,
    ProminentLabelFontFace           = "Univers 67",
    ProminentLabelFontStyle          = "outline",
    ProminentLabelFontSize           = 16,
    ProminentProgress                = true,
    ProminentProgressTexture         = "Plain",
    ProminentProgressBuffC1          = { 0, 1, 0 },
    ProminentProgressBuffC2          = { 0, .4, 0 },
    ProminentProgressDebuffC1        = { 1, 0, 0 },
    ProminentProgressDebuffC2        = { .4, 0, 0 },
    ProminentBuffAlignment           = "Bottom",
    ProminentDebuffAlignment         = "Bottom",
    ProminentBuffReverseSort         = false,
    ProminentDebuffReverseSort       = false,
    ProminentBuffLabelDirection      = "Left",
    ProminentDebuffLabelDirection    = "Right",
    PromBuffTable                    = {},
    PromDebuffTable                  = {},
    BlacklistTable                   = {},
}
SCB.SV = nil

LUIE.EffectsList                     = { player1 = {}, player2 = {}, reticleover1 = {}, reticleover2 = {}, ground = {}, saved = {}, promb_ground = {}, promb_target = {}, promb_player = {}, promd_ground = {}, promd_target = {}, promd_player = {} } -- Saved Effects

local uiTlw                          = {} -- GUI
local containerRouting               = {} -- Routing for Auras
local g_playerActive                 = false -- Player Active State
local g_playerDead                   = false -- Player Dead State
local g_playerResurrectStage         = nil -- Player resurrection sequence state
local g_buffsFont                    -- Buff font
local g_prominentFont                -- Prominent buffs label font
local g_padding                      = 0 -- Padding between icons
local g_horizAlign                   = CENTER -- Alignment for standard buff containers
local g_longHorizAlign               = CENTER -- Alignment for Long Term Buffs (Horizontal)
local g_longVertAlign                = MIDDLE -- Alignment for Long Term Buffs (Vertical)
local g_prominentVertBuffAlign       = BOTTOM -- Alignment for Prominent Buffs
local g_prominentVertDebuffAlign     = BOTTOM -- Alignment for Prominent Debuffs
local g_horizSortInvert              = false -- Invert sort order on buff container
local g_protectAbilityRemoval        = {} -- AbilityId's set to a timestamp here to prevent removal of ground effects when refreshing ground auras from causing the aura to fade.
local g_grimFocusCount               = 0 -- Tracker for Grim Focus Stacks
local g_ignoreAbilityId              = {} -- Ignored abilityId's on EVENT_COMBAT_EVENT, some events fire twice and we need to ignore every other one.

-- Quadratic easing out - decelerating to zero velocity (For buff fade)
local function EaseOutQuad(t, b, c, d)
    t = t / d
    return -c * t*(t-2) + b
end

-- Initialization
function SCB.Initialize( enabled )
    -- Load settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        SCB.SV = ZO_SavedVars:New( LUIE.SVName, LUIE.SVVer, "SpellCastBuffs", SCB.D )
    else
        SCB.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "SpellCastBuffs", SCB.D )
    end

    -- Correct read values
    if SCB.SV.IconSize < 30 or SCB.SV.IconSize > 60 then
        SCB.SV.IconSize = SCB.D.IconSize
    end

    -- If User does not want the Buffs tracking then exit right here
    if not enabled then
        return
    end
    SCB.Enabled = true

    -- Before we start creating controls, update icons font
    SCB.ApplyFont()

    -- Create controls
    -- Create temporary table to store references to scenes locally
    local fragments = { }

    -- We will not create TopLevelWindows when buff frames are locked to Custom Unit Frames
    if SCB.SV.lockPositionToUnitFrames and LUIE.UnitFrames.CustomFrames.player and LUIE.UnitFrames.CustomFrames.player.buffs and LUIE.UnitFrames.CustomFrames.player.debuffs then
        uiTlw.player1 = LUIE.UnitFrames.CustomFrames.player.buffs
        uiTlw.player2 = LUIE.UnitFrames.CustomFrames.player.debuffs
        containerRouting.player1 = "player1"
        containerRouting.player2 = "player2"
    else
        uiTlw.playerb = UI.TopLevel( nil, nil )
        uiTlw.playerb:SetHandler( "OnMoveStop", function(self)
                SCB.SV.playerbOffsetX = self:GetLeft()
                SCB.SV.playerbOffsetY = self:GetTop()
            end )
        uiTlw.playerd = UI.TopLevel( nil, nil )
        uiTlw.playerd:SetHandler( "OnMoveStop", function(self)
                SCB.SV.playerdOffsetX = self:GetLeft()
                SCB.SV.playerdOffsetY = self:GetTop()
            end )
        containerRouting.player1 = "playerb"
        containerRouting.player2 = "playerd"

        local fragment1 = ZO_HUDFadeSceneFragment:New(uiTlw.playerb, 0, 0)
        local fragment2 = ZO_HUDFadeSceneFragment:New(uiTlw.playerd, 0, 0)
        table.insert(fragments, fragment1)
        table.insert(fragments, fragment2)

    end

    -- Create TopLevelWindows for buff frames when NOT locked to Custom Unit Frames
    if SCB.SV.lockPositionToUnitFrames and LUIE.UnitFrames.CustomFrames.reticleover and LUIE.UnitFrames.CustomFrames.reticleover.buffs and LUIE.UnitFrames.CustomFrames.reticleover.debuffs then
        uiTlw.target1 = LUIE.UnitFrames.CustomFrames.reticleover.buffs
        uiTlw.target2 = LUIE.UnitFrames.CustomFrames.reticleover.debuffs
        containerRouting.reticleover1 = "target1"
        containerRouting.reticleover2 = "target2"
        containerRouting.ground = "target2"
    else
        uiTlw.targetb = UI.TopLevel( nil, nil )
        uiTlw.targetb:SetHandler( "OnMoveStop", function(self)
                SCB.SV.targetbOffsetX = self:GetLeft()
                SCB.SV.targetbOffsetY = self:GetTop()
            end )
        uiTlw.targetd = UI.TopLevel( nil, nil )
        uiTlw.targetd:SetHandler( "OnMoveStop", function(self)
                SCB.SV.targetdOffsetX = self:GetLeft()
                SCB.SV.targetdOffsetY = self:GetTop()
            end )
        containerRouting.reticleover1 = "targetb"
        containerRouting.reticleover2 = "targetd"
        containerRouting.ground = "targetd"

        local fragment1 = ZO_HUDFadeSceneFragment:New(uiTlw.targetb, 0, 0)
        local fragment2 = ZO_HUDFadeSceneFragment:New(uiTlw.targetd, 0, 0)
        table.insert(fragments, fragment1)
        table.insert(fragments, fragment2)

    end

    -- Create TopLevelWindows for Prominent Buffs
    uiTlw.prominentbuffs = UI.TopLevel( nil, nil )
    uiTlw.prominentbuffs:SetHandler( "OnMoveStop", function(self)
            SCB.SV.prominentbOffsetX = self:GetLeft()
            SCB.SV.prominentbOffsetY = self:GetTop()
        end )
    uiTlw.prominentdebuffs = UI.TopLevel( nil, nil )
    uiTlw.prominentdebuffs:SetHandler( "OnMoveStop", function(self)
            SCB.SV.prominentdOffsetX = self:GetLeft()
            SCB.SV.prominentdOffsetY = self:GetTop()
        end )

    uiTlw.prominentbuffs.alignVertical = true
    uiTlw.prominentdebuffs.alignVertical = true

    containerRouting.promb_ground = "prominentbuffs"
    containerRouting.promb_target = "prominentbuffs"
    containerRouting.promb_player = "prominentbuffs"
    containerRouting.promd_ground = "prominentdebuffs"
    containerRouting.promd_target = "prominentdebuffs"
    containerRouting.promd_player = "prominentdebuffs"

    local fragmentP1 = ZO_HUDFadeSceneFragment:New(uiTlw.prominentbuffs, 0, 0)
    local fragmentP2 = ZO_HUDFadeSceneFragment:New(uiTlw.prominentdebuffs, 0, 0)
    table.insert(fragments, fragmentP1)
    table.insert(fragments, fragmentP2)

    -- Separate container for players long term buffs
    if true then
        uiTlw.player_long = UI.TopLevel( nil, nil )
        uiTlw.player_long:SetHandler( "OnMoveStop", function(self)
                if self.alignVertical then
                    SCB.SV.playerVOffsetX = self:GetLeft()
                    SCB.SV.playerVOffsetY = self:GetTop()
                else
                    SCB.SV.playerHOffsetX = self:GetLeft()
                    SCB.SV.playerHOffsetY = self:GetTop()
                end
            end )

        if SCB.SV.LongTermEffectsSeparateAlignment == 1 then
            uiTlw.player_long.alignVertical = false
        elseif SCB.SV.LongTermEffectsSeparateAlignment == 2 then
            uiTlw.player_long.alignVertical = true
        end
        uiTlw.player_long.skipUpdate = 0
        containerRouting.player_long = "player_long"

        local fragment = ZO_HUDFadeSceneFragment:New(uiTlw.player_long, 0, 0)
        table.insert(fragments, fragment)
    else
        containerRouting.player_long = containerRouting.player1
    end

    -- Loop over table of fragments to add them to relevant UI Scenes
    for _,v in pairs(fragments) do
        sceneManager:GetScene("hud"):AddFragment( v )
        sceneManager:GetScene("hudui"):AddFragment( v )
        sceneManager:GetScene("siegeBar"):AddFragment( v )
        sceneManager:GetScene("siegeBarUI"):AddFragment( v )
    end

    -- Set Buff Container Positions
    SCB.SetTlwPosition()

    -- Loop over created controls to...
    for _, v in pairs(containerRouting) do
        -- Set Draw Priority
        uiTlw[v]:SetDrawLayer(DL_BACKDROP)
        uiTlw[v]:SetDrawTier(DT_LOW)
        uiTlw[v]:SetDrawLevel(1)
        if uiTlw[v].preview == nil then
            -- Create background areas for preview position purposes
            --uiTlw[v].preview = UI.Backdrop( uiTlw[v], "fill", nil, nil, nil, true )
            uiTlw[v].preview = UI.Texture( uiTlw[v], "fill", nil, "/esoui/art/miscellaneous/inset_bg.dds", DL_BACKGROUND, true )
            uiTlw[v].previewLabel = UI.Label( uiTlw[v].preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", windowTitles[v] .. (SCB.SV.lockPositionToUnitFrames and (v ~= "player_long" and v ~= "prominentbuffs" and v ~= "prominentdebuffs") and " (locked)" or ""), false )

            -- Create control that will hold the icons
            uiTlw[v].prevIconsCount = 0
            -- We need this container only for icons that are aligned in one row/column automatically.
            -- Thus we do not create containers for player and target buffs/debuffs on custom frames
            if v ~= "player1" and v ~= "player2" and v ~= "target1" and v ~= "target2" then
                uiTlw[v].iconHolder = UI.Control( uiTlw[v], nil, nil, false )
            end
            -- Create table to store created contols for icons
            uiTlw[v].icons = {}
        end
    end

    SCB.Reset()
    SCB.UpdateContextHideList()

    -- Register events
    eventManager:RegisterForUpdate(moduleName, 100, SCB.OnUpdate )

    -- Target Events
    eventManager:RegisterForEvent(moduleName, EVENT_TARGET_CHANGE,             SCB.OnTargetChange )
    eventManager:RegisterForEvent(moduleName, EVENT_RETICLE_TARGET_CHANGED,    SCB.OnReticleTargetChanged )

    -- Buff Events
    eventManager:RegisterForEvent(moduleName, EVENT_EFFECT_CHANGED, SCB.OnEffectChanged )

    -- Combat Events
    eventManager:RegisterForEvent("LUIE_Event1", EVENT_COMBAT_EVENT, SCB.OnCombatEventIn )
    eventManager:RegisterForEvent("LUIE_Event2", EVENT_COMBAT_EVENT, SCB.OnCombatEventOut )
    eventManager:RegisterForEvent("LUIE_Event3", EVENT_COMBAT_EVENT, SCB.OnCombatEventOut )
    eventManager:AddFilterForEvent("LUIE_Event1", EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false) -- Target -> Player
    eventManager:AddFilterForEvent("LUIE_Event2", EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false) -- Player -> Target
    eventManager:AddFilterForEvent("LUIE_Event3", EVENT_COMBAT_EVENT, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER_PET, REGISTER_FILTER_IS_ERROR, false) -- Player Pet -> Target

    -- Stealth Events
    eventManager:RegisterForEvent(moduleName .. "player",          EVENT_STEALTH_STATE_CHANGED, SCB.StealthStateChanged )
    eventManager:RegisterForEvent(moduleName .. "reticleover",     EVENT_STEALTH_STATE_CHANGED, SCB.StealthStateChanged )
    eventManager:AddFilterForEvent(moduleName .. "player",         EVENT_STEALTH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
    eventManager:AddFilterForEvent(moduleName .. "reticleover",    EVENT_STEALTH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "reticleover" )

    -- Disguise Events
    eventManager:RegisterForEvent(moduleName .. "player",          EVENT_DISGUISE_STATE_CHANGED, SCB.DisguiseStateChanged )
    eventManager:RegisterForEvent(moduleName .. "reticleover",     EVENT_DISGUISE_STATE_CHANGED, SCB.DisguiseStateChanged )
    eventManager:AddFilterForEvent(moduleName .. "player",         EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
    eventManager:AddFilterForEvent(moduleName .. "reticleover",    EVENT_DISGUISE_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "reticleover" )

    -- Artificial Effects Handling
    eventManager:RegisterForEvent(moduleName, EVENT_ARTIFICIAL_EFFECT_ADDED, SCB.ArtificialEffectUpdate)
    eventManager:RegisterForEvent(moduleName, EVENT_ARTIFICIAL_EFFECT_REMOVED, SCB.ArtificialEffectUpdate)

    -- Activate/Deactivate Player, Player Dead/Alive, Vibration, and Unit Death
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED,   SCB.OnPlayerActivated )
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_DEACTIVATED, SCB.OnPlayerDeactivated )
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_ALIVE, SCB.OnPlayerAlive )
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_DEAD,  SCB.OnPlayerDead )
    eventManager:RegisterForEvent(moduleName, EVENT_VIBRATION,    SCB.OnVibration )
    eventManager:RegisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED,  SCB.OnDeath )

    -- Mount Events
    eventManager:RegisterForEvent(moduleName, EVENT_MOUNTED_STATE_CHANGED, SCB.MountStatus)
    eventManager:RegisterForEvent(moduleName, EVENT_COLLECTIBLE_USE_RESULT, SCB.CollectibleUsed)

    -- Inventory Events
    eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, SCB.DisguiseItem)
    eventManager:AddFilterForEvent(moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, REGISTER_FILTER_BAG_ID, BAG_WORN )

    -- Duel (For resolving Target Battle Spirit Status)
    eventManager:RegisterForEvent(moduleName, EVENT_DUEL_STARTED, SCB.DuelStart)
    eventManager:RegisterForEvent(moduleName, EVENT_DUEL_FINISHED, SCB.DuelEnd)

    -- Werewolf
    SCB.RegisterWerewolfEvents()

    -- Debug
    SCB.RegisterDebugEvents()

    -- Enable Bar function for Bound Armor if the player is a Sorcerer
    if GetUnitClassId('player') == 2 then
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED, SCB.DrawBoundAegisBuffs)
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_ALL_HOTBARS_UPDATED, SCB.DrawBoundAegisBuffs)
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED, SCB.DrawBoundAegisBuffs)
    end
end

function SCB.RegisterWerewolfEvents()
    eventManager:UnregisterForUpdate(moduleName .. "WerewolfTicker")
    eventManager:UnregisterForEvent(moduleName, EVENT_WEREWOLF_STATE_CHANGED)
    eventManager:UnregisterForEvent(moduleName, EVENT_POWER_UPDATE)
    eventManager:UnregisterForEvent(moduleName .. "Werewolf1", EVENT_EFFECT_CHANGED)
    eventManager:UnregisterForEvent(moduleName .. "Werewolf2", EVENT_EFFECT_CHANGED)
    if SCB.SV.ShowWerewolf then
        eventManager:RegisterForEvent(moduleName, EVENT_WEREWOLF_STATE_CHANGED, SCB.WerewolfState)
        eventManager:RegisterForEvent(moduleName .. "Werewolf1", EVENT_EFFECT_CHANGED, SCB.DevourEffectListener )
        eventManager:RegisterForEvent(moduleName .. "Werewolf2", EVENT_EFFECT_CHANGED, SCB.DevourEffectListener )
        eventManager:AddFilterForEvent(moduleName .. "Werewolf1", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID , 33208, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER ) -- Target -> Player
        eventManager:AddFilterForEvent(moduleName .. "Werewolf2", EVENT_EFFECT_CHANGED, REGISTER_FILTER_ABILITY_ID , 39477, REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_UNIT_TAG, 'player' ) -- Target -> Player
        if IsWerewolf() then
            SCB.WerewolfState(nil, true, true)
        end
    end
end

function SCB.RegisterDebugEvents()
    eventManager:UnregisterForEvent(moduleName .. "LUIE_DEBUG_COMBAT", EVENT_COMBAT_EVENT)
    eventManager:UnregisterForEvent(moduleName .. "LUIE_DEBUG_EFFECT", EVENT_EFFECT_CHANGED)
    if SCB.SV.ShowDebugCombat then
        eventManager:RegisterForEvent(moduleName .. "LUIE_DEBUG_COMBAT", EVENT_COMBAT_EVENT, SCB.EventCombatDebug)
    end
    if SCB.SV.ShowDebugEffect then
        eventManager:RegisterForEvent(moduleName .. "LUIE_DEBUG_EFFECT", EVENT_EFFECT_CHANGED, SCB.EventEffectDebug)
    end
end

-- List Handling (Add) for Prominent Auras & Blacklist
function SCB.AddToCustomList(list, input)
    local id = tonumber(input)
    local listRef = list == SCB.SV.PromBuffTable and "Prominent Buffs." or list == SCB.SV.PromDebuffTable and "Prominent Debuffs." or list == SCB.SV.BlacklistTable and "Aura Blacklist." or ""
    if id and id > 0 then
        local name = strformat("<<C:1>>", GetAbilityName(id))
        if name ~= nil then
            local icon = iconFormat(GetAbilityIcon(id), 16, 16)
            list[id] = true
            CHAT_SYSTEM:Maximize() CHAT_SYSTEM.primaryContainer:FadeIn()
            printToChat(strformat("<<1>> [<<2>>] <<3>> added to <<4>>", icon, id, name, listRef), true) -- TODO: localization
        else
            CHAT_SYSTEM:Maximize() CHAT_SYSTEM.primaryContainer:FadeIn()
            printToChat(strformat("Could not add [<<1>>] to <<2>>. That abiilityId does not exist.", input, listRef), true) -- TODO: localization
        end
    else
        if input ~= "" then
            list[input] = true
            CHAT_SYSTEM:Maximize() CHAT_SYSTEM.primaryContainer:FadeIn()
            printToChat(strformat("<<1>> added to <<2>>", input, listRef), true) -- TODO: localization
        end
    end
    SCB.Reset()
end

-- List Handling (Remove) for Prominent Auras & Blacklist
function SCB.RemoveFromCustomList(list, input)
    local id = tonumber(input)
    local listRef = list == SCB.SV.PromBuffTable and "Prominent Buffs." or list == SCB.SV.PromDebuffTable and "Prominent Debuffs." or list == SCB.SV.BlacklistTable and "Aura Blacklist." or ""
    if id and id > 0 then
        local name = strformat("<<C:1>>", GetAbilityName(id))
        if name ~= nil then
            local icon = iconFormat(GetAbilityIcon(id), 16, 16)
            list[id] = nil
            CHAT_SYSTEM:Maximize() CHAT_SYSTEM.primaryContainer:FadeIn()
            printToChat(strformat("<<1>> [<<2>>] <<3>> removed from <<4>>", icon, id, name, listRef), true) -- TODO: localization
        else
            CHAT_SYSTEM:Maximize() CHAT_SYSTEM.primaryContainer:FadeIn()
            printToChat(strformat("Could not remove [<<1>>] to <<2>>. That abilityId does not exist.", input, listRef), true) -- TODO: localization
        end
    else
        if input ~= "" then
            list[input] = nil
            CHAT_SYSTEM:Maximize() CHAT_SYSTEM.primaryContainer:FadeIn()
            printToChat(strformat("<<1>> removed from <<2>>", input, listRef), true) -- TODO: localization
        end
    end
    SCB.Reset()
end

-- Sets horizontal alignment of icon. Called from Settings Menu.
-- This is done simply by setting of iconHolder anchor.
function SCB.SetIconsAlignment( value )
    -- Check correctness of argument value
    if value ~= "Left" and value ~= "Centered" and value ~= "Right" then
        value = SCB.D.Alignment
    end
    SCB.SV.Alignment = value

    if not SCB.Enabled then
        return
    end

    g_horizAlign = ( value == "Left" ) and LEFT or ( value == "Right" ) and RIGHT or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( g_longVertAlign )
            else
                if v == "player_long" then
                    uiTlw[v].iconHolder:SetAnchor( g_longHorizAlign )
                else
                    uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
                end
            end
        end
    end
end

-- Sets vertical alignment of Prominent Buff icons
function SCB.SetIconsAlignmentProminentBuff( value )
    if value ~= "Top" and value ~= "Middle" and value ~= "Bottom" then
        value = SCB.D.ProminentBuffAlignment
    end
    SCB.SV.ProminentBuffAlignment = value

    if not SCB.Enabled then
        return
    end

    g_prominentVertBuffAlign = ( value == "Top" ) and TOP or ( value == "Bottom" ) and BOTTOM or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            if v == "prominentbuffs" then
                uiTlw[v].iconHolder:ClearAnchors()
                uiTlw[v].iconHolder:SetAnchor ( g_prominentVertBuffAlign )
            end
        end
    end
end

-- Sets vertical alignment of Prominent Debuff icons
function SCB.SetIconsAlignmentProminentDebuff( value )
    if value ~= "Top" and value ~= "Middle" and value ~= "Bottom" then
        value = SCB.D.ProminentDebuffAlignment
    end
    SCB.SV.ProminentDebuffAlignment = value

    if not SCB.Enabled then
        return
    end

    g_prominentVertDebuffAlign = ( value == "Top" ) and TOP or ( value == "Bottom" ) and BOTTOM or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            if v == "prominentdebuffs" then
                uiTlw[v].iconHolder:ClearAnchors()
                uiTlw[v].iconHolder:SetAnchor ( g_prominentVertDebuffAlign )
            end
        end
    end
end

-- Set PLAYER LONG Container Vertical Alignment
function SCB.SetIconsAlignmentLongVert( value )
    -- Check correctness of argument value
    if value ~= "Top" and value ~= "Middle" and value ~= "Bottom" then
        value = SCB.D.AlignmentLongVert
    end
    SCB.SV.AlignmentLongVert = value

    if not SCB.Enabled then
        return
    end

    g_longVertAlign = ( value == "Top" ) and TOP or ( value == "Bottom" ) and BOTTOM or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( g_longVertAlign )
            else
                if v == "player_long" then
                    uiTlw[v].iconHolder:SetAnchor( g_longHorizAlign )
                else
                    uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
                end
            end
        end
    end
end

-- Set PLAYER LONG Container Horizontal Alignment
function SCB.SetIconsAlignmentLongHorz( value )
    -- Check correctness of argument value
    if value ~= "Left" and value ~= "Centered" and value ~= "Right" then
        value = SCB.D.AlignmentLongHorz
    end
    SCB.SV.AlignmentLongHorz = value

    if not SCB.Enabled then
        return
    end

    g_longHorizAlign = ( value == "Left" ) and LEFT or ( value == "Right" ) and RIGHT or CENTER

    for _, v in pairs(containerRouting) do
        if uiTlw[v].iconHolder then
            uiTlw[v].iconHolder:ClearAnchors()
            if uiTlw[v].alignVertical then
                -- Might need to consolidate these two functions somehow, possibly consolidate all options so that Left = Top, Middle = Center, Right = Bottom
                uiTlw[v].iconHolder:SetAnchor( g_longVertAlign )
            else
                if v == "player_long" then
                    uiTlw[v].iconHolder:SetAnchor( g_longHorizAlign )
                else
                    uiTlw[v].iconHolder:SetAnchor( g_horizAlign )
                end
            end
        end
    end
end

-- Sets horizontal sort direction. Called from Settings Menu.
function SCB.SetSortDirection( value )
    -- Check correctness of argument value
    if value ~= "Left to Right" and value ~= "Right to Left" then
        value = SCB.D.SortDirection
    end
    SCB.SV.SortDirection = value

    g_horizSortInvert = (value == "Right to Left")
end

-- Reset position of windows. Called from Settings Menu.
function SCB.ResetTlwPosition()
    if not SCB.Enabled then
        return
    end
    SCB.SV.playerbOffsetX = nil
    SCB.SV.playerbOffsetY = nil
    SCB.SV.playerdOffsetX = nil
    SCB.SV.playerdOffsetY = nil
    SCB.SV.targetbOffsetX = nil
    SCB.SV.targetbOffsetY = nil
    SCB.SV.targetdOffsetX = nil
    SCB.SV.targetdOffsetY = nil
    SCB.SV.playerVOffsetX = nil
    SCB.SV.playerVOffsetY = nil
    SCB.SV.playerHOffsetX = nil
    SCB.SV.playerHOffsetY = nil
    SCB.SV.prominentbOffsetX = nil
    SCB.SV.prominentbOffsetY = nil
    SCB.SV.prominentdOffsetX = nil
    SCB.SV.prominentdOffsetY = nil
    SCB.SetTlwPosition()
end

-- Set position of windows. Called from .Initialize() and .ResetTlwPosition()
function SCB.SetTlwPosition()
    -- If icons are locked to custom frames, i.e. uiTlw[] is a CT_CONTROL of LUIE.UnitFrames.CustomFrames.player
    -- We do not have to do anything here. so just bail out

    -- Otherwise set position of uiTlw[] which are CT_TOPLEVELCONTROLs to saved or default positions
    if uiTlw.playerb and uiTlw.playerb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.playerb:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.playerbOffsetX ~= nil and SCB.SV.playerbOffsetY ~= nil then
            uiTlw.playerb:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerbOffsetX, SCB.SV.playerbOffsetY )
        else
            uiTlw.playerb:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 0, -10 )
        end
    end

    if uiTlw.playerd and uiTlw.playerd:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.playerd:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.playerdOffsetX ~= nil and SCB.SV.playerdOffsetY ~= nil then
            uiTlw.playerd:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerdOffsetX, SCB.SV.playerdOffsetY )
        else
            uiTlw.playerd:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 0, -60 )
        end
    end

    if uiTlw.targetb and uiTlw.targetb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.targetb:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.targetbOffsetX ~= nil and SCB.SV.targetbOffsetY ~= nil then
            uiTlw.targetb:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.targetbOffsetX, SCB.SV.targetbOffsetY )
        else
            uiTlw.targetb:SetAnchor( TOP, ZO_TargetUnitFramereticleover, BOTTOM, 0, 60 )
        end
    end

    if uiTlw.targetd and uiTlw.targetd:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.targetd:ClearAnchors()
        if not SCB.SV.lockPositionToUnitFrames and SCB.SV.targetdOffsetX ~= nil and SCB.SV.targetdOffsetY ~= nil then
            uiTlw.targetd:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.targetdOffsetX, SCB.SV.targetdOffsetY )
        else
            uiTlw.targetd:SetAnchor( TOP, ZO_TargetUnitFramereticleover, BOTTOM, 0, 110 )
        end
    end

    if uiTlw.player_long then
        uiTlw.player_long:ClearAnchors()
        if uiTlw.player_long.alignVertical then
            if SCB.SV.playerVOffsetX ~= nil and SCB.SV.playerVOffsetY ~= nil then
                uiTlw.player_long:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerVOffsetX, SCB.SV.playerVOffsetY )
            else
                uiTlw.player_long:SetAnchor( BOTTOMRIGHT, GuiRoot, BOTTOMRIGHT, -3, -75 )
            end
        else
            if SCB.SV.playerHOffsetX ~= nil and SCB.SV.playerHOffsetY ~= nil then
                uiTlw.player_long:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.playerHOffsetX, SCB.SV.playerHOffsetY )
            else
                uiTlw.player_long:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 0, -70 )
            end
        end
    end

    -- Setup Prominent Buffs Position
    if uiTlw.prominentbuffs then
        uiTlw.prominentbuffs:ClearAnchors()
        if SCB.SV.prominentbOffsetX ~= nil and SCB.SV.prominentbOffsetY ~= nil then
            uiTlw.prominentbuffs:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.prominentbOffsetX, SCB.SV.prominentbOffsetY )
        else
            uiTlw.prominentbuffs:SetAnchor( CENTER, GuiRoot, CENTER, -340, -100 )
        end
    end

    if uiTlw.prominentdebuffs then
        uiTlw.prominentdebuffs:ClearAnchors()
        if SCB.SV.prominentdOffsetX ~= nil and SCB.SV.prominentdOffsetY ~= nil then
            uiTlw.prominentdebuffs:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, SCB.SV.prominentdOffsetX, SCB.SV.prominentdOffsetY )
        else
            uiTlw.prominentdebuffs:SetAnchor( CENTER, GuiRoot, CENTER, 340, -100 )
        end
    end
end

-- Unlock windows for moving. Called from Settings Menu.
function SCB.SetMovingState(state)
    if not SCB.Enabled then
        return
    end

    -- Set moving state
    if uiTlw.playerb and uiTlw.playerb:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.playerb:SetMouseEnabled( state )
        uiTlw.playerb:SetMovable( state )
    end
    if uiTlw.playerd and uiTlw.playerd:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.playerd:SetMouseEnabled( state )
        uiTlw.playerd:SetMovable( state )
    end
    if uiTlw.targetb and uiTlw.targetb:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.targetb:SetMouseEnabled( state )
        uiTlw.targetb:SetMovable( state )
    end
    if uiTlw.targetd and uiTlw.targetd:GetType() == CT_TOPLEVELCONTROL and not SCB.SV.lockPositionToUnitFrames then
        uiTlw.targetd:SetMouseEnabled( state )
        uiTlw.targetd:SetMovable( state )
    end
    if uiTlw.player_long then
        uiTlw.player_long:SetMouseEnabled( state )
        uiTlw.player_long:SetMovable( state )
    end
    if uiTlw.prominentbuffs then
        uiTlw.prominentbuffs:SetMouseEnabled( state )
        uiTlw.prominentbuffs:SetMovable( state )
    end
    if uiTlw.prominentdebuffs then
        uiTlw.prominentdebuffs:SetMouseEnabled( state )
        uiTlw.prominentdebuffs:SetMovable( state )
    end

    -- Show/hide preview
    for _, v in pairs(containerRouting) do
        uiTlw[v].preview:SetHidden( not state )
    end

    -- Now create or remove test-effects icons
    if state then
        SCB.MenuPreview()
    else
        SCB.Reset()
    end
end

-- Reset all buff containers
function SCB.Reset()
    if not SCB.Enabled then
        return
    end

    -- Update padding between icons
    g_padding = math.floor(0.5 + SCB.SV.IconSize / 13)

    -- Set size of top level window
    -- Player
    if uiTlw.playerb and uiTlw.playerb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.playerb:SetDimensions( 500, SCB.SV.IconSize + 6 )
        uiTlw.playerd:SetDimensions( 500, SCB.SV.IconSize + 6 )
    else
        uiTlw.player2:SetHeight( SCB.SV.IconSize )
        uiTlw.player2.firstAnchor = { TOPLEFT, TOP }
        uiTlw.player2.maxIcons = math.floor(  (uiTlw.player2:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )

        uiTlw.player1:SetHeight( SCB.SV.IconSize)
        uiTlw.player1.firstAnchor = { TOPLEFT, TOP }
        uiTlw.player1.maxIcons = math.floor(  (uiTlw.player1:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )
    end

    -- Target
    if uiTlw.targetb and uiTlw.targetb:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.targetb:SetDimensions( 500, SCB.SV.IconSize + 6 )
        uiTlw.targetd:SetDimensions( 500, SCB.SV.IconSize + 6 )
    else
        uiTlw.target2:SetHeight( SCB.SV.IconSize )
        uiTlw.target2.firstAnchor = { TOPLEFT, TOP }
        uiTlw.target2.maxIcons = math.floor(  (uiTlw.target2:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )

        uiTlw.target1:SetHeight( SCB.SV.IconSize)
        uiTlw.target1.firstAnchor = { TOPLEFT, TOP }
        uiTlw.target1.maxIcons = math.floor(  (uiTlw.target1:GetWidth()-4*g_padding) / (SCB.SV.IconSize+g_padding) )
    end

    -- Player long buffs
    if uiTlw.player_long then
        if uiTlw.player_long.alignVertical then
            uiTlw.player_long:SetDimensions( SCB.SV.IconSize + 6, 400 )
        else
            uiTlw.player_long:SetDimensions( 500, SCB.SV.IconSize + 6 )
        end
    end

    -- Prominent buffs & debuffs
    if uiTlw.prominentbuffs then
        uiTlw.prominentbuffs:SetDimensions( SCB.SV.IconSize + 6, 400 )
        uiTlw.prominentdebuffs:SetDimensions( SCB.SV.IconSize + 6, 400 )
    end

    -- Reset alignment and sort
    SCB.SetIconsAlignment( SCB.SV.Alignment )
    SCB.SetIconsAlignmentLongVert( SCB.SV.AlignmentLongVert )
    SCB.SetIconsAlignmentLongHorz( SCB.SV.AlignmentLongHorz )
    SCB.SetIconsAlignmentProminentBuff( SCB.SV.ProminentBuffAlignment )
    SCB.SetIconsAlignmentProminentDebuff( SCB.SV.ProminentDebuffAlignment )
    SCB.SetSortDirection( SCB.SV.SortDirection )

    local needs_reset = {}
    -- And reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_reset[container] = true
    end
    for _, container in pairs(containerRouting) do
        if needs_reset[container] then
            for i = 1, #uiTlw[container].icons do
                SCB.ResetSingleIcon( container, uiTlw[container].icons[i], uiTlw[container].icons[i-1] )
            end
        end
        needs_reset[container] = false
    end

    if g_playerActive then
        SCB.ReloadEffects("player")
    end
end

-- Reset only a single icon
function SCB.ResetSingleIcon( container, buff, AnchorItem )
    local buffSize = SCB.SV.IconSize
    local frameSize = 2 * buffSize + 4

    buff:SetHidden( true )
    --buff:SetAlpha( 1 )
    buff:SetDimensions( buffSize, buffSize )
    buff.frame:SetDimensions( frameSize, frameSize )
    buff.back:SetHidden( SCB.SV.GlowIcons )
    buff.frame:SetHidden( not SCB.SV.GlowIcons )
    buff.label:SetAnchor(TOPLEFT, buff, LEFT, -g_padding, -SCB.SV.LabelPosition)
    buff.label:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT, g_padding, -2)
    buff.label:SetHidden( not SCB.SV.RemainingText )
    buff.stack:SetAnchor(CENTER, buff, BOTTOMLEFT, 0, 0)
    buff.stack:SetAnchor(CENTER, buff, TOPRIGHT, -g_padding * 3, g_padding * 3)
    buff.stack:SetHidden( true )

    if buff.name ~= nil then
        buff.name:SetHidden( not SCB.SV.ProminentLabel )
    end

    if buff.bar ~= nil then
        buff.bar.backdrop:SetHidden( not SCB.SV.ProminentProgress )
        buff.bar.bar:SetHidden( not SCB.SV.ProminentProgress )
    end

    if buff.cd ~= nil then
        buff.cd:SetHidden( not SCB.SV.RemainingCooldown )
        -- We do not need black icon background when there is no Cooldown control present
        buff.iconbg:SetHidden( not SCB.SV.RemainingCooldown )
    end

    if buff.abilityId ~= nil then
        buff.abilityId:SetHidden( not SCB.SV.ShowDebugAbilityId )
    end

    local inset = (SCB.SV.RemainingCooldown and buff.cd ~= nil) and 3 or 1

    buff.drop:ClearAnchors()
    buff.drop:SetAnchor( TOPLEFT, buff, TOPLEFT, inset, inset )
    buff.drop:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -inset, -inset )

    buff.icon:ClearAnchors()
    buff.icon:SetAnchor( TOPLEFT, buff, TOPLEFT, inset, inset )
    buff.icon:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -inset, -inset )
    if buff.iconbg ~= nil then
        buff.iconbg:ClearAnchors()
        buff.iconbg:SetAnchor( TOPLEFT, buff, TOPLEFT, inset, inset)
        buff.iconbg:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -inset, -inset)
    end

    if buff.bar then
        if buff.effectType == 1 then
            buff.bar.backdrop:SetCenterColor((0.1*SCB.SV.ProminentProgressBuffC2[1]), (0.1*SCB.SV.ProminentProgressBuffC2[2]), (0.1*SCB.SV.ProminentProgressBuffC2[3]), 0.75)
            buff.bar.bar:SetGradientColors( SCB.SV.ProminentProgressBuffC2[1], SCB.SV.ProminentProgressBuffC2[2], SCB.SV.ProminentProgressBuffC2[3], 1, SCB.SV.ProminentProgressBuffC1[1], SCB.SV.ProminentProgressBuffC1[2], SCB.SV.ProminentProgressBuffC1[3], 1)
        else
            buff.bar.backdrop:SetCenterColor((0.1*SCB.SV.ProminentProgressDebuffC2[1]), (0.1*SCB.SV.ProminentProgressDebuffC2[2]), (0.1*SCB.SV.ProminentProgressDebuffC2[3]), 0.75)
            buff.bar.bar:SetGradientColors( SCB.SV.ProminentProgressDebuffC2[1], SCB.SV.ProminentProgressDebuffC2[2], SCB.SV.ProminentProgressDebuffC2[3], 1, SCB.SV.ProminentProgressDebuffC1[1], SCB.SV.ProminentProgressDebuffC1[2], SCB.SV.ProminentProgressDebuffC1[3], 1)
        end
    end

    if container == "prominentbuffs" then
        if SCB.SV.ProminentBuffLabelDirection == "Left" then
            buff.name:ClearAnchors()
            buff.name:SetAnchor(BOTTOMRIGHT, buff, BOTTOMLEFT, -4, -(SCB.SV.IconSize * .25) +2 )
            buff.name:SetAnchor(TOPRIGHT, buff, TOPLEFT, -4, -(SCB.SV.IconSize * .25) +2 )

            buff.bar.backdrop:ClearAnchors()
            buff.bar.backdrop:SetAnchor(BOTTOMRIGHT, buff, BOTTOMLEFT, -4, 0 )
            buff.bar.backdrop:SetAnchor(BOTTOMRIGHT, buff, BOTTOMLEFT, -4, 0 )

            buff.bar.bar:SetTexture(LUIE.StatusbarTextures[SCB.SV.ProminentProgressTexture])
            buff.bar.bar:SetBarAlignment(BAR_ALIGNMENT_REVERSE)
            buff.bar.bar:ClearAnchors()
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
        else
            buff.name:ClearAnchors()
            buff.name:SetAnchor(BOTTOMLEFT, buff, BOTTOMRIGHT, 4, -(SCB.SV.IconSize * .25) +2 )
            buff.name:SetAnchor(TOPLEFT, buff, TOPRIGHT, 4, -(SCB.SV.IconSize * .25) +2 )

            buff.bar.backdrop:ClearAnchors()
            buff.bar.backdrop:SetAnchor(BOTTOMLEFT, buff, BOTTOMRIGHT, 4, 0 )
            buff.bar.backdrop:SetAnchor(BOTTOMLEFT, buff, BOTTOMRIGHT, 4, 0 )

            buff.bar.bar:SetTexture(LUIE.StatusbarTextures[SCB.SV.ProminentProgressTexture])
            buff.bar.bar:SetBarAlignment(BAR_ALIGNMENT_NORMAL)
            buff.bar.bar:ClearAnchors()
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
        end
    end

    if container == "prominentdebuffs" then
        if SCB.SV.ProminentDebuffLabelDirection == "Right" then
            buff.name:ClearAnchors()
            buff.name:SetAnchor(BOTTOMLEFT, buff, BOTTOMRIGHT, 4, -(SCB.SV.IconSize * .25) +2 )
            buff.name:SetAnchor(TOPLEFT, buff, TOPRIGHT, 4, -(SCB.SV.IconSize * .25) +2 )

            buff.bar.backdrop:ClearAnchors()
            buff.bar.backdrop:SetAnchor(BOTTOMLEFT, buff, BOTTOMRIGHT, 4, 0 )
            buff.bar.backdrop:SetAnchor(BOTTOMLEFT, buff, BOTTOMRIGHT, 4, 0 )

            buff.bar.bar:SetTexture(LUIE.StatusbarTextures[SCB.SV.ProminentProgressTexture])
            buff.bar.bar:SetBarAlignment(BAR_ALIGNMENT_NORMAL)
            buff.bar.bar:ClearAnchors()
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
        else
            buff.name:ClearAnchors()
            buff.name:SetAnchor(BOTTOMRIGHT, buff, BOTTOMLEFT, -4, -(SCB.SV.IconSize * .25) +2 )
            buff.name:SetAnchor(TOPRIGHT, buff, TOPLEFT, -4, -(SCB.SV.IconSize * .25) +2 )

            buff.bar.backdrop:ClearAnchors()
            buff.bar.backdrop:SetAnchor(BOTTOMRIGHT, buff, BOTTOMLEFT, -4, 0 )
            buff.bar.backdrop:SetAnchor(BOTTOMRIGHT, buff, BOTTOMLEFT, -4, 0 )

            buff.bar.bar:SetTexture(LUIE.StatusbarTextures[SCB.SV.ProminentProgressTexture])
            buff.bar.bar:SetBarAlignment(BAR_ALIGNMENT_REVERSE)
            buff.bar.bar:ClearAnchors()
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
            buff.bar.bar:SetAnchor(CENTER, buff.bar.backdrop, CENTER, 0, 0)
        end
    end

    -- Position all items except first one to the right of it's neighbour
    -- First icon is positioned automatically if the container is present
    buff:ClearAnchors()
    if AnchorItem == nil then
        -- First Icon is positioned only when the container is present,
        if uiTlw[container].iconHolder then
            if uiTlw[container].alignVertical then
                buff:SetAnchor( BOTTOM, uiTlw[container].iconHolder, BOTTOM, 0, 0 )
            else
                buff:SetAnchor( LEFT, uiTlw[container].iconHolder, LEFT, 0, 0 )
            end
        end

    -- For container without holder we will reanchor first icon all the time
    -- Rest icons go one after another.
    else
        if uiTlw[container].alignVertical then
            buff:SetAnchor( BOTTOM, AnchorItem, TOP, 0, -g_padding )
        else
            buff:SetAnchor( LEFT, AnchorItem, RIGHT, g_padding, 0 )
        end
    end
end

-- Right Click Cancel Buff function
function SCB.Buff_OnMouseUp(self, button, upInside)
    if upInside and button == MOUSE_BUTTON_INDEX_RIGHT and self.buffSlot and not self.isArtificial then
        CancelBuff(self.buffSlot)
    end
end

-- TODO - add as option - StickyTooltip removal function
local function ClearStickyTooltip()
    ClearTooltip(GameTooltip)
    eventManager:UnregisterForUpdate(moduleName .. "StickyTooltip")
end

-- OnMouseEnter for Buff Tooltips
function SCB.Buff_OnMouseEnter(control)

    -- TEMP
    eventManager:UnregisterForUpdate(moduleName .. "StickyTooltip")

    InitializeTooltip(GameTooltip, control, BOTTOM, 0, -5, TOP)
    -- Setup Text
    local tooltipText
    local colorText = ZO_NORMAL_TEXT
    local tooltipTitle = strformat(SI_ABILITY_TOOLTIP_NAME, control.effectName)
    if control.isArtificial then
        tooltipText = GetArtificialEffectTooltipText(control.effectId)
        GameTooltip:AddLine(tooltipTitle, "", ZO_SELECTED_TEXT:UnpackRGBA())
        GameTooltip:AddLine(tooltipText, "", colorText:UnpackRGBA())
    else


    -- BEGIN TEMPORARY DEBUF FUNCTION HERE
    -- MY ACCOUNT DEBUG: Temporary conditional to check for my Display Name and do some debug stuff, otherwise use normal function
    local displayName = GetDisplayName()
    if displayName == "@ArtOfShred" or displayName == "@ArtOfShredLegacy" then

        tooltipText = ""

        -- Add original TP if present
        if control.buffSlot then
            if GetAbilityEffectDescription(control.buffSlot) ~= "" then
                tooltipText = "|cFFFF00Original Tool:|r " .. GetAbilityEffectDescription(control.buffSlot) .. "\n"
            end
        end

        local duration
        if type(control.effectId) == "number" then
            -- Add original description if present
            if GetAbilityDescription(control.effectId) ~= "" then
                tooltipText = tooltipText .. "|c3A92FFOriginal Desc:|r " .. GetAbilityDescription(control.effectId) .. "\n\n"
            end

            duration = control.duration / 1000
        else
            duration = 0
        end

        local value2
        local value3
        if E.EffectOverride[control.effectId] then
            if E.EffectOverride[control.effectId].tooltipValue2 then
                value2 = E.EffectOverride[control.effectId].tooltipValue2
            elseif E.EffectOverride[control.effectId].tooltipValue2Mod then
                value2 =  math.floor(GetAbilityDuration(E.EffectOverride[control.effectId].tooltipValue2Mod * 10) + 0.5) / 10
            elseif E.EffectOverride[control.effectId].tooltipValue2Id then
                value2 =  math.floor(GetAbilityDuration(E.EffectOverride[control.effectId].tooltipValue2Id) + 0.5) / 1000
            else
                value2 = 0
            end
        else
            value2 = 0
        end
        if E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltipValue3 then
            value3 = E.EffectOverride[control.effectId].tooltipValue3
        else
            value3 = 0
        end
        duration = math.floor((duration * 10) + 0.5) / 10

        local tooltipText2
        if LUIE.ResolveVeteranDifficulty() == true and E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltipVet then
            tooltipText2 = strformat(E.EffectOverride[control.effectId].tooltipVet, timer, value2, value3)
        else
             tooltipText2 = (E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltip) and strformat(E.EffectOverride[control.effectId].tooltip, duration, value2, value3) or ""
        end
        if tooltipText2 ~= "" then
            tooltipText2 = "|cEE992AOverride TP:|r " .. tooltipText2
        end
        tooltipText = tooltipText .. tooltipText2

        if control.tooltip then tooltipText = control.tooltip end

        if E.TooltipUseDefault[control.effectId] then
            if GetAbilityEffectDescription(control.buffSlot) ~= "" then
                tooltipText = tooltipText .. "\n\n|c00FFFFFlagged to show original Tooltip|r"
            end
        end

    -- NORMAL BEHAVIOR:
    else
        if control.tooltip then
            tooltipText = control.tooltip
        else
            local duration
            if type(control.effectId) == "number" then
                duration = control.duration / 1000
                local value2
                local value3
                if E.EffectOverride[control.effectId] then
                    if E.EffectOverride[control.effectId].tooltipValue2 then
                        value2 = E.EffectOverride[control.effectId].tooltipValue2
                    elseif E.EffectOverride[control.effectId].tooltipValue2Mod then
                        value2 =  math.floor(GetAbilityDuration(E.EffectOverride[control.effectId].tooltipValue2Mod * 10) + 0.5) / 10
                    elseif E.EffectOverride[control.effectId].tooltipValue2Id then
                        value2 =  math.floor(GetAbilityDuration(E.EffectOverride[control.effectId].tooltipValue2Id) + 0.5) / 1000
                    else
                        value2 = 0
                    end
                else
                    value2 = 0
                end
                if E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltipValue3 then
                    value3 = E.EffectOverride[control.effectId].tooltipValue3
                else
                    value3 = 0
                end
                duration = math.floor((duration * 10) + 0.5) / 10

                local tooltipText
                if control.buffSlot then
                    tooltipText = (E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltip) and strformat(E.EffectOverride[control.effectId].tooltip, duration, value2, value3) or GetAbilityDescription(abilityId)
                else
                    tooltipText = (E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltip) and strformat(E.EffectOverride[control.effectId].tooltip, duration, value2, value3) or ""
                end
                if LUIE.ResolveVeteranDifficulty() == true and E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltipVet then
                    tooltipText = strformat(E.EffectOverride[control.effectId].tooltipVet, timer, value2, value3)
                end

                -- Use default tooltip - temp if needed (TODO: Remove when all base ability/set tooltips are updated)
                if tooltipText == "" or tooltipText == nil then
                    if GetAbilityEffectDescription(control.buffSlot) ~= "" then
                        tooltipText = GetAbilityEffectDescription(control.buffSlot)
                    end
                end

            else
                duration = 0
            end
        end

        if E.TooltipUseDefault[control.effectId] then
            if GetAbilityEffectDescription(control.buffSlot) ~= "" then
                tooltipText = GetAbilityEffectDescription(control.buffSlot)
            end
        end

    end
    -- END TEMPORARY DEBUG FUNCTION HERE

        local thirdLine
        local duration = control.duration / 1000
        if E.EffectOverride[control.effectId] and E.EffectOverride[control.effectId].tooltipDurFix then
            duration = duration + E.EffectOverride[control.effectId].tooltipDurFix
        end
        if E.TooltipNameOverride[control.effectName] then
            thirdLine = strformat(E.TooltipNameOverride[control.effectName], duration)
        end
        if E.TooltipNameOverride[control.effectId] then
            thirdLine = strformat(E.TooltipNameOverride[control.effectId], duration)
        end
        -- Have to trim trailing spaces on the end of tooltips
        if tooltipText ~= "" then
            tooltipText = string.match(tooltipText, ".*%S")
        end
        if thirdLine ~="" and thirdLine ~= nil then
            colorText = control.buffType == BUFF_EFFECT_TYPE_DEBUFF and ZO_ERROR_COLOR or ZO_SUCCEEDED_TEXT
        end

        GameTooltip:AddLine(tooltipTitle, "", ZO_SELECTED_TEXT:UnpackRGBA())
        if tooltipText ~= "" and tooltipText ~= nil then
            GameTooltip:AddLine(tooltipText, "", colorText:UnpackRGBA())
        end
        if thirdLine ~="" and thirdLine ~= nil then
            GameTooltip:AddLine(thirdLine, "", ZO_NORMAL_TEXT:UnpackRGB())
        end
    end
end

-- OnMouseExit for Buff Tooltips
function SCB.Buff_OnMouseExit(control)
    local displayName = GetDisplayName()
    if displayName == "@ArtOfShred" or displayName == "@ArtOfShredLegacy" then
        -- Temp - Sticky tooltip so I can edit things easier
        eventManager:RegisterForUpdate(moduleName .. "StickyTooltip", 4000, ClearStickyTooltip )
    else
        ClearTooltip(GameTooltip)
    end
    -- TODO: Add Sticky Tooltips
end

-- Create a Single Buff Icon
function SCB.CreateSingleIcon(container, AnchorItem, effectType)
    local buff = UI.Backdrop( uiTlw[container], nil, nil, {0,0,0,0.5}, {0,0,0,1}, false )

    -- Enable tooltip
    buff:SetMouseEnabled( true )
    buff:SetHandler("OnMouseEnter", SCB.Buff_OnMouseEnter)
    buff:SetHandler("OnMouseExit",  SCB.Buff_OnMouseExit)
    buff:SetHandler("OnMouseUp",  SCB.Buff_OnMouseUp)

    -- Border
    buff.back   = UI.Texture( buff, nil, nil, "/esoui/art/actionbar/abilityframe64_up.dds", nil, false )
    buff.back:SetAnchor(TOPLEFT, buff, TOPLEFT)
    buff.back:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT)
    -- Glow border
    buff.frame  = UI.Texture( buff, {CENTER,CENTER}, nil, nil, nil, false )
    -- Background
    if container ~= "player_long" then
        buff.iconbg = UI.Texture( buff, nil, nil, "/esoui/art/actionbar/abilityinset.dds", DL_CONTROLS, true )
        buff.iconbg = UI.Backdrop( buff, nil, nil, {0,0,0,0.9}, {0,0,0,0.9}, false )
        buff.iconbg:SetDrawLevel(DL_CONTROLS)
    end
    -- Drop for collectible/mount
    buff.drop   = UI.Texture( buff, nil, nil, "LuiExtended/media/icons/abilities/ability_innate_background.dds", DL_BACKGROUND, true )
    -- Icon itself
    buff.icon   = UI.Texture( buff, nil, nil, "/esoui/art/icons/icon_missing.dds", DL_CONTROLS, false )
    -- Remaining text label
    buff.label = UI.Label( buff, nil, nil, nil, g_buffsFont, nil, false )
    buff.label:SetAnchor(TOPLEFT, buff, LEFT, -g_padding, -SCB.SV.LabelPosition)
    buff.label:SetAnchor(BOTTOMRIGHT, buff, BOTTOMRIGHT, g_padding, -2)
    -- AbilityId Debug label
    buff.abilityId = UI.Label( buff, nil, nil, nil, g_buffsFont, nil, false )
    buff.abilityId:SetAnchor(CENTER, buff, CENTER, 0, 0)
    buff.abilityId:SetAnchor(CENTER, buff, CENTER, 0, 0)
    -- Stack label
    buff.stack = UI.Label( buff, nil, nil, nil, g_buffsFont, nil, false )
    buff.stack:SetAnchor(CENTER, buff, BOTTOMLEFT, 0, 0)
    buff.stack:SetAnchor(CENTER, buff, TOPRIGHT, -g_padding * 3, g_padding * 3)
    -- Cooldown circular control
    if buff.iconbg ~= nil then
        buff.cd = windowManager:CreateControl(nil, buff, CT_COOLDOWN)
        buff.cd:SetAnchor( TOPLEFT, buff, TOPLEFT, 1, 1 )
        buff.cd:SetAnchor( BOTTOMRIGHT, buff, BOTTOMRIGHT, -1, -1 )
        buff.cd:SetDrawLayer(DL_BACKGROUND)
    end

    if container == "prominentbuffs" then
        buff.effectType = effectType
        buff.name = UI.Label( buff, nil, nil, nil, g_prominentFont, nil, false )
        buff.bar = {
            ["backdrop"] = UI.Backdrop( buff, nil, {154, 16}, nil, nil, false ),
            ["bar"]     = UI.StatusBar( buff, nil, {150, 12}, nil, false ),
        }
        buff.bar.backdrop:SetEdgeTexture("",8,2,2)
        buff.bar.backdrop:SetDrawLayer(DL_BACKDROP)
        buff.bar.backdrop:SetDrawLevel(1)
        buff.bar.bar:SetMinMax(0, 1)
    end

    if container == "prominentdebuffs" then
        buff.effectType = effectType
        buff.name = UI.Label( buff, nil, nil, nil, g_prominentFont, nil, false )
        buff.bar = {
            ["backdrop"]= UI.Backdrop( buff, nil, {154, 16}, nil, nil, false ),
            ["bar"]     = UI.StatusBar( buff, nil, {150, 12}, nil, false ),
        }
        buff.bar.backdrop:SetEdgeTexture("",8,2,2)
        buff.bar.backdrop:SetDrawLayer(DL_BACKDROP)
        buff.bar.backdrop:SetDrawLevel(1)
        buff.bar.bar:SetMinMax(0, 1)
    end

    SCB.ResetSingleIcon(container, buff, AnchorItem)
    return buff
end

 -- Set proper color of border and text on single buff element
function SCB.SetSingleIconBuffType(buff, buffType, unbreakable)
    local contextType
    local colour
    if not unbreakable or unbreakable == 0 then
        if buffType == 1 then
            contextType = "buff"
            colour = {0,1,0,1}
        else
            contextType = "debuff"
            colour = {1,0,0,1}
        end
    elseif unbreakable == 1 then
        if buffType == 1 then
            contextType = "buff"
            colour = {0,1,1,1}
        else
            contextType = "debuff"
            colour = {.88,.88,1,1}
        end
    end
    -- {0.07, 0.45, 0.8}

    buff.frame:SetTexture("/esoui/art/actionbar/" .. contextType .. "_frame.dds")
    buff.label:SetColor( unpack( SCB.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
    buff.stack:SetColor( unpack( SCB.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
    if buff.cd ~= nil then
        buff.cd:SetFillColor( unpack(colour) )
    end

    if buff.bar then
        if buffType == 1 then
            buff.bar.backdrop:SetCenterColor((0.1*SCB.SV.ProminentProgressBuffC2[1]), (0.1*SCB.SV.ProminentProgressBuffC2[2]), (0.1*SCB.SV.ProminentProgressBuffC2[3]), 0.75)
            buff.bar.bar:SetGradientColors( SCB.SV.ProminentProgressBuffC2[1], SCB.SV.ProminentProgressBuffC2[2], SCB.SV.ProminentProgressBuffC2[3], 1, SCB.SV.ProminentProgressBuffC1[1], SCB.SV.ProminentProgressBuffC1[2], SCB.SV.ProminentProgressBuffC1[3], 1)
        else
            buff.bar.backdrop:SetCenterColor((0.1*SCB.SV.ProminentProgressDebuffC2[1]), (0.1*SCB.SV.ProminentProgressDebuffC2[2]), (0.1*SCB.SV.ProminentProgressDebuffC2[3]), 0.75)
            buff.bar.bar:SetGradientColors( SCB.SV.ProminentProgressDebuffC2[1], SCB.SV.ProminentProgressDebuffC2[2], SCB.SV.ProminentProgressDebuffC2[3], 1, SCB.SV.ProminentProgressDebuffC1[1], SCB.SV.ProminentProgressDebuffC1[2], SCB.SV.ProminentProgressDebuffC1[3], 1)
        end
    end
end

-- Updates local variable with new font and resets all existing icons
function SCB.ApplyFont()
    if not SCB.Enabled then
        return
    end

    -- Font setup for standard Buffs & Debuffs
    local fontName = LUIE.Fonts[SCB.SV.BuffFontFace]
    if not fontName or fontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        fontName = "$(MEDIUM_FONT)"
    end
    local fontStyle = ( SCB.SV.BuffFontStyle and SCB.SV.BuffFontStyle ~= "" ) and SCB.SV.BuffFontStyle or "outline"
    local fontSize = ( SCB.SV.BuffFontSize and SCB.SV.BuffFontSize > 0 ) and SCB.SV.BuffFontSize or 17
    g_buffsFont = fontName .. "|" .. fontSize .. "|" .. fontStyle

    -- Font Setup for Prominent Buffs & Debuffs
    local prominentName = LUIE.Fonts[SCB.SV.ProminentLabelFontFace]
    if not prominentName or prominentName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        prominentName = "$(MEDIUM_FONT)"
    end
    local prominentStyle = ( SCB.SV.ProminentLabelFontStyle and SCB.SV.ProminentLabelFontStyle ~= "" ) and SCB.SV.ProminentLabelFontStyle or "outline"
    local prominentSize = ( SCB.SV.ProminentLabelFontSize and SCB.SV.ProminentLabelFontSize > 0 ) and SCB.SV.ProminentLabelFontSize or 17
    g_prominentFont = prominentName .. "|" .. prominentSize .. "|" .. prominentStyle

    local needs_reset = {}
    -- And reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_reset[container] = true
    end
    for _, container in pairs(containerRouting) do
        if needs_reset[container] then
            for i = 1, #uiTlw[container].icons do
                -- Set label font
                uiTlw[container].icons[i].label:SetFont(g_buffsFont)
                -- Set prominent buff label font
                if uiTlw[container].icons[i].name then
                    uiTlw[container].icons[i].name:SetFont(g_prominentFont)
                end
            end
        end
        needs_reset[container] = false
    end
end

--[[
    * Runs on the EVENT_EFFECT_CHANGED listener.
    * This handler fires every long-term effect added or removed:
 ]]--
function SCB.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    if castByPlayer == COMBAT_UNIT_TYPE_PLAYER and (E.EffectGroundDisplay[abilityId] or E.LinkedGroundMine[abilityId]) and not SCB.SV.HideGroundEffects then
        -- Mines with multiple auras have to be linked into one id for the purpose of tracking stacks
        if E.LinkedGroundMine[abilityId] then
            abilityId = E.LinkedGroundMine[abilityId]
        end

        -- Bail out if this ability is blacklisted
        if SCB.SV.BlacklistTable[abilityId] or SCB.SV.BlacklistTable[effectName] then
            return
        end

        -- Create fake ground aura
        local groundType = { }
        groundType[1] = { info = E.EffectGroundDisplay[abilityId].buff, context = "player1", promB = "promb_player", promD = "promd_player", type = 1 }
        groundType[2] = { info = E.EffectGroundDisplay[abilityId].debuff, context = "player2", promB = "promb_target", promD = "promd_target", type = BUFF_EFFECT_TYPE_DEBUFF }
        groundType[3] = { info = E.EffectGroundDisplay[abilityId].ground, context = "ground", promB = "promb_ground", promD = "promd_ground", type = BUFF_EFFECT_TYPE_DEBUFF }

        if changeType == EFFECT_RESULT_FADED then
            if E.EffectGroundDisplay[abilityId] and E.EffectGroundDisplay[abilityId].noRemove then return end -- Ignore some abilities
            local currentTime = GetGameTimeMilliseconds()
            if not g_protectAbilityRemoval[abilityId] or g_protectAbilityRemoval[abilityId] < currentTime then
                for i = 1, 3 do
                    if groundType[i].info == true then
                        -- Set container context
                        local context
                        if (SCB.SV.PromDebuffTable[abilityId] or SCB.SV.PromDebuffTable[effectName]) then
                            context = groundType[i].promD
                        elseif (SCB.SV.PromBuffTable[abilityId] or SCB.SV.PromBuffTable[effectName]) then
                            context = groundType[i].promB
                        else
                            context = groundType[i].context
                        end
                        if (E.IsGroundMineAura[abilityId] or E.IsGroundMineStack[abilityId]) then
                            -- Check to make sure aura exists in case of reloadUI
                            if LUIE.EffectsList[context][ abilityId ] then
                                LUIE.EffectsList[context][ abilityId ].stack = LUIE.EffectsList[context][ abilityId ].stack - E.EffectGroundDisplay[abilityId].stackRemove
                                if LUIE.EffectsList[context][ abilityId ].stack == 0 then LUIE.EffectsList[context][ abilityId ] = nil end
                            end
                        else
                            LUIE.EffectsList[context][ abilityId ] = nil
                        end
                    end
                end
            end
        elseif changeType == EFFECT_RESULT_GAINED then
            -- Special condition to remove 2nd Rearming Trap aura if it is recast before the 2nd trap triggers
            if abilityId == 40382 then
                LUIE.EffectsList.ground[40388] = nil
                LUIE.EffectsList.promb_ground[40388] = nil
                LUIE.EffectsList.promd_ground[40388] = nil
            end

            local currentTime = GetGameTimeMilliseconds()
            g_protectAbilityRemoval[abilityId] = currentTime + 150

            local duration = endTime - beginTime
            local groundLabel = E.EffectOverride[abilityId] and E.EffectOverride[abilityId].groundLabel or false
            local toggle = E.IsToggle[abilityId] or false
            iconName = E.EffectGroundDisplay[abilityId].icon or iconName
            effectName = E.EffectGroundDisplay[abilityId].name or effectName

            for i = 1, 3 do
                if groundType[i].info == true then
                    -- Set container context
                    local context
                    if (SCB.SV.PromDebuffTable[abilityId] or SCB.SV.PromDebuffTable[effectName]) then
                        context = groundType[i].promD
                    elseif (SCB.SV.PromBuffTable[abilityId] or SCB.SV.PromBuffTable[effectName]) then
                        context = groundType[i].promB
                    else
                        context = groundType[i].context
                    end
                    if E.IsGroundMineAura[abilityId] then
                        stackCount = E.EffectGroundDisplay[abilityId].stackReset
                    elseif E.IsGroundMineStack[abilityId] then
                        if LUIE.EffectsList[context][ abilityId ] then
                            stackCount = LUIE.EffectsList[context][ abilityId ].stack + E.EffectGroundDisplay[abilityId].stackRemove
                        else
                            stackCount = 1
                        end
                        if stackCount > E.EffectGroundDisplay[abilityId].stackReset then stackCount = E.EffectGroundDisplay[abilityId].stackReset end
                    end

                    LUIE.EffectsList[context][ abilityId ] = {
                        type=groundType[i].type,
                        id=abilityId, name=effectName, icon=iconName,
                        dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
                        forced=nil,
                        restart=true, iconNum=0,
                        unbreakable=0,
                        stack = stackCount,
                        buffSlot = effectSlot,
                        groundLabel = groundLabel,
                        toggle = toggle,
                    }
                end
            end
        end
    end

    if E.EffectOverride[abilityId] then
        effectType = E.EffectOverride[abilityId].type or effectType
        -- Bail out now if we hide ground snares and other effects because we are showing Damaging Auras (Only do this for the player, we don't want effects on targets to stop showing up).
        if E.EffectOverride[abilityId].hideGround and SCB.SV.GroundDamageAura and unitTag == "player" then
            return
        end
    end

    -- Track only effects on self or target debuffs
    if unitTag ~= "player" and unitTag ~= "reticleover" then
        return
    end

    -- If this effect isn't a prominent buff or debuff and we have certain buffs set to hidden - then hide those.
    if not (SCB.SV.PromDebuffTable[abilityId] or SCB.SV.PromDebuffTable[effectName] or SCB.SV.PromBuffTable[abilityId] or SCB.SV.PromBuffTable[effectName]) then
        if SCB.SV.HidePlayerBuffs and effectType == 1 and unitTag == "player" then
            return
        end
        if SCB.SV.HidePlayerDebuffs and effectType == 2 and unitTag == "player" then
            return
        end
        if SCB.SV.HideTargetBuffs and effectType == 1 and unitTag ~= "player" then
            return
        end
        if SCB.SV.HideTargetDebuffs and effectType == 2 and unitTag ~= "player" then
            return
        end
    end
    --d(strfmt("OnEffectChanged %d: %s[%s] / %d/%d/%d [%s-%d] %d", changeType, effectName, unitTag, effectType, abilityType, statusEffectType, unitName, unitId, abilityId ))

    local unbreakable = 0

    -- Grim Focus Stack counter
    if E.IsGrimFocus[abilityId] or E.IsGrimFocusOverride[abilityId] then
        local context
        if unitTag == "player" then
            context = { LUIE.EffectsList.player1, LUIE.EffectsList.promb_player, LUIE.EffectsList.promd_player }
        else
            context = { LUIE.EffectsList.reticleover1 }
        end

        -- Set stack count when Grim Focus counter changes
        if E.IsGrimFocus[abilityId] then
            for _, effectsList in pairs(context) do
                for k, v in pairs(effectsList) do
                    if E.IsGrimFocusOverride[v.id] then
                        if changeType == EFFECT_RESULT_FADED then
                            v.stack = 0
                        else
                            v.stack = stackCount
                        end
                    end
                end
            end
        end

        -- Set stack count when Grim Focus duration buff changes
        if E.IsGrimFocusOverride[abilityId] then
            for i = 1, GetNumBuffs(unitTag) do
                local _, _, _, _, stack, _, _, _, _, _, abilityId = GetUnitBuffInfo(unitTag, i)
                if E.IsGrimFocus[abilityId] then
                    stackCount = stack
                end
            end
        end
    end

    if E.EffectOverride[abilityId] then
        if E.EffectOverride[abilityId].hide == true then
            return
        end
        if E.EffectOverride[abilityId].hideReduce == true and SCB.SV.HideReduce then
            return
        end
        if E.EffectOverride[abilityId].isDisguise and SCB.SV.IgnoreDisguise then -- For Monk's Disguise / other buff based Disguise hiding
            return
        end
        iconName = E.EffectOverride[abilityId].icon or iconName
        effectName = E.EffectOverride[abilityId].name or effectName
        unbreakable = E.EffectOverride[abilityId].unbreakable or 0
        stackCount = E.EffectOverride[abilityId].stack or stackCount
        -- Destroy other effects of the same type if we don't want to show duplicates at all.
        if E.EffectOverride[abilityId].noDuplicate then
            for context, effectsList in pairs( LUIE.EffectsList ) do
                for k, v in pairs(effectsList) do
                    -- Only remove the lower duration effects that were cast previously.
                    if v.id == abilityId and v.ends < (1000*endTime) then
                        LUIE.EffectsList[context][ k ] = nil
                    end
                end
            end
        end
        -- Bail out if this effect should only appear on Refresh
        if E.EffectOverride[abilityId].refreshOnly then
            if changeType ~= EFFECT_RESULT_UPDATED and changeType ~= EFFECT_RESULT_FULL_REFRESH and changeType ~= EFFECT_RESULT_FADED then
                return
            end
        end
    end

    if E.MapDataOverride[abilityId] then
        local index = GetCurrentMapZoneIndex()
        if E.MapDataOverride[abilityId][index] then
            if E.MapDataOverride[abilityId][index].icon then
                iconName = E.MapDataOverride[abilityId][index].icon
            end
            if E.MapDataOverride[abilityId][index].name then
                effectName = E.MapDataOverride[abilityId][index].name
            end
            if E.MapDataOverride[abilityId][index].hide then
                return
            end
        end
    end

    if E.EffectOverrideByName[abilityId] then
        unitName = strformat("<<t:1>>", unitName)
        if E.EffectOverrideByName[abilityId][unitName] then
            if E.EffectOverrideByName[abilityId][unitName].hide then
                return
            end
            iconName = E.EffectOverrideByName[abilityId][unitName].icon or iconName
            effectName = E.EffectOverrideByName[abilityId][unitName].name or effectName
        end
    end

    if SCB.SV.BlacklistTable[abilityId] or SCB.SV.BlacklistTable[effectName] then
        return
    end

    -- If the source of the buff isn't the player or the buff is not on the AbilityId or AbilityName override list then we don't display it
    if unitTag ~= "player" then
        if effectType == 2 and not (castByPlayer == 1) and not (E.DebuffDisplayOverrideId[abilityId] or E.DebuffDisplayOverrideName[effectName]) then
            return
        end
    end

    -- Hide effects if chosen in the options menu
    if hidePlayerEffects[abilityId] and unitTag == "player" then
        return
    end

    if hideTargetEffects[abilityId] and unitTag == "reticleover" then
        return
    end

    local forcedType = E.EffectOverride[abilityId] and E.EffectOverride[abilityId].forcedContainer or nil
    local savedEffectSlot = effectSlot
    effectSlot = E.EffectMergeId[abilityId] or E.EffectMergeName[effectName] or effectSlot

    if unitTag == "reticleover" and abilityId == 92428 and not IsUnitPlayer('reticleover') then
        return
    end

    -- Where the new icon will go into
    local context = unitTag .. effectType

    if (SCB.SV.PromDebuffTable[abilityId] or SCB.SV.PromDebuffTable[effectName]) then
        if context == "player1" then
            context = "promd_player"
        elseif (context == "reticleover2" and castByPlayer == COMBAT_UNIT_TYPE_PLAYER) or abilityId == 102771 then
            context = "promd_target"
        end
    elseif (SCB.SV.PromBuffTable[abilityId] or SCB.SV.PromBuffTable[effectName]) then
        if context == "player1" then
            context = "promb_player"
        elseif (context == "reticleover2" and castByPlayer == COMBAT_UNIT_TYPE_PLAYER) or abilityId == 102771 then
            context = "promb_target"
        end
    end

    -- Exit here if there is no container to hold this effect
    if not containerRouting[context] then
        return
    end

    if changeType == EFFECT_RESULT_FADED then -- delete Effect
        LUIE.EffectsList[context][effectSlot] = nil
        if E.EffectCreateSkillAura[ abilityId ] and E.EffectCreateSkillAura [ abilityId ].removeOnEnd then
            local name = strformat("<<C:1>>", GetAbilityName(E.EffectCreateSkillAura[abilityId].abilityId))
            local id = E.EffectCreateSkillAura[abilityId].abilityId
            if not (SCB.SV.BlacklistTable[name] or SCB.SV.BlacklistTable[id]) then
                local simulatedContext = unitTag .. effectType

                if (SCB.SV.PromDebuffTable[name] or SCB.SV.PromDebuffTable[id]) then
                    if simulatedContext == "player1" then
                        simulatedContext = "promd_player"
                    elseif (simulatedContext == "reticleover2" and castByPlayer == COMBAT_UNIT_TYPE_PLAYER)  then
                        simulatedContext = "promd_target"
                    end
                elseif (SCB.SV.PromBuffTable[name] or SCB.SV.PromBuffTable[id]) then
                    if simulatedContext == "player1" then
                        simulatedContext = "promb_player"
                    elseif (simulatedContext == "reticleover2" and castByPlayer == COMBAT_UNIT_TYPE_PLAYER) then
                        simulatedContext = "promb_target"
                    end
                end
                LUIE.EffectsList[simulatedContext][ E.EffectCreateSkillAura[abilityId].abilityId ] = nil
            end
        end

    -- Create Effect
    else
        local duration = endTime - beginTime
        local groundLabel = E.EffectOverride[abilityId] and E.EffectOverride[abilityId].groundLabel or false
        local toggle = E.IsToggle[abilityId] or false

        if E.EffectOverride[abilityId] and E.EffectOverride[abilityId].duration then
            if E.EffectOverride[abilityId].duration == 0 then
                duration = 0
            else
               duration = duration - E.EffectOverride[abilityId].duration
            end
            endTime = endTime - E.EffectOverride[abilityId].duration
        end

        -- Specific override for Mend Spirit -- Updates Major Resolve / Major Ward to use the remaining duration of Mend Spirit.
        if E.EffectPullDuration[abilityId] then
            local matchId = E.EffectPullDuration[abilityId]
            for i = 1, GetNumBuffs(unitTag) do
                local _, timeStarted, timeEnding, _, _, _, _, _, _, _, abilityId = GetUnitBuffInfo(unitTag, i)
                if abilityId == matchId then
                    duration = timeEnding - timeStarted
                    beginTime = timeStarted
                    endTime = timeEnding
                end
            end
        end

        --EffectCreateSkillAura
        if E.EffectCreateSkillAura[abilityId] then
            if (not E.EffectCreateSkillAura[abilityId].requiredStack) or (E.EffectCreateSkillAura[abilityId].requiredStack and stackCount == E.EffectCreateSkillAura[abilityId].requiredStack) then
                local name = strformat("<<C:1>>", GetAbilityName(E.EffectCreateSkillAura[abilityId].abilityId))
                local id = E.EffectCreateSkillAura[abilityId].abilityId
                if not (SCB.SV.BlacklistTable[name] or SCB.SV.BlacklistTable[id]) then
                    local simulatedContext = unitTag .. effectType

                    if (SCB.SV.PromDebuffTable[name] or SCB.SV.PromDebuffTable[id]) then
                        if simulatedContext == "player1" then
                            simulatedContext = "promd_player"
                        elseif (simulatedContext == "reticleover2" and castByPlayer == COMBAT_UNIT_TYPE_PLAYER)  then
                            simulatedContext = "promd_target"
                        end
                    elseif (SCB.SV.PromBuffTable[name] or SCB.SV.PromBuffTable[id]) then
                        if simulatedContext == "player1" then
                            simulatedContext = "promb_player"
                        elseif (simulatedContext == "reticleover2" and castByPlayer == COMBAT_UNIT_TYPE_PLAYER)  then
                            simulatedContext = "promb_target"
                        end
                    end

                    if ( SCB.SV.ExtraBuffs ) or ( E.EffectCreateSkillAura[abilityId].consolidate and SCB.SV.ExtraConsolidate ) or ( E.EffectCreateSkillAura[abilityId].alwaysShow ) then
                        if ( not E.EffectCreateSkillAura[abilityId].extendedDisplay ) or (E.EffectCreateSkillAura[abilityId].extendedDisplay and SCB.SV.ExtraExpanded) then
                            local icon = E.EffectCreateSkillAura[abilityId].icon or GetAbilityIcon(id)
                            LUIE.EffectsList[simulatedContext][ E.EffectCreateSkillAura[abilityId].abilityId ] = {
                                target=unitTag, type=effectType,
                                id=id, name=name, icon=icon,
                                dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
                                forced=forcedType,
                                restart=true, iconNum=0,
                                stack = 0,
                                unbreakable=unbreakable,
                                groundLabel = groundLabel,
                                toggle = toggle,
                            }
                        end
                    end
                end
            end
        end

        -- If consolidate is enabled then hide the consolidated ability
        if E.EffectOverride[abilityId] and SCB.SV.ExtraConsolidate then
            if E.EffectOverride[abilityId].consolidate or ( E.EffectOverride[abilityId].consolidateExtra and SCB.SV.ExtraExpanded ) then
                return
            end
        end
        -- If this effect doesn't properly display stacks - then add them.
        if E.EffectOverride[abilityId] and E.EffectOverride[abilityId].displayStacks then
            for context, effectsList in pairs( LUIE.EffectsList ) do
                for k, v in pairs(effectsList) do
                    -- Add stacks
                    if v.id == abilityId then
                        stackCount = v.stack + 1
                        -- Stop stacks from going over a certain amount.
                        if stackCount > E.EffectOverride[abilityId].maxStacks then
                            stackCount = E.EffectOverride[abilityId].maxStacks
                        end
                    end
                end
            end
        end

        -- Buffs are created based on their effectSlot, this allows multiple buffs/debuffs of the same type to appear.
        LUIE.EffectsList[context][ effectSlot ] = {
            target=unitTag, type=effectType,
            id=abilityId, name=effectName, icon=iconName,
            dur=1000*duration, starts=1000*beginTime, ends=(duration > 0) and (1000*endTime) or nil,
            forced=forcedType,
            restart=true, iconNum=0,
            stack = stackCount,
            unbreakable=unbreakable,
            buffSlot = savedEffectSlot,
            groundLabel = groundLabel,
            toggle = toggle,
        }
    end
end

--[[
    * Runs on the EVENT_ARTIFICIAL_EFFECT_ADDED / EVENT_ARTIFICIAL_EFFECT_REMOVED listener.
    * This handler fires whenever an ArtificialEffectId is added or removed:
]]--
function SCB.ArtificialEffectUpdate(eventCode, effectId)
    if SCB.SV.HidePlayerBuffs then
        return
    end

    if effectId then
        LUIE.EffectsList.player1[effectId] = nil
    end

    for effectId in ZO_GetNextActiveArtificialEffectIdIter do
        local displayName, iconFile, effectType, _, startTime = GetArtificialEffectInfo(effectId)
        --local forcedType = E.EffectForcedType[artificialEffectId]
        -- Bail out if we don't have Battle Spirit display for the player on

        local duration = 0
        local endTime = nil

        if (effectId == 0 or effectId == 2) and SCB.SV.IgnoreBattleSpiritPlayer then
            return
        end

        if (effectId == 3) then
            duration = 1200000
            startTime = GetGameTimeMilliseconds()
            endTime = startTime + ( GetLFGCooldownTimeRemainingSeconds(LFG_COOLDOWN_BATTLEGROUND_DESERTED) * 1000 )
            effectType = BUFF_EFFECT_TYPE_BUFF -- Set to buff so it shows in long duration effects
        end

        LUIE.EffectsList.player1[ effectId ] = {
            target="player", type=effectType,
            id=effectId, name = displayName, icon = iconFile,
            dur=duration, starts=startTime, ends=endTime,
            forced="long",
            restart=true, iconNum=0,
            artificial = true,
        }
    end
end

--[[
 * Runs on the EVENT_COMBAT_EVENT listener.
 * This handler fires every time ANY combat activity happens. Very-very often.
 * We use it to remove mines from active target debuffs
 * As well as create fake buffs/debuffs for events with no active effect present.
 ]]--

-- Counter variable for ACTION_RESULT_EFFECT_GAINED / ACTION_RESULT_EFFECT_FADED tracking for some buffs that are broken
-- Handles buffs that rather than refreshing on reapplication create an individual instance and therefore have GAINED/FADED events every single time the effect ticks.
local InternalStackCounter = { }

 -- Combat Event (Target = Player)
function SCB.OnCombatEventIn( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    if not (E.FakeExternalBuffs[abilityId] or E.FakeExternalDebuffs[abilityId] or E.FakePlayerBuffs[abilityId] or E.FakeStagger[abilityId] or E.AddGroundDamageAura[abilityId]) then
        return
    end

    -- Create ground auras for damaging effects if toggled on
    if SCB.SV.GroundDamageAura and E.AddGroundDamageAura[abilityId] then
        -- Return if this isn't damage or healing, or blocked, dodged, or shielded.
        if result ~= ACTION_RESULT_DAMAGE and result ~= ACTION_RESULT_DAMAGE_SHIELDED and result ~= ACTION_RESULT_DODGED and result ~=ACTION_RESULT_CRITICAL_DAMAGE and result ~= ACTION_RESULT_CRITICAL_HEAL and result ~= ACTION_RESULT_HEAL and result ~= ACTION_RESULT_BLOCKED and result ~= ACTION_RESULT_BLOCKED_DAMAGE and not E.AddGroundDamageAura[abilityId].exception then
            return
        end

        -- Only allow exceptions through if flagged as such
        if E.AddGroundDamageAura[abilityId].exception and result ~= E.AddGroundDamageAura[abilityId].exception then
            return
        end

        local iconName = GetAbilityIcon(abilityId)
        local effectName
        local unbreakable
        local duration = E.AddGroundDamageAura[abilityId].duration
        local effectType = E.AddGroundDamageAura[abilityId].type
        local buffSlot
        local groundLabel = E.EffectOverride[abilityId] and E.EffectOverride[abilityId].groundLabel or false
        local toggle = E.IsToggle[abilityId] or false

        if E.EffectOverride[abilityId] then
            effectName = E.EffectOverride[abilityId].name or abilityName
            unbreakable = E.EffectOverride[abilityId].unbreakable or 0
            stack = E.EffectOverride[abilityId].stack or 0
        else
            effectName = abilityName
            unbreakable = 0
            stack = 0
        end

        if E.AddGroundDamageAura[abilityId].merge then
            buffSlot = "GroundDamageAura" .. tostring(E.AddGroundDamageAura[abilityId].merge)
        else
            buffSlot = abilityId
        end

        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local context = "player" .. effectType

        -- Stack Resolution
        if LUIE.EffectsList[context][ buffSlot ] and E.EffectOverride[abilityId] and E.EffectOverride[abilityId].stackAdd then
            if E.EffectOverride[abilityId].stackMax then
                if not (LUIE.EffectsList[context][ buffSlot ].stack == E.EffectOverride[abilityId].stackMax) then
                    stack = LUIE.EffectsList[context][ buffSlot ].stack + E.EffectOverride[abilityId].stackAdd
                else
                    stack = LUIE.EffectsList[context][ buffSlot ].stack
                end
            else
                stack = LUIE.EffectsList[context][ buffSlot ].stack + E.EffectOverride[abilityId].stackAdd
            end
        end

        LUIE.EffectsList[context][ buffSlot ] = {
            type=effectType,
            id=abilityId, name=effectName, icon=iconName,
            dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
            forced = "short",
            restart=true, iconNum=0,
            unbreakable=unbreakable,
            fakeDuration= true,
            groundLabel = groundLabel,
            toggle = toggle,
            stack = stack,
        }
    end

    -- If the action result isn't a starting/ending event then we ignore it.
    if result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_GAINED and result ~= ACTION_RESULT_EFFECT_GAINED_DURATION and result ~= ACTION_RESULT_EFFECT_FADED then
        return
    end

    -- Toggled on when we need to ignore double events from some ids
    if g_ignoreAbilityId[abilityId] then
        g_ignoreAbilityId[abilityId] = nil
        return
    end

    local unbreakable
    local stack
    local internalStack
    local iconName
    local effectName
    local duration
    local groundLabel = E.EffectOverride[abilityId] and E.EffectOverride[abilityId].groundLabel or false

    if E.EffectOverride[abilityId] then
        if E.EffectOverride[abilityId].hideReduce and SCB.SV.HideReduce then
            return
        end
        unbreakable = E.EffectOverride[abilityId].unbreakable or 0
        stack = E.EffectOverride[abilityId].stack or 0
        internalStack = E.EffectOverride[abilityId].internalStack or nil
    else
        unbreakable = 0
        stack = 0
        internalStack = nil
    end

    -- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalBuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        -- Bail out if we ignore begin events
        if E.FakeExternalBuffs[abilityId].ignoreBegin and (result == ACTION_RESULT_BEGIN) then
            return
        end
        if E.FakeExternalBuffs[abilityId].refreshOnly and (result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED) then
            return
        end
        if E.FakeExternalBuffs[abilityId].ignoreFade and (result == ACTION_RESULT_FADED or result == ACTION_RESULT_EFFECT_FADED) then
            return
        end
        if SCB.SV.HidePlayerBuffs then
            return
        end

        LUIE.EffectsList.player1[ abilityId ] = nil
        iconName = E.FakeExternalBuffs[abilityId].icon or GetAbilityIcon(abilityId)
        effectName = E.FakeExternalBuffs[abilityId].name or GetAbilityName(abilityId)
        overrideDuration = E.FakeExternalBuffs[abilityId].overrideDuration
        duration = E.FakeExternalBuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        if source ~= "" and target == LUIE.PlayerNameFormatted then
            LUIE.EffectsList.player1[ abilityId ] = {
                type=1,
                id=abilityId, name=effectName, icon=iconName,
                dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                forced = "short",
                restart=true, iconNum=0,
                unbreakable=unbreakable,
                fakeDuration = overrideDuration,
                groundLabel = groundLabel,
            }
        end
    end

    -- Creates fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on player by target)
    if E.FakeExternalDebuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        -- Bail out if we ignore begin events
        if E.FakeExternalDebuffs[abilityId].ignoreBegin and (result == ACTION_RESULT_BEGIN) then
            return
        end
        if E.FakeExternalDebuffs[abilityId].refreshOnly and (result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED) then
            return
        end
        if E.FakeExternalDebuffs[abilityId].ignoreFade == true and (result == ACTION_RESULT_FADED or result == ACTION_RESULT_EFFECT_FADED) then
            return
        end
        if SCB.SV.HidePlayerDebuffs then
            return
        end
        -- Bail out if we hide ground snares/etc to replace them with auras for damage
        if SCB.SV.GroundDamageAura and E.EffectOverride[abilityId] and E.EffectOverride[abilityId].hideGround then
            return
        end

        -- Stack handling
        if LUIE.EffectsList.player2[ abilityId ] and E.EffectOverride[abilityId] and E.EffectOverride[abilityId].stackAdd then -- Before removing old effect, if this effect is currently present and stack is set to increment on event, then add to stack counter
            if E.EffectOverride[abilityId].stackMax then
                if not (LUIE.EffectsList.player2[ abilityId ].stack == E.EffectOverride[abilityId].stackMax) then
                    stack = LUIE.EffectsList.player2[ abilityId ].stack + E.EffectOverride[abilityId].stackAdd
                else
                    stack = LUIE.EffectsList.player2[ abilityId ].stack
                end
            else
                stack = LUIE.EffectsList.player2[ abilityId ].stack + E.EffectOverride[abilityId].stackAdd
            end
        end

        if internalStack then
            if not InternalStackCounter[abilityId] then InternalStackCounter[abilityId] = 0 end -- Create stack if it doesn't exist
            if result == ACTION_RESULT_EFFECT_FADED then
                InternalStackCounter[abilityId] = InternalStackCounter[abilityId] - 1
            elseif result == ACTION_RESULT_EFFECT_GAINED_DURATION then
                InternalStackCounter[abilityId] = InternalStackCounter[abilityId] + 1
            end
            if LUIE.EffectsList.player2[abilityId] then
                if InternalStackCounter[abilityId] <= 0 then
                    LUIE.EffectsList.player2[abilityId] = nil
                    InternalStackCounter[abilityId] = nil
                end
            end
        else
            LUIE.EffectsList.player2[ abilityId ] = nil
        end

        iconName = E.FakeExternalDebuffs[abilityId].icon or GetAbilityIcon(abilityId)
        effectName = E.FakeExternalDebuffs[abilityId].name or GetAbilityName(abilityId)
        duration = E.FakeExternalDebuffs[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)

        if E.MapDataOverride[abilityId] then
            local index = GetCurrentMapZoneIndex()
            if E.MapDataOverride[abilityId][index] then
                if E.MapDataOverride[abilityId][index].icon then
                    iconName = E.MapDataOverride[abilityId][index].icon
                end
                if E.MapDataOverride[abilityId][index].name then
                    effectName = E.MapDataOverride[abilityId][index].name
                end
                if E.MapDataOverride[abilityId][index].hide then
                    return
                end
            end
        end

        -- TODO: Temp - converts icon for Helljoint, might be other abilities that need this in the future
        if abilityId == 14523 then
            if source == "Jackal" then
                iconName = 'LuiExtended/media/icons/abilities/ability_jackal_helljoint.dds'
            end
        end

        if source ~= "" and target == LUIE.PlayerNameFormatted then
            LUIE.EffectsList.player2[ abilityId ] = {
                type=BUFF_EFFECT_TYPE_DEBUFF,
                id=abilityId, name=effectName, icon=iconName,
                dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                forced = "short",
                restart=true, iconNum=0,
                unbreakable=unbreakable,
                groundLabel = groundLabel,
                stack = stack,
            }
        end
    end

    -- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on player by player)
    if E.FakePlayerBuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
         -- Bail out if we ignore begin events
        if E.FakePlayerBuffs[abilityId].ignoreBegin and (result == ACTION_RESULT_BEGIN) then
            return
        end
        if E.FakePlayerBuffs[abilityId].refreshOnly and (result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED) then
            return
        end
        if E.FakePlayerBuffs[abilityId].ignoreFade and (result == ACTION_RESULT_FADED or result == ACTION_RESULT_EFFECT_FADED) then
            return
        end
        if SCB.SV.HidePlayerBuffs and not (SCB.SV.PromDebuffTable[abilityId] or SCB.SV.PromDebuffTable[effectName] or SCB.SV.PromBuffTable[abilityId] or SCB.SV.PromBuffTable[effectName]) then
            return
        end

        -- Prominent Support
        local context
        if (SCB.SV.PromDebuffTable[abilityId] or SCB.SV.PromDebuffTable[effectName]) then
            context = "promd_player"
        elseif (SCB.SV.PromBuffTable[abilityId] or SCB.SV.PromBuffTable[effectName]) then
            context = "promb_player"
        else
            context = "player1"
        end

        if LUIE.EffectsList[context][ abilityId ] and E.EffectOverride[abilityId] and E.EffectOverride[abilityId].stackAdd then -- Before removing old effect, if this effect is currently present and stack is set to increment on event, then add to stack counter
            stack = LUIE.EffectsList[context][ abilityId ].stack + E.EffectOverride[abilityId].stackAdd
        end
        if abilityId == 26406 then g_ignoreAbilityId[abilityId] = true end
        LUIE.EffectsList[context][ abilityId ] = nil
        LUIE.EffectsList.player2[ abilityId ] = nil
        if abilityId == 973 and not SCB.SV.ShowSprint then
            return
        end
        if abilityId == 33439 and not SCB.SV.ShowGallop then
            return
        end

        local toggle = E.IsToggle[abilityId] or false

        iconName = E.FakePlayerBuffs[abilityId].icon or GetAbilityIcon(abilityId)
        effectName = E.FakePlayerBuffs[abilityId].name or GetAbilityName(abilityId)
        duration = E.FakePlayerBuffs[abilityId].duration
        local finalId = E.FakePlayerBuffs[abilityId].shiftId or abilityId
        local forcedType = E.FakePlayerBuffs[abilityId].long and "long" or "short"
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        if source == LUIE.PlayerNameFormatted and target == LUIE.PlayerNameFormatted then
            -- If the "buff" is flagged as a debuff, then display it here instead
            if E.FakePlayerBuffs[abilityId].debuff == true then
                LUIE.EffectsList.player2[ finalId ] = {
                    type=BUFF_EFFECT_TYPE_DEBUFF,
                    id=finalId, name=effectName, icon=iconName,
                    dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                    forced = "short",
                    restart=true, iconNum=0,
                    unbreakable=unbreakable,
                    stack = stack,
                    groundLabel = groundLabel,
                    toggle = toggle,
                }
            -- Otherwise, display as a normal buff
            else
                LUIE.EffectsList[context][ finalId ] = {
                    target="player", type=1,
                    id=finalId, name=effectName, icon=iconName,
                    dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                    forced = forcedType,
                    restart=true, iconNum=0,
                    unbreakable=unbreakable,
                    stack = stack,
                    groundLabel = groundLabel,
                    toggle = toggle,
                }
            end
        end
    end

        -- Simulates fake debuff icons for stagger effects - works for both (target -> player) and (player -> target) - DOES NOT REFRESH - Only expiration condition is the timer
    if E.FakeStagger[abilityId] then
        -- Bail out if we ignore begin events
        if E.FakeStagger[abilityId].ignoreBegin and (result == ACTION_RESULT_BEGIN) then
            return
        end
        if E.FakeStagger[abilityId].refreshOnly and (result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED) then
            return
        end
        if E.FakeStagger[abilityId].ignoreFade and (result == ACTION_RESULT_FADED or result == ACTION_RESULT_EFFECT_FADED) then
            return
        end
        if SCB.SV.HidePlayerDebuffs then
            return
        end
        iconName = E.FakeStagger[abilityId].icon or GetAbilityIcon(abilityId)
        effectName = E.FakeStagger[abilityId].name or GetAbilityName(abilityId)
        duration = E.FakeStagger[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        if source ~= "" and target == LUIE.PlayerNameFormatted then
            LUIE.EffectsList.player2[ abilityId ] = {
                type=BUFF_EFFECT_TYPE_DEBUFF,
                id=abilityId, name=effectName, icon=iconName,
                dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                forced = "short",
                restart=true, iconNum=0,
                unbreakable=unbreakable,
                groundLabel = groundLabel,
            }
        end
    end
end

 -- Combat Event (Source = Player)
function SCB.OnCombatEventOut( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    if targetType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER_PET then
        return
    end

    if not (E.FakePlayerExternalBuffs[abilityId] or E.FakePlayerDebuffs[abilityId] or E.FakeStagger[abilityId]) then
        return
    end

    -- If the action result isn't a starting/ending event then we ignore it.
    if result ~= ACTION_RESULT_BEGIN and result ~= ACTION_RESULT_EFFECT_GAINED and result ~= ACTION_RESULT_EFFECT_GAINED_DURATION and result ~= ACTION_RESULT_EFFECT_FADED then
        return
    end

    local unbreakable
    local stack
    local iconName
    local effectName
    local duration
    local effectType
    local groundLabel = E.EffectOverride[abilityId] and E.EffectOverride[abilityId].groundLabel or false

    if E.EffectOverride[abilityId] then
        if E.EffectOverride[abilityId].hideReduce and SCB.SV.HideReduce then return end
        unbreakable = E.EffectOverride[abilityId].unbreakable or 0
        stack = E.EffectOverride[abilityId].stack or 0
    else
        unbreakable = 0
        stack = 0
    end

    -- Creates fake buff icons for buffs without an aura - These refresh on reapplication/removal (Applied on target by player)
    if E.FakePlayerExternalBuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        -- Bail out if we ignore begin events
        if E.FakePlayerExternalBuffs[abilityId].ignoreBegin and (result == ACTION_RESULT_BEGIN) then
            return
        end
        if E.FakePlayerExternalBuffs[abilityId].refreshOnly and (result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED) then
            return
        end
        if E.FakePlayerExternalBuffs[abilityId].ignoreFade and (result == ACTION_RESULT_FADED or result == ACTION_RESULT_EFFECT_FADED) then
            return
        end
        if SCB.SV.HideTargetBuffs then
            return
        end
        LUIE.EffectsList.reticleover1[ abilityId ] = nil
        if not DoesUnitExist("reticleover") then return end
        if GetUnitReaction("reticleover") == UNIT_REACTION_HOSTILE then return end
        if IsUnitDead(unitTag) then return end
        iconName = E.FakePlayerExternalBuffs[abilityId].icon or GetAbilityIcon(abilityId)
        effectName = E.FakePlayerExternalBuffs[abilityId].name or GetAbilityName(abilityId)
        duration = E.FakePlayerExternalBuffs[abilityId].duration
        effectType = BUFF_EFFECT_TYPE_DEBUFF
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        if unitName ~= target then return end
        if source == LUIE.PlayerNameFormatted and target ~= nil then
            if SCB.SV.HideTargetBuffs then
                return
            end
            LUIE.EffectsList.reticleover1[ abilityId ] = {
                type=effectType,
                id=abilityId, name=effectName, icon=iconName,
                dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                forced = "short",
                restart=true, iconNum=0,
                unbreakable=unbreakable,
                groundLabel = groundLabel,
            }
        end
    end

    -- Creates fake debuff icons for debuffs without an aura - These refresh on reapplication/removal (Applied on target by player)
    if E.FakePlayerDebuffs[abilityId] and (sourceType == COMBAT_UNIT_TYPE_PLAYER or targetType == COMBAT_UNIT_TYPE_PLAYER) then
        -- Bail out if we ignore begin events
        if E.FakePlayerDebuffs[abilityId].ignoreBegin and (result == ACTION_RESULT_BEGIN) then
            return
        end
        if E.FakePlayerDebuffs[abilityId].refreshOnly and (result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED) then
            return
        end
        if E.FakePlayerDebuffs[abilityId].ignoreFade and (result == ACTION_RESULT_FADED or result == ACTION_RESULT_EFFECT_FADED) then
            return
        end
        if SCB.SV.HideTargetDebuffs then
            return
        end
        LUIE.EffectsList.reticleover2[ abilityId ] = nil
        if not DoesUnitExist("reticleover") then end
        --if GetUnitReaction("reticleover") ~= UNIT_REACTION_HOSTILE then return end
        if IsUnitDead(unitTag) then return end
        iconName = E.FakePlayerDebuffs[abilityId].icon or GetAbilityIcon(abilityId)
        effectName = E.FakePlayerDebuffs[abilityId].name or GetAbilityName(abilityId)
        duration = E.FakePlayerDebuffs[abilityId].duration
        overrideDuration = E.FakePlayerDebuffs[abilityId].overrideDuration
        effectType = BUFF_EFFECT_TYPE_DEBUFF
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        --if unitName ~= target then return end
        if source == LUIE.PlayerNameFormatted and target ~= nil then
            if SCB.SV.HideTargetDebuffs then
                return
            end
            if unitName == target then
                LUIE.EffectsList.ground[ abilityId ] = {
                    type=effectType,
                    id=abilityId, name=effectName, icon=iconName,
                    dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                    forced = "short",
                    restart=true, iconNum=0,
                    unbreakable=unbreakable,
                    savedName = strformat(SI_UNIT_NAME, targetName),
                    fakeDuration = overrideDuration,
                    groundLabel = groundLabel,
                }
            else
                LUIE.EffectsList.saved[ abilityId ] = {
                    type=effectType,
                    id=abilityId, name=effectName, icon=iconName,
                    dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                    forced = "short",
                    restart=true, iconNum=0,
                    unbreakable=unbreakable,
                    savedName = strformat(SI_UNIT_NAME, targetName),
                    fakeDuration = overrideDuration,
                    groundLabel = groundLabel,
                }
            end
        end
    end

    -- Simulates fake debuff icons for stagger effects - works for both (target -> player) and (player -> target) - DOES NOT REFRESH - Only expiration condition is the timer
    if E.FakeStagger[abilityId] then
        -- Bail out if we ignore begin events
        if E.FakeStagger[abilityId].ignoreBegin and (result == ACTION_RESULT_BEGIN) then
            return
        end
        if E.FakeStagger[abilityId].refreshOnly and (result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED) then
            return
        end
        if E.FakeStagger[abilityId].ignoreFade and (result == ACTION_RESULT_FADED or result == ACTION_RESULT_EFFECT_FADED) then
            return
        end
        if SCB.SV.HideTargetDebuffs then
            return
        end
        iconName = E.FakeStagger[abilityId].icon or GetAbilityIcon(abilityId)
        effectName = E.FakeStagger[abilityId].name or GetAbilityName(abilityId)
        duration = E.FakeStagger[abilityId].duration
        local beginTime = GetGameTimeMilliseconds()
        local endTime = beginTime + duration
        local source = strformat("<<t:1>>",sourceName)
        local target = strformat("<<t:1>>",targetName)
        local unitName = strformat("<<t:1>>", GetUnitName("reticleover") )
        if source == LUIE.PlayerNameFormatted and target ~= nil then
            if SCB.SV.HideTargetDebuffs then
                return
            end
            if unitName == target then
                LUIE.EffectsList.ground[ abilityId ] = {
                    type=BUFF_EFFECT_TYPE_DEBUFF,
                    id=abilityId, name=effectName, icon=iconName,
                    dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                    forced = "short",
                    restart=true, iconNum=0,
                    unbreakable=unbreakable,
                    savedName = strformat(SI_UNIT_NAME, targetName),
                    groundLabel = groundLabel,
                }
            else
                LUIE.EffectsList.saved[ abilityId ] = {
                    type=BUFF_EFFECT_TYPE_DEBUFF,
                    id=abilityId, name=effectName, icon=iconName,
                    dur=duration, starts=beginTime, ends=(duration > 0) and (endTime) or nil,
                    forced = "short",
                    restart=true, iconNum=0,
                    unbreakable=unbreakable,
                    savedName = strformat(SI_UNIT_NAME, targetName),
                    groundLabel = groundLabel,
                }
            end
        end
    end
end

-- Runs on the EVENT_UNIT_DEATH_STATE_CHANGED listener.
-- This handler fires every time a valid unitTag dies or is resurrected
function SCB.OnDeath(eventCode, unitTag, isDead)
    -- Wipe buffs
    if isDead then
        if unitTag == "player" then
            LUIE.EffectsList.player1 = {}
            LUIE.EffectsList.player2 = {}
            LUIE.EffectsList.ground = {}
            LUIE.EffectsList.promb_ground = {}
            LUIE.EffectsList.promd_ground = {}
            LUIE.EffectsList.promb_player = {}
            LUIE.EffectsList.promd_player = {}

            -- If werewolf is active, reset the icon so it's not removed (otherwise it flashes off for about a second until the trailer function picks up on the fact that no power drain has occurred.
            if SCB.SV.ShowWerewolf and IsWerewolf() then
                SetWerewolfIconFrozen()
            end
        else
            for effectType = 1, 2 do
                LUIE.EffectsList[ unitTag .. effectType ] = {}
            end
        end
    end
end

-- Runs on the EVENT_TARGET_CHANGE listener.
-- This handler fires every time someone target changes.
-- This function is needed in case the player teleports via Way Shrine
function SCB.OnTargetChange(eventCode, unitTag)
    if unitTag ~= "player" then
        return
    end
    SCB.OnReticleTargetChanged(eventCode)
end

-- Runs on the EVENT_RETICLE_TARGET_CHANGED listener.
-- This handler fires every time the player's reticle target changes
function SCB.OnReticleTargetChanged(eventCode)
    SCB.ReloadEffects("reticleover")
end

-- Used to clear existing .effectsList.unitTag and to request game API to fill it again
function SCB.ReloadEffects(unitTag)

    -- Bail if this isn't reticleover or player
    if unitTag ~= "player" and unitTag ~= "reticleover" then
        return
    end

    -- Clear Existing
    LUIE.EffectsList[unitTag .. 1] = {}
    LUIE.EffectsList[unitTag .. 2] = {}
    if unitTag == "player" then
        LUIE.EffectsList["promb_player"] = {}
        LUIE.EffectsList["promb_ground"] = {}
        LUIE.EffectsList["promd_player"] = {}
        LUIE.EffectsList["promd_ground"] = {}
    else
        LUIE.EffectsList["promb_target"] = {}
        LUIE.EffectsList["promd_target"] = {}
    end

    -- Stop doing anything else if we moused off a target
    if GetUnitName(unitTag) == "" then
        return
    end

    -- Fill it again
    for i = 1, GetNumBuffs(unitTag) do
        local unitName = GetRawUnitName(unitTag)
        local buffName, timeStarted, timeEnding, buffSlot, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = GetUnitBuffInfo(unitTag, i)
        -- Fudge this value to send to SCB.OnEffectChanged if this is a debuff
        if castByPlayer == true then
        castByPlayer = 1
        else
            castByPlayer = 5
        end
        if not (IsUnitDead(unitTag) and E.EffectHideWhenDead[abilityId]) then
            SCB.OnEffectChanged(0, 3, buffSlot, buffName, unitTag, timeStarted, timeEnding, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, unitName, 0--[[unitId]], abilityId, castByPlayer)
        end
    end

    -- Load Cyrodiil Buffs
    SCB.LoadCyrodiilBuffs(unitTag)
    -- Display Disguise State
    SCB.DisguiseStateChanged(nil, unitTag, GetUnitDisguiseState(unitTag))
    -- Display Stealth State
    SCB.StealthStateChanged(nil, unitTag, GetUnitStealthState(unitTag))

    -- PLAYER SPECIFIC
    if unitTag == "player" and not SCB.SV.HidePlayerBuffs then
        -- Update Artificial Effects
        SCB.ArtificialEffectUpdate()
        -- Display Recall Cooldown
        if SCB.SV.ShowRecall and not SCB.SV.HidePlayerDebuffs then
            SCB.ShowRecallCooldown()
        end
    end

    -- TARGET SPECIFIC
    if unitTag == "reticleover" and not SCB.SV.HideTargetBuffs then
        -- Handle FAKE DEBUFFS between targets
        SCB.RestoreSavedFakeEffects()
        -- Add Name Auras
        SCB.AddNameAura()
        -- Display Battle Spirit
        SCB.LoadBattleSpiritTarget()
    end

end

-- Called by EVENT_RETICLE_TARGET_CHANGED listener - Displays recall cooldown
function SCB.ShowRecallCooldown()
    local recallRemain, _ = GetRecallCooldown()
    if recallRemain > 0 then
        local currentTime = GetGameTimeMilliseconds()
        LUIE.EffectsList["player1"][ A.Innate_Recall_Penalty ] = {
            target="player", type=1,
            id=6811, name=A.Innate_Recall_Penalty, icon='LuiExtended/media/icons/abilities/ability_innate_recall_cooldown.dds',
            dur=600000, starts=currentTime, ends=currentTime+recallRemain,
            forced = "long",
            restart=true, iconNum=0,
            unbreakable=1,
            overrideDur = 600000
        }
    end
end

-- Called by EVENT_RETICLE_TARGET_CHANGED listener - Saves active FAKE debuffs on enemies and moves them back and forth between the active container or hidden.
function SCB.RestoreSavedFakeEffects()
    -- Restore Ground Effects
    for _, effectsList in pairs( {LUIE.EffectsList.ground, LUIE.EffectsList.saved} ) do
        --local container = containerRouting[context]
        for k, v in pairs(effectsList) do
            if v.savedName ~= nil then
                local unitName = strformat(SI_UNIT_NAME, GetUnitName('reticleover'))
                if unitName == v.savedName then
                    if LUIE.EffectsList.saved[k] then
                        LUIE.EffectsList.ground[k] = LUIE.EffectsList.saved[k]
                        LUIE.EffectsList.ground[k].iconNum = 0
                        LUIE.EffectsList.saved[k] = nil
                    end
                else
                    if LUIE.EffectsList.ground[k] then
                        LUIE.EffectsList.saved[k] = LUIE.EffectsList.ground[k]
                        LUIE.EffectsList.ground[k] = nil
                    end
                end
            end
        end
    end
end

-- Called by EVENT_RETICLE_TARGET_CHANGED listener - Displays fake buffs based off unitName (primarily for displaying Boss Immunities)
function SCB.AddNameAura()
    local unitName = GetUnitName('reticleover')
    -- We need to check to make sure the mob is not dead, and also check to make sure the unitTag is not the player (just in case someones name exactly matches that of a boss NPC)
    if E.AddNameAura[unitName] and GetUnitReaction('reticleover') == UNIT_REACTION_HOSTILE and not IsUnitPlayer('reticleover') and not IsUnitDead('reticleover') then
        for k, v in ipairs(E.AddNameAura[unitName]) do
            local abilityName = GetAbilityName(v.id)
            local abilityIcon = GetAbilityIcon(v.id)
            LUIE.EffectsList.reticleover1[ "Name Specific Buff" .. k ] = {
                type=1,
                id= v.id, name= abilityName, icon= abilityIcon,
                dur=0, starts=1, ends=nil,
                forced = "short",
                restart=true, iconNum=0
            }
        end
    end
end

-- Called by menu to preview icon positions. Simply iterates through all containers other than player_long and adds dummy test buffs into them.
function SCB.MenuPreview()
    local currentTime = GetGameTimeMilliseconds()
    local routing = { "player1", "reticleover1", "promb_player", "player2", "reticleover2", "promd_player" }
    local testEffectDurationList = { 22, 44, 55, 300, 1800000 }
    local abilityId = 999000
    local icon = "/esoui/art/icons/icon_missing.dds"

    for i = 1, 5 do
        for c = 1, 6 do
            local context = routing[c]
            local type = c < 4 and 1 or 2
            local name = ("Test Effect: " .. i )
            local duration = testEffectDurationList[i]
            LUIE.EffectsList[context][ abilityId ] = {
                target = context, type=type,
                id=16415, name=name, icon=icon,
                dur = duration * 1000,
                starts = currentTime,
                ends = currentTime + (duration * 1000),
                forced="short",
                restart=true, iconNum=0,
            }
            abilityId = abilityId + 1
        end
    end
end

-- Helper function to sort buffs
local function buffSort(x, y)
    local xDuration = (x.ends == nil or x.dur == 0 or x.groundLabel or x.toggle) and 0 or x.dur
    local yDuration = (y.ends == nil or y.dur == 0 or y.groundLabel or y.toggle) and 0 or y.dur
    -- Sort toggle effects
    if x.toggle or y.toggle then
        if xDuration == 0 and yDuration == 0 then
            if x.toggle and y.toggle then
                return (x.name < y.name)
            elseif x.toggle and not y.toggle then
                return (xDuration == 0)
            end
        else
            return (xDuration == 0)
        end
    -- Sort permanent/ground effects (might separate these at some point but for now want the sorting function simplified)
    elseif (xDuration == 0 and yDuration == 0) then
        return (x.name < y.name)
    -- Both non-permanent
    elseif xDuration ~= 0 and yDuration ~= 0 then
        return (x.starts == y.starts) and (x.name < y.name) or (x.ends > y.ends)
    -- One permanent, one not
    else
        return (xDuration == 0)
    end
end

-- Runs OnUpdate - 100 ms buffer
function SCB.OnUpdate(currentTime)
    -- local currentTime = GetGameTimeMilliseconds()
    local buffsSorted = {}
    local needs_update = {}
    local isProminent = {}
    -- And reset sizes of already existing icons
    for _, container in pairs(containerRouting) do
        needs_update[container] = true
        -- Prepare sort container
        if buffsSorted[container] == nil then
            buffsSorted[container] = {}
        end

        -- Refresh prominent buff labels on each update tick
        if container == "prominentbuffs" or container == "prominentdebuffs" then
            isProminent[container] = true
        end
    end

    -- Filter expired events. and build array for sorting
    for context, effectsList in pairs(LUIE.EffectsList) do
        local container = containerRouting[context]
        for k, v in pairs(effectsList) do
            -- Remove effect (that is not permanent and has duration)
            if v.ends ~= nil and v.dur > 0 and v.ends < currentTime then
                effectsList[k] = nil
            -- Or append to correct container
            elseif container then
                -- Add icons to to-be-sorted list only if effect already started
                if v.starts < currentTime then
                    -- Filter Long-Term effects:
                    -- Always show debuffs and short-term buffs
                    if v.type == 2 or v.forced == "short" or not (v.forced == "long" or v.ends == nil or v.dur == 0 or v.ends-currentTime > 120000) then
                        table.insert(buffsSorted[container], v)

                    -- Show long-term target buffs in same container
                    elseif v.target == "reticleover" and SCB.SV.LongTermEffects_Target then
                        table.insert(buffsSorted[container], v)

                    -- Show long-term player buffs
                    elseif v.target == "player" and SCB.SV.LongTermEffects_Player then
                        -- Choose container for long-term player buffs
                        if SCB.SV.LongTermEffectsSeparate and not (container == "prominentbuffs" or container == "prominentdebuffs") then
                            table.insert(buffsSorted.player_long, v)
                        else
                            table.insert(buffsSorted[container], v)
                        end
                    end
                end
            end
        end
    end

    -- Sort effects in container and draw them on screen
    for _, container in pairs(containerRouting) do
        if needs_update[container] then
            table.sort(buffsSorted[container], buffSort)
            SCB.updateIcons( currentTime, buffsSorted[container], container )
        end
        needs_update[container] = false
    end
    for _, container in pairs(containerRouting) do
        if isProminent then
            SCB.updateBar( currentTime, buffsSorted[container], container )
        end
    end

end

function SCB.updateBar( currentTime, sortedList, container )
    local iconsNum = #sortedList
    local istart, iend, istep

    if g_horizSortInvert and not uiTlw[container].alignVertical then
        istart, iend, istep = iconsNum, 1, -1
    else
        istart, iend, istep = 1, iconsNum, 1
    end

    local index = 0 -- Global icon counter
    for i = istart, iend, istep do
        index = index + 1
        -- Get current buff definition
        local effect = sortedList[i]

        local ground = effect.groundLabel
        local remain = ( effect.ends ~= nil ) and ( effect.ends - currentTime ) or nil
        local buff = uiTlw[container].icons[index]
        local auraStarts = effect.starts or nil
        local auraEnds = effect.ends or nil
        local fakeDuration = effect.fakeDuration

        -- If this isn't a permanent duration buff then update the bar on every tick
        if buff and buff.bar and buff.bar.bar then
            if auraStarts and auraEnds and remain > 0 and not ground then
                buff.bar.bar:SetValue(1 - ((currentTime - auraStarts) / (auraEnds - auraStarts)))
            else
                buff.bar.bar:SetValue(1)
            end
        end
    end
end

function SCB.updateIcons( currentTime, sortedList, container )
    -- Special workaround for container with player long buffs. We do not need to update it every 100ms, but rather 3 times less often
    if uiTlw[container].skipUpdate then
        uiTlw[container].skipUpdate = uiTlw[container].skipUpdate + 1
        if uiTlw[container].skipUpdate > 1 then
            uiTlw[container].skipUpdate = 0
        else
            return
        end
    end

    local iconsNum = #sortedList

    -- Chose direction of iteration
    local istart, iend, istep
    -- Reverse the order for right aligned icons
    if container == "player_long" and SCB.SV.LongTermEffectsReverse then
        if g_horizSortInvert and not uiTlw[container].alignVertical then
            istart, iend, istep = iconsNum, 1, -1
        else
            istart, iend, istep = iconsNum, 1, -1
        end
    elseif (container == "prominentbuffs") and SCB.SV.ProminentBuffReverseSort then
            istart, iend, istep = iconsNum, 1, -1
    elseif (container == "prominentdebuffs") and SCB.SV.ProminentDebuffReverseSort then
            istart, iend, istep = iconsNum, 1, -1
    else
        if g_horizSortInvert and not uiTlw[container].alignVertical then
            istart, iend, istep = iconsNum, 1, -1
        else
            istart, iend, istep = 1, iconsNum, 1
        end
    end

    -- Size of icon+padding
    local iconSize = SCB.SV.IconSize + g_padding

    -- Set width of contol that holds icons. This will make alignment automatic
    if uiTlw[container].iconHolder then
        if uiTlw[container].alignVertical then
            uiTlw[container].iconHolder:SetDimensions( 0, iconSize*iconsNum - g_padding )
        else
            uiTlw[container].iconHolder:SetDimensions( iconSize*iconsNum - g_padding, 0 )
        end
    end

    -- Prepare variables for manual alignment of icons
    local row = 0   -- row counter for multi-row placement
    local next_row_break = 1

    -- Iterate over list of sorted icons
    local index = 0 -- Global icon counter
    for i = istart, iend, istep do
        -- Get current buff definition
        local effect = sortedList[i]
        index = index + 1
        -- Check if the icon for buff #index exists otherwise create new icon
        if uiTlw[container].icons[index] == nil then
            uiTlw[container].icons[index] = SCB.CreateSingleIcon(container, uiTlw[container].icons[index-1], effect.type)
        end

        -- Calculate remaining time
        local remain = ( effect.ends ~= nil ) and ( effect.ends - currentTime ) or nil
        local name = ( effect.name ~= nil) and effect.name or nil

        local buff = uiTlw[container].icons[index]

        -- Perform manual alignment
        if not uiTlw[container].iconHolder then
            if iconsNum ~= uiTlw[container].prevIconsCount and index == next_row_break --[[ and horizontal orientation of container ]] then
                -- Padding of first icon in a row
                local anchor, leftPadding
                if g_horizAlign == LEFT then
                    anchor = TOPLEFT
                    leftPadding = g_padding
                elseif g_horizAlign == RIGHT then
                    anchor = TOPRIGHT
                    leftPadding = - math.min(uiTlw[container].maxIcons, iconsNum-uiTlw[container].maxIcons*row) * iconSize - g_padding
                else
                    anchor = TOP
                    leftPadding = - 0.5 * ( math.min(uiTlw[container].maxIcons, iconsNum-uiTlw[container].maxIcons*row) * iconSize - g_padding )
                end

                buff:ClearAnchors()
                buff:SetAnchor( TOPLEFT, uiTlw[container], anchor, leftPadding, row*iconSize )
                -- Determine if we need to make next row
                if uiTlw[container].maxIcons then
                    -- If buffs then stack down
                    if container == "player1" or container == "target1" then
                        row = row + 1
                    -- If debuffs then stack up
                    elseif container == "player2"  or container == "target2" then
                        row = row -1
                    end
                    next_row_break = next_row_break + uiTlw[container].maxIcons
                end
            end
        end

        -- If previously this icon was used for different effect, then setup it again
        if effect.iconNum ~= index then
            effect.iconNum = index
            effect.restart = true
            SCB.SetSingleIconBuffType(buff, effect.type, effect.unbreakable)

            -- Setup Info for Tooltip function to pull
            buff.effectId = effect.id
            buff.effectName = effect.name
            buff.buffType = effect.type
            buff.buffSlot = effect.buffSlot
            buff.tooltip = effect.tooltip
            buff.isArtificial = effect.artificial
            buff.duration = effect.dur or 0

            if effect.backdrop then
                buff.drop:SetHidden(false)
            else
                buff.drop:SetHidden(true)
            end
            buff.icon:SetTexture(effect.icon)
            buff:SetAlpha(1)
            buff:SetHidden(false)
            if not remain or effect.fakeDuration then
                if effect.toggle then
                    buff.label:SetText("T")
                elseif effect.groundLabel then
                    buff.label:SetText("G")
                else
                    buff.label:SetText(nil)
                end
            end

            if buff.abilityId and effect.id then
                buff.abilityId:SetText(effect.id)
            end

            if buff.name then
                buff.name:SetText(strformat("<<C:1>>", effect.name))
            end

        end

        if effect.stack and effect.stack > 0 then
            buff.stack:SetText( strfmt("%s", effect.stack) )
            buff.stack:SetHidden(false)
        else
            buff.stack:SetHidden(true)
        end

        -- For update remaining text. For temporary effects this is not very efficient, but we have not much such effects
        if remain and not effect.fakeDuration then
            if remain > 86400000 then -- more then 1 day
                buff.label:SetText( strfmt("%d d", math.floor( remain/86400000 )) )
            elseif remain > 6000000 then -- over 100 minutes - display XXh
                buff.label:SetText( strfmt("%dh", math.floor( remain/3600000 )) )
            elseif remain > 600000 then -- over 10 minutes - display XXm
                buff.label:SetText( strfmt("%dm", math.floor( remain/60000 )) )
            elseif remain > 60000 or container == "player_long" then
                local m = math.floor( remain/60000 )
                local s = remain/1000 - 60*m
                buff.label:SetText( strfmt("%d:%.2d", m, s) )
            else
                buff.label:SetText( strfmt(SCB.SV.RemainingTextMillis and "%.1f" or "%.1d", remain/1000) )
            end
        end
        if effect.restart and buff.cd ~= nil then
            -- Modify abilities with forced maximum durations.
            if effect.overrideDur then
                effect.dur = effect.overrideDur
            end
            if remain == nil or effect.dur == nil or effect.dur == 0 or effect.fakeDuration then
                buff.cd:StartCooldown(0, 0, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_REMAINING, false )
            else
                buff.cd:StartCooldown(remain, effect.dur, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_UNTIL, false )
                effect.restart = false
            end
        end

        -- Now possibly fade out expiring icon
        if SCB.SV.FadeOutIcons and remain ~= nil and remain < 2000 then
            --buff:SetAlpha( 0.05 + remain/2106 )
            buff:SetAlpha(EaseOutQuad(remain, 0, 1, 2000))
        end
    end

    -- Hide rest of icons
    for i = iconsNum+1, #uiTlw[container].icons do
        uiTlw[container].icons[i]:SetHidden(true)
    end

    -- Save icon number processed to compare in next update iteration
    uiTlw[container].prevIconsCount = iconsNum
end

-- Runs on EVENT_PLAYER_ACTIVATED listener
function SCB.OnPlayerActivated(eventCode)
    g_playerActive = true
    g_playerResurrectStage = nil

    -- Reload Effects
    SCB.ReloadEffects("player")

    -- Resolve Duel Target
    SCB.DuelStart()

    -- Resolve Mounted icon
    if not SCB.SV.IgnoreMount and IsMounted() then
        callLater(function() SCB.MountStatus(eventCode, true) end, 50)
    end

    -- Resolve Disguise Icon
    if not SCB.SV.IgnoreDisguise then
        callLater(function() SCB.DisguiseItem(nil, BAG_WORN, 10) end, 50)
    end

    -- Resolve Assistant Icon
    if not SCB.SV.IgnorePet or not SCB.SV.IgnoreAssistant then
        callLater(function() SCB.CollectibleBuff( eventCode, 0, true) end, 50)
    end

    -- Resolve Werewolf
    if SCB.SV.ShowWerewolf and IsWerewolf() then
        SCB.WerewolfState(nil, true, true)
        -- If player is dead, add unlimited duration Werewolf indicator buff
        if IsUnitDead("player") then
            SetWerewolfIconFrozen()
        end
    end

    -- Add Bound Aegis buffs if player has it slotted
    if GetUnitClassId("player") == 2 then
        SCB.DrawBoundAegisBuffs()
    end

    -- Sets the player to dead if reloading UI or loading in while dead.
    if IsUnitDead("player") then
        g_playerDead = true
    end
end

-- Runs on the EVENT_PLAYER_DEACTIVATED listener
function SCB.OnPlayerDeactivated(eventCode)
    g_playerActive = false
    g_playerResurrectStage = nil
end

-- Runs on the EVENT_PLAYER_ALIVE listener
function SCB.OnPlayerAlive(eventCode)
    --[[-- If player clicks "Resurrect at Wayshrine", then player is first deactivated, then he is transferred to new position, then he becomes alive (this event) then player is activated again.
    To register resurrection we need to work in this function if player is already active. --]]--
    if not g_playerActive or not g_playerDead then
        return
    end

    g_playerDead = false

    -- This is a good place to reload player buffs, as they were wiped on death
    SCB.ReloadEffects( "player" )

    -- Reload werewolf effects
    if SCB.SV.ShowWerewolf and IsWerewolf() then
        SCB.WerewolfState(nil, true, true)
        SetWerewolfIconFrozen()
    end

    -- Start Resurrection Sequence
    g_playerResurrectStage = 1
    --[[If it was self resurrection, then there will be 4 EVENT_VIBRATION:
    First - 600ms, Second - 0ms to switch first one off, Third - 350ms, Fourth - 0ms to switch third one off.
    So now we'll listen in the vibration event and progress g_playerResurrectStage with first 2 events and then on correct third event we'll create a buff. --]]
end

-- Runs on the EVENT_PLAYER_DEAD listener
function SCB.OnPlayerDead(eventCode)
    if not g_playerActive then
        return
    end
    g_playerDead = true
end

-- Runs on the EVENT_VIBRATION listener (detects player resurrection stage)
function SCB.OnVibration(eventCode, duration, coarseMotor, fineMotor, leftTriggerMotor, rightTriggerMotor)
    if not g_playerResurrectStage then
        return
    end
    if SCB.SV.HidePlayerBuffs then
        return
    end
    if g_playerResurrectStage == 1 and duration == 600 then
        g_playerResurrectStage = 2
    elseif g_playerResurrectStage == 2 and duration == 0 then
        g_playerResurrectStage = 3
    elseif g_playerResurrectStage == 3 and duration == 350 and SCB.SV.ShowResurrectionImmunity then
        -- We got correct sequence, so let us create a buff and reset the g_playerResurrectStage
        g_playerResurrectStage = nil
        local currentTime = GetGameTimeMilliseconds()
        LUIE.EffectsList["player1"]["Resurrection Immunity"] = {
            target="player", type=1,
            id=14646, name = A.Innate_Resurrection_Immunity, icon = 'LuiExtended/media/icons/abilities/ability_innate_resurrection_immunity.dds',
            dur = 10000, starts= currentTime, ends = currentTime + 10000,
            restart=true, iconNum=0,
        }
    else
        -- This event does not seem to have anything to do with player self-resurrection
        g_playerResurrectStage = nil
    end
end

-- Runs on EVENT_ACTION_SLOT_UPDATED / EVENT_ACTION_SLOTS_ALLHOTBARS_UPDATED / EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED
-- Creates Minor Ward/Minor Resolve buffs for Bound Aegis
function SCB.DrawBoundAegisBuffs()
    LUIE.EffectsList["player1"][999008] = nil
    LUIE.EffectsList["player1"][999009] = nil

    for slotNum = 3, 8 do
        local abilityId = GetSlotBoundId(slotNum)
        if abilityId == 24163 then
            LUIE.EffectsList["player1"][999008] = {
                target ="player", type=1,
                id=999008, icon = 'esoui/art/icons/ability_buff_minor_resolve.dds', name = A.Skill_Minor_Resolve,
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "long",
                restart=true, iconNum=0,
            }
            LUIE.EffectsList["player1"][999009] = {
                target ="player", type=1,
                id=999009, icon = 'esoui/art/icons/ability_buff_minor_ward.dds', name = A.Skill_Minor_Ward,
                dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
                forced = "long",
                restart=true, iconNum=0,
            }
        end
    end
end

-- Called from the menu and on initialize to build the table of hidden effects.
function SCB.UpdateContextHideList()
    hidePlayerEffects = { }
    hideTargetEffects = { }

    if SCB.SV.IgnoreMundusPlayer then
        for k, v in pairs(E.IsBoon) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreMundusTarget then
        for k, v in pairs(E.IsBoon) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreVampPlayer then
        for k, v in pairs(E.IsVamp) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreVampTarget then
        for k, v in pairs(E.IsVamp) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreLycanPlayer then
        for k, v in pairs(E.IsLycan) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreLycanTarget then
        for k, v in pairs(E.IsLycan) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreDiseasePlayer then
        for k, v in pairs(E.IsVampLycanDisease) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreDiseaseTarget then
        for k, v in pairs(E.IsVampLycanDisease) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreBitePlayer then
        for k, v in pairs(E.IsVampLycanBite) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreBiteTarget then
        for k, v in pairs(E.IsVampLycanBite) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreCyrodiilPlayer then
        for k, v in pairs(E.IsCyrodiil) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreCyrodiilTarget then
        for k, v in pairs(E.IsCyrodiil) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreEsoPlusPlayer then
        hidePlayerEffects[63601] = true
    end
    if SCB.SV.IgnoreEsoPlusTarget then
        hideTargetEffects[63601] = true
    end
    if SCB.SV.IgnoreSoulSummonsPlayer then
        for k, v in pairs(E.IsSoulSummons) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreSoulSummonsTarget then
        for k, v in pairs(E.IsSoulSummons) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreSetICDPlayer then
        for k, v in pairs(E.IsSetICD) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreSetICDTarget then
        for k, v in pairs(E.IsSetICD) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreFoodPlayer then
        for k, v in pairs(E.IsFoodBuff) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreFoodTarget then
        for k, v in pairs(E.IsFoodBuff) do
            hideTargetEffects[k] = v
        end
    end
    if SCB.SV.IgnoreExperiencePlayer then
        for k, v in pairs(E.IsExperienceBuff) do
            hidePlayerEffects[k] = v
        end
    end
    if SCB.SV.IgnoreExperienceTarget then
        for k, v in pairs(E.IsExperienceBuff) do
            hideTargetEffects[k] = v
        end
    end
    if not SCB.SV.ShowBlockPlayer then
        for k, v in pairs(E.IsBlock) do
            hidePlayerEffects[k] = v
        end
    end
    if not SCB.SV.ShowBlockTarget then
        for k, v in pairs(E.IsBlock) do
            hideTargetEffects[k] = v
        end
    end
end
