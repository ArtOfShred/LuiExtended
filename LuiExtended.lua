------------------
-- LUIE namespace
LUIE             = {}
LUIE.name        = "LuiExtended"
LUIE.author      = "ArtOfShred, psypanda & SpellBuilder"
LUIE.version     = "5.5.2"
LUIE.website     = "http://www.esoui.com/downloads/info818-LuiExtended.html"
LUIE.github      = "https://github.com/ArtOfShred/LuiExtended"
LUIE.components  = {}

-- Saved variables options
LUIE.SV          = nil
LUIE.SVVer       = 2
LUIE.SVName      = "LUIESV"

-- Performance Enhancement
local strfmt        = string.format
local strmatch      = string.match
local strformat     = zo_strformat
local tableinsert   = table.insert
local tablesort     = table.sort
local gsub          = gsub
local reverse       = reverse
local tostring      = tostring
local pairs, ipairs = pairs, ipairs

local eventManager  = EVENT_MANAGER

local colorDef       = ZO_ColorDef

-- Local
local TimeStampColorize

-- Default Settings
LUIE.D = {
    CharacterSpecificSV         = false,
    StartupInfo                 = false,
    HideXPBar                   = false,
    TempAlertHome               = false,
    TempAlertCampaign           = false,
	TempAlertOutfit				= false,
    WelcomeVersion              = 0,

    -- Modules
    UnitFrames_Enabled          = true,
    InfoPanel_Enabled           = true,
    CombatInfo_Enabled          = true,
    CombatText_Enabled          = true,
    SpellCastBuff_Enable        = true,
    ChatAnnouncements_Enable    = true,
    SlashCommands_Enable        = true,
}

-- Global fonts table to use in other parts of this addon
LUIE.Fonts = {
    ["ProseAntique"]            = "/EsoUI/Common/Fonts/ProseAntiquePSMT.otf",
    ["Consolas"]                = "/EsoUI/Common/Fonts/consola.ttf",
    ["Futura Condensed"]        = "/EsoUI/Common/Fonts/FTN57.otf",
    ["Futura Condensed Bold"]   = "/EsoUI/Common/Fonts/FTN87.otf",
    ["Futura Condensed Light"]  = "/EsoUI/Common/Fonts/FTN47.otf",
    ["Skyrim Handwritten"]      = "/EsoUI/Common/Fonts/Handwritten_Bold.otf",
    ["Trajan Pro"]              = "/EsoUI/Common/Fonts/trajanpro-regular.otf",
    ["Univers 55"]              = "/EsoUI/Common/Fonts/univers55.otf",
    ["Univers 57"]              = "/EsoUI/Common/Fonts/univers57.otf",
    ["Univers 67"]              = "/EsoUI/Common/Fonts/univers67.otf",
    ["Fontin Bold"]             = "/LuiExtended/media/fonts/Fontin/fontin_sans_b.otf",
    ["Fontin Italic"]           = "/LuiExtended/media/fonts/Fontin/fontin_sans_i.otf",
    ["Fontin Regular"]          = "/LuiExtended/media/fonts/Fontin/fontin_sans_r.otf",
    ["Fontin SmallCaps"]        = "/LuiExtended/media/fonts/Fontin/fontin_sans_sc.otf",
    ["Trajan Pro Bold"]         = "/LuiExtended/media/fonts/TrajanPro/TrajanProBold.otf",
    ["EnigmaReg"]               = "/LuiExtended/media/fonts/Enigma/EnigmaReg.ttf",
    ["EnigmaBold"]              = "/LuiExtended/media/fonts/Enigma/EnigmaBold.ttf",
    ["Adventure"]               = "/LuiExtended/media/fonts/Adventure/adventure.ttf",
    ["Bazooka"]                 = "/LuiExtended/media/fonts/Bazooka/bazooka.ttf",
    ["Cooline"]                 = "/LuiExtended/media/fonts/Cooline/cooline.ttf",
    ["Diogenes"]                = "/LuiExtended/media/fonts/Diogenes/diogenes.ttf",
    ["Ginko"]                   = "/LuiExtended/media/fonts/Ginko/ginko.ttf",
    ["Heroic"]                  = "/LuiExtended/media/fonts/Heroic/heroic.ttf",
    ["Metamorphous"]            = "/LuiExtended/media/fonts/Metamorphous/metamorphous.otf",
    ["Porky"]                   = "/LuiExtended/media/fonts/Porky/porky.ttf",
    ["Roboto Bold"]             = "/LuiExtended/media/fonts/Roboto/Roboto-Bold.ttf",
    ["Roboto Bold Italic"]      = "/LuiExtended/media/fonts/Roboto/Roboto-BoldItalic.ttf",
    ["Talisman"]                = "/LuiExtended/media/fonts/Talisman/talisman.ttf",
    ["Transformers"]            = "/LuiExtended/media/fonts/Transformers/transformers.ttf",
    ["Yellowjacket"]            = "/LuiExtended/media/fonts/Yellowjacket/yellowjacket.ttf",
    ["ProFontWindows"]          = "/LuiExtended/media/fonts/ProFontWindows/ProFontWindows.ttf",
}

LUIE.Sounds = {
    ["Death Recap Killing Blow"]  = SOUNDS.DEATH_RECAP_KILLING_BLOW_SHOWN,
}

LUIE.StatusbarTextures = {
    ["Aluminium"]               = "/LuiExtended/media/unitframes/textures/Aluminium.dds",
    ["Elder Scrolls Gradient"]  = "/LuiExtended/media/unitframes/textures/ElderScrollsGrad.dds",
    ["Glass"]                   = "/LuiExtended/media/unitframes/textures/Glass.dds",
    ["Glaze"]                   = "/LuiExtended/media/unitframes/textures/Glaze.dds",
    ["Horizontal Gradient 1"]   = "/LuiExtended/media/unitframes/textures/HorizontalGrad.dds",
    ["Horizontal Gradient 2"]   = "/LuiExtended/media/unitframes/textures/HorizontalGradV2.dds",
    ["Inner Glow"]              = "/LuiExtended/media/unitframes/textures/InnerGlow.dds",
    ["Inner Shadow"]            = "/LuiExtended/media/unitframes/textures/InnerShadow.dds",
    ["Inner Shadow Glossy"]     = "/LuiExtended/media/unitframes/textures/InnerShadowGloss.dds",
    ["Minimalistic"]            = "/LuiExtended/media/unitframes/textures/Minimalistic.dds",
    ["Round"]                   = "/LuiExtended/media/unitframes/textures/Round.dds",
    ["Sand Paper 1"]            = "/LuiExtended/media/unitframes/textures/SandPaper.dds",
    ["Sand Paper 2"]            = "/LuiExtended/media/unitframes/textures/SandPaperV2.dds",
    ["Shadow"]                  = "/LuiExtended/media/unitframes/textures/Shadow.dds",
    ["Smooth"]                  = "/LuiExtended/media/unitframes/textures/Smooth.dds",
    ["Plain"]                   = "/LuiExtended/media/unitframes/textures/Plain.dds",
}

-- Load saved settings
local function LUIE_LoadSavedVars()
    -- Addon options
    LUIE.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, nil, LUIE.D)

    if LUIE.SV.CharacterSpecificSV then
        LUIE.SV = ZO_SavedVars:New(LUIE.SVName, LUIE.SVVer, nil, LUIE.D)
    end
end

-- Load additional fonts and status bar textures from LMP if it is present in environment
local function LUIE_LoadMedia()
    local LMP = LibStub("LibMediaProvider-1.0")
    if LMP == nil then
        return
    end

    -- Update Fonts
    for _, f in pairs(LMP:List(LMP.MediaType.FONT)) do
        if not LUIE.Fonts[f] then
            LUIE.Fonts[f] = LMP:Fetch(LMP.MediaType.FONT, f)
        end
    end

    -- Update StatusBar textures
    for _, s in pairs(LMP:List(LMP.MediaType.STATUSBAR)) do
        if not LUIE.StatusbarTextures[s] then
            LUIE.StatusbarTextures[s] = LMP:Fetch(LMP.MediaType.STATUSBAR, s)
        end
    end

    for _, a in pairs (LMP:List(LMP.MediaType.SOUND)) do
        if not LUIE.StatusbarTextures[a] then
            LUIE.Sounds[a] = LMP:Fetch(LMP.MediaType.SOUND, a)
        end
    end
end

-- Startup Info string
local function LUIE_LoadScreen()
    eventManager:UnregisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED)

    if not LUIE.SV.StartupInfo then
        LUIE.PrintToChat(strfmt("|cFEFEFE%s by|r |c00C000%s|r |cFEFEFEv%s|r", LUIE.name, LUIE.author, LUIE.version), true)
    end
end

-- Runs on the EVENT_ACTION_LAYER_POPPED and EVENT_ACTION_LAYER_PUSHED listeners.
-- This handler is used to hide and show all GUI elements when player opens any sort of menu.
local function LUIE_ToggleVisibility(eventCode, layerIndex, activeLayerIndex)
    local hidden = ( activeLayerIndex > 3 )
    for _, control in pairs( LUIE.components ) do
        control:SetHidden( hidden )
    end
end

local function LUIE_RegisterEvents()
    eventManager:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LUIE_LoadScreen)
    eventManager:RegisterForEvent(LUIE.name, EVENT_ACTION_LAYER_POPPED, LUIE_ToggleVisibility)
    eventManager:RegisterForEvent(LUIE.name, EVENT_ACTION_LAYER_PUSHED, LUIE_ToggleVisibility)
    -- Events registerd for Slash Commands
    -- TODO: Only register if Slash Commands module loaded
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, LUIE.GuildAddedSelf)
    eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD, LUIE.GuildRemovedSelf)
end

-- LuiExtended Initialization
local function LUIE_OnAddOnLoaded(eventCode, addonName)
    -- Only initialize our own addon
    if LUIE.name ~= addonName then
        return
    end
    -- Once we know it's ours, lets unregister the event listener
    eventManager:UnregisterForEvent(addonName, eventCode)

    -- Load additional media from LMP and other addons
    LUIE_LoadMedia()

    -- Load saved variables
    LUIE_LoadSavedVars()

    -- Display welcome screen
    LUIE_WelcomeScreen()

    LUIE.PlayerNameRaw = GetRawUnitName("player")
    LUIE.PlayerNameFormatted = strformat(SI_UNIT_NAME, GetUnitName("player"))
    LUIE.PlayerDisplayName = strformat(SI_UNIT_NAME, GetUnitDisplayName("player"))

    -- Initialize this addon modules according to user preferences
    LUIE.ChatAnnouncements.Initialize( LUIE.SV.ChatAnnouncements_Enable )
    LUIE.CombatInfo.Initialize( LUIE.SV.CombatInfo_Enabled )
    LUIE.CombatText.Initialize ( LUIE.SV.CombatText_Enabled )
    LUIE.InfoPanel.Initialize( LUIE.SV.InfoPanel_Enabled )
    LUIE.UnitFrames.Initialize( LUIE.SV.UnitFrames_Enabled )
    LUIE.SpellCastBuffs.Initialize( LUIE.SV.SpellCastBuff_Enable )
    LUIE.SlashCommands.Initialize( LUIE.SV.SlashCommands_Enable )

	-- Load Timetamp Color
    LUIE.UpdateTimeStampColor()

    -- Create settings menu for our addon
    LUIE_CreateSettings()

    -- Register global event listeners
    LUIE_RegisterEvents()

    -- Keep track of guilds for the /ginvite commands
    LUIE.InitGuildData()

    local zos_GetSkillAbilityInfo = GetSkillAbilityInfo
    GetSkillAbilityInfo = function(skillType, skillIndex, abilityIndex)
        local name, texture, earnedRank, passive, ultimate, purchased, progressionIndex, rankIndex = zos_GetSkillAbilityInfo(skillType, skillIndex, abilityIndex)
        local abilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then
            texture = LUIE.Effects.EffectOverride[abilityId].icon
        end
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then
            name = LUIE.Effects.EffectOverride[abilityId].name
        end
        return name, texture, earnedRank, passive, ultimate, purchased, progressionIndex, rankIndex
    end

    local zos_GetSkillAbilityNextUpgradeInfo = GetSkillAbilityNextUpgradeInfo
    GetSkillAbilityNextUpgradeInfo = function(skillType, skillIndex, abilityIndex)
        local name, texture, earnedRank = zos_GetSkillAbilityNextUpgradeInfo(skillType, skillIndex, abilityIndex)
        local abilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then
            texture = LUIE.Effects.EffectOverride[abilityId].icon
        end
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then
            name = LUIE.Effects.EffectOverride[abilityId].name
        end
        return name, texture, earnedRank
    end

    local zos_GetUnitBuffInfo = GetUnitBuffInfo
    GetUnitBuffInfo = function(unitTag, buffIndex)
        local buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = zos_GetUnitBuffInfo(unitTag, buffIndex)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then
            buffName = LUIE.Effects.EffectOverride[abilityId].name
        end
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then
            iconFile = LUIE.Effects.EffectOverride[abilityId].icon
        end

        return buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer
    end

    -- Death Recap enhancements
    local zos_GetKillingAttackerInfo = GetKillingAttackerInfo
    local zos_GetKillingAttackInfo = GetKillingAttackInfo

    GetKillingAttackerInfo = function(index)
        local attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName = zos_GetKillingAttackerInfo(index)
        local attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits, abilityId = zos_GetKillingAttackInfo(index)

        if LUIE.Effects.EffectSourceOverride[abilityId] then
            if LUIE.Effects.EffectSourceOverride[abilityId].source then
                attackerRawName = LUIE.Effects.EffectSourceOverride[abilityId].source
            end
            if LUIE.Effects.EffectSourceOverride[abilityId].pet then
                minionName = LUIE.Effects.EffectSourceOverride[abilityId].pet
            end
        end

        return attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName
    end

    GetKillingAttackInfo = function(index)
        local attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName = zos_GetKillingAttackerInfo(index)
        local attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits, abilityId = zos_GetKillingAttackInfo(index)

        if LUIE.Effects.EffectOverride[abilityId] then
            attackName = LUIE.Effects.EffectOverride[abilityId].name or attackName
            attackIcon = LUIE.Effects.EffectOverride[abilityId].icon or attackIcon
        end

        if LUIE.Effects.EffectOverrideByName[abilityId] then
            local unitName = strformat("<<t:1>>", attackerRawName)
            local petName = strformat("<<t:1>>", minionName)
            if LUIE.Effects.EffectOverrideByName[abilityId][unitName] then
                if LUIE.Effects.EffectOverrideByName[abilityId][unitName].hide then
                    return
                end
                attackName = LUIE.Effects.EffectOverrideByName[abilityId][unitName].name or attackName
                attackIcon = LUIE.Effects.EffectOverrideByName[abilityId][unitName].icon or attackIcon
            end
            if LUIE.Effects.EffectOverrideByName[abilityId][petName] then
                if LUIE.Effects.EffectOverrideByName[abilityId][petName].hide then
                    return
                end
                attackName = LUIE.Effects.EffectOverrideByName[abilityId][petName].name or attackName
                attackIcon = LUIE.Effects.EffectOverrideByName[abilityId][petName].icon or attackIcon
            end
        end

        return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
    end

    -- Hook support for other addons (Icon)
    LUIE.GetAbilityIcon = GetAbilityIcon -- Used only for PTS testing
    zos_GetAbilityIcon = GetAbilityIcon
    GetAbilityIcon = function(abilityId)
        local icon = zos_GetAbilityIcon(abilityId)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then
            icon = LUIE.Effects.EffectOverride[abilityId].icon
        end
        return(icon)
    end

    -- Hook support for other addons (Name)
    LUIE.GetAbilityName = GetAbilityName -- Used only for PTS testing
    zos_GetAbilityName = GetAbilityName
    GetAbilityName = function(abilityId)
        local abilityName = zos_GetAbilityName(abilityId)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then
            abilityName = LUIE.Effects.EffectOverride[abilityId].name
        end
        return(abilityName)
    end

    -- Hook support for other addons (Artificial effect ids)
    LUIE.GetArtificialEffectInfo = GetArtificialEffectInfo -- Used only for PTS testing
    zos_GetArtificialEffectInfo = GetArtificialEffectInfo
    GetArtificialEffectInfo = function(artificialEffectId)
        local displayName, iconFile, effectType, sortOrder, timeStarted, timeEnding = zos_GetArtificialEffectInfo(artificialEffectId)
        if LUIE.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Effects.ArtificialEffectOverride[artificialEffectId].icon then
            iconFile = LUIE.Effects.ArtificialEffectOverride[artificialEffectId].icon
        end
        if LUIE.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Effects.ArtificialEffectOverride[artificialEffectId].name then
            displayName = LUIE.Effects.ArtificialEffectOverride[artificialEffectId].name
        end
        return displayName, iconFile, effectType, sortOrder, timeStarted, timeEnding
    end

    ZO_Synergy.OnSynergyAbilityChanged = function(self)
        local synergyName, iconFilename = GetSynergyInfo()

        if LUIE.Effects.SynergyNameOverride[synergyName] then
            iconFilename = LUIE.Effects.SynergyNameOverride[synergyName]
        end

        if synergyName and iconFilename then
            if self.lastSynergyName ~= synergyName then
                PlaySound(SOUNDS.ABILITY_SYNERGY_READY)

                self.action:SetText(strformat(SI_USE_SYNERGY, synergyName))
            end

            self.icon:SetTexture(iconFilename)
            SHARED_INFORMATION_AREA:SetHidden(self, false)
        else
            SHARED_INFORMATION_AREA:SetHidden(self, true)
        end

        self.lastSynergyName = synergyName
    end

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
                    effectsRow.name:SetText(strformat(SI_ABILITY_TOOLTIP_NAME, displayName))
                    effectsRow.icon:SetTexture(iconFile)
                    effectsRow.effectType = effectType
                    effectsRow.time:SetHidden(true)
                    effectsRow.sortOrder = sortOrder
                    effectsRow.tooltipTitle = strformat(SI_ABILITY_TOOLTIP_NAME, displayName)
                    effectsRow.effectId = effectId
                    effectsRow.isArtificial = true

                    tableinsert(effectsRows, effectsRow)
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

                -- Heavy handed - but functional way to mark duplicate abilities to not display (Duplicate shuffle auras, etc) by only displaying the one with the latest end time.
                for i = 1, #trackBuffs do
                    local compareId = trackBuffs[i].abilityId
                    local compareTime = trackBuffs[i].endTime
                    -- Only re-iterate and compare if this ability is on the override table, this way we avoid as much of this double loop as possible.
                    if LUIE.Effects.EffectOverride[compareId] and LUIE.Effects.EffectOverride[compareId].noDuplicate then
                        for k, v in pairs(trackBuffs) do
                            -- Only remove the lower duration effects that were cast previously.
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

                    local tooltipText = LUIE.Effects.TooltipOverride[abilityId] or GetAbilityEffectDescription(buffSlot)

                    -- In debug mode for now
                    local displayName = GetDisplayName()
                    if tooltipText == "" and displayName == "@ArtOfShred" or displayName == "@ArtOfShredLegacy" then
                        if GetAbilityDescription(abilityId) ~= "" then
                            tooltipText = "|c2DC50EDescription:|r " .. GetAbilityDescription(abilityId) or ""
                        end
                    end
                    -- In debug mode for now

                    if tooltipText ~= "" then
                        tooltipText = strmatch(tooltipText, ".*%S")
                    end
                    local thirdLine
                    if LUIE.Effects.TooltipNameOverride[buffName] then
                        thirdLine = strformat(LUIE.Effects.TooltipNameOverride[buffName], GetAbilityDuration(abilityId)/1000 )
                    end
                    if buffSlot > 0 and buffName ~= "" and not (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].hide) and not markForRemove then
                        local effectsRow = effectsRowPool:AcquireObject()
                        effectsRow.name:SetText(strformat(SI_ABILITY_TOOLTIP_NAME, buffName))
                        effectsRow.icon:SetTexture(iconFile)
                        effectsRow.tooltipTitle = strformat(SI_ABILITY_TOOLTIP_NAME, buffName)
                        effectsRow.tooltipText = tooltipText
                        effectsRow.thirdLine = thirdLine
                        local duration = startTime - endTime
                        effectsRow.time:SetHidden(duration == 0)
                        effectsRow.time.endTime = endTime
                        effectsRow.effectType = effectType
                        effectsRow.buffSlot = buffSlot
                        effectsRow.isArtificial = false

                        tableinsert(effectsRows, effectsRow)
                    end
                end

                tablesort(effectsRows, EffectsRowComparator)
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

    ZO_StatsActiveEffect_OnMouseEnter = function(control)
        InitializeTooltip(GameTooltip, control, RIGHT, -15)
        if control.isArtificial then
            local tooltipText = GetArtificialEffectTooltipText(control.effectId)
            GameTooltip:AddLine(control.tooltipTitle, "", ZO_SELECTED_TEXT:UnpackRGBA())
            GameTooltip:AddLine(tooltipText, "", ZO_NORMAL_TEXT:UnpackRGBA())
        else
            GameTooltip:AddLine(control.tooltipTitle, "", ZO_SELECTED_TEXT:UnpackRGBA())
            if control.tooltipText ~= "" and control.tooltipText ~= nil then
                GameTooltip:AddLine(control.tooltipText, "", ZO_NORMAL_TEXT:UnpackRGBA())
            end
            if control.thirdLine ~="" and control.thirdLine ~= nil then
                GameTooltip:AddLine(control.thirdLine, "", ZO_NORMAL_TEXT:UnpackRGBA())
            end
        end

        if not control.animation then
            control.animation = ANIMATION_MANAGER:CreateTimelineFromVirtual("ShowOnMouseOverLabelAnimation", control:GetNamedChild("Highlight"))
        end
        control.animation:PlayForward()
    end

    -- Hook skills advisor and use this variable to refresh the abilityData on time on initialization. We don't want to reload any more after that.
    local firstRun = true

    -- Overwrite skills advisor ability data function
    ZO_SKILLS_ADVISOR_SINGLETON.FillInAbilityData = function(self, abilityData, skillBuildId, skillBuildAbilityIndex)
        local skillType, lineIndex, abilityIndex, isActive, skillBuildMorphChoice, skillBuildRankIndex = GetSkillBuildEntryInfo(skillBuildId, skillBuildAbilityIndex)
        local _, _, earnedRank, _, ultimate, purchased, progressionIndex, rankIndex = GetSkillAbilityInfo(skillType, lineIndex, abilityIndex)
        local _, lineRank = GetSkillLineInfo(skillType, lineIndex)
        local abilityId, rankNeeded = GetSpecificSkillAbilityInfo(skillType, lineIndex, abilityIndex, skillBuildMorphChoice, skillBuildRankIndex)
        local _, _, nextUpgradeEarnedRank = GetSkillAbilityNextUpgradeInfo(skillType, lineIndex, abilityIndex)
        local currentMorphChoice
        local atMorph = false
        if progressionIndex then
            currentMorphChoice = select(2, GetAbilityProgressionInfo(progressionIndex))
            atMorph = select(4, GetAbilityProgressionXPInfo(progressionIndex))
        end

        -- This data is expensive to get, and won't change when the ID is the same.
        if abilityData.abilityId ~= abilityId or firstRun then
            local rawName = GetAbilityName(abilityId)
            local icon = GetAbilityIcon(abilityId)

            local plainName = strformat(SI_ABILITY_NAME, rawName)
            abilityData.name = isActive and plainName or strformat(SI_ABILITY_NAME_AND_RANK, rawName, skillBuildRankIndex)
            abilityData.plainName = plainName
            abilityData.icon = icon
        end

        abilityData.abilityId = abilityId
        abilityData.skillType = skillType
        abilityData.lineIndex = lineIndex
        abilityData.abilityIndex = abilityIndex
        abilityData.earnedRank = earnedRank
        abilityData.nextUpgradeEarnedRank = nextUpgradeEarnedRank
        abilityData.rankIndex = rankIndex
        abilityData.passive = not isActive
        abilityData.ultimate = ultimate
        abilityData.purchased = purchased
        abilityData.progressionIndex = progressionIndex
        abilityData.lineRank = lineRank
        abilityData.atMorph = atMorph
        abilityData.morph = currentMorphChoice
        abilityData.skillBuildMorphChoice = skillBuildMorphChoice
        abilityData.skillBuildRankIndex = skillBuildRankIndex
        abilityData.rankNeeded = rankNeeded
    end

    ZO_SKILLS_ADVISOR_SINGLETON:UpdateSkillBuildData()

    firstRun = false

    local ACTION_BUTTON_BGS = {ability = "EsoUI/Art/ActionBar/abilityInset.dds", item = "EsoUI/Art/ActionBar/quickslotBG.dds"}
    local ACTION_BUTTON_BORDERS = {normal = "EsoUI/Art/ActionBar/abilityFrame64_up.dds", mouseDown = "EsoUI/Art/ActionBar/abilityFrame64_down.dds"}

    local function SetupActionSlot(slotObject, slotId)
        local slotIcon = GetSlotTexture(slotId)

        -- Added function - Replace icons if needed
        local slotName = GetSlotName(slotId)
        if LUIE.Effects.BarNameOverride[slotName] then
            slotIcon = LUIE.Effects.BarNameOverride[slotName]
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

    local function SetupSiegeActionSlot(slotObject, slotId)
        SetupActionSlot(slotObject, slotId)
    end

    local function SetupCollectibleActionSlot(slotObject, slotId)
        SetupActionSlotWithBg(slotObject, slotId)
        slotObject:ClearCount()
    end

    SetupSlotHandlers = {
        [ACTION_TYPE_ABILITY]       = SetupAbilitySlot,
        [ACTION_TYPE_ITEM]          = SetupItemSlot,
        [ACTION_TYPE_SIEGE_ACTION]  = SetupSiegeActionSlot,
        [ACTION_TYPE_COLLECTIBLE]   = SetupCollectibleActionSlot,
    }
end

-- Called from the menu and on initialization to update timestamp color when changed.
function LUIE.UpdateTimeStampColor()
    TimeStampColorize = colorDef:New(unpack(LUIE.ChatAnnouncements.SV.TimeStampColor)):ToHex()
end

-- Return a formatted time
-- Stolen from pChat, thanks @Ayantir
function LUIE.CreateTimestamp(timeStr, formatStr)
    local formatStr = formatStr or LUIE.ChatAnnouncements.SV.TimeStampFormat

    -- Split up default timestamp
    local hours, minutes, seconds = timeStr:match("([^%:]+):([^%:]+):([^%:]+)")
    local hoursNoLead = tonumber(hours) -- Hours without leading zero
    local hours12NoLead = (hoursNoLead - 1)%12 + 1
    local hours12
    if (hours12NoLead < 10) then
        hours12 = "0" .. hours12NoLead
    else
        hours12 = hours12NoLead
    end
    local pUp = "AM"
    local pLow = "am"
    if (hoursNoLead >= 12) then
        pUp = "PM"
        pLow = "pm"
    end

    -- Create new one
    local timestamp = formatStr
    timestamp = timestamp:gsub("HH", hours)
    timestamp = timestamp:gsub("H",  hoursNoLead)
    timestamp = timestamp:gsub("hh", hours12)
    timestamp = timestamp:gsub("h",  hours12NoLead)
    timestamp = timestamp:gsub("m",  minutes)
    timestamp = timestamp:gsub("s",  seconds)
    timestamp = timestamp:gsub("A",  pUp)
    timestamp = timestamp:gsub("a",  pLow)

    return timestamp
end

-- FormatMessage helper function
function LUIE.FormatMessage(msg, doTimestamp)
    local msg = msg or ""
    if doTimestamp then
        local timestring = GetTimeString()
        -- Color Code to match pChat default
        msg = strfmt("|c%s[%s]|r %s", TimeStampColorize, LUIE.CreateTimestamp(timestring), msg)
    end
    return msg
end

-- Easy Print to Chat
function LUIE.PrintToChat(msg, isSystem)
    if LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" then
        if not LUIE.ChatAnnouncements.SV.ChatBypass and CHAT_SYSTEM.primaryContainer then
            local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
            -- Add timestamps if bypass is not enabled
            CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
        else
            -- Otherwise send as a normal message and let other addons handle this.
            CHAT_SYSTEM:AddMessage(msg)
        end
    else
        -- If we have system messages sent to display in all windows then just print to all windows at once, otherwise send messages to individual tabs.
        if CHAT_SYSTEM.primaryContainer then
            if isSystem and LUIE.ChatAnnouncements.SV.ChatSystemAll then
                local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                -- Post as a System message so that it can appear in multiple tabs.
                CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
            else
                local chatContainer = CHAT_SYSTEM.primaryContainer
                for i = 1, #chatContainer.windows do
                    if LUIE.ChatAnnouncements.SV.ChatTab[i] == true then
                        local chatWindow = CHAT_SYSTEM.primaryContainer["windows"][i]
                        local msg = LUIE.FormatMessage(msg or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
                        chatContainer:AddEventMessageToWindow(chatWindow, msg, CHAT_CATEGORY_SYSTEM)
                    end
                end
            end
        end
    end
end

-- Returns a formatted number with commas
-- Function no comma to be added in a later date.
function LUIE.AbbreviateNumber(number, shorten, comma)
    if number > 0 and shorten then
        local value
        local suffix

        if number >= 1000000000 then
            value = number / 1000000000
            suffix = "G"
        elseif number >= 1000000 then
            value = number / 1000000
            suffix = "M"
        elseif number >= 1000 then
            value = number / 1000
            suffix = "k"
        else
            value = number
        end

        -- If we could not conver even to "G", return full number
        if value >= 1000 then
            if comma then
                value = ZO_LocalizeDecimalNumber(number)
                return value
            else
                return number
            end
        elseif value >= 100 or suffix == nil then
            value = strfmt("%d", value)
        else
            value = strfmt("%.1f", value)
        end

        if suffix ~= nil then
            value = value .. suffix
        end

        return value
    end

    -- Add commas if needed
    if comma then
        local value = ZO_LocalizeDecimalNumber(number)
        return value
    end

    return number
end

function LUIE.InitGuildData()
    GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

function LUIE.GuildAddedSelf(eventCode, guildId, guildName)
    GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

function LUIE.GuildRemovedSelf(eventCode, guildId, guildName)
    GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

-- Hook initialization
eventManager:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, LUIE_OnAddOnLoaded)
