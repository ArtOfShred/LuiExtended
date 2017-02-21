------------------
-- InfoPanel namespace
LUIE.InfoPanel = {}

local colors = {
    RED         = { r = 1    , g = 0    , b = 0    },
    GREEN       = { r = 0    , g = 1    , b = 0    },
    BLUE        = { r = 0    , g = 0    , b = 1    },
    YELLOW      = { r = 1    , g = 1    , b = 0    },
    WHITE       = { r = 1    , g = 1    , b = 1    },
    BLACK       = { r = 0    , g = 0    , b = 0    },
    GRAY        = { r = 0.5  , g = 0.5  , b = 0.5  },
}

-- Performance Enhancement
local PNL           = LUIE.InfoPanel
local UI            = LUIE.UI
local DelayBuffer   = LUIE.DelayBuffer
local strformat     = string.format

local moduleName    = LUIE.name .. '_InfoPanel'
local fakeControl   = {}

PNL.Enabled = false
PNL.SV      = nil

PNL.panelUnlocked = false

-- UI elements
local g_infoPanelFont = '/LuiExtended/media/fonts/ProFontWindows.ttf|9|soft-shadow-thin'

local uiPanel  = nil
local uiTopRow = nil
local uiBotRow = nil

local uiLatency = {
    colour = {
        [1] = { ping = 50, colour = colors.WHITE },
        [2] = { ping = 99, colour = colors.YELLOW },
        [3] = {            colour = colors.RED },
    },
}
local uiClock = {}
local uiFps = {
    colour = {
        [1] = { fps = 25, colour = colors.RED },
        [2] = { fps = 55, colour = colors.YELLOW },
        [3] = {           colour = colors.GREEN },
    },
}

local uiFeedTimer = {
    hideLocally = false,
}
local uiArmour = {
    colour = {
        [1] = { dura = 50, colour = colors.RED,    iconcolour = colors.RED },
        [2] = { dura = 80, colour = colors.YELLOW, iconcolour = colors.YELLOW },
        [2] = { dura = 95, colour = colors.GREEN,  iconcolour = colors.WHITE },
        [3] = {            colour = colors.WHITE,  iconcolour = colors.WHITE },
    },
}
local uiWeapons = {
    colour = {
        [1] = { charges = 5,  colour = colors.RED },
        [2] = { charges = 33, colour = colors.YELLOW },
        [3] = {               colour = colors.WHITE },
    },
}
local uiGems = {}
local uiBags = {
    colour = {
        [1] = { fill = 50, colour = colors.WHITE },
        [2] = { fill = 90, colour = colors.YELLOW },
        [3] = {            colour = colors.RED },
    },
}
local uiTrophy = {}
local uiTrophyIcons = {
    '/esoui/art/icons/quest_boneshard.dds',
    '/esoui/art/icons/quest_darkether.dds',
    '/esoui/art/icons/quest_markofthelegion.dds',
    '/esoui/art/icons/quest_planararmor.dds',
    '/esoui/art/icons/quest_tinyclaw.dds',
    '/esoui/art/icons/quest_tooth.dds',
}

local function CreateUIControls()
    uiPanel = UI.TopLevel( nil, {240,48})
    --uiPanel.bg = UI.Backdrop( uiPanel, "fill", nil, nil, nil, false )

    uiPanel.div = UI.Texture( uiPanel, nil, nil, "/esoui/art/miscellaneous/horizontaldivider.dds", DL_BACKGROUND, false )
    uiPanel.div:SetAnchor( LEFT, uiPanel, LEFT, -60, 0 )
    uiPanel.div:SetAnchor( RIGHT, uiPanel, RIGHT, 60, 0 )
    uiPanel.div:SetHeight(4)

    uiPanel.div2 = UI.Texture( uiPanel, nil, nil, "/esoui/art/miscellaneous/horizontaldivider.dds", DL_BACKGROUND, false )
    uiPanel.div2:SetAnchor( LEFT, uiPanel, BOTTOMLEFT, -60, 0 )
    uiPanel.div2:SetAnchor( RIGHT, uiPanel, BOTTOMRIGHT, 60, 0 )
    uiPanel.div2:SetHeight(4)

    uiTopRow = UI.Control( uiPanel, {TOP,TOP,0,2}, {300,20}, false )
    --uiTopRow.bg = UI.Backdrop( uiTopRow, "fill", nil, nil, nil, false )

    uiBotRow = UI.Control( uiPanel, {BOTTOM,BOTTOM,0,-2}, {300,20}, false )
    --uiBotRow.bg = UI.Backdrop( uiBotRow, "fill", nil, nil, nil, false )

    uiTroRow = UI.Control( uiPanel, {TOP,BOTTOM,0,2}, {300,20}, false )
    --uiTroRow.bg = UI.Backdrop( uiTroRow, "fill", nil, nil, nil, false )

    uiLatency.control = UI.Control( uiTopRow, nil, {80,20}, false )
    uiLatency.icon = UI.Texture( uiLatency.control, {LEFT,LEFT}, {24,24}, "/esoui/art/campaign/campaignbrowser_hipop.dds", nil, false )
    uiLatency.label = UI.Label( uiLatency.control, {LEFT,RIGHT,0,0,uiLatency.icon}, {56,20}, {0,1}, g_infoPanelFont, "11999 ms", false )
    --uiLatency.bg = UI.Backdrop( uiLatency.control, "fill", nil, nil, nil, false )

    uiClock.label = UI.Label( uiTopRow, nil, {60,20}, {1,1}, g_infoPanelFont, "88:88:88", false )
    uiClock.control = uiClock.label
    --uiClock.bg = UI.Backdrop( uiClock.control, "fill", nil, nil, nil, false )

    uiFps.label = UI.Label( uiTopRow, nil, {66,20}, {1,1}, g_infoPanelFont, "999.9 fps", false )
    uiFps.control = uiFps.label
    --uiFps.bg = UI.Backdrop( uiFps.control, "fill", nil, nil, nil, false )

    uiGems.control = UI.Control( uiTopRow, nil, {48,20}, false )
    uiGems.icon = UI.Texture( uiGems.control, {LEFT,LEFT}, {16,16}, nil, nil, false )
    uiGems.label = UI.Label( uiGems.control, {LEFT,RIGHT,0,0,uiGems.icon}, {32,20}, {0,1}, g_infoPanelFont, "8/88", false )
    --uiGems.bg = UI.Backdrop( uiGems.control, "fill", nil, nil, nil, false )

    uiFeedTimer.control = UI.Control( uiBotRow, nil, {84,20}, false )
    uiFeedTimer.icon = UI.Texture( uiFeedTimer.control, {LEFT,LEFT}, {28,28}, "/esoui/art/mounts/tabicon_mounts_up.dds", nil, false )
    uiFeedTimer.label = UI.Label( uiFeedTimer.control, {LEFT,RIGHT,0,0,uiFeedTimer.icon}, {56,20}, {0,1}, g_infoPanelFont, "Feed Now", false )
    --uiFeedTimer.bg = UI.Backdrop( uiFeedTimer.control, "fill", nil, nil, nil, false )

    uiArmour.control = UI.Control( uiBotRow, nil, {55,20}, false )
    uiArmour.icon = UI.Texture( uiArmour.control, {LEFT,LEFT}, {24,24}, "/esoui/art/progression/progression_indexicon_armor_up.dds", nil, false )
    uiArmour.label = UI.Label( uiArmour.control, {LEFT,RIGHT,0,0,uiArmour.icon}, {31,20}, {0,1}, g_infoPanelFont, "100%", false )
    --uiArmour.bg = UI.Backdrop( uiArmour.control, "fill", nil, nil, nil, false )

    uiWeapons.control = UI.Control( uiBotRow, nil, {36,20}, false )
    uiWeapons.main = UI.Texture( uiWeapons.control, {LEFT,LEFT,-5},  {30,30}, "/esoui/art/progression/icon_1handplusrune.dds", nil, false )
    uiWeapons.swap = UI.Texture( uiWeapons.control, {RIGHT,RIGHT,5}, {30,30}, "/esoui/art/progression/icon_1handplusrune.dds", nil, false )
    uiWeapons.main.slotIndex = EQUIP_SLOT_MAIN_HAND
    uiWeapons.swap.slotIndex = EQUIP_SLOT_BACKUP_MAIN
    --uiWeapons.bg = UI.Backdrop( uiWeapons.control, "fill", nil, nil, nil, false )

    uiBags.control = UI.Control( uiBotRow, nil, {78,20}, false )
    uiBags.icon = UI.Texture( uiBags.control, {LEFT,LEFT}, {28,28}, "/esoui/art/inventory/inventory_tabicon_misc_up.dds", nil, false )
    uiBags.label = UI.Label( uiBags.control, {LEFT,RIGHT,0,0,uiBags.icon}, {50,20}, {0,1}, g_infoPanelFont, "888/888", false )
    --uiBags.bg = UI.Backdrop( uiBags.control, "fill", nil, nil, nil, false )

    local trophiesControls = {}
    for i, iconName in ipairs(uiTrophyIcons) do
        local control = UI.Control( uiTroRow, nil, {39,20}, false )
        local icon    = UI.Texture( control, {LEFT,LEFT}, {20,20}, iconName, nil, false )
        local label   = UI.Label( control, {LEFT,RIGHT,0,0,icon}, nil, {0,1}, g_infoPanelFont, "WWW", false )
        --label.bg      = UI.Backdrop( control, "fill", nil, nil, nil, false )
        uiTrophy[iconName] = label
        trophiesControls[i] = control
    end
    -- manually anchor contols, so that it stays behaves properly on scaling
    trophiesControls[3]:SetAnchor(RIGHT, uiTroRow, CENTER)
    trophiesControls[2]:SetAnchor(RIGHT, trophiesControls[3], LEFT)
    trophiesControls[1]:SetAnchor(RIGHT, trophiesControls[2], LEFT)
    trophiesControls[4]:SetAnchor(LEFT, uiTroRow, CENTER)
    trophiesControls[5]:SetAnchor(LEFT, trophiesControls[4], RIGHT)
    trophiesControls[6]:SetAnchor(LEFT, trophiesControls[5], RIGHT)
end

--[[
 * Rearranges panel elements. Called from Initialize and settings menu.
 ]]--
function PNL.RearrangePanel()
    if not PNL.Enabled then return end

    -- reset scale of panel
    uiPanel:SetScale(1)

    -- top row
    local anchor = nil
    local size = 0

    -- latency
    if PNL.SV.HideLatency then
        uiLatency.control:SetHidden(true)
    else
        uiLatency.control:ClearAnchors()
        uiLatency.control:SetAnchor( LEFT, anchor or uiTopRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiLatency.control:SetHidden(false)
        size = size + uiLatency.control:GetWidth()
        anchor = uiLatency.control
    end

    -- time
    if PNL.SV.HideClock then
        uiClock.control:SetHidden(true)
    else
        uiClock.control:ClearAnchors()
        uiClock.control:SetAnchor( LEFT, anchor or uiTopRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiClock.control:SetHidden(false)
        size = size + uiClock.control:GetWidth()
        anchor = uiClock.control
    end

    -- fps
    if PNL.SV.HideFPS then
        uiFps.control:SetHidden(true)
    else
        uiFps.control:ClearAnchors()
        uiFps.control:SetAnchor( LEFT, anchor or uiTopRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiFps.control:SetHidden(false)
        size = size + uiFps.control:GetWidth()
        anchor = uiFps.control
    end

    -- soulgems
    if PNL.SV.HideGems then
        uiGems.control:SetHidden(true)
    else
        uiGems.control:ClearAnchors()
        uiGems.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiGems.control:SetHidden(false)
        size = size + uiGems.control:GetWidth()
        anchor = uiGems.control
    end

    -- set row size
    uiTopRow:SetWidth( ( size > 0 ) and size or 10 )

    -- bottom row
    local anchor = nil
    local size = 0

    -- feed timer
    if PNL.SV.HideMountFeed or uiFeedTimer.hideLocally then
        uiFeedTimer.control:SetHidden(true)
    else
        uiFeedTimer.control:ClearAnchors()
        uiFeedTimer.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiFeedTimer.control:SetHidden(false)
        size = size + uiFeedTimer.control:GetWidth()
        anchor = uiFeedTimer.control
    end

    -- durability
    if PNL.SV.HideArmour then
        uiArmour.control:SetHidden(true)
    else
        uiArmour.control:ClearAnchors()
        uiArmour.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiArmour.control:SetHidden(false)
        size = size + uiArmour.control:GetWidth()
        anchor = uiArmour.control
    end

    -- charges
    if PNL.SV.HideWeapons then
        uiWeapons.control:SetHidden(true)
    else
        uiWeapons.control:ClearAnchors()
        uiWeapons.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiWeapons.control:SetHidden(false)
        size = size + uiWeapons.control:GetWidth()
        anchor = uiWeapons.control
    end

    -- bags
    if PNL.SV.HideBags then
        uiBags.control:SetHidden(true)
    else
        uiBags.control:ClearAnchors()
        uiBags.control:SetAnchor( LEFT, anchor or uiBotRow, ( anchor == nil ) and LEFT or RIGHT, 0, 0 )
        uiBags.control:SetHidden(false)
        size = size + uiBags.control:GetWidth()
        anchor = uiBags.control
    end

    -- set row size
    uiBotRow:SetWidth( ( size > 0 ) and size or 10 )

    -- last bottom Trophy row
    uiPanel.div2:SetHidden(not PNL.SV.ShowTrophy)
    uiTroRow:SetHidden(not PNL.SV.ShowTrophy)
    if PNL.SV.ShowTrophy then
        --todo
    end

    -- set size of panel
    uiPanel:SetWidth( math.max( uiTopRow:GetWidth(), uiBotRow:GetWidth(), 39*6 ) )

    -- set scale of panel again
    PNL.SetScale()
end

function PNL.Initialize( enabled )
    -- load settings
    PNL.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, 'InfoPanel' )

    -- if User does not want the InfoPanel then exit right here
    if not enabled then return end

    PNL.Enabled = true

    CreateUIControls()
    PNL.RearrangePanel()

    -- add control to global list so it can be hidden
    LUIE.components[ moduleName ] = uiPanel
    LUIE.components[ moduleName .. '_FakeControl' ] = fakeControl

    -- panel position
    if PNL.SV.position ~= nil and #PNL.SV.position == 2 then
        uiPanel:SetAnchor( CENTER, GuiRoot, TOPLEFT, PNL.SV.position[1], PNL.SV.position[2] )
    else
        uiPanel:SetAnchor(TOPRIGHT, GuiRoot, TOPRIGHT, -24, 20)
    end

    -- dragging
    uiPanel.OnMoveStop = function(self) PNL.SV.position = { self:GetCenter() } end
    uiPanel:SetHandler( 'OnMoveStop',  uiPanel.OnMoveStop )

    -- set init values
    -- uiWorld.label:SetText( GetWorldName() )
    PNL.OnUpdate01()
    PNL.OnUpdate10()
    PNL.OnUpdate60()

    -- set event handlers
    EVENT_MANAGER:RegisterForEvent( moduleName, EVENT_LOOT_RECEIVED,                PNL.OnBagUpdate )
    EVENT_MANAGER:RegisterForEvent( moduleName, EVENT_INVENTORY_SINGLE_SLOT_UPDATE, PNL.OnBagUpdate )
    EVENT_MANAGER:RegisterForUpdate( moduleName .. '01' , 1000,  PNL.OnUpdate01 )
    EVENT_MANAGER:RegisterForUpdate( moduleName .. '10' , 10000, PNL.OnUpdate10 )
    EVENT_MANAGER:RegisterForUpdate( moduleName .. '60' , 60000, PNL.OnUpdate60 )
end

function PNL.ResetPosition()
    PNL.SV.position = nil
    if not PNL.Enabled then return end
    uiPanel:ClearAnchors()
    uiPanel:SetAnchor(TOPRIGHT, GuiRoot, TOPRIGHT, -24, 20)
end

--[[
 * Unlock panel for moving. Called from Settings Menu.
 ]]--
function PNL.SetMovingState( state )
    if not PNL.Enabled then return end
    PNL.panelUnlocked = state
    uiPanel:SetMouseEnabled( state )
    uiPanel:SetMovable( state )
end

--[[
 * Set scale of Info Panel. Called from Settings Menu.
 ]]--
function PNL.SetScale()
    if not PNL.Enabled then return end
    uiPanel:SetScale( PNL.SV.panelScale and PNL.SV.panelScale/100 or 1 )
    uiPanel:SetHidden(false)
end

--[[
 * Fake Component callback function used by main module
 ]]--
function fakeControl.SetHidden(self, hidden)
    -- update not more then once every 5 second
    if not hidden and DelayBuffer( 'InfoPanelFakeControl', 5000 ) then
        PNL.OnUpdate60()
    end
end

--[[
 * Listens to EVENT_INVENTORY_SINGLE_SLOT_UPDATE and EVENT_LOOT_RECEIVED
 ]]--
function PNL.OnBagUpdate()
    -- We shall not execute bags size calculation immediately, but rather set a flag with delay function
    -- This is needed to avoid lockups when the game start flooding us with same event for every bag slot used
    -- While we do not need any good latency, we can afford to update info-panel label with 250ms delay

    EVENT_MANAGER:RegisterForUpdate(moduleName .. '_PendingBagsUpdate', 250, PNL.DoBagUpdate )
end

--[[
 * Performs calculation of empty space in bags
 * Called with delay by corresponding event listener
 ]]--
function PNL.DoBagUpdate()

    -- clear pending event
    EVENT_MANAGER:UnregisterForUpdate(moduleName .. '_PendingBagsUpdate')

    -- update bags
    local bagSize = GetBagSize( BAG_BACKPACK )
    local bagUsed = GetNumBagUsedSlots( BAG_BACKPACK )

    local filledSlotPercentage = ( bagUsed / bagSize ) * 100
    local colour = uiBags.colour[#uiBags.colour].colour
    if bagSize - bagUsed > 10 then
        for i = 1, #uiBags.colour-1 do
            if filledSlotPercentage < uiBags.colour[i].fill then
                colour = uiBags.colour[i].colour
                break
            end
        end
    end
    uiBags.label:SetText( strformat( '%d/%d', bagUsed, bagSize ) )
    uiBags.label:SetColor( colour.r, colour.g, colour.b, 1 )

    -- update soulgems
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

    -- scan for trophies
    if PNL.SV.ShowTrophy then
        local tro = {}
        for slotIndex = 0, GetBagSize( BAG_BACKPACK ) - 1 do
            if GetItemType(BAG_BACKPACK, slotIndex) == ITEMTYPE_TROPHY then
                local icon, stack = GetItemInfo(BAG_BACKPACK, slotIndex)
                if uiTrophy[icon] then
                    tro[icon] = tro[icon] and (tro[icon] + stack) or stack
                end
            end
        end
        -- update labels
        for icon, label in pairs(uiTrophy) do
            -- DEBUG tro[icon] = 1999
            local count = tro[icon] and (tro[icon] > 999 and 999 or tro[icon]) or 0
            label:SetText( count )
            if count >= 60 then
                label:SetColor(0,1,0)
            else
                label:SetColor(1,1,1)
            end
        end
    end
end

function PNL.OnUpdate01()
    -- update time
    uiClock.label:SetText( GetTimeString() )

    -- update fps
    local fps = GetFramerate()
    local colour = colors.WHITE
    if not PNL.SV.DisableInfoColours then
        colour = uiFps.colour[#uiFps.colour].colour
        for i = 1, #uiFps.colour-1 do
            if fps < uiFps.colour[i].fps then
                colour = uiFps.colour[i].colour
                break
            end
        end
    end
    uiFps.label:SetText( strformat( '%.1f fps', fps ) )
    uiFps.label:SetColor( colour.r, colour.g, colour.b, 1 )
end

function PNL.OnUpdate10()
    -- update latency
    local lat = GetLatency()
    local colour = colors.WHITE
    if not PNL.SV.DisableInfoColours then
        colour = uiLatency.colour[#uiLatency.colour].colour
        for i = 1, #uiLatency.colour-1 do
            if lat < uiLatency.colour[i].ping then
                colour = uiLatency.colour[i].colour
                break
            end
        end
    end
    uiLatency.label:SetText( strformat( '%d ms', lat ) )
    uiLatency.label:SetColor( colour.r, colour.g, colour.b, 1 )
end

function PNL.OnUpdate60()
    -- update mountfeedtimer
    if not PNL.SV.HideMountFeed and not uiFeedTimer.hideLocally then
        local mountFeedTimer, mountFeedTotalTime = GetTimeUntilCanBeTrained()
        local mountFeedMessage = 'Maxed'
        if ( mountFeedTimer ~= nil ) then
            if ( mountFeedTimer == 0 ) then
                local inventoryBonus, maxInventoryBonus, staminaBonus, maxStaminaBonus, speedBonus, maxSpeedBonus = GetRidingStats()
                if inventoryBonus ~= maxInventoryBonus or staminaBonus ~= maxStaminaBonus or speedBonus ~= maxSpeedBonus then
                    mountFeedMessage = 'Feed now'
                else
                    uiFeedTimer.hideLocally = true
                    PNL.RearrangePanel()
                end
            elseif ( mountFeedTimer > 0 ) then
                local hours   = math.floor( mountFeedTimer / 3600000 )
                local minutes = math.floor( ( mountFeedTimer - ( hours * 3600000 ) ) / 60000 )
                mountFeedMessage = strformat( '%dh %dm', hours, minutes )
            end
        end
        uiFeedTimer.label:SetText( mountFeedMessage )
    end

    -- update item durability
    if not PNL.SV.HideArmour then
        local slotCount    = 0
        local duraSum      = 0
        local totalSlots = GetBagSize( BAG_WORN )
        for slotNum = 0, totalSlots - 1 do
            if ( DoesItemHaveDurability( BAG_WORN, slotNum ) == true ) then
                duraSum = duraSum + GetItemCondition( BAG_WORN, slotNum )
                slotCount = slotCount + 1
            end
        end
        local duraPercentage = ( slotCount == 0 ) and 0 or duraSum / slotCount
        local colour = uiArmour.colour[#uiArmour.colour].colour
        local iconcolour = uiArmour.colour[#uiArmour.colour].iconcolour
        for i = 1, #uiArmour.colour-1 do
            if duraPercentage < uiArmour.colour[i].dura then
                colour = uiArmour.colour[i].colour
                iconcolour = uiArmour.colour[i].iconcolour
                break
            end
        end
        uiArmour.label:SetText( strformat( '%d%%', duraPercentage ) )
        uiArmour.label:SetColor( colour.r, colour.g, colour.b, 1 )
        uiArmour.icon:SetColor( iconcolour.r, iconcolour.g, iconcolour.b, 1 )
    end

    -- get charges information
    if not PNL.SV.HideWeapons then
        for _, icon in pairs( { uiWeapons.main, uiWeapons.swap } ) do
            local charges, maxCharges = GetChargeInfoForItem( BAG_WORN, icon.slotIndex)
            local colour = colors.GRAY
            if maxCharges > 0 then
                colour = uiWeapons.colour[#uiWeapons.colour].colour
                local chargesPercentage = 100 * charges / maxCharges
                for i = 1, #uiWeapons.colour-1 do
                    if chargesPercentage < uiWeapons.colour[i].charges then
                        colour = uiWeapons.colour[i].colour
                        break
                    end
                end
            end
            icon:SetColor( colour.r, colour.g, colour.b, 1 )
        end
    end

    -- update bag slot count
    PNL.DoBagUpdate()
end
