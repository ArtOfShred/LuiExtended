CombatCloudLocalization = {
---------------------------------------------------------------------------------------------------------------------------------------
    --//PANEL TITLES//--
---------------------------------------------------------------------------------------------------------------------------------------
    panelTitles = {
        CombatCloud_Outgoing                = "Outgoing",
        CombatCloud_Incoming                = "Incoming",
        CombatCloud_Point                   = "Points",
        CombatCloud_Alert                   = "Alerts",
        CombatCloud_Resource                = "Resources"
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//MAIN//--
---------------------------------------------------------------------------------------------------------------------------------------
        combatCloudOptions                  = "Combat Cloud Options",
        unlock                              = "Unlock",
        unlockTooltip                       = "Unlock the panels to move them.",
---------------------------------------------------------------------------------------------------------------------------------------
    --//TOGGLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonToggleIncoming                = "Toggle Options [Incoming]",
        buttonToggleOutgoing                = "Toggle Options [Outgoing]",
        buttonToggleNotification            = "Toggle Options [Notifications]",
        headerToggleIncomingDamageHealing   = "Incoming Damage & Healing Toggles",
        headerToggleIncomingMitigation      = "Incoming Mitigation Toggles",
        headerToggleIncomingCrowdControl    = "Incoming Crowd Control Toggles",
        headerToggleOutgoingDamageHealing   = "Outgoing Damage & Healing Toggles",
        headerToggleOutgoingMitigation      = "Outgoing Mitigation Toggles",
        headerToggleOutgoingCrowdControl    = "Outgoing Crowd Control Toggles",
        headerToggleCombatState             = "Combat State Toggles",
        headerToggleAlert                   = "Active Combat Alert Toggles",
        headerTogglePoint                   = "Point Toggles",
        headerToggleResource                = "Resource Toggles",
        descriptionAlert                    = "Set Active Combat Tips to Always Show in the Interface options",
    --General
        inCombatOnly                        = "In Combat Only",
    --Combat State
        combatState                         = "Combat State",
        inCombat                            = "In Combat",
        outCombat                           = "Out Of Combat",
    --Damage & Healing
        damage                              = "Damage",
        healing                             = "Healing",
        energize                            = "Energize",
        ultimateEnergize                    = "Ultimate energize",
        drain                               = "Drain",
        tick                                = "DoT & HoT",
        dot                                 = "Damage over time",
        hot                                 = "Healing over time",
        critical                            = "Critical",
    --Mitigation
        mitigation                          = "Mitigation",
        miss                                = "Missed",
        immune                              = "Immune",
        parried                             = "Parried",
        reflected                           = "Reflected",
        damageShield                        = "Damage Shielded",
        dodged                              = "Dodged",
        blocked                             = "Blocked",
        interrupted                         = "Interrupted",
    --Crowd Control
        crowdControl                        = "Crowd Control",
        disoriented                         = "Disoriented",
        feared                              = "Feared",
        offBalanced                         = "Off Balanced",
        silenced                            = "Silenced",
        stunned                             = "Stunned",
    --Alerts
        alert                               = "Active Combat Alerts",
        alertCleanse                        = "Cleanse Now",
        alertBlock                          = "Block Now",
        alertExploit                        = "Exploit Now",
        alertInterrupt                      = "Interrupt Now",
        alertDodge                          = "Dodge Now",
        alertExecute                        = "Execute Now",
        executeThreshold                    = "Execute Threshold",
        executeFrequency                    = "Execute Frequency",
        ingameTips                          = "Hide ingame tips",
    --Points
        point                               = "AP, XP & CP Points",
        pointsAlliance                      = "Alliance Points",
        pointsExperience                    = "Experience Points",
        pointsChampion                       = "Champion Points",
    --Resources
        resource                            = "Resources",
        formatResource                      = "Low Resources",
        lowHealth                           = "Low Health",
        lowMagicka                          = "Low Magicka",
        lowStamina                          = "Low Stamina",
        ultimateReady                       = "Ultimate Ready",
        potionReady                         = "Potion Ready",
        warningSound                        = "Warning Sound",
        warningThresholdHealth              = "Warning Threshold Health",
        warningThresholdMagicka             = "Warning Threshold Magicka",
        warningThresholdStamina             = "Warning Threshold Stamina",
    --Tooltips General
        tooltipInCombatOnly                 = "Will only display incoming and outgoing numbers when in combat",
    --Tooltips Incoming
        --Damage & Healing
        tooltipIncomingDamage               = "Show incoming damage",
        tooltipIncomingHealing              = "Show incoming direct healing",
        tooltipIncomingEnergize             = "Show incoming magicka/stamina return",
        tooltipIncomingUltimateEnergize     = "Show incoming ultimate return",
        tooltipIncomingDrain                = "Show incoming magicka/stamina loss",
        tooltipIncomingDot                  = "Show incoming 'damage over time'",
        tooltipIncomingHot                  = "Show incoming 'healing over time'",
        --Mitigation
        tooltipIncomingMiss                 = "Show missed enemy attacks",
        tooltipIncomingImmune               = "Show immunity to enemy attacks",
        tooltipIncomingParried              = "Show parried attacks",
        tooltipIncomingReflected            = "Show reflected attacks (incoming only)",
        tooltipIncomingDamageShield         = "Show damage shield absorbs",
        tooltipIncomingDodge                = "Show dodged attacks",
        tooltipIncomingBlocked              = "Show blocked attacks",
        tooltipIncomingInterrupted          = "Show interrupted attacks",
        --Crowd Control
        tooltipIncomingDisoriented          = "Show whether you are disoriented",
        tooltipIncomingFeared               = "Show whether you are feared",
        tooltipIncomingOffBalanced          = "Show whether you are off balanced",
        tooltipIncomingSilenced             = "Show whether you are silenced",
        tooltipIncomingStunned              = "Show whether you are stunned",
    --Tooltips Outgoing
        --Damage & Healing
        tooltipOutgoingDamage               = "Show outgoing damage",
        tooltipOutgoingHealing              = "Show outgoing direct healing",
        tooltipOutgoingEnergize             = "Show outgoing magicka/stamina return",
        tooltipOutgoingUltimateEnergize     = "Show outgoing ultimate return",
        tooltipOutgoingDrain                = "Show outgoing magicka/stamina loss",
        tooltipOutgoingDot                  = "Show outgoing 'damage over time'",
        tooltipOutgoingHot                  = "Show outgoing 'healing over time'",
        --Mitigation
        tooltipOutgoingMiss                 = "Show your missed attacks on the enemy",
        tooltipOutgoingImmune               = "Show whether the enemy was immune to the attack",
        tooltipOutgoingParried              = "Show whether the enemy parried the attack",
        tooltipOutgoingReflected            = "Show whether the enemy reflected the attack",
        tooltipOutgoingDamageShield         = "Show whether the enemy absorbed the attack",
        tooltipOutgoingDodge                = "Show whether the enemy dodged the attack",
        tooltipOutgoingBlocked              = "Show whether the enemy blocked the attack",
        tooltipOutgoingInterrupted          = "Show whether the enemy interrupted the attack",
        --Crowd Control
        tooltipOutgoingDisoriented          = "Show whether you disoriented the enemy",
        tooltipOutgoingFeared               = "Show whether you feared the enemy",
        tooltipOutgoingOffBalanced          = "Show whether you made the enemy off balanced",
        tooltipOutgoingSilenced             = "Show whether you silenced the enemy",
        tooltipOutgoingStunned              = "Show whether you stunned the enemy",
    --Tooltips Combat State
        tooltipInCombat                     = "Will display a message upon entering combat",
        tooltipOutCombat                    = "Will display a message upon exiting combat",
    --Tooltips Alerts
        tooltipAlertsCleanse                = "Show alerts when you need to cleanse",
        tooltipAlertsBlock                  = "Show alerts when you can block a special attack",
        tooltipAlertsExploit                = "Show alerts when you can exploit the target",
        tooltipAlertsInterrupt              = "Show alerts when you can interrupt a special attack",
        tooltipAlertsDodge                  = "Show alerts when you can dodge a special attack",
        tooltipAlertsExecute                = "Show alerts when target has low health",
        tooltipExecuteThreshold             = "The threshold at which the execute alert will trigger. Default will display alert at 20% of target's health.",
        tooltipExecuteFrequency             = "The frequency how often will be execute alert triggered for the same target. Default is 8 seconds.",
        tooltipIngameTips                   = "Hide default Active Combat Tips window",
    --Tooltips Points
        tooltipPointsAlliance               = "Show accumulated Alliance Points",
        tooltipPointsExperience             = "Show accumulated Experience Points",
        tooltipPointsChampion                = "Show accumulated Champion Points",
    --Tooltips Resources
        tooltipLowHealth                    = "Show Health warning when below desired threshold",
        tooltipLowMagicka                   = "Show Magicka warning when below desired threshold",
        tooltipLowStamina                   = "Show Stamina warning when below desired threshold",
        tooltipUltimateReady                = "Show a notification when Ultimate becomes available",
        tooltipPotionReady                  = "Show a notification when Potion is ready for use",
        tooltipWarningSound                 = "Play a sound when resources fall below the desired threshold",
        tooltipWarningThresholdHealth       = "The threshold at which the warnings will trigger. Default will display a warning at 35%",
        tooltipWarningThresholdMagicka      = "The threshold at which the warnings will trigger. Default will display a warning at 35%",
        tooltipWarningThresholdStamina      = "The threshold at which the warnings will trigger. Default will display a warning at 35%",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FONT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonFont                          = "Font Options",
        buttonFontCombat                    = "Font Sizes [Combat]",
        buttonFontNotification              = "Font Sizes [Notifications]",
    --General Fonts
        fontFace                            = "Font Face",
        fontOutline                         = "Font Outline",
        fontTest                            = "Test Font",
        gainLoss                            = "Energize & Drain",
    --Tooltips Fonts
        tooltipFontFace                     = "Pick a font face",
        tooltipFontOutline                  = "Pick a font outline",
        tooltipFontTest                     = "Generate numbers to test out the chosen font",
    --Tooltips Fonts Combat
        tooltipFontDamage                   = "Font size of damage, default 26",
        tooltipFontHealing                  = "Font size of direct heals and energize, default 26",
        tooltipFontGainLoss                 = "Font size of energize and drain, default 18",
        tooltipFontTick                     = "Font size of DoTs and HoTs default 18",
        tooltipFontCritical                 = "Font size of critical hits, default 36",
        tooltipFontMitigation               = "Font size of mitigation, default 30",
        tooltipFontCrowdControl             = "Font size of crowd control warnings, default 36",
    --Tooltips Fonts Combat State, Alerts, Points, Resources
        tooltipFontCombatState              = "Font size of message when entering or exiting combat, default 32",
        tooltipFontAlert                    = "Font size of active combat alerts, default 48",
        tooltipFontPoint                    = "Font size of accumulated points, default 32",
        tooltipFontResource                 = "Font size of resource warnings, default 48",
---------------------------------------------------------------------------------------------------------------------------------------
    --//COLOR OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonColorCombat                   = "Color Options [Combat]",
        buttonColorNotification             = "Color Options [Notifications]",
        headerColorDamageHealing            = "Damage & Healing Colors",
        headerColorMitigation               = "Mitigation Colors",
        headerColorCrowdControl             = "Crowd Control Colors",
        headerColorCombatState              = "Combat State Colors",
        headerColorAlert                    = "Active Combat Alert Colors",
        headerColorPoint                    = "Point Colors",
        headerColorResource                 = "Resource Colors",
    --Damage & Healing
        energizeMagicka                     = "Energize (Magicka)",
        energizeStamina                     = "Energize (Stamina)",
        energizeUltimate                    = "Energize (Ultimate)",
        drainMagicka                        = "Drain (Magicka)",
        drainStamina                        = "Drain (Stamina)",
        colorCriticalDamage                 = "Override Critical Damage Color",
        colorCriticalHealing                = "Override Critical Healing Color",
        damageType = {
            [DAMAGE_TYPE_NONE]              = "None",
            [DAMAGE_TYPE_GENERIC]           = "Generic",
            [DAMAGE_TYPE_PHYSICAL]          = "Physical",
            [DAMAGE_TYPE_FIRE]              = "Fire",
            [DAMAGE_TYPE_SHOCK]             = "Shock",
            [DAMAGE_TYPE_OBLIVION]          = "Oblivion",
            [DAMAGE_TYPE_COLD]              = "Cold",
            [DAMAGE_TYPE_EARTH]             = "Earth",
            [DAMAGE_TYPE_MAGIC]             = "Magic",
            [DAMAGE_TYPE_DROWN]             = "Drown",
            [DAMAGE_TYPE_DISEASE]           = "Disease",
            [DAMAGE_TYPE_POISON]            = "Poison",
        },
    --Tooltips damage & healing
        tooltipColorHealing                 = "Set a color for all healing",
        tooltipColorEnergizeMagicka         = "Set a color for magicka return",
        tooltipColorEnergizeStamina         = "Set a color for stamina return",
        tooltipColorEnergizeUltimate        = "Set a color for ultimate return",
        tooltipColorDrainMagicka            = "Set a color for magicka loss",
        tooltipColorDrainStamina            = "Set a color for stamina loss",
        tooltipColorCriticalDamage          = "Override critical damage color, no matter the damage type",
        tooltipColorCriticalHealing         = "Override critical healing color",
        tooltipCriticalDamageOverride       = "Show override critical damage color",
        tooltipCriticalHealingOverride      = "Show override critical healing color",
        tooltipDamageType = {
            [DAMAGE_TYPE_NONE]              = "Set a color for damage with no type",
            [DAMAGE_TYPE_GENERIC]           = "Set a color for Generic damage",
            [DAMAGE_TYPE_PHYSICAL]          = "Set a color for Physical damage",
            [DAMAGE_TYPE_FIRE]              = "Set a color for Fire damage",
            [DAMAGE_TYPE_SHOCK]             = "Set a color for Shock damage",
            [DAMAGE_TYPE_OBLIVION]          = "Set a color for Oblivion damage",
            [DAMAGE_TYPE_COLD]              = "Set a color for Cold damage",
            [DAMAGE_TYPE_EARTH]             = "Set a color for Earth damage",
            [DAMAGE_TYPE_MAGIC]             = "Set a color for Magic damage",
            [DAMAGE_TYPE_DROWN]             = "Set a color for Drowning damage",
            [DAMAGE_TYPE_DISEASE]           = "Set a color for Disease damage",
            [DAMAGE_TYPE_POISON]            = "Set a color for Poison damage",
        },
    --Tooltips Mitigation
        tooltipColorMiss                    = "Set a color for missed attacks",
        tooltipColorImmune                  = "Set a color for immunity to attacks",
        tooltipColorParried                 = "Set a color for parried attacks",
        tooltipColorReflected               = "Set a color for reflected attacks",
        tooltipColorDamageShield            = "Set a color for damage shield absorbs",
        tooltipColorDodge                   = "Set a color for dodged attacks",
        tooltipColorBlocked                 = "Set a color for blocked attacks",
        tooltipColorInterrupted             = "Set a color for interrupted attacks",
    --Tooltips Crowd Control
        tooltipColorDisoriented             = "Set a color for notifications when disoriented",
        tooltipColorFeared                  = "Set a color for notifications when feared",
        tooltipColorOffBalanced             = "Set a color for notifications when off balance",
        tooltipColorSilenced                = "Set a color for notifications when silenced",
        tooltipColorStunned                 = "Set a color for notifications when stunned",
    --Tooltips Alerts
        tooltipColorAlertsCleanse           = "Set a color for cleanse alerts",
        tooltipColorAlertsBlock             = "Set a color for block alerts",
        tooltipColorAlertsExploit           = "Set a color for exploit alerts",
        tooltipColorAlertsInterrupt         = "Set a color for interrupt alerts",
        tooltipColorAlertsDodge             = "Set a color for dodge alerts",
        tooltipColorAlertsExecute           = "Set a color for execute alerts",
    --Tooltips Points
        tooltipColorPointsAlliance          = "Set a color for accumulated Alliance Points",
        tooltipColorPointsExperience        = "Set a color for accumulated Experience Points",
        tooltipColorPointsChampion           = "Set a color for accumulated Champion Points",
    --Tooltips Resources
        tooltipColorLowHealth               = "Set a color for low Health warnings",
        tooltipColorLowMagicka              = "Set a color for low Magicka warnings",
        tooltipColorLowStamina              = "Set a color for low Stamina warnings",
        tooltipColorUltimateReady           = "Set a color for notifications when Ultimate is available",
        tooltipColorPotionReady             = "Set a color for notifications when Potion is ready for use",
    --Tooltips Combat State
        tooltipColorInCombat                = "Set a color for notifications when entering combat",
        tooltipColorOutCombat               = "Set a color for notifications when exiting combat",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FORMAT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        descriptionFormat                   = "Allows to change the text output. Write any text you want or enter a variable for special outputs\n %t Ability name, localized name\n %a Amount, value\n %r Power type, resource",
        buttonFormatCombat                  = "Format Options [Combat]",
        buttonFormatNotification            = "Format Options [Notifications]",
        headerFormatDamageHealing           = "Damage & Healing Text Formats",
        headerFormatMitigation              = "Mitigation Text Formats",
        headerFormatCrowdControl            = "Crowd Control Text Formats",
        headerFormatCombatState             = "Combat State Formats",
        headerFormatAlert                   = "Active Combat Alert Formats",
        headerFormatPoint                   = "Point Text Formats",
        headerFormatResource                = "Resource Text Formats",
    --Tooltips Damage & Healing
        tooltipFormatDamage                 = "Text format for damage numbers",
        tooltipFormatHealing                = "Text format for direct healing numbers",
        tooltipFormatEnergize               = "Text format for magicka/stamina return",
        tooltipFormatUltimateEnergize       = "Text format for ultimate return",
        tooltipFormatDrain                  = "Text format for magicka/stamina loss",
        tooltipFormatDot                    = "Text format for 'damage over time' numbers",
        tooltipFormatHot                    = "Text format for 'heal over time' numbers",
        tooltipFormatCritical               = "Text format for critical damage numbers",
    --Tooltips Mitigation
        tooltipFormatMiss                   = "Text format for missed attacks",
        tooltipFormatImmune                 = "Text format for immunity to attacks",
        tooltipFormatParried                = "Text format for parried attacks",
        tooltipFormatReflected              = "Text format for reflected attacks",
        tooltipFormatDamageShield           = "Text format for damage shield absorbs",
        tooltipFormatDodged                 = "Text format for dodged attacks",
        tooltipFormatBlocked                = "Text format for blocked attacks",
        tooltipFormatInterrupted            = "Text format for interrupted attacks",
    --Tooltips Crowd Control
        tooltipFormatDisoriented            = "Text format for notifications when disoriented",
        tooltipFormatFeared                 = "Text format for notifications when feared",
        tooltipFormatOffBalanced            = "Text format for notifications when off balanced",
        tooltipFormatSilenced               = "Text format for notifications when silenced",
        tooltipFormatStunned                = "Text format for notifications when stunned",
    --Tooltips Alerts
        tooltipFormatAlertsCleanse          = "Text format for cleanse alerts",
        tooltipFormatAlertsBlock            = "Text format for block alerts",
        tooltipFormatAlertsExploit          = "Text format for exploit alerts",
        tooltipFormatAlertsInterrupt        = "Text format for interrupt alerts",
        tooltipFormatAlertsDodge            = "Text format for dodge alerts",
        tooltipFormatAlertsExecute          = "Text format for execute alerts",
    --Tooltips Points
        tooltipFormatPointsAlliance         = "Text format for accumulated Alliance Points",
        tooltipFormatPointsExperience       = "Text format for accumulated Experience Points",
        tooltipFormatPointsChampion          = "Text format for accumulated Champion Points",
    --Tooltips Resources
        tooltipFormatResource               = "Text format for warnings when low on resources",
        tooltipFormatUltimateReady          = "Text format for notifications when your Ultimate is available",
        tooltipFormatPotionReady            = "Text format for notifications when Potion is ready for use",
    --Tooltips Combat State
        tooltipFormatInCombat               = "Text format for notifications when entering combat",
        tooltipFormatOutCombat              = "Text format for notifications when exiting combat",
---------------------------------------------------------------------------------------------------------------------------------------
    --//ANIMATION OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonAnimation                     = "Animation Options",
    --General
        animationType                       = "Animation type",
        outgoingDirection                   = "Outgoing direction",
        incomingDirection                   = "Incoming direction",
        animationTest                       = "Test Animation",
        outgoingIcon                        = "Outgoing icon position",
        incomingIcon                        = "Incoming icon position",
    --Tooltips
        tooltipAnimationType                = "Select Animation Type",
        tooltipAnimationIncomingDirection   = "Set the direction of incoming damage",
        tooltipAnimationOutgoingDirection   = "Set the direction of outgoing damage",
        tooltipAnimationTest                = "Test the animations of incoming & outgoing damage",
        tooltipAnimationOutgoingIcon        = "Set the icons position of outgoing events",
        tooltipAnimationIncomingIcon        = "Set the icons position of incoming events",
---------------------------------------------------------------------------------------------------------------------------------------
    --//THROTTLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonThrottle                      = "Throttle Options",
    --General
        descriptionThrottle                 = "Accumulates multiple hits into one. Use the slider to adjust the time frame in milliseconds. Critical hits are never throttled.\n",
        showThrottleTrailer                 = "Show throttle trailer",
    --Tooltips
        tooltipThrottleDamage               = "Set the throttle for damage numbers",
        tooltipThrottleHealing              = "Set the throttle for healing numbers",
        tooltipThrottleDot                  = "Set the throttle for 'damage over time' numbers",
        tooltipThrottleHot                  = "Set the throttle for 'heal over time' numbers",
        tooltipThrottleTrailer              = "Enable throttle trailer",
        tooltipThrottleCritical             = "Enable throttle for critical hits",
}