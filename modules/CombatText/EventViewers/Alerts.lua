LUIE.CombatTextAlertViewer = LUIE.CombatTextEventViewer:Subclass()
local CTV = LUIE.CombatTextAlertViewer
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

    local size, color, text
    
    -- First we handle Cleanse/Execute/Exploit because these messages are always individual
    
    --Cleanse
    if (alertType == alertTypes.CLEANSE) then
        color = S.colors.alertCleanse
        size = S.fontSizes.alert
        text = zo_strformat("<<1>> <<2>> - <<3>>", abilityIcon, abilityName, S.formats.alertCleanse)
    --EXECUTE
    elseif (alertType == alertTypes.EXECUTE) then
        color = S.colors.alertExecute
        size = S.fontSizes.alert
        text = S.formats.alertExecute
    --EXPLOIT
    elseif (alertType == alertTypes.EXPLOIT) then
        color = S.colors.alertExploit
        size = S.fontSizes.alert
        text = S.formats.alertExploit
    elseif (alertType == alertTypes.SHARED) then

        size = S.fontSizes.alert
        
        local spacer = " - "
        local stringBlock
        local stringDodge
        local stringAvoid
        local stringInterrupt
        
        -- Quickly set only one of these to true for priority color formatting.
        -- PRIORITY: INTERRUPT > BLOCK STAGGER > DODGE > BLOCK > AVOID
        if blockstagger then block = false end
        
        if avoid then
            stringAvoid = (S.formats.alertAvoid .. spacer)
            color = S.colors.alertAvoid
        else
            stringAvoid = ""
        end
        
        if block then
            stringBlock = (S.formats.alertBlock .. spacer)
            color = S.colors.alertBlock
        end
        
        if dodge then
            stringDodge = (S.formats.alertDodge .. spacer)
            color = S.colors.alertDodge
        else
            stringDodge = ""
        end
        
        if blockstagger then
            stringBlock = (S.formats.alertBlockStagger .. spacer)
            color = S.colors.alertBlock
        end
        
        if interrupt then
            stringInterrupt = (S.formats.alertInterrupt .. spacer)
            color = S.colors.alertInterrupt
        else
            stringInterrupt = ""
        end
        
        if not block and not blockstagger then
            stringBlock = ""
        end
        
        local stringPart1 = self:FormatAlertString(S.toggles.mitigationFormat, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = isDirect and S.toggles.mitigationSuffix or ""
        local stringPart3 = string.format("%s%s%s%s%s", spacer, stringBlock, stringDodge, stringAvoid, stringInterrupt)
        
        text = zo_strformat("<<1>><<2>><<3>>", stringPart1, stringPart2, stringPart3)
    --BLOCK
    elseif (alertType == alertTypes.BLOCK) then
        color = S.colors.alertBlock
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(S.toggles.mitigationFormat, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = isDirect and S.toggles.mitigationSuffix or ""
        local stringPart3 = S.formats.alertBlock
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    -- BLOCK STAGGER
    elseif (alertType == alertTypes.BLOCKSTAGGER) then
        color = S.colors.alertBlock
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(S.toggles.mitigationFormat, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = isDirect and S.toggles.mitigationSuffix or ""
        local stringPart3 = S.formats.alertBlockStagger
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    --INTERRUPT
    elseif (alertType == alertTypes.INTERRUPT) then
        color = S.colors.alertInterrupt
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(S.toggles.mitigationFormat, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = isDirect and S.toggles.mitigationSuffix or ""
        local stringPart3 = S.formats.alertInterrupt
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    --DODGE
    elseif (alertType == alertTypes.DODGE) then
        color = S.colors.alertDodge
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(S.toggles.mitigationFormat, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = isDirect and S.toggles.mitigationSuffix or ""
        local stringPart3 = S.formats.alertDodge
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    -- AVOID
    elseif (alertType == alertTypes.AVOID) then
        color = S.colors.alertAvoid
        size = S.fontSizes.alert
        local stringPart1 = self:FormatAlertString(S.toggles.mitigationFormat, { source = sourceName, ability = abilityName, icon = abilityIcon })
        local stringPart2 = isDirect and S.toggles.mitigationSuffix or ""
        local stringPart3 = S.formats.alertAvoid
        text = zo_strformat("<<1>><<2>> <<3>>", stringPart1, stringPart2, stringPart3)
    end

    self:PrepareLabel(control.label, size, color, text)
    self:ControlLayout(control)

    --Control setup
    control:SetAnchor(CENTER, CombatText_Alert, TOP, 0, self.locationOffset * (S.fontSizes.alert + 5))
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
