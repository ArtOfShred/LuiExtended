------------------
-- LUIE namespace
LUIE             = {}
LUIE.name        = "LuiExtended"
LUIE.author      = "ArtOfShred, psypanda & SpellBuilder"
LUIE.version     = "5.7.3"
LUIE.website     = "http://www.esoui.com/downloads/info818-LuiExtended.html"
LUIE.github      = "https://github.com/ArtOfShred/LuiExtended"

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
local mathfloor     = math.floor
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
    ["ProseAntique"] 			= ZoFontBookPaper:GetFontInfo(),
    ["Consolas"] 				= "/EsoUI/Common/Fonts/consola.ttf",
    ["Futura Condensed"] 		= "/EsoUI/Common/Fonts/FTN57.otf",
    ["Futura Condensed Bold"] 	= "/EsoUI/Common/Fonts/FTN87.otf",
    ["Futura Condensed Light"] 	= "/EsoUI/Common/Fonts/FTN47.otf",
    ["Skyrim Handwritten"] 		= ZoFontBookLetter:GetFontInfo(),
    ["Trajan Pro"] 				= ZoFontBookTablet:GetFontInfo(),
    ["Univers 55"] 				= "/EsoUI/Common/Fonts/univers55.otf",
    ["Univers 57"] 				= ZoFontGame:GetFontInfo(),
    ["Univers 67"] 				= ZoFontWinH1:GetFontInfo(),
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

local function LUIE_RegisterEvents()
    eventManager:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LUIE_LoadScreen)
	-- Keep track of guilds for the /ginvite commands & Chat Announcement EVENT_GUILD_SELF_LEFT_GUILD handler
	if LUIE.SV.SlashCommands_Enable or LUIE.SV.ChatAnnouncements_Enable then
		LUIE.UpdateGuildData()
		eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, LUIE.UpdateGuildData)
		eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD, LUIE.UpdateGuildData)
	end
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

    zos_GetArtificialEffectTooltipText = GetArtificialEffectTooltipText
    GetArtificialEffectTooltipText = function(artificialEffectId)
        local tooltip
        if LUIE.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Effects.ArtificialEffectOverride[artificialEffectId].tooltip then
            tooltip = LUIE.Effects.ArtificialEffectOverride[artificialEffectId].tooltip
            return tooltip
        else
            tooltip = zos_GetArtificialEffectTooltipText(artificialEffectId)
            return tooltip
        end
    end

    ZO_Synergy.OnSynergyAbilityChanged = function(self)
        local synergyName, iconFilename = GetSynergyInfo()

        if LUIE.Effects.SynergyNameOverride[synergyName] then
            if LUIE.Effects.SynergyNameOverride[synergyName].icon then
                iconFilename = LUIE.Effects.SynergyNameOverride[synergyName].icon
            end
            if LUIE.Effects.SynergyNameOverride[synergyName].name then
                synergyName = LUIE.Effects.SynergyNameOverride[synergyName].name
            end
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

                    local timer = endTime - startTime
                    local value2 = (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].tooltipValue2Mod) and (timer + LUIE.Effects.EffectOverride[abilityId].tooltipValue2Mod) or 0
                    timer = math.floor((timer * 10) + 0.5) / 10
                    value2 = math.floor((value2 * 10) + 0.5) / 10

                    local tooltipText = (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].tooltip) and strformat(LUIE.Effects.EffectOverride[abilityId].tooltip, timer, value2) or GetAbilityDescription(abilityId)

                    -- Use default tooltip - temp if needed (TODO: Remove when all base ability/set tooltips are updated)
                    if tooltipText == "" or tooltipText == nil then
                        if GetAbilityEffectDescription(buffSlot) ~= "" then
                            tooltipText = GetAbilityEffectDescription(buffSlot)
                        end
                    end

                    if LUIE.Effects.TooltipUseDefault[abilityId] then
                        if GetAbilityEffectDescription(buffSlot) ~= "" then
                            tooltipText = GetAbilityEffectDescription(buffSlot)
                        end
                    end

                    if tooltipText ~= "" then
                        tooltipText = strmatch(tooltipText, ".*%S")
                    end
                    local thirdLine
                    local timer2 = (endTime - startTime)
                    if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].tooltipDurFix then
                        timer2 = timer2 + LUIE.Effects.EffectOverride[abilityId].tooltipDurFix
                    end
                    if LUIE.Effects.TooltipNameOverride[buffName] then
                        thirdLine = strformat(LUIE.Effects.TooltipNameOverride[buffName], timer2)
                    end
                    if LUIE.Effects.TooltipNameOverride[abilityId] then
                        thirdLine = strformat(LUIE.Effects.TooltipNameOverride[abilityId], timer2)
                    end

                    -- Change effect type if needed
                    if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].type then effectType = LUIE.Effects.EffectOverride[abilityId].type end

                    if buffSlot > 0 and buffName ~= "" and not (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].hide) and not markForRemove then
                        if (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].hideReduce and not LUIE.SpellCastBuffs.SV.HideReduce) or not (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].hideReduce) then
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

        local colorText = ZO_NORMAL_TEXT
        if control.thirdLine ~= "" and control.thirdLine ~= nil then
            colorText = control.effectType == BUFF_EFFECT_TYPE_DEBUFF and ZO_ERROR_COLOR or ZO_SUCCEEDED_TEXT
        end

        if control.isArtificialTooltip then
            local tooltipText = GetArtificialEffectTooltipText(control.effectId)
            GameTooltip:AddLine(control.tooltipTitle, "", ZO_SELECTED_TEXT:UnpackRGBA())
            GameTooltip:AddLine(tooltipText, "", colorText:UnpackRGBA())
        else
            GameTooltip:AddLine(control.tooltipTitle, "", ZO_SELECTED_TEXT:UnpackRGBA())
            if control.tooltipText ~= "" and control.tooltipText ~= nil then
                GameTooltip:AddLine(control.tooltipText, "", colorText:UnpackRGBA())
            end
            if control.thirdLine ~="" and control.thirdLine ~= nil then
                GameTooltip:AddLine(control.thirdLine, "", ZO_NORMAL_TEXT:UnpackRGB())
            end
        end

        if not control.animation then
            control.animation = ANIMATION_MANAGER:CreateTimelineFromVirtual("ShowOnMouseOverLabelAnimation", control:GetNamedChild("Highlight"))
        end
        control.animation:PlayForward()
    end

    -- Hook skills advisor and use this variable to refresh the abilityData on time one initialization. We don't want to reload any more after that.
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
        if LUIE.Effects.BarIdOverride[abilityId] then
            slotIcon = LUIE.Effects.BarIdOverride[abilityId]
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

    SetupSlotHandlers =
    {
        [ACTION_TYPE_ABILITY]       = SetupAbilitySlot,
        [ACTION_TYPE_ITEM]          = SetupItemSlot,
        [ACTION_TYPE_COLLECTIBLE]   = SetupCollectibleActionSlot,
        [ACTION_TYPE_QUEST_ITEM]    = SetupQuestItemActionSlot,
        [ACTION_TYPE_NOTHING]       = SetupEmptyActionSlot,
    }

    -- Hook to make Activation Highlight play indefinitely
    ActionButton.UpdateActivationHighlight = function(self)
        local slotnum = self:GetSlot()
        local slotType = GetSlotType(slotnum)
        local slotIsEmpty = (slotType == ACTION_TYPE_NOTHING)

        local showHighlight = not slotIsEmpty and HasActivationHighlight(slotnum) and not self.useFailure and not self.showingCooldown
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
        if IsSlotToggled(slotnum) == true or LUIE.Effects.IsAbilityActiveHighlight[abilityId] == true then
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
				local icon = (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].passiveIcon) and LUIE.Effects.EffectOverride[abilityId].passiveIcon or GetAbilityIcon(abilityId)
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

    -- HOOK SKILLS
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
                dialog.abilityName:SetText(GetAbilityName(id))

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

function LUIE.UpdateGuildData()
    local GuildsIndex = GetNumGuilds()
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
