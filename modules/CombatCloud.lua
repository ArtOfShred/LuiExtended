------------------
-- CombatText namespace
LUIE.CombatText     = {}

local LMP = LibStub("LibMediaProvider-1.0")
local CT  = LUIE.CombatText

local moduleName    = LUIE.name .. "_CombatText"

CT.Enabled  = false
CT.D = {
    unlocked = false,
---------------------------------------------------------------------------------------------------------------------------------------
    --//PANEL DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    panels = {
    --Outgoing
        CombatCloud_Outgoing = {
            point                   = CENTER,
            relativePoint           = CENTER,
            offsetX                 = 400,
            offsetY                 = -200,
            dimensions              = { 400, 100 },
        },
    --Incoming
        CombatCloud_Incoming = {
            point                   = CENTER,
            relativePoint           = CENTER,
            offsetX                 = -400,
            offsetY                 = -200,
            dimensions              = { 400, 100 },
        },
    --Alerts
        CombatCloud_Alert = {
            point                   = CENTER,
            relativePoint           = CENTER,
            offsetX                 = 0,
            offsetY                 = 250,
            dimensions              = { 400, 100 },
        },
    --Points
        CombatCloud_Point = {
            point                   = CENTER,
            relativePoint           = CENTER,
            offsetX                 = 0,
            offsetY                 = -300,
            dimensions              = { 400, 100 },
        },
    --Resources
        CombatCloud_Resource = {
            point                   = CENTER,
            relativePoint           = CENTER,
            offsetX                 = 0,
            offsetY                 = 375,
            dimensions              = { 400, 100 },
        }
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//TOGGLE DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    toggles     = {
    --General
        inCombatOnly                = false,
        showThrottleTrailer         = true,
        throttleCriticals           = false,
    ----------------------------------
        incoming    = {
    --Damage & Healing
            showDamage              = true,
            showHealing             = true,
            showEnergize            = true,
            showUltimateEnergize    = true,
            showDrain               = true,
            showDot                 = true,
            showHot                 = true,
    --Mitigation
            showMiss                = true,
            showImmune              = true,
            showParried             = true,
            showReflected           = true,
            showDamageShield        = true,
            showDodged              = true,
            showBlocked             = true,
            showInterrupted         = true,
    --Crowd Control
            showDisoriented         = true,
            showFeared              = true,
            showOffBalanced         = true,
            showSilenced            = true,
            showStunned             = true,
        },
    ----------------------------------
        outgoing    = {
    --Damage & Healing
            showDamage              = true,
            showHealing             = true,
            showEnergize            = true,
            showUltimateEnergize    = true,
            showDrain               = true,
            showDot                 = true,
            showHot                 = true,
    --Mitigation
            showMiss                = true,
            showImmune              = true,
            showParried             = true,
            showReflected           = true,
            showDamageShield        = true,
            showDodged              = true,
            showBlocked             = true,
            showInterrupted         = true,
    --Crowd Control
            showDisoriented         = true,
            showFeared              = true,
            showOffBalanced         = true,
            showSilenced            = true,
            showStunned             = true,
        },
    ----------------------------------
    --Combat State
        showInCombat                = true,
        showOutCombat               = true,
    ----------------------------------
    --Alerts
        showAlertMitigation         = true,
        mitigationType              = "Single Line",
        mitigationFormat            = "%t %i", -- %i %t
        mitigationSuffix            = GetString(SI_LUIE_CT_MITIGATION_SUFFIX_DEFAULT), -- "incoming! "
        mitigationRank3             = true,
        mitigationRank2             = true,
        mitigationRank1             = true,
        mitigationDungeon           = true,
    
        showAlertBlock              = true,
        showAlertInterrupt          = true,
        showAlertDodge              = true,
        showAlertAvoid              = true,
        
        showAlertCleanse            = true,
        showAlertExploit            = true,
        showAlertExecute            = false,
        hideIngameTips              = true,
    ----------------------------------
    --Points
        showPointsAlliance          = false,
        showPointsExperience        = false,
        showPointsChampion          = false,
    ----------------------------------
    --Resources
        showLowHealth               = false,
        showLowStamina              = false,
        showLowMagicka              = false,
        showUltimate                = true,
        showPotionReady             = true,
        warningSound                = false,
    ----------------------------------
    --Colors
        criticalDamageOverride      = false,
        criticalHealingOverride     = false,
		incomingDamageOverride		= false,
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//OTHER DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    healthThreshold                 = 35,
    magickaThreshold                = 35,
    staminaThreshold                = 35,
    executeThreshold                = 20,
    executeFrequency                = 8,
---------------------------------------------------------------------------------------------------------------------------------------
    --//FONT DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    fontFace                        = [[Univers 67]],
    fontOutline                     = [[soft-shadow-thick]],
    ----------------------------------
    fontSizes = {
    --Combat
        damage                      = 32,
		damagecritical 				= 32,
        healing                     = 32,
		healingcritical				= 32,
        dot                         = 26,
		dotcritical 				= 26,
        hot	              		    = 26,
		hotcritical				    = 26,
        gainLoss                    = 32,
        mitigation                  = 32,
        crowdControl                = 26,
    ----------------------------------
    --Combat State, Points, Alerts & Resources
        combatState                 = 24,
        alert                       = 32,
        point                       = 24,
        resource                    = 32,
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//COLOR DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    colors = {
    --Damage & Healing
        damage = {
            [DAMAGE_TYPE_NONE]      = { 1, 1, 1, 1 },                     
            [DAMAGE_TYPE_GENERIC]   = { 1, 1, 1, 1 },                     
            [DAMAGE_TYPE_PHYSICAL]  = { 200/255, 200/255, 160/255, 1 },
            [DAMAGE_TYPE_FIRE]      = { 1, 100/255, 20/255, 1 },
            [DAMAGE_TYPE_SHOCK]     = { 0, 1, 1, 1 },
            [DAMAGE_TYPE_OBLIVION]  = { 75/255, 0, 150/255, 1 },
            [DAMAGE_TYPE_COLD]      = { 35/255, 70/255, 1, 1 },
            [DAMAGE_TYPE_EARTH]     = { 100/255, 75/255, 50/255, 1 },
            [DAMAGE_TYPE_MAGIC]     = { 1, 1, 0, 1 },
            [DAMAGE_TYPE_DROWN]     = { 35/255, 70/255, 255/255, 1 },      
            [DAMAGE_TYPE_DISEASE]   = { 25/255, 85/255, 0, 1 },
            [DAMAGE_TYPE_POISON]    = { 0, 1, 127/255, 1 }
            },
        healing                     = { 0, 192/255, 0, 1 },
        energizeMagicka             = { 0, 192/255, 1, 1 },
        energizeStamina             = { 192/255, 1, 0, 1 },
        energizeUltimate            = { 1, 1, 0, 1 },       
        drainMagicka                = { 0, 192/255, 1, 1 },
        drainStamina                = { 192/255, 1, 0, 1 },
        criticalDamageOverride      = { 247/255, 244/255, 153/255, 1 },
        criticalHealingOverride     = { 0, 192/255, 0, 1 },
		incomingDamageOverride		= { 1, 0, 0, 1 },
    ----------------------------------
    --Mitigation
        miss                        = { 1, 1, 1, 1 },
        immune                      = { 1, 0, 0, 1 },
        parried                     = { 1, 1, 1, 1 },
        reflected                   = { 1, 160/255, 0, 1 },
        damageShield                = { 1, 160/255, 0, 1 },
        dodged                      = { 1, 1, 50/255, 1 },
        blocked                     = { 1, 1, 1, 1 },
        interrupted                 = { 1, 1, 1, 1 },
    ----------------------------------
    --Crowd Control
        disoriented                 = { 1, 1, 1, 1 },
        feared                      = { 1, 1, 1, 1 },
        offBalanced                 = { 1, 1, 1, 1 },
        silenced                    = { 1, 1, 1, 1 },
        stunned                     = { 1, 1, 1, 1 },
    ----------------------------------
    --Combat State
        inCombat                    = { 1, 1, 1, 1 },
        outCombat                   = { 1, 1, 1, 1 },
    ----------------------------------
    --Alerts
        alertCleanse                = { 1, 1, 1, 1 },
        alertBlock                  = { 1, 0, 0, 1 },
        alertExploit                = { 1, 1, 1, 1 },
        alertInterrupt              = { 1, 1, 1, 1 },
        alertDodge                  = { 1, 1, 50/255, 1 },
        alertAvoid                  = { 1, 1, 50/255, 1 },
        alertExecute                = { 1, 1, 1, 1 },
    ----------------------------------
    --Points
        pointsAlliance              = { 0.235294, 0.784314, 0.313725, 1 },  --RGB(60, 200, 80)
        pointsExperience            = { 0.588235, 0.705882, 0.862745, 1 },  --RGB(150, 180, 220)
        pointsChampion               = { 0.784314, 0.784314, 0.627451, 1 },  --RGB(200, 200, 160)
    ----------------------------------
    --Resources
        lowHealth                   = { 0.901961, 0.196078, 0.098039, 1 },  --RGB(230, 50, 25)
        lowMagicka                  = { 0.137255, 0.588235, 0.784314, 1 },  --RGB(35, 150, 200)
        lowStamina                  = { 0.235294, 0.784314, 0.313725, 1 },  --RGB(60, 200, 80)
        ultimateReady               = { 0.862745, 1, 0.313725, 1 },         --RGB(220, 255, 80)
        potionReady                 = { 0.470588, 0.156863, 0.745098, 1 },  --RGB(120, 40, 190)
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//FORMAT DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    formats = {
    --Damage & Healing
        damage                      = "%t %a",
		damagecritical				= "%t %a!",
        healing                     = "%t %a",
		healingcritical             = "%t %a!",
        energize                    = "+%a %t",
        ultimateEnergize            = "+%a %t",
        drain                       = "-%a %t",
        dot                         = "%t %a",
		dotcritical					= "%t %a!",
        hot                         = "%t %a",
		hotcritical                 = "%t %a!",
    ----------------------------------
    --Mitigation
        miss                        = GetString(SI_LUIE_CT_MISS_DEFAULT),
        immune                      = GetString(SI_LUIE_CT_IMMUNE_DEFAULT),
        parried                     = GetString(SI_LUIE_CT_PARRIED_DEFAULT),
        reflected                   = GetString(SI_LUIE_CT_REFLECTED_DEFAULT),
        damageShield                = "(%a) %t",
        dodged                      = GetString(SI_LUIE_CT_DODGED_DEFAULT),
        blocked                     = "*%t %a",
        interrupted                 = GetString(SI_LUIE_CT_INTERRUPTED_DEFAULT),
    ----------------------------------
    --Crowd Control
        disoriented                 = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED),
        feared                      = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
        offBalanced                 = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
        silenced                    = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
        stunned                     = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
    ----------------------------------
    --Combat State
        inCombat                    = GetString(SI_LUIE_CT_COMBAT_IN_DEFAULT),
        outCombat                   = GetString(SI_LUIE_CT_COMBAT_OUT_DEFAULT),
    ----------------------------------
    --Alerts
        alertCleanse                = GetString(SI_LUIE_CT_CLEANSE_DEFAULT),
        alertBlock                  = GetString(SI_LUIE_CT_BLOCK_DEFAULT),
        alertBlockStagger           = GetString(SI_LUIE_CT_BLOCKSTAGGER_DEFAULT),
        alertExploit                = GetString(SI_LUIE_CT_EXPLOIT_DEFAULT),
        alertInterrupt              = GetString(SI_LUIE_CT_INTERRUPT_DEFAULT),
        alertDodge                  = GetString(SI_LUIE_CT_DODGE_DEFAULT),
        alertAvoid                  = GetString(SI_LUIE_CT_AVOID_DEFAULT),
        alertExecute                = GetString(SI_LUIE_CT_EXECUTE_DEFAULT),
    ----------------------------------
    --Points
        pointsAlliance              = "%a AP",
        pointsExperience            = "%a XP",
        pointsChampion              = "%a XP",
    ----------------------------------
    --Resources
        resource                    = "%t! (%a)",
        ultimateReady               = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY),
        potionReady                 = GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY),
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//ANIMATION DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    animation = {
        animationType               = "scroll",
        outgoingIcon                = "left",
        incomingIcon                = "right",
        outgoing = {
            directionType           = "down",
            speed                   = 4000,
        },
        incoming = {
            directionType           = "down",
            speed                   = 4000,
        }
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//THROTTLE DEFAULTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    throttles   = {
        damage                      = 200,
        damagecritical              = 200,
        healing                     = 200,
        healingcritical             = 200,
        dot                         = 200,
        dotcritical                 = 200,
        hot                         = 200,
        hotcritical                 = 200,
    },
}
CT.SV       = nil

local function SavePosition(panel)
        local anchor = { panel:GetAnchor(0) }
        local dimensions = { panel:GetDimensions() }
        local panelSettings = LUIE.CombatText.SV.panels[panel:GetName()]
        panelSettings.point = anchor[2]
        panelSettings.relativePoint = anchor[4]
        panelSettings.offsetX = anchor[5]
        panelSettings.offsetY = anchor[6]
        panelSettings.dimensions = dimensions
end

---------------------------------------------------------------------------------------------------------------------------------------
    --//ADDON LOADED//--
---------------------------------------------------------------------------------------------------------------------------------------
function CT.Initialize( enabled )

    CT.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "CombatText", CT.D )

    if not enabled then return end
    CT.Enabled = true

    --Set panels to player configured settings
    for k, s in pairs (LUIE.CombatText.SV.panels) do
        if _G[k] ~= nil then
            _G[k]:ClearAnchors()
            _G[k]:SetAnchor(s.point, CombatCloud, s.relativePoint, s.offsetX, s.offsetY)
            _G[k]:SetDimensions(unpack(s.dimensions))
            _G[k]:SetHandler('OnMouseUp', SavePosition)
            _G[k .. '_Label']:SetFont(LMP:Fetch('font', LUIE.CombatText.SV.fontFace) .. '|26|' .. LUIE.CombatText.SV.fontOutline)
            _G[k .. '_Label']:SetText(CombatCloudLocalization.panelTitles[k])
        else
            LUIE.CombatText.SV.panels[k] = nil
        end
    end

    --Allow mouse resizing of panels
    CombatCloud_Incoming:SetResizeHandleSize(MOUSE_CURSOR_RESIZE_NS)
    CombatCloud_Outgoing:SetResizeHandleSize(MOUSE_CURSOR_RESIZE_NS)

    --Pool Manager
    local poolManager = CombatCloud_PoolManager:New()
    for _, v in pairs(CombatCloudConstants.poolType) do -- Create a pool for each type
        poolManager:RegisterPool(v, CombatCloud_Pool:New(v))
    end

    --Event Listeners
    CombatCloud_CombatEventListener:New()
    CombatCloud_AlertEventListener:New()
    CombatCloud_PointsAllianceEventListener:New()
    CombatCloud_PointsExperienceEventListener:New()
    CombatCloud_PointsChampionEventListener:New()
    CombatCloud_ResourcesPowerEventListener:New()
    CombatCloud_ResourcesUltimateEventListener:New()
    CombatCloud_ResourcesPotionEventListener:New()

    --Event Viewers
    CombatCloud_CombatCloudEventViewer:New(poolManager, LMP)
    CombatCloud_CombatHybridEventViewer:New(poolManager, LMP)
    CombatCloud_CombatScrollEventViewer:New(poolManager, LMP)
    CombatCloud_CombatEllipseEventViewer:New(poolManager, LMP)
    CombatCloud_AlertEventViewer:New(poolManager, LMP)
    CombatCloud_CrowdControlEventViewer:New(poolManager, LMP)
    CombatCloud_PointEventViewer:New(poolManager, LMP)
    CombatCloud_ResourceEventViewer:New(poolManager, LMP)

    --Hide ingame active combat tips
    ZO_ActiveCombatTips:SetHidden(LUIE.CombatText.SV.toggles.hideIngameTips)

    if LUIE.CombatText.SV.toggles.showAlertMitigation then 
        SetSetting(SETTING_TYPE_ACTIVE_COMBAT_TIP, 0, ACT_SETTING_ALWAYS)
    end

end
