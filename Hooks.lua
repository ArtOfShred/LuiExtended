--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat
local printToChat = LUIE.PrintToChat

function LUIE.InitializeHooks()

        -- TODO: Localize
        local buffTypes = {
            [LUIE_BUFF_TYPE_BUFF] = "Buff",
            [LUIE_BUFF_TYPE_DEBUFF] = "Debuff",
            [LUIE_BUFF_TYPE_UB_BUFF] = "Cosmetic Buff",
            [LUIE_BUFF_TYPE_UB_DEBUFF] = "Unbreakable Debuff",
            [LUIE_BUFF_TYPE_GROUND_BUFF_TRACKER] = "AOE Buff Tracker",
            [LUIE_BUFF_TYPE_GROUND_DEBUFF_TRACKER] = "AOE Debuff Tracker",
            [LUIE_BUFF_TYPE_GROUND_AOE_BUFF] = "AOE Buff",
            [LUIE_BUFF_TYPE_GROUND_AOE_DEBUFF] = "AOE Debuff",
            [LUIE_BUFF_TYPE_ENVIRONMENT_BUFF] = "Zone Buff",
            [LUIE_BUFF_TYPE_ENVIRONMENT_DEBUFF] = "Hazard",
            [LUIE_BUFF_TYPE_NONE] = "None",
        }

        -- Hook Gamepad Skill Advisor for custom icon support
        LUIE.InitializeHooksSkillAdvisor()

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

        -- Hook DoesKillingAttackHaveAttacker - Add a source to attacks that don't normally show one (mostly for environmental effects)
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

        -- Hook Skills Advisor (Keyboard) and use this variable to refresh the abilityData one time on initialization. We don't want to reload any more after that.
        ZO_SkillsAdvisor_Suggestions_Keyboard.SetupAbilityEntry = function(self, control, skillProgressionData)
            local skillData = skillProgressionData:GetSkillData()
            local isPassive = skillData:IsPassive()

            control.skillProgressionData = skillProgressionData
            control.slot.skillProgressionData = skillProgressionData

            -- slot
            ZO_Skills_SetKeyboardAbilityButtonTextures(control.slot)
            local id = skillProgressionData:GetAbilityId()
            control.slotIcon:SetTexture(GetAbilityIcon(id))
            control.slotLock:SetHidden(skillProgressionData:IsUnlocked())
            local morphControl = control:GetNamedChild("Morph")
            morphControl:SetHidden(isPassive or not skillProgressionData:IsMorph())

            -- name
            local detailedName
            if isPassive and skillData:GetNumRanks() > 1 then
                detailedName = skillProgressionData:GetFormattedNameWithRank()
            else
                detailedName = skillProgressionData:GetFormattedName()
            end
            detailedName = detailedName:gsub("With", "with") -- Easiest way to fix the capitalization of the skill "Bond With Nature"
            detailedName = detailedName:gsub("Blessing Of", "Blessing of") -- Easiest way to fix the capitalization of the skill "Blessing of Restoration"
            control.nameLabel:SetText(detailedName)
            control.nameLabel:SetColor(PURCHASED_COLOR:UnpackRGBA())
        end

        -- Hook Action Slots
        local ACTION_BUTTON_BGS = {ability = "EsoUI/Art/ActionBar/abilityInset.dds", item = "EsoUI/Art/ActionBar/quickslotBG.dds"}
        local ACTION_BUTTON_BORDERS = {normal = "EsoUI/Art/ActionBar/abilityFrame64_up.dds", mouseDown = "EsoUI/Art/ActionBar/abilityFrame64_down.dds"}

        local function SetupActionSlot(slotObject, slotId)
            -- pass slotObject.button.hotbarCategory which will be nil or companion
            local slotIcon = GetSlotTexture(slotId, slotObject.button.hotbarCategory)

            -- Added function - Replace icons if needed
            local abilityId = GetSlotBoundId(slotId, slotObject.button.hotbarCategory)
            if LUIE.Data.Effects.BarIdOverride[abilityId] then
                slotIcon = LUIE.Data.Effects.BarIdOverride[abilityId]
            end

            slotObject:SetEnabled(true)
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

        SetupSlotHandlers =
        {
            [ACTION_TYPE_ABILITY]       = SetupAbilitySlot,
            [ACTION_TYPE_ITEM]          = SetupItemSlot,
            [ACTION_TYPE_COLLECTIBLE]   = SetupCollectibleActionSlot,
            [ACTION_TYPE_QUEST_ITEM]    = SetupQuestItemActionSlot,
            [ACTION_TYPE_NOTHING]       = SetupEmptyActionSlot,
        }

        -- Hook to make Activation Highlight Effect play indefinitely instead of animation only once
        ActionButton.UpdateActivationHighlight = function(self)
            local slotnum = self:GetSlot()
            local hotbarCategory = self.slot.slotNum == 1 and HOTBAR_CATEGORY_QUICKSLOT_WHEEL or self.button.hotbarCategory
            local slotType = GetSlotType(slotnum, hotbarCategory)
            local slotIsEmpty = (slotType == ACTION_TYPE_NOTHING)

            local abilityId = GetSlotBoundId(slotnum, hotbarCategory) -- Check AbilityId for if this should be a fake activation highlight

            local showHighlight = not slotIsEmpty and (HasActivationHighlight(slotnum, hotbarCategory) or LUIE.Data.Effects.IsAbilityActiveGlow[abilityId] == true) and not self.useFailure and not self.showingCooldown
            local isShowingHighlight = self.activationHighlight:IsHidden() == false

            if showHighlight ~= isShowingHighlight then
                self.activationHighlight:SetHidden(not showHighlight)

                if showHighlight then
                    local _, _, activationAnimationTexture = GetSlotTexture(slotnum, hotbarCategory)
                    self.activationHighlight:SetTexture(activationAnimationTexture)

                    local anim = self.activationHighlight.animation
                    if not anim then
                        anim = CreateSimpleAnimation(ANIMATION_TEXTURE, self.activationHighlight)
                        anim:SetImageData(64, 1)
                        anim:SetFramerate(30)
                        anim:GetTimeline():SetPlaybackType(ANIMATION_PLAYBACK_LOOP, LOOP_INDEFINITELY)

                        self.activationHighlight.animation = anim
                    end

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
            local hotbarCategory = self.slot.slotNum == 1 and HOTBAR_CATEGORY_QUICKSLOT_WHEEL or self.button.hotbarCategory
            local slotType = GetSlotType(slotnum, hotbarCategory)
            local slotIsEmpty = (slotType == ACTION_TYPE_NOTHING)
            local abilityId = GetSlotBoundId(slotnum, hotbarCategory) -- Check AbilityId for if this should be a fake activation highlight

            self.button.actionId = GetSlotBoundId(slotnum, hotbarCategory)

            self:UpdateUseFailure()

            local hidden = true
            if IsSlotToggled(slotnum, hotbarCategory) == true or LUIE.Data.Effects.IsAbilityActiveHighlight[abilityId] == true then
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
            if DoesCampaignHaveEmperor(campaignId) then
                local alliance = GetCampaignEmperorInfo(campaignId)
                if alliance == GetUnitAlliance("player") then
                    return 1
                end
            end

            return 0
        end

        local BONUS_SECTION_DATA =
        {
            [ZO_CAMPAIGN_BONUS_TYPE_HOME_KEEPS] =           {
                                                    typeIcon = "EsoUI/Art/Campaign/campaignBonus_keepIcon.dds",
                                                    typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_keeps.dds",
                                                    headerText = GetString(SI_CAMPAIGN_BONUSES_HOME_KEEP_HEADER),
                                                    infoText = GetHomeKeepBonusString,
                                                    count = 1,
                                                    countText = GetString(SI_CAMPAIGN_BONUSES_HOME_KEEP_ALL),
                                                    abilityFunction = GetKeepScoreBonusAbilityId,
                                                    scoreFunction = GetHomeKeepBonusScore,
                                                },
            [ZO_CAMPAIGN_BONUS_TYPE_ENEMY_KEEPS] =          {
                                                    typeIcon = "EsoUI/Art/Campaign/campaignBonus_keepIcon.dds",
                                                    typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_keeps.dds",
                                                    headerText = GetString(SI_CAMPAIGN_BONUSES_ENEMY_KEEP_HEADER),
                                                    infoText = GetKeepBonusString,
                                                    count = GetNumKeepScoreBonuses,
                                                    startIndex = 2,
                                                    abilityFunction = GetKeepScoreBonusAbilityId,
                                                    scoreFunction = GetKeepBonusScore,
                                                },
            [ZO_CAMPAIGN_BONUS_TYPE_DEFENSIVE_SCROLLS] =    {
                                                    typeIcon = "EsoUI/Art/Campaign/campaignBonus_scrollIcon.dds",
                                                    typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_scrolls.dds",
                                                    headerText = GetString(SI_CAMPAIGN_BONUSES_DEFENSIVE_SCROLL_HEADER),
                                                    infoText = GetDefensiveBonusString,
                                                    count = GetDefensiveBonusCount,
                                                    abilityFunction = GetDefensiveBonusAbilityId,
                                                    scoreFunction = GetDefensiveBonusScore,
                                                },
            [ZO_CAMPAIGN_BONUS_TYPE_OFFENSIVE_SCROLLS] =    {
                                                    typeIcon = "EsoUI/Art/Campaign/campaignBonus_scrollIcon.dds",
                                                    typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_scrolls.dds",
                                                    headerText = GetString(SI_CAMPAIGN_BONUSES_OFFENSIVE_SCROLL_HEADER),
                                                    infoText = GetOffensiveBonusString,
                                                    count = GetOffensiveBonusCount,
                                                    abilityFunction = GetOffensiveBonusAbilityId,
                                                    scoreFunction = GetOffensiveBonusScore,
                                                },
            [ZO_CAMPAIGN_BONUS_TYPE_EMPEROR] =              {
                                                    typeIcon = "EsoUI/Art/Campaign/campaignBonus_emporershipIcon.dds",
                                                    typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_emperor.dds",
                                                    headerText = GetString(SI_CAMPAIGN_BONUSES_EMPERORSHIP_HEADER),
                                                    infoText = GetEmperorBonusString,
                                                    count = 1,
                                                    countText = HIDE_COUNT,
                                                    abilityFunction = GetEmperorBonusAbilityId,
                                                    scoreFunction = GetEmperorBonusScore,
                                                },
            [ZO_CAMPAIGN_BONUS_TYPE_EDGE_KEEPS] =           {
                                                    typeIcon = "EsoUI/Art/Campaign/campaignBonus_keepIcon.dds",
                                                    typeIconGamepad = "EsoUI/Art/Campaign/Gamepad/gp_bonusIcon_keeps.dds",
                                                    headerText = GetString(SI_CAMPAIGN_BONUSES_EDGE_KEEP_HEADER),
                                                    infoText = GetEdgeKeepBonusString,
                                                    count = GetNumEdgeKeepBonuses,
                                                    abilityFunction = GetEdgeKeepBonusAbilityId,
                                                    scoreFunction = GetEdgeKeepBonusScore,
                                                },
        }

        -- Hook Campaign Bonuses functions
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
                    self.dataTable[i].abilityId = data.abilityId -- Add AbilityId here for LUIE functions
                    self.dataTable[i].typeIcon = data.typeIcon
                    self.dataTable[i].countText = data.countText
                    self.dataTable[i].name = data.name -- Add AbilityName here for LUIE functions
                    self.dataTable[i].active = data.active
                    self.dataTable[i].bonusType = data.bonusType
                    self.dataTable[i].description = data.description

                    nextItemIsHeader = false
                end
            end
        end

        -- Hook Campaign Bonuses functions
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
                    local icon = (LUIE.Data.Effects.EffectOverride[abilityId] and LUIE.Data.Effects.EffectOverride[abilityId].passiveIcon) and LUIE.Data.Effects.EffectOverride[abilityId].passiveIcon or GetAbilityIcon(abilityId) -- Get Updated LUIE AbilityIcon here
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
                        abilityId = abilityId, -- Add AbilityId here for LUIE functions
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

        -- Hook Gamepad Campaign Bonuses tooltip
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

        -- Hook Campaign Bonuses
        CAMPAIGN_BONUSES.SetupBonusesEntry = function(self, control, data)
            ZO_SortFilterList.SetupRow(self, control, data)

            control.typeIcon = GetControl(control, "TypeIcon")
            control.count = GetControl(control, "Count")
            control.ability = GetControl(control, "Ability")
            control.icon = GetControl(control.ability, "Icon")
            control.nameLabel = GetControl(control, "Name")
            control.ability.index = data.index
            control.ability.bonusType = data.bonusType
            control.ability.abilityId = data.abilityId -- Add AbilityId here
            control.ability.name = data.name -- Add AbilityName here
            control.ability.description = data.description -- Add tooltip here

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

        -- Hook Campaign Bonuses Tooltip
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

        -- Hook AVA Keep Upgrade
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

        -- Hook Keep Upgrade Tooltip (Keyboard)
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

        -- Variables for Skill Window Hook
        local INCREASE_BUTTON_TEXTURES =
        {
            PLUS =
            {
                normal = "EsoUI/Art/Progression/addPoints_up.dds",
                mouseDown = "EsoUI/Art/Progression/addPoints_down.dds",
                mouseover = "EsoUI/Art/Progression/addPoints_over.dds",
                disabled = "EsoUI/Art/Progression/addPoints_disabled.dds",
            },
            MORPH =
            {
                normal = "EsoUI/Art/Progression/morph_up.dds",
                mouseDown = "EsoUI/Art/Progression/morph_down.dds",
                mouseover = "EsoUI/Art/Progression/morph_over.dds",
                disabled = "EsoUI/Art/Progression/morph_disabled.dds",
            },
            REMORPH =
            {
                normal = "EsoUI/Art/Progression/remorph_up.dds",
                mouseDown = "EsoUI/Art/Progression/remorph_down.dds",
                mouseover = "EsoUI/Art/Progression/remorph_over.dds",
                disabled = "EsoUI/Art/Progression/remorph_disabled.dds",
            },
        }

        -- Local function for Skill Window Hook
        local function ApplyButtonTextures(button, textures)
            button:SetNormalTexture(textures.normal)
            button:SetPressedTexture(textures.mouseDown)
            button:SetMouseOverTexture(textures.mouseover)
            button:SetDisabledTexture(textures.disabled)
        end

        -- Hook Skills Window (Keyboard)
        function ZO_Skills_AbilityEntry_Setup(control, skillData)
            local skillPointAllocator = skillData:GetPointAllocator()
            local skillProgressionData = skillPointAllocator:GetProgressionData()

            local isPassive = skillData:IsPassive()
            local isActive = not isPassive
            local isPurchased = skillPointAllocator:IsPurchased()
            local isUnlocked = skillProgressionData:IsUnlocked()

            local lastSkillProgressionData = control.skillProgressionData
            control.skillProgressionData = skillProgressionData
            control.slot.skillProgressionData = skillProgressionData

            -- slot
            local id = skillProgressionData:GetAbilityId()
            control.slotIcon:SetTexture(GetAbilityIcon(id))
            ZO_Skills_SetKeyboardAbilityButtonTextures(control.slot)
            ZO_ActionSlot_SetUnusable(control.slotIcon, not isPurchased)
            control.slot:SetEnabled(isPurchased and isActive)
            control.slotLock:SetHidden(isUnlocked)

            -- xp bar
            local showXPBar = skillProgressionData:HasRankData()
            if showXPBar then
                local currentRank = skillProgressionData:GetCurrentRank()
                local startXP, endXP = skillProgressionData:GetRankXPExtents(currentRank)
                local currentXP = skillProgressionData:GetCurrentXP()
                local dontWrap = lastSkillProgressionData ~= skillProgressionData

                control.xpBar:SetHidden(false)
                ZO_SkillInfoXPBar_SetValue(control.xpBar, currentRank, startXP, endXP, currentXP, dontWrap)
            else
                local NO_LEVEL = nil
                local START_XP = 0
                local END_XP = 1
                local NO_XP = 0
                local DONT_WRAP = true

                control.xpBar:SetHidden(true)
                ZO_SkillInfoXPBar_SetValue(control.xpBar, NO_LEVEL, START_XP, END_XP, NO_XP, DONT_WRAP)
            end

            -- name
            local detailedName = skillProgressionData:GetDetailedName()
            detailedName = detailedName:gsub("With", "with") -- Easiest way to fix the capitalization of the skill "Bond With Nature"
            detailedName = detailedName:gsub("Blessing Of", "Blessing of") -- Easiest way to fix the capitalization of the skill "Blessing of Restoration"
            control.nameLabel:SetText(detailedName)
            local offsetY = showXPBar and -10 or 0
            control.nameLabel:SetAnchor(LEFT, control.slot, RIGHT, 10, offsetY)

            if isPurchased then
                control.nameLabel:SetColor(PURCHASED_COLOR:UnpackRGBA())
            else
                if isUnlocked then
                    control.nameLabel:SetColor(UNPURCHASED_COLOR:UnpackRGBA())
                else
                    control.nameLabel:SetColor(LOCKED_COLOR:UnpackRGBA())
                end
            end

            -- increase/decrease buttons
            local increaseButton = control.increaseButton
            local decreaseButton = control.decreaseButton
            local hideIncreaseButton = true
            local hideDecreaseButton = true
            local canPurchase = skillPointAllocator:CanPurchase()
            local canIncreaseRank = skillPointAllocator:CanIncreaseRank()
            local canMorph = skillPointAllocator:CanMorph()
            local skillPointAllocationMode = SKILLS_AND_ACTION_BAR_MANAGER:GetSkillPointAllocationMode()
            if skillPointAllocationMode == SKILL_POINT_ALLOCATION_MODE_PURCHASE_ONLY then
                local increaseTextures
                if canMorph then
                    increaseTextures = INCREASE_BUTTON_TEXTURES.MORPH
                elseif canPurchase or canIncreaseRank then
                    increaseTextures = INCREASE_BUTTON_TEXTURES.PLUS
                end

                if increaseTextures then
                    ApplyButtonTextures(increaseButton, increaseTextures)
                    if GetActionBarLockedReason() == ACTION_BAR_LOCKED_REASON_COMBAT then
                        increaseButton:SetState(BSTATE_DISABLED)
                    else
                        increaseButton:SetState(BSTATE_NORMAL)
                    end
                    hideIncreaseButton = false
                end
            else
                local isFullRespec = skillPointAllocationMode == SKILL_POINT_ALLOCATION_MODE_FULL
                if skillData:CanPointAllocationsBeAltered(isFullRespec) then
                    hideIncreaseButton = false
                    hideDecreaseButton = false

                    if isPassive or not isPurchased or not skillData:IsAtMorph() then
                        ApplyButtonTextures(increaseButton, INCREASE_BUTTON_TEXTURES.PLUS)
                    else
                        if skillProgressionData:IsMorph() then
                            ApplyButtonTextures(increaseButton, INCREASE_BUTTON_TEXTURES.REMORPH)
                        else
                            ApplyButtonTextures(increaseButton, INCREASE_BUTTON_TEXTURES.MORPH)
                        end
                    end

                    if canMorph or canPurchase or canIncreaseRank then
                        increaseButton:SetState(BSTATE_NORMAL)
                    else
                        increaseButton:SetState(BSTATE_DISABLED)
                    end

                    if skillPointAllocator:CanSell() or skillPointAllocator:CanDecreaseRank() or skillPointAllocator:CanUnmorph() then
                        decreaseButton:SetState(BSTATE_NORMAL)
                    else
                        decreaseButton:SetState(BSTATE_DISABLED)
                    end
                end
            end

            increaseButton:SetHidden(hideIncreaseButton)
            decreaseButton:SetHidden(hideDecreaseButton)
        end

        -- Overwrite default Skill Confirm Learn Menu for Skills with Custom Icons (Keyboard)
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

        -- Overwrite default Upgrade menu for Skills with Custom Icons (Keyboard)
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

        -- Function for Gamepad Skills Hook
        local function SetupAbilityIconFrame(control, isPassive, isActive, isAdvised)
            local iconTexture = control.icon

            local DOUBLE_FRAME_THICKNESS = 9
            local SINGLE_FRAME_THICKNESS = 5
            --Circle Frame (Passive)
            local circleFrameTexture = control.circleFrame
            if circleFrameTexture then
                if isPassive then
                    circleFrameTexture:SetHidden(false)
                    local frameOffsetFromIcon
                    if isAdvised then
                        frameOffsetFromIcon = DOUBLE_FRAME_THICKNESS
                        circleFrameTexture:SetTexture("EsoUI/Art/SkillsAdvisor/gamepad/gp_passiveDoubleFrame_64.dds")
                    else
                        frameOffsetFromIcon = SINGLE_FRAME_THICKNESS
                        circleFrameTexture:SetTexture("EsoUI/Art/Miscellaneous/Gamepad/gp_passiveFrame_64.dds")
                    end
                    circleFrameTexture:ClearAnchors()
                    circleFrameTexture:SetAnchor(TOPLEFT, iconTexture, TOPLEFT, -frameOffsetFromIcon, -frameOffsetFromIcon)
                    circleFrameTexture:SetAnchor(BOTTOMRIGHT, iconTexture, BOTTOMRIGHT, frameOffsetFromIcon, frameOffsetFromIcon)
                else
                    control.circleFrame:SetHidden(true)
                end
            end

            --Edge Frame (Active)
            local SKILLS_ADVISOR_ACTIVE_DOUBLE_FRAME_WIDTH = 128
            local SKILLS_ADVISOR_ACTIVE_DOUBLE_FRAME_HEIGHT = 16
            local edgeFrameBackdrop = control.edgeFrame
            if isActive then
                edgeFrameBackdrop:SetHidden(false)
                local frameOffsetFromIcon
                if isAdvised then
                    frameOffsetFromIcon = DOUBLE_FRAME_THICKNESS
                    edgeFrameBackdrop:SetEdgeTexture("EsoUI/Art/SkillsAdvisor/gamepad/edgeDoubleframeGamepadBorder.dds", SKILLS_ADVISOR_ACTIVE_DOUBLE_FRAME_WIDTH, SKILLS_ADVISOR_ACTIVE_DOUBLE_FRAME_HEIGHT)
                else
                    frameOffsetFromIcon = SINGLE_FRAME_THICKNESS
                    edgeFrameBackdrop:SetEdgeTexture("EsoUI/Art/Miscellaneous/Gamepad/edgeframeGamepadBorder.dds", SKILLS_ADVISOR_ACTIVE_DOUBLE_FRAME_WIDTH, SKILLS_ADVISOR_ACTIVE_DOUBLE_FRAME_HEIGHT)
                end
                edgeFrameBackdrop:ClearAnchors()
                edgeFrameBackdrop:SetAnchor(TOPLEFT, iconTexture, TOPLEFT, -frameOffsetFromIcon, -frameOffsetFromIcon)
                edgeFrameBackdrop:SetAnchor(BOTTOMRIGHT, iconTexture, BOTTOMRIGHT, frameOffsetFromIcon, frameOffsetFromIcon)
            else
                edgeFrameBackdrop:SetHidden(true)
            end

        end

        local function SetBindingTextForSkill(keybindLabel, skillData)
            local hasBinding = false
            local keybindWidth = 0
            --The spot where the keybind goes is occupied by the decrease button in the respec modes
            if SKILLS_AND_ACTION_BAR_MANAGER:GetSkillPointAllocationMode() == SKILL_POINT_ALLOCATION_MODE_PURCHASE_ONLY and skillData:IsActive() then
                local slot = skillData:GetSlotOnCurrentHotbar()
                if slot then
                    hasBinding = true
                    local hotbarCategory = ACTION_BAR_ASSIGNMENT_MANAGER:GetCurrentHotbarCategory()
                    local GAMEPAD_MODE = true
                    local actionName = ACTION_BAR_ASSIGNMENT_MANAGER:GetActionNameForSlot(slot, hotbarCategory, GAMEPAD_MODE)
                    local bindingText = ""
                    if actionName then
                        bindingText = ZO_Keybindings_GetHighestPriorityBindingStringFromAction(actionName, KEYBIND_TEXT_OPTIONS_FULL_NAME, KEYBIND_TEXTURE_OPTIONS_EMBED_MARKUP, GAMEPAD_MODE)
                        local layerIndex, categoryIndex, actionIndex = GetActionIndicesFromName(actionName)
                        if layerIndex then
                            local key = GetActionBindingInfo(layerIndex, categoryIndex, actionIndex, 1)
                            if IsKeyCodeChordKey(key) then
                                keybindWidth = 90   --width minus double keybind width (RB+LB)
                            else
                                keybindWidth = 50   --width minus single keybind
                            end
                        end
                    else
                        bindingText = zo_iconFormat("EsoUI/Art/Inventory/Gamepad/gp_inventory_icon_equipped.dds", "100%", "100%")
                        keybindWidth = 50   --width minus single keybind
                    end
                    keybindLabel:SetText(bindingText)
                end
            end

            if hasBinding then
                keybindLabel:SetHidden(false)
            else
                keybindLabel:SetHidden(true)
                -- other controls depend on the keybind width for layout so let's reset its size too
                keybindLabel:SetText("")
            end

            return keybindWidth
        end

        local function SetupIndicatorsForSkill(leftIndicator, rightIndicator, skillData, showIncrease, showDecrease, showNew)
            local indicatorRightWidth = 0

            --If we don't have a left indicator then we aren't going to have a right indicator either, so exit the function
            if not leftIndicator then
                return indicatorRightWidth
            end
            local skillPointAllocator = skillData:GetPointAllocator()

            local increaseMultiIcon
            local decreaseMultiIcon
            if rightIndicator == nil then
                increaseMultiIcon = leftIndicator
                decreaseMultiIcon = leftIndicator
                leftIndicator:ClearIcons()
            elseif SKILLS_AND_ACTION_BAR_MANAGER:DoesSkillPointAllocationModeBatchSave() then
                increaseMultiIcon = rightIndicator
                decreaseMultiIcon = leftIndicator
                leftIndicator:ClearIcons()
                rightIndicator:ClearIcons()
            else
                increaseMultiIcon = leftIndicator
                decreaseMultiIcon = rightIndicator
                leftIndicator:ClearIcons()
                rightIndicator:ClearIcons()
            end

            --Increase (Morph, Purchase, Increase Rank) Icon
            local increaseAction = ZO_SKILL_POINT_ACTION.NONE
            if showIncrease then
                increaseAction = skillPointAllocator:GetIncreaseSkillAction()
            elseif isMorph then
                -- this is used more as an indicator that this skill has been morphed, than an indicator that you _should_ morph it
                increaseAction = ZO_SKILL_POINT_ACTION.MORPH
            end

            if increaseAction ~= ZO_SKILL_POINT_ACTION.NONE then
                increaseMultiIcon:AddIcon(ZO_Skills_GetGamepadSkillPointActionIcon(increaseAction))
            end

            --Decrease (Unmorph, Sell, Decrease Rank)
            if showDecrease then
                local decreaseAction = skillPointAllocator:GetDecreaseSkillAction()
                if decreaseAction ~= ZO_SKILL_POINT_ACTION.NONE then
                    decreaseMultiIcon:AddIcon(ZO_Skills_GetGamepadSkillPointActionIcon(decreaseAction))
                end

                --Always carve out space for the decrease icon even if it isn't active so the name doesn't dance around as it appears and disappears
                indicatorRightWidth = 40
            end

            --New Indicator
            if showNew then
                if skillData:HasUpdatedStatus() then
                    leftIndicator:AddIcon("EsoUI/Art/Inventory/newItem_icon.dds")
                end
            end

            leftIndicator:Show()
            if rightIndicator then
                rightIndicator:Show()
            end

            return indicatorRightWidth
        end

        local SKILL_ENTRY_LABEL_WIDTH = 289

        -- Hook for Gamepad Skills Menu
        function ZO_GamepadSkillEntryTemplate_Setup(control, skillEntry, selected, activated, displayView)
            --Some skill entries want to target a specific progression data (such as the morph dialog showing two specific morphs). Otherwise they use the skill progression that matches the current point spending.
            local skillData = skillEntry.skillData or skillEntry.skillProgressionData:GetSkillData()
            local skillProgressionData = skillEntry.skillProgressionData or skillData:GetPointAllocatorProgressionData()
            local skillPointAllocator = skillData:GetPointAllocator()
            local isUnlocked = skillProgressionData:IsUnlocked()
            local isMorph = skillData:IsActive() and skillProgressionData:IsMorph()
            local isPurchased = skillPointAllocator:IsPurchased()
            local isInSkillBuild = skillProgressionData:IsAdvised()
            local abilityId = skillProgressionData.abilityId

            --Icon
            local iconTexture = control.icon
            iconTexture:SetTexture(GetAbilityIcon(abilityId))
            if displayView == ZO_SKILL_ABILITY_DISPLAY_INTERACTIVE then
                if isPurchased then
                    iconTexture:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
                else
                    iconTexture:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
                end
            end

            SetupAbilityIconFrame(control, skillData:IsPassive(), skillData:IsActive(), isInSkillBuild)

            --Label Color
            if displayView == ZO_SKILL_ABILITY_DISPLAY_INTERACTIVE then
                if not skillEntry.isPreview and isPurchased then
                    control.label:SetColor((selected and PURCHASED_COLOR or PURCHASED_UNSELECTED_COLOR):UnpackRGBA())
                end
            else
                control.label:SetColor(PURCHASED_COLOR:UnpackRGBA())
            end

            --Lock Icon
            if control.lock then
                control.lock:SetHidden(isUnlocked)
            end

            local labelWidth = SKILL_ENTRY_LABEL_WIDTH

            local showIncrease = (displayView == ZO_SKILL_ABILITY_DISPLAY_INTERACTIVE)
            local showDecrease = SKILLS_AND_ACTION_BAR_MANAGER:DoesSkillPointAllocationModeAllowDecrease()
            local showNew = (displayView == ZO_SKILL_ABILITY_DISPLAY_INTERACTIVE)
            local indicatorWidth = SetupIndicatorsForSkill(control.leftIndicator, control.rightIndicator, skillData, showIncrease, showDecrease, showNew)
            labelWidth = labelWidth - indicatorWidth

            if displayView == ZO_SKILL_ABILITY_DISPLAY_INTERACTIVE then
                --Current Binding Text
                if control.keybind then
                    local keybindWidth = SetBindingTextForSkill(control.keybind, skillData)
                    labelWidth = labelWidth - keybindWidth
                end
            end

            --Size the label to allow space for the keybind and decrease icon
            control.label:SetWidth(labelWidth)
        end

        -- Hook for Gamepad Skills Preview
        function ZO_GamepadSkillEntryPreviewRow_Setup(control, skillData)
            local skillProgressionData = skillData:GetPointAllocatorProgressionData()
            local skillPointAllocator = skillData:GetPointAllocator()
            local isUnlocked = skillProgressionData:IsUnlocked()
            local isPurchased = skillPointAllocator:IsPurchased()
            local isMorph = skillData:IsPlayerSkill() and skillData:IsActive() and skillProgressionData:IsMorph()
            local abilityId = skillProgressionData.abilityId

            --Icon
            local iconTexture = control.icon
            iconTexture:SetTexture(GetAbilityIcon(abilityId))
            if isPurchased then
                iconTexture:SetColor(ZO_DEFAULT_ENABLED_COLOR:UnpackRGBA())
            else
                iconTexture:SetColor(ZO_DEFAULT_DISABLED_COLOR:UnpackRGBA())
            end

            SetupAbilityIconFrame(control, skillData:IsPassive(), skillData:IsActive(), skillProgressionData:IsAdvised())

            --Label
            control.label:SetText(skillProgressionData:GetDetailedGamepadName())
            local color = skillPointAllocator:IsPurchased() and ZO_SELECTED_TEXT or ZO_DISABLED_TEXT
            control.label:SetColor(color:UnpackRGBA())

            --Lock Icon
            control.lock:SetHidden(isUnlocked)

            -- indicator
            local labelWidth = SKILL_ENTRY_LABEL_WIDTH
            local NO_RIGHT_INDICATOR = nil
            local SHOW_INCREASE = true
            local showDecrease = SKILLS_AND_ACTION_BAR_MANAGER:DoesSkillPointAllocationModeAllowDecrease()
            local SHOW_NEW = true
            local indicatorWidth = SetupIndicatorsForSkill(control.leftIndicator, NO_RIGHT_INDICATOR, skillData, SHOW_INCREASE, showDecrease, SHOW_NEW)
            labelWidth = labelWidth - indicatorWidth

            local keybindWidth = SetBindingTextForSkill(control.keybind, skillData)
            labelWidth = labelWidth - keybindWidth

            --Size the label to allow space for the keybind and decrease icon
            control.label:SetWidth(labelWidth)
        end

end
