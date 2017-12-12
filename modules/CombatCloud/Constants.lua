CombatCloudConstants = {
---------------------------------------------------------------------------------------------------------------------------------------
    --//DAMAGE & HEALING//--
---------------------------------------------------------------------------------------------------------------------------------------
    isDamage = {
        [ACTION_RESULT_DAMAGE]              = true,
        [ACTION_RESULT_FALL_DAMAGE]         = true,
    },
	isDamageCritical = {
		[ACTION_RESULT_CRITICAL_DAMAGE]     = true,
	},
    isHealing = {
        [ACTION_RESULT_HEAL]                = true,
    },
	isHealingCritical = {
        [ACTION_RESULT_CRITICAL_HEAL]       = true,
    },
    isEnergize = {
        [ACTION_RESULT_POWER_ENERGIZE]      = true,
    },
    isDrain = {
        [ACTION_RESULT_POWER_DRAIN]         = true,
    },
    isDot = {
        [ACTION_RESULT_DOT_TICK]            = true,
    },
	isDotCritical = {
        [ACTION_RESULT_DOT_TICK_CRITICAL]   = true,
    },
    isHot = {
        [ACTION_RESULT_HOT_TICK]            = true,
    },
	isHotCritical = {
        [ACTION_RESULT_HOT_TICK_CRITICAL]   = true,
    },
    damageType = {
        [DAMAGE_TYPE_NONE]                  = true,
        [DAMAGE_TYPE_GENERIC]               = true,
        [DAMAGE_TYPE_PHYSICAL]              = true,
        [DAMAGE_TYPE_FIRE]                  = true,
        [DAMAGE_TYPE_SHOCK]                 = true,
        [DAMAGE_TYPE_OBLIVION]              = true,
        [DAMAGE_TYPE_COLD]                  = true,
        [DAMAGE_TYPE_EARTH]                 = true,
        [DAMAGE_TYPE_MAGIC]                 = true,
        [DAMAGE_TYPE_DROWN]                 = true,
        [DAMAGE_TYPE_DISEASE]               = true,
        [DAMAGE_TYPE_POISON]                = true,
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//MITIGATION//--
---------------------------------------------------------------------------------------------------------------------------------------
    isMiss = {
        [ACTION_RESULT_MISS]                = true,
    },
    isImmune = {
        [ACTION_RESULT_IMMUNE]              = true,
    },
    isParried = {
        [ACTION_RESULT_PARRIED]             = true,
    },
    isReflected = {
        [ACTION_RESULT_REFLECTED]           = true,
    },
    isDamageShield = {
        [ACTION_RESULT_DAMAGE_SHIELDED]     = true,
    },
    isDodged = {
        [ACTION_RESULT_DODGED]              = true,
    },
    isBlocked = {
        [ACTION_RESULT_BLOCKED_DAMAGE]      = true,
    },
    isInterrupted = {
        [ACTION_RESULT_INTERRUPT]           = true,
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//CROWD CONTROL//--
---------------------------------------------------------------------------------------------------------------------------------------
--WHAT IS ACTION RESULT FOR SNARE AND IMMOBILIZE?? ROOTED DOES NOT WORK
    isDisoriented = {
        [ACTION_RESULT_DISORIENTED]         = true,
    },
    isFeared = {
        [ACTION_RESULT_FEARED]              = true,
    },
    isOffBalanced = {
        [ACTION_RESULT_OFFBALANCE]          = true,
    },
    isSilenced = {
        [ACTION_RESULT_SILENCED]            = true,
    },
    isStunned = {
        [ACTION_RESULT_STUNNED]             = true,
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//PLAYER CHECKS//--
---------------------------------------------------------------------------------------------------------------------------------------
    isPlayer = {
        [COMBAT_UNIT_TYPE_PLAYER]           = true,
        [COMBAT_UNIT_TYPE_PLAYER_PET]       = true,
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//EVENT TYPES//--
---------------------------------------------------------------------------------------------------------------------------------------
    eventType = {
        ALERT                       = "COMBATCLOUD_EVENT_ALERT",
        COMBAT                      = "COMBATCLOUD_EVENT_COMBAT",
        POINT                       = "COMBATCLOUD_EVENT_POINT",
        CROWDCONTROL                = "COMBATCLOUD_EVENT_CROWDCONTROL",
        RESOURCE                    = "COMBATCLOUD_EVENT_RESOURCE",
    },
    alertType = {
        CLEANSE                     = "COMBATCLOUD_ALERT_TYPE_CLEANSE",
        BLOCK                       = "COMBATCLOUD_ALERT_TYPE_BLOCK",
        BLOCKSTAGGER                = "COMBATCLOUD_ALERT_TYPE_BLOCKSTAGGER",
        EXPLOIT                     = "COMBATCLOUD_ALERT_TYPE_EXPLOIT",
        INTERRUPT                   = "COMBATCLOUD_ALERT_TYPE_INTERRUPT",
        DODGE                       = "COMBATCLOUD_ALERT_TYPE_DODGE",
        EXECUTE                     = "COMBATCLOUD_ALERT_TYPE_EXECUTE",
    },
    combatType = {
        INCOMING                    = "COMBATCLOUD_COMBAT_TYPE_INCOMING",
        OUTGOING                    = "COMBATCLOUD_COMBAT_TYPE_OUTGOING",
    },
    crowdControlType = {
        DISORIENTED                 = "COMBATCLOUD_CROWDCONTROL_TYPE_DISORIENTED",
        FEARED                      = "COMBATCLOUD_CROWDCONTROL_TYPE_FEARED",
        OFFBALANCED                 = "COMBATCLOUD_CROWDCONTROL_TYPE_OFFBALANCED",
        SILENCED                    = "COMBATCLOUD_CROWDCONTROL_TYPE_SILENCED",
        STUNNED                     = "COMBATCLOUD_CROWDCONTROL_TYPE_STUNNED",
    },
    pointType = {
        ALLIANCE_POINTS             = "COMBATCLOUD_POINT_TYPE_ALLIANCE_POINTS",
        EXPERIENCE_POINTS           = "COMBATCLOUD_POINT_TYPE_EXPERIENCE_POINTS",
        CHAMPION_POINTS              = "COMBATCLOUD_POINT_TYPE_CHAMPION_POINTS",
        IN_COMBAT                   = "COMBATCLOUD_POINT_TYPE_IN_COMBAT",
        OUT_COMBAT                  = "COMBATCLOUD_POINT_TYPE_OUT_COMBAT",
    },
    resourceType = {
        LOW_HEALTH                  = "COMBATCLOUD_RESOURCE_TYPE_LOW_HEALTH",
        LOW_MAGICKA                 = "COMBATCLOUD_RESOURCE_TYPE_LOW_MAGICKA",
        LOW_STAMINA                 = "COMBATCLOUD_RESOURCE_TYPE_LOW_STAMINA",
        ULTIMATE                    = "COMBATCLOUD_RESOURCE_TYPE_ULTIMATE",
        POTION                      = "COMBATCLOUD_RESOURCE_TYPE_POTION",
    },
    poolType = {
        CONTROL                     = "COMBATCLOUD_POOL_TYPE_CONTROL",
        ANIMATION_CLOUD             = "COMBATCLOUD_POOL_TYPE_ANIMATION_CLOUD",
        ANIMATION_CLOUD_CRITICAL    = "COMBATCLOUD_POOL_TYPE_ANIMATION_CLOUD_CRITICAL",
        ANIMATION_CLOUD_FIREWORKS   = "COMBATCLOUD_POOL_TYPE_ANIMATION_CLOUD_FIREWORKS",
        ANIMATION_SCROLL            = "COMBATCLOUD_POOL_TYPE_ANIMATION_SCROLL",
        ANIMATION_SCROLL_CRITICAL   = "COMBATCLOUD_POOL_TYPE_ANIMATION_SCROLL_CRITICAL",
        ANIMATION_ELLIPSE_X         = "COMBATCLOUD_POOL_TYPE_ANIMATION_ELLIPSE_X",
        ANIMATION_ELLIPSE_Y         = "COMBATCLOUD_POOL_TYPE_ANIMATION_ELLIPSE_Y",
        ANIMATION_ELLIPSE_X_CRIT    = "COMBATCLOUD_POOL_TYPE_ANIMATION_ELLIPSE_X_CRITICAL",
        ANIMATION_ELLIPSE_Y_CRIT    = "COMBATCLOUD_POOL_TYPE_ANIMATION_ELLIPSE_Y_CRITICAL",
        ANIMATION_ALERT             = "COMBATCLOUD_POOL_TYPE_ANIMATION_ALERT",
        ANIMATION_COMBATSTATE       = "COMBATCLOUD_POOL_TYPE_ANIMATION_COMBATSTATE",
        ANIMATION_POINT             = "COMBATCLOUD_POOL_TYPE_ANIMATION_POINT",
        ANIMATION_RESOURCE          = "COMBATCLOUD_POOL_TYPE_ANIMATION_RESOURCE",
    },

---------------------------------------------------------------------------------------------------------------------------------------
    --//ANIMATION & FONTS//--
---------------------------------------------------------------------------------------------------------------------------------------
    outlineType                     = { "none", "outline", "thin-outline", "thick-outline", "shadow", "soft-shadow-thin", "soft-shadow-thick" },
    animationType                   = { "cloud", "hybrid", "scroll", "ellipse" },
    directionType                   = { "up", "down" },
    iconSide                        = { "none", "left", "right"},
}