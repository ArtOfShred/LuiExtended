--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- InfoPanel namespace
LUIE.InfoPanel = {}
local InfoPanel = LUIE.InfoPanel

local UI = LUIE.UI

local eventManager = EVENT_MANAGER
local sceneManager = SCENE_MANAGER

local moduleName = LUIE.name .. "InfoPanel"

local colors = {
    RED         = { r = 1    , g = 0    , b = 0    },
    GREEN       = { r = 0    , g = 1    , b = 0    },
    BLUE        = { r = 0    , g = 0    , b = 1    },
    YELLOW      = { r = 1    , g = 1    , b = 0    },
    WHITE       = { r = 1    , g = 1    , b = 1    },
    BLACK       = { r = 0    , g = 0    , b = 0    },
    GRAY        = { r = 0.5  , g = 0.5  , b = 0.5  },
}

--local fakeControl   = {}

InfoPanel.Enabled = false
InfoPanel.SV = nil
InfoPanel.panelUnlocked = false

-- UI elements
local infoPanelFontFace = "/EsoUI/Common/Fonts/Univers67.otf"
local infoPanelFontSize = 16
local infoPanelFontStyle = "soft-shadow-thin"
local g_infoPanelFont = string.format( "%s|%d|%s", infoPanelFontFace, infoPanelFontSize, infoPanelFontStyle )

local uiPanel = nil
local uiTopRow = nil
local uiBotRow = nil
local uiClock  = {}
local uiGems   = {}

-- Add info panel into LUIE namespace
InfoPanel.Panel = uiPanel

local uiLatency = {
    color = {
        [1] = { ping = 100, color = colors.GREEN },
        [2] = { ping = 200, color = colors.YELLOW },
        [3] = {            color = colors.RED },
    },
}

local uiFps = {
    color = {
        [1] = { fps = 25, color = colors.RED },
        [2] = { fps = 40, color = colors.YELLOW },
        [3] = {           color = colors.GREEN },
    },
}

local uiFeedTimer = {
    hideLocally = false,
}

local uiArmour = {
    color = {
        [1] = { dura = 25, color = colors.RED,    iconcolour = colors.WHITE },
        [2] = { dura = 50, color = colors.YELLOW, iconcolour = colors.WHITE },
        [3] = {            color = colors.GREEN,  iconcolour = colors.WHITE },
    },
}

local uiWeapons = {
    color = {
        [1] = { charges = 10,  color = colors.RED },
        [2] = { charges = 25, color = colors.YELLOW },
        [3] = {               color = colors.WHITE },
    },
}

local uiBags = {
    color = {
        [1] = { fill = 70, color = colors.WHITE },
        [2] = { fill = 90, color = colors.YELLOW },
        [3] = {            color = colors.RED },
    },
}

local delayBuffer = {}
-- Delay Buffer
local function DelayBuffer(key, buffer, currentTime)
    if key == nil then
        return
    end

    local buffer = buffer or 10
    local now    = currentTime or GetFrameTimeMilliseconds()

    if delayBuffer[key] == nil then
        delayBuffer[key] = now
        return true -- For first call of DelayBuffer we should return true
    end
    local eval = ( now - delayBuffer[key] ) >= buffer
    if eval then
        delayBuffer[key] = now
    end
    return eval
end

local panelFragment

function InfoPanel.SetDisplayOnMap()
    if InfoPanel.SV.DisplayOnWorldMap then
        sceneManager:GetScene("worldMap"):AddFragment( panelFragment )
    else
        sceneManager:GetScene("worldMap"):RemoveFragment( panelFragment )
    end
end

local function CreateUIControls()
    uiPanel = UI.TopLevel( nil, {240,48})
    uiPanel:SetDrawLayer(DL_BACKDROP)
    uiPanel:SetDrawTier(DT_LOW)
    uiPanel:SetDrawLevel(1)
    --uiPanel.bg = UI.Backdrop( uiPanel, "fill", nil, nil, nil, false )

    panelFragment = ZO_HUDFadeSceneFragment:New(uiPanel, 0, 0)

    sceneManager:GetScene("hud"):AddFragment( panelFragment )
    sceneManager:GetScene("hudui"):AddFragment( panelFragment )
    sceneManager:GetScene("siegeBar"):AddFragment( panelFragment )
    sceneManager:GetScene("siegeBarUI"):AddFragment( panelFragment )

    InfoPanel.SetDisplayOnMap() -- Add to map scene if the option is enabled.

    uiPanel.div = UI.Texture( uiPanel, nil, nil, "/esoui/art/miscellaneous/horizontaldivider.dds", DL_BACKGROUND, false )
    uiPanel.div:SetAnchor( LEFT, uiPanel, LEFT, -60, 0 )
    uiPanel.div:SetAnchor( RIGHT, uiPanel, RIGHT, 60, 0 )
    uiPanel.div:SetHeight(4)

    uiTopRow = UI.Control( uiPanel, {TOP,TOP,0,2}, {300,20}, false )
    --uiTopRow.bg = UI.Backdrop( uiTopRow, "fill", nil, nil, nil, false )

    uiBotRow = UI.Control( uiPanel, {BOTTOM,BOTTOM,0,-2}, {300,20}, false )
    --uiBotRow.bg = UI.Backdrop( uiBotRow, "fill", nil, nil, nil, false )

    uiLatency.control = UI.Control( uiTopRow, nil, {75,20}, false )
    uiLatency.icon = UI.Texture( uiLatency.control, {LEFT,LEFT}, {24,24}, "/esoui/art/campaign/campaignbrowser_hipop.dds", nil, false )
    uiLatency.label = UI.Label( uiLatency.control, {LEFT,RIGHT,0,0,uiLatency.icon}, {56,20}, {0,1}, g_infoPanelFont, "11999 ms", false )
    --uiLatency.bg = UI.Backdrop( uiLatency.control, "fill", nil, nil, nil, false )

    uiFps.label = UI.Label( uiTopRow, nil, {50,20}, {1,1}, g_infoPanelFont, "999 fps", false )
    uiFps.control = uiFps.label
    --uiFps.bg = UI.Backdrop( uiFps.control, "fill", nil, nil, nil, false )

    uiClock.label = UI.Label( uiTopRow, nil, {60,20}, {1,1}, g_infoPanelFont, "88:88:88", false )
    uiClock.control = uiClock.label
    --uiClock.bg = UI.Backdrop( uiClock.control, "fill", nil, nil, nil, false )

    uiGems.control = UI.Control( uiTopRow, nil, {48,20}, false )
    uiGems.icon = UI.Texture( uiGems.control, {LEFT,LEFT}, {16,16}, nil, nil, false )
    uiGems.label = UI.Label( uiGems.control, {LEFT,RIGHT,2,0,uiGems.icon}, {32,20}, {0,1}, g_infoPanelFont, "8/88", false )
    --uiGems.bg = UI.Backdrop( uiGems.control, "fill", nil, nil, nil, false )

    uiFeedTimer.control = UI.Control( uiBotRow, nil, {96,20}, false )
    uiFeedTimer.icon = UI.Texture( uiFeedTimer.control, {LEFT,LEFT}, {28,28}, "/esoui/art/mounts/tabicon_mounts_up.dds", nil, false )
    uiFeedTimer.label = UI.Label( uiFeedTimer.control, {LEFT,RIGHT,0,0,uiFeedTimer.icon}, {68,20}, {0,1}, g_infoPanelFont, GetString(SI_LUIE_PNL_TRAINNOW), false )
    --uiFeedTimer.bg = UI.Backdrop( uiFeedTimer.control, "fill", nil, nil, nil, false )

    uiArmour.control = UI.Control( uiBotRow, nil, {55,20}, false )
    uiArmour.icon = UI.Texture( uiArmour.control, {LEFT,LEFT}, {24,24}, "/esoui/art/progression/progression_indexicon_armor_up.dds", nil, false )
    uiArmour.label = UI.Label( uiArmour.control, {LEFT,RIGHT,0,0,uiArmour.icon}, {41,20}, {0,1}, g_infoPanelFont, "100%", false )
    --uiArmour.bg = UI.Backdrop( uiArmour.control, "fill", nil, nil, nil, false )

    uiWeapons.control = UI.Control( uiBotRow, nil, {46,20}, false )
    uiWeapons.main = UI.Texture( uiWeapons.control, {LEFT,LEFT},  {30,30}, "/esoui/art/progression/icon_1handplusrune.dds", nil, false )
    uiWeapons.swap = UI.Texture( uiWeapons.control, {RIGHT,RIGHT,5}, {30,30}, "/esoui/art/progression/icon_1handplusrune.dds", nil, false )
    uiWeapons.main.slotIndex = EQUIP_SLOT_MAIN_HAND
    uiWeapons.swap.slotIndex = EQUIP_SLOT_BACKUP_MAIN
    --uiWeapons.bg = UI.Backdrop( uiWeapons.control, "fill", nil, nil, nil, false )

    uiBags.control = UI.Control( uiBotRow, nil, {78,20}, false )
    uiBags.icon = UI.Texture( uiBags.control, {LEFT,LEFT}, {28,28}, "/esoui/art/inventory/inventory_tabicon_misc_up.dds", nil, false )
    uiBags.label = UI.Label( uiBags.control, {LEFT,RIGHT,0,0,uiBags.icon}, {50,20}, {0,1}, g_infoPanelFont, "888/888", false )
    --uiBags.bg = UI.Backdrop( uiBags.control, "fill", nil, nil, nil, false )
end

-- Rearranges panel elements. Called from Initialize and settings menu.
function InfoPanel.RearrangePanel()
    if not InfoPanel.Enabled then return end

    -- Reset scale of panel
    uiPanel:SetScale(1)

    -- Top row
    local anchor = nil
    local size = 0

    -- Latency
    if InfoPanel.SV.HideLatency then
        uiLatency.control:SetHidden(true)
    else
        uiLatency.control:ClearAnchors()
        uiLatency.control:SetAnchor( LEFT, anchor or uiTopRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiLatency.control:SetHidden(false)
        size = size + uiLatency.control:GetWidth()
        anchor = uiLatency.control
    end

    -- FPS
    if InfoPanel.SV.HideFPS then
        uiFps.control:SetHidden(true)
    else
        uiFps.control:ClearAnchors()
        uiFps.control:SetAnchor( LEFT, anchor or uiTopRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiFps.control:SetHidden(false)
        size = size + uiFps.control:GetWidth()
        anchor = uiFps.control
    end

    -- Time
    if InfoPanel.SV.HideClock then
        uiClock.control:SetHidden(true)
    else
        uiClock.control:ClearAnchors()
        uiClock.control:SetAnchor( LEFT, anchor or uiTopRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiClock.control:SetHidden(false)
        size = size + uiClock.control:GetWidth()
        anchor = uiClock.control
    end

    -- Soulgems
    if InfoPanel.SV.HideGems then
        uiGems.control:SetHidden(true)
    else
        uiGems.control:ClearAnchors()
        uiGems.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiGems.control:SetHidden(false)
        size = size + uiGems.control:GetWidth()
        anchor = uiGems.control
    end

    -- Set row size
    uiTopRow:SetWidth( ( size > 0 ) and size or 10 )

    -- Bottom row
    local anchor = nil
    local size = 0

    -- Feed timer
    if InfoPanel.SV.HideMountFeed or uiFeedTimer.hideLocally then
        uiFeedTimer.control:SetHidden(true)
        size = size - (uiFeedTimer.control:GetWidth() * .15)
    else
        uiFeedTimer.control:ClearAnchors()
        uiFeedTimer.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiFeedTimer.control:SetHidden(false)
        size = size + uiFeedTimer.control:GetWidth()
        anchor = uiFeedTimer.control
    end

    -- Durability
    if InfoPanel.SV.HideArmour then
        uiArmour.control:SetHidden(true)
    else
        uiArmour.control:ClearAnchors()
        uiArmour.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiArmour.control:SetHidden(false)
        size = size + uiArmour.control:GetWidth()
        anchor = uiArmour.control
    end

    -- Charges
    if InfoPanel.SV.HideWeapons then
        uiWeapons.control:SetHidden(true)
    else
        uiWeapons.control:ClearAnchors()
        uiWeapons.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiWeapons.control:SetHidden(false)
        size = size + uiWeapons.control:GetWidth()
        anchor = uiWeapons.control
    end

    -- Bags
    if InfoPanel.SV.HideBags then
        uiBags.control:SetHidden(true)
    else
        uiBags.control:ClearAnchors()
        uiBags.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiBags.control:SetHidden(false)
        size = size + uiBags.control:GetWidth()
        anchor = uiBags.control
    end

    -- Set row size
    uiBotRow:SetWidth( ( size > 0 ) and size or 10 )

    -- Set size of panel
    uiPanel:SetWidth( math.max( uiTopRow:GetWidth(), uiBotRow:GetWidth(), 39*6 ) )

    -- Set scale of panel again
    InfoPanel.SetScale()
    uiPanel:SetHidden(false)
end

function InfoPanel.Initialize(enabled)
    -- Load settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        InfoPanel.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, "InfoPanel", InfoPanel.Defaults)
    else
        InfoPanel.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, "InfoPanel", InfoPanel.Defaults)
    end

    -- Disable module if setting not toggled on
    if not enabled then
        return
    end
    InfoPanel.Enabled = true

    CreateUIControls()
    InfoPanel.RearrangePanel()

    -- add control to global list so it can be hidden
    LUIE.Components[moduleName] = uiPanel

    -- Panel position
    if InfoPanel.SV.position ~= nil and #InfoPanel.SV.position == 2 then
        uiPanel:SetAnchor( CENTER, GuiRoot, TOPLEFT, InfoPanel.SV.position[1], InfoPanel.SV.position[2] )
    else
        uiPanel:SetAnchor(TOPRIGHT, GuiRoot, TOPRIGHT, -24, 20)
    end

    -- Dragging
    uiPanel.OnMoveStop = function(self) InfoPanel.SV.position = { self:GetCenter() } end
    uiPanel:SetHandler( "OnMoveStop",  uiPanel.OnMoveStop )

    -- Set init values
    -- uiWorld.label:SetText( GetWorldName() )
    InfoPanel.OnUpdate01()
    InfoPanel.OnUpdate10()
    InfoPanel.OnUpdate60()

    -- Set event handlers
    eventManager:RegisterForEvent( moduleName, EVENT_LOOT_RECEIVED,                InfoPanel.OnBagUpdate )
    eventManager:RegisterForEvent( moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, InfoPanel.OnBagUpdate )
    eventManager:RegisterForUpdate( moduleName .. "01" , 1000,  InfoPanel.OnUpdate01 )
    eventManager:RegisterForUpdate( moduleName .. "10" , 10000, InfoPanel.OnUpdate10 )
    eventManager:RegisterForUpdate( moduleName .. "60" , 60000, InfoPanel.OnUpdate60 )
end

function InfoPanel.ResetPosition()
    InfoPanel.SV.position = nil
    if not InfoPanel.Enabled then
        return
    end
    uiPanel:ClearAnchors()
    uiPanel:SetAnchor(TOPRIGHT, GuiRoot, TOPRIGHT, -24, 20)
end

-- Unlock panel for moving. Called from Settings Menu.
function InfoPanel.SetMovingState( state )
    if not InfoPanel.Enabled then
        return
    end
    InfoPanel.panelUnlocked = state
    uiPanel:SetMouseEnabled( state )
    uiPanel:SetMovable( state )
    uiPanel:SetHidden ( false )
end

-- Set scale of Info Panel. Called from Settings Menu.
function InfoPanel.SetScale()
    if not InfoPanel.Enabled then
        return
    end
    uiPanel:SetScale( InfoPanel.SV.panelScale and InfoPanel.SV.panelScale/100 or 1 )
    uiPanel:SetHidden(false)
end

-- Fake Component callback function used by main module
--[[function fakeControl.SetHidden(self, hidden)
    -- update not more then once every 5 second
    if not hidden and DelayBuffer( "InfoPanelFakeControl", 5000 ) then
        InfoPanel.OnUpdate60()
    end
end]]--

-- Listens to EVENT_INVENTORY_SINGLE_SLOT_UPDATE and EVENT_LOOT_RECEIVED
function InfoPanel.OnBagUpdate()
    -- We shall not execute bags size calculation immediately, but rather set a flag with delay function
    -- This is needed to avoid lockups when the game start flooding us with same event for every bag slot used
    -- While we do not need any good latency, we can afford to update info-panel label with 250ms delay
    eventManager:RegisterForUpdate(moduleName .. "PendingBagsUpdate", 250, InfoPanel.DoBagUpdate )
end

-- Performs calculation of empty space in bags
-- Called with delay by corresponding event listener
function InfoPanel.DoBagUpdate()
    -- Clear pending event
    eventManager:UnregisterForUpdate(moduleName .. "PendingBagsUpdate")

    -- Update bags
    local bagSize = GetBagSize(BAG_BACKPACK)
    local bagUsed = GetNumBagUsedSlots(BAG_BACKPACK)

    local filledSlotPercentage = ( bagUsed / bagSize ) * 100
    local color = uiBags.color[#uiBags.color].color
    if bagSize - bagUsed > 10 then
        for i = 1, #uiBags.color-1 do
            if filledSlotPercentage < uiBags.color[i].fill then
                color = uiBags.color[i].color
                break
            end
        end
    end
    uiBags.label:SetText( string.format( "%d/%d", bagUsed, bagSize ) )
    uiBags.label:SetColor( color.r, color.g, color.b, 1 )

    -- Update soulgems
    local myLevel = GetUnitEffectiveLevel("player")
    local _, icon, emptyCount = GetSoulGemInfo(SOUL_GEM_TYPE_EMPTY, myLevel, true);
    local _, iconF, fullCount = GetSoulGemInfo(SOUL_GEM_TYPE_FILLED, myLevel, true);
    emptyCount = math.min( emptyCount, 99 )
    fullCount = math.min( fullCount, 9999 )
    local fullText = ( fullCount > 0 ) and ( "|c00FF00"..fullCount.."|r" ) or "|cFF00000|r"
    if iconF ~= nil and iconF ~= "" and iconF ~= "/esoui/art/icons/icon_missing.dds" then icon = iconF end
    if icon == "/esoui/art/icons/icon_missing.dds" then icon = "/esoui/art/icons/soulgem_001_empty.dds" end
    uiGems.icon:SetTexture( icon )
    uiGems.label:SetText( ( fullCount > 9 ) and fullText or ( fullText .. "/" .. emptyCount ) )
end

function InfoPanel.OnUpdate01()
    -- Update time
    uiClock.label:SetText( GetTimeString() )

    -- Update fps
    local fps = GetFramerate()
    local color = colors.WHITE
    if not InfoPanel.SV.DisableInfoColours then
        color = uiFps.color[#uiFps.color].color
        for i = 1, #uiFps.color-1 do
            if fps < uiFps.color[i].fps then
                color = uiFps.color[i].color
                break
            end
        end
    end
    uiFps.label:SetText( string.format( "%d fps", fps ) )
    uiFps.label:SetColor( color.r, color.g, color.b, 1 )
end

function InfoPanel.OnUpdate10()
    -- Update latency
    local lat = GetLatency()
    local color = colors.WHITE
    if not InfoPanel.SV.DisableInfoColours then
        color = uiLatency.color[#uiLatency.color].color
        for i = 1, #uiLatency.color-1 do
            if lat < uiLatency.color[i].ping then
                color = uiLatency.color[i].color
                break
            end
        end
    end
    uiLatency.label:SetText( string.format( "%d ms", lat ) )
    uiLatency.label:SetColor( color.r, color.g, color.b, 1 )
end

function InfoPanel.OnUpdate60()
    -- Update mountfeedtimer
    if not InfoPanel.SV.HideMountFeed and not uiFeedTimer.hideLocally then
        local mountFeedTimer, mountFeedTotalTime = GetTimeUntilCanBeTrained()
        local mountFeedMessage = GetString(SI_LUIE_PNL_MAXED)
        if ( mountFeedTimer ~= nil ) then
            if ( mountFeedTimer == 0 ) then
                local inventoryBonus, maxInventoryBonus, staminaBonus, maxStaminaBonus, speedBonus, maxSpeedBonus = GetRidingStats()
                if inventoryBonus ~= maxInventoryBonus or staminaBonus ~= maxStaminaBonus or speedBonus ~= maxSpeedBonus then
                    mountFeedMessage = GetString(SI_LUIE_PNL_TRAINNOW)
                else
                    uiFeedTimer.hideLocally = true
                    InfoPanel.RearrangePanel()
                end
            elseif ( mountFeedTimer > 0 ) then
                local hours   = math.floor( mountFeedTimer / 3600000 )
                local minutes = math.floor( ( mountFeedTimer - ( hours * 3600000 ) ) / 60000 )
                mountFeedMessage = string.format( "%dh %dm", hours, minutes )
            end
        end
        uiFeedTimer.label:SetText( mountFeedMessage )
    end

    -- Update item durability
    if not InfoPanel.SV.HideArmour then
        local slotCount    = 0
        local duraSum      = 0
        local totalSlots = GetBagSize(BAG_WORN)
        for slotNum = 0, totalSlots - 1 do
            if ( DoesItemHaveDurability(BAG_WORN, slotNum) == true ) then
                duraSum = duraSum + GetItemCondition(BAG_WORN, slotNum)
                slotCount = slotCount + 1
            end
        end
        local duraPercentage = ( slotCount == 0 ) and 0 or duraSum / slotCount
        local color = uiArmour.color[#uiArmour.color].color
        local iconcolour = uiArmour.color[#uiArmour.color].iconcolour
        for i = 1, #uiArmour.color-1 do
            if duraPercentage < uiArmour.color[i].dura then
                color = uiArmour.color[i].color
                iconcolour = uiArmour.color[i].iconcolour
                break
            end
        end
        uiArmour.label:SetText( string.format( "%d%%", duraPercentage ) )
        uiArmour.label:SetColor( color.r, color.g, color.b, 1 )
        uiArmour.icon:SetColor( iconcolour.r, iconcolour.g, iconcolour.b, 1 )
    end

    -- Get charges information
    if not InfoPanel.SV.HideWeapons then
        for _, icon in pairs( { uiWeapons.main, uiWeapons.swap } ) do
            local charges, maxCharges = GetChargeInfoForItem( BAG_WORN, icon.slotIndex)
            local color = colors.GRAY
            if maxCharges > 0 then
                color = uiWeapons.color[#uiWeapons.color].color
                local chargesPercentage = 100 * charges / maxCharges
                for i = 1, #uiWeapons.color-1 do
                    if chargesPercentage < uiWeapons.color[i].charges then
                        color = uiWeapons.color[i].color
                        break
                    end
                end
            end
            icon:SetColor( color.r, color.g, color.b, 1 )
        end
    end

    -- Update bag slot count
    InfoPanel.DoBagUpdate()
end
