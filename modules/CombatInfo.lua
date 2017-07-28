------------------
-- CombatInfo namespace
LUIE.CombatInfo     = {}

-- Performance Enhancement
local CI            = LUIE.CombatInfo
local UI            = LUIE.UI
local E             = LUIE.Effects
--local DelayBuffer   = LUIE.DelayBuffer
local strfmt        = string.format
--local strformat     = zo_strformat


local moduleName    = LUIE.name .. "_CombatInfo"

CI.Enabled  = false
CI.D = {
    CoolDown            = false,
    UltimateEnabled     = true,
    UltimateHideFull    = true,
    UltimateGeneration  = true,
}
CI.SV       = nil

local g_ultimateCost             = 0
local g_ultimateCurrent          = 0
local g_ultimateAbilityName       = ""
local g_ultimateAbilityId         = 0
local g_ultimateSlot             = ACTION_BAR_ULTIMATE_SLOT_INDEX + 1

-- Cooldowns overlay
local uiCooldown    = {
    colour  = {0.941, 0.973, .957},
    timeColours = {
        [1] = {remain = 600, colour = {0.878, 0.941, 0.251}},
        [2] = {remain = 400, colour = {0.941, 0.565, 0.251}},
        [3] = {remain = 200, colour = {0.941, 0.251, 0.125}},
    },
}
-- Quickslot
local uiQuickSlot   = {
    colour  = {0.941, 0.565, 0.251},
    timeColours = {
        [1] = {remain = 15000, colour = {0.878, 0.941, 0.251}},
        [2] = {remain =  5000, colour = {0.251, 0.941, 0.125}},
    },
}
-- Ultimate slot
local uiUltimate = {
    colour  = {0.941, 0.973, .957},
    pctColours = {
        [1] = {pct =100, colour = {0.878, 0.941, 0.251}},
        [2] = {pct = 80, colour = {0.941, 0.565, 0.251}},
        [3] = {pct = 50, colour = {0.941, 0.251, 0.125}},
    },
    FadeTime = 0,
    NotFull = false,
}


-- Module initialization
function CI.Initialize( enabled )
    -- Load settings
    CI.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "CombatInfo", CI.D )

    -- If User does not want the Combat Info then exit right here
    if not enabled then return end
    CI.Enabled = true

    -- Set ability cooldown controls
    for actionButtonNum = 3, 7 do
        local parent = ZO_ActionBar_GetButton(actionButtonNum).slot
        local bg = UI.Texture( parent, nil, nil, nil, DL_OVERLAY, true )
        bg:SetAnchor(TOPLEFT, parent:GetNamedChild("FlipCard"))
        bg:SetAnchor(BOTTOMRIGHT, parent:GetNamedChild("FlipCard"))
        --:SetAlpha( 0.55 )
        uiCooldown[ actionButtonNum ] = {}
        uiCooldown[ actionButtonNum ].bg = bg
        uiCooldown[ actionButtonNum ].label = UI.Label( bg, {CENTER,CENTER}, nil, nil, "$(BOLD_FONT)|24|soft-shadow-thin", nil, true )
        uiCooldown[ actionButtonNum ].label:SetColor(unpack(uiCooldown.colour))
    end

    uiQuickSlot.label = UI.Label( ActionButton9, {CENTER,CENTER}, nil, nil, "$(MEDIUM_FONT)|18|outline", nil, true )
    uiQuickSlot.label:SetColor(unpack(uiQuickSlot.colour))
    uiQuickSlot.label:SetDrawLayer( DL_OVERLAY )
    uiQuickSlot.label:SetDrawTier( DT_HIGH )
    -- FIXME: This stopped working with Update 1.7.0
    --ActionButton9CountText:SetFont("/EsoUI/Common/Fonts/FTN87.otf|14|soft-shadow-thin")

    -- Create Ultimate overlay labels
    uiUltimate.LabelVal = UI.Label( ActionButton8, {BOTTOM,TOP,0,-3}, nil, {1,2}, "$(BOLD_FONT)|16|soft-shadow-thick", nil, true )
    uiUltimate.LabelPct = UI.Label( ActionButton8, {CENTER,CENTER}, nil, nil, "$(BOLD_FONT)|20|outline", nil, true )
    uiUltimate.LabelPct:SetColor( unpack(uiUltimate.colour) )
    -- And buff texture
    uiUltimate.Texture = UI.Texture( ActionButton8, {CENTER,CENTER}, {160,160}, "/esoui/art/crafting/white_burst.dds", DL_BACKGROUND, true )

    CI.RegisterCombatInfo()

end

-- Clear and then (maybe) re-register event listeners for Combat/Power/Slot Updates
function CI.RegisterCombatInfo()
    EVENT_MANAGER:RegisterForUpdate(moduleName, 100, CI.OnUpdate )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, CI.OnPlayerActivated )

    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_COMBAT_EVENT )
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_POWER_UPDATE )
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACTION_SLOTS_FULL_UPDATE )
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED )
    if CI.SV.UltimateEnabled == true then
        EVENT_MANAGER:RegisterForEvent(moduleName .. "player", EVENT_COMBAT_EVENT, CI.OnCombatEvent )
        EVENT_MANAGER:AddFilterForEvent(moduleName .. "player", EVENT_COMBAT_EVENT, REGISTER_FILTER_UNIT_TAG, "player")
        EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false )
        
        EVENT_MANAGER:RegisterForEvent(moduleName .. "player", EVENT_POWER_UPDATE, CI.OnPowerUpdatePlayer)
        EVENT_MANAGER:AddFilterForEvent(moduleName .. "player", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG, "player" )
        
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_FULL_UPDATE, CI.OnSlotsFullUpdate)
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED, function(eventCode, slotNum) if slotNum == g_ultimateSlot then CI.OnSlotsFullUpdate(eventCode) end end)
    end
end

-- Used to populate abilities icons after the user has logged on
function CI.OnPlayerActivated( eventCode )
    -- do not call this function for the second time
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED )

    -- Manually trigger event to update stats
    CI.OnSlotsFullUpdate(nil)
    CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_ULTIMATE, GetUnitPower("player", POWERTYPE_ULTIMATE))
end

-- Updates all floating labels. Called every 100ms
function CI.OnUpdate(currentTime)
    -- Ability cooldowns
    if ( CI.SV.CoolDown ) then
        for actionButtonNum = 3, 7 do
            local bg    = uiCooldown[ actionButtonNum ].bg
            local label = uiCooldown[ actionButtonNum ].label
            local remain, duration, global = GetSlotCooldownInfo( actionButtonNum )
            if ( duration > 0 ) then
                bg:SetHidden( false )
                bg:SetAlpha( 0.001*remain )
                label:SetHidden( false )
                label:SetText( strfmt( "%.1f", 0.001*remain ) )
                --for i = #(uiCooldown.timeColours), 1, -1 do
                --  if remain < uiCooldown.timeColours[i].remain then
                --      label:SetColor( unpack( uiCooldown.timeColours[i].colour ) )
                --      break
                --  end
                --end
            else
                bg:SetHidden( true )
                --label:SetColor( unpack( uiCooldown.colour ) )
            end
        end
        -- Now same thing for quickslot
        local slotIndex = GetCurrentQuickslot()
        local remain, duration, global = GetSlotCooldownInfo( slotIndex )
        if ( duration > 0 ) then
            uiQuickSlot.label:SetHidden( false )
            uiQuickSlot.label:SetText( strfmt( "%.1f", 0.001*remain ) )
            for i = #(uiQuickSlot.timeColours), 1, -1 do
                if remain < uiQuickSlot.timeColours[i].remain then
                    uiQuickSlot.label:SetColor( unpack( uiQuickSlot.timeColours[i].colour ) )
                    break
                end
            end
        else
            uiQuickSlot.label:SetHidden( true )
            uiQuickSlot.label:SetColor( unpack( uiQuickSlot.colour ) )
        end
    end

    -- Hide Ultimate generation texture if it is time to do so
    if CI.SV.UltimateGeneration then
        if not uiUltimate.Texture:IsHidden() and uiUltimate.FadeTime < currentTime then
            uiUltimate.Texture:SetHidden(true)
        end
    end

end

-- Listens to EVENT_COMBAT_EVENT
function CI.OnCombatEvent( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    -- Ignore error events
    if isError then return end

    -- Manually track Ultimate generation -- same as in SCB module
    if CI.SV.UltimateGeneration and uiUltimate.NotFull and (
        ( result == ACTION_RESULT_BLOCKED_DAMAGE and targetType == COMBAT_UNIT_TYPE_PLAYER ) or
        ( E.IsWeaponAttack[abilityName] and sourceType == COMBAT_UNIT_TYPE_PLAYER and targetType == COMBAT_UNIT_TYPE_NONE )
        ) then

        uiUltimate.Texture:SetHidden(false)
        uiUltimate.FadeTime = GetGameTimeMilliseconds() + 8000
    end

end

function CI.OnSlotsFullUpdate(eventCode)
    local setHidden = not ( CI.SV.UltimateEnabled and IsSlotUsed( g_ultimateSlot ) )

    uiUltimate.LabelVal:SetHidden( setHidden )
    if setHidden then
        uiUltimate.LabelPct:SetHidden( true )
    end

    -- Get the currently slotted ultimate cost
    local cost, mechType = GetSlotAbilityCost( g_ultimateSlot )

    g_ultimateCost = ( mechType == POWERTYPE_ULTIMATE ) and cost or 0

    g_ultimateAbilityName = GetSlotName( g_ultimateSlot )
    g_ultimateAbilityId = GetSlotBoundId( g_ultimateSlot )

    -- if this event was caused only by user manually changing the ultimate ability, then
    -- force recalculation of percent value. Otherwise (weapons swap) this will be called by the game
    if ( eventCode == EVENT_ACTION_SLOT_UPDATED or EVENT_ACTION_SLOTS_FULL_UPDATE and not setHidden ) then
        CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_ULTIMATE, g_ultimateCurrent, 0, 0)
    end
end

function CI.OnPowerUpdatePlayer( eventCode , unitTag, powerIndex, powerType, powerValue, powerMax, powerEffectiveMax )

    if unitTag ~= "player" then return end
    if powerType ~= POWERTYPE_ULTIMATE then return end
    
    -- flag if ultimate is full - we"ll need it for ultimate generation texture
    uiUltimate.NotFull = ( powerValue < powerMax )
    -- Calculate the percentage to activation old one and current
    local pct = ( g_ultimateCost > 0 ) and math.floor( ( powerValue / g_ultimateCost ) * 100 ) or 0
    -- Update the tooltip only when corresponding setting is enabled
    if CI.SV.UltimateEnabled then
        -- Values label: Set Value and assign colour
        -- Pct label: show always when less then 100% and possibly if UltimateHideFull is false
        uiUltimate.LabelVal:SetText( powerValue .. "/" .. g_ultimateCost )
        uiUltimate.LabelPct:SetText( pct .. "%")
        if pct < 100  then
            uiUltimate.LabelPct:SetHidden(false)
            for i = #(uiUltimate.pctColours), 1, -1 do
                if pct < uiUltimate.pctColours[i].pct then
                    uiUltimate.LabelVal:SetColor( unpack( uiUltimate.pctColours[i].colour ) )
                    break
                end
            end
        else
            uiUltimate.LabelPct:SetHidden( CI.SV.UltimateHideFull )
            uiUltimate.LabelVal:SetColor( unpack(uiUltimate.colour) )
        end
    end

    -- Update stored value
    g_ultimateCurrent = powerValue
end

