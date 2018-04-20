------------------
-- CombatInfo namespace
LUIE.CombatInfo     = {}

-- Performance Enhancement
local CI            = LUIE.CombatInfo
local UI            = LUIE.UI
local E             = LUIE.Effects
local A             = LUIE.GetAbility()
local printToChat   = LUIE.PrintToChat
local strfmt        = string.format
local strformat     = zo_strformat
local mathfloor     = math.floor
local unpack        = unpack
local pairs         = pairs

local eventManager  = EVENT_MANAGER
local windowManager = WINDOW_MANAGER

local callLater     = zo_callLater

local moduleName    = LUIE.name .. "_CombatInfo"

CI.Enabled  = false
CI.D = {
    GlobalShowGCD                    = false,
    GlobalPotion                     = false,
    GlobalFlash                      = true,
    GlobalDesat                      = false,
    GlobalLabelColor                 = false,
    GlobalMethod                     = 3,
    UltimateLabelEnabled             = true,
    UltimatePctEnabled               = true,
    UltimateHideFull                 = true,
    UltimateGeneration               = true,
    ShowTriggered                    = true,
    ShowToggled                      = true,
    ShowToggledUltimate              = false,
    ShowToggledSecondary             = false,
    BarShowLabel                     = true,
    BarLabelPosition                 = -20,
    BarFontFace                      = "Univers 67",
    BarFontStyle                     = "outline",
    BarFontSize                      = 18,
    BarMiilis                        = true,
    PotionTimerShow                  = true,
    PotionTimerLabelPosition         = 0,
    PotionTimerFontFace              = "Univers 67",
    PotionTimerFontStyle             = "outline",
    PotionTimerFontSize              = 18,
    PotionTimerColor                 = true,
    PotionTimerMillis                = true,
}
CI.SV       = nil

local g_ultimateCost        = 0
local g_ultimateCurrent     = 0
local g_ultimateAbilityName = ""
local g_ultimateAbilityId   = 0
local g_ultimateSlot        = ACTION_BAR_ULTIMATE_SLOT_INDEX + 1

-- Bar Abilities
local g_uiProcAnimation      = {}
local g_uiCustomToggle       = {}
local g_actionBar            = {}
local g_triggeredSlots       = {}
local g_triggeredSlotsRemain = {}
local g_toggledSlots         = {}
local g_toggledSlotsRemain   = {}
local g_lastCast = 0
local g_pendingGroundAbility = nil
local g_barFont
local g_potionFont
local g_barOverrideCI        = {} -- Table for storing abilityId's from E.BarHighlightOverride that should show as an aura (Created on initialization)
local g_barFakeAura          = {} -- Table for storing abilityId's that only display a fakeaura (Created on initialization)
local g_barDurationOverride  = {} -- Table for storing abilitiyId's that ignore ending event (Created on initialization)
local g_barNoRemove          = {} -- Table of abilities we don't remove from bar highlight (Created on initialization)
local g_potionUsed           = false -- Toggled on when a potion is used to prevent OnSlotsFullUpdate from updating timers.

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

local IsAbilityProc = {
    [A.Skill_Tighten]               = true,
    [A.Skill_Power_Lash]            = true,
    [A.Trigger_Assassins_Will]      = true,
    [A.Trigger_Assassins_Scourge]   = true,
    --[L.Trigger_Deadly_Throw]      = true,
}

local HasAbilityProc = {
    [A.Skill_Crystal_Fragments]     = 46327, -- Trigger_Crystal_Fragments_Passive
}

local CooldownMethod = {
    [1] = CD_TYPE_VERTICAL_REVEAL,
    [2] = CD_TYPE_VERTICAL,
    [3] = CD_TYPE_RADIAL,
}

-- Double check that the slot is actually eligible for use
local function HasFailure( slotIndex )
    if ( HasCostFailure( slotIndex ) ) then
        return true
    elseif ( HasRequirementFailure( slotIndex ) ) then
        return true
    elseif ( HasWeaponSlotFailure( slotIndex ) ) then
        return true
    elseif ( HasTargetFailure( slotIndex ) ) then
        return true
    elseif ( HasRangeFailure( slotIndex ) ) then
        return true
    elseif ( HasStatusEffectFailure( slotIndex )  ) then
        return true
    elseif ( HasFallingFailure( slotIndex ) ) then
        return true
    elseif ( HasSwimmingFailure( slotIndex ) ) then
        return true
    elseif ( HasMountedFailure( slotIndex ) ) then
        return true
    elseif ( HasReincarnatingFailure( slotIndex ) ) then
        return true
    end
    return false
end

-- Module initialization
function CI.Initialize( enabled )
    -- Load settings
    CI.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "CombatInfo", CI.D )

    -- If User does not want the Combat Info then exit right here
    if not enabled then return end
    CI.Enabled = true

    CI.ApplyFont()

    uiQuickSlot.label = UI.Label( ActionButton9, {CENTER,CENTER}, nil, nil, g_potionFont, nil, true )
    uiQuickSlot.label:SetFont(g_potionFont)
    if CI.SV.PotionTimerColor then
        uiQuickSlot.label:SetColor(unpack(uiQuickSlot.colour))
    else
        uiQuickSlot.label:SetColor( 1, 1, 1, 1 )
    end
    uiQuickSlot.label:SetDrawLayer( DL_OVERLAY )
    uiQuickSlot.label:SetDrawTier( DT_HIGH )
    CI.ResetPotionTimerLabel() -- Set the label position

    -- Create Ultimate overlay labels
    uiUltimate.LabelVal = UI.Label( ActionButton8, {BOTTOM,TOP,0,-3}, nil, {1,2}, "$(BOLD_FONT)|16|soft-shadow-thick", nil, true )
    uiUltimate.LabelPct = UI.Label( ActionButton8, {CENTER,CENTER}, nil, nil, "$(BOLD_FONT)|20|outline", nil, true )
    uiUltimate.LabelPct:SetColor( unpack(uiUltimate.colour) )
    -- And buff texture
    uiUltimate.Texture = UI.Texture( ActionButton8, {CENTER,CENTER}, {160,160}, "/esoui/art/crafting/white_burst.dds", DL_BACKGROUND, true )

    CI.RegisterCombatInfo()

    ActionButton.UpdateUsable = function(self)
        local slotnum = self:GetSlot()
        local isGamepad = IsInGamepadPreferredMode()
        local _, duration, _, _ = GetSlotCooldownInfo(slotnum)
        local isShowingCooldown = self.showingCooldown
        local isKeyboardUltimateSlot = not isGamepad and self.slot.slotNum == ACTION_BAR_ULTIMATE_SLOT_INDEX + 1
        local usable = false
        if not self.useFailure and not isShowingCooldown then
            usable = true
        elseif ( isKeyboardUltimateSlot and self.costFailureOnly and not isShowingCooldown ) then
            usable = true
        -- Fix to grey out potions
        elseif IsSlotItemConsumable(slotnum) and duration <= 1000 and not self.useFailure then
            usable = true
        end
        if usable ~= self.usable or isGamepad ~= self.isGamepad then
            self.usable = usable
            self.isGamepad = isGamepad
        end
        -- Have to move this out of conditional to fix desaturation from getting stuck on icons.
        local useDesaturation = (isShowingCooldown and CI.SV.GlobalDesat )
        ZO_ActionSlot_SetUnusable(self.icon, not usable, useDesaturation)
    end

    ActionButton.UpdateCooldown = function(self, options)
        local slotnum = self:GetSlot()
        local remain, duration, global, globalSlotType = GetSlotCooldownInfo(slotnum)
        local isInCooldown = duration > 0
        local slotType = GetSlotType(slotnum)
        local showGlobalCooldownForCollectible = global and slotType == ACTION_TYPE_COLLECTIBLE and globalSlotType == ACTION_TYPE_COLLECTIBLE
        local showCooldown = isInCooldown and (CI.SV.GlobalShowGCD or not global or showGlobalCooldownForCollectible)
        self.cooldown:SetHidden(not showCooldown)

        local updateChromaQuickslot = slotType ~= ACTION_TYPE_ABILITY and ZO_RZCHROMA_EFFECTS

        if showCooldown then
            -- For items with a long CD we need to be sure not to hide the countdown radial timer, so if the duration is the 1 sec GCD, then we don't turn off the cooldown animation.
            if not IsSlotItemConsumable(slotnum) or duration > 1000 or CI.SV.GlobalPotion then
                self.cooldown:StartCooldown(remain, duration, CooldownMethod[CI.SV.GlobalMethod], nil, NO_LEADING_EDGE)
                if self.cooldownCompleteAnim.animation then
                    self.cooldownCompleteAnim.animation:GetTimeline():PlayInstantlyToStart()
                end

                if IsInGamepadPreferredMode() then
                    if not self.itemQtyFailure then
                        self.icon:SetDesaturation(0)
                    end
                    self.cooldown:SetHidden(true)
                    if not self.showingCooldown then
                        self:SetNeedsAnimationParameterUpdate(true)
                        self:PlayAbilityUsedBounce()
                    end
                else
                    self.cooldown:SetHidden(false)
                end

                self.slot:SetHandler("OnUpdate", function() self:RefreshCooldown() end)
                if updateChromaQuickslot then
                    ZO_RZCHROMA_EFFECTS:RemoveKeybindActionEffect("ACTION_BUTTON_9")
                end
            end
        else
            if CI.SV.GlobalFlash then
                if self.showingCooldown then
                    -- Stop flash from appearing on potion/ultimate if toggled off.
                    if not IsSlotItemConsumable(slotnum) or duration > 1000 or CI.SV.GlobalPotion then
                        self.cooldownCompleteAnim.animation = self.cooldownCompleteAnim.animation or CreateSimpleAnimation(ANIMATION_TEXTURE, self.cooldownCompleteAnim)
                        local anim = self.cooldownCompleteAnim.animation

                        self.cooldownCompleteAnim:SetHidden(false)
                        self.cooldown:SetHidden(false)

                        anim:SetImageData(16,1)
                        anim:SetFramerate(30)
                        anim:GetTimeline():PlayFromStart()

                        if updateChromaQuickslot then
                            ZO_RZCHROMA_EFFECTS:AddKeybindActionEffect("ACTION_BUTTON_9")
                        end
                    end
                end
            end
            self.icon.percentComplete = 1
            self.slot:SetHandler("OnUpdate", nil)
            self.cooldown:ResetCooldown()
        end

        if showCooldown ~= self.showingCooldown then
            self.showingCooldown = showCooldown

            if self.showingCooldown then
                ZO_ContextualActionBar_AddReference()
            else
                ZO_ContextualActionBar_RemoveReference()
            end

            self:UpdateActivationHighlight()
            if IsInGamepadPreferredMode() then
                self:SetCooldownHeight(self.icon.percentComplete)
            end
            self:SetCooldownIconAnchors(showCooldown)
        end

        local textColor
        if CI.SV.GlobalLabelColor then
            textColor = showCooldown and INTERFACE_TEXT_COLOR_FAILED or INTERFACE_TEXT_COLOR_SELECTED
        else
            textColor = INTERFACE_TEXT_COLOR_SELECTED
        end
        self.buttonText:SetColor(GetInterfaceColor(INTERFACE_COLOR_TYPE_TEXT_COLORS, textColor))

        self.isGlobalCooldown = global
        self:UpdateUsable()
    end
end

-- Helper function to get override ability duration.
function CI.GetAbilityDuration(abilityId)
    local duration = g_barDurationOverride[abilityId] or GetAbilityDuration(abilityId)
    return duration
end

-- Clear and then (maybe) re-register event listeners for Combat/Power/Slot Updates
function CI.RegisterCombatInfo()
    eventManager:RegisterForUpdate(moduleName, 100, CI.OnUpdate )
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, CI.OnPlayerActivated )

    eventManager:UnregisterForEvent(moduleName, EVENT_COMBAT_EVENT )
    eventManager:UnregisterForEvent(moduleName, EVENT_POWER_UPDATE )
    eventManager:UnregisterForEvent(moduleName, EVENT_ACTION_SLOTS_FULL_UPDATE )
    eventManager:UnregisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED )
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_ITEM_USED)
    if CI.SV.UltimateLabelEnabled or CI.SV.UltimatePctEnabled then
        eventManager:RegisterForEvent(moduleName .. "_LUIE_CI_CombatEvent1", EVENT_COMBAT_EVENT, CI.OnCombatEvent )
        eventManager:RegisterForEvent(moduleName .. "_LUIE_CI_CombatEvent2", EVENT_COMBAT_EVENT, CI.OnCombatEvent )
        eventManager:AddFilterForEvent(moduleName .. "_LUIE_CI_CombatEvent1", REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false, REGISTER_FILTER_COMBAT_RESULT, ACTION_RESULT_BLOCKED_DAMAGE)
        eventManager:AddFilterForEvent(moduleName .. "_LUIE_CI_CombatEvent2", REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false)
        eventManager:RegisterForEvent(moduleName .. "_LUIE_CI_PowerUpdate", EVENT_POWER_UPDATE, CI.OnPowerUpdatePlayer)
        eventManager:AddFilterForEvent(moduleName .. "_LUIE_CI_PowerUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG, "player" )
    end
    if CI.SV.ShowTriggered or CI.SV.ShowToggled or CI.SV.UltimateLabelEnabled or CI.SV.UltimatePctEnabled then
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_FULL_UPDATE, CI.OnSlotsFullUpdate)
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED, CI.OnSlotUpdated)
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_ABILITY_USED, CI.OnSlotAbilityUsed)
    end
    if CI.SV.ShowTriggered or CI.SV.ShowToggled then
        eventManager:RegisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED, CI.OnDeath)
        eventManager:RegisterForEvent(moduleName, EVENT_EFFECT_CHANGED, CI.OnEffectChanged)
        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_ITEM_USED, CI.InventoryItemUsed)

        -- Grab any aura's from the list that have on EVENT_COMBAT_EVENT AURA support
        for abilityId, value in pairs (E.BarHighlightOverride) do
            if value.showFakeAura == true then
                if value.newId then
                    g_barOverrideCI[value.newId] = true
                    if value.duration then
                        g_barDurationOverride[value.newId] = value.duration
                    end
                    if value.noRemove then
                        g_barNoRemove[value.newId] = true
                    end
                else
                    g_barOverrideCI[abilityId] = true
                    if value.duration then
                        g_barDurationOverride[abilityId] = value.duration
                    end
                    if value.noRemove then
                        g_barNoRemove[abilityId] = true
                    end
                end
                g_barFakeAura[abilityId] = true
            else
                if value.noRemove then
                    if value.newId then
                        g_barNoRemove[value.newId] = true
                    else
                        g_barNoRemove[abilityId] = true
                    end
                end
            end
        end
        local counter = 0
        for abilityId, _ in pairs (g_barOverrideCI) do
            counter = counter + 1
            local eventName = (moduleName .. "LUIE_CI_CombatEventBar" .. counter)
            eventManager:RegisterForEvent(eventName, EVENT_COMBAT_EVENT, CI.OnCombatEventBar)
            -- Register filter for specific abilityId's in table only, and filter for source = player, no errors
            eventManager:AddFilterForEvent(eventName, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, abilityId, REGISTER_FILTER_IS_ERROR, false )
        end
    end
end

-- Used to populate abilities icons after the user has logged on
function CI.OnPlayerActivated( eventCode )
    -- do not call this function for the second time
    eventManager:UnregisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED )

    -- Manually trigger event to update stats
    CI.OnSlotsFullUpdate(nil)
    CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_ULTIMATE, GetUnitPower("player", POWERTYPE_ULTIMATE))
end

-- Updates all floating labels. Called every 100ms
function CI.OnUpdate(currentTime)
    -- Procs
    for k, v in pairs (g_triggeredSlotsRemain) do
        local remain = g_triggeredSlotsRemain[k] - currentTime

        -- If duration reaches 0 then remove effect
        if remain <= 0 then
            if g_triggeredSlots[k] and g_uiProcAnimation[g_triggeredSlots[k]] then
                g_uiProcAnimation[g_triggeredSlots[k]]:Stop()
            end
            g_triggeredSlotsRemain[k] = nil
        end

        -- Update Label
        if g_triggeredSlots[k] and g_uiProcAnimation[g_triggeredSlots[k]] and g_triggeredSlotsRemain[k] then
            if CI.SV.BarShowLabel then
                g_uiProcAnimation[g_triggeredSlots[k]].procLoopTexture.label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
            end
        end
    end

    -- Ability Highlight
    for k, v in pairs (g_toggledSlotsRemain) do
        local remain = g_toggledSlotsRemain[k] - currentTime

        -- If duration reaches 0 then remove effect
        if remain <= 0 then
            if g_toggledSlots[k] and g_uiCustomToggle[g_toggledSlots[k]] then
                g_uiCustomToggle[g_toggledSlots[k]]:SetHidden(true)
                if g_toggledSlots[k] == 8 and CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) then
                    uiUltimate.LabelPct:SetHidden( false )
                end
            end
            g_toggledSlotsRemain[k] = nil
        end

        -- Update Label
        if g_toggledSlots[k] and g_uiCustomToggle[g_toggledSlots[k]] and g_toggledSlotsRemain[k] then
            if g_toggledSlots[k] == 8 and CI.SV.UltimatePctEnabled then
                uiUltimate.LabelPct:SetHidden( true )
            end
            if CI.SV.BarShowLabel then
                g_uiCustomToggle[g_toggledSlots[k]].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
            end
        end
    end

    -- Quickslot cooldown
    if ( CI.SV.PotionTimerShow ) then
        local slotIndex = GetCurrentQuickslot()
        local remain, duration, global = GetSlotCooldownInfo( slotIndex )
        -- Don't show unless potion is used - We have to counter for the GCD lockout from casting a spell here
        if ( duration > 5000 ) then
            uiQuickSlot.label:SetHidden( false )
            uiQuickSlot.label:SetText( strfmt(CI.SV.PotionTimerMiilis and "%.1f" or "%.1d", 0.001*remain ) )
            for i = #(uiQuickSlot.timeColours), 1, -1 do
                if remain < uiQuickSlot.timeColours[i].remain then
                    if CI.SV.PotionTimerColor then
                        uiQuickSlot.label:SetColor( unpack( uiQuickSlot.timeColours[i].colour ) )
                    else
                        uiQuickSlot.label:SetColor( 1, 1, 1, 1 )
                    end
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

-- Updates local variable with new font and resets all existing icons
function CI.ApplyFont()
    if not CI.Enabled then
        return
    end

    -- Setup Bar Font
    local barFontName = LUIE.Fonts[CI.SV.BarFontFace]
        if not barFontName or barFontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        barfontName = "$(MEDIUM_FONT)"
    end

    local barFontStyle = ( CI.SV.BarFontStyle and CI.SV.BarFontStyle ~= "" ) and CI.SV.BarFontStyle or "outline"
    local barFontSize = ( CI.SV.BarFontSize and CI.SV.BarFontSize > 0 ) and CI.SV.BarFontSize or 17

    g_barFont = barFontName .. "|" .. barFontSize .. "|" .. barFontStyle

    for k, _ in pairs(g_uiProcAnimation) do
        g_uiProcAnimation[k].procLoopTexture.label:SetFont(g_barFont)
    end

    for k, _ in pairs(g_uiCustomToggle) do
        g_uiCustomToggle[k].label:SetFont(g_barFont)
    end

    -- Setup Potion Timer Font
    local potionFontName = LUIE.Fonts[CI.SV.PotionTimerFontFace]
        if not potionFontName or potionFontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        potionFontName = "$(MEDIUM_FONT)"
    end

    local potionFontStyle = ( CI.SV.PotionTimerFontStyle and CI.SV.PotionTimerFontStyle ~= "" ) and CI.SV.PotionTimerFontStyle or "outline"
    local potionFontSize = ( CI.SV.PotionTimerFontSize and CI.SV.PotionTimerFontSize > 0 ) and CI.SV.PotionTimerFontSize or 17

    g_potionFont = potionFontName .. "|" .. potionFontSize .. "|" .. potionFontStyle

    -- If QuickSlot is created, and we're updating font from the menu setting, set the font here.
    if uiQuickSlot.label then
        uiQuickSlot.label:SetFont(g_potionFont)
    end
end

-- Resets bar labels on menu option change
function CI.ResetBarLabel()
    for k, _ in pairs(g_uiProcAnimation) do
        g_uiProcAnimation[k].procLoopTexture.label:SetText("")
    end

    for k, _ in pairs(g_uiCustomToggle) do
        g_uiCustomToggle[k].label:SetText("")
    end

    for i = 3, 8 do
        local actionButton = ZO_ActionBar_GetButton(i)
        if g_uiCustomToggle[i] then
            g_uiCustomToggle[i].label:ClearAnchors()
            g_uiCustomToggle[i].label:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
            g_uiCustomToggle[i].label:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"), nil, 0, -CI.SV.BarLabelPosition)
        elseif g_uiProcAnimation[i] then
            g_uiProcAnimation[i].procLoopTexture.label:ClearAnchors()
            g_uiProcAnimation[i].procLoopTexture.label:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
            g_uiProcAnimation[i].procLoopTexture.label:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"), nil, 0, -CI.SV.BarLabelPosition)
        end
    end
end

function CI.ResetPotionTimerLabel()
    local actionButton = ZO_ActionBar_GetButton(9)
    uiQuickSlot.label:ClearAnchors()
    uiQuickSlot.label:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
    uiQuickSlot.label:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"), nil, 0, -CI.SV.PotionTimerLabelPosition)
end

function CI.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    -- If we're displaying a fake bar highlight then bail out here (sometimes we need a fake aura that doesn't end to simulate effects that can be overwritten, such as Major/Minor buffs. Technically we don't want to stop the
    -- highlight of the original ability since we can only track one buff per slot and overwriting the buff with a longer duration buff shouldn't throw the player off by making the glow disappear earlier.
    if g_barFakeAura[abilityId] then
        return
    end

    if castByPlayer == COMBAT_UNIT_TYPE_PLAYER then
        if g_pendingGroundAbility and g_pendingGroundAbility.id == abilityId and changeType == EFFECT_RESULT_GAINED then
            -- Bar Tracker
            if CI.SV.ShowToggled then
                local currentTime = GetGameTimeMilliseconds()
                local slotNum = g_pendingGroundAbility.slotNum
                if g_toggledSlots[abilityId] then
                    if CI.SV.ShowToggled then
                        local groundDuration = endTime - beginTime
                        g_toggledSlotsRemain[abilityId] = groundDuration*1000 + currentTime
                        CI.ShowCustomToggle(slotNum)
                        if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled then
                            uiUltimate.LabelPct:SetHidden( true )
                        end
                        if CI.SV.BarShowLabel then
                            g_uiCustomToggle[g_toggledSlots[abilityId]].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", CI.SV.BarMiilis and groundDuration or groundDuration - 1 ))
                        end
                    end
                end
            end
            -- Clear the ground target queue
            g_pendingGroundAbility = nil
        end
    end

    if changeType == EFFECT_RESULT_FADED then -- delete Effect
        -- Ignore fading event if override is true
        if g_barNoRemove[abilityId] then return end

        if unitTag == "player" then
            -- Stop any proc animation associated with this effect
            if abilityType == ABILITY_TYPE_BONUS and g_triggeredSlotsRemain[abilityId] then
                if g_triggeredSlots[abilityId] and g_uiProcAnimation[g_triggeredSlots[abilityId]] then
                    g_uiProcAnimation[g_triggeredSlots[abilityId]]:Stop()
                end
                g_triggeredSlotsRemain[abilityId] = nil
            end
            -- Stop any toggle animation associted with this effect
            if g_toggledSlotsRemain[abilityId] then
                if g_toggledSlots[abilityId] and g_uiCustomToggle[g_toggledSlots[abilityId]] then
                    g_uiCustomToggle[g_toggledSlots[abilityId]]:SetHidden(true)
                    if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) then
                        uiUltimate.LabelPct:SetHidden( false )
                    end
                end
                g_toggledSlotsRemain[abilityId] = nil
            end
        end
    else
        -- Also create visual enhancements from skill bar
        if castByPlayer == COMBAT_UNIT_TYPE_PLAYER then
            -- start any proc animation associated with this effect
            if abilityType == ABILITY_TYPE_BONUS and g_triggeredSlots[abilityId] then
                if CI.SV.ShowTriggered then
                    PlaySound(SOUNDS.DEATH_RECAP_KILLING_BLOW_SHOWN)
                    g_triggeredSlotsRemain[abilityId] = ((endTime - beginTime) * 1000) + GetGameTimeMilliseconds()
                    CI.PlayProcAnimations(g_triggeredSlots[abilityId])
                    if CI.SV.BarShowLabel then
                        g_uiProcAnimation[g_triggeredSlots[abilityId]].procLoopTexture.label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", CI.SV.BarMiilis and (CI.GetAbilityDuration(abilityId)/1000) or (CI.GetAbilityDuration(abilityId)/1000) - 1 ))
                    end
                end
            end
            -- Display active effects
            if g_toggledSlots[abilityId] then
                local currentTime = GetGameTimeMilliseconds()
                if CI.SV.ShowToggled then
                    g_toggledSlotsRemain[abilityId] = ((endTime - beginTime) * 1000) + GetGameTimeMilliseconds()
                    CI.ShowCustomToggle(g_toggledSlots[abilityId])
                    if CI.SV.BarShowLabel then
                        g_uiCustomToggle[g_toggledSlots[abilityId]].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", CI.SV.BarMiilis and (CI.GetAbilityDuration(abilityId)/1000) or (CI.GetAbilityDuration(abilityId)/1000) - 1 ))
                    end
                end
            end
        end
    end
end

-- Listens to EVENT_COMBAT_EVENT
function CI.OnCombatEvent( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    -- Manually track Ultimate generation -- same as in CI module
    if CI.SV.UltimateGeneration and uiUltimate.NotFull and (
        ( result == ACTION_RESULT_BLOCKED_DAMAGE and targetType == COMBAT_UNIT_TYPE_PLAYER ) or
        ( E.IsWeaponAttack[abilityName] and sourceType == COMBAT_UNIT_TYPE_PLAYER and targetType == COMBAT_UNIT_TYPE_NONE )
        ) then

        uiUltimate.Texture:SetHidden(false)
        uiUltimate.FadeTime = GetGameTimeMilliseconds() + 8000
    end
end

function CI.OnCombatEventBar( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    -- If the source/target isn't the player then bail out now.
    if sourceType ~= COMBAT_UNIT_TYPE_PLAYER and targetType ~= COMBAT_UNIT_TYPE_PLAYER then return end

    if result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED or result == ACTION_RESULT_EFFECT_GAINED_DURATION then
        local currentTime = GetGameTimeMilliseconds()
        if g_toggledSlots[abilityId] then
            if CI.SV.ShowToggled then
                g_toggledSlotsRemain[abilityId] = CI.GetAbilityDuration(abilityId) + currentTime
                CI.ShowCustomToggle(g_toggledSlots[abilityId])
                if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled then
                    uiUltimate.LabelPct:SetHidden( true )
                end
                if CI.SV.BarShowLabel then
                    g_uiCustomToggle[g_toggledSlots[abilityId]].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", CI.SV.BarMiilis and (CI.GetAbilityDuration(abilityId)/1000) or (CI.GetAbilityDuration(abilityId)/1000) - 1 ))
                end
            end
        end
    elseif result == ACTION_RESULT_EFFECT_FADED then
        -- Ignore fading event if override is true
        if g_barNoRemove[abilityId] then return end

        if g_toggledSlotsRemain[abilityId] then
            if g_toggledSlots[abilityId] and g_uiCustomToggle[g_toggledSlots[abilityId]] then
                g_uiCustomToggle[g_toggledSlots[abilityId]]:SetHidden(true)
                if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) then
                    uiUltimate.LabelPct:SetHidden( false )
                end
            end
            g_toggledSlotsRemain[abilityId] = nil
        end
    end
end

function CI.OnSlotAbilityUsed(eventCode, slotNum)
    -- Clear stored ground-target ability
    g_pendingGroundAbility = nil

    -- Get the used ability & time
    local currentTime = GetGameTimeMilliseconds()
    local ability = g_actionBar[slotNum]

    if ability then -- Only proceed if this button is being watched
        -- Avoid failure and button mashing
        if not HasFailure( slotNum ) and ( currentTime > g_lastCast + 250 ) then
            -- Don't process effects immediately for ground-target spells
            if ability.ground then
                g_pendingGroundAbility = ability
            else
                -- Flag the last cast time
                g_lastCast = currentTime
            end
        end
    end
end

function CI.OnSlotUpdated(eventCode, slotNum)
    if slotNum == 8 then
        CI.UpdateUltimateLabel(eventCode)
    end

    -- Handle slot update for action bars
    --d( strfmt("%d: %s(%d)", slotNum, GetSlotName(slotNum), GetSlotBoundId(slotNum) ) )
    -- Look only for action bar slots
    if CI.SV.ShowToggledUltimate then
        if slotNum < 3 or slotNum > 8 then
            return
        end
    else
        if slotNum < 3 or slotNum > 7 then
            return
        end
    end

    -- Remove saved triggered proc information
    for abilityId, slot in pairs(g_triggeredSlots) do
        if (slot == slotNum) then
            g_triggeredSlots[abilityId] = nil
        end
    end
    -- Stop possible proc animation
    if g_uiProcAnimation[slotNum] and g_uiProcAnimation[slotNum]:IsPlaying() then
        --g_uiProcAnimation[slotNum].procLoopTexture.label:SetText("")
        g_uiProcAnimation[slotNum]:Stop()
    end

    -- Remove custom toggle information and custom highlight
    for abilityId, slot in pairs(g_toggledSlots) do
        if (slot == slotNum) then
            g_toggledSlots[abilityId] = nil
        end
    end

    if g_uiCustomToggle[slotNum] then
        --g_uiCustomToggle[slotNum].label:SetText("")
        g_uiCustomToggle[slotNum]:SetHidden(true)
    end

    -- Bail out if slot is not used
    if not IsSlotUsed(slotNum) then
        g_actionBar[slotNum] = nil
        return
    end

    -- Get the slotted ability ID
    local ability_id = GetSlotBoundId(slotNum)
    local showFakeAura = (E.BarHighlightOverride[ability_id] and E.BarHighlightOverride[ability_id].showFakeAura)

    -- If secondary effects aren't set to display then don't setup highlight for this slot.
    if (E.BarHighlightOverride[ability_id] and E.BarHighlightOverride[ability_id].secondary) and not CI.SV.ShowToggledSecondary then
        return
    end

    if E.BarHighlightOverride[ability_id] and E.BarHighlightOverride[ability_id].newId then
        ability_id = E.BarHighlightOverride[ability_id].newId
    end
    local abilityName = E.EffectOverride[ability_id] and E.EffectOverride[ability_id].name or GetAbilityName(ability_id) -- GetSlotName(slotNum)
    local duration = CI.GetAbilityDuration(ability_id)

    g_actionBar[slotNum] = {
        id      = ability_id,
        name    = abilityName,
        ground  = ( GetAbilityTargetDescription(ability_id) == "Ground" ),
        duration = duration,
        slotNum=slotNum,
        showFakeAura = showFakeAura
    }

    -- Check if currently this ability is in proc state
    local proc = HasAbilityProc[abilityName]
    if IsAbilityProc[abilityName] then
        if CI.SV.ShowTriggered then
            CI.PlayProcAnimations(slotNum)
        end
    elseif proc then
        g_triggeredSlots[proc] = slotNum
         if g_triggeredSlotsRemain[proc] then
            if CI.SV.ShowTriggered then
                CI.PlayProcAnimations(slotNum)
                if CI.SV.BarShowLabel then
                    g_uiProcAnimation[slotNum].procLoopTexture.label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", CI.SV.BarMiilis and (CI.GetAbilityDuration(ability_id)/1000) or (CI.GetAbilityDuration(ability_id)/1000) - 1 ))
                end
            end
        end
    end

    -- Check for active duration to display highlight for abilities on bar swap
    if duration > 0 then
        g_toggledSlots[ability_id] = slotNum
        if g_toggledSlotsRemain[ability_id] then
            if CI.SV.ShowToggled then
                CI.ShowCustomToggle(slotNum)
                if slotNum == 8 and CI.SV.UltimatePctEnabled then
                    uiUltimate.LabelPct:SetHidden( true )
                end
                if CI.SV.BarShowLabel then
                    g_uiCustomToggle[slotNum].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", CI.SV.BarMiilis and (CI.GetAbilityDuration(ability_id)/1000) or (CI.GetAbilityDuration(ability_id)/1000) - 1 ))
                end
            end
        end
    end
end

function CI.UpdateUltimateLabel(eventCode)
    -- Handle ultimate label first
    local setHiddenLabel = not ( CI.SV.UltimateLabelEnabled and IsSlotUsed( g_ultimateSlot ) )
    local setHiddenPct = not ( CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) )

    uiUltimate.LabelVal:SetHidden( setHiddenLabel )
    if setHiddenPct then
        uiUltimate.LabelPct:SetHidden( true )
    end

    -- Get the currently slotted ultimate cost
    local cost, mechType = GetSlotAbilityCost( g_ultimateSlot )

    g_ultimateCost = ( mechType == POWERTYPE_ULTIMATE ) and cost or 0

    g_ultimateAbilityName = GetSlotName( g_ultimateSlot )
    g_ultimateAbilityId = GetSlotBoundId( g_ultimateSlot )

    -- if this event was caused only by user manually changing the ultimate ability, then
    -- force recalculation of percent value. Otherwise (weapons swap) this will be called by the game
    if ( (eventCode == EVENT_ACTION_SLOT_UPDATED or EVENT_ACTION_SLOTS_FULL_UPDATE) and not setHidden ) then
        CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_ULTIMATE, g_ultimateCurrent, 0, 0)
    end
end

function CI.InventoryItemUsed()
    g_potionUsed = true
    callLater(function() g_potionUsed = false end, 200)
end

function CI.OnSlotsFullUpdate(eventCode, isHotbarSwap)
    -- Handle ultimate label first
    CI.UpdateUltimateLabel(eventCode)

    -- If the event was triggered by a weapon swap we need to clear ground-target stored ability
    if isHotbarSwap then
        g_pendingGroundAbility = nil
    end

    -- Don't update bars if this full update event was from using an inventory item
    if g_potionUsed == true then return end

    -- Update action bar skills
    g_actionBar = {}
    for i = 3, 8 do
        CI.OnSlotUpdated(eventCode, i)
    end
end

function CI.PlayProcAnimations(slotNum)
    if not g_uiProcAnimation[slotNum] then
        local actionButton = ZO_ActionBar_GetButton(slotNum)
        local procLoopTexture = windowManager:CreateControl("$(parent)Loop_LUIE", actionButton.slot, CT_TEXTURE)
        procLoopTexture:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
        procLoopTexture:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"))
        procLoopTexture:SetTexture("/esoui/art/actionbar/abilityhighlight_mage_med.dds")
        procLoopTexture:SetBlendMode(TEX_BLEND_MODE_ADD)
        procLoopTexture:SetDrawLevel(2)
        procLoopTexture:SetHidden(true)

        procLoopTexture.label = UI.Label (procLoopTexture, nil, nil, nil, g_barFont, nil, false)
        procLoopTexture.label:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
        procLoopTexture.label:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"), nil, 0, -CI.SV.BarLabelPosition)
        procLoopTexture.label:SetDrawLayer(DL_COUNT)
        procLoopTexture.label:SetDrawLevel(3)
        procLoopTexture.label:SetDrawTier(3)
        procLoopTexture.label:SetColor( unpack( CI.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
        procLoopTexture.label:SetHidden(false)

        local procLoopTimeline = ANIMATION_MANAGER:CreateTimelineFromVirtual("UltimateReadyLoop", procLoopTexture)
        procLoopTimeline.procLoopTexture = procLoopTexture

        procLoopTimeline.onPlay = function(self) self.procLoopTexture:SetHidden(false) end
        procLoopTimeline.onStop = function(self) self.procLoopTexture:SetHidden(true) end

        procLoopTimeline:SetHandler("OnPlay", procLoopTimeline.onPlay)
        procLoopTimeline:SetHandler("OnStop", procLoopTimeline.onStop)

        g_uiProcAnimation[slotNum] = procLoopTimeline
    end
    if g_uiProcAnimation[slotNum] then
        if not g_uiProcAnimation[slotNum]:IsPlaying() then
            g_uiProcAnimation[slotNum]:PlayFromStart()
        end
    end
end

function CI.OnDeath(eventCode, unitTag, isDead)
    -- And toggle buttons
    if unitTag == "player" then
        for slotNum = 3, 8 do
            if g_uiCustomToggle[slotNum] then
                g_uiCustomToggle[slotNum]:SetHidden(true)
                if slotNum == 8 and CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) then
                    uiUltimate.LabelPct:SetHidden( false )
                end
            end
        end
    end
end

-- Displays custom toggle texture
function CI.ShowCustomToggle(slotNum)
    if not g_uiCustomToggle[slotNum] then
        local actionButton = ZO_ActionBar_GetButton(slotNum)

        local toggleFrame = windowManager:CreateControl("$(parent)Toggle_LUIE", actionButton.slot, CT_TEXTURE)

        --toggleFrame.back = UI.Texture( toggleFrame, nil, nil, "/esoui/art/actionbar/actionslot_toggledon.dds")
        toggleFrame:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
        toggleFrame:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"))
        toggleFrame:SetTexture("/esoui/art/actionbar/actionslot_toggledon.dds")
        toggleFrame:SetBlendMode(TEX_BLEND_MODE_ADD)
        toggleFrame:SetDrawLayer(0)
        toggleFrame:SetDrawLevel(0)
        toggleFrame:SetDrawTier(2)
        toggleFrame:SetColor(0.5,1,0.5,1)
        toggleFrame:SetHidden(false)

        toggleFrame.label = UI.Label (toggleFrame, nil, nil, nil, g_barFont, nil, false)
        toggleFrame.label:SetAnchor(TOPLEFT, actionButton.slot:GetNamedChild("FlipCard"))
        toggleFrame.label:SetAnchor(BOTTOMRIGHT, actionButton.slot:GetNamedChild("FlipCard"), nil, 0, -CI.SV.BarLabelPosition)
        toggleFrame.label:SetDrawLayer(DL_COUNT)
        toggleFrame.label:SetDrawLevel(1)
        toggleFrame.label:SetDrawTier(3)
        toggleFrame.label:SetColor( unpack( CI.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
        toggleFrame.label:SetHidden(false)

        g_uiCustomToggle[slotNum] = toggleFrame
    end
    if g_uiCustomToggle[slotNum] then
        g_uiCustomToggle[slotNum]:SetHidden(false)
    end
end

function CI.OnPowerUpdatePlayer( eventCode , unitTag, powerIndex, powerType, powerValue, powerMax, powerEffectiveMax )
    if unitTag ~= "player" then return end
    if powerType ~= POWERTYPE_ULTIMATE then return end

    -- flag if ultimate is full - we"ll need it for ultimate generation texture
    uiUltimate.NotFull = ( powerValue < powerMax )
    -- Calculate the percentage to activation old one and current
    local pct = ( g_ultimateCost > 0 ) and mathfloor( ( powerValue / g_ultimateCost ) * 100 ) or 0
    -- Update the tooltip only when corresponding setting is enabled
    if CI.SV.UltimateLabelEnabled or CI.SV.UltimatePctEnabled then
        if IsSlotUsed( g_ultimateSlot ) then
            -- Values label: Set Value and assign colour
            -- Pct label: show always when less then 100% and possibly if UltimateHideFull is false
            if CI.SV.UltimateLabelEnabled then
                uiUltimate.LabelVal:SetText( powerValue .. "/" .. g_ultimateCost )
            end
            if CI.SV.UltimatePctEnabled then
                uiUltimate.LabelPct:SetText( pct .. "%")
            end
            if pct < 100  then
                if CI.SV.UltimatePctEnabled then
                    local setHidden = false
                    if (CI.SV.ShowToggledUltimate and g_uiCustomToggle[8] and not g_uiCustomToggle[8]:IsHidden() ) then
                        setHidden = true
                    end
                    uiUltimate.LabelPct:SetHidden(setHidden)
                end
                if CI.SV.UltimateLabelEnabled then
                    for i = #(uiUltimate.pctColours), 1, -1 do
                        if pct < uiUltimate.pctColours[i].pct then
                            uiUltimate.LabelVal:SetColor( unpack( uiUltimate.pctColours[i].colour ) )
                            break
                        end
                    end
                end
            else
                local setHidden = false
                if (CI.SV.ShowToggledUltimate and g_uiCustomToggle[8] and not g_uiCustomToggle[8]:IsHidden() ) or CI.SV.UltimateHideFull then
                    setHidden = true
                end
                if CI.SV.UltimatePctEnabled then
                    uiUltimate.LabelPct:SetHidden( setHidden )
                end
                if CI.SV.UltimateLabelEnabled then
                    uiUltimate.LabelVal:SetColor( unpack(uiUltimate.colour) )
                end
            end
        end
    end
    -- Update stored value
    g_ultimateCurrent = powerValue
end
