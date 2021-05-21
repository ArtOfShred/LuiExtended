--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local CombatInfo = LUIE.CombatInfo
CombatInfo.CrowdControlTracker = {}
local CrowdControlTracker = CombatInfo.CrowdControlTracker

local Effects = LUIE.Data.Effects
local CrowdControl = LUIE.Data.CrowdControl

local eventManager = EVENT_MANAGER
local animationManager = ANIMATION_MANAGER
local callbackManager = CALLBACK_MANAGER

local moduleName = LUIE.name .. "CombatInfo"

local PriorityOne, PriorityTwo, PriorityThree, PriorityFour, PrioritySix

local staggerDuration = 800
local areaDuration = 1100
local graceTime = 5

local iconFont = "$(GAMEPAD_BOLD_FONT)|25|thick-outline"
local staggerFont = "$(GAMEPAD_BOLD_FONT)|36|thick-outline"

local iconBorder = "LuiExtended/media/combatinfo/crowdcontroltracker/border.dds"

local SET_SCALE_FROM_SV = true
local BREAK_FREE_ID = 16565
local NEGATE_MAGIC_ID = 47158
local NEGATE_MAGIC_1_ID = 51894
local ICON_MISSING = "icon_missing"

local ACTION_RESULT_AREA_EFFECT=669966

CrowdControlTracker.controlTypes = {
    ACTION_RESULT_STUNNED,
    ACTION_RESULT_FEARED,
    ACTION_RESULT_DISORIENTED,
    ACTION_RESULT_SILENCED,
    ACTION_RESULT_STAGGERED,
    ACTION_RESULT_AREA_EFFECT,
}

CrowdControlTracker.actionResults = {
    [ACTION_RESULT_STUNNED]           = true,
    [ACTION_RESULT_FEARED]            = true,
    [ACTION_RESULT_DISORIENTED]       = true,
}

CrowdControlTracker.controlText = {
    [ACTION_RESULT_STUNNED]           = "STUNNED",
    [ACTION_RESULT_FEARED]            = "FEARED",
    [ACTION_RESULT_DISORIENTED]       = "DISORIENTED",
    [ACTION_RESULT_SILENCED]          = "SILENCED",
    [ACTION_RESULT_STAGGERED]         = "STAGGER",
    [ACTION_RESULT_IMMUNE]            = "IMMUNE",
    [ACTION_RESULT_DODGED]            = "DODGED",
    [ACTION_RESULT_BLOCKED]           = "BLOCKED",
    [ACTION_RESULT_BLOCKED_DAMAGE]    = "BLOCKED",
    [ACTION_RESULT_AREA_EFFECT]       = "AREA DAMAGE",
}

CrowdControlTracker.aoeHitTypes = {
    [ACTION_RESULT_BLOCKED]             = true,
    [ACTION_RESULT_BLOCKED_DAMAGE]      = true,
    [ACTION_RESULT_CRITICAL_DAMAGE]     = true,
    [ACTION_RESULT_DAMAGE]              = true,
    [ACTION_RESULT_DAMAGE_SHIELDED]     = true,
    [ACTION_RESULT_IMMUNE]              = true,
    [ACTION_RESULT_MISS]                = true,
    [ACTION_RESULT_PARTIAL_RESIST]      = true,
    [ACTION_RESULT_REFLECTED]           = true,
    [ACTION_RESULT_RESIST]              = true,
    [ACTION_RESULT_WRECKING_DAMAGE]     = true,
    [ACTION_RESULT_SNARED]              = true,
    [ACTION_RESULT_DOT_TICK]            = true,
    [ACTION_RESULT_DOT_TICK_CRITICAL]   = true,
}

function CrowdControlTracker:OnOff()
    if CombatInfo.SV.cct.enabled and not (CombatInfo.SV.cct.enabledOnlyInCyro and LUIE.ResolvePVPZone()) then
        if not self.addonEnabled then
            self.addonEnabled = true
            eventManager:RegisterForEvent(self.name, EVENT_PLAYER_ACTIVATED, self.Initialize)
            eventManager:RegisterForEvent(self.name, EVENT_COMBAT_EVENT, function(...) self:OnCombat(...) end)
            eventManager:RegisterForEvent(self.name, EVENT_PLAYER_STUNNED_STATE_CHANGED, function(...) self:OnStunnedState(...) end)
            eventManager:RegisterForEvent(self.name, EVENT_UNIT_DEATH_STATE_CHANGED, function(eventCode, unitTag, isDead) if isDead then self:FullReset() end end)
            eventManager:AddFilterForEvent(self.name, EVENT_UNIT_DEATH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG, "player")
            self.Initialize()
        end
    else
        if self.addonEnabled then
            self.addonEnabled = false
            eventManager:UnregisterForEvent(self.name, EVENT_PLAYER_ACTIVATED)
            eventManager:UnregisterForEvent(self.name, EVENT_COMBAT_EVENT)
            eventManager:UnregisterForEvent(self.name, EVENT_PLAYER_STUNNED_STATE_CHANGED)
            eventManager:UnregisterForEvent(self.name, EVENT_UNIT_DEATH_STATE_CHANGED)
            LUIE_CCTracker:SetHidden(true)
        end
    end
end

function CrowdControlTracker.Initialize()
    CrowdControlTracker:OnOff()
    if CombatInfo.SV.cct.enabled then
        CrowdControlTracker.currentlyPlaying = nil
        CrowdControlTracker.breakFreePlaying = nil
        CrowdControlTracker.immunePlaying = nil
        CrowdControlTracker:FullReset()
    end
end

-- Called before the rest of CCT is initialized, uses menu settings in order to create the table of abilities to use.
-- Also called by menu functions to reset this list.
function CrowdControlTracker.UpdateAOEList()
    local priority = 0 -- Counter for priority, we increment by one for each active category added
    CrowdControlTracker.aoeTypesId = { }

    if CombatInfo.SV.cct.aoePlayerUltimate then
        for k, v in pairs(CrowdControl.aoePlayerUltimate) do
            priority = priority + v
            CrowdControlTracker.aoeTypesId[k] = priority
        end
        priority = priority + 1
    end

    if CombatInfo.SV.cct.aoePlayerNormal then
        for k, v in pairs(CrowdControl.aoePlayerNormal) do
            priority = priority + v
            CrowdControlTracker.aoeTypesId[k] = priority
        end
        priority = priority + 1
    end

    if CombatInfo.SV.cct.aoePlayerSet then
        for k, v in pairs(CrowdControl.aoePlayerSet) do
            priority = priority + v
            CrowdControlTracker.aoeTypesId[k] = priority
        end
        priority = priority + 1
    end

    if CombatInfo.SV.cct.aoeTraps then
        for k, v in pairs(CrowdControl.aoeTraps) do
            priority = priority + v
            CrowdControlTracker.aoeTypesId[k] = priority
        end
        priority = priority + 1
    end

    if CombatInfo.SV.cct.aoeNPCBoss then
        for k, v in pairs(CrowdControl.aoeNPCBoss) do
            priority = priority + v
            CrowdControlTracker.aoeTypesId[k] = priority
        end
        priority = priority + 1
    end

    if CombatInfo.SV.cct.aoeNPCElite then
        for k, v in pairs(CrowdControl.aoeNPCElite) do
            priority = priority + v
            CrowdControlTracker.aoeTypesId[k] = priority
        end
        priority = priority + 1
    end

    if CombatInfo.SV.cct.aoeNPCNormal then
        for k, v in pairs(CrowdControl.aoeNPCNormal) do
            priority = priority + v
            CrowdControlTracker.aoeTypesId[k] = priority
        end
        priority = priority + 1
    end

end

function CrowdControlTracker.PlaySoundAoe(abilityId)
    -- I hope you like inline conditionals, because we've got them for days!
    -- If we have sound enabled for the type of AOE this ability is then fetch it.
    local playSound =  ( (CrowdControl.aoePlayerUltimate[abilityId] and CombatInfo.SV.cct.aoePlayerUltimateSoundToggle) and CombatInfo.SV.cct.aoePlayerUltimateSound )
                    or ( (CrowdControl.aoePlayerNormal[abilityId] and CombatInfo.SV.cct.aoePlayerNormalSoundToggle) and CombatInfo.SV.cct.aoePlayerNormalSound )
                    or ( (CrowdControl.aoePlayerSet[abilityId] and CombatInfo.SV.cct.aoePlayerSetSoundToggle) and CombatInfo.SV.cct.aoePlayerSetSound )
                    or ( (CrowdControl.aoeTraps[abilityId] and CombatInfo.SV.cct.aoeTrapsSoundToggle) and CombatInfo.SV.cct.aoeTrapsSound )
                    or ( (CrowdControl.aoeNPCBoss[abilityId] and CombatInfo.SV.cct.aoeNPCBossSoundToggle) and CombatInfo.SV.cct.aoeNPCBossSound )
                    or ( (CrowdControl.aoeNPCElite[abilityId] and CombatInfo.SV.cct.aoeNPCEliteSoundToggle) and CombatInfo.SV.cct.aoeNPCEliteSound )
                    or ( (CrowdControl.aoeNPCNormal[abilityId] and CombatInfo.SV.cct.aoeNPCNormalSoundToggle) and CombatInfo.SV.cct.aoeNPCNormalSound )

    -- If we found a sound, then play it (twice so it's a bit louder)
    if playSound then
        PlaySound(LUIE.Sounds[playSound])
        PlaySound(LUIE.Sounds[playSound])
    else
        return
    end
end

-- GAP between INIT and code for now

function CrowdControlTracker:SavePosition()
    local coordX, coordY = LUIE_CCTracker:GetCenter()
    CombatInfo.SV.cct.offsetX = coordX - (GuiRoot:GetWidth() / 2)
    CombatInfo.SV.cct.offsetY = coordY - (GuiRoot:GetHeight() / 2)
    LUIE_CCTracker:ClearAnchors()
    LUIE_CCTracker:SetAnchor(CENTER, GuiRoot, CENTER, CombatInfo.SV.cct.offsetX, CombatInfo.SV.cct.offsetY)
end

function CrowdControlTracker.ResetPosition()
    CombatInfo.SV.cct.offsetX = 0
    CombatInfo.SV.cct.offsetY = 0
    LUIE_CCTracker:ClearAnchors()
    LUIE_CCTracker:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
end

function CrowdControlTracker:OnUpdate(control)
    if CrowdControlTracker.Timer == 0 or not CrowdControlTracker.Timer then
        return
    end

    local timeLeft = math.ceil(CrowdControlTracker.Timer - GetFrameTimeSeconds())
    if timeLeft > 0 then
        LUIE_CCTracker_Timer_Label:SetText(timeLeft)
    end
end

function CrowdControlTracker:OnProc(ccDuration, interval)
    self:OnAnimation(LUIE_CCTracker, "proc")
    if CombatInfo.SV.cct.playSound then
        local playSound = CombatInfo.SV.cct.playSoundOption
        if playSound then
            PlaySound(LUIE.Sounds[playSound])
            PlaySound(LUIE.Sounds[playSound])
        end
    end
    self.Timer = GetFrameTimeSeconds() + (interval / 1000)

    local remaining, duration, global = GetSlotCooldownInfo(1)
    if remaining > 0 then
        LUIE_CCTracker_IconFrame_GlobalCooldown:ResetCooldown()
        if CombatInfo.SV.cct.showGCD and LUIE.ResolvePVPZone() then
            LUIE_CCTracker_IconFrame_GlobalCooldown:SetHidden(false)
            LUIE_CCTracker_IconFrame_GlobalCooldown:StartCooldown(remaining, remaining, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_UNTIL, false)
            zo_callLater(function() LUIE_CCTracker_IconFrame_GlobalCooldown:SetHidden(true) end, remaining)
        end
    end
    LUIE_CCTracker_IconFrame_Cooldown:ResetCooldown()
    LUIE_CCTracker_IconFrame_Cooldown:StartCooldown(interval, ccDuration, CD_TYPE_RADIAL, CD_TIME_TYPE_TIME_REMAINING, false)

    self:SetupDisplay("timer")
end

function CrowdControlTracker:OnAnimation(control, animationType, param)
    self:SetupDisplay(animationType)
    if CombatInfo.SV.cct.playAnimation then
        if animationType == "immune" then
            self.immunePlaying = self:StartAnimation(control, animationType)
        elseif animationType == "breakfree" then
            self.breakFreePlaying = self:BreakFreeAnimation()
        else
            self.currentlyPlaying = self:StartAnimation(control, animationType)
        end
    elseif param then
        LUIE_CCTracker:SetHidden(not CombatInfo.SV.cct.unlock)
    end
end

function CrowdControlTracker:AoePriority(abilityId, result)
    if self.aoeTypesId[abilityId] and self.aoeHitTypes[result] and ((not self.aoeTypesId[PrioritySix.abilityId]) or (self.aoeTypesId[abilityId]<=self.aoeTypesId[PrioritySix.abilityId])) then
        return true
    else
        return false
    end
end

local function ResolveAbilityName(abilityId, sourceName)

    local abilityName = GetAbilityName(abilityId)


    if Effects.EffectOverrideByName[abilityId] then
        sourceName = zo_strformat("<<C:1>>", sourceName)
        if Effects.EffectOverrideByName[abilityId][sourceName] then
            abilityName = Effects.EffectOverrideByName[abilityId][sourceName].name or abilityName
        end
    end

    if Effects.ZoneDataOverride[abilityId] then
        local index = GetZoneId(GetCurrentMapZoneIndex())
        local zoneName = GetPlayerLocationName()
        if Effects.ZoneDataOverride[abilityId][index] then
            abilityName = Effects.ZoneDataOverride[abilityId][index].name
        end
        if Effects.ZoneDataOverride[abilityId][zoneName] then
            abilityName = Effects.ZoneDataOverride[abilityId][zoneName].name
        end
    end

    -- Override name, icon, or hide based on Map Name
    if Effects.MapDataOverride[abilityId] then
        local mapName = GetMapName()
        if Effects.MapDataOverride[abilityId][mapName] then
            if Effects.MapDataOverride[abilityId][mapName].name then
                abilityName = Effects.MapDataOverride[abilityId][mapName].name
            end
        end
    end

    return abilityName

end

local function ResolveAbilityIcon(abilityId, sourceName)

    local abilityIcon = GetAbilityIcon(abilityId)

    if Effects.EffectOverrideByName[abilityId] then
        sourceName = zo_strformat("<<C:1>>", sourceName)
        if Effects.EffectOverrideByName[abilityId][sourceName] then
            abilityIcon = Effects.EffectOverrideByName[abilityId][sourceName].icon or abilityIcon
        end
    end

    if Effects.ZoneDataOverride[abilityId] then
        local index = GetZoneId(GetCurrentMapZoneIndex())
        local zoneName = GetPlayerLocationName()
        if Effects.ZoneDataOverride[abilityId][index] then
            abilityIcon = Effects.ZoneDataOverride[abilityId][index].icon
        end
        if Effects.ZoneDataOverride[abilityId][zoneName] then
            abilityIcon = Effects.ZoneDataOverride[abilityId][zoneName].icon
        end
    end

    -- Override name, icon, or hide based on Map Name
    if Effects.MapDataOverride[abilityId] then
        local mapName = GetMapName()
        if Effects.MapDataOverride[abilityId][mapName] then
            if Effects.MapDataOverride[abilityId][mapName].icon then
                abilityIcon = Effects.MapDataOverride[abilityId][mapName].icon
            end
        end
    end

    return abilityIcon

end

function CrowdControlTracker:OnCombat(eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, combat_log, sourceUnitId, targetUnitId, abilityId)
    -- LuiExtended Addition
    abilityName = ResolveAbilityName(abilityId, sourceName)
    local abilityIcon = ResolveAbilityIcon(abilityId, sourceName)

    if CrowdControl.IgnoreList[abilityId] then return end
    local function StringEnd(String,End)
        return End == '' or string.sub(String,-string.len(End)) == End
    end

    -- Adjust duration of Player Vampire bite stun
    if abilityId == 40349 then hitValue = hitValue - 950 end

    local malformedName

    if not StringEnd(LUIE.PlayerNameRaw,'^Mx') and not StringEnd(LUIE.PlayerNameRaw,'^Fx') then
        malformedName = true
    end

    if result == ACTION_RESULT_EFFECT_GAINED_DURATION and ((not malformedName and sourceName == LUIE.PlayerNameRaw) or (malformedName and (sourceName == LUIE.PlayerNameRaw..'^Mx' or sourceName == LUIE.PlayerNameRaw..'^Fx'))) and (abilityName == "Break Free" or abilityName == GetAbilityName(BREAK_FREE_ID) or abilityId == BREAK_FREE_ID) then
        if CombatInfo.SV.cct.showOptions == "text" then
            self:StopDraw(true)
        else
            self:StopDrawBreakFree()
        end
        return
    end

    --51894
    -----------------DISORIENT PROCESSING-------------------------------

    if result == ACTION_RESULT_EFFECT_FADED and ((not malformedName and targetName == LUIE.PlayerNameRaw) or (malformedName and (targetName == LUIE.PlayerNameRaw..'^Mx' or targetName == LUIE.PlayerNameRaw..'^Fx'))) then
        if GetFrameTimeMilliseconds() <= (PriorityTwo.endTime + graceTime) and #self.fearsQueue ~= 0 then
            local found_k
            for k, v in pairs (self.fearsQueue) do
                if v == abilityId then
                    found_k = k
                    break
                end
            end
            if found_k then
                table.remove(self.fearsQueue, found_k)
                if #self.fearsQueue == 0 then
                    self:RemoveCC(2, PriorityTwo.endTime)
                end
            end
        elseif GetFrameTimeMilliseconds() <= (PriorityThree.endTime + graceTime) and #self.disorientsQueue ~= 0 then
            local found_k
            for k, v in pairs (self.disorientsQueue) do
                if v == abilityId then
                    found_k = k
                    break
                end
            end
            if found_k then
                table.remove(self.disorientsQueue, found_k)
                if #self.disorientsQueue == 0 then self:RemoveCC(3, PriorityThree.endTime) end
            end
        end
    end

    ------------------------------------------------

    -- If AoE effect is flagged as self damage (mostly from lava) id then don't use the normal return statement, otherwise return based off primary conditions.
    if ((not malformedName and sourceName == LUIE.PlayerNameRaw) or (malformedName and (sourceName == LUIE.PlayerNameRaw..'^Mx' or sourceName == LUIE.PlayerNameRaw..'^Fx'))) and CrowdControl.LavaAlerts[abilityId] then
        --
    else
        if ((not malformedName and targetName ~= LUIE.PlayerNameRaw) or (malformedName and (targetName ~= LUIE.PlayerNameRaw..'^Mx' and targetName ~= LUIE.PlayerNameRaw..'^Fx'))) or targetName == "" or targetType ~= 1 or ((not malformedName and sourceName == LUIE.PlayerNameRaw) or (malformedName and (sourceName == LUIE.PlayerNameRaw..'^Mx' or sourceName == LUIE.PlayerNameRaw..'^Fx'))) or sourceName == "" or sourceUnitId == 0 or self.breakFreePlaying then
            return
        end
    end

    if CombatInfo.SV.cct.showAoe and (self:AoePriority(abilityId, result) or (CrowdControl.SpecialCC[abilityId] and result == ACTION_RESULT_EFFECT_GAINED)) then
        if not CrowdControlTracker.aoeTypesId[abilityId] then
            return
        end
        if CrowdControl.SpecialCC[abilityId] and result ~= ACTION_RESULT_EFFECT_GAINED then
            return
        end

        -- PlaySoundAoe
        CrowdControlTracker.PlaySoundAoe(abilityId)

        local currentEndTimeArea = GetFrameTimeMilliseconds() + areaDuration
        PrioritySix = {endTime = currentEndTimeArea, abilityId = abilityId, abilityIcon = abilityIcon, hitValue = hitValue, result = ACTION_RESULT_AREA_EFFECT, abilityName = abilityName}
        if PriorityOne.endTime == 0 and PriorityTwo.endTime == 0 and PriorityThree.endTime == 0 and PriorityFour.endTime == 0 then
            self.currentCC = 6
            zo_callLater(function() self:RemoveCC(6, currentEndTimeArea) end, areaDuration + graceTime)
            self:OnDraw(abilityId, abilityIcon, areaDuration, ACTION_RESULT_AREA_EFFECT, abilityName, areaDuration)
        end
    end

    local validResults = {
        [ACTION_RESULT_EFFECT_GAINED_DURATION] = true,
        [ACTION_RESULT_STUNNED] = true,
        [ACTION_RESULT_FEARED] = true,
        [ACTION_RESULT_STAGGERED] = true,
        [ACTION_RESULT_IMMUNE] = true,
        [ACTION_RESULT_DODGED] = true,
        [ACTION_RESULT_BLOCKED] = true,
        [ACTION_RESULT_BLOCKED_DAMAGE] = true,
        [ACTION_RESULT_DISORIENTED] = true,
    }

    if not validResults[result] then
        return
    end

    -- if result == ACTION_RESULT_STUNNED then
        -- d('STUNNED after')
    -- end

    -- if result~=ACTION_RESULT_EFFECT_GAINED_DURATION and result~=ACTION_RESULT_STUNNED and result~=ACTION_RESULT_FEARED and result~=ACTION_RESULT_STAGGERED and result~=ACTION_RESULT_IMMUNE and result~=ACTION_RESULT_DISORIENTED then return end

    if abilityName == LUIE.Data.Abilities.Trap_Hiding_Spot then -- TODO: Put IDs here instead or add to blacklist instead
        return
    end

    -------------STAGGERED EVENT TRIGGER--------------------
    if CombatInfo.SV.cct.showStaggered and result == ACTION_RESULT_STAGGERED and self.currentCC == 0 then
        zo_callLater(function() self:RemoveCC(5, GetFrameTimeMilliseconds()) end, staggerDuration)
        self:OnDraw(abilityId, abilityIcon, staggerDuration, result, abilityName, staggerDuration)
    end
    --------------------------------------------------------

    -------------IMMUNE EVENT TRIGGER-----------------------
    if CombatInfo.SV.cct.showImmune and (result == ACTION_RESULT_IMMUNE or (PVP_Alerts_Main_Table and (result == ACTION_RESULT_DODGED or result == ACTION_RESULT_BLOCKED or result == ACTION_RESULT_BLOCKED_DAMAGE) and PVP_Alerts_Main_Table.snipeId[abilityId])) and not (CombatInfo.SV.cct.showImmuneOnlyInCyro and not LUIE.ResolvePVPZone()) and (not self.currentlyPlaying) and self.currentCC == 0 and GetAbilityIcon(abilityId) ~= nil then
        self:OnDraw(abilityId, abilityIcon, CombatInfo.SV.cct.immuneDisplayTime, result, abilityName, CombatInfo.SV.cct.immuneDisplayTime)
    end
    -------------------------------------------------------

    if not self.incomingCC then
        self.incomingCC = {}
    end

    if result == ACTION_RESULT_EFFECT_GAINED_DURATION then
        if (abilityName == GetAbilityName(NEGATE_MAGIC_ID) or abilityId == NEGATE_MAGIC_ID or abilityId == NEGATE_MAGIC_1_ID) then
            local currentEndTimeSilence = GetFrameTimeMilliseconds() + hitValue
            PriorityFour = {endTime = currentEndTimeSilence, abilityId = abilityId, abilityIcon = abilityIcon, hitValue = hitValue, result = ACTION_RESULT_SILENCED, abilityName = abilityName}
            if PriorityOne.endTime == 0 and PriorityTwo.endTime == 0 and PriorityThree.endTime == 0 then
                self.currentCC = 4
                zo_callLater(function() self:RemoveCC(4, currentEndTimeSilence) end, hitValue + graceTime)
                self:OnDraw(abilityId, abilityIcon, hitValue, ACTION_RESULT_SILENCED, abilityName, hitValue)
            end
        else
            -- d("EVENT " .. " DURATION " .. tostring(GetFrameTimeMilliseconds()))
            -- if self.incomingCC[ACTION_RESULT_FEARED] then
                -- d("FEAR DURATION " .. tostring(GetFrameTimeMilliseconds()))
            -- end
            local currentTime = GetFrameTimeMilliseconds()
            local currentEndTime = currentTime + hitValue
            if abilityId == self.incomingCC[ACTION_RESULT_STUNNED] and (currentEndTime + 200) > PriorityOne.endTime then
                -- self.incomingCC[ACTION_RESULT_STUNNED] = nil
                -- callbackManager:RegisterCallback("OnIncomingStun", function()
                    if self.breakFreePlaying then
                        return
                    end
                    PriorityOne = {endTime = (GetFrameTimeMilliseconds() + hitValue), abilityId = abilityId, abilityIcon = abilityIcon, hitValue = hitValue, result = ACTION_RESULT_STUNNED, abilityName = abilityName}
                    self.currentCC = 1
                    zo_callLater(function() self:RemoveCC(1, currentEndTime) end, hitValue + graceTime+1000)
                    self:OnDraw(abilityId, abilityIcon, hitValue, ACTION_RESULT_STUNNED, abilityName, hitValue)
                -- end)
                -- zo_callLater(function() callbackManager:UnregisterAllCallbacks("OnIncomingStun") end, 1)
                self.incomingCC = {}
            elseif abilityId == self.incomingCC[ACTION_RESULT_FEARED] and (currentEndTime + 200) > PriorityOne.endTime and (currentEndTime + 200) > PriorityTwo.endTime then
                table.insert(self.fearsQueue, abilityId)
                PriorityTwo = {endTime = currentEndTime, abilityId = abilityId, abilityIcon = abilityIcon, hitValue = hitValue, result = ACTION_RESULT_FEARED, abilityName = abilityName}
                if PriorityOne.endTime == 0 then
                    self.currentCC = 2
                    zo_callLater(function() self:RemoveCC(2, currentEndTime) end, hitValue + graceTime)
                    self:OnDraw(abilityId, abilityIcon, hitValue, ACTION_RESULT_FEARED, abilityName, hitValue)
                end
                self.incomingCC = {}
            elseif abilityId == self.incomingCC[ACTION_RESULT_DISORIENTED] and (currentEndTime + 200) > PriorityOne.endTime and (currentEndTime + 200) > PriorityTwo.endTime and currentEndTime > PriorityThree.endTime then
                -- self.incomingCC[ACTION_RESULT_DISORIENTED] == nil
                table.insert(self.disorientsQueue, abilityId)
                PriorityThree = {endTime = currentEndTime, abilityId = abilityId, abilityIcon = abilityIcon, hitValue = hitValue, result = ACTION_RESULT_DISORIENTED, abilityName = abilityName}
                if PriorityOne.endTime == 0 and PriorityTwo.endTime == 0 then
                    self.currentCC = 3
                    zo_callLater(function() self:RemoveCC(3, currentEndTime) end, hitValue + graceTime)
                    self:OnDraw(abilityId, abilityIcon, hitValue, ACTION_RESULT_DISORIENTED, abilityName, hitValue)
                end
                self.incomingCC = {}
            else
                table.insert(self.effectsGained, {abilityId = abilityId, hitValue = hitValue, sourceUnitId = sourceUnitId, abilityGraphic = abilityGraphic})
            end
        end
    elseif #self.effectsGained > 0 then
        local foundValue = self:FindEffectGained(abilityId, sourceUnitId, abilityGraphic)
        -- if not foundValue then return end

        if foundValue then
            local currentTime = GetFrameTimeMilliseconds()
            local currentEndTime = currentTime + foundValue.hitValue

            if result == ACTION_RESULT_FEARED and (currentEndTime + 200) > PriorityOne.endTime and (currentEndTime + 200) > PriorityTwo.endTime then
                table.insert(self.fearsQueue, abilityId)
                PriorityTwo = {endTime = currentEndTime, abilityId = abilityId, abilityIcon = abilityIcon, hitValue = foundValue.hitValue, result = result, abilityName = abilityName}
                if PriorityOne.endTime == 0 then
                    self.currentCC = 2
                    zo_callLater(function() self:RemoveCC(2, currentEndTime) end, foundValue.hitValue + graceTime)
                    self:OnDraw(abilityId, abilityIcon, foundValue.hitValue, result, abilityName, foundValue.hitValue)
                end
            end
            self.effectsGained = {}
        end
    end

    if self.actionResults[result] then
        self.incomingCC[result] = abilityId
        -- if result == ACTION_RESULT_FEARED then
            -- d("FEAR EVENT " .. tostring(GetFrameTimeMilliseconds()))
        -- end

        -- d("EVENT " .. tostring(result) .. " " .. tostring(GetFrameTimeMilliseconds()))
        -- return
    end


    -- else
        -- if #self.effectsGained>0 then
            -- local foundValue=self:FindEffectGained(abilityId, sourceUnitId, abilityGraphic)
            -- if not foundValue then return end

            -- local currentTime=GetFrameTimeMilliseconds()
            -- local currentEndTime=currentTime+foundValue.hitValue
            -- if result==ACTION_RESULT_STUNNED and (currentEndTime+200)>PriorityOne.endTime then
                -- callbackManager:RegisterCallback("OnIncomingStun", function()
                    -- if self.breakFreePlaying then return end
                    -- PriorityOne = {endTime=(GetFrameTimeMilliseconds()+foundValue.hitValue), abilityId=abilityId, hitValue=foundValue.hitValue, result=result, abilityName=abilityName}
                    -- self.currentCC = 1
                    -- zo_callLater(function() self:RemoveCC(1, currentEndTime) end, foundValue.hitValue+graceTime+1000)
                    -- d('draw stun')
                    -- self:OnDraw(abilityId, abilityIcon, foundValue.hitValue, result, abilityName, foundValue.hitValue)
                -- end)
                -- zo_callLater(function() callbackManager:UnregisterAllCallbacks("OnIncomingStun") end, 1)

            -- elseif result==ACTION_RESULT_FEARED and (currentEndTime+200)>PriorityOne.endTime and (currentEndTime+200)>PriorityTwo.endTime then
                -- table.insert(self.fearsQueue, abilityId)
                -- PriorityTwo = {endTime=currentEndTime, abilityId=abilityId, hitValue=foundValue.hitValue, result=result, abilityName=abilityName}
                -- if PriorityOne.endTime==0 then
                    -- self.currentCC=2
                    -- zo_callLater(function() self:RemoveCC(2, currentEndTime) end, foundValue.hitValue+graceTime)
                    -- self:OnDraw(abilityId, abilityIcon, foundValue.hitValue, result, abilityName, foundValue.hitValue)
                -- end

            -- elseif result==ACTION_RESULT_DISORIENTED and (currentEndTime+200)>PriorityOne.endTime and (currentEndTime+200)>PriorityTwo.endTime and currentEndTime>PriorityThree.endTime then
                -- table.insert(self.disorientsQueue, abilityId)
                -- PriorityThree = {endTime=currentEndTime, abilityId=abilityId, hitValue=foundValue.hitValue, result=result, abilityName=abilityName}
                -- if PriorityOne.endTime==0 and PriorityTwo.endTime==0 then
                    -- self.currentCC=3
                    -- zo_callLater(function() self:RemoveCC(3, currentEndTime) end, foundValue.hitValue+graceTime)
                    -- self:OnDraw(abilityId, abilityIcon, foundValue.hitValue, result, abilityName, foundValue.hitValue)
                -- end
            -- end
            -- self.effectsGained={}
        -- end
    -- end
end


function CrowdControlTracker:RemoveCC(ccType, currentEndTime)
    local stagger
    if (self.currentCC == 0 and (ccType ~= 5)) or self.breakFreePlaying then
        return
    end
    local currentTime = GetFrameTimeMilliseconds()
    local secondInterval, thirdInterval, fourthInterval, sixthInterval = PriorityTwo.endTime - currentTime, PriorityThree.endTime - currentTime, PriorityFour.endTime - currentTime, PrioritySix.endTime - currentTime
----STUN-----
    if ccType == 1 then
        if self.currentCC == 1 and PriorityOne.endTime ~= currentEndTime then
            return
        end
        PriorityOne = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
        if secondInterval > 0 then
            self.currentCC = 2
            zo_callLater(function() self:RemoveCC(2, PriorityTwo.endTime) end, secondInterval)
            self:OnDraw(PriorityTwo.abilityId, PriorityTwo.abilityIcon, PriorityTwo.hitValue, PriorityTwo.result, PriorityTwo.abilityName, secondInterval)
            return
        elseif thirdInterval > 0 then
            self.currentCC = 3
            zo_callLater(function() self:RemoveCC(3, PriorityThree.endTime) end, thirdInterval)
            self:OnDraw(PriorityThree.abilityId, PriorityThree.abilityIcon, PriorityThree.hitValue, PriorityThree.result, PriorityThree.abilityName, thirdInterval)
            return
        elseif fourthInterval > 0 then
            self.currentCC = 4
            zo_callLater(function() self:RemoveCC(4, PriorityFour.endTime) end, fourthInterval)
            self:OnDraw(PriorityFour.abilityId, PriorityFour.abilityIcon, PriorityFour.hitValue, PriorityFour.result, PriorityFour.abilityName, fourthInterval)
            return
        elseif sixthInterval > 0 then
            self.currentCC = 6
            zo_callLater(function() self:RemoveCC(6, PriorityFour.endTime) end, sixthInterval)
            self:OnDraw(PrioritySix.abilityId, PrioritySix.abilityIcon, PrioritySix.hitValue, PrioritySix.result, PrioritySix.abilityName, sixthInterval)
            return
        end
----FEAR----
    elseif ccType == 2 then
        if (self.currentCC == 1 or self.currentCC == 2) and PriorityTwo.endTime ~= currentEndTime then
            return
        end
        PriorityTwo = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
        if PriorityOne.endTime > 0 and self.currentCC == 1 then
            return
        end
        if thirdInterval > 0 then
            self.currentCC = 3
            zo_callLater(function() self:RemoveCC(3, PriorityThree.endTime) end, thirdInterval)
            self:OnDraw(PriorityThree.abilityId, PriorityThree.abilityIcon, PriorityThree.hitValue, PriorityThree.result, PriorityThree.abilityName, thirdInterval)
            return
        elseif fourthInterval > 0 then
            self.currentCC = 4
            zo_callLater(function() self:RemoveCC(4, PriorityFour.endTime) end, fourthInterval)
            self:OnDraw(PriorityFour.abilityId, PriorityFour.abilityIcon, PriorityFour.hitValue, PriorityFour.result, PriorityFour.abilityName, fourthInterval)
            return
        elseif sixthInterval > 0 then
            self.currentCC = 6
            zo_callLater(function() self:RemoveCC(6, PriorityFour.endTime) end, sixthInterval)
            self:OnDraw(PrioritySix.abilityId, PrioritySix.abilityIcon, PrioritySix.hitValue, PrioritySix.result, PrioritySix.abilityName, sixthInterval)
            return
        end
----DISORIENT----
    elseif ccType == 3 then
        if (self.currentCC > 0 and self.currentCC < 4) and PriorityThree.endTime ~= currentEndTime then --d("DISORIENT discarded")
            return
        end
        PriorityThree = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
        if (PriorityOne.endTime > 0 and self.currentCC == 1) or (PriorityTwo.endTime > 0 and self.currentCC == 2) then
            return
        end
        if fourthInterval > 0 then
            self.currentCC = 4
            zo_callLater(function() self:RemoveCC(4, PriorityFour.endTime) end, fourthInterval)
            self:OnDraw(PriorityFour.abilityId, PriorityFour.abilityIcon, PriorityFour.hitValue, PriorityFour.result, PriorityFour.abilityName, thirdInterval)
            return
        elseif sixthInterval > 0 then
            self.currentCC = 6
            zo_callLater(function() self:RemoveCC(6, PriorityFour.endTime) end, sixthInterval)
            self:OnDraw(PrioritySix.abilityId, PrioritySix.abilityIcon, PrioritySix.hitValue, PrioritySix.result, PrioritySix.abilityName, sixthInterval)
            return
        end
----SILENCE----
    elseif ccType == 4 then
        if self.currentCC ~= 0 and PriorityFour.endTime ~= currentEndTime then
            return
        end
        PriorityFour = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
        if (PriorityOne.endTime > 0 and self.currentCC == 1) or (PriorityTwo.endTime > 0 and self.currentCC == 2) or (PriorityThree.endTime > 0 and self.currentCC == 3) then
            return
        end
        elseif sixthInterval > 0 then
            self.currentCC = 6
            zo_callLater(function() self:RemoveCC(6, PriorityFour.endTime) end, sixthInterval)
            self:OnDraw(PrioritySix.abilityId, PrioritySix.abilityIcon, PrioritySix.hitValue, PrioritySix.result, PrioritySix.abilityName, sixthInterval)
        return
----STAGGER----
    elseif ccType == 5 then
        if self.currentCC ~= 0 then
            return
        else
            stagger = true
        end
----AOE----
    elseif ccType == 6 then
        if self.currentCC ~= 0 and PrioritySix.endTime ~= currentEndTime then
            return
        end
        PrioritySix = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
        if (PriorityOne.endTime > 0 and self.currentCC == 1) or (PriorityTwo.endTime > 0 and self.currentCC == 2) or (PriorityThree.endTime > 0 and self.currentCC == 3) or (PriorityFour.endTime > 0 and self.currentCC == 4) then
            return
        end
    end

    if CombatInfo.SV.cct.showOptions == "text" then
        stagger=true
    end
    self:StopDraw(stagger)
end

function CrowdControlTracker:OnStunnedState(eventCode, playerStunned)
    -- d('playerStunned: '..tostring(playerStunned))
    if not playerStunned then
        -- d("PriorityOne.endTime", PriorityOne.endTime)
        if PriorityOne.endTime ~= 0 then
            self:RemoveCC(1, PriorityOne.endTime)
        end
    else
        -- callbackManager:FireCallbacks("OnIncomingStun")
    end
end

function CrowdControlTracker:GetDefaultIcon(ccType)
    if ccType == ACTION_RESULT_STUNNED then return LUIE_CC_ICON_STUN
    elseif ccType == ACTION_RESULT_KNOCKBACK then return LUIE_CC_ICON_KNOCKBACK
    elseif ccType == ACTION_RESULT_LEVITATED then return LUIE_CC_ICON_PULL
    elseif ccType == ACTION_RESULT_FEARED then return LUIE_CC_ICON_FEAR
    elseif ccType == ACTION_RESULT_DISORIENTED then return LUIE_CC_ICON_DISORIENT
    elseif ccType == ACTION_RESULT_SILENCED then return LUIE_CC_ICON_SILENCE
    elseif ccType == ACTION_RESULT_IMMUNE then return LUIE_CC_ICON_IMMUNE
    elseif ccType == ACTION_RESULT_DODGED then return LUIE_CC_ICON_IMMUNE
    elseif ccType == ACTION_RESULT_BLOCKED then return LUIE_CC_ICON_IMMUNE
    elseif ccType == ACTION_RESULT_BLOCKED_DAMAGE then return LUIE_CC_ICON_IMMUNE
    end
end

function CrowdControlTracker:ShouldUseDefaultIcon(abilityId)
    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].cc then
        if CombatInfo.SV.cct.defaultIconOptions == 1 then
            return true
        elseif CombatInfo.SV.cct.defaultIconOptions == 2 then
            return Effects.EffectOverride[abilityId].isPlayerAbility and false or true
        elseif CombatInfo.SV.cct.defaultIconOptions == 3 then
            return Effects.EffectOverride[abilityId].isPlayerAbility and true or false
        end
    end
end

function CrowdControlTracker:SetupDefaultIcon(abilityId, ccType)
    if ccType == ACTION_RESULT_STUNNED and Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].cc then
        if Effects.EffectOverride[abilityId].cc == LUIE_CC_TYPE_KNOCKBACK then
            ccType = ACTION_RESULT_KNOCKBACK
        elseif Effects.EffectOverride[abilityId].cc == LUIE_CC_TYPE_PULL then
            ccType = ACTION_RESULT_LEVITATED
        end
    end
    return self:GetDefaultIcon(ccType)
end

function CrowdControlTracker:OnDraw(abilityId, abilityIcon, ccDuration, result, abilityName, interval)
    if result == ACTION_RESULT_STAGGERED then
        self:OnAnimation(LUIE_CCTracker, "stagger")
        return
    end

    --Override icon with default if enabled
    if CombatInfo.SV.cct.useDefaultIcon and result ~= ACTION_RESULT_AREA_EFFECT and self:ShouldUseDefaultIcon(abilityId) == true then
        abilityIcon = self:SetupDefaultIcon(abilityId, result)
    end

    local ccText
    if CombatInfo.SV.cct.useAbilityName then
        ccText = zo_strformat(SI_ABILITY_NAME, abilityName)
    else
        ccText = self.controlText[result]
    end

    -- If the effect is flagged as unbreakable in the Effect Override table then switch the effect to color as unbreakable (unless its an AOE).
    if Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].unbreakable and not CrowdControlTracker.aoeTypesId[abilityId] then
        self:SetupInfo(ccText, CombatInfo.SV.cct.colors.unbreakable, abilityIcon)
    -- If the effect is labeled as a Knockback or Pull then change the color setting.
    elseif result == ACTION_RESULT_STUNNED and Effects.EffectOverride[abilityId] and Effects.EffectOverride[abilityId].cc then
        if Effects.EffectOverride[abilityId].cc == LUIE_CC_TYPE_KNOCKBACK then
            self:SetupInfo(ccText, CombatInfo.SV.cct.colors[ACTION_RESULT_KNOCKBACK], abilityIcon)
        elseif Effects.EffectOverride[abilityId].cc == LUIE_CC_TYPE_PULL then
            self:SetupInfo(ccText, CombatInfo.SV.cct.colors[ACTION_RESULT_LEVITATED], abilityIcon)
        else
            self:SetupInfo(ccText, CombatInfo.SV.cct.colors[result], abilityIcon)
        end
    else
        self:SetupInfo(ccText, CombatInfo.SV.cct.colors[result], abilityIcon)
    end

    if result == ACTION_RESULT_SILENCED or result == ACTION_RESULT_AREA_EFFECT then
        if CombatInfo.SV.cct.showOptions == "text" then
            self:OnAnimation(LUIE_CCTracker_TextFrame, "silence")
        else
            self:OnAnimation(LUIE_CCTracker_IconFrame, "silence")
        end
    elseif result == ACTION_RESULT_IMMUNE or result == ACTION_RESULT_DODGED or result == ACTION_RESULT_BLOCKED or result == ACTION_RESULT_BLOCKED_DAMAGE then
        self:OnAnimation(LUIE_CCTracker, "immune")
    else
        self:OnProc(ccDuration, interval)
    end
end

function CrowdControlTracker:IconHidden(hidden)
    if CombatInfo.SV.cct.showOptions == "text" then
        LUIE_CCTracker_IconFrame:SetHidden(true)
    else
        LUIE_CCTracker_IconFrame:SetHidden(hidden)
    end
end

function CrowdControlTracker:TimerHidden(hidden)
    if CombatInfo.SV.cct.showOptions == "text" then
        LUIE_CCTracker_Timer:SetHidden(true)
    else
        LUIE_CCTracker_Timer:SetHidden(hidden)
    end
end

function CrowdControlTracker:TextHidden(hidden)
    if CombatInfo.SV.cct.showOptions == "icon" then
        LUIE_CCTracker_TextFrame:SetHidden(true)
    else
        LUIE_CCTracker_TextFrame:SetHidden(hidden)
    end
end

function CrowdControlTracker:BreakFreeHidden(hidden)
    if CombatInfo.SV.cct.showOptions == "text" then
        LUIE_CCTracker_BreakFreeFrame:SetHidden(true)
    else
        LUIE_CCTracker_BreakFreeFrame:SetHidden(hidden)
    end
end

function CrowdControlTracker:SetupInfo(ccText, ccColor, abilityIcon)
    LUIE_CCTracker_TextFrame_Label:SetFont(iconFont)
    LUIE_CCTracker_TextFrame_Label:SetText(ccText)
    LUIE_CCTracker_TextFrame_Label:SetColor(unpack(ccColor))
    LUIE_CCTracker_IconFrame_Icon:SetTexture(abilityIcon)
    LUIE_CCTracker_IconFrame_Icon:SetColor(1,1,1,1)
    LUIE_CCTracker_IconFrame_IconBG:SetColor(unpack(ccColor))
    LUIE_CCTracker_IconFrame_IconBorder:SetColor(unpack(ccColor))
    LUIE_CCTracker_IconFrame_IconBorderHighlight:SetColor(unpack(ccColor))
    LUIE_CCTracker_Timer_Label:SetColor(unpack(ccColor))
end

function CrowdControlTracker:SetupDisplay(displayType)
    if displayType == "silence" then
        LUIE_CCTracker_IconFrame_Cooldown:SetHidden(true)
        LUIE_CCTracker_IconFrame_GlobalCooldown:SetHidden(true)
        LUIE_CCTracker_IconFrame_IconBorderHighlight:SetHidden(false)
        LUIE_CCTracker_IconFrame_Icon:SetTextureCoords(0,1,0,1)
        self:IconHidden(false)
        self:TextHidden(false)
        self:TimerHidden(true)
        self:BreakFreeHidden(true)
        LUIE_CCTracker:SetHidden(false)

    elseif displayType == "immune" then
        LUIE_CCTracker_IconFrame_Cooldown:SetHidden(true)
        LUIE_CCTracker_IconFrame_GlobalCooldown:SetHidden(true)
        LUIE_CCTracker_IconFrame_IconBorderHighlight:SetHidden(true)
        LUIE_CCTracker_IconFrame_Icon:SetTextureCoords(0,1,0,1)
        LUIE_CCTracker_IconFrame_IconBG:SetColor(0,0,0)
        self:IconHidden(false)
        self:TextHidden(false)
        self:TimerHidden(true)
        self:BreakFreeHidden(true)
        LUIE_CCTracker:SetHidden(false)

    elseif displayType == "stagger" then
        LUIE_CCTracker_TextFrame_Label:SetText(CrowdControlTracker.controlText[ACTION_RESULT_STAGGERED])
        LUIE_CCTracker_TextFrame_Label:SetColor(unpack(CombatInfo.SV.cct.colors[ACTION_RESULT_STAGGERED]))
        LUIE_CCTracker_TextFrame_Label:SetFont(staggerFont)
        self:TextHidden(false)
        self:IconHidden(true)
        self:TimerHidden(true)
        self:BreakFreeHidden(true)
        LUIE_CCTracker:SetHidden(false)

    elseif displayType == "breakfree" then
        self:IconHidden(true)
        self:TextHidden(true)
        self:TimerHidden(true)
        self:BreakFreeHidden(false)
        LUIE_CCTracker:SetHidden(false)

    elseif displayType == "timer" then
        LUIE_CCTracker_IconFrame_Cooldown:SetHidden(false)
    elseif displayType == "end" then
        LUIE_CCTracker_IconFrame_IconBorderHighlight:SetHidden(false)
        LUIE_CCTracker_IconFrame_Icon:SetTextureCoords(0,1,0,1)
        LUIE_CCTracker_IconFrame_Cooldown:SetHidden(false)
        LUIE_CCTracker_IconFrame_GlobalCooldown:SetHidden(true)
        self:IconHidden(false)
        self:TextHidden(false)
        self:TimerHidden(true)
        self:BreakFreeHidden(true)
        LUIE_CCTracker:SetHidden(false)
    elseif displayType == "endstagger" then
        self:SetupDisplay("end")
        self:IconHidden(true)
    elseif displayType == "proc" then
        LUIE_CCTracker_IconFrame_Icon:SetTextureCoords(0,1,0,1)
        LUIE_CCTracker_IconFrame_IconBorderHighlight:SetHidden(false)
        self:IconHidden(false)
        self:TextHidden(false)
        self:TimerHidden(false)
        self:BreakFreeHidden(true)
        LUIE_CCTracker:SetHidden(false)
    end
end

function CrowdControlTracker:StopDraw(isTextOnly)
    if self.breakFreePlaying and not self.breakFreePlayingDraw then
        -- d("Stop Draw breakfree returned")
        return
    end
    self:VarReset()
    if isTextOnly then self:OnAnimation(LUIE_CCTracker, "endstagger", true)
    else
        self:OnAnimation(LUIE_CCTracker, "end", true)
    end
end

function CrowdControlTracker:StopDrawBreakFree()
    local breakFreeIcon
    local currentCCIcon = ICON_MISSING
    local currentCC = self.currentCC

    if currentCC ~= 0 and currentCC ~= 4 and currentCC ~= 6 then
        local currentResult = self:CCPriority(currentCC).result
        local currentAbilityId = self:CCPriority(currentCC).abilityId
        local currentColor
        if Effects.EffectOverride[currentAbilityId] and Effects.EffectOverride[currentAbilityId].unbreakable then
            currentColor = CombatInfo.SV.cct.colors.unbreakable
        elseif currentResult == ACTION_RESULT_STUNNED and Effects.EffectOverride[currentAbilityId] and Effects.EffectOverride[currentAbilityId].cc then
            if Effects.EffectOverride[currentAbilityId].cc == LUIE_CC_TYPE_KNOCKBACK then
                currentColor = CombatInfo.SV.cct.colors[ACTION_RESULT_KNOCKBACK]
            elseif Effects.EffectOverride[currentAbilityId].cc == LUIE_CC_TYPE_PULL then
                currentColor = CombatInfo.SV.cct.colors[ACTION_RESULT_LEVITATED]
            else
                currentColor = CombatInfo.SV.cct.colors[currentResult]
            end
        else
            currentColor = CombatInfo.SV.cct.colors[currentResult]
        end

        if CombatInfo.SV.cct.useDefaultIcon and currentResult ~= ACTION_RESULT_AREA_EFFECT and self:ShouldUseDefaultIcon(currentAbilityId) == true then
            currentCCIcon = self:SetupDefaultIcon(currentAbilityId, currentResult)
        else
            currentCCIcon = GetAbilityIcon(currentAbilityId)
        end

        LUIE_CCTracker_BreakFreeFrame_Left_IconBG:SetColor(unpack(currentColor))
        LUIE_CCTracker_BreakFreeFrame_Right_IconBG:SetColor(unpack(currentColor))
        LUIE_CCTracker_BreakFreeFrame_Left_IconBorder:SetColor(unpack(currentColor))
        LUIE_CCTracker_BreakFreeFrame_Left_IconBorderHighlight:SetColor(unpack(currentColor))
        LUIE_CCTracker_BreakFreeFrame_Right_IconBorder:SetColor(unpack(currentColor))
        LUIE_CCTracker_BreakFreeFrame_Right_IconBorderHighlight:SetColor(unpack(currentColor))
    end

    self:VarReset()
    self.breakFreePlaying = true

    if not currentCCIcon:find(ICON_MISSING) then
        breakFreeIcon = currentCCIcon
    else
        self:VarReset()
        self.breakFreePlaying = true
        self.breakFreePlayingDraw = true
        zo_callLater(function() self.breakFreePlayingDraw = nil self.breakFreePlaying = nil end, 450)
        LUIE_CCTracker:SetHidden(true)
        return
    end

    LUIE_CCTracker_BreakFreeFrame_Left_Icon:SetColor(1,1,1,1)
    LUIE_CCTracker_BreakFreeFrame_Right_Icon:SetColor(1,1,1,1)
    LUIE_CCTracker_BreakFreeFrame_Left_Icon:SetTexture(breakFreeIcon)
    LUIE_CCTracker_BreakFreeFrame_Left_Icon:SetTextureCoords(0,0.5,0,1)
    LUIE_CCTracker_BreakFreeFrame_Right_Icon:SetTexture(breakFreeIcon)
    LUIE_CCTracker_BreakFreeFrame_Right_Icon:SetTextureCoords(0.5,1,0,1)
    self:OnAnimation(nil, "breakfree", true)
end

function CrowdControlTracker:FindEffectGained(abilityId, sourceUnitId, abilityGraphic)
    local foundValue
    for k, v in pairs (self.effectsGained) do
        if v.abilityId == abilityId and v.sourceUnitId == sourceUnitId and v.abilityGraphic == abilityGraphic then
            foundValue = v
            break
        end
    end
    return foundValue
end

function CrowdControlTracker:CCPriority(ccType)
    local priority
        if ccType == 1 then priority = PriorityOne
        elseif ccType == 2 then priority = PriorityTwo
        elseif ccType == 3 then priority = PriorityThree
        elseif ccType == 4 then priority = PriorityFour
        elseif ccType == 6 then priority = PrioritySix
        end
    return priority
end

function CrowdControlTracker:BreakFreeAnimation()
    if self.currentlyPlaying then
        self.currentlyPlaying:Stop()
    end
    if self.immunePlaying then
        self.immunePlaying:Stop()
    end

    local leftSide, rightSide = LUIE_CCTracker_BreakFreeFrame_Left, LUIE_CCTracker_BreakFreeFrame_Right

    LUIE_CCTracker:SetScale(CombatInfo.SV.cct.controlScale)
    leftSide:ClearAnchors()
    leftSide:SetAnchor(RIGHT, LUIE_CCTracker_BreakFreeFrame_Middle, LEFT, 1-20, 0)
    rightSide:ClearAnchors()
    rightSide:SetAnchor(LEFT, LUIE_CCTracker_BreakFreeFrame_Middle, RIGHT, -1+20, 0)
    leftSide:SetAlpha(1)
    rightSide:SetAlpha(1)

    local timeline = animationManager:CreateTimeline()
    local animDuration = 300
    local animDelay = 150

    self:InsertAnimationType(timeline, ANIMATION_SCALE, leftSide, animDelay, 0, ZO_EaseOutCubic, 1.0, 2)
    self:InsertAnimationType(timeline, ANIMATION_SCALE, rightSide, animDelay, 0, ZO_EaseOutCubic, 1.0, 2)
    self:InsertAnimationType(timeline, ANIMATION_SCALE, leftSide, animDuration, animDelay, ZO_EaseOutCubic, 1.8, 0.1)
    self:InsertAnimationType(timeline, ANIMATION_SCALE, rightSide, animDuration, animDelay, ZO_EaseOutCubic, 1.8, 0.1)
    self:InsertAnimationType(timeline, ANIMATION_ALPHA, leftSide, animDuration, animDelay, ZO_EaseInOutQuintic, 1, 0)
    self:InsertAnimationType(timeline, ANIMATION_ALPHA, rightSide, animDuration, animDelay, ZO_EaseInOutQuintic, 1, 0)
    self:InsertAnimationType(timeline, ANIMATION_TRANSLATE, leftSide, animDuration, animDelay, ZO_EaseOutCubic, 0, 0, -550, 0)
    self:InsertAnimationType(timeline, ANIMATION_TRANSLATE, rightSide, animDuration, animDelay, ZO_EaseOutCubic, 0, 0, 550, 0)

    timeline:SetHandler('OnStop', function()
        leftSide:ClearAnchors()
        leftSide:SetAnchor(LEFT, LUIE_CCTracker_BreakFreeFrame, LEFT, 0, 0)
        leftSide:SetScale(1)
        rightSide:ClearAnchors()
        rightSide:SetAnchor(RIGHT, LUIE_CCTracker_BreakFreeFrame, RIGHT, 0, 0)
        rightSide:SetScale(1)
        self.breakFreePlaying = nil
    end)

    timeline:PlayFromStart()

    return timeline
end

function CrowdControlTracker:StartAnimation(control, animType, test)
    if self.currentlyPlaying then
        self.currentlyPlaying:Stop()
    end
    if self.immunePlaying then
        self.immunePlaying:Stop()
    end

    local _, point, relativeTo, relativePoint, offsetX, offsetY = control:GetAnchor()
    control:ClearAnchors()
    control:SetAnchor(point, relativeTo, relativePoint, offsetX, offsetY)

    local timeline = animationManager:CreateTimeline()

    if animType == "proc" then
        if control:GetAlpha() == 0 then
            self:InsertAnimationType(timeline, ANIMATION_ALPHA, control, 100, 0, ZO_EaseInQuadratic, 0, 1)
        else
            control:SetAlpha(1)
        end
        self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 100,   0, ZO_EaseInQuadratic,   1, 2.2, SET_SCALE_FROM_SV)
        self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 200, 200, ZO_EaseOutQuadratic, 2.2,   1, SET_SCALE_FROM_SV)

    elseif animType == "end" or animType == "endstagger" then
        local currentAlpha = control:GetAlpha()
        self:InsertAnimationType(timeline, ANIMATION_ALPHA, control, 150,   0, ZO_EaseOutQuadratic,  currentAlpha,   0)

    elseif animType == "silence" then
        if LUIE_CCTracker:GetAlpha() < 1 then
            self:InsertAnimationType(timeline, ANIMATION_ALPHA, LUIE_CCTracker, 100,   0, ZO_EaseInQuadratic,    0,   1)
            self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 100,   0, ZO_EaseInQuadratic,    1, 2.5, SET_SCALE_FROM_SV)
            self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 200, 200, ZO_EaseOutQuadratic, 2.5,   1, SET_SCALE_FROM_SV)
        else
            LUIE_CCTracker:SetAlpha(1)
            self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 250,   0, ZO_EaseInQuadratic,    1, 1.5, SET_SCALE_FROM_SV)
            self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 250, 250, ZO_EaseOutQuadratic, 1.5,   1, SET_SCALE_FROM_SV)
        end

    elseif animType == "stagger" then
        self:InsertAnimationType(timeline, ANIMATION_ALPHA, control, 50,  0, ZO_EaseInQuadratic,    0,   1)
        self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 50,  0, ZO_EaseInQuadratic,    1, 1.5, SET_SCALE_FROM_SV)
        self:InsertAnimationType(timeline, ANIMATION_SCALE, control, 50, 100, ZO_EaseOutQuadratic, 1.5,   1, SET_SCALE_FROM_SV)

    elseif animType == "immune" then
        control:SetScale(CombatInfo.SV.cct.controlScale*1)
        self:InsertAnimationType(timeline, ANIMATION_ALPHA, control, 10, 0, ZO_EaseInQuadratic, 0, 0.6)
        self:InsertAnimationType(timeline, ANIMATION_ALPHA, control, CombatInfo.SV.cct.immuneDisplayTime, 100, ZO_EaseInOutQuadratic, 0.6, 0)
    end

    timeline:SetHandler('OnStop', function()
        control:SetScale(CombatInfo.SV.cct.controlScale)
        control:ClearAnchors()
        control:SetAnchor(point, relativeTo, relativePoint, offsetX, offsetY)
        self.currentlyPlaying = nil
        self.immunePlaying = nil
    end)

    timeline:PlayFromStart()
    return timeline
end

function CrowdControlTracker:InsertAnimationType(animHandler, animType, control, animDuration, animDelay, animEasing, ...)
    if not animHandler then
        return
    end
    if animType == ANIMATION_SCALE then
        local animationScale, startScale, endScale, scaleFromSV = animHandler:InsertAnimation(ANIMATION_SCALE, control, animDelay), ...
        if scaleFromSV then
            startScale = startScale * CombatInfo.SV.cct.controlScale
            endScale = endScale * CombatInfo.SV.cct.controlScale
        end
        animationScale:SetScaleValues(startScale, endScale)
        animationScale:SetDuration(animDuration)
        animationScale:SetEasingFunction(animEasing)
    elseif animType == ANIMATION_ALPHA then
        local animationAlpha, startAlpha, endAlpha = animHandler:InsertAnimation(ANIMATION_ALPHA, control, animDelay), ...
        animationAlpha:SetAlphaValues(startAlpha, endAlpha)
        animationAlpha:SetDuration(animDuration)
        animationAlpha:SetEasingFunction(animEasing)
    elseif animType == ANIMATION_TRANSLATE then
        local animationTranslate, startX, startY, offsetX, offsetY = animHandler:InsertAnimation(ANIMATION_TRANSLATE, control, animDelay), ...
        animationTranslate:SetTranslateOffsets(startX, startY, offsetX, offsetY)
        animationTranslate:SetDuration(animDuration)
        animationTranslate:SetEasingFunction(animEasing)
    end
end

function CrowdControlTracker:InitControls()
    LUIE_CCTracker:ClearAnchors()
    LUIE_CCTracker:SetAnchor(CENTER, GuiRoot, CENTER, CombatInfo.SV.cct.offsetX, CombatInfo.SV.cct.offsetY)
    LUIE_CCTracker:SetScale(CombatInfo.SV.cct.controlScale)
    LUIE_CCTracker_TextFrame_Label:SetFont(iconFont)
    if CombatInfo.SV.cct.unlock then
        LUIE_CCTracker_TextFrame_Label:SetText("Unlocked")
    else
        LUIE_CCTracker_TextFrame_Label:SetText("")
    end
    self:TextHidden(false)
    LUIE_CCTracker_IconFrame_IconBorder:SetTexture(iconBorder)
    LUIE_CCTracker_IconFrame_IconBorderHighlight:SetTexture(iconBorder)
    LUIE_CCTracker_IconFrame_IconBorder:SetHidden(false)
    LUIE_CCTracker_IconFrame_IconBorderHighlight:SetHidden(false)
    LUIE_CCTracker_IconFrame_Cooldown:ResetCooldown()
    LUIE_CCTracker_IconFrame_Cooldown:SetHidden(true)
    LUIE_CCTracker_IconFrame_GlobalCooldown:ResetCooldown()
    LUIE_CCTracker_IconFrame_GlobalCooldown:SetHidden(true)
    LUIE_CCTracker_IconFrame_Icon:SetTexture(defaultImmuneIcon)
    LUIE_CCTracker_IconFrame_Icon:SetTextureCoords(0.2,0.8,0.2,0.8)
    LUIE_CCTracker_IconFrame_IconBG:SetColor(1,1,1)
    LUIE_CCTracker_IconFrame_Icon:SetColor(1,1,1)
    self:IconHidden(false)
    LUIE_CCTracker_IconFrame_IconBorder:SetColor(1,1,1)
    LUIE_CCTracker_IconFrame_IconBorderHighlight:SetColor(1,1,1)
    LUIE_CCTracker_TextFrame_Label:SetColor(1,1,1)

    LUIE_CCTracker:SetMouseEnabled(CombatInfo.SV.cct.unlock)
    LUIE_CCTracker:SetMovable(CombatInfo.SV.cct.unlock)
    LUIE_CCTracker:SetAlpha(1)

    LUIE_CCTracker_BreakFreeFrame_Left_IconBorder:SetTexture(iconBorder)
    LUIE_CCTracker_BreakFreeFrame_Left_IconBorderHighlight:SetTexture(iconBorder)
    LUIE_CCTracker_BreakFreeFrame_Left_IconBorder:SetTextureCoords(0,0.5,0,1)
    LUIE_CCTracker_BreakFreeFrame_Left_IconBorderHighlight:SetTextureCoords(0,0.5,0,1)
    LUIE_CCTracker_BreakFreeFrame_Right_IconBorder:SetTexture(iconBorder)
    LUIE_CCTracker_BreakFreeFrame_Right_IconBorderHighlight:SetTexture(iconBorder)
    LUIE_CCTracker_BreakFreeFrame_Right_IconBorder:SetTextureCoords(0.5,1,0,1)
    LUIE_CCTracker_BreakFreeFrame_Right_IconBorderHighlight:SetTextureCoords(0.5,1,0,1)
    LUIE_CCTracker_BreakFreeFrame_Left_Icon:SetTexture(defaultDisorientIcon)
    LUIE_CCTracker_BreakFreeFrame_Left_Icon:SetTextureCoords(0,0.5,0,1)
    LUIE_CCTracker_BreakFreeFrame_Right_Icon:SetTexture(defaultDisorientIcon)
    LUIE_CCTracker_BreakFreeFrame_Right_Icon:SetTextureCoords(0.5,1,0,1)
    self:BreakFreeHidden(true)
    self:TimerHidden(not CombatInfo.SV.cct.unlock)
    LUIE_CCTracker_Timer_Label:SetText("69")
    LUIE_CCTracker_Timer_Label:SetColor(1,1,1,1)
    LUIE_CCTracker:SetHidden(not CombatInfo.SV.cct.unlock)
end

function CrowdControlTracker:FullReset()
    self:VarReset()
    if self.currentlyPlaying then
        self.currentlyPlaying:Stop()
    end

    if self.breakFreePlaying then
        if not self.breakFreePlayingDraw then
            self.breakFreePlaying:Stop() end
        else
            self.breakFreePlayingDraw = nil
            self.breakFreePlaying = nil
        end
    if self.immunePlaying then
        self.immunePlaying:Stop()
    end
    self:InitControls()
end

function CrowdControlTracker:VarReset()
    self.effectsGained = {}
    self.disorientsQueue = {}
    self.fearsQueue = {}
    self.currentCC = 0
    PriorityOne = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
    PriorityTwo = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
    PriorityThree = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
    PriorityFour = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
    PrioritySix = {endTime = 0, abilityId = 0, abilityIcon = "", hitValue = 0, result = 0, abilityName = ""}
    self.Timer = 0
end
