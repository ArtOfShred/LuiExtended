------------------
-- Damage meter namespace
LUIE.DamageMeter = {}

-- Performance Enhancement
local DM = LUIE.DamageMeter
local UI = LUIE.UI
local E  = LUIE.Effects
local commaValue = LUIE.CommaValue
local formatMessage = LUIE.ChatAnnouncements.FormatMessage
local colours = LUIE.CombatInfo.Colours
local strfmt = string.format
local strformat = zo_strformat
local IsUnitInCombat = IsUnitInCombat
local tremove = table.remove
local tinsert = table.insert

local moduleName = LUIE.name .. '_DamageMeter'
local g_DamageMeterTitle = "LUIE Damage Meter"
local g_DamageGraphTitle = "LUIE Damage Log"
local g_NoRecord = "No Combat Recorded"

local fakeControl = {}

DM.Enabled = false
DM.D = {
	DamageTimeout = 5,
	UpdateFullRealtime = false,
	FightTime	= true,
	Backdrop	= true,
	CombatLog	= false,
	LogTimeStamp= true,
	CombatLogFocus = false,
	CombatLogDebuff = false,
	CombatLogFont = 0,
}
DM.DC = {
	LogSaveEnable = false,
	LogSaved = {},
}

local uiPanel
local uiMeter
local uiGraph
DM.panelUnlocked = false

local g_playerName
local g_Meter
local g_Targets
local g_Damages
local g_Heals
local g_TimelineCur

local g_CombatLogActivated = false

local fontPanelLabel = '/LuiExtended/assets/fontin_sans_r.otf|14|soft-shadow-thin'

ZO_CreateStringId("SI_BINDING_NAME_LUIE_DISPLAY_DAMAGE_METER", "Display Damage Meter")
ZO_CreateStringId("SI_BINDING_NAME_LUIE_DISPLAY_DAMAGE_LOG", "Display Damage Log")
ZO_CreateStringId("SI_BINDING_NAME_LUIE_POST_DAMAGE_RESULTS", "Post Damage Results")
ZO_CreateStringId("SI_BINDING_NAME_LUIE_POST_HEALING_RESULTS", "Post Healing Results")

function DM.Initialize( enabled )
	-- load settings
	DM.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, 'DamageMeter', DM.D )
	DM.SVC =           ZO_SavedVars:New( LUIE.SVName, LUIE.SVVer, 'DamageMeter', DM.DC ) 

	-- check for valid saved variables
	if tonumber(DM.SV.CombatLogFont) ~= DM.SV.CombatLogFont or DM.SV.CombatLogFont > 3 or DM.SV.CombatLogFont < -3 then
		DM.SV.CombatLogFont = DM.D.CombatLogFont
	end
	
	-- if User does not want the InfoPanel then exit right here
	if not enabled then return end

	DM.Enabled = true

	-- Read current player toon name
	g_playerName = GetRawUnitName('player')

	-- Create mini meter panel
	uiPanel = UI.TopLevel( nil, {290,34} )
	uiPanel.OnMoveStop = function(self) DM.SV.positionMini = { self:GetLeft(), self:GetTop() } end
	uiPanel:SetHandler( 'OnMoveStop', uiPanel.OnMoveStop )

	--uiPanel.backdrop = UI.Backdrop( uiPanel, "fill", nil, {0,0,0,0.2}, {0,0,0,0.1}, false )
	uiPanel.backdrop = UI.ChatBackdrop( uiPanel, "fill", nil, {0,0,0,0.4}, 8, false )

	uiPanel.dam = UI.Control( uiPanel, {LEFT,LEFT,10,0}, {70,30}, false )
	uiPanel.dam.icon = UI.Texture( uiPanel.dam, {LEFT,LEFT,1,0}, {20,20}, "/esoui/art/icons/poi/poi_battlefield_complete.dds", nil, false )
	uiPanel.dam.label = UI.Label( uiPanel.dam, {LEFT,LEFT,24,0}, {46,30}, {0,1}, fontPanelLabel, "dam", false )
	uiPanel.dam.label:SetMouseEnabled( true )
	uiPanel.dam.label.OnMouseDown = function() DM.Post('Damage') end
	uiPanel.dam.label:SetHandler( 'OnMouseDown', uiPanel.dam.label.OnMouseDown )
	
	uiPanel.heal = UI.Control( uiPanel, {LEFT,RIGHT,0,0,uiPanel.dam}, {70,30}, false )
	uiPanel.heal.icon = UI.Texture( uiPanel.heal, {LEFT,LEFT,1,0}, {16,16}, "/esoui/art/buttons/gamepad/gp_plus.dds", nil, false )
	uiPanel.heal.label = UI.Label( uiPanel.heal, {LEFT,LEFT,24,0}, {46,30}, {0,1}, fontPanelLabel, "heal", false )
	uiPanel.heal.label:SetMouseEnabled( true )
	uiPanel.heal.label.OnMouseDown = function() DM.Post('Healing') end
	uiPanel.heal.label:SetHandler( 'OnMouseDown', uiPanel.heal.label.OnMouseDown )

	uiPanel.inc = UI.Control( uiPanel, {LEFT,RIGHT,0,0,uiPanel.heal}, {70,30}, false )
	uiPanel.inc.icon = UI.Texture( uiPanel.inc, {LEFT,LEFT,1,0}, {14,14}, "/esoui/art/lfg/gamepad/lfg_roleicon_tank.dds", nil, false )
	uiPanel.inc.label = UI.Label( uiPanel.inc, {LEFT,LEFT,24,0}, {46,30}, {0,1}, fontPanelLabel, "inc", false )
	uiPanel.inc.label:SetMouseEnabled( true )
	uiPanel.inc.label:SetHandler( 'OnMouseDown', DM.ShowMeter )

	uiPanel.time = UI.Control( uiPanel, {LEFT,RIGHT,0,0,uiPanel.inc}, {70,30}, false )
	uiPanel.time.icon = UI.Texture( uiPanel.time, {LEFT,LEFT,1,0}, {18,18}, "/esoui/art/miscellaneous/gamepad/gp_icon_timer32.dds", nil, false )
	uiPanel.time.label = UI.Label( uiPanel.time, {LEFT,LEFT,24,0}, {46,30}, {0,1}, fontPanelLabel, "?:??", false )
	uiPanel.time.label:SetMouseEnabled( true )
	uiPanel.time.label:SetHandler( 'OnMouseDown', DM.ShowLog )

	DM.LayoutMiniPanel()

	-- Create full meter statistics window
	local width = 680
	uiMeter = UI.TopLevel( nil, {width+40,700} )
	uiMeter:SetMouseEnabled( true )
	uiMeter:SetMovable( true )
	uiMeter.OnMoveStop = function(self) DM.SV.positionFull = { self:GetLeft(), self:GetTop() } end
	uiMeter:SetHandler( 'OnMoveStop', uiMeter.OnMoveStop )

	uiMeter.backdrop = UI.ChatBackdrop( uiMeter, nil, nil, {0,0,0,0.8}, 32, false )
	uiMeter.backdrop:SetAnchor( TOPLEFT, uiMeter, TOPLEFT, -16, -16 )
	uiMeter.backdrop:SetAnchor( BOTTOMRIGHT, uiMeter, BOTTOMRIGHT, 16, 16 )
	
	uiMeter.title = UI.Label( uiMeter, {TOP,TOP,0,0}, {width,60}, {0,1}, "ZoFontWindowTitle", g_DamageMeterTitle, false )

	uiMeter.dam = UI.Control( uiMeter, {TOP,TOP,0,60}, {width,280}, false )
	uiMeter.dam.title = UI.Label( uiMeter.dam, {TOP,TOP,0,10}, {width,40}, {0,1}, "ZoFontWindowSubtitle", "Outgoing Damage", false )
	uiMeter.dam.dps = UI.Label( uiMeter.dam, {RIGHT,RIGHT,0,0,uiMeter.dam.title}, {110,40}, {2,1}, "ZoFontWindowSubtitle", "DPS", false )
	uiMeter.dam.crit = UI.Label( uiMeter.dam, {RIGHT,LEFT,0,0,uiMeter.dam.dps}, {60,40}, {1,1}, "ZoFontWindowSubtitle", "Crit", false )
	uiMeter.dam.hits = UI.Label( uiMeter.dam, {RIGHT,LEFT,0,0,uiMeter.dam.crit}, {60,40}, {1,1}, "ZoFontWindowSubtitle", "Hits", false )
	uiMeter.dam.dam = UI.Label( uiMeter.dam, {RIGHT,LEFT,0,0,uiMeter.dam.hits}, {80,40}, {2,1}, "ZoFontWindowSubtitle", "Damage", false )
	local anchor = uiMeter.dam.title
	for i = 1, 10 do
		uiMeter.dam[i] =  UI.Control( uiMeter, {TOP,BOTTOM,0,0,anchor}, {width,24}, false )
		uiMeter.dam[i].icon = UI.Texture( uiMeter.dam[i], {LEFT,LEFT,0,0}, {20,20}, nil, nil, false )
		uiMeter.dam[i].frame = UI.Texture( uiMeter.dam[i].icon, {CENTER,CENTER}, {22,22}, '/esoui/art/actionbar/icon_metal01.dds', nil, false )
		uiMeter.dam[i].left = UI.Label( uiMeter.dam[i], {LEFT,LEFT,26,0}, {width-26,24}, {0,1}, "ZoFontGame", "Damage Skill" .. i, false )
		uiMeter.dam[i].right = UI.Label( uiMeter.dam[i], {RIGHT,RIGHT,0,0}, {110,24}, {2,1}, "ZoFontGame", i .. "%", false )
		uiMeter.dam[i].crit = UI.Label( uiMeter.dam[i], {RIGHT,LEFT,0,0,uiMeter.dam[i].right}, {60,24}, {1,1}, "ZoFontGame", i, false )
		uiMeter.dam[i].hits = UI.Label( uiMeter.dam[i], {RIGHT,LEFT,0,0,uiMeter.dam[i].crit}, {60,24}, {1,1}, "ZoFontGame", i, false )
		uiMeter.dam[i].dam = UI.Label( uiMeter.dam[i], {RIGHT,LEFT,0,0,uiMeter.dam[i].hits}, {80,24}, {2,1}, "ZoFontGame", i, false )
		anchor = uiMeter.dam[i]
	end

	uiMeter.heal = UI.Control( uiMeter, {TOP,BOTTOM,0,0,uiMeter.dam}, {width,280}, false )
	uiMeter.heal.title = UI.Label( uiMeter.heal, {TOP,TOP,0,10}, {width,40}, {0,1}, "ZoFontWindowSubtitle", "Outgoing Healing", false )
	uiMeter.heal.hps = UI.Label( uiMeter.heal, {RIGHT,RIGHT,0,0,uiMeter.heal.title}, {110,40}, {2,1}, "ZoFontWindowSubtitle", "HPS", false )
	uiMeter.heal.crit = UI.Label( uiMeter.heal, {RIGHT,LEFT,0,0,uiMeter.heal.hps}, {60,40}, {1,1}, "ZoFontWindowSubtitle", "Crit", false )
	uiMeter.heal.hits = UI.Label( uiMeter.heal, {RIGHT,LEFT,0,0,uiMeter.heal.crit}, {60,40}, {1,1}, "ZoFontWindowSubtitle", "Hits", false )
	uiMeter.heal.heal = UI.Label( uiMeter.heal, {RIGHT,LEFT,0,0,uiMeter.heal.hits}, {80,40}, {2,1}, "ZoFontWindowSubtitle", "Healing", false )
	anchor = uiMeter.heal.title
	for i = 1, 10 do
		uiMeter.heal[i] =  UI.Control( uiMeter, {TOP,BOTTOM,0,0,anchor}, {width,24}, false )
		uiMeter.heal[i].icon = UI.Texture( uiMeter.heal[i], {LEFT,LEFT,0,0}, {20,20}, nil, nil, false )
		uiMeter.heal[i].frame = UI.Texture( uiMeter.heal[i].icon, {CENTER,CENTER}, {22,22}, '/esoui/art/actionbar/icon_metal02.dds', nil, false )
		uiMeter.heal[i].left = UI.Label( uiMeter.heal[i], {LEFT,LEFT,26,0}, {width-26,24}, {0,1}, "ZoFontGame", "Healing Skill" .. i, false )
		uiMeter.heal[i].right = UI.Label( uiMeter.heal[i], {RIGHT,RIGHT,0,0}, {110,24}, {2,1}, "ZoFontGame", i .. "%", false )
		uiMeter.heal[i].crit = UI.Label( uiMeter.heal[i], {RIGHT,LEFT,0,0,uiMeter.heal[i].right}, {60,24}, {1,1}, "ZoFontGame", i, false )
		uiMeter.heal[i].hits = UI.Label( uiMeter.heal[i], {RIGHT,LEFT,0,0,uiMeter.heal[i].crit}, {60,24}, {1,1}, "ZoFontGame", i, false )
		uiMeter.heal[i].heal = UI.Label( uiMeter.heal[i], {RIGHT,LEFT,0,0,uiMeter.heal[i].hits}, {80,24}, {2,1}, "ZoFontGame", i, false )
		anchor = uiMeter.heal[i]
	end

	uiMeter.inc = UI.Control( uiMeter, {TOP,BOTTOM,0,0,uiMeter.heal}, {width,40}, false )
	uiMeter.inc.title = UI.Label( uiMeter.inc, {TOP,TOP,0,10}, {width,40}, {0,1}, "ZoFontWindowSubtitle", "Incoming Damage", false )

	-- Create Damage Graph
	local width, height = 600, 300
	uiGraph = UI.TopLevel( nil, {width+100,height+150} )
	uiGraph:SetMouseEnabled( true )
	uiGraph:SetMovable( true )
	uiGraph.OnMoveStop = function(self) DM.SV.positionGraph = { self:GetLeft(), self:GetTop() } end
	uiGraph:SetHandler( 'OnMoveStop', uiGraph.OnMoveStop )

	uiGraph.lineColour = ZO_ColorDef:New("6b5d39")
	uiGraph.avgColour = ZO_ColorDef:New("ff0000")
	uiGraph.curColour = ZO_ColorDef:New("ffff00")

	uiGraph.backdrop = UI.ChatBackdrop( uiGraph, nil, nil, {0,0,0,1}, 32, false )
	uiGraph.backdrop:SetAnchor( TOPLEFT, uiGraph, TOPLEFT, -16, -16 )
	uiGraph.backdrop:SetAnchor( BOTTOMRIGHT, uiGraph, BOTTOMRIGHT, 16, 16 )
	
	uiGraph.title = UI.Label( uiGraph, {TOPLEFT,TOPLEFT,80,0}, {width,60}, {0,1}, "ZoFontWindowTitle", g_DamageGraphTitle, false )

	uiGraph.graph = UI.Backdrop( uiGraph, {TOPLEFT,TOPLEFT,80,60}, {width,height}, {1,1,1,0}, {uiGraph.lineColour:UnpackRGBA()}, false )
	uiGraph.graph:SetDrawLayer(DL_BACKGROUND)

	uiGraph.curLegend = UI.Backdrop( uiGraph, {TOPLEFT,TOPLEFT,80,height+100}, {200,40}, {1,1,1,0}, {uiGraph.lineColour:UnpackRGBA()}, false )
	uiGraph.curLegend:SetDrawLayer(DL_BACKGROUND)
	uiGraph.curLegend.text = UI.Label( uiGraph.curLegend, {LEFT,LEFT,10,0}, nil, {0,1}, "ZoFontWindowSubtitle", "Current DPS", false )
	uiGraph.curLegend.line = WINDOW_MANAGER:CreateControl(nil, uiGraph.curLegend, CT_LINE)
	uiGraph.curLegend.line:SetAnchor(LEFT, uiGraph.curLegend, RIGHT, -50, 0)
	uiGraph.curLegend.line:SetAnchor(RIGHT, uiGraph.curLegend, RIGHT, -10, 0)
	uiGraph.curLegend.line:SetThickness(2)
	uiGraph.curLegend.line:SetColor(uiGraph.curColour:UnpackRGBA())
	uiGraph.curLegend.line:SetDrawLayer(DL_BACKGROUND)
	uiGraph.curLegend.line:SetHidden(false)

	uiGraph.avgLegend = UI.Backdrop( uiGraph, {TOPLEFT,TOPLEFT,300,height+100}, {200,40}, {1,1,1,0}, {uiGraph.lineColour:UnpackRGBA()}, false )
	uiGraph.avgLegend:SetDrawLayer(DL_BACKGROUND)
	uiGraph.avgLegend.text = UI.Label( uiGraph.avgLegend, {LEFT,LEFT,10,0}, nil, {0,1}, "ZoFontWindowSubtitle", "Average DPS", false )
	uiGraph.avgLegend.line = WINDOW_MANAGER:CreateControl(nil, uiGraph.avgLegend, CT_LINE)
	uiGraph.avgLegend.line:SetAnchor(LEFT, uiGraph.avgLegend, RIGHT, -50, 0)
	uiGraph.avgLegend.line:SetAnchor(RIGHT, uiGraph.avgLegend, RIGHT, -10, 0)
	uiGraph.avgLegend.line:SetThickness(2)
	uiGraph.avgLegend.line:SetColor(uiGraph.avgColour:UnpackRGBA())
	uiGraph.avgLegend.line:SetDrawLayer(DL_BACKGROUND)
	uiGraph.avgLegend.line:SetHidden(false)

	uiGraph.yLines = {}
	uiGraph.yLabels = {}
	for i = 1, 5 do
		local offset = height * i / 6
		local line = WINDOW_MANAGER:CreateControl(nil, uiGraph.graph, CT_LINE)
		line:SetAnchor(LEFT, uiGraph.graph, BOTTOMLEFT, 0, -offset)
		line:SetAnchor(RIGHT, uiGraph.graph, BOTTOMRIGHT, 0, -offset)
		line:SetThickness(1)
		line:SetColor(uiGraph.lineColour:UnpackRGBA())
		line:SetDrawLayer(DL_BACKGROUND)
		line:SetHidden(false)
		table.insert(uiGraph.yLines, line)
		table.insert(uiGraph.yLabels, UI.Label( uiGraph.graph, {RIGHT,BOTTOMLEFT,-10,-offset}, nil, {2,1}, "ZoFontWindowSubtitle", nil, false ) )
	end
	table.insert(uiGraph.yLabels, UI.Label( uiGraph.graph, {RIGHT,TOPLEFT,-10,0}, nil, {2,1}, "ZoFontWindowSubtitle", nil, false ) )
	uiGraph.yLabelZ = UI.Label( uiGraph.graph, {RIGHT,BOTTOMLEFT,-10,0}, nil, {2,1}, "ZoFontWindowSubtitle", "0", false )

	uiGraph.xLines = {}
	uiGraph.xLabels = {}
	for i = 1, 9 do
		local line = WINDOW_MANAGER:CreateControl(nil, uiGraph.graph, CT_LINE)
		line:SetThickness(1)
		line:SetColor(uiGraph.lineColour:UnpackRGBA())
		line:SetDrawLayer(DL_BACKGROUND)
		line:SetHidden(true)
		table.insert(uiGraph.xLines, line)
		table.insert(uiGraph.xLabels, UI.Label( uiGraph.graph, nil, nil, {2,1}, "ZoFontWindowSubtitle", nil, true ) )
	end
	uiGraph.xLabelZ = UI.Label( uiGraph.graph, {TOP,BOTTOMLEFT,0,10}, nil, {1,1}, "ZoFontWindowSubtitle", "0", false )
	uiGraph.xLabelM = UI.Label( uiGraph.graph, {TOP,BOTTOMRIGHT,0,10}, nil, {1,1}, "ZoFontWindowSubtitle", nil, false )

	uiGraph.curBars = {}
	uiGraph.curSegments = {}
	uiGraph.avgSegments = {}

	-- Position panel
	DM.SetTlwPosition()

	-- Add panel to global controls list, so it can be hidden
	LUIE.components[ moduleName ] = uiPanel	
	LUIE.components[ moduleName .. '_FakeControl' ] = fakeControl

	-- Reset meter
	DM.Reset()

	-- Register events
	EVENT_MANAGER:RegisterForUpdate(moduleName, 1000, DM.OnUpdate )
	EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COMBAT_EVENT, DM.OnCombatEvent )
	EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false )
	EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, DM.OnPlayerActivated)
	EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG, "player" )
	DM.RegisterCombatStateEvent()
	DM.RegisterEffectChangedEvent()
end

--[[
 * Clear and then (maybe) re-register event listener for in/out combat state event
 ]]--
function DM.RegisterCombatStateEvent()
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLAYER_COMBAT_STATE )
	if DM.SV.CombatLog and DM.SV.CombatLogFocus then
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_COMBAT_STATE, DM.OnPlayerCombatState )
	end
end

--[[
 * Clear and then (maybe) re-register event listener for EVENT_EFFECT_CHANGED
 ]]--
function DM.RegisterEffectChangedEvent()
	EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_EFFECT_CHANGED )
	if DM.SV.CombatLog and DM.SV.CombatLogDebuff then
		EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_EFFECT_CHANGED, DM.OnEffectChanged )
	end
end

--[[
 * Reset position of windows. Called from Settings Menu.
 ]]--
function DM.ResetTlwPosition()
	if not DM.Enabled then return end
	DM.SV.positionMini = nil
	DM.SV.positionFull = nil
	DM.SetTlwPosition()
end

--[[
 * Set position of windows. Called from .Initialize() and .ResetTlwPosition()
 ]]--
function DM.SetTlwPosition()

	uiPanel:ClearAnchors()
	if DM.SV.positionMini ~= nil and #DM.SV.positionMini == 2 then
		uiPanel:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, DM.SV.positionMini[1], DM.SV.positionMini[2] )
	else
		uiPanel:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, 3, 3 )
	end

	uiMeter:ClearAnchors()
	if DM.SV.positionFull ~= nil and #DM.SV.positionFull == 2 then
		uiMeter:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, DM.SV.positionFull[1], DM.SV.positionFull[2] )
	else
		uiMeter:SetAnchor( CENTER, GuiRoot, CENTER, 0, -250 )
	end

	uiGraph:ClearAnchors()
	if DM.SV.positionGraph ~= nil and #DM.SV.positionGraph == 2 then
		uiGraph:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, DM.SV.positionGraph[1], DM.SV.positionGraph[2] )
	else
		uiGraph:SetAnchor( CENTER, GuiRoot, CENTER, 0, -150 )
	end

end

--[[
 * Unlock windows for moving. Called from Settings Menu.
 ]]--
function DM.SetMovingState( state )
	if not DM.Enabled then return end
	DM.panelUnlocked = state
	uiPanel:SetMouseEnabled( state )
	uiPanel:SetMovable( state )
end

--[[
 * Changes layout of Meter mini-panel
 ]]--
function DM.LayoutMiniPanel()
	if not DM.Enabled then return end

	-- Hide background backdrop
	uiPanel.backdrop:SetHidden( not DM.SV.Backdrop )

	-- Hide FightTime control and resize Meter mini-panel
	uiPanel.time:SetHidden( not DM.SV.FightTime )
	uiPanel:SetWidth( DM.SV.FightTime and 290 or 220 )
end

--[[
 * Fake Component callback function used by main module
 ]]--
function fakeControl.SetHidden(self, hidden)
	if hidden and not uiMeter:IsHidden() then
		uiMeter:SetHidden(true)
	end
	if hidden and not uiGraph:IsHidden() then
		uiGraph:SetHidden(true)
	end
end

--[[ 
 * Update values on mini-panel
 ]]--
function DM.OnUpdate() 

	-- Compute the fight time
	local record_time = ( g_Meter.endTime - g_Meter.startTime ) / 1000
	local m = math.floor(record_time/60)
	local s = record_time - 60*m
	local fight_time = math.max( record_time , 1 )

	-- Compute player statistics
	local dps = strfmt( "%d" , g_Meter.damage/fight_time )
	local hps = strfmt( "%d" , g_Meter.healing/fight_time )
	local ips = strfmt( "%d" , g_Meter.incoming/fight_time )
	local fts = strfmt( "%d:%.2d" , m, s )
	
	-- Update the labels
	uiPanel.dam.label:SetText( dps )
	uiPanel.heal.label:SetText( hps )
	uiPanel.inc.label:SetText( ips )
	uiPanel.time.label:SetText( fts )
	
	if DM.SV.UpdateFullRealtime and not uiMeter:IsHidden() then DM.Display() end
	if DM.SV.UpdateFullRealtime and not uiGraph:IsHidden() then DM.UpdateGraph() end
end

--[[ 
 * Update values on full statistics window
 ]]--
function DM.Display() 

	-- Compute the most damaged target
	local most_damaged_target = ""
	local most_damage = 0
	local total_targets = -1
	for k, v in pairs( g_Targets ) do
		if k > 0 then
			total_targets = total_targets + 1
			if ( v.total > most_damage ) then
				most_damage = v.total
				most_damaged_target = v.name
			end
		end
	end

	-- Compute the fight time
	local fight_time = math.max( ( g_Meter.endTime - g_Meter.startTime ) / 1000 , 1 )

	-- Generate a title
	local header = ( g_Meter.damage + g_Meter.healing == 0 ) and
		( g_DamageMeterTitle ..  " - " .. g_NoRecord ) or
		strfmt( "%s - %s%s (%.1f sec)",  g_DamageMeterTitle, strformat("<<!aC:1>>", most_damaged_target), (total_targets > 0) and strfmt(" (+%d)", total_targets) or '', fight_time )

	--[[----------------------------------
		OUTGOING DAMAGE
	  ]]----------------------------------
	local dps = g_Meter.damage/fight_time
	
	-- Set Header
	local head	= ( g_Meter.damage > 0 ) and strfmt( "Total Damage - %s (%.1f DPS)", commaValue( g_Meter.damage ), dps ) or "No Outgoing Damage"
	uiMeter.dam.title:SetText( head )
	uiMeter.dam.dam:SetHidden( g_Meter.damage == 0 )
	uiMeter.dam.hits:SetHidden( g_Meter.damage == 0 )
	uiMeter.dam.crit:SetHidden( g_Meter.damage == 0 )
	uiMeter.dam.dps:SetHidden( g_Meter.damage == 0 )
	
	-- Sort damaging abilities
	local damages = {}
	for k,v in pairs( g_Damages ) do
		v.id = k
		table.insert( damages , v ) 
	end
	table.sort( damages , function(x,y) return x.total > y.total end )

	local ndamage = math.min( #damages , 10 )
	for i = 1 , ndamage do

		-- Get data
		local total	= commaValue( damages[i].total )
		local count	= damages[i].count
		local crit	= math.floor( ( damages[i].crit / count ) * 100 )
		local adps	= strfmt( "%.1f" , damages[i].total / fight_time )
		local pdps	= math.floor( ( damages[i].total / fight_time / dps ) * 100 )

		-- Add data
		uiMeter.dam[i]:SetHidden(false)
		uiMeter.dam[i].icon:SetTexture(E.GetAbilityIcon(damages[i].name, damages[i].id))
		uiMeter.dam[i].left:SetText( strformat("<<2>><<t:1>>|r", damages[i].name, colours.DAMAGE_COLOURED[damages[i].type].hex) )
		uiMeter.dam[i].dam:SetText( total )
		uiMeter.dam[i].hits:SetText( count )
		uiMeter.dam[i].crit:SetText( crit .. "%" )
		uiMeter.dam[i].right:SetText( "(" .. pdps .. "%) " .. adps )
	end
	
	-- Hide unused lines
	for i = ndamage + 1 , 10 do
		uiMeter.dam[i]:SetHidden(true)
	end

	-- Change the element height
	uiMeter.dam:SetHeight( 50 + ( math.min(#damages,10) * 24 ) )

	--[[----------------------------------
		OUTGOING HEALING
	  ]]----------------------------------		
	local hps = g_Meter.healing/fight_time
	
	-- Set Header
	local head	= ( g_Meter.healing > 0 ) and strfmt( "Total Healing - %s (%.1f HPS)", commaValue( g_Meter.healing ), hps ) or "No Outgoing Healing"
	uiMeter.heal.title:SetText( head )
	uiMeter.heal.heal:SetHidden( g_Meter.healing == 0 )
	uiMeter.heal.hits:SetHidden( g_Meter.healing == 0 )
	uiMeter.heal.crit:SetHidden( g_Meter.healing == 0 )
	uiMeter.heal.hps:SetHidden( g_Meter.healing == 0 )

	-- Sort healing abilities
	local heals = {}
	for k,v in pairs( g_Heals ) do
		v.id = k
		table.insert( heals , v ) 
	end
	table.sort( heals , function(x,y) return x.total > y.total end )	

	local nheals = math.min( #heals , 10 )
	for i = 1 , nheals do
		
		-- Get data
		local total	= commaValue( heals[i].total )
		local count	= heals[i].count
		local crit	= math.floor( ( heals[i].crit / count ) * 100 )
		local ahps	= strfmt( "%.1f" , heals[i].total / fight_time )
		local phps	= math.floor( ( heals[i].total / fight_time / hps ) * 100 )

		-- Add data
		uiMeter.heal[i]:SetHidden(false)
		uiMeter.heal[i].icon:SetTexture(E.GetAbilityIcon(heals[i].name, heals[i].id))
		uiMeter.heal[i].left:SetText( strformat("<<t:1>>", heals[i].name) )
		uiMeter.heal[i].heal:SetText( total )
		uiMeter.heal[i].hits:SetText( count )
		uiMeter.heal[i].crit:SetText( crit .. "%" )
		uiMeter.heal[i].right:SetText( "(" .. phps .. "%) " .. ahps )
	end
	
	-- Hide unused lines
	for i = nheals + 1 , 10 do
		uiMeter.heal[i]:SetHidden(true)	
	end	

	-- Change the element height
	uiMeter.heal:SetHeight( 50 + ( #heals * 24 ) )		

	--[[----------------------------------
		INCOMING DAMAGE
	  ]]----------------------------------			
	local ips = g_Meter.incoming/fight_time
	
	-- Set Header
	local head	= ( g_Meter.incoming > 0 ) and strfmt( "Incoming Damage - %s (%.1f IPS)", commaValue( g_Meter.incoming ), ips ) or "No Incoming Damage"
	uiMeter.inc.title:SetText( head )
	
	--[[----------------------------------
		ADJUST DISPLAY
	  ]]----------------------------------		 
	uiMeter:SetHeight( 60 + uiMeter.dam:GetHeight() + uiMeter.heal:GetHeight() + 60 )
	uiMeter.title:SetText(header)

end

--[[ 
 * Runs on the EVENT_COMBAT_EVENT listener.
 * This handler fires every time a combat effect is registered on a valid unitTag
 ]]--
function DM.OnCombatEvent( eventCode , result , isError , abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )

	-- Filter out definitelly incorrect ones
	if isError then return end
	
	-- Determine the context
	local damageOut = false
	if ( sourceType == COMBAT_UNIT_TYPE_PLAYER or sourceType == COMBAT_UNIT_TYPE_PLAYER_PET ) then damageOut = true
	elseif ( targetName == g_playerName ) then damageOut = false
	else return end

	-- Debugging
	--d( result .. " || " .. sourceType .. " || " .. sourceName .. " || " .. targetName .. " || " .. abilityName .. " || " .. hitValue  )

	-- Setup a new damage object
	local damage = {
		["out"]		= damageOut,
		["targetUnitId"] = damageOut and targetUnitId or 0,
		["result"]	= result,
		["target"]	= targetName,
		["source"]	= sourceName,
		["name"]	= E.EffectNameOverride[abilityId] or abilityName,
		["id"]		= abilityId,
		["type"]	= damageType,
		["value"]	= hitValue,
		["power"]	= powerType,
		["ms"]		= GetGameTimeMilliseconds(),
		["crit"]	= ( result == ACTION_RESULT_CRITICAL_DAMAGE or result == ACTION_RESULT_CRITICAL_HEAL or result == ACTION_RESULT_DOT_TICK_CRITICAL or result == ACTION_RESULT_HOT_TICK_CRITICAL ) and true or false,
		["heal"]	= ( result == ACTION_RESULT_HEAL or result == ACTION_RESULT_CRITICAL_HEAL or result == ACTION_RESULT_HOT_TICK or result == ACTION_RESULT_HOT_TICK_CRITICAL ) and true or false,
		["multi"]	= 1,
	}
	
	-- ACTION_RESULT_IMMUNE
	-- ACTION_RESULT_BLOCKED
	-- ACTION_RESULT_POWER_DRAIN
	-- ACTION_RESULT_POWER_ENERGIZE

	-- Damage Dealt
	if ( hitValue > 0 and ( result == ACTION_RESULT_DAMAGE or result == ACTION_RESULT_CRITICAL_DAMAGE or result == ACTION_RESULT_BLOCKED_DAMAGE or result == ACTION_RESULT_DOT_TICK or result == ACTION_RESULT_DOT_TICK_CRITICAL ) ) then 

		DM.LogDamage( damage )
		DM.UpdateMeter( damage )

	-- Falling damage
	elseif ( result == ACTION_RESULT_FALL_DAMAGE ) then

		DM.LogDamage( damage )

	-- Shielded Damage
	elseif ( result == ACTION_RESULT_DAMAGE_SHIELDED ) then

		DM.LogDamage( damage )
		if damageOut then DM.UpdateMeter( damage ) end

	-- Misses and  Dodges
	elseif ( result == ACTION_RESULT_DODGED or result == ACTION_RESULT_MISS ) then

		DM.LogDamage( damage )

	-- Crowd Controls
	--elseif ( result == ACTION_RESULT_INTERRUPT or result == ACTION_RESULT_STUNNED or result == ACTION_RESULT_OFFBALANCE or result == ACTION_RESULT_DISORIENTED or result == ACTION_RESULT_STAGGERED or result == ACTION_RESULT_FEARED or result == ACTION_RESULT_SILENCED or result == ACTION_RESULT_ROOTED ) then

	-- Healing Dealt
	elseif ( hitValue > 0 and ( result == ACTION_RESULT_HEAL or result == ACTION_RESULT_CRITICAL_HEAL or result == ACTION_RESULT_HOT_TICK or result == ACTION_RESULT_HOT_TICK_CRITICAL ) ) then 

		DM.LogDamage( damage )
		if damageOut then DM.UpdateMeter( damage ) end

	-- Target Death
	elseif ( result == ACTION_RESULT_DIED or result == ACTION_RESULT_DIED_XP ) then

		DM.LogDamage( damage )

	-- DEBUG NEW EVENTS
	elseif ( hitValue > 0 ) then

		-- Prompt other unrecognized
		--local direction = damageIn and "Incoming" or "Outgoing"
		--CHAT_SYSTEM:AddMessage( direction .. " result " .. result .. " not recognized! Target: " .. targetName .. " Value: " .. hitValue , {1,1,0} )
	end

end

--[[ 
 * Reset the damage meter
 ]]--
function DM.Reset(timeStamp)

	-- Setup damage overview
	g_Meter = {
		['damage']		= 0,
		['maxDam']		= 0,
		['maxDamName']	= "",
		['healing']		= 0,
		['maxHeal']		= 0,
		['maxHealName']	= "",
		['incoming']	= 0,
		['maxInc']		= 0,
		['group']		= 0,
		['startTime']	= timeStamp or 0,
		['endTime']		= timeStamp or 0,
	}
	
	-- Setup damaged target tracking
	g_Targets 	= {}
	
	-- Setup damage ability tracking
	g_Damages	= {}
	
	-- Setup healing ability tracking
	g_Heals	= {}

	-- clear arrays for graphs
	g_TimelineCur = {}
end

 --[[ 
 * Process new combat events passed from the combat event handler
 * Called by OnCombatEvent()
 ]]--
function DM.UpdateMeter( newDamage )

	-- Do not register healing if player is not in combat
	if ( newDamage.heal and not IsUnitInCombat('player') ) then return end
	
	-- If the meter has been inactive for over X seconds
	if ( ( newDamage.ms - g_Meter.endTime ) >= DM.SV.DamageTimeout * 1000 ) then
		
		-- If it's a new source of damage, reset the meter, otherwise, bail out
		if newDamage.heal then
			return
		end
		
		DM.Reset(newDamage.ms)

	end
	
	-- Process outgoing healing events (Healing here can be only outgoing, because we filter it already)
	if ( newDamage.heal ) then -- and newDamage.out ) then
		
		-- Update meter
		g_Meter.healing			= g_Meter.healing + newDamage.value
		if ( newDamage.value > g_Meter.maxHeal ) then
			g_Meter.maxHeal		= newDamage.value
			g_Meter.maxHealName	= newDamage.name			
		end
		
		-- Track ability
		if ( g_Heals[newDamage.id] ~= nil ) then
			g_Heals[newDamage.id].total 	= g_Heals[newDamage.id].total + newDamage.value
			g_Heals[newDamage.id].count 	= g_Heals[newDamage.id].count + 1
			if newDamage.crit then
				g_Heals[newDamage.id].crit	= g_Heals[newDamage.id].crit + 1
			end
		else
			g_Heals[newDamage.id] 	= {
				["name"]			= newDamage.name,
				["total"]			= newDamage.value,
				["count"]			= 1,
				["crit"]			= newDamage.crit and 1 or 0,
			}
		end
	
	-- Process outgoing damage events
	elseif ( newDamage.out ) then

		-- Track statistics for graph
		local timeBin = math.floor( ( newDamage.ms - g_Meter.startTime ) * 0.001 )

		-- Current DPS - simply increase value inside current time bin
		g_TimelineCur[timeBin+1] = g_TimelineCur[timeBin+1] and g_TimelineCur[timeBin+1] + newDamage.value or newDamage.value
			
		-- Update meter
		g_Meter.damage			= g_Meter.damage + newDamage.value
		if ( newDamage.value > g_Meter.maxDam ) then
			g_Meter.maxDam		= newDamage.value
			g_Meter.maxDamName	= newDamage.name			
		end

		-- Special handling of absorbed damage. We do not want to print which enemy skill absorber our damage
		local id = (newDamage.result == ACTION_RESULT_DAMAGE_SHIELDED) and 1 or newDamage.id
		
		-- Track ability
		if ( g_Damages[id] ~= nil ) then
			g_Damages[id].total 	= g_Damages[id].total + newDamage.value
			g_Damages[id].count 	= g_Damages[id].count + 1
			if newDamage.crit then
				g_Damages[id].crit = g_Damages[id].crit + 1
			end
		else
			g_Damages[id] 			= {
				["name"]			= (newDamage.result == ACTION_RESULT_DAMAGE_SHIELDED) and " ( Absorbed damage ) " or newDamage.name,
				["total"]			= newDamage.value,
				["count"]			= 1,
				["crit"]			= newDamage.crit and 1 or 0,
				["type"]			= newDamage.type,
			}
		end
		
		-- Track target
		if g_Targets[newDamage.targetUnitId] then
			g_Targets[newDamage.targetUnitId].total = g_Targets[newDamage.targetUnitId].total + newDamage.value
		else
			g_Targets[newDamage.targetUnitId] = { name = newDamage.target, total = newDamage.value }
		end

	-- Process incoming damage events
	elseif ( not newDamage.out ) then
	
		-- Update meter
		g_Meter.incoming	= g_Meter.incoming + newDamage.value
		if ( newDamage.value > g_Meter.maxInc ) then
			g_Meter.maxInc	= newDamage.value		
		end	
	end
	
	-- Stamp the time (but not for heals)
	if ( not newDamage.heal ) then g_Meter.endTime = newDamage.ms end
	
end

function DM.UpdateGraph()

	-- Compute the most damaged target
	local most_damaged_target = ""
	local most_damage = 0
	local total_targets = -1
	for k, v in pairs( g_Targets ) do
		if k > 0 then
			total_targets = total_targets + 1
			if ( v.total > most_damage ) then
				most_damage = v.total
				most_damaged_target = v.name
			end
		end
	end

	-- Compute the fight time
	local fight_time = math.max( ( g_Meter.endTime - g_Meter.startTime ) / 1000 , 1 )

	-- Generate a title
	local header = ( g_Meter.damage + g_Meter.healing == 0 ) and
		( g_DamageGraphTitle ..  " - " .. g_NoRecord ) or
		strfmt( "%s - %s%s",  g_DamageGraphTitle, strformat("<<!aC:1>>", most_damaged_target), (total_targets > 0) and strfmt(" (+%d)", total_targets) or '' )
	uiGraph.title:SetText(header)
	
	local maxBin = math.floor( fight_time )
	local maxValue = 0

	-- we are going to build array of average DPS here manually
	local l_TimelineAvg, totalDmg = {}, 0
	for i = 1, maxBin+1 do
		-- some time bins could be empty - we will zero current ones
		if not g_TimelineCur[i] then g_TimelineCur[i] = 0 end
		totalDmg = totalDmg + g_TimelineCur[i]
		l_TimelineAvg[i] = totalDmg / i

		-- update maximum value of graphs
		if maxValue < g_TimelineCur[i] then maxValue = g_TimelineCur[i] end
		if maxValue < l_TimelineAvg[i] then maxValue = l_TimelineAvg[i] end
	end
	if maxValue < g_Meter.damage / fight_time then maxValue = g_Meter.damage / fight_time end

	-- decide about vertical scale
	local multiplier = 1
	while maxValue > 24 * multiplier do
		multiplier = multiplier * 10
	end
	-- now we know multiplier, choose fine scale
	-- this value will be in range 1-24
	local scale
	maxValue = maxValue / multiplier
	for i = 1, 8 do
		if maxValue <= 3*i then
			scale = 0.5 * i
			break
		end
	end
	
	-- DEBUG:
	if not scale then
		d( "LUIE Log: Something is wrong when drawing graph" )
		return
	end

	for i = 1, 6 do
		local value = i * scale * multiplier
		uiGraph.yLabels[i]:SetText( ( value > 1000 ) and strfmt( "%.1fk", value / 1000 ) or strfmt( "%d", value ) )
	end

	-- this value will be used on each point offset
	local yScale = uiGraph.graph:GetHeight() / ( 6 * scale * multiplier )

	uiGraph.xLabelM:SetText( strfmt( "%.1f", fight_time ) )
	local xScale = uiGraph.graph:GetWidth() / ( fight_time )

	local xstep = 1
	while fight_time > 10 * xstep do
		xstep = xstep + 1
	end

	-- put X labels and ticks
	local lastX = 0
	for i = 1, 9 do
		if fight_time <= i * xstep then
			break
		end
		local offset = i * xstep * xScale
		
		uiGraph.xLabels[i]:ClearAnchors()
		uiGraph.xLabels[i]:SetAnchor( TOP, uiGraph.graph, BOTTOMLEFT, offset, 10 )
		uiGraph.xLabels[i]:SetText( strfmt( "%d", i * xstep ) )
		uiGraph.xLabels[i]:SetHidden(false)

		uiGraph.xLines[i]:ClearAnchors()
		uiGraph.xLines[i]:SetAnchor(TOP, uiGraph.graph, BOTTOMLEFT, offset, -6)
		uiGraph.xLines[i]:SetAnchor(BOTTOM, uiGraph.graph, BOTTOMLEFT, offset, 6)
		uiGraph.xLines[i]:SetHidden(false)
		
		lastX = i
	end
	for i = lastX+1, 9 do
		uiGraph.xLabels[i]:SetHidden(true)
		uiGraph.xLines[i]:SetHidden(true)
	end

	local lastCur
	local lastAvg

	for i = 1, maxBin + 1 do
		-- current DPS. use bar-plot
		local bar = uiGraph.curBars[i]
		if not bar then
			bar = UI.Backdrop( uiGraph.graph, nil, nil, {uiGraph.curColour:UnpackRGBA(),0.5}, {uiGraph.curColour:UnpackRGBA()}, true )
			bar:SetDrawLayer(DL_CONTROLS)
			uiGraph.curBars[i] = bar
		end
		local barparams = { yScale * g_TimelineCur[i], xScale * (i-0.8), xScale * (i-0.2) }
		if fight_time < i-0.8 then
			barparams = nil
		elseif fight_time < i-0.2 then
			barparams[3] = xScale * fight_time
		end
		if barparams then
			bar:ClearAnchors()
			bar:SetAnchor(BOTTOMLEFT, uiGraph.graph, BOTTOMLEFT, barparams[2], 0 )
			bar:SetAnchor(TOPRIGHT, uiGraph.graph, BOTTOMLEFT, barparams[3], -barparams[1] )
			bar:SetHidden(false)
		else
			bar:SetHidden(true)
		end

		-- current DPS. use line-plot
		--[[ * line plot disabled
		local line = uiGraph.curSegments[i]
		if not line then
			line = WINDOW_MANAGER:CreateControl(nil, uiGraph.graph, CT_LINE)
			line:SetThickness(2)
			line:SetColor(uiGraph.curColour:UnpackRGBA())
			line:SetDrawLayer(DL_CONTROLS)
			uiGraph.curSegments[i] = line
		end
		line:SetHidden(false)
		line:ClearAnchors()
		-- chose next point: either from table or on border of graph
		local curPoint = { xScale * ( (i == maxBin + 1) and fight_time or (i-0.5) ) , yScale * g_TimelineCur[i] }
		if not lastCur then lastCur = {0,0} end
		-- draw line
		if lastCur[2] < curPoint[2] then
			-- this is "/" segment
			line:SetAnchor(BOTTOMLEFT, uiGraph.graph, BOTTOMLEFT, lastCur[1], -lastCur[2])
			line:SetAnchor(TOPRIGHT, uiGraph.graph, BOTTOMLEFT, curPoint[1], -curPoint[2])
		elseif lastCur[2] > curPoint[2] then
			-- this is "\" segment
			line:SetAnchor(TOPLEFT, uiGraph.graph, BOTTOMLEFT, lastCur[1], -lastCur[2])
			line:SetAnchor(BOTTOMRIGHT, uiGraph.graph, BOTTOMLEFT, curPoint[1], -curPoint[2])
		else
			-- this is "-" segment
			line:SetAnchor(LEFT, uiGraph.graph, BOTTOMLEFT, lastCur[1], -lastCur[2])
			line:SetAnchor(RIGHT, uiGraph.graph, BOTTOMLEFT, curPoint[1], -curPoint[2])
		end
		lastCur = curPoint ]]--

		-- average DPS. use line-plot
		local line = uiGraph.avgSegments[i]
		if not line then
			line = WINDOW_MANAGER:CreateControl(nil, uiGraph.graph, CT_LINE)
			line:SetThickness(3)
			line:SetColor(uiGraph.avgColour:UnpackRGBA())
			line:SetDrawLayer(DL_CONTROLS)
			uiGraph.avgSegments[i] = line
		end
		line:SetHidden(false)
		line:ClearAnchors()
		-- chose next point: either from table or on border of graph
		local avgPoint
		if i == maxBin + 1 then
			avgPoint = { xScale * fight_time, yScale * g_Meter.damage / fight_time }
		else
			avgPoint = { xScale * i, yScale * l_TimelineAvg[i] }
		end
		if not lastAvg then lastAvg = {0, avgPoint[2]} end
		-- draw line
		if lastAvg[2] < avgPoint[2] then
			-- this is "/" segment
			line:SetAnchor(BOTTOMLEFT, uiGraph.graph, BOTTOMLEFT, lastAvg[1], -lastAvg[2])
			line:SetAnchor(TOPRIGHT, uiGraph.graph, BOTTOMLEFT, avgPoint[1], -avgPoint[2])
		elseif lastAvg[2] > avgPoint[2] then
			-- this is "\" segment
			line:SetAnchor(TOPLEFT, uiGraph.graph, BOTTOMLEFT, lastAvg[1], -lastAvg[2])
			line:SetAnchor(BOTTOMRIGHT, uiGraph.graph, BOTTOMLEFT, avgPoint[1], -avgPoint[2])
		else
			-- this is "-" segment
			line:SetAnchor(LEFT, uiGraph.graph, BOTTOMLEFT, lastAvg[1], -lastAvg[2])
			line:SetAnchor(RIGHT, uiGraph.graph, BOTTOMLEFT, avgPoint[1], -avgPoint[2])
		end
		lastAvg = avgPoint
	end

	-- hide all unused bars
	for i = maxBin + 2, #uiGraph.curBars do
		uiGraph.curBars[i]:SetHidden(true)
	end
	-- hide all unused line segments
	for i = maxBin + 2, #uiGraph.curSegments do
		uiGraph.curSegments[i]:SetHidden(true)
	end
	-- hide all unused line segments
	for i = maxBin + 2, #uiGraph.avgSegments do
		uiGraph.avgSegments[i]:SetHidden(true)
	end

end

--[[
 * Toggle full meter display
 ]]--
function DM.ShowMeter()
	if not DM.Enabled then return end

	-- update statistics window
	if uiMeter:IsHidden() then DM.Display() end

	uiMeter:SetHidden( not uiMeter:IsHidden() )
end

--[[
 * Toggle graph log display
 ]]--
function DM.ShowLog()
	if not DM.Enabled then return end

	-- update statistics window
	if uiGraph:IsHidden() then DM.UpdateGraph() end

	uiGraph:SetHidden( not uiGraph:IsHidden() )
end

--[[ 
 * Print damage output to chat
 ]]--
function DM.Post( context )
	if not DM.Enabled then return end

	CHAT_SYSTEM:AddMessage(context)

	-- Make sure there's something to report
	if ( g_Meter.damage + g_Meter.healing == 0 ) then 
		CHAT_SYSTEM:AddMessage( "No damage to report!" ) 
		return
	end

	-- Compute the most damaged target
	local most_damaged_target = ""
	local most_damage = 0
	local total_targets = -1
	for k, v in pairs( g_Targets ) do
		if k > 0 then
			total_targets = total_targets + 1
			if ( v.total > most_damage ) then
				most_damage = v.total
				most_damaged_target = v.name
			end
		end
	end
	
	-- Sanitize the name
	local name = strformat("<<!aC:1>>", most_damaged_target) .. ( (total_targets > 0) and strfmt(" (+%d)", total_targets) or '' )
	
	-- Compute the fight time
	local total = 0
	local metric = ""
	local fight_time = math.max( ( g_Meter.endTime - g_Meter.startTime ) / 1000 , 1 )

	-- Generate output
	if ( 'Damage' == context ) then
		total = g_Meter.damage
		metric = "DPS"
	elseif ( 'Healing' == context ) then
		total = g_Meter.healing
		metric = "HPS"
	end

	local label = strfmt("%s (%.1fs) - %s Total %s (%.1f %s)" , name, fight_time, commaValue(total), context, total/fight_time, metric )
	
	-- Determine appropriate channel
	local channel = IsUnitGrouped('player') and "/p " or "/say "

	-- Print output to chat
	--CHAT_SYSTEM:AddMessage(label)
	CHAT_SYSTEM.textEntry:SetText( channel .. label )
end

--[[
 * Fix Combat Log window settings
 ]]--
local function fixCombatLog(cc, window)
	local tabIndex = window.tab.index

	cc:SetFontSize(tabIndex, GetChatFontSize() + DM.SV.CombatLogFont)
	cc:SetInteractivity(tabIndex, true)
	cc:SetLocked(tabIndex, true)
	
	for category = 1, GetNumChatCategories() do
		cc:SetWindowFilterEnabled(tabIndex, category, false)
	end
end

--[[
 * Prepare Combat Log window
 ]]--
local function getCombatLog()
	for _, cc in ipairs(CHAT_SYSTEM.containers) do
		for i = 1, #cc.windows do
			if cc:GetTabName(i) == 'CombatLog' then
				return cc, cc.windows[i]
			end
		end
	end

	-- previous lookup did not find proper window, so create it in primary container
	local cc = CHAT_SYSTEM.primaryContainer
	local window, key = cc.windowPool:AcquireObject()
	window.key = key
	
	cc:AddRawWindow(window, 'CombatLog')

	fixCombatLog(cc, window)

	return cc, window
end

--[[
 * Print combat log entry
 ]]--
function DM.AddMessage(message, doTimeStamp, category)
	local message = formatMessage(message, doTimeStamp)
	local category = category or CHAT_CATEGORY_COMBAT_OTHER
	local cc, window = getCombatLog()

	cc:AddEventMessageToWindow(window, message, category)

	-- store up to 20 last entries in saved variables table
	if g_CombatLogActivated and DM.SVC.LogSaveEnable then
		while #DM.SVC.LogSaved > 20 do
			tremove(DM.SVC.LogSaved, 1)
		end
		tinsert(DM.SVC.LogSaved, message)
	end
end

--[[ 
 * Runs on the EVENT_PLAYER_COMBAT_STATE listener.
 * This handler fires every time player enters or leaves combat
 ]]--
function DM.OnPlayerCombatState(eventCode, inCombat)
	local cc, window = getCombatLog()

	-- ooc
	if not inCombat and cc.luiRestoreTab then
		cc:HandleTabClick(cc.luiRestoreTab)
		cc.luiRestoreTab = nil
	end

	-- ic
	if inCombat then
		local cur_window
		for _, wnd in pairs(cc.windows) do
			if wnd.buffer == cc.currentBuffer then
				cur_window = wnd
				break
			end
		end
		if cur_window then
			cc.luiRestoreTab = cur_window.tab
		end
		cc:HandleTabClick(window.tab)
	end
end

--[[
 * Listens to EVENT_PLAYER_ACTIVATED to print initial message to chat system
 ]]--
function DM.OnPlayerActivated(eventCode)
	-- When CombatLog is enabled, make sure that the chat container is prepared for output
	if DM.SV.CombatLog then

		-- On each EVENT_PLAYER_ACTIVATED reset settings for Combat Log window
		fixCombatLog(getCombatLog())
		
		if not g_CombatLogActivated and eventCode ~= nil then
			if DM.SVC.LogSaveEnable then
				for _, message in ipairs(DM.SVC.LogSaved) do
					DM.AddMessage(message, false, CHAT_CATEGORY_COMBAT_OTHER)
				end
				DM.AddMessage("LUIE Combat Log restored", DM.SV.LogTimeStamp, CHAT_CATEGORY_COMBAT_OTHER)
			else
				DM.AddMessage("LUIE Combat Log activated", DM.SV.LogTimeStamp, CHAT_CATEGORY_COMBAT_OTHER)
			end
			DM.SVC.LogSaved = {}
			g_CombatLogActivated = true
		end
	end
end

--[[ 
 * Runs on the EVENT_EFFECT_CHANGED listener.
 ]]--
function DM.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId)
	if not DM.SV.CombatLog then return end

	-- record only negative effects on self
	if unitTag ~= 'player' or effectType ~= BUFF_EFFECT_TYPE_DEBUFF or changeType ~= EFFECT_RESULT_GAINED then return end

	local msg = strfmt("|c00AA00You|r received |cEEEEEE%s%s|r debuff.",
						effectName ~= "" and strformat("<<t:1>>", effectName) or "Unknown",
						(endTime-beginTime > 0) and strfmt(" (%.1fs)", endTime-beginTime) or "")
	
	DM.AddMessage(msg, DM.SV.LogTimeStamp, CHAT_CATEGORY_COMBAT_GAINED_EFFECT)
end

--[[
 * Prints Combat Event to Chat
 ]]--
function DM.LogDamage(damage)
	if not DM.SV.CombatLog or not damage then return end

	local category
	local msg

	-- Death
	if damage.result == ACTION_RESULT_DIED or damage.result == ACTION_RESULT_DIED_XP then
		msg = "|c00AA00You|r killed " .. strformat("<<!aC:1>>", damage.target)
		category = CHAT_CATEGORY_COMBAT_DEATH

	-- Shielding
	elseif damage.result == ACTION_RESULT_DAMAGE_SHIELDED then
		msg = strfmt("%s %s absorbed |cEEEEEE%s|r damage.",
					damage.out and strformat("|cFF0000<<!aCg:1>>|r", damage.target) or "|c00AA00Your|r",
					damage.name ~= "" and strformat("|cEEEEEE<<t:1>>|r", damage.name) or "shield",
					commaValue(damage.value))
		category = CHAT_CATEGORY_COMBAT_BLOCK_ABSORBED_DEFEND

	-- Blocks
	elseif damage.result == ACTION_RESULT_BLOCKED_DAMAGE then
		msg = strfmt("%s blocked %staking %s%s|r damage.",
					damage.out and strformat("|cFF0000<<!aC:1>>|r", damage.target) or "|c00AA00You|r",
					damage.name ~= "" and strformat("|cEEEEEE<<t:1>>|r ", damage.name) or "",
					colours.DAMAGE_COLOURED[damage.type].hex, commaValue(damage.value))
		category = CHAT_CATEGORY_COMBAT_BLOCK_ABSORBED_DEFEND

	elseif damage.value > 0 then
		-- normal damage
		if damage.result == ACTION_RESULT_DAMAGE or damage.result == ACTION_RESULT_CRITICAL_DAMAGE then
			local subject	= damage.out and "|c00AA00You|r" or strformat("|cFF0000<<!aC:1>>|r", damage.source)
			local object	= damage.out and strformat("|cFF0000<<!aC:1>>|r", damage.target) or "|c00AA00you|r"
			local verb		= damage.out and "hit" or "hits"
			if damage.result == ACTION_RESULT_CRITICAL_DAMAGE then
				verb = colours.DAMAGECRIT.hex .. "critically " .. verb .. "|r"
			end
			msg = strfmt("%s %s %s for %s%s|r damage with %s.", subject, verb, object,
						colours.DAMAGE_COLOURED[damage.type].hex, commaValue(damage.value), strformat("|cEEEEEE<<t:1>>|r", damage.name))
			category = CHAT_CATEGORY_COMBAT_DIRECT_DAMAGE
			
		-- dot
		elseif damage.result == ACTION_RESULT_DOT_TICK or damage.result == ACTION_RESULT_DOT_TICK_CRITICAL then
			local subject	= damage.out and "|c00AA00You|r" or strformat("|cFF0000<<!aC:1>>|r", damage.source)
			local object	= damage.out and strformat("|cFF0000<<!aC:1>>|r", damage.target) or "|c00AA00you|r"
			local verb		= "applied " .. ((damage.result == ACTION_RESULT_DOT_TICK_CRITICAL) and (colours.DAMAGECRIT.hex .. "critical ") or "") .. "dot|r"
			msg = strfmt("%s %s on %s for %s%s|r damage with %s.", subject, verb, object,
						colours.DAMAGE_COLOURED[damage.type].hex, commaValue(damage.value), strformat("|cEEEEEE<<t:1>>|r", damage.name))
			category = CHAT_CATEGORY_COMBAT_DOT

		end
	end
		
	if not msg then return end
	DM.AddMessage(msg, DM.SV.LogTimeStamp, category)
end

--[[
 * Prints Combat Event to Chat
 ]]--
function DM.LogExp(value)
	if not DM.SV.CombatLog or value <= 0 then return end
	DM.AddMessage(strfmt("You earned |cEEEEEE%s|r experience for a kill.", commaValue(value)), DM.SV.LogTimeStamp, CHAT_CATEGORY_COMBAT_EXPERIENCE)
end
