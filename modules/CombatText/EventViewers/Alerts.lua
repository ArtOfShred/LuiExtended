LUIE.CombatTextAlertViewer = LUIE.CombatTextEventViewer:Subclass()
local CTV = LUIE.CombatTextAlertViewer
local CT = LUIE.CombatText
local L = CombatTextLocalization
local callLater = zo_callLater
local poolTypes = LUIE.CombatTextConstants.poolType
local alertTypes = LUIE.CombatTextConstants.alertType

function CTV:New(...)
    local obj = LUIE.CombatTextEventViewer:New(...)
    obj:RegisterCallback(LUIE.CombatTextConstants.eventType.ALERT, function(...) self:OnEvent(...) end)
    self.locationOffset = 0  -- Simple way to avoid overlapping. When number of active notes is back to 0, the offset is also reset
    self.activeAlerts = 0
    return obj
end

function CTV:OnEvent(alertType, abilityName, abilityIcon, sourceName, isDirect, block, blockstagger, dodge, avoid, interrupt)
    local S = LUIE.CombatText.SV

    --Label setup
    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    local size, text
    local labelColor = S.colors.alertShared
	local prefix = (sourceName ~= "" and sourceName ~= nil) and S.toggles.mitigationPrefixN or S.toggles.mitigationPrefix
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

        local stringPart1 = zo_strformat("|cffffff<<1>>|r", self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon }))
        local stringPart2 = mitigationSuffix
        local stringPart3 = S.toggles.hideMitigation and "" or zo_strformat(" <<1>> <<2>><<3>><<4>><<5>>", spacer, stringBlock, stringDodge, stringAvoid, stringInterrupt)

        text = zo_strformat("<<1>><<2>><<3>>", stringPart1, stringPart2, stringPart3)
    --BLOCK
    elseif (alertType == alertTypes.BLOCK) then
        local color = CT.AlertColors.alertColorBlock
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertBlock)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    -- BLOCK STAGGER
    elseif (alertType == alertTypes.BLOCKSTAGGER) then
        local color = CT.AlertColors.alertColorBlock
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertBlockStagger)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    --INTERRUPT
    elseif (alertType == alertTypes.INTERRUPT) then
        local color = CT.AlertColors.alertColorInterrupt
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertInterrupt)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    --DODGE
    elseif (alertType == alertTypes.DODGE) then
        local color = CT.AlertColors.alertColorDodge
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertDodge)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    -- AVOID
    elseif (alertType == alertTypes.AVOID) then
        local color = CT.AlertColors.alertColorAvoid
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = mitigationSuffix
        local stringPart3 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertAvoid)
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    -- POWER
    elseif (alertType == alertTypes.POWER) then
        local color = CT.AlertColors.alertColorPower
		prefix = (sourceName ~= "" and sourceName ~= nil) and S.toggles.mitigationPowerPrefixN or S.toggles.mitigationPowerPrefix
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertPower)
        text = zo_strformat("<<1>> <<2>>", stringPart1, stringPart2)
    -- DESTROY
    elseif (alertType == alertTypes.DESTROY) then
        local color = CT.AlertColors.alertColorDestroy
		prefix = (sourceName ~= "" and sourceName ~= nil) and S.toggles.mitigationDestroyPrefixN or S.toggles.mitigationDestroyPrefix
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(prefix, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = zo_strformat("|c<<1>><<2>>|r", color, S.formats.alertDestroy)
        text = zo_strformat("<<1>> <<2>>", stringPart1, stringPart2)
    end

    self:PrepareLabelAlert(control.label, size, labelColor, text)
    self:ControlLayout(control)

    --Control setup
    control:SetAnchor(CENTER, LUIE_CombatText_Alert, TOP, 0, self.locationOffset * (S.fontSizes.alert + 5))
    self.locationOffset = self.locationOffset + 1
    self.activeAlerts = self.activeAlerts + 1
    -- Move back up if we hit 5 alerts active at once.
    if self.locationOffset == 5 then
        self.locationOffset = 0
    end

    --Get animation
    local animationPoolType = poolTypes.ANIMATION_ALERT
    local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)
    animation:Apply(control)
    animation:Play()

    --Add items back into pool after animation
    callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
        self.activeAlerts = self.activeAlerts - 1
        if (self.activeAlerts == 0) then self.locationOffset = 0 end
    end, animation:GetDuration())
end
