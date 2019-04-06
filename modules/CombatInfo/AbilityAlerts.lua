--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local CI            = LUIE.CombatInfo
local UI            = LUIE.UI
local C             = LUIE.CombatTextConstants
local E             = LUIE.Effects
local AlertT        = LUIE.AlertTable
local callLater = zo_callLater
local refireDelay = { }
local CT     = LUIE.CombatText
local alertTypes = LUIE.CombatTextConstants.alertType

local eventManager  = EVENT_MANAGER
local sceneManager  = SCENE_MANAGER
local windowManager = WINDOW_MANAGER
local strfmt = string.format

local moduleName    = LUIE.name .. "_CombatInfo"

local uiTlw         = {} -- GUI

-- Create Alert Frame - basic setup for now
function CI.CreateAlertFrame()

    -- Temporary font configuration
    local barFontName = LUIE.Fonts[CI.SV.BarFontFace]
    if not barFontName or barFontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        barfontName = "$(MEDIUM_FONT)"
    end
    local barFontStyle = ( CI.SV.BarFontStyle and CI.SV.BarFontStyle ~= "" ) and CI.SV.BarFontStyle or "outline"
    local barFontSize = 24
    local g_barFont = barFontName .. "|" .. barFontSize .. "|" .. barFontStyle
    --

    -- Create Top Level Controls
    uiTlw.AlertFrame = UI.TopLevel( { CENTER, CENTER, 0 , -250, GuiRoot }, nil )
    uiTlw.AlertFrame:SetHandler( "OnMoveStop", function(self)
            CI.SV.AlertFrameX = self:GetLeft()
            CI.SV.AlertFrameY = self:GetTop()
        end )

    -- Create 3 alert labels
    local anchor = { CENTER, CENTER, 0, 0, uiTlw.AlertFrame }
    local height = (barFontSize * 2)
    for i = 1, 3 do
        local alert = UI.Label( uiTlw.AlertFrame, anchor, { 1400, height }, nil, g_barFont, "", false, "LUIE_Alert" .. i )
        alert.available = true
        anchor = { TOP, BOTTOM, 0, 0, alert }
    end

    local fragment = ZO_HUDFadeSceneFragment:New(uiTlw.AlertFrame, 0, 0)

    sceneManager:GetScene("hud"):AddFragment( fragment )
    sceneManager:GetScene("hudui"):AddFragment( fragment )
    sceneManager:GetScene("siegeBar"):AddFragment( fragment )
    sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )

    -- Register Events
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, CI.OnPlayerActivated)
    eventManager:RegisterForEvent(moduleName, EVENT_COMBAT_EVENT, CI.OnCombatIn)
    eventManager:AddFilterForEvent(moduleName .. "Combat", EVENT_COMBAT_EVENT, REGISTER_FILTER_TARGET_COMBAT_UNIT_TYPE, COMBAT_UNIT_TYPE_PLAYER)
    eventManager:RegisterForEvent(moduleName, EVENT_EFFECT_CHANGED, CI.EffectChanged)

    for abilityId, data in pairs (AlertT) do
        if data.eventdetect == true then
            eventManager:RegisterForEvent(moduleName .. abilityId, EVENT_COMBAT_EVENT, CI.OnCombatAlert)
            eventManager:AddFilterForEvent(moduleName .. abilityId, EVENT_COMBAT_EVENT, REGISTER_FILTER_ABILITY_ID, abilityId, REGISTER_FILTER_IS_ERROR, false)
        end
    end

    eventManager:RegisterForUpdate(moduleName.."CI_ALERT_UPDATE", 100, CI.AlertUpdate )

end

local isWarned = {
    cleanse         = false,
}

-- Update ticker for Alerts
function CI.AlertUpdate()
    for i = 1, 3 do
        if _G["LUIE_Alert" .. i].duration then

            if i > 1 and _G["LUIE_Alert" .. i - 1].available == true then
                _G["LUIE_Alert" .. i - 1].duration = _G["LUIE_Alert" .. i].duration
                _G["LUIE_Alert" .. i - 1].showDuration = _G["LUIE_Alert" .. i].showDuration
                _G["LUIE_Alert" .. i - 1].text = _G["LUIE_Alert" .. i].text
                _G["LUIE_Alert" .. i - 1].available = false
                _G["LUIE_Alert" .. i - 1]:SetHidden(false)
                _G["LUIE_Alert" .. i].available = true
                _G["LUIE_Alert" .. i]:SetHidden(true)
                _G["LUIE_Alert" .. i].text = nil
                _G["LUIE_Alert" .. i].duration = nil
                _G["LUIE_Alert" .. i].showDuration = nil
                i = i - 1
            end

            _G["LUIE_Alert" .. i].duration = _G["LUIE_Alert" .. i].duration - 100
            if _G["LUIE_Alert" .. i].showDuration then
                _G["LUIE_Alert" .. i]:SetText(_G["LUIE_Alert" .. i].text .. " " .. strfmt("%.1f", _G["LUIE_Alert" .. i].duration/1000) )
            end
            if _G["LUIE_Alert" .. i].duration <= 0 then
                _G["LUIE_Alert" .. i]:SetHidden(true)
                _G["LUIE_Alert" .. i].text = nil
                _G["LUIE_Alert" .. i].duration = nil
                _G["LUIE_Alert" .. i].available = true
            end
        end
    end
end

local drawLocation = 1

function CI.SetupSingleAlertFrame(text, duration, showDuration)
    for i = 1, 3 do
        if _G["LUIE_Alert" .. i].available then
            _G["LUIE_Alert" .. i].text = text
            _G["LUIE_Alert" .. i].duration = duration
            _G["LUIE_Alert" .. i].showDuration = showDuration
            _G["LUIE_Alert" .. i]:SetText(showDuration and (text .. " " .. strfmt("%.1f", duration/1000)) or text)
            _G["LUIE_Alert" .. i]:SetHidden(false)
            _G["LUIE_Alert" .. i].available = false
            drawLocation = 1 -- As long as this text is filling an available spot, we reset the draw over location to slot 1. If all slots are filled then the draw over code below will cycle and handle abilities.
            return
        end
    end
    -- If no alert frame is available, then draw over in the first spot
    _G["LUIE_Alert" .. drawLocation].text = text
    _G["LUIE_Alert" .. drawLocation].duration = duration
    _G["LUIE_Alert" .. drawLocation].showDuration = showDuration
    _G["LUIE_Alert" .. drawLocation]:SetText(showDuration and (text .. " " .. strfmt("%.1f", duration/1000)) or text)
    _G["LUIE_Alert" .. drawLocation]:SetHidden(false)
    _G["LUIE_Alert" .. drawLocation].available = false
    drawLocation = drawLocation +1
    if drawLocation > 3 then
        drawLocation = 1
    end
end

function CI.ProcessAlert(abilityId, unitName)
    local S = LUIE.CombatText.SV

    -- Just in case
    if not AlertT[abilityId] then return end
    -- Ignore this event if we are on refire delay (whether from delay input in the table or from a "bad" event processing)
    if refireDelay[abilityId] then return end

    -- Setup refire delay
    if AlertT[abilityId].refire then
        refireDelay[abilityId] = true
        callLater(function() refireDelay[abilityId] = nil end, AlertT[abilityId].refire) --buffer by X time
    end

    -- Auto refire for auras to stop events when both reticleover and the unit exist
    if AlertT[abilityId].auradetect then
        refireDelay[abilityId] = true
        callLater(function() refireDelay[abilityId] = nil end, 250) --buffer by X time
    end

    -- Get Ability Name & Icon
    local abilityName = GetAbilityName(abilityId)
    local abilityIcon = GetAbilityIcon(abilityId)
    local formattedIcon
    unitName = zo_strformat("<<t:1>>", unitName)

    -- Handle effects that override by UnitName
    if E.EffectOverrideByName[abilityId] then
        if E.EffectOverrideByName[abilityId][unitName] then
            if E.EffectOverrideByName[abilityId][unitName].icon then
                abilityIcon = E.EffectOverrideByName[abilityId][unitName].icon
            end
            if E.EffectOverrideByName[abilityId][unitName].name then
                abilityName = E.EffectOverrideByName[abilityId][unitName].name
            end
        end
    end

    -- Handle effects that override by ZoneId
    if E.MapDataOverride[abilityId] then
        local index = GetCurrentMapZoneIndex()
        if E.MapDataOverride[abilityId][index] then
            if E.MapDataOverride[abilityId][index].name then
                abilityName = E.MapDataOverride[abilityId][index].name
            end
            if E.MapDataOverride[abilityId][index].icon then
                abilityIcon = E.MapDataOverride[abilityId][index].icon
            end
        end
    end

    -- Override unitName here if we utilize a fakeName / bossName
    unitName = zo_strformat("<<t:1>>", unitName)

    if AlertT[abilityId].fakeName then
        unitName = AlertT[abilityId].fakeName
    end
    if AlertT[abilityId].bossName and DoesUnitExist('boss1') then
        unitName = zo_strformat("<<t:1>>", GetUnitName('boss1'))
    end

    if AlertT[abilityId].bossMatch then
        for i = 1, 4 do
            local bossName = DoesUnitExist('boss' .. i) and zo_strformat("<<t:1>>", GetUnitName('boss' .. i)) or ""
            if bossName == AlertT[abilityId].bossMatch then
                unitName = AlertT[abilityId].bossMatch
            end
        end
    end

    formattedIcon = zo_iconFormat(abilityIcon, 32, 32)

    local isDirect
    local block
    local blockstagger
    local dodge
    local avoid
    local interrupt
    local power
    local destroy
    local summon
    local unmit
    local duration

    if AlertT[abilityId].notDirect then
        isDirect = false
    else
        isDirect = true
    end

    if AlertT[abilityId].block and (S.toggles.showAlertBlock) == true then
        if AlertT[abilityId].bs then
            blockstagger = true
        else
            block = true
        end
    end
    if AlertT[abilityId].dodge and (S.toggles.showAlertDodge) == true then
        dodge = true
    end
    if AlertT[abilityId].avoid and (S.toggles.showAlertDodge) == true then
        avoid = true
    end
    if AlertT[abilityId].interrupt and (S.toggles.showAlertInterrupt) == true then
        interrupt = true
    end
    if AlertT[abilityId].unmit and (S.toggles.showAlertUnmit) == true then
        unmit = true
    end
    if AlertT[abilityId].power and (S.toggles.showAlertPower) == true then
        power = true
    end
    if AlertT[abilityId].destroy and (S.toggles.showAlertDestroy) == true then
        destroy = true
    end
    if AlertT[abilityId].summon and (S.toggles.showAlertSummon) == true then
        summon = true
    end
    if AlertT[abilityId].duration then
        duration = AlertT[abilityId].duration
    end

    if S.toggles.mitigationType == "Single Line" and not (power == true or destroy == true or summon == true or unmit == true) then
        CI.OnEvent(C.alertType.SHARED, abilityName, formattedIcon, unitName, isDirect, duration, block, blockstagger, dodge, avoid, interrupt)
    elseif S.toggles.mitigationType == "Multiple Lines" or (power == true or destroy == true or summon == true or unmit == true) then
        if block and not blockstagger then
            CI.OnEvent(C.alertType.BLOCK, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if blockstagger then
            CI.OnEvent(C.alertType.BLOCKSTAGGER, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if dodge then
            CI.OnEvent(C.alertType.DODGE, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if avoid then
            CI.OnEvent(C.alertType.AVOID, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if interrupt then
            CI.OnEvent(C.alertType.INTERRUPT, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if unmit then
            CI.OnEvent(C.alertType.UNMIT, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if power then
            CI.OnEvent(C.alertType.POWER, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if destroy then
            CI.OnEvent(C.alertType.DESTROY, abilityName, formattedIcon, unitName, isDirect, duration)
        end
        if summon then
            CI.OnEvent(C.alertType.SUMMON, abilityName, formattedIcon, unitName, isDirect, duration)
        end
    end
end

function CI.EffectChanged(eventCode, changeType, effectSlot, effectName, unitTag, beginTime, endTime, stackCount, iconName, buffType, effectType, abilityType, statusEffectType, unitName, unitId, abilityId, castByPlayer)
    local S, combatType, togglesInOut = LUIE.CombatText.SV, nil, nil

    if S.toggles.showAlertMitigation and (S.toggles.mitigationAura or IsUnitInDungeon("player") ) and AlertT[abilityId] and AlertT[abilityId].auradetect then

        if changeType == EFFECT_RESULT_FADED then return end

        -- Don't duplicate events if unitTag is player and in a group.
        if GetGroupSize() > 1 and unitTag == 'player' then return end
        if AlertT[abilityId].noSelf and unitName == LUIE.PlayerNameRaw then return end

        if changeType == EFFECT_RESULT_UPDATED and AlertT[abilityId].ignoreRefresh then return end

        callLater(function() CI.ProcessAlert(abilityId, unitName) end, 50)

    end
end

function CI.OnCombatIn(eventCode, resultType, isError, abilityName, abilityGraphic, abilityAction_slotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)

    local S = LUIE.CombatText.SV
    local combatType, togglesInOut = C.combatType.INCOMING, S.toggles.incoming
    abilityName = zo_strformat("<<C:1>>", GetAbilityName(abilityId))
    local abilityIcon = GetAbilityIcon(abilityId)

    -- TODO: Fix this so we only process this information once when also sending to the alert printer.

    local sourceNameCheck = zo_strformat("<<t:1>>", sourceName)

    -- Handle effects that override by UnitName
    if E.EffectOverrideByName[abilityId] then
        if E.EffectOverrideByName[abilityId][sourceNameCheck] then
            if E.EffectOverrideByName[abilityId][sourceNameCheck].icon then
                abilityIcon = E.EffectOverrideByName[abilityId][sourceNameCheck].icon
            end
            if E.EffectOverrideByName[abilityId][sourceNameCheck].name then
                abilityName = E.EffectOverrideByName[abilityId][sourceNameCheck].name
            end
        end
    end

    -- Handle effects that override by ZoneId
    if E.MapDataOverride[abilityId] then
        local index = GetCurrentMapZoneIndex()
        if E.MapDataOverride[abilityId][index] then
            if E.MapDataOverride[abilityId][index].name then
                abilityName = E.MapDataOverride[abilityId][index].name
            end
            if E.MapDataOverride[abilityId][index].icon then
                abilityIcon = E.MapDataOverride[abilityId][index].icon
            end
        end
    end

    local formattedIcon = zo_iconFormat(abilityIcon, 32, 32)

    -- TODO - make sure player is in combat here
    if (isDot and S.toggles.showAlertCleanse and not isWarned.cleanse and not C.isPlayer[sourceType]) and not E.EffectCleanseOverride[abilityId] then
        if E.EffectOverride[abilityId] and E.EffectOverride[abilityId].unbreakable then return end -- Don't display a cleanse alert if this ability is flagged as unbreakable
        self:TriggerEvent(C.eventType.ALERT, C.alertType.CLEANSE, abilityName, formattedIcon)
        isWarned.cleanse = true
        callLater(function() isWarned.cleanse = false end, 5000) --5 second buffer
    end

    -- NEW ALERTS
    if S.toggles.showAlertMitigation and AlertT[abilityId] then
        if sourceName ~= nil and sourceName ~= "" then

            -- Return if any results occur which we absolutely don't want to display alerts for & stop spam when enemy is out of line of sight, etc and trying to cast
            if resultType == ACTION_RESULT_EFFECT_FADED
               or resultType == ACTION_RESULT_ABILITY_ON_COOLDOWN
               or resultType == ACTION_RESULT_BAD_TARGET
               or resultType == ACTION_RESULT_BUSY
               or resultType == ACTION_RESULT_FAILED
               or resultType == ACTION_RESULT_INVALID
               or resultType == ACTION_RESULT_CANT_SEE_TARGET
               or resultType == ACTION_RESULT_TARGET_DEAD
               or resultType == ACTION_RESULT_TARGET_OUT_OF_RANGE
               or resultType == ACTION_RESULT_TARGET_TOO_CLOSE
               or resultType == ACTION_RESULT_TARGET_NOT_IN_VIEW
            then
                refireDelay[abilityId] = true
                callLater(function() refireDelay[abilityId] = nil end, 1000) --buffer by X time
                return
            end

            -- Filter when only a certain event type should fire this
            if AlertT[abilityId].result and resultType ~= AlertT[abilityId].result then return end
            if AlertT[abilityId].eventdetect or AlertT[abilityId].auradetect then return end -- Don't create a duplicate warning if event/aura detection already handles this.
            if AlertT[abilityId].noSelf and targetName == LUIE.PlayerNameRaw then return end -- Don't create alert for self in cases where this is true.

            if AlertT[abilityId].block or AlertT[abilityId].dodge or AlertT[abilityId].avoid or AlertT[abilityId].interrupt or AlertT[abilityId].unmit or AlertT[abilityId].power or AlertT[abilityId].destroy or AlertT[abilityId].summon then

                -- Filter by priority
                if (S.toggles.mitigationDungeon and not IsUnitInDungeon("player")) or not S.toggles.mitigationDungeon then
                    if AlertT[abilityId].priority == 3 and not S.toggles.mitigationRank3 then return end
                    if AlertT[abilityId].priority == 2 and not S.toggles.mitigationRank2 then return end
                    if AlertT[abilityId].priority == 1 and not S.toggles.mitigationRank1 then return end
                end

                callLater(function() CI.ProcessAlert(abilityId, sourceName) end, 50)

            end

        end

    end
    --[[ EXPLOIT ALERT (IF WE NEED TO ADD TO ANY OFF-BALANCE)
    if E.CombatAlertExploit[abilityId] and targetName ~= nil and targetName ~= "" and (C.isPlayer[sourceType]) and resultType == ACTION_RESULT_OFFBALANCE then
        if (S.toggles.showAlertExploit) then
            self:TriggerEvent(C.eventType.ALERT, C.alertType.EXPLOIT, nil)
        end
    end
    ]]--
end

function CI.OnCombatAlert(eventCode, resultType, isError, abilityName, abilityGraphic, abilityAction_slotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId)

    local S = LUIE.CombatText.SV
    local combatType, togglesInOut = C.combatType.INCOMING, S.toggles.incoming

    -- NEW ALERTS
    if S.toggles.showAlertMitigation and (S.toggles.mitigationAura or IsUnitInDungeon("player") ) then
        if not refireDelay[abilityId] then

            -- Return if any results occur which we absolutely don't want to display alerts for & stop spam when enemy is out of line of sight, etc and trying to cast
            if resultType == ACTION_RESULT_EFFECT_FADED
               or resultType == ACTION_RESULT_ABILITY_ON_COOLDOWN
               or resultType == ACTION_RESULT_BAD_TARGET
               or resultType == ACTION_RESULT_BUSY
               or resultType == ACTION_RESULT_FAILED
               or resultType == ACTION_RESULT_INVALID
               or resultType == ACTION_RESULT_CANT_SEE_TARGET
               or resultType == ACTION_RESULT_TARGET_DEAD
               or resultType == ACTION_RESULT_TARGET_OUT_OF_RANGE
               or resultType == ACTION_RESULT_TARGET_TOO_CLOSE
               or resultType == ACTION_RESULT_TARGET_NOT_IN_VIEW
            then
                refireDelay[abilityId] = true
                callLater(function() refireDelay[abilityId] = nil end, 1000) --buffer by X time
                return
            end

            -- Filter when only a certain event type should fire this
            if AlertT[abilityId].result and resultType ~= AlertT[abilityId].result then return end
            if AlertT[abilityId].auradetect then return end -- Don't create a duplicate warning if aura detection already handles this.
            if AlertT[abilityId].noSelf and targetName == LUIE.PlayerNameRaw then return end -- Don't create alert for self in cases where this is true.


            if AlertT[abilityId].block or AlertT[abilityId].dodge or AlertT[abilityId].avoid or AlertT[abilityId].interrupt or AlertT[abilityId].unmit or AlertT[abilityId].power or AlertT[abilityId].destroy or AlertT[abilityId].summon then
                -- Filter by priority
                if (S.toggles.mitigationDungeon and not IsUnitInDungeon("player")) or not S.toggles.mitigationDungeon then
                    if AlertT[abilityId].priority == 3 and not S.toggles.mitigationRank3 then return end
                    if AlertT[abilityId].priority == 2 and not S.toggles.mitigationRank2 then return end
                    if AlertT[abilityId].priority == 1 and not S.toggles.mitigationRank1 then return end
                end

                callLater(function() CI.ProcessAlert(abilityId, sourceName) end, 50)

            end
        end
    end
end

function CI.FormatAlertString(inputFormat, params)
    return string.gsub(inputFormat, '%%.', function(x)
        if (x == '%n') then
            return params.source or ''
        elseif (x == '%t') then
            return params.ability or ''
        elseif (x == '%i') then
            return params.icon or ''
        else
            return x
        end
    end)
end

-- VIEWER
function CI.OnEvent(alertType, abilityName, abilityIcon, sourceName, isDirect, duration, block, blockstagger, dodge, avoid, interrupt)
    local S = LUIE.CombatText.SV

    local size, text
    local labelColor = S.colors.alertShared
	local prefix = (sourceName ~= "" and sourceName ~= nil and sourceName ~= "Offline") and S.toggles.mitigationPrefixN or S.toggles.mitigationPrefix
    local mitigationSuffix = (isDirect and S.toggles.mitigationDefaultSuffix ~= "") and zo_strformat(" <<1>>", S.toggles.mitigationDefaultSuffix) or ""

    -- First we handle Cleanse/Execute/Exploit because these messages are always individual

    --Cleanse
    if (alertType == alertTypes.CLEANSE) then
        labelColor = S.colors.alertCleanse
        size = S.fontSizes.alert
        text = zo_strformat("<<1>> <<2>> - <<3>>", abilityIcon, abilityName, S.formats.alertCleanse)
    --EXECUTE
    elseif (alertType == alertTypes.EXECUTE) then
        labelColor = S.colors.alertExecute
        size = S.fontSizes.alert
        text = S.formats.alertExecute
    --EXPLOIT
    elseif (alertType == alertTypes.EXPLOIT) then
        labelColor = S.colors.alertExploit
        size = S.fontSizes.alert
        text = S.formats.alertExploit
    elseif (alertType == alertTypes.SHARED) then

        size = S.fontSizes.alert

        local spacer = "-"
        local stringBlock
        local stringDodge
        local stringAvoid
        local stringInterrupt
        local color = CT.AlertColors.alertColorBlock

        -- Quickly set only one of these to true for priority color formatting.
        -- PRIORITY: INTERRUPT > BLOCK STAGGER > DODGE > BLOCK > AVOID
        if blockstagger then block = false end

		if not S.toggles.hideMitigation then
			if avoid then
				local color = CT.AlertColors.alertColorAvoid
				stringAvoid = zo_strformat("|c<<1>><<2>>|r <<3>> ", color, S.formats.alertAvoid, spacer)
			else
				stringAvoid = ""
			end

			if block then
				local color = CT.AlertColors.alertColorBlock
				stringBlock = zo_strformat("|c<<1>><<2>>|r <<3>> ", color, S.formats.alertBlock, spacer)
			end

			if dodge then
				local color = CT.AlertColors.alertColorDodge
				stringDodge = zo_strformat("|c<<1>><<2>>|r <<3>> ", color, S.formats.alertDodge, spacer)
			else
				stringDodge = ""
			end

			if blockstagger then
				local color = CT.AlertColors.alertColorBlock
				stringBlock = zo_strformat("|c<<1>><<2>>|r <<3>> ", color, S.formats.alertBlockStagger, spacer)
			end

			if interrupt then
				local color = CT.AlertColors.alertColorInterrupt
				stringInterrupt = zo_strformat("|c<<1>><<2>>|r <<3>> ", color, S.formats.alertInterrupt, spacer)
			else
				stringInterrupt = ""
			end

			if not block and not blockstagger then
				stringBlock = ""
			end
		end

        local stringPart1 = zo_strformat("|cffffff<<1>>|r", CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon }))
        local stringPart2 = mitigationSuffix
        local stringPart3 = S.toggles.hideMitigation and "" or zo_strformat(" <<1>> <<2>><<3>><<4>><<5>>", spacer, stringBlock, stringDodge, stringAvoid, stringInterrupt)

        text = zo_strformat("<<1>><<2>><<3>>", stringPart1, stringPart2, stringPart3)
    --BLOCK
    elseif (alertType == alertTypes.BLOCK) then
        local color = CT.AlertColors.alertColorBlock
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertBlock)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    -- BLOCK STAGGER
    elseif (alertType == alertTypes.BLOCKSTAGGER) then
        local color = CT.AlertColors.alertColorBlock
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertBlockStagger)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    --INTERRUPT
    elseif (alertType == alertTypes.INTERRUPT) then
        local color = CT.AlertColors.alertColorInterrupt
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertInterrupt)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    --DODGE
    elseif (alertType == alertTypes.DODGE) then
        local color = CT.AlertColors.alertColorDodge
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertDodge)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    -- AVOID
    elseif (alertType == alertTypes.AVOID) then
        local color = CT.AlertColors.alertColorAvoid
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertAvoid)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
	-- UNMIT
	elseif (alertType == alertTypes.UNMIT) then
		local color = CT.AlertColors.alertColorUnmit
		size = S.fontSizes.alert
		local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertUnmit)
		if S.toggles.mitigationType == "Single Line" then
			text = zo_strformat("<<1>><<2>> - <<3>> - ", stringPart1, stringPart2, stringPart3)
		else
			text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
		end
    -- POWER
    elseif (alertType == alertTypes.POWER) then
        local color = CT.AlertColors.alertColorPower
		prefix = (sourceName ~= "" and sourceName ~= nil and sourceName ~= "Offline") and S.toggles.mitigationPowerPrefixN or S.toggles.mitigationPowerPrefix
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertPower)
        text = zo_strformat("<<1>> <<2>>", stringPart1, stringPart2)
    -- DESTROY
    elseif (alertType == alertTypes.DESTROY) then
        local color = CT.AlertColors.alertColorDestroy
		prefix = (sourceName ~= "" and sourceName ~= nil and sourceName ~= "Offline") and S.toggles.mitigationDestroyPrefixN or S.toggles.mitigationDestroyPrefix
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertDestroy)
        text = zo_strformat("<<1>> <<2>>", stringPart1, stringPart2)
    -- SUMMON
    elseif (alertType == alertTypes.SUMMON) then
        local color = CT.AlertColors.alertColorSummon
		prefix = (sourceName ~= "" and sourceName ~= nil and sourceName ~= "Offline") and S.toggles.mitigationSummonPrefixN or S.toggles.mitigationSummonPrefix
        size = S.fontSizes.alert
        local stringPart1 = CI.FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertSummon)
        text = zo_strformat("<<1>> <<2>>", stringPart1, stringPart2)
    end

    local showDuration = duration and true or false
    if not duration then duration = 4000 end

    CI.SetupSingleAlertFrame(text, duration, showDuration)

end
