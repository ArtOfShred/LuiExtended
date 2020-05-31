--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local UI = LUIE.UI

local sceneManager = SCENE_MANAGER

local firstRun = true
local savedHiddenStates = { }

-- Table of UI elements to unlock for moving.
-- Constraints for some of these elements need to be adjusted - using values from Azurah.
local defaultPanels = {
    [ZO_HUDInfamyMeter]	= { GetString(SI_LUIE_DEFAULT_FRAME_INFAMY_METER) },
    [ZO_HUDTelvarMeter]	= { GetString(SI_LUIE_DEFAULT_FRAME_TEL_VAR_METER) },
    [ZO_HUDDaedricEnergyMeter] = { GetString(SI_LUIE_DEFAULT_FRAME_VOLENDRUNG_METER) },
    [ZO_HUDEquipmentStatus]	= { GetString(SI_LUIE_DEFAULT_FRAME_EQUIPMENT_STATUS) },
    [ZO_FocusedQuestTrackerPanel] = { GetString(SI_LUIE_DEFAULT_FRAME_QUEST_LOG), nil, 200 },
    [ZO_LootHistoryControl_Keyboard] = { GetString(SI_LUIE_DEFAULT_FRAME_LOOT_HISTORY), 280, 400 },
    [ZO_BattlegroundHUDFragmentTopLevel] = { GetString(SI_LUIE_DEFAULT_FRAME_BATTLEGROUND_SCORE) },
    [ZO_ActionBar1]	= { GetString(SI_LUIE_DEFAULT_FRAME_ACTION_BAR) },
    [ZO_Subtitles] = { GetString(SI_LUIE_DEFAULT_FRAME_SUBTITLES), 256, 80 },
    --[ZO_CompassFrame] = { "Compass Frame" }, -- Snaps back, might have to register some new handler to stop this
    [ZO_TutorialHudInfoTipKeyboard]	= { GetString(SI_LUIE_DEFAULT_FRAME_TUTORIALS) },
    [ZO_ObjectiveCaptureMeter] = { GetString(SI_LUIE_DEFAULT_FRAME_OBJECTIVE_METER), 128, 128 },
    [ZO_PlayerToPlayerAreaPromptContainer] = { GetString(SI_LUIE_DEFAULT_FRAME_PLAYER_INTERACTION), nil, 30 },
    [ZO_ActiveCombatTipsTip] = { GetString(SI_LUIE_DEFAULT_FRAME_ACTIVE_COMBAT_TIPS), 250, 20 },
    [ZO_SynergyTopLevelContainer] = { GetString(SI_LUIE_DEFAULT_FRAME_SYNERGY) },
}

-- Our custom mover frames
local g_LUIE_Movers = { }
local g_framesUnlocked = false

local function sceneChange(oldState, newState)
    if (newState == SCENE_SHOWN) then
        if g_framesUnlocked then
            for k, v in pairs(g_LUIE_Movers) do
                v:SetHidden(true)
            end
        end
    elseif (newState == SCENE_HIDDEN) then
        if g_framesUnlocked then
            for k, v in pairs(g_LUIE_Movers) do
                v:SetHidden(false)
            end
        end
    end
end

function LUIE.SetElementPosition()
    for k,v in pairs(defaultPanels) do
        local frameName = k:GetName()
        if LUIE.SV[frameName] then
            k:SetClampedToScreen ( true )
            -- Adjust constraints so we can move elements.
            if v[2] then
                k:SetWidth(v[2])
            end
            if v[3] then
                k:SetHeight(v[3])
            end
            local x = LUIE.SV[frameName][1]
            local y = LUIE.SV[frameName][2]
            if x ~= nil and y ~= nil then
                k:ClearAnchors()
                k:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, x, y)
            end
        end
    end
end

function LUIE.SetupElementMover(state)
    g_framesUnlocked = state
    for k,v in pairs(defaultPanels) do
        if firstRun then
            -- Clamp these elements to screen so we can't drag them off
            --k:SetClampedToScreen ( true )
            -- Adjust constraints so we can move elements.
            if v[2] then
				k:SetWidth(v[2])
            end
            if v[3] then
                k:SetHeight(v[3])
            end

            -- Create a top level window for backbar butons
            local isValidAnchor, point, relativeTo, relativePoint, offsetX, offsetY = k:GetAnchor()
            local tlw = UI.TopLevel( { point, relativePoint, offsetX, offsetY, relativeTo }, { k:GetWidth(), k:GetHeight() } )

            tlw:SetDrawLayer(DL_BACKDROP)
            tlw:SetDrawTier(DT_MEDIUM)
            tlw.customPositionAttr = k:GetName()
            tlw.preview = UI.Backdrop( tlw, "fill", nil, nil, nil, false )
            tlw.preview:SetAnchorFill()
            tlw.previewLabel = UI.Label( tlw.preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", v[1], false )
            tlw:SetHandler( "OnMoveStop", function(self)
                LUIE.SV[self.customPositionAttr] = { self:GetLeft(), self:GetTop() }
                LUIE.SetElementPosition()
            end)
            g_LUIE_Movers[tlw.customPositionAttr] = tlw
        end
        tlw = g_LUIE_Movers[k:GetName()]
        tlw:SetMouseEnabled ( state )
        tlw:SetMovable ( state )
        tlw:SetHidden( not state )
    end
    if firstRun then
        -- Register scene updates to hide elements when entering the menu settings.
        local scene = sceneManager:GetScene("gameMenuInGame")
        scene:RegisterCallback("StateChange", sceneChange)
    end
    firstRun = false
end

-- Reset position of windows. Called from Settings Menu.
function LUIE.ResetElementPosition()
    for k,v in pairs(defaultPanels) do
        local frameName = k:GetName()
        LUIE.SV[frameName] = nil
    end
    ReloadUI()
end
