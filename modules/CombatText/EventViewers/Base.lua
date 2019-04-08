--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextEventViewer = ZO_Object:Subclass()
local CTV = LUIE.CombatTextEventViewer

local C = LUIE.CombatTextConstants
local E = LUIE.Effects
local strfmt = string.format

local callbackManager = CALLBACK_MANAGER

CTV.resourceNames = setmetatable({}, {__index = function(t, k) t[k] = GetString('SI_COMBATMECHANICTYPE', k); return t[k] end})
CTV.damageTypes = setmetatable({}, {__index = function(t, k) t[k] = GetString('SI_DAMAGETYPE', k); return t[k] end})

function CTV:New(poolManager, LMP)
    local obj = ZO_Object:New(self)
    self.poolManager = poolManager
    self.LMP = LMP
    return obj
end

function CTV:FormatString(inputFormat, params)
    return string.gsub(inputFormat, '%%.', function(x)
        if (x == '%t') then
            return params.text or ''
        elseif (x == '%a') then
            return params.value or ''
        elseif (x == '%r') then
            return self.resourceNames[params.powerType] or ''
        elseif (x == '%d') then
            return self.damageTypes[params.damageType]
        else
            return x
        end
    end)
end

function CTV:FormatAlertString(inputFormat, params)
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

function CTV:GetTextAtributes(powerType, damageType, isDamage, isDamageCritical, isHealing, isHealingCritical, isEnergize, isDrain, isDot, isDotCritical, isHot, isHotCritical, isMiss, isImmune, isParried, isReflected, isDamageShield, isDodged, isBlocked, isInterrupted)
    local S = LUIE.CombatText.SV

    local textFormat = S.formats.damage
    local fontSize = S.fontSizes.damage
    local textColor = S.colors.damage[damageType]

    if (isDodged) then
        textFormat = S.formats.dodged
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.dodged
    elseif (isMiss) then
        textFormat = S.formats.miss
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.miss
    elseif (isImmune) then
        textFormat = S.formats.immune
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.immune
    elseif (isReflected) then
        textFormat = S.formats.reflected
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.reflected
    elseif (isDamageShield) then
        textFormat = S.formats.damageShield
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.damageShield
    elseif (isParried) then
        textFormat = S.formats.parried
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.parried
    elseif (isBlocked) then
        textFormat = S.formats.blocked
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.blocked
    elseif (isInterrupted) then
        textFormat = S.formats.interrupted
        fontSize = S.fontSizes.mitigation
        textColor = S.colors.interrupted
    elseif (isDamageCritical) then
        textFormat = S.formats.damagecritical
        fontSize = S.fontSizes.damagecritical
        if S.toggles.criticalDamageOverride then
            textColor = S.colors.criticalDamageOverride
        end
    elseif (isHealing) then
        textFormat = S.formats.healing
        fontSize = S.fontSizes.healing
        textColor = S.colors.healing
    elseif (isHealingCritical) then
        textFormat = S.formats.healingcritical
        fontSize = S.fontSizes.healingcritical
        if S.toggles.criticalHealingOverride then
            textColor = S.colors.criticalHealingOverride
        else
            textColor = S.colors.healing
        end
    elseif (isEnergize) then
        fontSize = S.fontSizes.gainLoss
        if (powerType == POWERTYPE_ULTIMATE) then
            textFormat = S.formats.ultimateEnergize
            textColor = S.colors.energizeUltimate
        else
            textFormat = S.formats.energize
            if (powerType == POWERTYPE_MAGICKA) then
                textColor = S.colors.energizeMagicka
            elseif (powerType == POWERTYPE_STAMINA) then
                textColor = S.colors.energizeStamina
            end
        end
    elseif (isDrain) then
        textFormat = S.formats.drain
        fontSize = S.fontSizes.gainLoss
        if (powerType == POWERTYPE_MAGICKA) then
            textColor = S.colors.energizeMagicka
        elseif (powerType == POWERTYPE_STAMINA) then
            textColor = S.colors.energizeStamina
        end
    elseif (isDot) then
        textFormat = S.formats.dot
        fontSize = S.fontSizes.dot
    elseif (isDotCritical) then
        textFormat = S.formats.dotcritical
        fontSize = S.fontSizes.dotcritical
        if S.toggles.criticalDamageOverride then
            textColor = S.colors.criticalDamageOverride
        end
    elseif (isHot) then
        textFormat = S.formats.hot
        fontSize = S.fontSizes.hot
        textColor = S.colors.healing
    elseif (isHotCritical) then
        textFormat = S.formats.hotcritical
        fontSize = S.fontSizes.hotcritical
        if S.toggles.criticalHealingOverride then
            textColor = S.colors.criticalHealingOverride
        else
            textColor = S.colors.healing
        end
    end

    return textFormat, fontSize, textColor
end

function CTV:ControlLayout(control, abilityId, combatType, sourceName)
    local width, height = control.label:GetTextDimensions()

    if abilityId then
        local iconPath = E.EffectOverride[abilityId] and E.EffectOverride[abilityId].icon or GetAbilityIcon(abilityId)

        if E.EffectOverrideByName[abilityId] then
            sourceName = zo_strformat("<<t:1>>", sourceName)
            if E.EffectOverrideByName[abilityId][sourceName] and E.EffectOverrideByName[abilityId][sourceName].icon then
                iconPath = E.EffectOverrideByName[abilityId][sourceName].icon
            end
        end

        if E.MapDataOverride[abilityId] then
            local index = GetCurrentMapZoneIndex()
            if E.MapDataOverride[abilityId][index] then
                if E.MapDataOverride[abilityId][index].icon then
                    iconPath = E.MapDataOverride[abilityId][index].icon
                end
            end
        end

        if iconPath and iconPath ~= '' then
            local S = LUIE.CombatText.SV
            local iconSide
            if combatType == C.combatType.INCOMING then
                iconSide = S.animation.incomingIcon
            elseif combatType == C.combatType.OUTGOING then
                iconSide = S.animation.outgoingIcon
            else
                iconSide = 'none'
            end

            if iconSide == 'none' then
                control.icon:SetAnchor(CENTER, control, CENTER, 0, 0)
                control.label:SetAnchor(CENTER, control.icon, CENTER, 0, 0)
                control:SetDimensions(width, height)
            else
                if iconSide == 'left' then
                    control.icon:SetAnchor(LEFT, control, LEFT, 0, 0)
                    control.label:SetAnchor(LEFT, control.icon, RIGHT, 8, 0)
                elseif iconSide == 'right' then
                    control.icon:SetAnchor(RIGHT, control, RIGHT, 0, 0)
                    control.label:SetAnchor(RIGHT, control.icon, LEFT, -8, 0)
                end
                control.icon:SetTexture(iconPath)
                control.icon:SetDimensions(height, height)
                control.icon:SetHidden(false)
                control:SetDimensions(width + height + 8, height)
            end
        else
            control.icon:SetAnchor(CENTER, control, CENTER, 0, 0)
            control.label:SetAnchor(CENTER, control.icon, CENTER, 0, 0)
            control:SetDimensions(width, height)
        end
    else
        control.icon:SetAnchor(CENTER, control, CENTER, 0, 0)
        control.label:SetAnchor(CENTER, control.icon, CENTER, 0, 0)
        control:SetDimensions(width, height)
    end
    control.icon:SetAlpha(LUIE.CombatText.SV.common.transparencyValue/100)
end

function CTV:RegisterCallback(eventType, func)
    callbackManager:RegisterCallback(eventType, function(...) func(...) end)
end

function CTV:PrepareLabel(label, fontSize, color, text)
    label:SetText(text)
    label:SetColor(unpack(color))
    label:SetFont(strfmt('%s|%d|%s', self.LMP:Fetch('font', LUIE.CombatText.SV.fontFace), fontSize, LUIE.CombatText.SV.fontOutline))
    label:SetAlpha(LUIE.CombatText.SV.common.transparencyValue/100)
end

function CTV:IsOverlapping(control, activeControls)
    local p = 5 -- Substract some padding

    local left, top, right, bottom = control:GetScreenRect()
    local p1, p2 = { x = left + p, y = top + p }, { x = right - p, y = bottom - p }

    for _, c in pairs(activeControls) do
        left, top, right, bottom = c:GetScreenRect()
        local p3, p4 = { x = left + p, y = top + p }, { x = right - p, y = bottom - p }

        if (p2.y >= p3.y and p1.y <= p4.y and p2.x >= p3.x and p1.x <= p4.x) then
            return true
        end
    end

    return false
end
