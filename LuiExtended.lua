------------------
-- LUIE namespace
LUIE             = {}
LUIE.name        = "LuiExtended"
LUIE.author      = "ArtOfShred, psypanda, Upularity & SpellBuilder"
LUIE.version     = "5.1.1 BETA"
LUIE.components  = {}

-- Saved variables options
LUIE.SV          = nil
LUIE.SVVer       = 2
LUIE.SVName      = "LUIESV"

-- Default Settings
LUIE.D = {
    UnitFrames_Enabled          = true,
    InfoPanel_Enabled           = true,
    CombatInfo_Enabled          = true,
    SpellCastBuff_Enable        = true,
    ChatAnnouncements_Enable    = true,
    DamageMeter_Enable          = false,
    ChatUseSystem               = false,
    TimeStamp                   = false,
    TimeStampFormat             = "HH:m:s",
    StartupInfo                 = false,
    HideXPBar                   = false,
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
    ["Fontin Bold"]             = "/LuiExtended/media/fonts/fontin_sans_b.otf",
    ["Fontin Italic"]           = "/LuiExtended/media/fonts/fontin_sans_i.otf",
    ["Fontin Regular"]          = "/LuiExtended/media/fonts/fontin_sans_r.otf",
    ["Fontin SmallCaps"]        = "/LuiExtended/media/fonts/fontin_sans_sc.otf",
    ["Trajan Pro Bold"]         = "/LuiExtended/media/fonts/TrajanProBold.otf",
    ["Trajan Pro Regular"]      = "/LuiExtended/media/fonts/TrajanProRegular.otf",
    ["EnigmaBold"]              = [[/LuiExtended/media/fonts/EnigmaBold.ttf]],
    ["Adventure"]               = [[/LuiExtended/media/fonts/adventure.ttf]],
    ["Bazooka"]                 = [[/LuiExtended/media/fonts/bazooka.ttf]],
    ["Cooline"]                 = [[/LuiExtended/media/fonts/cooline.ttf]],
    ["Diogenes"]                = [[/LuiExtended/media/fonts/diogenes.ttf]],
    ["Ginko"]                   = [[/LuiExtended/media/fonts/ginko.ttf]],
    ["Heroic"]                  = [[/LuiExtended/media/fonts/heroic.ttf]],
    ["Metamorphous"]            = [[/LuiExtended/media/fonts/metamorphous.otf]],
    ["Porky"]                   = [[/LuiExtended/media/fonts/porky.ttf]],
    ["Roboto Bold"]             = [[/LuiExtended/media/fonts/Roboto-Bold.ttf]],
    ["Roboto Bold Italic"]      = [[/LuiExtended/media/fonts/Roboto-BoldItalic.ttf]],
    ["Talisman"]                = [[/LuiExtended/media/fonts/talisman.ttf]],
    ["Transformers"]            = [[/LuiExtended/media/fonts/transformers.ttf]],
    ["Yellowjacket"]            = [[/LuiExtended/media/fonts/yellowjacket.ttf]],
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
}

-- Load saved settings
local function LUIE_LoadSavedVars()
    -- Addon options
    LUIE.SV = ZO_SavedVars:NewAccountWide(LUIE.SVName, LUIE.SVVer, nil, LUIE.D)
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
end

-- Startup Info string
local function LUIE_LoadScreen()
    EVENT_MANAGER:UnregisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED)

    if not LUIE.SV.StartupInfo then
        LUIE.PrintToChat(string.format("|cFEFEFE%s by|r |c00C000%s|r |cFEFEFEv%s|r", LUIE.name, LUIE.author, LUIE.version))
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
    EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_PLAYER_ACTIVATED, LUIE_LoadScreen)
    EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_ACTION_LAYER_POPPED, LUIE_ToggleVisibility)
    EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_ACTION_LAYER_PUSHED, LUIE_ToggleVisibility)
    -- Events registed for Slash Commands
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SOCIAL_ERROR, LUIE.SocialError)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_JUMP_FAILED, LUIE.JumpFailed)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD, LUIE.GuildAddedSelf)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD, LUIE.GuildRemovedSelf)
end

-- LuiExtended Initialization
local function LUIE_OnAddOnLoaded(eventCode, addonName)
    -- Only initialize our own addon
    if LUIE.name ~= addonName then
        return
    end
    -- Once we know it's ours, lets unregister the event listener
    EVENT_MANAGER:UnregisterForEvent(addonName, eventCode)

    -- Load additional media from LMP and other addons
    LUIE_LoadMedia()

    -- Load saved variables
    LUIE_LoadSavedVars()

    -- Initialize this addon modules according to user preferences
    LUIE.ChatAnnouncements.Initialize( LUIE.SV.ChatAnnouncements_Enable )
    LUIE.CombatInfo.Initialize( LUIE.SV.CombatInfo_Enabled )
    LUIE.InfoPanel.Initialize( LUIE.SV.InfoPanel_Enabled )
    LUIE.UnitFrames.Initialize( LUIE.SV.UnitFrames_Enabled )
    LUIE.SpellCastBuffs.Initialize( LUIE.SV.SpellCastBuff_Enable )

    -- Create settings menu for our addon
    LUIE_CreateSettings()

    -- Register global event listeners
    LUIE_RegisterEvents()

    -- Keep track of guilds for the /ginvite commands
    LUIE.InitGuildData()
    
    local zos_IconSetup = SKILLS_WINDOW.SetupAbilityEntry
    SKILLS_WINDOW.SetupAbilityEntry = function(self, ability, data)
        zos_IconSetup(self, ability, data)
        
        local abilityId = GetSkillAbilityId(data.skillType, data.lineIndex, data.abilityIndex)
        local slot = ability.slot
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then
            slot.icon:SetTexture(LUIE.Effects.EffectOverride[abilityId].icon)
            slot.iconFile = LUIE.Effects.EffectOverride[abilityId].icon
        end
    end

    local zos_GetSkillAbilityInfo = GetSkillAbilityInfo
    GetSkillAbilityInfo = function(skillType, skillIndex, abilityIndex)
        local name, texture, earnedRank, passive, ultimate, purchased, progressionIndex = zos_GetSkillAbilityInfo(skillType, skillIndex, abilityIndex)
        local abilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then
            texture = LUIE.Effects.EffectOverride[abilityId].icon
        end
        return name, texture, earnedRank, passive, ultimate, purchased, progressionIndex
    end

    local zos_GetSkillAbilityNextUpgradeInfo = GetSkillAbilityNextUpgradeInfo
    GetSkillAbilityNextUpgradeInfo = function(skillType, skillIndex, abilityIndex)
        local name, texture, earnedRank = zos_GetSkillAbilityNextUpgradeInfo(skillType, skillIndex, abilityIndex)
        local abilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then
            texture = LUIE.Effects.EffectOverride[abilityId].icon
        end
        return name, texture, earnedRank
    end
 
    local zos_GetUnitBuffInfo = GetUnitBuffInfo
    GetUnitBuffInfo = function(unitTag, buffIndex)
        local buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer = zos_GetUnitBuffInfo(unitTag, buffIndex)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then buffName = LUIE.Effects.EffectOverride[abilityId].name end
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then iconFile = LUIE.Effects.EffectOverride[abilityId].icon end
    
        return buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId, canClickOff, castByPlayer
    
    end
    
    -- Death Recap enhancements:
    
    local zos_GetKillingAttackerInfo = GetKillingAttackerInfo
    local zos_GetKillingAttackInfo = GetKillingAttackInfo
    
    GetKillingAttackerInfo = function(index)
        local attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName = zos_GetKillingAttackerInfo(index)
        local attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits = zos_GetKillingAttackInfo(index)
       -- if LUIE.DeathRecap.DeathRecapSourceOverride[attackerRawName] then
       --     if LUIE.DeathRecap.DeathRecapSourceOverride[attackerRawName][attackName] then attackerRawName = LUIE.DeathRecap.DeathRecapSourceOverride[attackerRawName][attackName] end
       -- end
       
       -- Override source name (Non-player)
        if LUIE.DeathRecap.DeathRecapInfoOverride[attackName] and LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName] and not isPlayer then
            local source
            if LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName].source then source = LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName].source end
            if source then attackerRawName = source end
        end
        
        -- Override pet name (Player)
        if (minionName ~= "" and minionName ~= nil) and LUIE.DeathRecap.DeathRecapPlayerPet[minionName] and isPlayer then
            if LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName] then
                local source
                if LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName].source then source = LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName].source end
                if source then minionName = source end
            end
        end
        
        return attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName
    end
 
    GetKillingAttackInfo = function(index)
        local attackerRawName, attackerChampionPoints, attackerLevel, attackerAvARank, isPlayer, isBoss, alliance, minionName, attackerDisplayName = zos_GetKillingAttackerInfo(index)
        local attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits = zos_GetKillingAttackInfo(index)
        
        local name
        local icon
        attackerRawName = zo_strformat("<<t:1>>", attackerRawName)
        minionName = zo_strformat("<<t:1>>", minionName)
        
        -- Player pet ability overrides
        if (minionName ~= "" and minionName ~= nil) and LUIE.DeathRecap.DeathRecapPlayerPet[minionName] and isPlayer then
            if LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName] then
                if LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName].name then name = LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName].name end
                if LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName].icon then icon = LUIE.DeathRecap.DeathRecapPlayerPet[minionName][attackName].icon end
                if name then attackName = name end
                if icon then attackIcon = icon end
                return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
            end
        end
        
        -- Player ability overrides (Advanced - checks name + icon)
        if LUIE.DeathRecap.DeathRecapPlayerAdvanced[attackName] and isPlayer then
            if LUIE.DeathRecap.DeathRecapPlayerAdvanced[attackName][attackIcon] then
                if LUIE.DeathRecap.DeathRecapPlayerAdvanced[attackName][attackIcon].name then name = LUIE.DeathRecap.DeathRecapPlayerAdvanced[attackName][attackIcon].name end
                if LUIE.DeathRecap.DeathRecapPlayerAdvanced[attackName][attackIcon].icon then icon = LUIE.DeathRecap.DeathRecapPlayerAdvanced[attackName][attackIcon].icon end
                if name then attackName = name end
                if icon then attackIcon = icon end
                return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
            end
        end
        
        -- Player ability overrides (Basic - just checks name)
        if LUIE.DeathRecap.DeathRecapPlayerBasic[attackName] and isPlayer then
            if LUIE.DeathRecap.DeathRecapPlayerBasic[attackName].name then name = LUIE.DeathRecap.DeathRecapPlayerBasic[attackName].name end
            if LUIE.DeathRecap.DeathRecapPlayerBasic[attackName].icon then icon = LUIE.DeathRecap.DeathRecapPlayerBasic[attackName].icon end
            if name then attackName = name end
            if icon then attackIcon = icon end
            return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
        end
        
        -- A few overrides require source, attackname, and ICON as well, this handles those
        if LUIE.DeathRecap.DeathRecapTripleOverride[attackName] and not isPlayer then
            if LUIE.DeathRecap.DeathRecapTripleOverride[attackName][attackerRawName] then
                if LUIE.DeathRecap.DeathRecapTripleOverride[attackName][attackerRawName][attackIcon] then
                    if LUIE.DeathRecap.DeathRecapTripleOverride[attackName][attackerRawName][attackIcon].name then name = LUIE.DeathRecap.DeathRecapTripleOverride[attackName][attackerRawName][attackIcon].name end
                    if LUIE.DeathRecap.DeathRecapTripleOverride[attackName][attackerRawName][attackIcon].icon then icon = LUIE.DeathRecap.DeathRecapTripleOverride[attackName][attackerRawName][attackIcon].icon end
                    if name then attackName = name end
                    if icon then attackIcon = icon end
                    return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
                end
            elseif LUIE.DeathRecap.DeathRecapTripleOverride[attackName][minionName] then
                if LUIE.DeathRecap.DeathRecapTripleOverride[attackName][minionName][attackIcon] then
                    if LUIE.DeathRecap.DeathRecapTripleOverride[attackName][minionName][attackIcon].name then name = LUIE.DeathRecap.DeathRecapTripleOverride[attackName][minionName][attackIcon].name end
                    if LUIE.DeathRecap.DeathRecapTripleOverride[attackName][minionName][attackIcon].icon then icon = LUIE.DeathRecap.DeathRecapTripleOverride[attackName][minionName][attackIcon].icon end
                    if name then attackName = name end
                    if icon then attackIcon = icon end
                    return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
                end
            end
        end
        
        -- Advanced override considering source
        if LUIE.DeathRecap.DeathRecapInfoOverride[attackName] and not isPlayer then
            if LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName] then
                if LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName].name then name = LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName].name end
                if LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName].icon then icon = LUIE.DeathRecap.DeathRecapInfoOverride[attackName][attackerRawName].icon end
                if name then attackName = name end
                if icon then attackIcon = icon end
                return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
            elseif LUIE.DeathRecap.DeathRecapInfoOverride[attackName][minionName] then
                if LUIE.DeathRecap.DeathRecapInfoOverride[attackName][minionName].name then name = LUIE.DeathRecap.DeathRecapInfoOverride[attackName][minionName].name end
                if LUIE.DeathRecap.DeathRecapInfoOverride[attackName][minionName].icon then icon = LUIE.DeathRecap.DeathRecapInfoOverride[attackName][minionName].icon end
                if name then attackName = name end
                if icon then attackIcon = icon end
                return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
            end  
        end
        
        -- Advanced override considering icon
        if LUIE.DeathRecap.DeathRecapIconOverride[attackName] and not isPlayer then
            if LUIE.DeathRecap.DeathRecapIconOverride[attackName][attackIcon] then
                if LUIE.DeathRecap.DeathRecapIconOverride[attackName][attackIcon].name then name = LUIE.DeathRecap.DeathRecapIconOverride[attackName][attackIcon].name end
                if LUIE.DeathRecap.DeathRecapIconOverride[attackName][attackIcon].icon then icon = LUIE.DeathRecap.DeathRecapIconOverride[attackName][attackIcon].icon end
                if name then attackName = name end
                if icon then attackIcon = icon end
                return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
            end  
        end
        
        -- Basic override by name
        if LUIE.DeathRecap.DeathRecapBasicOverride[attackName] and not isPlayer then
            if LUIE.DeathRecap.DeathRecapBasicOverride[attackName].name then name = LUIE.DeathRecap.DeathRecapBasicOverride[attackName].name end
            if LUIE.DeathRecap.DeathRecapBasicOverride[attackName].icon then icon = LUIE.DeathRecap.DeathRecapBasicOverride[attackName].icon end
            if name then attackName = name end
            if icon then attackIcon = icon end
            return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
        end
        
        -- Override for self inflicted damage
        if LUIE.DeathRecap.NoSourceOverride[attackName] and attackerRawName == "" then
            if LUIE.DeathRecap.NoSourceOverride[attackName][attackIcon] then
                if LUIE.DeathRecap.NoSourceOverride[attackName][attackIcon].name then name = LUIE.DeathRecap.NoSourceOverride[attackName][attackIcon].name end
                if LUIE.DeathRecap.NoSourceOverride[attackName][attackIcon].icon then icon = LUIE.DeathRecap.NoSourceOverride[attackName][attackIcon].icon end
                if name then attackName = name end
                if icon then attackIcon = icon end
                return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
            end
        end
        
        return attackName, attackDamage, attackIcon, wasKillingBlow, castTimeAgoMS, durationMS, numAttackHits
    end
    
    -- HOOK SUPPORT FOR OTHER ADDONS (ICON)
    LUIE.GetAbilityIcon = GetAbilityIcon
    local zos_GetAbilityIcon = GetAbilityIcon
    GetAbilityIcon = function(abilityId)
        local icon = zos_GetAbilityIcon(abilityId)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].icon then icon = LUIE.Effects.EffectOverride[abilityId].icon end
        return(icon)
    end
    
    -- HOOK SUPPORT FOR OTHER ADDONS (NAME)
    LUIE.GetAbilityName = GetAbilityName
    local zos_GetAbilityName = GetAbilityName
    GetAbilityName = function(abilityId)
        local abilityName = zos_GetAbilityName(abilityId)
        if LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].name then abilityName = LUIE.Effects.EffectOverride[abilityId].name end
        return(abilityName)
    end
    
    -- HOOK SUPPORT FOR OTHER ADDONS (ARTIFICIAL EFFECT IDS)
    LUIE.GetArtificialEffectInfo = GetArtificialEffectInfo
    local zos_GetArtificialEffectInfo = GetArtificialEffectInfo
    GetArtificialEffectInfo = function(artificialEffectId)
        local displayName, iconFile, effectType, sortOrder, timeStarted, timeEnding = zos_GetArtificialEffectInfo(artificialEffectId)
        if LUIE.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Effects.ArtificialEffectOverride[artificialEffectId].icon then iconFile = LUIE.Effects.ArtificialEffectOverride[artificialEffectId].icon end
        if LUIE.Effects.ArtificialEffectOverride[artificialEffectId] and LUIE.Effects.ArtificialEffectOverride[artificialEffectId].name then displayName = LUIE.Effects.ArtificialEffectOverride[artificialEffectId].name end
        return displayName, iconFile, effectType, sortOrder, timeStarted, timeEnding
    end
    
    local zos_GetSynergyInfo = GetSynergyInfo
    GetSynergyInfo = function()
        local synergyName, iconFilename = zos_GetSynergyInfo()
        if LUIE.Effects.SynergyNameOverride[synergyName] then iconFilename = LUIE.Effects.SynergyNameOverride[synergyName] end
        return synergyName, iconFilename
    end
    
    local function EffectsRowComparator(left, right)
        local leftIsArtificial, rightIsArtificial = left.isArtificial, right.isArtificial
        if leftIsArtificial ~= rightIsArtificial then
            --Artificial before real
            return leftIsArtificial
        else
            if leftIsArtificial then
                --Both artificial, use def defined sort order
                return left.sortOrder < right.sortOrder
            else
                --Both real, use time
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
                    
                    if effectId == 0 then
                        displayName = "Dueling"
                        iconFile = "/esoui/art/icons/achievement_dueling_002.dds"
                    end
                        
                    
                    local effectsRow = effectsRowPool:AcquireObject()
                    effectsRow.name:SetText(zo_strformat(SI_ABILITY_TOOLTIP_NAME, displayName))
                    effectsRow.icon:SetTexture(iconFile)
                    effectsRow.effectType = effectType
                    effectsRow.time:SetHidden(true)
                    effectsRow.sortOrder = sortOrder
                    effectsRow.tooltipTitle = displayName
                    effectsRow.effectId = effectId
                    effectsRow.isArtificial = true

                    table.insert(effectsRows, effectsRow)
                        
                end

                for i = 1, GetNumBuffs("player") do
                    local buffName, startTime, endTime, buffSlot, stackCount, iconFile, buffType, effectType, abilityType, statusEffectType, abilityId = GetUnitBuffInfo("player", i)
                    
                    local tooltipText = GetAbilityEffectDescription(buffSlot)
                    --if LUIE.Effects.TooltipOverride[abilityId] then tooltipText = LUIE.Effects.TooltipOverride[abilityId] end
                    -- Have to trim trailing spaces on the end of tooltips
                    if tooltipText ~= "" then tooltipText = string.match(tooltipText, ".*%S") end
                    if buffSlot > 0 and buffName ~= "" and not (LUIE.Effects.EffectOverride[abilityId] and LUIE.Effects.EffectOverride[abilityId].hide) then
                        local effectsRow = effectsRowPool:AcquireObject()
                        effectsRow.name:SetText(zo_strformat(SI_ABILITY_TOOLTIP_NAME, buffName))
                        effectsRow.icon:SetTexture(iconFile)
                        effectsRow.tooltipTitle = buffName
                        effectsRow.tooltipText = (tooltipText)
                        local duration = startTime - endTime
                        effectsRow.time:SetHidden(duration == 0)
                        effectsRow.time.endTime = endTime
                        effectsRow.effectType = effectType
                        effectsRow.buffSlot = buffSlot
                        effectsRow.isArtificial = false

                        table.insert(effectsRows, effectsRow)
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
            if control.tooltipText ~= "" then
                GameTooltip:AddLine(control.tooltipText, "", ZO_NORMAL_TEXT:UnpackRGBA())
            end
        end

        if not control.animation then
            control.animation = ANIMATION_MANAGER:CreateTimelineFromVirtual("ShowOnMouseOverLabelAnimation", control:GetNamedChild("Highlight"))
        end
        control.animation:PlayForward()
    end
    
end

local delayBuffer       = {}
local playerName        = GetUnitName("player")
local playerDisplayName = GetUnitDisplayName("player")
local g_regroupStacks   = {}
local PendingRegroup    = false

-- Return a formatted time
-- Stolen from pChat, thanks @Ayantir
function LUIE.CreateTimestamp(timeStr, formatStr)
    local formatStr = formatStr or LUIE.SV.TimeStampFormat

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
        msg = string.format("|c8F8F8F[%s]|r %s", LUIE.CreateTimestamp(timestring), msg)
    end
    return msg
end

-- Easy Print to Chat
function LUIE.PrintToChat(msg)
    if LUIE.SV.ChatUseSystem and CHAT_SYSTEM.primaryContainer then
        local msg = LUIE.FormatMessage(msg or "no message", LUIE.SV.TimeStamp)
        -- Post as a System message so that it can appear in multiple tabs.
        CHAT_SYSTEM.primaryContainer:OnChatEvent(nil, msg, CHAT_CATEGORY_SYSTEM)
    else
        -- Post as a normal message
        CHAT_SYSTEM:AddMessage(msg)
    end
end

-- Delay Buffer
function LUIE.DelayBuffer(key, buffer, currentTime)
    if key == nil then
        return
    end

    local buffer = buffer or 10
    local now    = currentTime or GetFrameTimeMilliseconds()

    if delayBuffer[key] == nil then
        delayBuffer[key] = now
        return true -- For first call of DelayBuffer we should return true
    end
    local eval = ( now - delayBuffer[key] ) >= buffer
    if eval then
        delayBuffer[key] = now
    end
    return eval
end

-- Returns a formatted number with commas
-- Function no comma to be added in a later date.
function LUIE.CommaValue(number, shorten, noncomma)
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

        -- If we could not conver even to "G", return full number with commas
        if value >= 1000 then
            value = LUIE.CommaValue(number)
        elseif value >= 100 or suffix == nil then
            value = string.format("%d", value)
        elseif value >= 10 then
            value = string.format("%.1f", value)
        else
            value = string.format("%.2f", value)
        end

        if suffix ~= nil then
            value = value .. suffix
        end

        return value
    end

    local number = tostring(number)
    -- No shortening was done, so print number with commas
    local left,num,right = string.match(number,"^([^%d]*%d)(%d*)(.-)$")
    return left .. (num:reverse():gsub("(%d%d%d)","%1,"):reverse()) .. right
end

function LUIE.SlashHome()
    local primaryHouse = GetHousingPrimaryHouse()

    if IsUnitInCombat("player") then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT)))
        return
    end

    if IsPlayerInAvAWorld() then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA)))
        return
    end

    if primaryHouse == 0 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME)))
    else
        RequestJumpToHouse(primaryHouse)
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG))
    end

end

function LUIE.SlashRegroup()
    local groupSize = GetGroupSize()
    -- Check for pending regroup
    if PendingRegroup then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_PENDING))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_PENDING)))
        return
    end
    -- Check to make sure player is in a group
    if groupSize <= 1 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTINGRP))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTINGRP)))
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTLEADER))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTLEADER)))
        return
    end
    -- Check to make sure we're not in LFG
    if IsInLFGGroup() then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_LFGACTIVITY))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_REGROUP_FAILED_LFGACTIVITY)))
        return
    end

    PendingRegroup = true
    
    local flagOffline = 0
    local index = 1
    for i = 1, groupSize do
        -- We need to index player here as well
        local memberTag = GetGroupUnitTagByIndex(i)
        if IsUnitOnline(memberTag) then
            local groupMemberString
            local groupMemberName = GetUnitName(memberTag)
            local groupMemberAccountName = GetUnitDisplayName(memberTag)
            local characterNameLink = ZO_LinkHandler_CreateCharacterLink(groupMemberName)
            local displayNameLink = ZO_LinkHandler_CreateDisplayNameLink(groupMemberAccountName)
            local displayBothString = ( zo_strformat("<<1>><<2>>", groupMemberName, groupMemberAccountName) )
            local displayBoth = ZO_LinkHandler_CreateLink(displayBothString, nil, DISPLAY_NAME_LINK_TYPE, groupMemberAccountName)
            if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 1 then
                memberLink = displayNameLink
            end
            if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 2 then
                memberLink = characterNameLink
            end
            if LUIE.ChatAnnouncements.SV.ChatPlayerDisplayOptions == 3 then
                memberLink = displayBoth
            end
            -- Place inside counter incremented index, this way if we have offline members in the group we still index everything in an ordered integer list.
            g_regroupStacks[index] = { memberLink = memberLink, memberName = groupMemberName }
            index = index + 1
        else
            flagOffline = flagOffline + 1
        end
    end
    
    -- Reinvite the group after 5 seconds (give the group interface time to update on server and client end for all group members)
    -- If the stack counter was less than 1 (just the player eligible for reinvite then regroup won't invite any members.)
    if flagOffline > 0 then 
        if #g_regroupStacks > 1 then
            LUIE.PrintToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_SOME_OFF_MSG), flagOffline, flagOffline, flagOffline))
            GroupDisband()
            zo_callLater(LUIE.RegroupInvite, 5000)
        else
            LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_ALL_OFF_MSG))
            PendingRegroup = false -- Allow Regroup command to be used again
            g_regroupStacks = {} -- Allow index to be used again.
        end
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_SAVED_MSG))
        GroupDisband()
        zo_callLater(LUIE.RegroupInvite, 5000)
    end
end

function LUIE.RegroupInvite()
    LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_MSG))
    for i = 1, #g_regroupStacks do
        local member = g_regroupStacks[i]
        -- Don't invite self and offline members
        if member.memberName ~= playerName then
            GroupInviteByName(member.memberName)
            LUIE.PrintToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG), member.memberLink))
        end
    end

    PendingRegroup = false -- Allow Regroup command to be used again
    g_regroupStacks = {} -- Allow index to be used again.
end

function LUIE.SlashDisband()
    -- Check to make sure player is in a group
    if GetGroupSize() <= 1 then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP)))
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER)))
        return
    end
    -- Check to make sure we're not in LFG
    local isLFG = IsInLFGGroup()
    if isLFG then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_LFG_ACTIVITY))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_DISBAND_FAILED_LFG_ACTIVITY)))
        return
    end

    GroupDisband()
end

function LUIE.SlashGroupLeave()
    GroupLeave()
    local groupSize = GetGroupSize()
    if groupSize <= 1 then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
        return
    end
end

-- If the player uses /kick with no option then we need to play the kick emote, otherwise handle everything with the SlashGroupKick function.
function LUIE.SlashKick(option)

    if option == "" then
        PlayEmoteByIndex(109)
    else
        LUIE.SlashGroupKick(option)
    end
end

function LUIE.SlashGroupKick(option)
    -- Rather then error out, let the player use /kick and /remove as a substitute for /votekick and /voteremove in LFG
    if IsInLFGGroup() then
        if option == "" then
            LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME))
            ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME)))
            return
        else
            LUIE.SlashVoteKick(option)
            return
        end
    end

    -- Check to make sure player is in a group
    if GetGroupSize() <= 1 then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_IN_A_GROUP)))
        return
    end
    -- Check to make sure player is the leader
    if not IsUnitGroupLeader("player") then
        LUIE.PrintToChat(GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_GROUP_NOTIFICATION_YOU_ARE_NOT_THE_LEADER)))
        return
    end

    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME)))
        return
    end

    local g_partyKick = { }
    local kickedMemberName
    local kickedAccountName
    local compareName = string.lower(option)
    local comparePlayerName = string.lower(playerName)
    local comparePlayerAccount = string.lower(playerAccountName)
    local unitToKick

    for i = 1,24 do
        local memberTag = GetGroupUnitTagByIndex(i)
        -- Once we reach a nil value (aka no party member there, stop the loop)
        if memberTag == nil then
            break
        end
        kickedMemberName = string.lower(GetUnitName(memberTag))
        kickedAccountName = string.lower(GetUnitDisplayName(memberTag))
        g_partyKick[i] = { memberTag=memberTag, kickedMemberName=kickedMemberName, kickedAccountName=kickedAccountName }
    end

    -- Iterate through UnitTags to get the member who just joined
    for i = 1,#g_partyKick do
        local kickcompare = g_partyKick[i]
        if kickcompare.kickedMemberName == compareName or kickcompare.kickedAccountName == compareName then
            if kickcompare.kickedMemberName == comparePlayerName or kickcompare.kickedAccountName == comparePlayerAccount then
                GroupLeave()
            else
                unitToKick = kickcompare.memberTag
                GroupKick(unitToKick)
            end
            return
        end
    end

    LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME))
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

function LUIE.SocialError(eventCode, reason)
    if reason ~= 1 and reason ~= 32 then
        LUIE.PrintToChat(zo_strformat(GetString("SI_SOCIALACTIONRESULT", reason)))
    elseif reason == 1 or reason == 32 then
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (zo_strformat(GetString("SI_SOCIALACTIONRESULT", reason))))
    end
end

function LUIE.JumpFailed(eventCode, reason)
    LUIE.PrintToChat(GetString("SI_JUMPRESULT", reason))
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
    if LUIE.ChatAnnouncements.SV.MiscGuild then
        LUIE.ChatAnnouncements.GuildRemovedSelf(eventCode, guildId, guildName)
    end
    GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1,GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = {id=id, name=name, guildAlliance=guildAlliance}
    end
end

function LUIE.SlashGuildInvite(option)
    -- If no input was entered, display an error and end.
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV)))
        
        return
    end

    -- Parse input
    local options = {}
    local searchResult = { string.match(option,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
        if (v ~= nil and v ~= "") then
            options[i] = v
        end
    end

    local guildnumber = options[1]
    local name = options[2]

    -- If no name was entered, display an error and end.
    if name == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV)))
        return
    end

    if guildnumber == "1" and LUIE.GuildIndexData[1] then
        guildnumber = LUIE.GuildIndexData[1].id
    elseif guildnumber == "2" and LUIE.GuildIndexData[2] then
        guildnumber = LUIE.GuildIndexData[2].id
    elseif guildnumber == "3" and LUIE.GuildIndexData[3] then
        guildnumber = LUIE.GuildIndexData[3].id
    elseif guildnumber == "4" and LUIE.GuildIndexData[4] then
        guildnumber = LUIE.GuildIndexData[4].id
    elseif guildnumber == "5" and LUIE.GuildIndexData[5] then
        guildnumber = LUIE.GuildIndexData[5].id
    else -- If we enter anything outside of the range of 1-5, display an error and end.
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_INV))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_INV)))
        return
    end

    -- If we try to invite a player to a guild we don't have display an error and end.
    if guildnumber == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_INV))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_INV)))
        return
    end

    GuildInvite(guildnumber, name)

    local guildName = GetGuildName(guildnumber)
    local allianceIconSize = 16
    local guildAlliance = GetGuildAlliance(guildnumber)
    local guildNameAlliance = LUIE.ChatAnnouncements.SV.MiscGuildIcon
            and zo_iconTextFormat(GetAllianceBannerIcon(guildAlliance), allianceIconSize, allianceIconSize, ZO_SELECTED_TEXT:Colorize(guildName))
            or (ZO_SELECTED_TEXT:Colorize(guildName))

    LUIE.PrintToChat(zo_strformat(GetString(SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE), name, guildNameAlliance))
end

function LUIE.SlashGuildQuit(guildnumber)
    if guildnumber == "1" and LUIE.GuildIndexData[1] then
        guildnumber = LUIE.GuildIndexData[1].id
    elseif guildnumber == "2" and LUIE.GuildIndexData[2] then
        guildnumber = LUIE.GuildIndexData[2].id
    elseif guildnumber == "3" and LUIE.GuildIndexData[3] then
        guildnumber = LUIE.GuildIndexData[3].id
    elseif guildnumber == "4" and LUIE.GuildIndexData[4] then
        guildnumber = LUIE.GuildIndexData[4].id
    elseif guildnumber == "5" and LUIE.GuildIndexData[5] then
        guildnumber = LUIE.GuildIndexData[5].id
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE)))
        
        return
    end

    -- If we try to leave a guild we don't have display an error and end.
    if guildnumber == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE)))
        return
    end

    -- If neither of the above errors were triggered, leave the guild number.
    GuildLeave(guildnumber)
end

function LUIE.SlashGuildKick(option)
    -- If no input was entered, display an error and end.
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK)))
        return
    end

    -- Parse input
    local options = {}
    local searchResult = { string.match(option,"^(%S*)%s*(.-)$") }
    for i,v in pairs(searchResult) do
        if (v ~= nil and v ~= "") then
            options[i] = v
        end
    end

    local guildnumber = options[1]
    local name = options[2]

    -- If no name was entered, display an error and end.
    if name == nil then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK)))
        return
    end

    if guildnumber == "1" and LUIE.GuildIndexData[1] then
        guildnumber = LUIE.GuildIndexData[1].id
    elseif guildnumber == "2" and LUIE.GuildIndexData[2] then
        guildnumber = LUIE.GuildIndexData[2].id
    elseif guildnumber == "3" and LUIE.GuildIndexData[3] then
        guildnumber = LUIE.GuildIndexData[3].id
    elseif guildnumber == "4" and LUIE.GuildIndexData[4] then
        guildnumber = LUIE.GuildIndexData[4].id
    elseif guildnumber == "5" and LUIE.GuildIndexData[5] then
        guildnumber = LUIE.GuildIndexData[5].id
    else -- If we enter anything outside of the range of 1-5, display an error and end.
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_KICK))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_KICK)))
        return
    end

    -- If we try to invite a player to a guild we don't have display an error and end.
    if guildnumber == nil then
        LUIE.PrintToChat (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_KICK))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_KICK)))
        return
    end
    
    if not DoesPlayerHaveGuildPermission (guildnumber, GUILD_PERMISSION_REMOVE) then
        LUIE.PrintToChat (GetString(SI_SOCIALACTIONRESULT18))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_SOCIALACTIONRESULT18)))
        return
    end

    -- Index guild members so we can use character name as a kick option
    local guildNumbers = GetNumGuildMembers(guildnumber)
    local compareChar = string.lower(name)

    g_guildNamesTable = { }

    for i = 1,guildNumbers do
        local displayName = GetGuildMemberInfo(guildnumber, i)
        local _, characterName = GetGuildMemberCharacterInfo(guildnumber, i)

        local compareDisplay = string.lower(displayName)
        local compareCharacter = string.lower(characterName)

        compareCharacter = string.gsub(compareCharacter,"%^%a+","")

        g_guildNamesTable[i] = { displayName=displayName, characterName=characterName, compareDisplay=compareDisplay, compareCharacter=compareCharacter}
        --d(compareDisplay .. compareCharacter)
        --d("comparing vs... " .. compareChar)
    end

    local finalName = ""

    for i = 1, #g_guildNamesTable do
        local comparing = g_guildNamesTable[i]
        if comparing.compareDisplay == compareChar or comparing.compareCharacter == compareChar then
            finalName = comparing.displayName
            break
        end
    end

    if finalName ~= "" then
        GuildRemove(guildnumber, finalName)
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDNM_KICK))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDNM_KICK)))
    end
end

function LUIE.SlashFriend(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME)))
        return
    end
    LUIE.PrintToChat(zo_strformat(GetString(SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG), option))
    RequestFriend(option)
end

function LUIE.SlashIgnore(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME)))
        return
    end
    if IsIgnored(option) then -- Only lists account names, unfortunately
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE)))
        return
    end
    AddIgnore(option)
end

function LUIE.SlashRemoveFriend(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME)))
        return
    end

    local compareChar = string.lower(option)

    local friends = GetNumFriends()
    local g_friendIndex = {}
    for i = 1,friends do
        local displayName = GetFriendInfo(i)
        local _, characterName = GetFriendCharacterInfo(i)
        local compareDisplay = string.lower(displayName)
        local compareCharacter = string.lower(characterName)
        compareCharacter = string.gsub(compareCharacter,"%^%a+","")
        g_friendIndex[i] = {displayName=displayName, characterName=characterName, compareDisplay=compareDisplay, compareCharacter=compareCharacter}
    end

    local finalName = ""

    for i = 1, #g_friendIndex do
        local comparing = g_friendIndex[i]
        if comparing.compareDisplay == compareChar or comparing.compareCharacter == compareChar then
            finalName = comparing.displayName
            break
        end
    end

    if finalName ~= "" then
        RemoveFriend(finalName)
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME)))
    end
end

function LUIE.SlashRemoveIgnore(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE)))
        return
    end

    local compareChar = string.lower(option)

    local ignore = GetNumIgnored()
    local g_ignoreIndex = {}
    for i = 1,ignore do
        local displayName = GetIgnoredInfo(i)
        displayName = string.lower(displayName)
        g_ignoreIndex[i] = {displayName=displayName}
    end

    local finalName = ""

    for i = 1,#g_ignoreIndex do
        local comparing = g_ignoreIndex[i]
        if comparing.displayName == compareChar then
            finalName = comparing.displayName
            break
        end
    end

    if finalName ~= "" then
        RemoveIgnore(option)
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE)))
    end
end

function LUIE.SlashTrade(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME)))
        return
    end

    TradeInviteByName(option)
end

function LUIE.SlashVoteKick(option)
    -- Check to make sure player is in a group
    if GetGroupSize() <= 1 then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFG))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFG)))
        return
    end

    -- Check to make sure we're not in LFG
    if not IsInLFGGroup() then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFG))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFG)))
        return
    end

    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NONAME)))
        return
    end

    local g_partyKick = { }
    local kickedMemberName
    local kickedAccountName
    local compareName = string.lower(option)
    local comparePlayerName = string.lower(playerName)
    local comparePlayerAccount = string.lower(playerAccountName)
    local unitToKick = ""

    for i = 1,24 do
        local memberTag = GetGroupUnitTagByIndex(i)
        -- Once we reach a nil value (aka no party member there, stop the loop)
        if memberTag == nil then
            break
        end
        kickedMemberName = string.lower(GetUnitName(memberTag))
        kickedAccountName = string.lower(GetUnitDisplayName(memberTag))
        g_partyKick[i] = { memberTag=memberTag, kickedMemberName=kickedMemberName, kickedAccountName=kickedAccountName }
    end

    -- Iterate through UnitTags to get the member who just joined
    for i = 1,#g_partyKick do
        local kickcompare = g_partyKick[i]
        if kickcompare.kickedMemberName == compareName or kickcompare.kickedAccountName == compareName then
            if kickcompare.kickedMemberName == comparePlayerName or kickcompare.kickedAccountName == comparePlayerAccount then
                unitToKick = kickcompare.memberTag
                break
            else
                unitToKick = kickcompare.memberTag
                break
            end
        end
    end

    BeginGroupElection(GROUP_ELECTION_TYPE_KICK_MEMBER, ZO_GROUP_ELECTION_DESCRIPTORS.NONE, unitToKick)
end

function LUIE.SlashCampaignQ(option)
    if option == "" then
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGNQ_FAILED_NONAME))
        ZO_Alert(UI_ALERT_CATEGORY_ERROR, SOUNDS.GENERAL_ALERT_ERROR, (GetString(SI_LUIE_SLASHCMDS_CAMPAIGNQ_FAILED_NONAME)))
        return
    end
    --QueueForCampaign
    -- 80 = Sotha Sil
    -- 81 = Vivec
    -- 82 = Kyne
    -- 83 = Shor
    if option == "sotha" then
        LUIE.PrintToChat("Queing for Sotha Sil...")
        QueueForCampaign( 80 )
    elseif option == "vivec" then
        LUIE.PrintToChat("Queing for Vivec...")
        QueueForCampaign( 81 ) 
    elseif option == "shor" then
        LUIE.PrintToChat("Queing for Shor...")
        QueueForCampaign( 83 ) 
    elseif option == "kyne" then
        -- TODO: Check char lvl, if above 50 print error cant join
        LUIE.PrintToChat("Queing for Kyne...")
        QueueForCampaign( 82 )
    else
        LUIE.PrintToChat(GetString(SI_LUIE_SLASHCMDS_CAMPAIGNQ_FAILED_WRONCAMPAIGN))
    end
end

-- Slash Commands
-- Safe commands
SLASH_COMMANDS["/regroup"]      = LUIE.SlashRegroup
SLASH_COMMANDS["/disband"]      = LUIE.SlashDisband
SLASH_COMMANDS["/leave"]        = LUIE.SlashGroupLeave
SLASH_COMMANDS["/leavegroup"]   = LUIE.SlashGroupLeave
SLASH_COMMANDS["/kick"]         = LUIE.SlashKick
SLASH_COMMANDS["/remove"]       = LUIE.SlashGroupKick
SLASH_COMMANDS["/groupkick"]    = LUIE.SlashGroupKick
SLASH_COMMANDS["/groupremove"]  = LUIE.SlashGroupKick
SLASH_COMMANDS["/home"]         = LUIE.SlashHome
SLASH_COMMANDS["/trade"]        = LUIE.SlashTrade
SLASH_COMMANDS["/votekick"]     = LUIE.SlashVoteKick
SLASH_COMMANDS["/voteremove"]   = LUIE.SlashVoteKick
SLASH_COMMANDS["/guildinvite"]  = LUIE.SlashGuildInvite
SLASH_COMMANDS["/ginvite"]      = LUIE.SlashGuildInvite
SLASH_COMMANDS["/guildkick"]    = LUIE.SlashGuildKick
SLASH_COMMANDS["/gkick"]        = LUIE.SlashGuildKick
SLASH_COMMANDS["/guildquit"]    = LUIE.SlashGuildQuit
SLASH_COMMANDS["/gquit"]        = LUIE.SlashGuildQuit
SLASH_COMMANDS["/guildleave"]   = LUIE.SlashGuildQuit
SLASH_COMMANDS["/gleave"]       = LUIE.SlashGuildQuit
SLASH_COMMANDS["/addfriend"]    = LUIE.SlashFriend
SLASH_COMMANDS["/friend"]       = LUIE.SlashFriend
SLASH_COMMANDS["/addignore"]    = LUIE.SlashIgnore
SLASH_COMMANDS["/ignore"]       = LUIE.SlashIgnore
SLASH_COMMANDS["/unfriend"]     = LUIE.SlashRemoveFriend
SLASH_COMMANDS["/removefriend"] = LUIE.SlashRemoveFriend
SLASH_COMMANDS["/unignore"]     = LUIE.SlashRemoveIgnore
SLASH_COMMANDS["/removeignore"] = LUIE.SlashRemoveIgnore
SLASH_COMMANDS["/campaign"]     = LUIE.SlashCampaignQ

-- Hook initialization
EVENT_MANAGER:RegisterForEvent(LUIE.name, EVENT_ADD_ON_LOADED, LUIE_OnAddOnLoaded)
