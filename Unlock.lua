--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local UI = LUIE.UI

local WM = GetWindowManager()

local firstRun = true
local savedHiddenStates = { }

-- Table of UI elements to unlock for moving.
-- Constraints for some of these elements need to be adjusted - using values from Azurah.
local defaultPanels = {
    --[ZO_HUDInfamyMeter]	= { "Infamy Meter" },
    --[ZO_HUDTelvarMeter]	= { "Tel Var Meter" },
    --[ZO_HUDDaedricEnergyMeter] = { "Volendrung Meter" },
    [ZO_HUDEquipmentStatus]	= { GetString(SI_LUIE_DEFAULT_FRAME_EQUIPMENT_STATUS) },
    [ZO_FocusedQuestTrackerPanel] = { GetString(SI_LUIE_DEFAULT_FRAME_QUEST_LOG), nil, 200 },
    [ZO_LootHistoryControl_Keyboard] = { GetString(SI_LUIE_DEFAULT_FRAME_LOOT_HISTORY), 280, 400 },
    [ZO_BattlegroundHUDFragmentTopLevel] = { GetString(SI_LUIE_DEFAULT_FRAME_BATTLEGROUND_SCORE) },
}

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
    for k,v in pairs(defaultPanels) do
        if firstRun then
            -- Clamp these elements to screen so we can't drag them off
            k:SetClampedToScreen ( true )
            -- Adjust constraints so we can move elements.
            if v[2] then
				k:SetWidth(v[2])
            end
            if v[3] then
                k:SetHeight(v[3])
            end
            k.customPositionAttr = k:GetName()
            k.preview = UI.Backdrop( k, "fill", nil, nil, nil, false )
            k.preview:SetDrawLayer(DL_OVERLAY)
            k.preview:SetDrawLevel(3)
            k.preview:SetDrawTier(DT_HIGH)
            k.previewLabel = UI.Label( k.preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", v[1], false )
            k.previewLabel:SetDrawLayer(DL_OVERLAY)
            k.previewLabel:SetDrawLevel(4)
            k.previewLabel:SetDrawTier(DT_HIGH)
            k:SetHandler( "OnMoveStop", function(self)
                LUIE.SV[self.customPositionAttr] = { self:GetLeft(), self:GetTop() }
            end)
        end
        k:SetMouseEnabled ( state )
        k:SetMovable ( state )
        k.preview:SetHidden( not state )
        if state == false then
            if savedHiddenStates[k.customPositionAttr] then
                k:SetHidden ( savedHiddenStates[k.customPositionAttr] )
            end
        else
            savedHiddenStates[k.customPositionAttr] = k:IsHidden()
            k:SetHidden ( false )
        end
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
