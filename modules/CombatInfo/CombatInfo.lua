--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- CombatInfo namespace
LUIE.CombatInfo     = {}

-- Performance Enhancement
local CI            = LUIE.CombatInfo
local UI            = LUIE.UI
local E             = LUIE.Effects
local CBT           = LUIE.CastBarTable
local A             = LUIE.GetAbility()
local printToChat   = LUIE.PrintToChat

local strfmt        = string.format
local strformat     = zo_strformat
local callLater     = zo_callLater

local eventManager  = EVENT_MANAGER
local sceneManager  = SCENE_MANAGER
local windowManager = WINDOW_MANAGER

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
    UltimateLabelPosition            = -20,
    UltimateFontFace                 = "Univers 67",
    UltimateFontStyle                = "outline",
    UltimateFontSize                 = 18,
    ShowTriggered                    = true,
    ProcEnableSound                  = true,
    ProcSoundName                    = "Death Recap Killing Blow",
    ShowToggled                      = true,
    ShowToggledUltimate              = true,
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
    CastBarEnable                    = false,
    CastBarSizeW                     = 300,
    CastBarSizeH                     = 22,
    CastBarIconSize                  = 32,
    CastBarTexture                   = "Plain",
    CastBarLabel                     = true,
    CastBarTimer                     = true,
    CastBarFontFace                  = "Univers 67",
    CastBarFontStyle                 = "soft-shadow-thick",
    CastBarFontSize                  = 16,
    CastBarGradientC1                = { 0, 47/255, 130/255 },
    CastBarGradientC2                = { 82/255, 215/255, 1 },
    alerts = {
        toggles = {
            --Alerts
            alertEnable                 = true,
            alertFontFace               = "Univers 67",
            alertFontStyle              = "soft-shadow-thick",
            alertFontSize               = 32,
            alertTimer                  = true,

            showMitigation              = true,
            mitigationPrefix            = "%t",
            mitigationPrefixN           = "%n - %t",

            showCrowdControlBorder      = true,

            mitigationPowerPrefix       = GetString(SI_LUIE_CI_MITIGATION_FORMAT_POWER),
            mitigationPowerPrefixN      = GetString(SI_LUIE_CI_MITIGATION_FORMAT_POWER_N),
            mitigationDestroyPrefix     = GetString(SI_LUIE_CI_MITIGATION_FORMAT_DESTROY),
            mitigationDestroyPrefixN    = GetString(SI_LUIE_CI_MITIGATION_FORMAT_DESTROY_N),
            mitigationSummonPrefix      = GetString(SI_LUIE_CI_MITIGATION_FORMAT_SUMMON),
            mitigationSummonPrefixN     = GetString(SI_LUIE_CI_MITIGATION_FORMAT_SUMMON_N),

            -- Add Name/No Name Variants
            mitigationAura              = false,
            mitigationRank3             = true,
            mitigationRank2             = true,
            mitigationRank1             = true,
            mitigationDungeon           = true,

            showAlertMitigate           = true, -- TODO -- Replaces Block/Interrupt/Dodge

            showAlertUnmit				= true,
            showAlertPower              = true,
            showAlertDestroy            = true,
            showAlertSummon             = true,

            alertOptions                = 1,

        },
        colors = {
            alertShared                 = { 1, 1, 1, 1 },
            alertTimer                  = { 1, 1, 1, 1 },
            alertBlockA                 = { 1, 0, 0, 1 },
            alertInterruptB             = { 0, 0.50, 1, 1 },
            alertUnmit					= { 1, 0, 0, 1 },
            alertDodgeA                 = { 1, 1, 50/255, 1 },
            alertAvoidB                 = { 1, 127/255, 0, 1 },
            alertPower                  = { 1, 1, 1, 1 },
            alertDestroy                = { 1, 1, 1, 1 },
            alertSummon                 = { 1, 1, 1, 1 },
            stunColor                   = {0.894118, 0.133333, 0.090196, 1},
            disorientColor              = {0.0313725509,0.6274510026,1, 1},
            fearColor                   = {0.5607843137, 0.0352941176, 0.9254901961, 1},
            silenceColor                = {0, 1, 1, 1},
            staggerColor                = {1,0.9490196109,0.1294117719,1},
            unbreakableColor            = {0.88,0.88,1,1},
            snareColor                  = {1,.6470, 0, 1},
        },
        formats = {
            alertBlock                  = GetString(SI_LUIE_CI_BLOCK_DEFAULT),
            alertBlockStagger           = GetString(SI_LUIE_CI_BLOCKSTAGGER_DEFAULT),
            alertInterrupt              = GetString(SI_LUIE_CI_INTERRUPT_DEFAULT),
            alertUnmit					= GetString(SI_LUIE_CI_UNMIT_DEFAULT),
            alertDodge                  = GetString(SI_LUIE_CI_DODGE_DEFAULT),
            alertAvoid                  = GetString(SI_LUIE_CI_AVOID_DEFAULT),
            alertPower                  = GetString(SI_LUIE_CI_POWER_DEFAULT),
            alertDestroy                = GetString(SI_LUIE_CI_DESTROY_DEFAULT),
            alertSummon                 = GetString(SI_LUIE_CI_SUMMON_DEFAULT),
        },

        --[[
        -- TODO: CC Type Colors
        [ACTION_RESULT_STUNNED]={0.894118, 0.133333, 0.090196, 1},
		[ACTION_RESULT_DISORIENTED]={0.0313725509,0.6274510026,1, 1},
		[ACTION_RESULT_FEARED]={0.5607843137, 0.0352941176, 0.9254901961, 1},
		[ACTION_RESULT_SILENCED]={0, 1, 1, 1},
		[ACTION_RESULT_STAGGERED]={1,0.9490196109,0.1294117719,1},
        ]]
    },
}
CI.SV = nil
CI.AlertColors = {}
CI.CastBarUnlocked = false
CI.AlertFrameUnlocked = false

local uiTlw                   = {} -- GUI
local castbar                 = {} -- castbar
local g_casting               = false -- Toggled when casting - prevents additional events from creating a cast bar until finished
local g_ultimateCost          = 0 -- Cost of ultimate Ability in Slot
local g_ultimateCurrent       = 0 -- Current ultimate value
local g_ultimateSlot          = ACTION_BAR_ULTIMATE_SLOT_INDEX + 1 -- Ultimate slot number
local g_uiProcAnimation       = {} -- Animation for bar slots
local g_uiCustomToggle        = {} -- Toggle slots for bar Slots
local g_triggeredSlots        = {} -- Triggered bar highlight slots
local g_triggeredSlotsRemain  = {} -- Table of remaining durations on proc abilities
local g_toggledSlots          = {} -- Toggled bar highlight slots
local g_toggledSlotsRemain    = {} -- Table of remaining durations on active abilities
local g_toggledSlotsPlayer    = {} -- Table of abilities that target the player (bar highlight doesn't fade on reticleover change)
local g_potionUsed            = false -- Toggled on when a potion is used to prevent OnSlotsFullUpdate from updating timers.
local g_barOverrideCI         = {} -- Table for storing abilityId's from E.BarHighlightOverride that should show as an aura
local g_barFakeAura           = {} -- Table for storing abilityId's that only display a fakeaura
local g_barDurationOverride   = {} -- Table for storing abilitiyId's that ignore ending event
local g_barNoRemove           = {} -- Table of abilities we don't remove from bar highlight
local g_protectAbilityRemoval = {} -- AbilityId's set to a timestamp here to prevent removal of bar highlight when refreshing ground auras from causing the highlight to fade.
local g_mineStacks            = {} -- Individual AbilityId ground mine stack information
local g_barFont -- Font for Ability Highlight Label
local g_potionFont -- Font for Potion Timer Label
local g_ultimateFont -- Font for Ultimate Percentage Label
local g_castbarFont -- Font for Castbar Label & Timer
local g_ProcSound -- Proc Sound

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

-- Cooldown Animation Types for GCD Tracking
local CooldownMethod = {
    [1] = CD_TYPE_VERTICAL_REVEAL,
    [2] = CD_TYPE_VERTICAL,
    [3] = CD_TYPE_RADIAL,
}

-- Module initialization
function CI.Initialize( enabled )
    -- Load settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        CI.SV = ZO_SavedVars:New( LUIE.SVName, LUIE.SVVer, "CombatInfo", CI.D )
    else
        CI.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "CombatInfo", CI.D )
    end

    -- If User does not want the Combat Info then exit right here
    if not enabled then return end
    CI.Enabled = true

    CI.ApplyFont()
    CI.ApplyProcSound()

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
    uiUltimate.LabelPct = UI.Label( ActionButton8, nil, nil, nil, g_ultimateFont, nil, true )
    local actionButton = ZO_ActionBar_GetButton(8)
    uiUltimate.LabelPct:SetAnchor(TOPLEFT, actionButton.slot)
    uiUltimate.LabelPct:SetAnchor(BOTTOMRIGHT, actionButton.slot, nil, 0, -CI.SV.UltimateLabelPosition)

    uiUltimate.LabelPct:SetColor( unpack(uiUltimate.colour) )
    -- And buff texture
    uiUltimate.Texture = UI.Texture( ActionButton8, {CENTER,CENTER}, {160,160}, "/esoui/art/crafting/white_burst.dds", DL_BACKGROUND, true )

    CI.RegisterCombatInfo()

    -- Hook to update GCD support
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

    -- Hook to update GCD support
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

    -- Create and update Cast Bar
    CI.CreateCastBar()
    CI.UpdateCastBar()
    CI.SetCastBarPosition()

    CI.CreateAlertFrame()
    CI.SetAlertFramePosition()
    CI.SetAlertColors()
end

-- Helper function to get override ability duration.
local function GetUpdatedAbilityDuration(abilityId)
    local duration = g_barDurationOverride[abilityId] or GetAbilityDuration(abilityId)
    return duration
end

-- Called on initialization and menu changes
-- Pull data from E.BarHighlightOverride Tables to filter the display of Bar Highlight abilities based off menu settings.
function CI.UpdateBarHighlightTables()
    g_uiProcAnimation      = {}
    g_uiCustomToggle       = {}
    g_triggeredSlots       = {}
    g_triggeredSlotsRemain = {}
    g_toggledSlots         = {}
    g_toggledSlotsRemain   = {}
    g_toggledSlotsPlayer   = {}
    g_barOverrideCI        = {}
    g_barFakeAura          = {}
    g_barDurationOverride  = {}
    g_barNoRemove          = {}

    local counter = 0
    for abilityId, _ in pairs (g_barOverrideCI) do
        counter = counter + 1
        local eventName = (moduleName .. "LUIE_CI_CombatEventBar" .. counter)
        eventManager:UnregisterForEvent(eventName, EVENT_COMBAT_EVENT, CI.OnCombatEventBar)
    end

    if CI.SV.ShowTriggered or CI.SV.ShowToggled then
        LUIE.Effects.BarHighlightRefresh()
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
            if value.emulateGround == true then
                if value.newId then
                    g_toggledSlotsPlayer[value.newId] = true
                else
                    g_toggledSlotsPlayer[abilityId] = true
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

-- Clear and then (maybe) re-register event listeners for Combat/Power/Slot Updates
function CI.RegisterCombatInfo()
    eventManager:RegisterForUpdate(moduleName.."CI_UPDATE", 100, CI.OnUpdate )
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, CI.OnPlayerActivated )

    eventManager:UnregisterForEvent(moduleName, EVENT_COMBAT_EVENT )
    eventManager:UnregisterForEvent(moduleName, EVENT_POWER_UPDATE )
    eventManager:UnregisterForEvent(moduleName, EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED )
    eventManager:UnregisterForEvent(moduleName, EVENT_ACTION_SLOTS_ALL_HOTBARS_UPDATED )
    eventManager:UnregisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED )
    eventManager:UnregisterForEvent(moduleName, EVENT_INVENTORY_ITEM_USED)
    if CI.SV.UltimateLabelEnabled or CI.SV.UltimatePctEnabled then
        eventManager:RegisterForEvent(moduleName .. "_LUIE_CI_CombatEvent1", EVENT_COMBAT_EVENT, CI.OnCombatEvent )
        eventManager:AddFilterForEvent(moduleName .. "_LUIE_CI_CombatEvent1", REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false, REGISTER_FILTER_COMBAT_RESULT, ACTION_RESULT_BLOCKED_DAMAGE)
        eventManager:RegisterForEvent(moduleName .. "_LUIE_CI_PowerUpdate", EVENT_POWER_UPDATE, CI.OnPowerUpdatePlayer)
        eventManager:AddFilterForEvent(moduleName .. "_LUIE_CI_PowerUpdate", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG, "player" )
    end
    if CI.SV.UltimateLabelEnabled or CI.SV.UltimatePctEnabled or CI.SV.CastBarEnable then
        eventManager:RegisterForEvent(moduleName .. "_LUIE_CI_CombatEvent2", EVENT_COMBAT_EVENT, CI.OnCombatEvent )
        eventManager:AddFilterForEvent(moduleName .. "_LUIE_CI_CombatEvent2", REGISTER_FILTER_SOURCE_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false)
    end
    if CI.SV.CastBarEnable then
        local counter = 0
        for result, _ in pairs (CBT.CastBreakingStatus) do
            counter = counter + 1
            local eventName = (moduleName.. "LUIE_CI_CombatEventCC" .. counter)
            eventManager:RegisterForEvent(eventName, EVENT_COMBAT_EVENT, CI.OnCombatEventBreakCast)
            eventManager:AddFilterForEvent(eventName, EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_IS_ERROR, false, REGISTER_FILTER_COMBAT_RESULT, result)
        end
        eventManager:RegisterForEvent(moduleName, EVENT_START_SOUL_GEM_RESURRECTION, CI.SoulGemResurrectionStart)
        eventManager:RegisterForEvent(moduleName, EVENT_END_SOUL_GEM_RESURRECTION, CI.SoulGemResurrectionEnd)
        --[[counter = 0
        for id, _ in pairs (E.CastBreakOnRemoveEvent) do
            counter = counter + 1
            local eventName = (moduleName.. "LUIE_CI_CombatEventCastBreak" .. counter)
            eventManager:RegisterForEvent(eventName, EVENT_COMBAT_EVENT, CI.OnCombatEventSpecialFilters )
            eventManager:AddFilterForEvent(eventName, EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER, REGISTER_FILTER_ABILITY_ID, id, REGISTER_FILTER_IS_ERROR, false, REGISTER_FILTER_COMBAT_RESULT, ACTION_RESULT_EFFECT_FADED)
        end]]--
    end
    if CI.SV.ShowTriggered or CI.SV.ShowToggled or CI.SV.UltimateLabelEnabled or CI.SV.UltimatePctEnabled then
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED, CI.OnSlotsFullUpdate)
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_ALL_HOTBARS_UPDATED, CI.OnSlotsFullUpdate)
        eventManager:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED, CI.OnSlotUpdated)
    end
    if CI.SV.ShowTriggered or CI.SV.ShowToggled then
        eventManager:RegisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED, CI.OnDeath)
        eventManager:RegisterForEvent(moduleName, EVENT_TARGET_CHANGE, CI.OnTargetChange )
        eventManager:RegisterForEvent(moduleName, EVENT_RETICLE_TARGET_CHANGED, CI.OnReticleTargetChanged )

        eventManager:RegisterForEvent(moduleName, EVENT_INVENTORY_ITEM_USED, CI.InventoryItemUsed)

        -- Setup bar highlight
        CI.UpdateBarHighlightTables()
    end
    -- Have to register EVENT_EFFECT_CHANGED for werewolf as well - Stop devour cast bar when devour fades
    if CI.SV.ShowTriggered or CI.SV.ShowToggled or CI.SV.CastBarEnable then
        eventManager:RegisterForEvent(moduleName, EVENT_EFFECT_CHANGED, CI.OnEffectChanged)
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

local savedPlayerX = 0
local savedPlayerZ = 0
local playerX = 0
local playerZ = 0

-- Updates all floating labels. Called every 100ms
function CI.OnUpdate(currentTime)
    -- Procs
    for k, v in pairs (g_triggeredSlotsRemain) do
        local remain = g_triggeredSlotsRemain[k] - currentTime

        -- If duration reaches 0 then remove effect
        if v < currentTime then
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
        if v < currentTime then
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

    -- Break castbar when movement interrupt is detected for certain effects.
    savedPlayerX = playerX
    savedPlayerZ = playerZ
    playerX, playerZ = GetMapPlayerPosition("player")

    if savedPlayerX == playerX and savedPlayerZ == playerZ then
        return
    else
        if CBT.BreakCastOnMove[castbar.id] then
            CI.StopCastBar()
        end
    end
end

function CI.StopCastBar()
    local state = CI.CastBarUnlocked
     -- Don't hide the cast bar if we have it unlocked to move.
    castbar.bar.name:SetHidden(true)
    castbar.bar.timer:SetHidden(true)
    castbar:SetHidden(true)
    castbar.remain = nil
    castbar.starts = nil
    castbar.ends = nil
    g_casting = false
    eventManager:UnregisterForUpdate(moduleName.."CI_CASTBAR")

    if state then
        CI.GenerateCastbarPreview(state)
    end
end

-- Updates Cast Bar - only enabled when Cast Bar is unhidden
function CI.OnUpdateCastbar(currentTime)
    -- Update castbar
    local castStarts = castbar.starts
    local castEnds = castbar.ends
    local remain = castbar.remain - currentTime
    if remain <= 0 then
        CI.StopCastBar()
    else
        if CI.SV.CastBarTimer then
            castbar.bar.timer:SetText( strfmt("%.1f", remain/1000) )
        end
        if castbar.type == 1 then
            castbar.bar.bar:SetValue( (currentTime - castStarts) / (castEnds - castStarts) )
        else
            castbar.bar.bar:SetValue(1 - ((currentTime - castStarts) / (castEnds - castStarts)))
        end
    end
end

-- Updates local variables with new font
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

    -- Setup Ultimate Font
    local ultimateFontName = LUIE.Fonts[CI.SV.UltimateFontFace]
    if not ultimateFontName or ultimateFontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        ultimateFontName = "$(MEDIUM_FONT)"
    end

    local ultimateFontStyle = ( CI.SV.UltimateFontStyle and CI.SV.UltimateFontStyle ~= "" ) and CI.SV.UltimateFontStyle or "outline"
    local ultimateFontSize = ( CI.SV.UltimateFontSize and CI.SV.UltimateFontSize > 0 ) and CI.SV.UltimateFontSize or 17

    g_ultimateFont = ultimateFontName .. "|" .. ultimateFontSize .. "|" .. ultimateFontStyle

    if uiUltimate.LabelPct then
        uiUltimate.LabelPct:SetFont(g_ultimateFont)
    end

    -- Setup Castbar Font
    local castbarFontName = LUIE.Fonts[CI.SV.CastBarFontFace]
    if not castbarFontName or castbarFontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        castbarFontName = "$(MEDIUM_FONT)"
    end

    local castbarFontStyle = ( CI.SV.CastBarFontStyle and CI.SV.CastBarFontStyle ~= "" ) and CI.SV.CastBarFontStyle or "soft-shadow-thin"
    local castbarFontSize = ( CI.SV.CastBarFontSize and CI.SV.CastBarFontSize > 0 ) and CI.SV.CastBarFontSize or 16

    g_castbarFont = castbarFontName .. "|" .. castbarFontSize .. "|" .. castbarFontStyle
end

-- Updates Proc Sound - called on initialization and menu changes
function CI.ApplyProcSound(menu)
    local barProcSound = LUIE.Sounds[CI.SV.ProcSoundName]
        if not barProcSound or barProcSound == "" then
        printToChat(GetString(SI_LUIE_ERROR_SOUND), true)
        barProcSound = "DeathRecap_KillingBlowShown"
    end

    g_procSound = barProcSound

    if menu then
        PlaySound(g_procSound)
    end
end

-- Resets the ultimate labels on menu option change
function CI.ResetUltimateLabel()
    uiUltimate.LabelPct:ClearAnchors()
    local actionButton = ZO_ActionBar_GetButton(8)
    uiUltimate.LabelPct:SetAnchor(TOPLEFT, actionButton.slot)
    uiUltimate.LabelPct:SetAnchor(BOTTOMRIGHT, actionButton.slot, nil, 0, -CI.SV.UltimateLabelPosition)
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
            g_uiCustomToggle[i].label:SetAnchor(TOPLEFT, actionButton.slot)
            g_uiCustomToggle[i].label:SetAnchor(BOTTOMRIGHT, actionButton.slot, nil, 0, -CI.SV.BarLabelPosition)
        elseif g_uiProcAnimation[i] then
            g_uiProcAnimation[i].procLoopTexture.label:ClearAnchors()
            g_uiProcAnimation[i].procLoopTexture.label:SetAnchor(TOPLEFT, actionButton.slot)
            g_uiProcAnimation[i].procLoopTexture.label:SetAnchor(BOTTOMRIGHT, actionButton.slot, nil, 0, -CI.SV.BarLabelPosition)
        end
    end
end

-- Resets Potion Timer label - called on initialization and menu changes
function CI.ResetPotionTimerLabel()
    local actionButton = ZO_ActionBar_GetButton(9)
    uiQuickSlot.label:ClearAnchors()
    uiQuickSlot.label:SetAnchor(TOPLEFT, actionButton.slot)
    uiQuickSlot.label:SetAnchor(BOTTOMRIGHT, actionButton.slot, nil, 0, -CI.SV.PotionTimerLabelPosition)
end

-- Runs on the EVENT_TARGET_CHANGE listener.
-- This handler fires every time the someone target changes.
-- This function is needed in case the player teleports via Way Shrine
function CI.OnTargetChange(eventCode, unitTag)
    if unitTag ~= "player" then
        return
    end
    CI.OnReticleTargetChanged(eventCode)
end

-- Runs on the EVENT_RETICLE_TARGET_CHANGED listener.
-- This handler fires every time the player's reticle target changes
function CI.OnReticleTargetChanged(eventCode)
    local unitTag = "reticleover"

    for k, v in pairs (g_toggledSlotsRemain) do
        if g_toggledSlots[k] and g_uiCustomToggle[g_toggledSlots[k]] and not g_toggledSlotsPlayer[k] then
            g_uiCustomToggle[g_toggledSlots[k]]:SetHidden(true)
            g_toggledSlotsRemain[k] = nil
        end
    end

    if DoesUnitExist("reticleover") then
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

            if not IsUnitDead(unitTag) then
                CI.OnEffectChanged(0, EFFECT_RESULT_UPDATED, buffSlot, buffName, unitTag, timeStarted, timeEnding, stackCount, iconFilename, buffType, effectType, abilityType, statusEffectType, unitName, 0, abilityId, castByPlayer)
            end
        end
    end
end

function CI.OnEffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    -- If we're displaying a fake bar highlight then bail out here (sometimes we need a fake aura that doesn't end to simulate effects that can be overwritten, such as Major/Minor buffs. Technically we don't want to stop the
    -- highlight of the original ability since we can only track one buff per slot and overwriting the buff with a longer duration buff shouldn't throw the player off by making the glow disappear earlier.
    if g_barFakeAura[abilityId] then
        return
    end

    if CBT.CastBreakOnRemoveEffect[abilityId] and castByPlayer == COMBAT_UNIT_TYPE_PLAYER and changeType == EFFECT_RESULT_FADED then
        CI.StopCastBar()
        if abilityId == 33208 then -- Devour (Werewolf)
            return
        end
    end

    if unitTag == "player" then
        g_toggledSlotsPlayer[abilityId] = true
    end

    if castByPlayer == COMBAT_UNIT_TYPE_PLAYER and (E.EffectGroundDisplay[abilityId] or E.LinkedGroundMine[abilityId]) then
        if E.LinkedGroundMine[abilityId] then
            abilityId = E.LinkedGroundMine[abilityId]
        end

        if changeType == EFFECT_RESULT_FADED then
            if abilityId == 32958 then return end -- Ignore Shifting Standard
            local currentTime = GetGameTimeMilliseconds()
            if not g_protectAbilityRemoval[abilityId] or g_protectAbilityRemoval[abilityId] < currentTime then
                if (E.IsGroundMineAura[abilityId] or E.IsGroundMineStack[abilityId]) then
                    g_mineStacks[abilityId] = g_mineStacks[abilityId] - E.EffectGroundDisplay[abilityId].stackRemove
                    if g_mineStacks[abilityId] == 0 then
                        if g_toggledSlotsRemain[abilityId] then
                            if g_toggledSlots[abilityId] and g_uiCustomToggle[g_toggledSlots[abilityId]] then
                                g_uiCustomToggle[g_toggledSlots[abilityId]]:SetHidden(true)
                                if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) then
                                    uiUltimate.LabelPct:SetHidden( false )
                                end
                            end
                        end
                        g_toggledSlotsRemain[abilityId] = nil
                    end
                else
                    -- Ignore fading event if override is true
                    if g_barNoRemove[abilityId] then return end
                    -- Stop any toggle animation associated with this effect
                    if g_toggledSlotsRemain[abilityId] then
                        if g_toggledSlots[abilityId] and g_uiCustomToggle[g_toggledSlots[abilityId]] then
                            g_uiCustomToggle[g_toggledSlots[abilityId]]:SetHidden(true)
                            if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) then
                                uiUltimate.LabelPct:SetHidden( false )
                            end
                        end
                    end
                    g_toggledSlotsRemain[abilityId] = nil
                end
            end
        elseif changeType == EFFECT_RESULT_GAINED then

            local currentTime = GetGameTimeMilliseconds()
            g_protectAbilityRemoval[abilityId] = currentTime + 150

            if E.IsGroundMineAura[abilityId] then
                g_mineStacks[abilityId] = E.EffectGroundDisplay[abilityId].stackReset
            elseif E.IsGroundMineStack[abilityId] then
                if g_mineStacks[abilityId] then
                    g_mineStacks[abilityId] = g_mineStacks[abilityId] + E.EffectGroundDisplay[abilityId].stackRemove
                else
                    g_mineStacks[abilityId] = 1
                end
                if g_mineStacks[abilityId] > E.EffectGroundDisplay[abilityId].stackReset then g_mineStacks[abilityId] = E.EffectGroundDisplay[abilityId].stackReset end
            end

            -- Bar Tracker
            if CI.SV.ShowToggled then
                g_toggledSlotsPlayer[abilityId] = true
                local currentTime = GetGameTimeMilliseconds()
                if g_toggledSlots[abilityId] then
                    g_toggledSlotsRemain[abilityId] = 1000*endTime
                    CI.ShowCustomToggle(g_toggledSlots[abilityId])
                    if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled then
                        uiUltimate.LabelPct:SetHidden( true )
                    end
                    if CI.SV.BarShowLabel then
                        local remain = g_toggledSlotsRemain[abilityId] - currentTime
                        g_uiCustomToggle[g_toggledSlots[abilityId]].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
                    end
                end
            end
        end
    end

    if unitTag ~= "player" and unitTag ~= "reticleover" then
        return
    end

    if changeType == EFFECT_RESULT_FADED then -- delete Effect
        -- Ignore fading event if override is true
        if g_barNoRemove[abilityId] then return end

        -- Stop any proc animation associated with this effect
        if g_triggeredSlotsRemain[abilityId] then
            if g_triggeredSlots[abilityId] and g_uiProcAnimation[g_triggeredSlots[abilityId]] then
                g_uiProcAnimation[g_triggeredSlots[abilityId]]:Stop()
            end
            g_triggeredSlotsRemain[abilityId] = nil
        end
        -- Stop any toggle animation associated with this effect
        if g_toggledSlotsRemain[abilityId] then
            if g_toggledSlots[abilityId] and g_uiCustomToggle[g_toggledSlots[abilityId]] then
                g_uiCustomToggle[g_toggledSlots[abilityId]]:SetHidden(true)
                if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled and IsSlotUsed( g_ultimateSlot ) then
                    uiUltimate.LabelPct:SetHidden( false )
                end
            end
            g_toggledSlotsRemain[abilityId] = nil
        end
    else
        -- Also create visual enhancements from skill bar
        if castByPlayer == COMBAT_UNIT_TYPE_PLAYER then
            -- start any proc animation associated with this effect
            if g_triggeredSlots[abilityId] then
                local currentTime = GetGameTimeMilliseconds()
                if CI.SV.ShowTriggered then
                    -- Play sound twice so its a little louder.
                    if CI.SV.ProcEnableSound and unitTag == "player" then
                        PlaySound(g_procSound)
                        PlaySound(g_procSound)
                    end
                    g_triggeredSlotsRemain[abilityId] = 1000*endTime
                    CI.PlayProcAnimations(g_triggeredSlots[abilityId])
                    if CI.SV.BarShowLabel then
                        local remain = g_triggeredSlotsRemain[abilityId] - currentTime
                        g_uiProcAnimation[g_triggeredSlots[abilityId]].procLoopTexture.label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
                    end
                end
            end
            -- Display active effects
            if g_toggledSlots[abilityId] then
                local currentTime = GetGameTimeMilliseconds()
                if CI.SV.ShowToggled then
                    g_toggledSlotsRemain[abilityId] = 1000*endTime
                    CI.ShowCustomToggle(g_toggledSlots[abilityId])
                    if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled then
                        uiUltimate.LabelPct:SetHidden( true )
                    end
                    if CI.SV.BarShowLabel then
                        local remain = g_toggledSlotsRemain[abilityId] - currentTime
                        g_uiCustomToggle[g_toggledSlots[abilityId]].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
                    end
                end
            end
        end
    end
end

function CI.CreateCastBar()
    uiTlw.castBar = UI.TopLevel( nil, nil )

    uiTlw.castBar:SetDimensions( CI.SV.CastBarSizeW + CI.SV.CastBarIconSize + 4, CI.SV.CastBarSizeH )

    -- Setup Preview
    uiTlw.castBar.preview = LUIE.UI.Backdrop( uiTlw.castBar, "fill", nil, nil, nil, true )
    uiTlw.castBar.previewLabel = UI.Label( uiTlw.castBar.preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", "Cast Bar", false )

    -- Callback used to hide anchor coords preview label on movement start
    local tlwOnMoveStart = function(self)
        eventManager:RegisterForUpdate( moduleName .. "previewMove", 200, function()
            self.preview.anchorLabel:SetText(strformat("<<1>>, <<2>>", self:GetLeft(), self:GetTop()))
        end)
    end
    -- Callback used to save new position of frames
    local tlwOnMoveStop = function(self)
        eventManager:UnregisterForUpdate( moduleName .. "previewMove" )
        CI.SV.CastbarOffsetX = self:GetLeft()
        CI.SV.CastbarOffsetY = self:GetTop()
        CI.SV.CastBarCustomPosition = { self:GetLeft(), self:GetTop() }
    end

    uiTlw.castBar:SetHandler( "OnMoveStart", tlwOnMoveStart )
    uiTlw.castBar:SetHandler( "OnMoveStop", tlwOnMoveStop )

    uiTlw.castBar.preview.anchorTexture = UI.Texture( uiTlw.castBar.preview, {TOPLEFT,TOPLEFT}, {16,16}, "/esoui/art/reticle/border_topleft.dds", DL_OVERLAY, false )
    uiTlw.castBar.preview.anchorTexture:SetColor(1, 1, 0, 0.9)

    uiTlw.castBar.preview.anchorLabel = UI.Label( uiTlw.castBar.preview, {BOTTOMLEFT,TOPLEFT,0,-1}, nil, {0,2}, "ZoFontGameSmall", "xxx, yyy", false )
    uiTlw.castBar.preview.anchorLabel:SetColor(1, 1, 0 , 1)
    uiTlw.castBar.preview.anchorLabel:SetDrawLayer(DL_OVERLAY)
    uiTlw.castBar.preview.anchorLabel:SetDrawTier(1)
    uiTlw.castBar.preview.anchorLabelBg = UI.Backdrop(  uiTlw.castBar.preview.anchorLabel, "fill", nil, {0,0,0,1}, {0,0,0,1}, false )
    uiTlw.castBar.preview.anchorLabelBg:SetDrawLayer(DL_OVERLAY)
    uiTlw.castBar.preview.anchorLabelBg:SetDrawTier(0)

    local fragment = ZO_HUDFadeSceneFragment:New(uiTlw.castBar, 0, 0)

    sceneManager:GetScene("hud"):AddFragment( fragment )
    sceneManager:GetScene("hudui"):AddFragment( fragment )
    sceneManager:GetScene("siegeBar"):AddFragment( fragment )
    sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )

    castbar = UI.Backdrop( uiTlw.castBar, nil, nil, {0,0,0,0.5}, {0,0,0,1}, false )
    castbar:SetAnchor(LEFT, uiTlw.castBar, LEFT)

    castbar.starts = 0
    castbar.ends = 0
    castbar.remain = 0

    castbar:SetDimensions( CI.SV.CastBarIconSize, CI.SV.CastBarIconSize )

    castbar.back = UI.Texture( castbar, nil, nil, "/esoui/art/actionbar/abilityframe64_up.dds", nil, false )
    castbar.back:SetAnchor(TOPLEFT, castbar, TOPLEFT)
    castbar.back:SetAnchor(BOTTOMRIGHT, castbar, BOTTOMRIGHT)

    castbar.iconbg = UI.Texture( castbar, nil, nil, "/esoui/art/actionbar/abilityinset.dds", DL_CONTROLS, false )
    castbar.iconbg = UI.Backdrop( castbar, nil, nil, {0,0,0,0.9}, {0,0,0,0.9}, false )
    castbar.iconbg:SetDrawLevel(DL_CONTROLS)
    castbar.iconbg:SetAnchor( TOPLEFT, castbar, TOPLEFT, 3, 3)
    castbar.iconbg:SetAnchor( BOTTOMRIGHT, castbar, BOTTOMRIGHT, -3, -3)

    castbar.icon = UI.Texture( castbar, nil, nil, "/esoui/art/icons/icon_missing.dds", DL_CONTROLS, false )
    castbar.icon:SetAnchor( TOPLEFT, castbar, TOPLEFT, 3, 3 )
    castbar.icon:SetAnchor( BOTTOMRIGHT, castbar, BOTTOMRIGHT, -3, -3 )

    castbar.bar = {
        ["backdrop"] = UI.Backdrop( castbar, nil, {CI.SV.CastBarSizeW, CI.SV.CastBarSizeH}, nil, nil, false ),
        ["bar"] = UI.StatusBar( castbar, nil, {CI.SV.CastBarSizeW-4, CI.SV.CastBarSizeH-4}, nil, false ),
        ["name"] = UI.Label( castbar, nil, nil, nil, nil, g_castbarFont, false ),
        ["timer"] = UI.Label( castbar, nil, nil, nil, nil, g_castbarFont, false ),
    }
    castbar.id = 0

    castbar.bar.backdrop:SetEdgeTexture("",8,2,2)
    castbar.bar.backdrop:SetDrawLayer(DL_BACKDROP)
    castbar.bar.backdrop:SetDrawLevel(1)
    castbar.bar.bar:SetMinMax(0, 1)
    castbar.bar.backdrop:SetCenterColor((0.1*.50), (0.1*.50), (0.1*.50), 0.75)
    castbar.bar.bar:SetGradientColors( 0, 47/255, 130/255, 1, 82/255, 215/255, 1, 1)
    castbar.bar.backdrop:SetCenterColor((0.1*CI.SV.CastBarGradientC1[1]), (0.1*CI.SV.CastBarGradientC1[2]), (0.1*CI.SV.CastBarGradientC1[3]), 0.75)
    castbar.bar.bar:SetGradientColors( CI.SV.CastBarGradientC1[1], CI.SV.CastBarGradientC1[2], CI.SV.CastBarGradientC1[3], 1, CI.SV.CastBarGradientC2[1], CI.SV.CastBarGradientC2[2], CI.SV.CastBarGradientC2[3], 1)

    castbar.bar.backdrop:ClearAnchors()
    castbar.bar.backdrop:SetAnchor(LEFT, castbar, RIGHT, 4, 0 )

    castbar.bar.timer:ClearAnchors()
    castbar.bar.timer:SetAnchor(RIGHT, castbar.bar.backdrop, RIGHT, -4, 0 )
    castbar.bar.timer:SetHidden(true)

    castbar.bar.name:ClearAnchors()
    castbar.bar.name:SetAnchor(LEFT, castbar.bar.backdrop, LEFT, 4, 0 )
    castbar.bar.name:SetHidden(true)

    castbar.bar.bar:SetTexture(LUIE.StatusbarTextures[CI.SV.CastBarTexture])
    castbar.bar.bar:ClearAnchors()
    castbar.bar.bar:SetAnchor(CENTER, castbar.bar.backdrop, CENTER, 0, 0)
    castbar.bar.bar:SetAnchor(CENTER, castbar.bar.backdrop, CENTER, 0, 0)

    castbar.bar.timer:SetText("Timer")
    castbar.bar.name:SetText("Name")

    castbar:SetHidden(true)
end

function CI.ResizeCastBar()
    uiTlw.castBar:SetDimensions( CI.SV.CastBarSizeW + CI.SV.CastBarIconSize + 4, CI.SV.CastBarSizeH )
    castbar:ClearAnchors()
    castbar:SetAnchor(LEFT, uiTlw.castBar, LEFT)

    castbar:SetDimensions( CI.SV.CastBarIconSize, CI.SV.CastBarIconSize )
    castbar.bar.backdrop:SetDimensions(CI.SV.CastBarSizeW, CI.SV.CastBarSizeH)
    castbar.bar.bar:SetDimensions(CI.SV.CastBarSizeW-4, CI.SV.CastBarSizeH-4)

    castbar.bar.backdrop:ClearAnchors()
    castbar.bar.backdrop:SetAnchor(LEFT, castbar, RIGHT, 4, 0 )

    castbar.bar.timer:ClearAnchors()
    castbar.bar.timer:SetAnchor(RIGHT, castbar.bar.backdrop, RIGHT, -4, 0 )

    castbar.bar.name:ClearAnchors()
    castbar.bar.name:SetAnchor(LEFT, castbar.bar.backdrop, LEFT, 4, 0 )

    castbar.bar.bar:ClearAnchors()
    castbar.bar.bar:SetAnchor(CENTER, castbar.bar.backdrop, CENTER, 0, 0)
    castbar.bar.bar:SetAnchor(CENTER, castbar.bar.backdrop, CENTER, 0, 0)

    CI.SetCastBarPosition()
end

function CI.UpdateCastBar()
    castbar.bar.name:SetFont(g_castbarFont)
    castbar.bar.timer:SetFont(g_castbarFont)
    castbar.bar.bar:SetTexture(LUIE.StatusbarTextures[CI.SV.CastBarTexture])
    castbar.bar.backdrop:SetCenterColor((0.1*CI.SV.CastBarGradientC1[1]), (0.1*CI.SV.CastBarGradientC1[2]), (0.1*CI.SV.CastBarGradientC1[3]), 0.75)
    castbar.bar.bar:SetGradientColors( CI.SV.CastBarGradientC1[1], CI.SV.CastBarGradientC1[2], CI.SV.CastBarGradientC1[3], 1, CI.SV.CastBarGradientC2[1], CI.SV.CastBarGradientC2[2], CI.SV.CastBarGradientC2[3], 1)
end

function CI.ResetCastBarPosition()
    if not CI.Enabled then
        return
    end
    CI.SV.CastbarOffsetX = nil
    CI.SV.CastbarOffsetY = nil
    CI.SV.CastBarCustomPosition = nil
    CI.SetCastBarPosition()
end

function CI.SetCastBarPosition()
    if uiTlw.castBar and uiTlw.castBar:GetType() == CT_TOPLEVELCONTROL then
        uiTlw.castBar:ClearAnchors()

        if CI.SV.CastbarOffsetX ~= nil and CI.SV.CastbarOffsetY ~= nil then
            uiTlw.castBar:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, CI.SV.CastbarOffsetX, CI.SV.CastbarOffsetY )
        else
            uiTlw.castBar:SetAnchor( CENTER, GuiRoot, CENTER, 0, 320 )
        end
    end

    local savedPos = CI.SV.CastBarCustomPosition
    uiTlw.castBar.preview.anchorLabel:SetText( ( savedPos ~= nil and #savedPos == 2 ) and strformat("<<1>>, <<2>>", savedPos[1], savedPos[2]) or "default" )
end

function CI.SetMovingState(state)
    if not CI.Enabled then
        return
    end
    CI.CastBarUnlocked = state
    if uiTlw.castBar and uiTlw.castBar:GetType() == CT_TOPLEVELCONTROL then
        CI.GenerateCastbarPreview(state)
        uiTlw.castBar:SetMouseEnabled( state )
        uiTlw.castBar:SetMovable( state )
    end
end

-- Called by CI.SetMovingState from the menu as well as by CI.OnUpdateCastbar when preview is enabled
function CI.GenerateCastbarPreview(state)
    local previewIcon = 'esoui/art/icons/icon_missing.dds'
    castbar.icon:SetTexture(previewIcon)
    if CI.SV.CastBarLabel then
        local previewName = "Test"
        castbar.bar.name:SetText(previewName)
        castbar.bar.name:SetHidden( not state )
    end
    if CI.SV.CastBarTimer then
        castbar.bar.timer:SetText( strfmt("1.0") )
        castbar.bar.timer:SetHidden ( not state )
    end
    castbar.bar.bar:SetValue( 1 )

    uiTlw.castBar.preview:SetHidden( not state )
    uiTlw.castBar:SetHidden( not state )
    castbar:SetHidden( not state )
end

function CI.SoulGemResurrectionStart(eventCode, durationMs)
    -- Just in case any other casts are present - stop them first
    CI.StopCastBar()

    -- Set all parameters and start cast bar
    local icon = 'esoui/art/icons/achievement_frostvault_death_challenge.dds'
    local name = A.Innate_Soul_Gem_Resurrection
    local duration = durationMs

    local currentTime = GetGameTimeMilliseconds()
    local endTime = currentTime + duration
    local remain = endTime - currentTime

    castbar.remain = endTime
    castbar.starts = currentTime
    castbar.ends = endTime
    castbar.icon:SetTexture(icon)
    castbar.type = 1 -- CAST
    castbar.bar.bar:SetValue(0)

    if CI.SV.CastBarLabel then
        castbar.bar.name:SetText(name)
        castbar.bar.name:SetHidden(false)
    end
    if CI.SV.CastBarTimer then
        castbar.bar.timer:SetText( strfmt("%.1f", remain/1000) )
        castbar.bar.timer:SetHidden(false)
    end

    castbar:SetHidden(false)
    g_casting = true
    eventManager:RegisterForUpdate(moduleName.."CI_CASTBAR", 20, CI.OnUpdateCastbar )
end

function CI.SoulGemResurrectionEnd(eventCode)
    CI.StopCastBar()
end

-- Very basic handler registered to only read CC events on the player
function CI.OnCombatEventBreakCast( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    -- Some cast/channel abilities (or effects we use to simulate this) stun the player - ignore the effects of these ids when this happens.
    if CBT.IgnoreCastBarStun[abilityId] then return end

    if CBT.IgnoreCastBreakingActions[castbar.id] then return end

    if not CBT.IsCast[abilityId] then
        CI.StopCastBar()
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

    -- Bail out past here if the source isn't player, cast bar is disabled, or the ability is not on the list of abilities to show the cast bar for
    if sourceType ~= COMBAT_UNIT_TYPE_PLAYER and not CBT.CastOverride[abilityId] then
        return
    end

    if not CI.SV.CastBarEnable then
        return
    end

    -- Stop when a cast breaking action is detected
    if CBT.CastBreakingActions[abilityId] then
        if not CBT.IgnoreCastBreakingActions[castbar.id] then
            CI.StopCastBar()
        end
    end

    if not CBT.IsCast[abilityId] then
        return
    end

    local icon = GetAbilityIcon(abilityId)
    local name = strformat("<<C:1>>", GetAbilityName(abilityId))

    local duration
    local channeled, castTime, channelTime = GetAbilityCastInfo(abilityId)
    local forceChanneled = false
    -- Override certain things to display as a channel rather than cast. Note only works for events where we override the duration.
    if CBT.CastChannelOverride[abilityId] then
        channeled = true
    end
    if channeled then
        duration = CBT.CastDurationFix[abilityId] or channelTime
    else
        duration = CBT.CastDurationFix[abilityId] or castTime
    end

    -- End the cast bar and restart if a new begin event is detected and the effect isn't a channel or fake cast
    if result == ACTION_RESULT_BEGIN and not channeled and not CBT.CastDurationFix[abilityId] then
        CI.StopCastBar()
    elseif result == ACTION_RESULT_EFFECT_GAINED and channeled then
        CI.StopCastBar()
    end

    if CBT.CastChannelConvert[abilityId] then
        channeled = true
        forceChanneled = true
        duration = CBT.CastDurationFix[abilityId] or castTime
    end

    -- Some abilities cast into a channeled stun effect - we want these abilities to display the cast and channel if flagged.
    -- Only flags on ACTION_RESULT_BEGIN so this won't interfere with the stun result that is converted to display a channeled cast.
    if CBT.MultiCast[abilityId] then
        if result == 2200 then
            channeled = false
            duration = castTime or 0
        elseif result == 2240 then
            CI.StopCastBar() -- Stop the cast bar when the GAINED event happens so that we can display the channel when the cast ends
        end
    end

    if abilityId == 39033 or abilityId == 39477 then
        local skillType, skillIndex, abilityIndex, morphChoice, rankIndex = GetSpecificSkillAbilityKeysByAbilityId(32455)
        name, icon = GetSkillAbilityInfo(skillType, skillIndex, abilityIndex)
        if abilityId == 39477 then
            name = strformat("<<1>> <<2>>", A.Skill_Remove, name)
        end
    end

    if duration > 0 and not g_casting then
        -- If action result is BEGIN and not channeled then start, otherwise only use GAINED
        if ( not forceChanneled and ( ( (result == 2200 or result == 2210) and not channeled ) or (result == 2240 and (CBT.CastDurationFix[abilityId] or channeled) ) ) ) or (forceChanneled and result == 2200) then -- and CI.SV.CastBarCast
            local currentTime = GetGameTimeMilliseconds()
            local endTime = currentTime + duration
            local remain = endTime - currentTime

            castbar.remain = endTime
            castbar.starts = currentTime
            castbar.ends = endTime
            castbar.icon:SetTexture(icon)
            castbar.id = abilityId

            if channeled then
                castbar.type = 2 -- CHANNEL
                castbar.bar.bar:SetValue(1)
            else
                castbar.type = 1 -- CAST
                castbar.bar.bar:SetValue(0)
            end
            if CI.SV.CastBarLabel then
                castbar.bar.name:SetText(name)
                castbar.bar.name:SetHidden(false)
            end
            if CI.SV.CastBarTimer then
                castbar.bar.timer:SetText( strfmt("%.1f", remain/1000) )
                castbar.bar.timer:SetHidden(false)
            end

            castbar:SetHidden(false)
            g_casting = true
            eventManager:RegisterForUpdate(moduleName.."CI_CASTBAR", 20, CI.OnUpdateCastbar )
        end
    end

    -- Fix to lower the duration of the next cast of Profane Symbol quest ability for Scion of the Blood Matron (Vampire)
    if abilityId == 39507 then
        CBT.CastDurationFix[39507] = 19500
    end
end

--[[
function CI.OnCombatEventSpecialFilters( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    CI.StopCastBar()
end
]]--

function CI.OnCombatEventBar( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    -- If the source/target isn't the player then bail out now.
    if sourceType ~= COMBAT_UNIT_TYPE_PLAYER and targetType ~= COMBAT_UNIT_TYPE_PLAYER then
        return
    end

    if sourceType == COMBAT_UNIT_TYPE_PLAYER and targetType == COMBAT_UNIT_TYPE_PLAYER then
        g_toggledSlotsPlayer[abilityId] = true
    end

    if result == ACTION_RESULT_BEGIN or result == ACTION_RESULT_EFFECT_GAINED or result == ACTION_RESULT_EFFECT_GAINED_DURATION then
        local currentTime = GetGameTimeMilliseconds()
        if g_toggledSlots[abilityId] then
            if CI.SV.ShowToggled then
                local duration = GetUpdatedAbilityDuration(abilityId)
                local endTime = currentTime + duration
                g_toggledSlotsRemain[abilityId] = endTime
                CI.ShowCustomToggle(g_toggledSlots[abilityId])
                if g_toggledSlots[abilityId] == 8 and CI.SV.UltimatePctEnabled then
                    uiUltimate.LabelPct:SetHidden( true )
                end
                if CI.SV.BarShowLabel then
                    local remain = g_toggledSlotsRemain[abilityId] - currentTime
                    g_uiCustomToggle[g_toggledSlots[abilityId]].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
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

function CI.OnSlotUpdated(eventCode, slotNum, wasfullUpdate)
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
        return
    end

    -- Get the slotted ability ID
    local ability_id = GetSlotBoundId(slotNum)
    local showFakeAura = (E.BarHighlightOverride[ability_id] and E.BarHighlightOverride[ability_id].showFakeAura)

    -- If secondary effects aren't set to display then don't setup highlight for this slot.
    if (E.BarHighlightOverride[ability_id] and E.BarHighlightOverride[ability_id].secondary) and not CI.SV.ShowToggledSecondary then
        return
    end

    if E.BarHighlightOverride[ability_id] then
        if E.BarHighlightOverride[ability_id].hide then
            return
        end
        if E.BarHighlightOverride[ability_id].newId then
            ability_id = E.BarHighlightOverride[ability_id].newId
        end
    end
    local abilityName = E.EffectOverride[ability_id] and E.EffectOverride[ability_id].name or GetAbilityName(ability_id) -- GetSlotName(slotNum)
    --local _, _, channel = GetAbilityCastInfo(ability_id)
    local duration = GetUpdatedAbilityDuration(ability_id)

    local currentTime = GetGameTimeMilliseconds()

    -- Check if currently this ability is in proc state
    local proc = E.HasAbilityProc[abilityName]
    if E.IsAbilityProc[GetSlotBoundId(slotNum)] then
        if CI.SV.ShowTriggered then
            CI.PlayProcAnimations(slotNum)
            if CI.SV.ProcEnableSound then
                if not wasfullUpdate then
                    PlaySound(g_procSound)
                    PlaySound(g_procSound)
                end
            end
        end
    elseif proc then
        g_triggeredSlots[proc] = slotNum
         if g_triggeredSlotsRemain[proc] then
            if CI.SV.ShowTriggered then
                CI.PlayProcAnimations(slotNum)
                if CI.SV.BarShowLabel then
                    local remain = g_triggeredSlotsRemain[proc] - currentTime
                    g_uiProcAnimation[slotNum].procLoopTexture.label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
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
                    local remain = g_toggledSlotsRemain[ability_id] - currentTime
                    g_uiCustomToggle[slotNum].label:SetText( strfmt(CI.SV.BarMiilis and "%.1f" or "%.1d", remain/1000) )
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

    -- if this event was caused only by user manually changing the ultimate ability, then
    -- force recalculation of percent value. Otherwise (weapons swap) this will be called by the game
    if ( (eventCode == EVENT_ACTION_SLOT_UPDATED or EVENT_ACTION_SLOTS_ACTIVE_HOTBAR_UPDATED or EVENT_ACTION_SLOTS_ALL_HOTBARS_UPDATED) and not setHidden ) then
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

    -- Don't update bars if this full update event was from using an inventory item
    if g_potionUsed == true then return end

    -- Update action bar skills
    for i = 3, 8 do
        CI.OnSlotUpdated(eventCode, i, true)
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
        procLoopTexture.label:SetAnchor(TOPLEFT, actionButton.slot)
        procLoopTexture.label:SetAnchor(BOTTOMRIGHT, actionButton.slot, nil, 0, -CI.SV.BarLabelPosition)
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
        local name = "ActionButton" .. slotNum .. "Toggle_LUIE"
        local window = windowManager:GetControlByName(name) -- Check to see if this frame already exists, don't create it if it does.
        if window == nil then
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
            toggleFrame.label:SetAnchor(TOPLEFT, actionButton.slot)
            toggleFrame.label:SetAnchor(BOTTOMRIGHT, actionButton.slot, nil, 0, -CI.SV.BarLabelPosition)
            toggleFrame.label:SetDrawLayer(DL_COUNT)
            toggleFrame.label:SetDrawLevel(1)
            toggleFrame.label:SetDrawTier(3)
            toggleFrame.label:SetColor( unpack( CI.SV.RemainingTextColoured and colour or {1,1,1,1} ) )
            toggleFrame.label:SetHidden(false)

            g_uiCustomToggle[slotNum] = toggleFrame
        end
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
    local pct = ( g_ultimateCost > 0 ) and math.floor( ( powerValue / g_ultimateCost ) * 100 ) or 0
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
