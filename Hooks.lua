--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat
local printToChat = LUIE.PrintToChat

function LUIE.InitializeHooks()
        -- Hook for Icon/Name changes
        local zos_GetSkillAbilityInfo = GetSkillAbilityInfo
        GetSkillAbilityInfo = function(skillType, skillIndex, abilityIndex)
            local name, texture, earnedRank, passive, ultimate, purchased, progressionIndex, rankIndex = zos_GetSkillAbilityInfo(skillType, skillIndex, abilityIndex)
            local abilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex)
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].icon then
                texture = LUIE.Data.Effects.EffectOverride[abilityId].icon
            end
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].name then
                name = LUIE.Data.Effects.EffectOverride[abilityId].name
            end
            return name, texture, earnedRank, passive, ultimate, purchased, progressionIndex, rankIndex
        end

        -- Hook for Icon/Name changes
        local zos_GetSkillAbilityNextUpgradeInfo = GetSkillAbilityNextUpgradeInfo
        GetSkillAbilityNextUpgradeInfo = function(skillType, skillIndex, abilityIndex)
            local name, texture, earnedRank = zos_GetSkillAbilityNextUpgradeInfo(skillType, skillIndex, abilityIndex)
            local abilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex)
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].icon then
                texture = LUIE.Data.Effects.EffectOverride[abilityId].icon
            end
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].name then
                name = LUIE.Data.Effects.EffectOverride[abilityId].name
            end
            return name, texture, earnedRank
        end

        -- Hook for Icon/Name changes
        local zos_GetUnitBuffInfo = GetUnitBuffInfo
        GetUnitBuffInfo = function(unitTag, buffIndex)
            local buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = zos_GetUnitBuffInfo(unitTag, buffIndex)
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].name then
                buffName = LUIE.Data.Effects.EffectOverride[abilityId].name
            end
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].icon then
                iconFile = LUIE.Data.Effects.EffectOverride[abilityId].icon
            end

            return buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer
        end

        -- Hook GetKillingAttackerInfo - Change Source Name, Pet Name, or toggle damage that is sourced from the Player on/off
        -- Hook GetKillingAttackInfo - Change Icon or Name (additional support for Zone based changes, and source attacker/pet changes)
        local zos_GetKillingAttackerInfo = GetKillingAttackerInfo
        local zos_GetKillingAttackInfo = GetKillingAttackInfo
        local zos_DoesKillingAttackHaveAttacker = DoesKillingAttackHaveAttacker

        DoesKillingAttackHaveAttacker = function(index)
            local hasAttacker = zos_DoesKillingAttackHaveAttacker
            local attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits, abilityId = zos_GetKillingAttackInfo(index)

            if LUIE.Data.Effects.EffectSourceOverride[abilityId] then
                if LUIE.Data.Effects.EffectSourceOverride[abilityId].addSource then
                    hasAttacker = true
                end
            end

            return hasAttacker
        end


        GetKillingAttackerInfo = function(index)
            local attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName = zos_GetKillingAttackerInfo(index)
            local attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits, abilityId = zos_GetKillingAttackInfo(index)

            if LUIE.Data.Effects.EffectSourceOverride[abilityId] then
                if LUIE.Data.Effects.EffectSourceOverride[abilityId].source then
                    attackerRawName = LUIE.Data.Effects.EffectSourceOverride[abilityId].source
                end
                if LUIE.Data.Effects.EffectSourceOverride[abilityId].pet then
                    minionName = LUIE.Data.Effects.EffectSourceOverride[abilityId].pet
                end
                if LUIE.Data.Effects.EffectSourceOverride[abilityId].removePlayer then
                    isPlayer = false
                end
                if LUIE.Data.Effects.ZoneDataOverride[abilityId] then
                    local index = GetZoneId(GetCurrentMapZoneIndex())
                    local zoneName = GetPlayerLocationName()
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][index] then
                        if LUIE.Data.Effects.ZoneDataOverride[abilityId][index].source then
                            attackerRawName = LUIE.Data.Effects.ZoneDataOverride[abilityId][index].source
                        end
                    end
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName] then
                        if LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName].source then
                            attackerRawName = LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName].source
                        end
                    end
                end

            end

            return attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName
        end

        GetKillingAttackInfo = function(index)
            local attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName = zos_GetKillingAttackerInfo(index)
            local attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits, abilityId = zos_GetKillingAttackInfo(index)

            if LUIE.Data.Effects.EffectOverride[abilityId] then
                attackName = LUIE.Data.Effects.EffectOverride[abilityId].name or attackName
                attackIcon = LUIE.Data.Effects.EffectOverride[abilityId].icon or attackIcon
            end

            if LUIE.Data.Effects.ZoneDataOverride[abilityId] then
                local index = GetZoneId(GetCurrentMapZoneIndex())
                local zoneName = GetPlayerLocationName()
                if LUIE.Data.Effects.ZoneDataOverride[abilityId][index] then
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][index].icon then
                        attackIcon = LUIE.Data.Effects.ZoneDataOverride[abilityId][index].icon
                    end
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][index].name then
                        attackName = LUIE.Data.Effects.ZoneDataOverride[abilityId][index].name
                    end
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][index].hide then
                        return
                    end
                end
                if LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName] then
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName].icon then
                        attackIcon = LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName].icon
                    end
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName].name then
                        attackName = LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName].name
                    end
                    if LUIE.Data.Effects.ZoneDataOverride[abilityId][zoneName].hide then
                        return
                    end
                end
            end

            -- Override name, icon, or hide based on Map Name
            if LUIE.Data.Effects.MapDataOverride[abilityId] then
                local mapName = GetMapName()
                if LUIE.Data.Effects.MapDataOverride[abilityId][mapName] then
                    if LUIE.Data.Effects.MapDataOverride[abilityId][mapName].icon then
                        attackIcon = LUIE.Data.Effects.MapDataOverride[abilityId][mapName].icon
                    end
                    if LUIE.Data.Effects.MapDataOverride[abilityId][mapName].name then
                        attackName = LUIE.Data.Effects.MapDataOverride[abilityId][mapName].name
                    end
                    if LUIE.Data.Effects.MapDataOverride[abilityId][mapName].hide then
                        return
                    end
                end
            end

            if LUIE.Data.Effects.EffectOverrideByName[abilityId] then
                local unitName = zo_strformat("<<C:1>>", attackerRawName)
                local petName = zo_strformat("<<C:1>>", minionName)
                if LUIE.Data.Effects.EffectOverrideByName[abilityId][unitName] then
                    if LUIE.Data.Effects.EffectOverrideByName[abilityId][unitName].hide then
                        return
                    end
                    attackName = LUIE.Data.Effects.EffectOverrideByName[abilityId][unitName].name or attackName
                    attackIcon = LUIE.Data.Effects.EffectOverrideByName[abilityId][unitName].icon or attackIcon
                end
                if LUIE.Data.Effects.EffectOverrideByName[abilityId][petName] then
                    if LUIE.Data.Effects.EffectOverrideByName[abilityId][petName].hide then
                        return
                    end
                    attackName = LUIE.Data.Effects.EffectOverrideByName[abilityId][petName].name or attackName
                    attackIcon = LUIE.Data.Effects.EffectOverrideByName[abilityId][petName].icon or attackIcon
                end
            end

            if attackName == GetString(SI_LUIE_SKILL_FALL_DAMAGE) then
                if LUIE.Data.Effects.EffectOverride[10950] then
                    attackIcon = LUIE.Data.Effects.EffectOverride[10950].icon
                end
            end

            return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
        end

        -- Hook support for Custom Ability Icons (Helps normalize with other addons)
        LUIE.GetAbilityIcon = GetAbilityIcon -- Used only for PTS testing
        zos_GetAbilityIcon = GetAbilityIcon
        GetAbilityIcon = function(abilityId)
            local icon = zos_GetAbilityIcon(abilityId)
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].icon then
                icon = LUIE.Data.Effects.EffectOverride[abilityId].icon
            end
            return(icon)
        end

        -- Hook support for Custom Ability Names (Helps normalize with other addons)
        LUIE.GetAbilityName = GetAbilityName -- Used only for PTS testing
        zos_GetAbilityName = GetAbilityName
        GetAbilityName = function(abilityId)
            local abilityName = zos_GetAbilityName(abilityId)
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].name then
                abilityName = LUIE.Data.Effects.EffectOverride[abilityId].name
            end
            return(abilityName)
        end

        -- Hook support for ArtificialffectId's
        LUIE.GetArtificialEffectInfo = GetArtificialEffectInfo -- Used only for PTS testing
        zos_GetArtificialEffectInfo = GetArtificialEffectInfo
        GetArtificialEffectInfo = function(artificialEffectId)
            local displayName, iconFile, effectType, sortOrder, timeStarted, timeEnding = zos_GetArtificialEffectInfo(artificialEffectId)
            if LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId].icon then
                iconFile = LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId].icon
            end
            if LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId].name then
                displayName = LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId].name
            end
            return displayName, iconFile, effectType, sortOrder, timeStarted, timeEnding
        end

        -- Hook support to pull custom tooltips for ArtificialEffectId's
        zos_GetArtificialEffectTooltipText = GetArtificialEffectTooltipText
        GetArtificialEffectTooltipText = function(artificialEffectId)
            local tooltip
            if LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId].tooltip then
                tooltip = LUIE.Data.Effects.ArtificialEffectOverride[artificialEffectId].tooltip
                return tooltip
            else
                tooltip = zos_GetArtificialEffectTooltipText(artificialEffectId)
                return tooltip
            end
        end

        -- Hook synergy popup Icon/Name (to fix inconsistencies and add custom icons for some Quest/Encounter based Synergies)
        ZO_Synergy.OnSynergyAbilityChanged = function(self)
            local synergyName, iconFilename = GetSynergyInfo()

            if LUIE.Data.Effects.SynergyNameOverride[synergyName] then
                if LUIE.Data.Effects.SynergyNameOverride[synergyName].icon then
                    iconFilename = LUIE.Data.Effects.SynergyNameOverride[synergyName].icon
                end
                if LUIE.Data.Effects.SynergyNameOverride[synergyName].name then
                    synergyName = LUIE.Data.Effects.SynergyNameOverride[synergyName].name
                end
            end

            if synergyName and iconFilename then
                if self.lastSynergyName ~= synergyName then
                    PlaySound(SOUNDS.ABILITY_SYNERGY_READY)

                    self.action:SetText(zo_strformat(SI_USE_SYNERGY, synergyName))
                end

                self.icon:SetTexture(iconFilename)
                SHARED_INFORMATION_AREA:SetHidden(self, false)
            else
                SHARED_INFORMATION_AREA:SetHidden(self, true)
            end

            self.lastSynergyName = synergyName
        end

        -- Hook STATS Screen Buffs & Debuffs to hide buffs not needed, update icons, names, durations, and tooltips
        local function EffectsRowComparator(left, right)
            local leftIsArtificial, rightIsArtificial = left.isArtificial, right.isArtificial
            if leftIsArtificial ~= rightIsArtificial then
                -- Artificial before real
                return leftIsArtificial
            else
                if leftIsArtificial then
                    -- Both artificial, use def defined sort order
                    return left.sortOrder < right.sortOrder
                else
                    -- Both real, use time
                    return left.time.endTime < right.time.endTime
                end
            end
        end

        STATS.AddLongTermEffects = function(self, container, effectsRowPool)
            local function UpdateEffects(eventCode, changeType, buffSlot, buffName, unitTag, startTime, endTime, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId)
                if (not unitTag or unitTag == "player") and not container:IsHidden() then
                    effectsRowPool:ReleaseAllObjects()
                    local effectsRows = {}
                    --Artificial effects--
                    for effectId in ZO_GetNextActiveArtificialEffectIdIter do
                        local displayName, iconFile, effectType, sortOrder = GetArtificialEffectInfo(effectId)
                        local effectsRow = effectsRowPool:AcquireObject()
                        effectsRow.name:SetText(zo_strformat(SI_ABILITY_TOOLTIP_NAME, displayName))
                        effectsRow.icon:SetTexture(iconFile)
                        effectsRow.effectType = effectType
                        effectsRow.time:SetHidden(true)
                        effectsRow.sortOrder = sortOrder
                        effectsRow.tooltipTitle = zo_strformat(SI_ABILITY_TOOLTIP_NAME, displayName)
                        effectsRow.effectId = effectId
                        effectsRow.isArtificial = true
                        effectsRow.isArtificialTooltip = true
                        if effectId == 3 then -- Battleground Deserter Penalty
                            startTime = GetFrameTimeSeconds()
                            local cooldown = GetLFGCooldownTimeRemainingSeconds(LFG_COOLDOWN_BATTLEGROUND_DESERTED)
                            endTime = startTime + cooldown
                            local duration = startTime - endTime
                            effectsRow.time:SetHidden(duration == 0)
                            effectsRow.time.endTime = endTime
                            effectsRow.isArtificial = false -- Sort with normal buffs
                        end
                        table.insert(effectsRows, effectsRow)
                    end

                    local counter = 1
                    local trackBuffs = { }
                    for i = 1, GetNumBuffs("player") do
                        local buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId = GetUnitBuffInfo("player", i)
                        trackBuffs[counter] = {
                            buffName = buffName,
                            startTime = startTime,
                            endTime = endTime,
                            buffSlot = buffSlot,
                            stackCount = stackCount,
                            iconFile = iconFile,
                            buffType = buffType,
                            effectType = effectType,
                            abilityType = abilityType,
                            statusEffectType = statusEffectType,
                            abilityId = abilityId
                        }
                        counter = counter + 1
                    end

                    -- Heavy handed - but functional way to mark duplicate abilities to not display by only displaying the one with the latest end time.
                    for i = 1, #trackBuffs do
                        local compareId = trackBuffs[i].abilityId
                        local compareTime = trackBuffs[i].endTime
                        -- Only re-iterate and compare if this ability is on the override table, this way we avoid as much of this double loop as possible.
                        if LUIE.Data.Effects.EffectOverride[compareId] and LUIE.Data.Effects.EffectOverride[compareId].noDuplicate then
                            for k, v in pairs(trackBuffs) do
                                -- Only remove the lower duration effects that were cast previously or simultaneously.
                                if v.abilityId == compareId and v.endTime < compareTime then
                                    v.markForRemove = true
                                end
                            end
                        end
                    end

                    for i = 1, #trackBuffs do
                        local buffName = trackBuffs[i].buffName
                        local startTime =  trackBuffs[i].startTime
                        local endTime =  trackBuffs[i].endTime
                        local buffSlot =  trackBuffs[i].buffSlot
                        local stackCount =  trackBuffs[i].stackCount
                        local iconFile =  trackBuffs[i].iconFile
                        local buffType =  trackBuffs[i].buffType
                        local effectType =  trackBuffs[i].effectType
                        local abilityType =  trackBuffs[i].abilityType
                        local statusEffectType =  trackBuffs[i].statusEffectType
                        local abilityId =  trackBuffs[i].abilityId
                        local markForRemove = trackBuffs[i].markForRemove or false

                        local timer = endTime - startTime
                        local value2
                        local value3
                        if LUIE.Data.Effects.EffectOverride[abilityId] then
                            if LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2 then
                                value2 = LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2
                            elseif LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2Mod then
                                value2 = math.floor( timer + E.EffectOverride[abilityId].tooltipValue2Mod + 0.5 )
                            elseif LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2Id then
                                value2 =  math.floor(GetAbilityDuration(LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2Id) + 0.5) / 1000
                            else
                                value2 = 0
                            end
                        else
                            value2 = 0
                        end
                        if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue3 then
                            value3 = LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue3
                        else
                            value3 = 0
                        end
                        timer = math.floor((timer * 10) + 0.5) / 10

                        local tooltipText
                        if LUIE.ResolveVeteranDifficulty() == true and LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltipVet then
                            tooltipText = zo_strformat(LUIE.Data.Effects.EffectOverride[abilityId].tooltipVet, timer, value2, value3)
                        else
                            tooltipText = (LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltip) and zo_strformat(LUIE.Data.Effects.EffectOverride[abilityId].tooltip, timer, value2, value3) or GetAbilityDescription(abilityId)
                        end

                        -- Display Default Tooltip Description if no custom tooltip is present
                        if tooltipText == "" or tooltipText == nil then
                            if GetAbilityEffectDescription(buffSlot) ~= "" then
                                tooltipText = GetAbilityEffectDescription(buffSlot)
                            end
                        end

                        -- Override custom tooltip with default tooltip if this ability is flagged to do so (scaling buffs like Mundus Stones)
                        if LUIE.Data.Effects.TooltipUseDefault[abilityId] then
                            if GetAbilityEffectDescription(buffSlot) ~= "" then
                                tooltipText = GetAbilityEffectDescription(buffSlot)
                                tooltipText = LUIE.UpdateMundusTooltipSyntax(abilityId, tooltipText)
                            end
                        end

                        if tooltipText ~= "" then
                            tooltipText = string.match(tooltipText, ".*%S")
                        end
                        local thirdLine
                        local timer2 = (endTime - startTime)
                        if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltipDurFix then
                            timer2 = timer2 + LUIE.Data.Effects.EffectOverride[abilityId].tooltipDurFix
                        end
                        if LUIE.Data.Effects.TooltipNameOverride[buffName] then
                            thirdLine = zo_strformat(LUIE.Data.Effects.TooltipNameOverride[buffName], timer2)
                        end
                        if LUIE.Data.Effects.TooltipNameOverride[abilityId] then
                            thirdLine = zo_strformat(LUIE.Data.Effects.TooltipNameOverride[abilityId], timer2)
                        end

                        -- Change effect type if needed
                        if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].type then effectType = LUIE.Data.Effects.EffectOverride[abilityId].type end

                        if buffSlot > 0 and buffName ~= "" and not (LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].hide) and not markForRemove then
                            if (LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].hideReduce and not LUIE.SpellCastBuffs.SV.HideReduce) or not (LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].hideReduce) then
                                local effectsRow = effectsRowPool:AcquireObject()
                                effectsRow.name:SetText(zo_strformat(SI_ABILITY_TOOLTIP_NAME, buffName))
                                effectsRow.icon:SetTexture(iconFile)
                                effectsRow.tooltipTitle = zo_strformat(SI_ABILITY_TOOLTIP_NAME, buffName)
                                effectsRow.tooltipText = tooltipText
                                effectsRow.thirdLine = thirdLine
                                local duration = startTime - endTime
                                effectsRow.time:SetHidden(duration == 0)
                                effectsRow.time.endTime = endTime
                                effectsRow.effectType = effectType
                                effectsRow.buffSlot = buffSlot
                                effectsRow.isArtificial = false
                                effectsRow.effectId = abilityId

                                table.insert(effectsRows, effectsRow)
                            end
                        end
                    end

                    table.sort(effectsRows, EffectsRowComparator)
                    local prevRow
                    for i, effectsRow in ipairs(effectsRows) do
                        if(prevRow) then
                            effectsRow:SetAnchor(TOPLEFT, prevRow, BOTTOMLEFT)
                        else
                            effectsRow:SetAnchor(TOPLEFT, nil, TOPLEFT, 5, 0)
                        end
                        effectsRow:SetHidden(false)
                        prevRow = effectsRow
                    end
                end
            end

            container:RegisterForEvent(EVENT_EFFECT_CHANGED, UpdateEffects)
            --container:AddFilterForEvent(EVENT_EFFECT_CHANGED, REGISTER_FILTER_UNIT_TAG, "player")
            container:RegisterForEvent(EVENT_EFFECTS_FULL_UPDATE, UpdateEffects)
            container:RegisterForEvent(EVENT_ARTIFICIAL_EFFECT_ADDED, UpdateEffects)
            container:RegisterForEvent(EVENT_ARTIFICIAL_EFFECT_REMOVED, UpdateEffects)
            container:SetHandler("OnEffectivelyShown", UpdateEffects)
        end

        -- Hook GAMEPAD Stats
        GAMEPAD_STATS.RefreshCharacterEffects = function(self)
            local selectedData = self.mainList:GetTargetData()

            local contentTitle, contentDescription, contentStartTime, contentEndTime, _

            if selectedData.isArtificial then
                contentTitle, _, _, _, contentStartTime, contentEndTime = GetArtificialEffectInfo(selectedData.artificialEffectId)
                contentDescription = GetArtificialEffectTooltipText(selectedData.artificialEffectId)
            else
                local buffSlot, abilityId
                contentTitle, contentStartTime, contentEndTime, buffSlot, _, _, _, _, _, _, abilityId = GetUnitBuffInfo("player", selectedData.buffIndex)

                if DoesAbilityExist(abilityId) then
                    contentDescription = GetAbilityEffectDescription(buffSlot)

                    local timer = contentEndTime - contentStartTime
                    local value2
                    local value3
                    if LUIE.Data.Effects.EffectOverride[abilityId] then
                        if LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2 then
                            value2 = LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2
                        elseif LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2Mod then
                            value2 = math.floor( timer + E.EffectOverride[abilityId].tooltipValue2Mod + 0.5 )
                        elseif LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2Id then
                            value2 =  math.floor(GetAbilityDuration(LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue2Id) + 0.5) / 1000
                        else
                            value2 = 0
                        end
                    else
                        value2 = 0
                    end
                    if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue3 then
                        value3 = LUIE.Data.Effects.EffectOverride[abilityId].tooltipValue3
                    else
                        value3 = 0
                    end
                    timer = math.floor((timer * 10) + 0.5) / 10

                    local tooltipText
                    if LUIE.ResolveVeteranDifficulty() == true and LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltipVet then
                        tooltipText = zo_strformat(LUIE.Data.Effects.EffectOverride[abilityId].tooltipVet, timer, value2, value3)
                    else
                        tooltipText = (LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltip) and zo_strformat(LUIE.Data.Effects.EffectOverride[abilityId].tooltip, timer, value2, value3) or ""
                    end

                    -- Display Default Tooltip Description if no custom tooltip is present
                    if tooltipText == "" or tooltipText == nil then
                        if GetAbilityEffectDescription(buffSlot) ~= "" then
                            tooltipText = GetAbilityEffectDescription(buffSlot)
                        end
                    end

                    -- Display Default Description if no internal effect description is present
                    if tooltipText == "" or tooltipText == nil then
                        if GetAbilityDescription(abilityId) ~= "" then
                            tooltipText = GetAbilityDescription(abilityId)
                        end
                    end

                    -- Override custom tooltip with default tooltip if this ability is flagged to do so (scaling buffs like Mundus Stones)
                    if LUIE.Data.Effects.TooltipUseDefault[abilityId] then
                        if GetAbilityEffectDescription(buffSlot) ~= "" then
                            tooltipText = GetAbilityEffectDescription(buffSlot)
                            tooltipText = LUIE.UpdateMundusTooltipSyntax(abilityId, tooltipText)
                        end
                    end

                    if tooltipText ~= "" then
                        tooltipText = string.match(tooltipText, ".*%S")
                    end
                    local thirdLine
                    local timer2 = (contentEndTime - contentStartTime)
                    if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltipDurFix then
                        timer2 = timer2 + LUIE.Data.Effects.EffectOverride[abilityId].tooltipDurFix
                    end
                    if LUIE.Data.Effects.TooltipNameOverride[contentTitle] then
                        thirdLine = zo_strformat(LUIE.Data.Effects.TooltipNameOverride[contentTitle], timer2)
                    end
                    if LUIE.Data.Effects.TooltipNameOverride[abilityId] then
                        thirdLine = zo_strformat(LUIE.Data.Effects.TooltipNameOverride[abilityId], timer2)
                    end

                    contentDescription = tooltipText
                    if thirdLine ~= "" and thirdLine ~= nil then
                        contentDescription = thirdLine
                    end

                end
            end

            local contentDuration = contentEndTime - contentStartTime
            if contentDuration > 0 then
                local function OnTimerUpdate()
                    local timeLeft = contentEndTime - (GetFrameTimeMilliseconds() / 1000.0)

                    local timeLeftText = ZO_FormatTime(timeLeft, TIME_FORMAT_STYLE_COLONS, TIME_FORMAT_PRECISION_TWELVE_HOUR)

                    self:RefreshContentHeader(contentTitle, GetString(SI_STAT_GAMEPAD_TIME_REMAINING), timeLeftText)
                end

                self.effectDesc:SetHandler("OnUpdate", OnTimerUpdate)
            else
                self.effectDesc:SetHandler("OnUpdate", nil)
            end

            self.effectDesc:SetText(contentDescription)
            self:RefreshContentHeader(contentTitle)
        end

        -- Hook for request friend so menu option also displays invite message
        -- Menu is true if this request is sent from the Player to Player interaction menu
        local zos_RequestFriend = RequestFriend
        RequestFriend = function(option1, option2, menu)
            zos_RequestFriend(option1, option2)
            if not menu then
                local message = zo_strformat(GetString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG), option1)
                printToChat(message, true)
                if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, message)
                end
            end
        end

        -- Hook for request ignore to handle error message if account name is already ignored
        local zos_AddIgnore = AddIgnore
        AddIgnore = function(option)
            zos_AddIgnore(option)

            if IsIgnored(option) then -- Only lists account names, unfortunately
                printToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE), true)
                if LUIE.ChatAnnouncements.SV.Social.FriendIgnoreAlert then
                    ZO_Alert(UI_ALERT_CATEGORY_ERROR, nil, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE)))
                end
                PlaySound(SOUNDS.GENERAL_ALERT_ERROR)
                return
            end
        end

        local buffTypes = {
            [1] = "Buff",
            [2] = "Debuff",
            [3] = "Unbreakable Buff",
            [4] = "Unbreakable Debuff",
            [5] = "None",
        }

        local function TooltipBottomLine(control, detailsLine)

            -- Add bottom divider and info if present:
            if LUIE.SpellCastBuffs.SV.TooltipAbilityId or LUIE.SpellCastBuffs.SV.TooltipBuffType then
                ZO_Tooltip_AddDivider(GameTooltip)
                GameTooltip:SetVerticalPadding(4)
                GameTooltip:AddLine("", "", ZO_NORMAL_TEXT:UnpackRGB())
                -- Add Ability ID Line
                if LUIE.SpellCastBuffs.SV.TooltipAbilityId then
                    local labelAbilityId = control.effectId and control.effectId or "None"
                    if labelAbilityId == "Fake" then
                        artificial = true
                    end
                    if control.isArtificial then
                        labelAbilityId = "Artificial"
                    end
                    GameTooltip:AddHeaderLine("Ability ID", "ZoFontWinT1", detailsLine, TOOLTIP_HEADER_SIDE_LEFT, ZO_NORMAL_TEXT:UnpackRGB())
                    GameTooltip:AddHeaderLine(labelAbilityId, "ZoFontWinT1", detailsLine, TOOLTIP_HEADER_SIDE_RIGHT, 1, 1, 1)
                    detailsLine = detailsLine + 1
                end

                -- Add Buff Type Line
                if LUIE.SpellCastBuffs.SV.TooltipBuffType then
                    local buffType = control.effectType and control.effectType or 5
                    if control.effectId and LUIE.Data.Effects.EffectOverride[control.effectId] and LUIE.Data.Effects.EffectOverride[control.effectId].unbreakable then
                        buffType = buffType + 2
                    end
                    GameTooltip:AddHeaderLine("Type", "ZoFontWinT1", detailsLine, TOOLTIP_HEADER_SIDE_LEFT, ZO_NORMAL_TEXT:UnpackRGB())
                    GameTooltip:AddHeaderLine(buffTypes[buffType], "ZoFontWinT1", detailsLine, TOOLTIP_HEADER_SIDE_RIGHT, 1, 1, 1)
                    detailsLine = detailsLine + 1
                end
            end

        end

        -- Hook Tooltip Generation for STATS Screen Buffs & Debuffs
        ZO_StatsActiveEffect_OnMouseEnter = function(control)
            InitializeTooltip(GameTooltip, control, RIGHT, -15)

            local detailsLine
            local colorText = ZO_NORMAL_TEXT
            if control.thirdLine ~= "" and control.thirdLine ~= nil then
                colorText = control.effectType == BUFF_EFFECT_TYPE_DEBUFF and ZO_ERROR_COLOR or ZO_SUCCEEDED_TEXT
            end

            if control.isArtificialTooltip then
                local tooltipText = GetArtificialEffectTooltipText(control.effectId)
                GameTooltip:AddLine(control.tooltipTitle, "ZoFontHeader2",1,1,1, nil)
                GameTooltip:SetVerticalPadding(1)
                ZO_Tooltip_AddDivider(GameTooltip)
                GameTooltip:SetVerticalPadding(5)
                GameTooltip:AddLine(tooltipText, "", colorText:UnpackRGBA())
                detailsLine = 5
            else
                detailsLine = 3
                GameTooltip:AddLine(control.tooltipTitle, "ZoFontHeader2",1,1,1, nil)
                if control.tooltipText ~= "" and control.tooltipText ~= nil then
                    GameTooltip:SetVerticalPadding(1)
                    ZO_Tooltip_AddDivider(GameTooltip)
                    GameTooltip:SetVerticalPadding(5)
                    GameTooltip:AddLine(control.tooltipText, "", colorText:UnpackRGBA())
                    detailsLine = 5
                end
                if control.thirdLine ~= "" and control.thirdLine ~= nil then
                    if control.tooltipText == "" or control.tooltipText == nil then
                        GameTooltip:SetVerticalPadding(1)
                        ZO_Tooltip_AddDivider(GameTooltip)
                        GameTooltip:SetVerticalPadding(5)
                    end
                    detailsLine = 7
                    GameTooltip:AddLine(control.thirdLine, "", ZO_NORMAL_TEXT:UnpackRGB())
                end
            end

            TooltipBottomLine(control, detailsLine)

            if not control.animation then
                control.animation = ANIMATION_MANAGER:CreateTimelineFromVirtual("ShowOnMouseOverLabelAnimation", control:GetNamedChild("Highlight"))
            end
            control.animation:PlayForward()
        end

        -- Hook skills advisor and use this variable to refresh the abilityData one time on initialization. We don't want to reload any more after that.
        ZO_SkillsAdvisor_Suggestions_Keyboard.SetupAbilityEntry = function(self, ability, skillProgressionData)
            local skillData = skillProgressionData:GetSkillData()
            local isPassive = skillData:IsPassive()

            local detailedName = (isPassive and skillData:GetNumRanks() > 1) and skillProgressionData:GetFormattedNameWithRank() or skillProgressionData:GetFormattedName()
            detailedName = detailedName:gsub("With", "with") -- Easiest way to fix the capitalization of the skill "Bond With Nature"
            detailedName = detailedName:gsub("Blessing Of", "Blessing of") -- Easiest way to fix the capitalization of the skill "Blessing of Restoration"
            ability.nameLabel:SetText(detailedName)
            ability.nameLabel:SetColor(PURCHASED_COLOR:UnpackRGBA())
            ability.lock:SetHidden(skillProgressionData:IsUnlocked())
            ability.skillProgressionData = skillProgressionData

            local morphControl = ability:GetNamedChild("Morph")
            morphControl:SetHidden(isPassive or not skillProgressionData:IsMorph())

            local slot = ability.slot
            local id = skillProgressionData:GetAbilityId()
            slot.skillProgressionData = skillProgressionData
            slot.icon:SetTexture(GetAbilityIcon(id))
            ZO_Skills_SetKeyboardAbilityButtonTextures(slot)
        end

        -- Hook Action Slots
        local ACTION_BUTTON_BGS = {ability = "EsoUI/Art/ActionBar/abilityInset.dds", item = "EsoUI/Art/ActionBar/quickslotBG.dds"}
        local ACTION_BUTTON_BORDERS = {normal = "EsoUI/Art/ActionBar/abilityFrame64_up.dds", mouseDown = "EsoUI/Art/ActionBar/abilityFrame64_down.dds"}

        local function SetupActionSlot(slotObject, slotId)
            local slotIcon = GetSlotTexture(slotId)

            -- Added function - Replace icons if needed
            local abilityId = GetSlotBoundId(slotId)
            if LUIE.Data.Effects.BarIdOverride[abilityId] then
                slotIcon = LUIE.Data.Effects.BarIdOverride[abilityId]
            end

            slotObject.slot:SetHidden(false)
            slotObject.hasAction = true

            local isGamepad = IsInGamepadPreferredMode()
            ZO_ActionSlot_SetupSlot(slotObject.icon, slotObject.button, slotIcon, isGamepad and "" or ACTION_BUTTON_BORDERS.normal, isGamepad and "" or ACTION_BUTTON_BORDERS.mouseDown, slotObject.cooldownIcon)
            slotObject:UpdateState()
        end

        local function SetupActionSlotWithBg(slotObject, slotId)
            SetupActionSlot(slotObject, slotId)
            slotObject.bg:SetTexture(ACTION_BUTTON_BGS.ability)
        end

        local function SetupAbilitySlot(slotObject, slotId)
            SetupActionSlotWithBg(slotObject, slotId)

            if slotId == ACTION_BAR_ULTIMATE_SLOT_INDEX + 1 then
                slotObject:RefreshUltimateNumberVisibility()
            else
                slotObject:ClearCount()
            end
        end

        local function SetupItemSlot(slotObject, slotId)
            SetupActionSlotWithBg(slotObject, slotId)
            slotObject:SetupCount()
        end

        local function SetupCollectibleActionSlot(slotObject, slotId)
            SetupActionSlotWithBg(slotObject, slotId)
            slotObject:ClearCount()
        end

        local function SetupQuestItemActionSlot(slotObject, slotId)
            SetupActionSlotWithBg(slotObject, slotId)
            slotObject:SetupCount()
        end

        local function SetupEmptyActionSlot(slotObject, slotId)
            slotObject:Clear()
        end

        SetupSlotHandlers = {
            [ACTION_TYPE_ABILITY]       = SetupAbilitySlot,
            [ACTION_TYPE_ITEM]          = SetupItemSlot,
            [ACTION_TYPE_COLLECTIBLE]   = SetupCollectibleActionSlot,
            [ACTION_TYPE_QUEST_ITEM]    = SetupQuestItemActionSlot,
            [ACTION_TYPE_NOTHING]       = SetupEmptyActionSlot,
        }

        -- Hook to make Activation Highlight Effect play indefinitely instead of animation only once
        ActionButton.UpdateActivationHighlight = function(self)
            local slotnum = self:GetSlot()
            local slotType = GetSlotType(slotnum)
            local slotIsEmpty = (slotType == ACTION_TYPE_NOTHING)
            local abilityId = GetSlotBoundId(slotnum) -- Check AbilityId for if this should be a fake activation highlight

            local showHighlight = not slotIsEmpty and (HasActivationHighlight(slotnum) or LUIE.Data.Effects.IsAbilityActiveGlow[abilityId] == true) and not self.useFailure and not self.showingCooldown
            local isShowingHighlight = self.activationHighlight:IsHidden() == false

            if showHighlight ~= isShowingHighlight then
                self.activationHighlight:SetHidden(not showHighlight)

                if showHighlight then
                    local _, _, activationAnimation = GetSlotTexture(slotnum)
                    self.activationHighlight:SetTexture(activationAnimation)

                    self.activationHighlight.animation = self.activationHighlight.animation or CreateSimpleAnimation(ANIMATION_TEXTURE, self.activationHighlight)
                    local anim = self.activationHighlight.animation

                    anim:SetImageData(64, 1)
                    anim:SetFramerate(30)
                    anim:GetTimeline():SetPlaybackType(ANIMATION_PLAYBACK_LOOP, LOOP_INDEFINITELY) -- Set Playback to loop indefinitely, not sure why this isn't the default behavior
                    anim:GetTimeline():PlayFromStart()
                else
                    local anim = self.activationHighlight.animation
                    if anim then
                        anim:GetTimeline():Stop()
                    end
                end
            end
        end

        -- Hook to add AVA Guard Ability + Morphs into Toggle Highlights
        ActionButton.UpdateState = function(self)
            local slotnum = self:GetSlot()
            local slotType = GetSlotType(slotnum)
            local slotIsEmpty = (slotType == ACTION_TYPE_NOTHING)
            local abilityId = GetSlotBoundId(slotnum) -- Check AbilityId for if this should be a fake activation highlight

            self.button.actionId = GetSlotBoundId(slotnum)

            self:UpdateUseFailure()

            local hidden = true
            if IsSlotToggled(slotnum) == true or LUIE.Data.Effects.IsAbilityActiveHighlight[abilityId] == true then
                hidden = false
            end

            self.status:SetHidden(hidden)

            self:UpdateActivationHighlight()
            self:UpdateCooldown(FORCE_SUPPRESS_COOLDOWN_SOUND)
        end

        -- Hook campaign screen to fix icons
        local function GetHomeKeepBonusString(campaignId)
            local allHomeKeepsHeld = GetAvAKeepScore(campaignId, GetUnitAlliance("player"))
            if allHomeKeepsHeld then
                return GetString(SI_CAMPAIGN_BONUSES_HOME_KEEP_PASS_INFO)
            else
                return GetString(SI_CAMPAIGN_BONUSES_HOME_KEEP_FAIL_INFO)
            end
        end

        local function GetHomeKeepBonusScore(campaignId)
            local allHomeKeepsHeld = GetAvAKeepScore(campaignId, GetUnitAlliance("player"))
            return allHomeKeepsHeld and 1 or 0
        end

        local function GetKeepBonusString(campaignId)
            local _, enemyKeepsHeld = GetAvAKeepScore(campaignId, GetUnitAlliance("player"))
            return zo_strformat(SI_CAMPAIGN_BONUSES_ENEMY_KEEP_INFO, enemyKeepsHeld)
        end

        local function GetKeepBonusScore(campaignId)
            local allHomeKeepsHeld, enemyKeepsHeld = GetAvAKeepScore(campaignId, GetUnitAlliance("player"))
            return allHomeKeepsHeld and enemyKeepsHeld or 0
        end

        local function GetEdgeKeepBonusScore(campaignId)
            return select(5, GetAvAKeepScore(campaignId, GetUnitAlliance("player")))
        end

        local function GetEdgeKeepBonusString(campaignId)
            return zo_strformat(SI_CAMPAIGN_BONUSES_EDGE_KEEP_INFO, GetEdgeKeepBonusScore(campaignId))
        end

        local function GetDefensiveBonusString(campaignId)
            local _, enemyScrollsHeld = GetAvAArtifactScore(campaignId, GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_DEFENSIVE)
            return zo_strformat(SI_CAMPAIGN_BONUSES_ENEMY_SCROLL_INFO, enemyScrollsHeld)
        end

        local function GetDefensiveBonusCount()
            return GetNumArtifactScoreBonuses(GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_DEFENSIVE)
        end

        local function GetDefensiveBonusAbilityId(index)
            return GetArtifactScoreBonusAbilityId(GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_DEFENSIVE, index)
        end

        local function GetDefensiveBonusScore(campaignId)
            local allHomeScrollsHeld, enemyScrollsHeld = GetAvAArtifactScore(campaignId, GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_DEFENSIVE)
            return allHomeScrollsHeld and enemyScrollsHeld or 0
        end

        local function GetOffensiveBonusString(campaignId)
            local _, enemyScrollsHeld = GetAvAArtifactScore(campaignId, GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_OFFENSIVE)
            return zo_strformat(SI_CAMPAIGN_BONUSES_ENEMY_SCROLL_INFO, enemyScrollsHeld)
        end

        local function GetOffensiveBonusCount()
            return GetNumArtifactScoreBonuses(GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_OFFENSIVE)
        end

        local function GetOffensiveBonusAbilityId(index)
            return GetArtifactScoreBonusAbilityId(GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_OFFENSIVE, index)
        end

        local function GetOffensiveBonusScore(campaignId)
            local allHomeScrollsHeld, enemyScrollsHeld = GetAvAArtifactScore(campaignId, GetUnitAlliance("player"), OBJECTIVE_ARTIFACT_OFFENSIVE)
            return allHomeScrollsHeld and enemyScrollsHeld or 0
        end

        local function GetEmperorBonusString(campaignId)
            if DoesCampaignHaveEmperor(campaignId) then
                local alliance = GetCampaignEmperorInfo(campaignId)
                if alliance == GetUnitAlliance("player") then
                    return GetString(SI_CAMPAIGN_BONUSES_EMPEROR_PASS_INFO)
                else
                    return GetString(SI_CAMPAIGN_BONUSES_EMPEROR_FAIL_INFO)
                end
            else
                return GetString(SI_CAMPAIGN_BONUSES_EMPEROR_NONE_INFO)
            end
        end

        local function GetEmperorBonusAbilityId(campaignId)
            return GetEmperorAllianceBonusAbilityId(campaignId, GetUnitAlliance("player"))
        end

        local function GetEmperorBonusScore(campaignId)
            if(DoesCampaignHaveEmperor(campaignId)) then
                local alliance = GetCampaignEmperorInfo(campaignId)
                if alliance == GetUnitAlliance("player") then
                    return 1
                end
            end

            return 0
        end

        local BONUS_SECTION_DATA = {
            [ZO_CAMPAIGN_BONUS_TYPE_HOME_KEEPS] = {
                typeIcon = "EsoUI/Art/Campaign/campaignBonus_keepIcon.dds",
                typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_keeps.dds",
                headerText = GetString(SI_CAMPAIGN_BONUSES_HOME_KEEP_HEADER),
                infoText = GetHomeKeepBonusString,
                count = 1,
                countText = GetString(SI_CAMPAIGN_BONUSES_HOME_KEEP_ALL),
                abilityFunction = GetKeepScoreBonusAbilityId,
                scoreFunction = GetHomeKeepBonusScore,
            },
            [ZO_CAMPAIGN_BONUS_TYPE_ENEMY_KEEPS] = {
                typeIcon = "EsoUI/Art/Campaign/campaignBonus_keepIcon.dds",
                typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_keeps.dds",
                headerText = GetString(SI_CAMPAIGN_BONUSES_ENEMY_KEEP_HEADER),
                infoText = GetKeepBonusString,
                count = GetNumKeepScoreBonuses,
                startIndex = 2,
                abilityFunction = GetKeepScoreBonusAbilityId,
                scoreFunction = GetKeepBonusScore,
            },
            [ZO_CAMPAIGN_BONUS_TYPE_DEFENSIVE_SCROLLS] = {
                typeIcon = "EsoUI/Art/Campaign/campaignBonus_scrollIcon.dds",
                typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_scrolls.dds",
                headerText = GetString(SI_CAMPAIGN_BONUSES_DEFENSIVE_SCROLL_HEADER),
                infoText = GetDefensiveBonusString,
                count = GetDefensiveBonusCount,
                abilityFunction = GetDefensiveBonusAbilityId,
                scoreFunction = GetDefensiveBonusScore,
            },
            [ZO_CAMPAIGN_BONUS_TYPE_OFFENSIVE_SCROLLS] = {
                typeIcon = "EsoUI/Art/Campaign/campaignBonus_scrollIcon.dds",
                typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_scrolls.dds",
                headerText = GetString(SI_CAMPAIGN_BONUSES_OFFENSIVE_SCROLL_HEADER),
                infoText = GetOffensiveBonusString,
                count = GetOffensiveBonusCount,
                abilityFunction = GetOffensiveBonusAbilityId,
                scoreFunction = GetOffensiveBonusScore,
            },
            [ZO_CAMPAIGN_BONUS_TYPE_EMPEROR] = {
                typeIcon = "EsoUI/Art/Campaign/campaignBonus_emporershipIcon.dds",
                typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_emperor.dds",
                headerText = GetString(SI_CAMPAIGN_BONUSES_EMPERORSHIP_HEADER),
                infoText = GetEmperorBonusString,
                count = 1,
                countText = HIDE_COUNT,
                abilityFunction = GetEmperorBonusAbilityId,
                scoreFunction = GetEmperorBonusScore,
            },
            [ZO_CAMPAIGN_BONUS_TYPE_EDGE_KEEPS] = {
                typeIcon = "EsoUI/Art/Campaign/campaignBonus_keepIcon.dds",
                typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_keeps.dds",
                headerText = GetString(SI_CAMPAIGN_BONUSES_EDGE_KEEP_HEADER),
                infoText = GetEdgeKeepBonusString,
                count = GetNumEdgeKeepBonuses,
                abilityFunction = GetEdgeKeepBonusAbilityId,
                scoreFunction = GetEdgeKeepBonusScore,
            },
        }

        ZO_CampaignBonuses_Shared.CreateDataTable = function(self)
            self:BuildMasterList()

            self.dataTable = {}
            local nextItemIsHeader = false
            local headerName = nil
            for i = 1, #self.masterList do
                local data = self.masterList[i]
                if data.isHeader then
                    nextItemIsHeader = true
                    headerName = data.headerString
                else
                    self.dataTable[i] = ZO_GamepadEntryData:New(data.name, data.icon)

                    if nextItemIsHeader then
                        self.dataTable[i]:SetHeader(header)
                    end

                    self.dataTable[i].index = data.index
                    self.dataTable[i].abilityId = data.abilityId
                    self.dataTable[i].typeIcon = data.typeIcon
                    self.dataTable[i].countText = data.countText
                    self.dataTable[i].name = data.name
                    self.dataTable[i].active = data.active
                    self.dataTable[i].bonusType = data.bonusType
                    self.dataTable[i].description = data.description

                    nextItemIsHeader = false
                end
            end
        end

        -- CAMPAIGN_BONUSES

        ZO_CampaignBonuses_Shared.BuildMasterList = function(self)
            self.masterList = {}

            for bonusType, info in ipairs(BONUS_SECTION_DATA) do
                local data = {
                    isHeader = true,
                    headerString = info.headerText,
                    infoString = type(info.infoText) == "function" and info.infoText(self.campaignId) or info.infoText,
                    bonusType = bonusType,
                }

                self.masterList[#self.masterList + 1] = data

                local count = type(info.count) == "function" and info.count(self.campaignId) or info.count
                local startIndex = info.startIndex or 1
                local score = info.scoreFunction(self.campaignId)

                for i = startIndex, count do
                    local abilityId = info.abilityFunction(i)
                    local name = GetAbilityName(abilityId)
                    local icon = (LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].passiveIcon) and LUIE.Data.Effects.EffectOverride[abilityId].passiveIcon or GetAbilityIcon(abilityId)
                    local description = GetAbilityDescription(abilityId)

                    local scoreIndex = i - startIndex + 1
                    local countText = scoreIndex
                    if info.countText then
                        if info.countText == HIDE_COUNT then
                            countText = nil
                        else
                            countText = info.countText
                        end
                    end

                    local data = {
                        index = i,
                        abilityId = abilityId,
                        isHeader = false,
                        typeIcon = info.typeIcon,
                        typeIconGamepad = info.typeIconGamepad,
                        countText = countText,
                        name = zo_strformat(SI_CAMPAIGN_BONUSES_ENTRY_ROW_FORMATTER, name),
                        icon = icon,
                        active = score and score >= scoreIndex,
                        bonusType = bonusType,
                        description = description,
                    }

                    self.masterList[#self.masterList + 1] = data
                end
            end

            return self.masterList
        end

        CAMPAIGN_BONUSES_GAMEPAD.UpdateToolTip = function(self)
            GAMEPAD_TOOLTIPS:ClearLines(GAMEPAD_RIGHT_TOOLTIP)
            if self.abilityList:IsActive() then
                local targetData = self.abilityList:GetTargetData()
                if targetData and targetData.isHeader == false then

                    -- Replace description
                    if targetData.abilityId then
                        local abilityId = targetData.abilityId
                        if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltip then
                            targetData.description = LUIE.Data.Effects.EffectOverride[abilityId].tooltip
                        end
                    end
                    GAMEPAD_TOOLTIPS:LayoutAvABonus(GAMEPAD_RIGHT_TOOLTIP, targetData)
        			self:SetTooltipHidden(false)
                    return
                end
            end

            self:SetTooltipHidden(true)
        end

        CAMPAIGN_BONUSES.SetupBonusesEntry = function(self, control, data)
            ZO_SortFilterList.SetupRow(self, control, data)

            control.typeIcon = GetControl(control, "TypeIcon")
            control.count = GetControl(control, "Count")
            control.ability = GetControl(control, "Ability")
            control.icon = GetControl(control.ability, "Icon")
            control.nameLabel = GetControl(control, "Name")
            control.ability.index = data.index
            control.ability.bonusType = data.bonusType
            control.ability.abilityId = data.abilityId
            control.ability.name = data.name
            control.ability.description = data.description

            control.ability:SetEnabled(data.active)
            ZO_ActionSlot_SetUnusable(control.icon, not data.active)

            control.typeIcon:SetTexture(data.typeIcon)
            if data.countText then
                control.count:SetText(zo_strformat(SI_CAMPAIGN_SCORING_HOLDING, data.countText))
                control.count:SetHidden(false)
            else
                control.count:SetHidden(true)
            end
            control.nameLabel:SetText(data.name)
            control.icon:SetTexture(data.icon)
        end

        function ZO_CampaignBonuses_AbilitySlot_OnMouseEnter(control)

            local abilityId = control.abilityId
            local name = control.name
            local description = control.description

            -- Replace tooltip
            if LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].tooltip then
                description = LUIE.Data.Effects.EffectOverride[abilityId].tooltip
            end

            InitializeTooltip(SkillTooltip, control, TOPLEFT, 5, -5, TOPRIGHT)
            SkillTooltip:SetVerticalPadding(16)
            SkillTooltip:AddLine(name, "ZoFontHeader3",1,1,1, nil, MODIFY_TEXT_TYPE_UPPERCASE, TEXT_ALIGN_CENTER)
            SkillTooltip:SetVerticalPadding(0)
            ZO_Tooltip_AddDivider(SkillTooltip)
            SkillTooltip:SetVerticalPadding(8)
            local r,b,g = ZO_NORMAL_TEXT:UnpackRGB()
            SkillTooltip:AddLine(description, "",r,b,g, nil, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER)

        end

        -- AVA KEEP UPGRADE HOOK
        ZO_MapKeepUpgrade_Shared.RefreshLevels = function(self)
            self.levelsGridList:ClearGridList()

            for currentLevel = 0, GetKeepMaxUpgradeLevel(self.keepUpgradeObject:GetKeep()) do
                local numUpgrades = self.keepUpgradeObject:GetNumLevelUpgrades(currentLevel)
                if numUpgrades > 0 then
                    local levelHeaderText = zo_strformat(SI_KEEP_UPGRADE_LEVEL_SECTION_HEADER, currentLevel)
                    for i = 1, numUpgrades do
                        local name, description, icon, atPercent, isActive = self.keepUpgradeObject:GetLevelUpgradeInfo(currentLevel, i)
                        -- Override with custom icons here.
                        if LUIE.Data.Effects.KeepUpgradeOverride[name] then
                            icon = LUIE.Data.Effects.KeepUpgradeOverride[name]
                        end
                        -- Override with custom faction icons here.
                        if LUIE.Data.Effects.KeepUpgradeAlliance[name] then
                            icon = LUIE.Data.Effects.KeepUpgradeAlliance[name][LUIE.PlayerFaction]
                        end
                        -- Special condition to display a unique icon for rank 2 of siege cap upgrade.
                        if name == LUIE.Data.Abilities.Keep_Upgrade_Wood_Siege_Cap and currentLevel == 2 then
                            icon = "LuiExtended/media/icons/keepupgrade/upgrade_wood_siege_cap_2.dds"
                        end
                        -- Update the tooltips.
                        if LUIE.Data.Effects.KeepUpgradeTooltip[name] then
                            description = LUIE.Data.Effects.KeepUpgradeTooltip[name]
                        end
                        -- Update the name (Note: We do this last since our other conditionals check by name).
                        if LUIE.Data.Effects.KeepUpgradeNameFix[name] then
                            name = LUIE.Data.Effects.KeepUpgradeNameFix[name]
                        end

                        local data = {
                            index = i,
                            gridHeaderName = levelHeaderText,
                            level = currentLevel,
                            name = name,
                            description = description,
                            icon = icon,
                            atPercent = atPercent,
                            isActive = isActive,
                        }

                        self.levelsGridList:AddEntry(ZO_GridSquareEntryData_Shared:New(data))
                    end
                end
            end

            self.levelsGridList:CommitGridList()
        end

        WORLD_MAP_KEEP_UPGRADE.Button_OnMouseEnter = function(self, control)
            InitializeTooltip(KeepUpgradeTooltip, control, TOPLEFT, 5, 0)

            local data = control.dataEntry.data:GetDataSource()
            local level = zo_strformat("<<1>> <<2>>", GetString(SI_ITEM_FORMAT_STR_LEVEL), data.level)
            local name = zo_strformat("<<1>>", data.name)
            local description = data.description

            KeepUpgradeTooltip:SetVerticalPadding(16)
            KeepUpgradeTooltip:AddLine(name, "ZoFontHeader3",1,1,1, nil, MODIFY_TEXT_TYPE_UPPERCASE, TEXT_ALIGN_CENTER)
            KeepUpgradeTooltip:SetVerticalPadding(0)
            ZO_Tooltip_AddDivider(KeepUpgradeTooltip)
            KeepUpgradeTooltip:SetVerticalPadding(7)
            KeepUpgradeTooltip:AddLine(level, "ZoFontWinT1",1,1,1, nil, MODIFY_TEXT_TYPE_UPPERCASE, TEXT_ALIGN_CENTER, false, 344)
            KeepUpgradeTooltip:SetVerticalPadding(0)
            local r,b,g = ZO_NORMAL_TEXT:UnpackRGB()
            KeepUpgradeTooltip:AddLine(description, "",r,b,g, nil, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER)
            KeepUpgradeTooltip:SetVerticalPadding(0)
        end

        -- HOOK SKILLS
        local INCREASE_BUTTON_TEXTURES = {
            PLUS = {
                normal = "EsoUI/Art/Progression/addPoints_up.dds",
                mouseDown = "EsoUI/Art/Progression/addPoints_down.dds",
                mouseover = "EsoUI/Art/Progression/addPoints_over.dds",
                disabled = "EsoUI/Art/Progression/addPoints_disabled.dds",
            },
            MORPH = {
                normal = "EsoUI/Art/Progression/morph_up.dds",
                mouseDown = "EsoUI/Art/Progression/morph_down.dds",
                mouseover = "EsoUI/Art/Progression/morph_over.dds",
                disabled = "EsoUI/Art/Progression/morph_disabled.dds",
            },
            REMORPH = {
                normal = "EsoUI/Art/Progression/remorph_up.dds",
                mouseDown = "EsoUI/Art/Progression/remorph_down.dds",
                mouseover = "EsoUI/Art/Progression/remorph_over.dds",
                disabled = "EsoUI/Art/Progression/remorph_disabled.dds",
            },
        }

        local function ApplyButtonTextures(button, textures)
            button:SetNormalTexture(textures.normal)
            button:SetPressedTexture(textures.mouseDown)
            button:SetMouseOverTexture(textures.mouseover)
            button:SetDisabledTexture(textures.disabled)
        end

        local zos_SetupAbilityEntry = SKILLS_WINDOW.SetupAbilityEntry
        SKILLS_WINDOW.SetupAbilityEntry = function(self, ability, data)
            zos_SetupAbilityEntry(self, ability, data)

            local skillData = data.skillData
            local skillPointAllocator = skillData:GetPointAllocator()
            local skillProgressionData = skillPointAllocator:GetProgressionData()
            local id = skillProgressionData:GetAbilityId()

            local isPassive = skillData:IsPassive()
            local isActive = not isPassive
            local isPurchased = skillPointAllocator:IsPurchased()
            local isUnlocked = skillProgressionData:IsUnlocked()

            local detailedName
            if isPassive and skillData:GetNumRanks() > 1 then
                detailedName = skillProgressionData:GetFormattedNameWithUpgradeLevels()
            elseif isActive then
                detailedName = skillProgressionData:GetFormattedNameWithRank()
            else
                detailedName = skillProgressionData:GetFormattedName()
            end
            detailedName = detailedName:gsub("With", "with") -- Easiest way to fix the capitalization of the skill "Bond With Nature"
            detailedName = detailedName:gsub("Blessing Of", "Blessing of") -- Easiest way to fix the capitalization of the skill "Blessing of Restoration"
            ability.nameLabel:SetText(detailedName)

            local slot = ability.slot

            slot.icon:SetTexture(GetAbilityIcon(id))
        end

        -- Overwrite default Skill Confirm Learn Menu for Skills with Custom Icons
        local function InitializeKeyboardConfirmDialog()
            local confirmDialogControl = ZO_SkillsConfirmDialog
            confirmDialogControl.abilityName = confirmDialogControl:GetNamedChild("AbilityName")
            confirmDialogControl.ability = confirmDialogControl:GetNamedChild("Ability")
            confirmDialogControl.ability.icon = confirmDialogControl.ability:GetNamedChild("Icon")
            local advisementLabel = confirmDialogControl:GetNamedChild("Advisement")
            advisementLabel:SetText(GetString(SI_SKILLS_ADVISOR_PURCHASE_ADVISED))
            advisementLabel:SetColor(ZO_SKILLS_ADVISOR_ADVISED_COLOR:UnpackRGBA())
            confirmDialogControl.advisementLabel = advisementLabel

            local function SetupPurchaseAbilityConfirmDialog(dialog, skillProgressionData)
                if skillProgressionData:GetSkillData():GetPointAllocator():CanPurchase() then
                    local dialogAbility = dialog.ability
                    local id = skillProgressionData:GetAbilityId()
                    dialog.abilityName:SetText(zo_strformat("<<C:1>>", GetAbilityName(id)))

                    dialogAbility.skillProgressionData = skillProgressionData
                    dialogAbility.icon:SetTexture(GetAbilityIcon(id))
                    ZO_Skills_SetKeyboardAbilityButtonTextures(dialogAbility)

                    local hideAdvisement = ZO_SKILLS_ADVISOR_SINGLETON:IsAdvancedModeSelected() or not skillProgressionData:IsAdvised()
                    dialog.advisementLabel:SetHidden(hideAdvisement)
                end
            end

            ZO_Dialogs_RegisterCustomDialog("PURCHASE_ABILITY_CONFIRM",
            {
                customControl = confirmDialogControl,
                setup = SetupPurchaseAbilityConfirmDialog,
                title =
                {
                    text = SI_SKILLS_CONFIRM_PURCHASE_ABILITY,
                },
                buttons =
                {
                    [1] =
                    {
                        control =   confirmDialogControl:GetNamedChild("Confirm"),
                        text =      SI_SKILLS_UNLOCK_CONFIRM,
                        callback =  function(dialog)
                                        local skillProgressionData = dialog.data
                                        local skillPointAllocator = skillProgressionData:GetSkillData():GetPointAllocator()
                                        skillPointAllocator:Purchase()
                                    end,
                    },

                    [2] =
                    {
                        control =   confirmDialogControl:GetNamedChild("Cancel"),
                        text =      SI_CANCEL,
                    }
                }
            })
        end

        -- Overwrite default Upgrade menu for Skills with Custom Icons
        local function InitializeKeyboardUpgradeDialog()
            local upgradeDialogControl = ZO_SkillsUpgradeDialog
            upgradeDialogControl.desc = upgradeDialogControl:GetNamedChild("Description")

            upgradeDialogControl.baseAbility = upgradeDialogControl:GetNamedChild("BaseAbility")
            upgradeDialogControl.baseAbility.icon = upgradeDialogControl.baseAbility:GetNamedChild("Icon")

            upgradeDialogControl.upgradeAbility = upgradeDialogControl:GetNamedChild("UpgradeAbility")
            upgradeDialogControl.upgradeAbility.icon = upgradeDialogControl.upgradeAbility:GetNamedChild("Icon")

            local advisementLabel = upgradeDialogControl:GetNamedChild("Advisement")
            advisementLabel:SetText(GetString(SI_SKILLS_ADVISOR_PURCHASE_ADVISED))
            advisementLabel:SetColor(ZO_SKILLS_ADVISOR_ADVISED_COLOR:UnpackRGBA())

            local function SetupUpgradeAbilityDialog(dialog, skillData)
                --Only passives upgrade
                assert(skillData:IsPassive())

                local skillPointAllocator = skillData:GetPointAllocator()
                if skillPointAllocator:CanIncreaseRank() then
                    local rank = skillPointAllocator:GetSkillProgressionKey()
                    local skillProgressionData = skillData:GetRankData(rank)
                    local nextSkillProgressionData = skillData:GetRankData(rank + 1)

                    local id = skillProgressionData:GetAbilityId()
                    dialog.desc:SetText(zo_strformat(SI_SKILLS_UPGRADE_DESCRIPTION, GetAbilityName(id)))

                    local baseAbility = dialog.baseAbility
                    baseAbility.skillProgressionData = skillProgressionData
                    baseAbility.icon:SetTexture(GetAbilityIcon(id))
                    ZO_Skills_SetKeyboardAbilityButtonTextures(baseAbility)

                    local upgradeAbility = dialog.upgradeAbility
                    local idUpgrade = nextSkillProgressionData:GetAbilityId()
                    upgradeAbility.skillProgressionData = nextSkillProgressionData
                    upgradeAbility.icon:SetTexture(GetAbilityIcon(idUpgrade))
                    ZO_Skills_SetKeyboardAbilityButtonTextures(upgradeAbility)

                    local hideAdvisement = ZO_SKILLS_ADVISOR_SINGLETON:IsAdvancedModeSelected() or not skillData:IsAdvised()
                    advisementLabel:SetHidden(hideAdvisement)
                end
            end

            ZO_Dialogs_RegisterCustomDialog("UPGRADE_ABILITY_CONFIRM",
            {
                customControl = upgradeDialogControl,
                setup = SetupUpgradeAbilityDialog,
                title =
                {
                    text = SI_SKILLS_UPGRADE_ABILITY,
                },
                buttons =
                {
                    [1] =
                    {
                        control = upgradeDialogControl:GetNamedChild("Confirm"),
                        text =  SI_SKILLS_UPGRADE_CONFIRM,
                        callback =  function(dialog)
                                        local skillData = dialog.data
                                        local skillPointAllocator = skillData:GetPointAllocator()
                                        skillPointAllocator:IncreaseRank()
                                    end,
                    },
                    [2] =
                    {
                        control =   upgradeDialogControl:GetNamedChild("Cancel"),
                        text =      SI_CANCEL,
                    }
                }
            })
        end

        InitializeKeyboardConfirmDialog()
        InitializeKeyboardUpgradeDialog()
end
