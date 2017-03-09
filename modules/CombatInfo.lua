------------------
-- CombatInfo namespace
LUIE.CombatInfo     = {}

-- Performance Enhancement
local CI            = LUIE.CombatInfo
local UI            = LUIE.UI
local E             = LUIE.Effects
local DelayBuffer   = LUIE.DelayBuffer
local strformat     = zo_strformat
local strfmt        = string.format

local moduleName    = LUIE.name .. "_CombatInfo"

CI.Enabled  = false
CI.D = {
    position            = {},
  --HUDElements         = false,
    CoolDown            = false,
    UltimateEnabled     = true,
    UltimateHideFull    = true,
    UltimateAlert       = true,
    UltimateGeneration  = true,
    CloudTextEnabled    = true,
    ScrollTextEnabled   = false,
    FontFamily          = "Univers",
    FontCloudSizeLarge  = 36,
    FontCloudSizeMedium = 24,
    FontCloudSizeSmall  = 18,
    ShowIconsCloud      = true,
    FontScrollSizeLarge = 34,
    FontScrollSizeMedium= 28,
    FontScrollSizeSmall = 24,
    ShowIconsScroll     = true,
    PurgeExpiredScroll  = true,
    CombatEventsEnabled = true,
    DamageColoured      = true,
    ThrottleEnabled     = true,
    DotsInEnabled       = true,
    DotsOutEnabled      = true,
    HealingInEnabled    = true,
    HealingOutEnabled   = true,
    CombatCCEnabled     = true,
    DrainEnabled        = false,
    EnergizeEnabled     = true,
    ExperienceEnabled   = true,
    AllianceEnabled     = true,
    TelVarEnabled       = true,
    CombatTipsEnabled   = true,
    HideIngameTips      = true,
    GroupDeathEnabled   = true,
    LowEnabled          = true,
    LowThreshold        = 25,
    LowSound            = false,
    ExecuteEnabled      = false,
    ExecuteThreshold    = 20,
    ExecuteTimeout      = 8,
    CombatStateEnabled  = false,
}
CI.SV       = nil

local GetGameTimeMilliseconds = GetGameTimeMilliseconds
local GetUnitName             = GetUnitName
local GetUnitReaction         = GetUnitReaction
local IsUnitAttackable        = IsUnitAttackable
local IsSlotUsed              = IsSlotUsed
local GetSlotAbilityCost      = GetSlotAbilityCost

local g_printXP
local g_logKillXP

local fakeControl    = {}
local fifoQueue      = {} -- FIFO Queue data structure
local targetControls = {} -- Target areas controls
local throttleLabels = {} -- Throttle cached labels

-- Target areas controls for scrolling text
local g_scrollingControls  = {}
local g_scrollingAngle     = 0.5234 -- 30 deg
local g_scrollingSpeed     = 0.0175 --  1 deg
local g_scrollingRadius    = 1000

-- EXP
local g_combatXP                 = 0
local g_lastExp                  = 0 
local g_useChampionXP            = false
local g_cxpEnlightenedPool       = 0
local g_cxpEnlightenedMultiplier = nil
local g_ultimateCost             = 0
local g_ultimateCurrent          = 0
local g_ultimatAbilityName       = ""
local g_ultimatAbilityId         = 0
local g_ultimateNotReady         = false
local g_lastExecuteAlert         = {}
local g_ultimateSlot             = ACTION_BAR_ULTIMATE_SLOT_INDEX + 1

function fifoQueue.new()
    return {first = 0, last = -1}
end

function fifoQueue.pushLeft(list, value)
    local first = list.first - 1
    list.first = first
    list[first] = value
end

function fifoQueue.pushRight(list, value)
    local last = list.last + 1
    list.last = last
    list[last] = value
end

function fifoQueue.popLeft(list)
    local first = list.first
    if first > list.last then return nil end
    local value = list[first]
    list[first] = nil        -- To allow garbage collection
    list.first = first + 1
    return value
end

function fifoQueue.popRight(list)
    local last = list.last
    if list.first > last then return nil end
    local value = list[last]
    list[last] = nil         -- To allow garbage collection
    list.last = last - 1
    return value
end

function fifoQueue.getLeft(list)
    if list.first > list.last then
        return nil
    else
        return list[list.first]
    end
end

function fifoQueue.getRight(list)
    if list.first > list.last then
        return nil
    else
        return list[list.last]
    end
end

-- Default colours for text labels
CI.Colours = {
    RED         = { r = 1    , g = 0    , b = 0    },
    GREEN       = { r = 0    , g = 1    , b = 0    },
    BLUE        = { r = 0    , g = 0    , b = 1    },
    YELLOW      = { r = 1    , g = 1    , b = 0    },
    WHITE       = { r = 1    , g = 1    , b = 1    },
    BLACK       = { r = 0    , g = 0    , b = 0    },
    EXP         = { r = 0.07 , g = 0.45 , b = 0.80 },
    CP          = { r = 0.54 , g = 0.51 , b = 0.37 },
    AP          = { r = 0.16 , g = 0.86 , b = 0.13 },
    TELVAR      = { r = 0.37 , g = 0.64 , b = 1    },
    DAMAGE      = { r = 0.80 , g = 0.07 , b = 0.10 },
    DAMAGECRIT  = { r = 0.80 , g = 0.64 , b = 0.10 },
    HEAL        = { r = 0.07 , g = 0.80 , b = 0.45 },
    HEALCRIT    = { r = 0.03 , g = 0.85 , b = 0.27 },
    EXECUTE     = { r = 0.94 , g = 0.13 , b = 0.25 },
    MAGICKA     = { r = 0.14 , g = 0.59 , b = 0.78 },  --RGB(35, 150, 200)
    HEALTH      = { r = 0.80 , g = 0.07 , b = 0.10 },
  --STAMINA     = { r = 0.24 , g = 0.78 , b = 0.31 },  --RGB(60, 200, 80)
    STAMINA     = { r = 0.82 , g = 0.80 , b = 0.49 },  --RGB(210, 205, 125)
    ULTIMATE    = { r = 0.86 , g = 1    , b = 0.31 },  --RGB(220, 255, 80)
    BLOCKED     = { r = 0.24 , g = 0.78 , b = 0.31 },  --RGB(60, 200, 80)
    ABSORBED    = { r = 1    , g = 0.55 , b = 0.08 },  --RGB(255, 140, 20)
    DAMAGE_COLOURED = {
        [DAMAGE_TYPE_NONE]      = { r = 1, g = 1, b = 1 },                       --RGB(255, 255, 255)
        [DAMAGE_TYPE_GENERIC]   = { r = 1, g = 1, b = 1 },                       --RGB(255, 255, 255)
        [DAMAGE_TYPE_PHYSICAL]  = { r = 0.784314, g = 0.784314, b = 0.627451 },  --RGB(200, 200, 160)
        [DAMAGE_TYPE_FIRE]      = { r = 0.901961, g = 0.392157, b = 0.078431 },  --RGB(230, 100, 20)
        [DAMAGE_TYPE_SHOCK]     = { r = 0.588235, g = 0.392157, b = 0.784314 },  --RGB(150, 100, 200)
        [DAMAGE_TYPE_OBLIVION]  = { r = 0.784314, g = 0.215686, b = 0.529412 },  --RGB(200, 35, 135)
        [DAMAGE_TYPE_COLD]      = { r = 0.588235, g = 0.705882, b = 0.862745 },  --RGB(150, 180, 220)
        [DAMAGE_TYPE_EARTH]     = { r = 0.588235, g = 0.490196, b = 0.274510 },  --RGB(150, 125, 70)
        [DAMAGE_TYPE_MAGIC]     = { r = 0.137255, g = 0.588235, b = 0.784314 },  --RGB(35, 150, 200)
        [DAMAGE_TYPE_DROWN]     = { r = 0.274510, g = 0.666667, b = 1 },         --RGB(70, 170, 255)
        [DAMAGE_TYPE_DISEASE]   = { r = 0.392157, g = 0.784314, b = 0.588235 },  --RGB(100, 200, 150)
        [DAMAGE_TYPE_POISON]    = { r = 0.392157, g = 0.784314, b = 0.392157 }   --RGB(100, 200, 100)
    },
}


-- List of all damage results to be coloured into damage-dependent colour
local IsResultDamage = {
    [ACTION_RESULT_DAMAGE]            = true,
    [ACTION_RESULT_BLOCKED_DAMAGE]    = true,
    [ACTION_RESULT_CRITICAL_DAMAGE]   = true,
    [ACTION_RESULT_DOT_TICK]          = true,
    [ACTION_RESULT_DOT_TICK_CRITICAL] = true,
}

local IsResultDot = {
    [ACTION_RESULT_DOT_TICK]          = true,
    [ACTION_RESULT_DOT_TICK_CRITICAL] = true,
}

local IsResultHeal = {
    [ACTION_RESULT_HEAL]                = true,
    [ACTION_RESULT_CRITICAL_HEAL]       = true,
    [ACTION_RESULT_HOT_TICK]            = true,
    [ACTION_RESULT_HOT_TICK_CRITICAL]   = true,
}

local IsResultCritical = {
    [ACTION_RESULT_CRITICAL_DAMAGE]     = true,
    [ACTION_RESULT_DOT_TICK_CRITICAL]   = true,
    [ACTION_RESULT_CRITICAL_HEAL]       = true,
    [ACTION_RESULT_HOT_TICK_CRITICAL]   = true,
}

local IsResultCC = {
    [ACTION_RESULT_IMMUNE]      = true,
    [ACTION_RESULT_DODGED]      = true,
    [ACTION_RESULT_INTERRUPT]   = true,
    [ACTION_RESULT_STUNNED]     = true,
    [ACTION_RESULT_MISS]        = true,
    [ACTION_RESULT_REFLECTED]   = true,
}

-- Contains fonts for Combat Info module
-- Has to be supplied with other fonts during game play
local Font = {
    FontinSCLarge = "/LuiExtended/media/fonts/fontin_sans_sc.otf|36|soft-shadow-thick",
}

-- Used can select font face this families
CI.FontFamilies = {
    ["Fontin"] = {
        ["FontBold"]    = "/LuiExtended/media/fonts/fontin_sans_b.otf",
        ["FontRegular"] = "/LuiExtended/media/fonts/fontin_sans_r.otf",
    },
    ["Futura Condensed"] = {
        ["FontBold"]    = "/EsoUi/Common/Fonts/FTN87.otf",
        ["FontRegular"] = "/EsoUi/Common/Fonts/FTN57.otf",
    },
    ["Univers"] = {
        ["FontBold"]    = "$(BOLD_FONT)",
        ["FontRegular"] = "$(MEDIUM_FONT)",
    },
}

-- Config with variables for this module
-- Definition for different areas with scrolling text
local combatTargets = {
    Target = {
        labelsMax           = 30,
        showIcon            = true,
        animateAlpha        = true,
        animateY            = -3, -- **
        animateX            = 0,
        animateTime         = 2250,
        fixedTime           = 0,
        fixedScaleDown      = false,
        alignIcon           = RIGHT,
        alignIconTarget     = LEFT,
        alignIconOffsetX    = -4,
        alignIconOffsetY    = 0,
        sizeX               = 440,
        sizeY               = 330,
        default_position    = {CENTER,CENTER,0,-170},
        grid                = {4,3},
        throttleOption      = true,
    },
    TargetInfo = {
        labelsMax           = 20,
        showIcon            = true,
        animateAlpha        = true,
        animateY            = -3, -- **
        animateX            = 0,
        animateTime         = 2250,
        fixedTime           = 0,
        fixedScaleDown      = false,
        alignIcon           = RIGHT,
        alignIconTarget     = LEFT,
        alignIconOffsetX    = -4,
        alignIconOffsetY    = 0,
        sizeX               = 500,
        sizeY               = 200,
        default_position    = {CENTER,CENTER,0,-320},
        grid                = {3,1},
        throttleOption      = true,
    },
    PlayerDrainEnergize = {
        labelsMax           = 20,
        showIcon            = true,
        animateAlpha        = true,
        animateY            = 1,
        animateX            = 0,
        animateTime         = 2000,
        fixedTime           = 0,
        fixedScaleDown      = false,
        sizeX               = 500,
        sizeY               = 150,
        default_position    = {CENTER,CENTER,0,270},
        grid                = {3,2},
    },
    Alerts = {
        allwaysPresent      = true,
        labelsMax           = 20,
        showIcon            = false,
        animateAlpha        = true,
        animateY            = -1,
        animateX            = 0,
        animateTime         = 3000,
        fixedTime           = 500,
        fixedScaleDown      = true,
        sizeX               = 400,
        sizeY               = 300,
        default_position    = {CENTER,CENTER,500,-100},
        grid                = {4,3},
    },
    CombatState = {
        allwaysPresent      = true,
        labelsMax           = 5,
        showIcon            = false,
        animateAlpha        = true,
        animateY            = 0,
        animateX            = 0,
        animateTime         = 1500,
        fixedTime           = 700,
        fixedScaleDown      = true,
        sizeX               = 400,
        sizeY               = 70,
        default_position    = {CENTER,CENTER,600,-450},
    },
    CombatXP = { -- Display box for XP value gained during last combat
        allwaysPresent      = true,
        parent              = "CombatState",
        showIcon            = false,
        animateAlpha        = true,
        animateY            = 0,
        animateX            = 0,
        animateTime         = 1000,
        fixedTime           = 500,
        fixedScaleDown      = true,
        alignOffsetY        = 40,
    },
    Player = {
        labelsMax           = 40,
        sizeX               = 250,
        sizeY               = 500,
        default_position    = {CENTER,CENTER,-550,0},
    },
    PlayerDown = {
        parent              = "Player",
        showIcon            = true,
        animateAlpha        = true,
        animateY            = 3,
        animateX            = 0,
        animateTime         = 2250, -- 4000,
        fixedTime           = 0,
        fixedScaleDown      = false,
        alignIcon           = LEFT,
        alignIconTarget     = RIGHT,
        alignIconOffsetX    = 4, -- 10,
        alignIconOffsetY    = 0,
        grid                = {3,2},
        alignOffsetY        = 80,
    },
    PlayerUp = {
        parent              = "Player",
        showIcon            = true,
        animateAlpha        = true,
        animateY            = -3,
        animateX            = 0,
        animateTime         = 2250, -- 4000,
        fixedTime           = 0,
        fixedScaleDown      = false,
        alignIcon           = LEFT,
        alignIconTarget     = RIGHT,
        alignIconOffsetX    = 4, -- 10,
        alignIconOffsetY    = 0,
        grid                = {3,2},
        alignOffsetY        = -80,
        throttleOption      = true,
    },
    Other = {
        labelsMax           = 40,
        sizeX               = 250,
        sizeY               = 500,
        default_position    = {CENTER,CENTER,550,0},
    },
    OtherDown = {
        parent              = "Other",
        showIcon            = true,
        animateAlpha        = true,
        animateY            = 3,
        animateX            = 0,
        animateTime         = 2250, -- 4000,
        fixedTime           = 0,
        fixedScaleDown      = false,
        alignIcon           = RIGHT,
        alignIconTarget     = LEFT,
        alignIconOffsetX    = -4, -- -10,
        alignIconOffsetY    = 0,
        grid                = {3,2},
        alignOffsetY        = 80,
    },
    OtherUp = {
        parent              = "Other",
        showIcon            = true,
        animateAlpha        = true,
        animateY            = -3,
        animateX            = 0,
        animateTime         = 2250, -- 4000,
        fixedTime           = 0,
        fixedScaleDown      = false,
        alignIcon           = RIGHT,
        alignIconTarget     = LEFT,
        alignIconOffsetX    = -4, -- -10,
        alignIconOffsetY    = 0,
        grid                = {3,2},
        alignOffsetY        = -80,
        throttleOption      = true,
    },
}

local lowAlertText = {
    [POWERTYPE_HEALTH]  = "Low Health!",
    [POWERTYPE_MAGICKA] = "Low Magicka!",
    [POWERTYPE_STAMINA] = "Low Stamina!",
}

-- Events routing definition
local combatEvents = {
    ["custom"] = { -- Custom triggers
        [COMBAT_UNIT_TYPE_PLAYER] = { -- Source is always PLAYER
            ["exp"] = { -- Experience gain
                target = "TargetInfo",
                colour = CI.Colours.EXP,
                font   = "Large",
                strfmt = "+%4$d %3$s",
                animateScaleUp = {0.9, 1.15},
                scrolling = "Incoming",
            },
            ["ap"] = { -- Alliance points gain
                target = "TargetInfo",
                colour = CI.Colours.AP,
                font   = "Medium",
                strfmt = "+%4$d AP",
                scrolling = "Incoming",
            },
            ["telvar"] = { -- TelVar stones gain
                target = "TargetInfo",
                colour = CI.Colours.TELVAR,
                font   = "Medium",
                strfmt = "+%4$d TS",
                scrolling = "Incoming",
            },
            ["combatTip"] = { -- Active Combat Tips
                target = "Alerts",
                colour = {
                    [POWERTYPE_HEALTH]      = CI.Colours.HEALTH,    -- Low Health alert
                    [POWERTYPE_MAGICKA]     = CI.Colours.MAGICKA,   -- Low Magicka alert
                    [POWERTYPE_STAMINA]     = CI.Colours.STAMINA,   -- Low Stamina alert
                    [POWERTYPE_ULTIMATE]    = CI.Colours.ULTIMATE,  -- Low Ultimate Ready, Potion Ready alert
                --  [POWERTYPE_COMBO]       = CI.Colours.EXECUTE,   -- Low Execute Now alert
                    [POWERTYPE_INVALID]     = CI.Colours.YELLOW,    -- Default alert colour
                },
                font   = "FontinSCLarge",
                strfmt = "%2$s", -- sourceName is actually text to display
                deadtime = true,
            },
            ["unitDeath"] = { -- Group member death
                target = "Alerts",
                colour = CI.Colours.HEALTH,
                font   = "Medium",
                strfmt = "%3$s died", -- targetName here
            },
            ["combatState"] = { -- Combat State Change
                target = "CombatState",
                colour = CI.Colours.WHITE,
                font   = "FontinSCLarge",
                strfmt = "%3$s", -- targetName is actually text to display
            },
            ["combatXP"] = { -- Combat experience
                target = "CombatXP",
                colour = CI.Colours.EXP,
                font   = "Medium",
                strfmt = "%4$d XP",
            },
        },
    },
    [ACTION_RESULT_DAMAGE] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "%1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.DAMAGE,
                font   = "Medium",
                strfmt = "%1$d",
                scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.DAMAGE,
                font   = "Medium",
                strfmt = "%1$d pet",
                scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_BLOCKED_DAMAGE] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.BLOCKED,
                font   = "Regular",
                strfmt = "%6$sBLOCKED|r %1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.BLOCKED,
                font   = "Medium",
                strfmt = "%1$d %6$sBLOCKED|r",
                scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.BLOCKED,
                font   = "Medium",
                strfmt = "%1$d %6$sBLOCKED|r pet",
                scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_DAMAGE_SHIELDED] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.ABSORBED,
                font   = "Regular",
                strfmt = "ABSORBED %1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.ABSORBED,
                font   = "Regular",
                strfmt = "(%1$d)",
                scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.ABSORBED,
                font   = "Regular",
                strfmt = "(%1$d) pet",
                scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_MISS] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "Missed",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.DAMAGE,
                font   = "Medium",
                strfmt = "MISS",
                scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_REFLECTED] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "REFLECTED",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.DAMAGE,
                font   = "Large",
                strfmt = "REFLECTED",
            },
        },
    },
    [ACTION_RESULT_FALL_DAMAGE] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "FALL DAMAGE %1$d",
                scrolling = "Incoming",
            },
        },
    },
    [ACTION_RESULT_CRITICAL_DAMAGE] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.DAMAGECRIT,
                font   = "Regular",
                strfmt = "%1$d %5$sCRIT|r",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.DAMAGECRIT,
                font   = "Large",
                strfmt = "%1$d %5$sCRIT|r", --"%1$d CRITICAL",
                animateScaleUp = {0.7, 1.05},
                scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                target = "Target",
                colour = CI.Colours.DAMAGECRIT,
                font   = "Large",
                strfmt = "%1$d %5$sCRIT|r pet", --"%1$d PET CRITICAL",
                animateScaleUp = {0.7, 1.05},
                scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_DOT_TICK] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "DotsInEnabled",
                target = "PlayerDown",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "-%1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "DotsOutEnabled",
                target = "Target",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "-%1$d",
                scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "DotsOutEnabled",
                target = "Target",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "-%1$d pet",
                scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_DOT_TICK_CRITICAL] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "DotsInEnabled",
                target = "PlayerDown",
                colour = CI.Colours.DAMAGECRIT,
                font   = "Regular",
                strfmt = "-%1$d %5$sCRIT|r",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "DotsOutEnabled",
                target = "Target",
                colour = CI.Colours.DAMAGECRIT,
                font   = "Regular",
                strfmt = "-%1$d %5$sCRIT|r", --"-%1$d CRITICAL",
                animateScaleUp = {1, 1.1},
                scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "DotsOutEnabled",
                target = "Target",
                colour = CI.Colours.DAMAGECRIT,
                font   = "Regular",
                strfmt = "-%1$d %5$sCRIT|r pet", --"PET CRITICAL -%1$d",
                animateScaleUp = {1, 1.1},
                scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_HEAL] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "%1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "%1$d",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "%1$d",
              --scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "%1$d pet",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "%1$d pet",
              --scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_CRITICAL_HEAL] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "%1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "%1$d",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "%1$d",
                animateScaleUp = {1, 1.1}, -- This have to be decided
              --scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "%1$d pet",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "%1$d pet",
                animateScaleUp = {1, 1.1}, -- This have to be decided
              --scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_HOT_TICK] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "+%1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "+%1$d",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "+%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "+%1$d",
              --scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "+%1$d pet",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "+%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEAL,
                font   = "Regular",
                strfmt = "+%1$d pet",
              --scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_HOT_TICK_CRITICAL] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "+%1$d",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "+%1$d",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "+%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "+%1$d",
                animateScaleUp = {1, 1.1}, -- This have to be decided
              --scrolling = "Outgoing",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER_PET] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "OtherUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "+%1$d pet",
              --scrolling = "Outgoing",
            },
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "HealingInEnabled",
                target = "PlayerUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "+%1$d",
                scrolling = "Incoming",
            },
            [COMBAT_UNIT_TYPE_GROUP] = {
                savedVarsFilter = "HealingOutEnabled",
                target = "Target",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "+%1$d pet",
                animateScaleUp = {1, 1.1}, -- This have to be decided
              --scrolling = "Outgoing",
            },
        },
    },
    [ACTION_RESULT_DODGED] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerUp",
                colour = CI.Colours.HEALCRIT,
                font   = "Regular",
                strfmt = "Dodged",
                deadtime = true,
                scrolling = "Incoming",
            },
        },
    },
    [ACTION_RESULT_INTERRUPT] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "INTERRUPTED",
                scrolling = "Incoming",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "CombatCCEnabled",
                target = "TargetInfo",
                colour = CI.Colours.WHITE,
                font   = "Regular",
                strfmt = "Interrupted (%3$s)",
            },
        },
    },
    [ACTION_RESULT_STUNNED] = {
        [COMBAT_UNIT_TYPE_NONE] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                target = "PlayerDown",
                colour = CI.Colours.DAMAGE,
                font   = "Regular",
                strfmt = "STUNNED",
            },
        },
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_NONE] = {
                savedVarsFilter = "CombatCCEnabled",
                target = "TargetInfo",
                colour = CI.Colours.WHITE,
                font   = "Regular",
                strfmt = "Stunned (%3$s)",
            },
        },
    },
    [ACTION_RESULT_POWER_ENERGIZE] = {
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "EnergizeEnabled",
                powers = {
                    [POWERTYPE_MAGICKA]       = true,
                    [POWERTYPE_HEALTH]        = true,
                    [POWERTYPE_STAMINA]       = true,
                  --[POWERTYPE_ULTIMATE]      = true,
                },
                target = "PlayerDrainEnergize",
                colour = {
                    [POWERTYPE_MAGICKA]       = CI.Colours.MAGICKA,
                    [POWERTYPE_HEALTH]        = CI.Colours.HEALTH,
                    [POWERTYPE_STAMINA]       = CI.Colours.STAMINA,
                    [POWERTYPE_ULTIMATE]      = CI.Colours.ULTIMATE,
                },
                font   = "Medium",
                strfmt = {
                    [POWERTYPE_MAGICKA]       = "+%4$d (Magicka restored)",
                    [POWERTYPE_HEALTH]        = "+%4$d (Health restored)",
                    [POWERTYPE_STAMINA]       = "+%4$d (Stamina restored)",
                    [POWERTYPE_ULTIMATE]      = "+%4$d (Ultimate restored)",
                },
                scrolling = "Incoming",
            },
        },
    },
    [ACTION_RESULT_POWER_DRAIN] = {
        [COMBAT_UNIT_TYPE_PLAYER] = {
            [COMBAT_UNIT_TYPE_PLAYER] = {
                savedVarsFilter = "DrainEnabled",
                powers = {
                    [POWERTYPE_MAGICKA]       = true,
                    [POWERTYPE_HEALTH]        = true,
                    [POWERTYPE_STAMINA]       = true,
                  --[POWERTYPE_MOUNT_STAMINA] = true,
                  --[POWERTYPE_ULTIMATE]      = true,
                },
                target = "PlayerDrainEnergize",
                colour = {
                    [POWERTYPE_MAGICKA]       = CI.Colours.MAGICKA,
                    [POWERTYPE_HEALTH]        = CI.Colours.HEALTH,
                    [POWERTYPE_STAMINA]       = CI.Colours.STAMINA,
                    [POWERTYPE_MOUNT_STAMINA] = CI.Colours.STAMINA,
                    [POWERTYPE_ULTIMATE]      = CI.Colours.ULTIMATE,
                },
                font   = "Medium",
                strfmt = {
                    [POWERTYPE_MAGICKA]       = "-%4$d (Magicka drained)",
                    [POWERTYPE_HEALTH]        = "-%4$d (Health drained)",
                    [POWERTYPE_STAMINA]       = "-%4$d (Stamina drained)",
                    [POWERTYPE_MOUNT_STAMINA] = "-%4$d (Mount Stamina drained)",
                    [POWERTYPE_ULTIMATE]      = "-%4$d (Ultimate drained)",
                },
                scrolling = "Incoming",
            },
        },
    },
}

--[[
 * Some comments about healing redirection:
 *
 * All incoming healing (to player) from all sources goes to PlayerUp,
 * Ignore all healing towards PET
 * All healing towards non-group targets ( _NONE, _OTHER ) to OtherUp,
 * All outgoing healing towards group members - to central Target area
 ]]--

-- Used to parse formatted text out of previous definitions
local function StringFormat( fmt, ... )
    local fmt, args, order = fmt, {...}, {}
    if args[1] > 1000000 then
        args[1] = args[1]/1000000
        fmt = fmt:gsub("%%1%$d", "%%1$.1fkk")
    elseif args[1] > 1000 then
        args[1] = args[1]/1000
        fmt = fmt:gsub("%%1%$d", "%%1$.1fk")
    end
    fmt = fmt:gsub("%%(%d+)%$", function( i ) table.insert( order, args[ tonumber( i ) ] ) return "%" end)
    return strfmt( fmt, unpack( order ) ) -- table.unpack for lua 5.2 / unpack for 5.1 or lower
end

-- Cooldowns overlay
local uiCooldown    = {
    colour  = {0.941, 0.973, .957},
    timeColours = {
        [1] = {remain = 600, colour = {0.878, 0.941, 0.251}},
        [2] = {remain = 400, colour = {0.941, 0.565, 0.251}},
        [3] = {remain = 200, colour = {0.941, 0.251, 0.125}},
    },
}
-- Quickslot
local uiQuickSlot   = {
    colour  = {0.941, 0.565, 0.251},
    timeColours = {
        [1] = {remain = 15000, colour = {0.878, 0.941, 0.251}},
        [2] = {remain =  5000, colour = {0.251, 0.941, 0.125}},
    },
}
-- Ultimate slot
local uiUltimate = {
    colour  = {0.941, 0.973, .957},
    pctColours = {
        [1] = {pct =100, colour = {0.878, 0.941, 0.251}},
        [2] = {pct = 80, colour = {0.941, 0.565, 0.251}},
        [3] = {pct = 50, colour = {0.941, 0.251, 0.125}},
    },
    FadeTime = 0,
    NotFull = false,
}

-- Low attribute tracker
CI.thresholdAttribute   = 0
CI.thresholdExecute     = 0
local g_powerPools = {
    [POWERTYPE_HEALTH]  = 0,
    [POWERTYPE_MAGICKA] = 0,
    [POWERTYPE_STAMINA] = 0,
}

-- Module initialization
function CI.Initialize( enabled )
    -- Load settings
    CI.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "CombatInfo", CI.D )

    -- Prepare hex values of colours. We beed to do it before aborting initialization
    for k, v in pairs(CI.Colours) do
        if k ~= "DAMAGE_COLOURED" then
            v.hex = "|c" .. ZO_ColorDef:New(v.r, v.g, v.b):ToHex()
        end
    end
    for _, v in pairs(CI.Colours.DAMAGE_COLOURED) do
        v.hex = "|c" .. ZO_ColorDef:New(v.r, v.g, v.b):ToHex()
    end

    -- If User does not want the Combat Info then exit right here
    if not enabled then return end
    CI.Enabled = true

    CI.thresholdAttribute = 0.01 * CI.SV.LowThreshold
    CI.thresholdExecute = 0.01 * CI.SV.ExecuteThreshold

    -- Prepare fonts to use in Combat Info
    CI.PrepareFonts(false)

    -- Set controls
    local tlw = UI.TopLevel( {CENTER,CENTER}, nil )

    -- Add control to global list so it can be hidden
    LUIE.components[ moduleName ] = tlw
    LUIE.components[ moduleName .. "_FakeControl" ] = fakeControl

    --[[--
    LUIE_CombatInfo_HUDElements:SetHidden( not CI.SV.HUDElements )

    -- Set control defaults
    LUIE_CombatInfo_Labels_PlayerDivider:SetAddressMode( TEX_MODE_CLAMP )
    LUIE_CombatInfo_Labels_PlayerDivider:SetBlendMode( TEX_BLEND_MODE_ADD )
    LUIE_CombatInfo_Labels_PlayerDivider:SetColor( CI.Colours.WHITE.r, CI.Colours.WHITE.g, CI.Colours.WHITE.b, LUIE_CombatInfo_Labels_PlayerDivider:GetAlpha() )
    LUIE_CombatInfo_Labels_OtherDivider:SetAddressMode( TEX_MODE_CLAMP )
    LUIE_CombatInfo_Labels_OtherDivider:SetBlendMode( TEX_BLEND_MODE_ADD )
    LUIE_CombatInfo_Labels_OtherDivider:SetColor( CI.Colours.WHITE.r, CI.Colours.WHITE.g, CI.Colours.WHITE.b, LUIE_CombatInfo_Labels_OtherDivider:GetAlpha() )
    --]]--

    -- Iterate over combatTargets table to...
    for key, config in pairs(combatTargets) do
        -- Create controls only if requested or for required elements
        if config.allwaysPresent or CI.SV.CloudTextEnabled then
            local sizeX, sizeY
            -- If this is main control window
            if config.parent == nil then
                sizeX = config.sizeX
                sizeY = config.sizeY
                -- Create CT_CONTROL to hold labels
                local control = UI.Control( tlw, nil, { sizeX, sizeY }, false )
                -- Save position
                control:SetHandler( "OnMoveStop", function(self) CI.SV.position[key] = { self:GetLeft(), self:GetTop() } end )
                -- Create preview
                control.preview = UI.ChatBackdrop( control, "fill", nil, nil, 20, true )
                control.previewLabel = UI.Label( control.preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", key, false )

                -- Create empty table where we will store all dynamically created labels
                control.floatingLabels = {}
                -- Put initial number of last used dynamic label
                control.lastUsedLabel = 0
                -- Store this control
                targetControls[ key ] = control

            -- Otherwise this is a subsection of other control and
            -- We do not need to create any controls, we only need to define labels grid
            else
                sizeX = combatTargets[config.parent].sizeX
                sizeY = combatTargets[config.parent].sizeY
            end

            -- Define label grid
            local grid = ( config.grid ~= nil and #config.grid == 2 ) and config.grid or { 1, 1 }
            local gridSize = math.min( sizeX / grid[1], sizeY / grid[2] )
            config.grid = {
                last = 0,
                max = grid[1] * grid[2],
                size = gridSize,
            }
            for j = 1, grid[2] do
                local y = j + math.floor( grid[2] / 2 )
                if y > grid[2] then y = y - grid[2] end
                for i = 1, grid[1] do
                    local x = i + math.floor( grid[1] / 2 )
                    if x > grid[1] then x = x - grid[1] end

                    config.grid[ i + (j-1)*grid[1] ] = { x - 0.5*(grid[1]+1), y - 0.5*(grid[2]+1) } -- grid around point "0,0"
                end
            end
        end
    end
    -- Now when target areas are created we have to position them
    CI.SetTlwPosition()

    if CI.SV.ScrollTextEnabled then
        local disp_w = GuiRoot:GetWidth()
        local disp_h = GuiRoot:GetHeight()
        local scr_w = disp_w / 6
        local scr_h = disp_h * 2 / 3

        g_scrollingAngle = math.asin( 2 * disp_h / 3 / disp_w )
        g_scrollingSpeed = g_scrollingAngle / 60
        g_scrollingRadius = disp_w / 2

        for index, key in ipairs({ "Incoming", "Outgoing" }) do

            local curve = (index==1) and (-1) or 1

            -- Create CT_CONTROL to hold labels
            local control = UI.Control( tlw, {CENTER,CENTER,curve*disp_w/4,0}, { scr_w, scr_h }, false )
            -- Curve of labels
            control.curve = curve
            -- Save position
            --control:SetHandler( "OnMoveStop", function(self) CI.SV.position["scrolling" .. key] = { self:GetLeft(), self:GetTop() } end )
            -- Create preview
            control.preview = UI.Texture( control, "fill", nil, "/esoui/art/miscellaneous/inset_bg.dds", DL_BACKGROUND, true )
            control.previewLabel = UI.Label( control.preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", "Scrolling " .. key .. "\n(Fixed Position)", false )

            -- Create empty table where we will store all dynamically created labels
            control.floatingLabels = {}
            -- Put initial number of last used dynamic label
            control.lastUsedLabel = 0
            -- Maximum labels to create
            control.labelsMax = 40

            -- Events queue
            control.eventsQueue = fifoQueue.new()
            -- Next slot ready
            control.eventsQueueNext = true

            g_scrollingControls[ key ] = control
        end
    end

    -- Set ability cooldown controls
    for actionButtonNum = 3, 7 do
        local parent = ZO_ActionBar_GetButton(actionButtonNum).slot
        local bg = UI.Texture( parent, nil, nil, nil, DL_OVERLAY, true )
        bg:SetAnchor(TOPLEFT, parent:GetNamedChild("FlipCard"))
        bg:SetAnchor(BOTTOMRIGHT, parent:GetNamedChild("FlipCard"))
        --:SetAlpha( 0.55 )
        uiCooldown[ actionButtonNum ] = {}
        uiCooldown[ actionButtonNum ].bg = bg
        uiCooldown[ actionButtonNum ].label = UI.Label( bg, {CENTER,CENTER}, nil, nil, "$(BOLD_FONT)|24|soft-shadow-thin", nil, true )
        uiCooldown[ actionButtonNum ].label:SetColor(unpack(uiCooldown.colour))
    end

    uiQuickSlot.label = UI.Label( ActionButton9, {CENTER,CENTER}, nil, nil, "$(MEDIUM_FONT)|18|outline", nil, true )
    uiQuickSlot.label:SetColor(unpack(uiQuickSlot.colour))
    uiQuickSlot.label:SetDrawLayer( DL_OVERLAY )
    uiQuickSlot.label:SetDrawTier( DT_HIGH )
    -- FIXME: This stopped working with Update 1.7.0
    --ActionButton9CountText:SetFont("/EsoUI/Common/Fonts/FTN87.otf|14|soft-shadow-thin")

    -- Create Ultimate overlay labels
    uiUltimate.LabelVal = UI.Label( ActionButton8, {BOTTOM,TOP,0,-3}, nil, {1,2}, "$(BOLD_FONT)|16|soft-shadow-thick", nil, true )
    uiUltimate.LabelPct = UI.Label( ActionButton8, {CENTER,CENTER}, nil, nil, "$(BOLD_FONT)|20|outline", nil, true )
    uiUltimate.LabelPct:SetColor( unpack(uiUltimate.colour) )
    -- And buff texture
    uiUltimate.Texture = UI.Texture( ActionButton8, {CENTER,CENTER}, {160,160}, "/esoui/art/crafting/white_burst.dds", DL_BACKGROUND, true )

    -- Update function
    EVENT_MANAGER:RegisterForUpdate(moduleName, 40, CI.OnUpdate )
    EVENT_MANAGER:RegisterForUpdate(moduleName .. "_Scrolling", 20, CI.OnUpdateScrolling )

    -- set event handlers
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, CI.OnPlayerActivated )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ENLIGHTENED_STATE_GAINED, CI.OnEnlightenedState )
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ENLIGHTENED_STATE_LOST,   CI.OnEnlightenedState )

    CI.RegisterCombatEvent()
    EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, false )

    CI.RegisterPowerEvent()
    EVENT_MANAGER:AddFilterForEvent(moduleName .. "player", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG, "player" )
    EVENT_MANAGER:AddFilterForEvent(moduleName .."execute", EVENT_POWER_UPDATE, REGISTER_FILTER_UNIT_TAG, "reticleover" )

    CI.RegisterDeathEvent()
    EVENT_MANAGER:AddFilterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED, REGISTER_FILTER_UNIT_TAG_PREFIX, "group" )

    --g_printXP = LUIE.ChatAnnouncements.PrintXPChange
    g_logKillXP = LUIE.DamageMeter.LogExp

    CI.RegisterXPEvent()
    CI.RegisterAPEvent()
    CI.RegisterTSEvent()
    CI.RegisterCombatTipEvent()
    CI.RegisterCombatStateEvent()

    -- Debug: Synergy Icons
    --EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_SYNERGY_ABILITY_CHANGED,  CI._PrintFirstSynergyIcon )
end

-- Prepare fonts for Combat Info modules
function CI.PrepareFonts(doPreview)
    -- First make sure, that selected font family is known
    if CI.FontFamilies[ CI.SV.FontFamily ] == nil then
        CI.SV.FontFamily = CI.D.FontFamily
    end

    Font.CloudLarge   = CI.FontFamilies[ CI.SV.FontFamily ].FontBold    .. "|" .. CI.SV.FontCloudSizeLarge  .. "|soft-shadow-thin"
    Font.CloudMedium  = CI.FontFamilies[ CI.SV.FontFamily ].FontBold    .. "|" .. CI.SV.FontCloudSizeMedium .. "|soft-shadow-thin"
    Font.CloudRegular = CI.FontFamilies[ CI.SV.FontFamily ].FontRegular .. "|" .. CI.SV.FontCloudSizeSmall  .. "|soft-shadow-thin"

    Font.ScrollLarge   = CI.FontFamilies[ CI.SV.FontFamily ].FontRegular .. "|" .. CI.SV.FontScrollSizeLarge  .. "|soft-shadow-thin"
    Font.ScrollMedium  = CI.FontFamilies[ CI.SV.FontFamily ].FontRegular .. "|" .. CI.SV.FontScrollSizeMedium .. "|soft-shadow-thin"
    Font.ScrollRegular = CI.FontFamilies[ CI.SV.FontFamily ].FontRegular .. "|" .. CI.SV.FontScrollSizeSmall  .. "|soft-shadow-thin"

    -- Create several custom labels to show changes
    -- This also usually called from menu, so we need to unhide control areas
    if doPreview then
        LUIE.components[ moduleName ]:SetHidden(false)

        CI.OnCombatEvent( EVENT_COMBAT_EVENT, ACTION_RESULT_DAMAGE, false, "Example", "", 0, "Example Target", COMBAT_UNIT_TYPE_NONE, "Your Name", COMBAT_UNIT_TYPE_PLAYER, 3456, 0, DAMAGE_TYPE_PHYSICAL, false, 0, 0, 1 )

        CI.OnCombatEvent( EVENT_COMBAT_EVENT, ACTION_RESULT_DAMAGE, false, "Example", "", 0, "Your Name", COMBAT_UNIT_TYPE_PLAYER, "Example Target", COMBAT_UNIT_TYPE_NONE, 1234, 0, DAMAGE_TYPE_GENERIC, false, 0, 0, 1 )
        CI.OnCombatEvent( EVENT_COMBAT_EVENT, ACTION_RESULT_DOT_TICK, false, "Example Dot", "", 0, "Your Name", COMBAT_UNIT_TYPE_PLAYER, "Example Target", COMBAT_UNIT_TYPE_NONE, 567, 0, DAMAGE_TYPE_FIRE, false, 0, 0, 1 )
        CI.OnCombatEvent( EVENT_COMBAT_EVENT, ACTION_RESULT_CRITICAL_DAMAGE, false, "Example Crit", "", 0, "Your Name", COMBAT_UNIT_TYPE_PLAYER, "Example Target", COMBAT_UNIT_TYPE_NONE, 8900, 0, DAMAGE_TYPE_MAGIC, false, 0, 0, 1 )

        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "Combat Tip", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    end
end

function CI.ResetPosition()
    CI.SV.position = {}
    CI.SetTlwPosition()
end

-- Set position of window. Called from .Initialize() and .ResetTlwPosition()
-- This affects only player buffs
function CI.SetTlwPosition()
    if not CI.Enabled then
        return
    end

    for key, control in pairs(targetControls) do
        control:ClearAnchors()
        if CI.SV.position[key] and #CI.SV.position[key] == 2 then
            control:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, CI.SV.position[key][1], CI.SV.position[key][2] )
        else
            control:SetAnchor( combatTargets[key].default_position[1], GuiRoot, combatTargets[key].default_position[2], combatTargets[key].default_position[3], combatTargets[key].default_position[4] )
        end
    end
end

-- Unlock panel for moving. Called from Settings Menu.
function CI.SetMovingState( state )
    if not CI.Enabled then return end
    CI.panelUnlocked = state

    for _, control in pairs(targetControls) do
        control.preview:SetHidden( not state )
        control:SetMouseEnabled( state )
        control:SetMovable( state )
    end
    for _, control in pairs(g_scrollingControls) do
        control.preview:SetHidden( not state )
    end
end

-- Used to populate abilities icons after the used has logged on
function CI.OnPlayerActivated( eventCode )
    -- do not call this function for the second time
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED )

    -- Read all initial values
    g_useChampionXP = ( GetUnitChampionPoints( "player" ) == 16 )
    -- Initial experience is read in RegisterXPEvent()
    CI.OnEnlightenedState(nil)

    -- Manually trigger event to update stats
    CI.OnSlotsFullUpdate(nil)
    CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_HEALTH, GetUnitPower("player", POWERTYPE_HEALTH))
    CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_MAGICKA, GetUnitPower("player", POWERTYPE_MAGICKA))
    CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_STAMINA, GetUnitPower("player", POWERTYPE_STAMINA))
    CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_ULTIMATE, GetUnitPower("player", POWERTYPE_ULTIMATE))
end

-- Clear and then (maybe) re-register event listener for combat event
function CI.RegisterCombatEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_COMBAT_EVENT )
    if CI.SV.CombatEventsEnabled then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_COMBAT_EVENT, CI.OnCombatEvent )
    end
end

-- Clear and then (maybe) re-register event listener for experience gain event
function CI.RegisterXPEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_EXPERIENCE_UPDATE )
    if CI.SV.ExperienceEnabled then
        g_lastExp = GetUnitXP( "player" )
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_EXPERIENCE_UPDATE, CI.OnXPUpdate )
    end
end

-- Clear and then (maybe) re-register event listener for alliance points gain event
function CI.RegisterAPEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_ALLIANCE_POINT_UPDATE )
    if CI.SV.AllianceEnabled then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ALLIANCE_POINT_UPDATE, CI.OnAPUpdate )
    end
end

-- Clear and then (maybe) re-register event listener for telvar stones update event
function CI.RegisterTSEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_TELVAR_STONE_UPDATE )
    if CI.SV.TelVarEnabled then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_TELVAR_STONE_UPDATE, CI.OnTSUpdate )
    end
end

-- Rregister event listener for low attribute and ultimate tracking. Should be called only once!
function CI.RegisterPowerEvent()
    -- Register event
    EVENT_MANAGER:RegisterForEvent(moduleName .. "player", EVENT_POWER_UPDATE, CI.OnPowerUpdatePlayer)
    EVENT_MANAGER:RegisterForEvent(moduleName .."execute", EVENT_POWER_UPDATE, CI.OnPowerUpdateTarget)
    -- Those are only for ultimate tracking
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOTS_FULL_UPDATE, CI.OnSlotsFullUpdate)
    EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_ACTION_SLOT_UPDATED, function(eventCode, slotNum) if slotNum == g_ultimateSlot then CI.OnSlotsFullUpdate(eventCode) end end)
end

-- Clear and then (maybe) re-register event listener for combat tips alerts
function CI.RegisterCombatTipEvent()
    -- Clear event listener
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_DISPLAY_ACTIVE_COMBAT_TIP )
    -- If enabled, then
    if CI.SV.CombatTipsEnabled then
        -- Enable event listener
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_DISPLAY_ACTIVE_COMBAT_TIP, CI.OnDisplayActiveCombatTip )

        -- Force the in-game setting to send those events
        -- SetSetting( SETTING_TYPE_ACTIVE_COMBAT_TIP, 0, ACT_SETTING_ALWAYS )

        -- Hide ingame active combat tips (if requested)
        ZO_ActiveCombatTips:SetHidden(CI.SV.HideIngameTips)
    end
end

-- Clear and then (maybe) re-register event listener for group member death alerts
function CI.RegisterDeathEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED )
    if CI.SV.GroupDeathEnabled then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED, CI.OnDeath )
    end
end

-- Clear and then (maybe) re-register event listener for in/out combat state event
function CI.RegisterCombatStateEvent()
    EVENT_MANAGER:UnregisterForEvent(moduleName, EVENT_PLAYER_COMBAT_STATE )
    if CI.SV.CombatStateEnabled then
        EVENT_MANAGER:RegisterForEvent(moduleName, EVENT_PLAYER_COMBAT_STATE, CI.OnPlayerCombatState )
    end
end

-- Clear events queue for each field
function CI.ClearQueues()
    for _, control in pairs( g_scrollingControls ) do
        -- Create empty event queue tables
        control.eventsQueue = fifoQueue.new()
        -- Set next queue fire defaults
        control.eventsQueueNext = true
    end
end

-- Fake Component callback function used by main module
function fakeControl.SetHidden(self, hidden)
    -- when elements are hidden, clear queues for combat events.
    if not hidden then
        CI.ClearQueues()
    end
end

-- Updates all floating labels. Called every 40ms
function CI.OnUpdate(currentTime)
    -- Ability cooldowns
    if ( CI.SV.CoolDown ) then
        for actionButtonNum = 3, 7 do
            local bg    = uiCooldown[ actionButtonNum ].bg
            local label = uiCooldown[ actionButtonNum ].label
            local remain, duration, global = GetSlotCooldownInfo( actionButtonNum )
            if ( duration > 0 ) then
                bg:SetHidden( false )
                bg:SetAlpha( 0.001*remain )
                label:SetHidden( false )
                label:SetText( strfmt( "%.1f", 0.001*remain ) )
                --for i = #(uiCooldown.timeColours), 1, -1 do
                --  if remain < uiCooldown.timeColours[i].remain then
                --      label:SetColor( unpack( uiCooldown.timeColours[i].colour ) )
                --      break
                --  end
                --end
            else
                bg:SetHidden( true )
                --label:SetColor( unpack( uiCooldown.colour ) )
            end
        end
        -- Now same thing for quickslot
        local slotIndex = GetCurrentQuickslot()
        local remain, duration, global = GetSlotCooldownInfo( slotIndex )
        if ( duration > 0 ) then
            uiQuickSlot.label:SetHidden( false )
            uiQuickSlot.label:SetText( strfmt( "%.1f", 0.001*remain ) )
            for i = #(uiQuickSlot.timeColours), 1, -1 do
                if remain < uiQuickSlot.timeColours[i].remain then
                    uiQuickSlot.label:SetColor( unpack( uiQuickSlot.timeColours[i].colour ) )
                    break
                end
            end
        else
            uiQuickSlot.label:SetHidden( true )
            uiQuickSlot.label:SetColor( unpack( uiQuickSlot.colour ) )
        end
    end

    -- Hide Ultimate generation texture if it is time to do so
    if CI.SV.UltimateGeneration then
        if not uiUltimate.Texture:IsHidden() and uiUltimate.FadeTime < currentTime then
            uiUltimate.Texture:SetHidden(true)
        end
    end

    -- Loop label targets
    --local currentTime = GetGameTimeMilliseconds()
    local isAlive = false
    for key, target in pairs(targetControls) do

        -- Loop labels
        for labelnum, label in pairs(target.floatingLabels) do

            -- Animate label
            if ( label.settings.age ~= 0 ) then
                if ( label.settings.age <= currentTime ) then
                    -- Remove label
                    label:SetHidden( true )
                    label.settings.age = 0
                    -- And clear throttle labels cache, though this should already be done
                    if label.throttleKey then
                        throttleLabels[label.throttleKey] = nil
                    end
                else
                    -- Animation (movement) phase
                    if ( label.settings.fixedAge <= currentTime ) then

                        -- Check if we need to clear throttle labels cache
                        -- Label is available for possible throttle for first quarter of animation time
                        if label.throttleKey and ( label.settings.age - currentTime < 0.75*label.settings.animateTime ) then
                            throttleLabels[label.throttleKey] = nil
                            label.throttleKey = nil
                        end

                        -- In animation phase the label is always moving:
                        --
                        -- * Alpha fade is applied only of last 2/3 of live time,
                        --   i.e. first 1/3 of time while label is moving with full opacity
                        --
                        -- * For some events the label can be set to increase in scale.
                        --   This process takes first 2/3 of live time (precomputed in label.settings.animateScaleUp[3]).

                        local currentAge = currentTime - label.settings.fixedAge

                        -- Alpha fade
                        if ( label.settings.animateAlpha == true ) then
                            local fadeTime = label.settings.animateTime * 2 / 3
                            local currentAgeAdjusted = currentAge - label.settings.animateTime + fadeTime
                            local alpha = (currentAgeAdjusted < 0) and 1 or E.easeInQuad( currentAgeAdjusted, 1, -1, fadeTime )
                            label:SetAlpha( alpha )
                        end

                        -- Growing scale
                        -- The scale will grow from stored values in label.settings.animateScaleUp table
                        if ( label.settings.animateScaleUp ~= nil and #label.settings.animateScaleUp == 3 ) then
                            local scale = (currentAge < label.settings.animateScaleUp[3])
                                    and E.easeOutQuad( currentAge, label.settings.animateScaleUp[1], label.settings.animateScaleUp[2]-label.settings.animateScaleUp[1], label.settings.animateScaleUp[3] )
                                    or label.settings.animateScaleUp[2]
                            label:SetScale( scale )
                        end

                        -- Movement
                        if ( label.settings.animateX ~= 0 or label.settings.animateY ~= 0 ) then
                            if ( label.settings.animateX ~= 0 ) then -- left / right
                                label.settings.animateXoffset = label.settings.animateXoffset + label.settings.animateX
                            end
                            if ( label.settings.animateY ~= 0 ) then -- up / down
                                label.settings.animateYoffset = label.settings.animateYoffset + label.settings.animateY
                            end
                            label:ClearAnchors()
                            label:SetAnchor( label.settings.align, label.settings.targetControl, label.settings.alignTarget, label.settings.animateXoffset, label.settings.animateYoffset )
                        end
                    -- Fixed (label does not move) phase
                    else
                        -- Scale fade
                        if ( label.settings.fixedScaleDown ) then
                            --local scale = ( ( label.settings.fixedAge - currentTime ) / label.settings.fixedTime )
                            --scale = 1.0 * scale * scale
                            --label:SetScale( 1.0 + scale )
                            -- This is actually ease-out function, because t in first argument runs backwards
                            label:SetScale(E.easeInOutQuad( label.settings.fixedAge - currentTime, 1, 0.5, label.settings.fixedTime ))
                        end
                    end

                    -- Keep HUD alive
                    isAlive = true
                end
            end
        end
    end

    -- Keep HUD alive or hide it
    --LUIE_CombatInfo_HUDElements:SetHidden( not CI.SV.HUDElements or not isAlive )
end

-- Updates scrolling labels. Called every 20ms
function CI.OnUpdateScrolling(currentTime)
    -- Animate scrolling areas
    for key, target in pairs(g_scrollingControls) do
        -- Create label from queued event
        if fifoQueue.getLeft(target.eventsQueue) ~= nil then
            if target.eventsQueueNext then
                local event = fifoQueue.popLeft(target.eventsQueue)
                CI.FireCombatEvent( event.eventCode, event.result, event.isError, event.abilityName, event.abilityGraphic, event.abilityAST, event.sourceName, event.sourceType, event.targetName, event.targetType, event.hitValue, event.powerType, event.damageType, event.log, event.sourceUnitId, event.targetUnitId, event.abilityId )
                target.eventsQueueNext = false
            -- There are some events in queue, but we cannot yet pop them out
            elseif CI.SV.PurgeExpiredScroll then
                -- So check if queued events are "important", and if not, purge them from queue if they expired
                while true do
                    local event = fifoQueue.getLeft(target.eventsQueue)
                    if event and currentTime - event.ms > 750 and event.result ~= ACTION_RESULT_DAMAGE and event.result ~= ACTION_RESULT_CRITICAL_DAMAGE then
                        fifoQueue.popLeft(target.eventsQueue)
                    else
                        break
                    end
                end
            end
        end

        local maxAngle = 0

        -- Loop labels
        for labelnum, label in pairs(target.floatingLabels) do
            if label.available then
                -- Check if label reached border condition
                if label.angle < - g_scrollingAngle  then
                    label:SetHidden(true)
                    label.available = false
                    -- And clear throttle labels cache, though this should already be done
                    if label.throttleKey then
                        throttleLabels[label.throttleKey] = nil
                    end
                -- Move label
                else
                    -- Check if we need to clear throttle labels cache
                    -- Label is available for possible throttle for first quarter of animation time
                    if label.throttleKey and ( label.angle < 0.5*g_scrollingAngle ) then
                        throttleLabels[label.throttleKey] = nil
                        label.throttleKey = nil
                    end

                    label.angle = label.angle - g_scrollingSpeed

                    if label.angle > maxAngle then
                        maxAngle = label.angle
                    end

                    local abs_angle = math.abs(label.angle)
                    label:SetAlpha(
                        ( abs_angle >= g_scrollingAngle ) and 0 or
                        ( abs_angle >= 0.8 * g_scrollingAngle ) and E.easeInQuad( g_scrollingAngle-abs_angle, 0, 1, 0.2*g_scrollingAngle ) or
                        1 )
                    --if abs_angle >= 0.8 * g_scrollingAngle and abs_angle <= g_scrollingAngle then
                    --  label:SetAlpha( E.easeInQuad( g_scrollingAngle-abs_angle, 0, 1, 0.2*g_scrollingAngle ) )
                    --end

                    label:ClearAnchors()
                    label:SetAnchor(CENTER, target, CENTER, g_scrollingRadius * target.curve * (math.cos(label.angle)-1), g_scrollingRadius * math.sin(label.angle))
                end
            end
        end

        if maxAngle < 0.93 * g_scrollingAngle then
            target.eventsQueueNext = true
        end
    end
end

-- Runs EVENT_ENLIGHTENED_STATE_GAINED and EVENT_ENLIGHTENED_STATE_LOST listeners
function CI.OnEnlightenedState(eventCode)
    -- _STATE_LOST event does not seams to fire, so we will have to track remaining pool locally
    g_cxpEnlightenedPool = GetEnlightenedPool()

    -- If pool is non-zero, save champion xp multiplier
    g_cxpEnlightenedMultiplier = ( g_cxpEnlightenedPool > 0 ) and GetEnlightenedMultiplier() or nil

    --[[-- DEBUG: check what caused this event
   d("LUIE DEBUG: Enlightened - "
        .. ( ( eventCode == EVENT_ENLIGHTENED_STATE_GAINED ) and "Gained" or ( eventCode == EVENT_ENLIGHTENED_STATE_LOST ) and "Lost" or "Unknown" )
        .. "; pool: " .. GetEnlightenedPool()
    )
    --]]--
end

function CI.OnXPUpdate( eventCode, unitTag, currentExp, maxExp, reason )
    if ( unitTag ~= "player" ) then
        return
    end

    local value  = currentExp - g_lastExp
    g_lastExp = currentExp

    -- Abort if there is no gain
    if ( value < 1 ) then return end

    -- Calculate used pool amount and subtract it from local pool variable
    local cxpUsedPool = ( g_cxpEnlightenedPool > value ) and value or g_cxpEnlightenedPool
    g_cxpEnlightenedPool = g_cxpEnlightenedPool - cxpUsedPool

    -- If remaining pool became zero, but multiplier is still exists, reread it again
    if ( g_cxpEnlightenedMultiplier ~= nil ) and ( g_cxpEnlightenedPool == 0 ) then
        CI.OnEnlightenedState(nil)
        -- if after this query our local pool is positive again, then for this event we will use full amount of it
        if g_cxpEnlightenedPool > 0 then
            cxpUsedPool = value
        end
    end

    -- Now we are ready to calculate champion xp gain
    local cxp = ( g_useChampionXP and g_cxpEnlightenedMultiplier ) and ( value + cxpUsedPool * g_cxpEnlightenedMultiplier ) or nil

    -- Display floating text
    CI.OnCombatEvent( 0, "custom", false, "", "", 0, "", COMBAT_UNIT_TYPE_PLAYER, cxp and "CXP" or "EXP", "exp", cxp or value, 0, 0, false, 0, 0, 0)
    -- update in-combat xp gain
    g_combatXP = g_combatXP + ( cxp or value )

    -- Also announce XP to chat ( via ChatAnnouncements module )
    -- g_printXP( reason, value, cxp )
    -- Also send kill-xp information into Combat Log component ( via Damage Meter module )
    -- PROGRESS_REASON_KILL == 0
    --if reason == 0 then g_logKillXP(value)
    --end
end

-- Listens to EVENT_ALLIANCE_POINT_UPDATE
function CI.OnAPUpdate( eventCode, alliancePoints, playSound, difference )
    if ( difference < 1 ) then return end
    -- Send custom combat event
    CI.OnCombatEvent( 0, "custom", false, "Alliance Points", "", 0, "", COMBAT_UNIT_TYPE_PLAYER, "", "ap", difference, 0, 0, false, 0, 0, 1)
end

-- Listens to EVENT_TELVAR_STONE_UPDATE
function CI.OnTSUpdate( eventCode, newTelvarStones, oldTelvarStones, reason )
    if ( newTelvarStones - oldTelvarStones < 1 ) then return end
    -- Send custom combat event
    CI.OnCombatEvent( 0, "custom", false, "TelVar Stones", "", 0, "", COMBAT_UNIT_TYPE_PLAYER, "", "telvar", newTelvarStones - oldTelvarStones, 0, 0, false, 0, 0, 1)
end

-- Listens to EVENT_COMBAT_EVENT
function CI.OnCombatEvent( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )
    -- Ignore error events
    if isError then return end

    -- We do not distinguish between NPC targets and Player targets
    if targetType == COMBAT_UNIT_TYPE_OTHER then
        targetType = COMBAT_UNIT_TYPE_NONE
    end

    -- Manually track Ultimate generation -- same as in SCB module
    if CI.SV.UltimateGeneration and uiUltimate.NotFull and (
        ( result == ACTION_RESULT_BLOCKED_DAMAGE and targetType == COMBAT_UNIT_TYPE_PLAYER ) or
        ( E.IsWeaponAttack[abilityName] and sourceType == COMBAT_UNIT_TYPE_PLAYER and targetType == COMBAT_UNIT_TYPE_NONE )
        ) then

        uiUltimate.Texture:SetHidden(false)
        uiUltimate.FadeTime = GetGameTimeMilliseconds() + 8000
    end

    -- Cleanse now! alert is triggered by presence of incoming dot
    if CI.SV.CombatTipsEnabled and IsResultDot[result] and targetType == COMBAT_UNIT_TYPE_PLAYER then
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "Cleanse Now!", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    end

    -- Filter events by eventId, sourceType, targetType
    if ( not CI.FilterEvent( result, sourceType, targetType, powerType, hitValue ) ) then
        return
    end

    -- 1: Fire cloud-text event
    CI.FireCombatEvent( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )

    -- 2: Prepare scrolling text event
    -- Get event config
    local scrolling = ( type(combatEvents[ result ][ sourceType ][ targetType ].scrolling) == "table" ) and combatEvents[ result ][ sourceType ][ targetType ].scrolling[ powerType ] or combatEvents[ result ][ sourceType ][ targetType ].scrolling

    -- Add to queue or fire instant
    if ( g_scrollingControls[ scrolling ] ) then
        -- Manually filter out some events
        -- 1. No scrolling Alliance Points text for small amounts
        if result == "custom" and sourceType == COMBAT_UNIT_TYPE_PLAYER and targetType == "ap" and hitValue < 15 then return end

        -- Create event table
        local combatEvent          = {}
        combatEvent.ms             = GetGameTimeMilliseconds()
        combatEvent.eventCode      = scrolling -- !!! -- eventCode
        combatEvent.result         = result
        combatEvent.isError        = isError
        combatEvent.abilityName    = E.EffectNameOverride[abilityId] or abilityName
        combatEvent.abilityGraphic = abilityGraphic
        combatEvent.abilityAST     = abilityActionSlotType
        combatEvent.sourceName     = sourceName
        combatEvent.sourceType     = sourceType
        combatEvent.targetName     = targetName
        combatEvent.targetType     = targetType
        combatEvent.hitValue       = hitValue
        combatEvent.powerType      = powerType
        combatEvent.damageType     = damageType
        combatEvent.log            = log
        combatEvent.sourceUnitId   = sourceUnitId
        combatEvent.targetUnitId   = targetUnitId
        combatEvent.abilityId      = abilityId

        -- Add event to queue
        fifoQueue.pushRight( g_scrollingControls[ scrolling ].eventsQueue, combatEvent )
    end
end

-- Helper function to setup icon used in next procedure
local function setupIcon(showIcon, label, iconSettings, abilityName, abilityId)
    local icon = label.icon

    if showIcon and abilityId and abilityId > 0 then
        -- Get ability texture
        local iconTexture = E.GetAbilityIcon(abilityName, abilityId)

        -- DEBUG:
        --d(abilityName, abilityId)
        --d(iconTexture)

        -- Icon setup
        if ( iconSettings.show and iconTexture ~= "" and iconTexture ~= "/esoui/art/icons/ability_mage_065.dds" ) then
            local sizeY = label:GetTextHeight() * 0.8
            icon:SetDimensions( sizeY, sizeY )
            icon:SetAnchor( iconSettings.align, label, iconSettings.alignTarget, iconSettings.offsetX, iconSettings.offsetY )
            icon:SetTexture( iconTexture )
            icon:SetHidden( false )
            icon:SetAlpha( 0.7 )
        else
            icon:SetHidden( true )
        end
    else
        icon:SetHidden( true )
    end
end

-- Creates new label in cloud areas
function CI.FireCombatEvent( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log, sourceUnitId, targetUnitId, abilityId )

    local currentTime = GetGameTimeMilliseconds()

    -- Prepare names
    local sourceName = sourceName:gsub("%^%a+","")
    local targetName = targetName:gsub("%^%a+","")

    -- Get event config
    local target    = ( type(combatEvents[ result ][ sourceType ][ targetType ].target) == "table" ) and combatEvents[ result ][ sourceType ][ targetType ].target[ powerType ] or combatEvents[ result ][ sourceType ][ targetType ].target
    local colour    = ( type(combatEvents[ result ][ sourceType ][ targetType ].colour) == "table" ) and combatEvents[ result ][ sourceType ][ targetType ].colour[ powerType ] or combatEvents[ result ][ sourceType ][ targetType ].colour
    local font      = ( type(combatEvents[ result ][ sourceType ][ targetType ].font) == "table" ) and combatEvents[ result ][ sourceType ][ targetType ].font[ powerType ] or combatEvents[ result ][ sourceType ][ targetType ].font
    local strfmt    = ( type(combatEvents[ result ][ sourceType ][ targetType ].strfmt) == "table" ) and combatEvents[ result ][ sourceType ][ targetType ].strfmt[ powerType ] or combatEvents[ result ][ sourceType ][ targetType ].strfmt
    local deadtime  = combatEvents[ result ][ sourceType ][ targetType ].deadtime
    local animateScaleUp = combatEvents[ result ][ sourceType ][ targetType ].animateScaleUp
    animateScaleUp = ( animateScaleUp and #animateScaleUp == 2 ) and animateScaleUp or nil

    -- Prepare now text for label right now to check if if requires deadtime
    local labelText = StringFormat( strfmt, hitValue, sourceName, targetName, hitValue, CI.Colours.DAMAGECRIT.hex, CI.Colours.BLOCKED.hex )

    -- If DeadTime for this label is True, then do not display identical icons within 3 seconds (simply ignore such labels)
    if deadtime then
        if not DelayBuffer( moduleName .. target .. labelText, 3000, currentTime ) then
            return
        end
    end

    -- Prepare custom colour for outgoing damage is required
    -- Incoming damage has no information at all about damage type and or ability name, so we will not use this custom colour for it
    if CI.SV.DamageColoured and IsResultDamage[result] then
        colour = CI.Colours.DAMAGE_COLOURED[ damageType ]
    end

    -- eventCode will be scrolling key if this is a queued event
    if g_scrollingControls[eventCode] then
        -- FIXME: after Update 2.1 this have to be rechecked
        if result == "custom" and targetType == "exp" then
            labelText = StringFormat("Experience gain: |cEEEEEE+%4$d|r %3$s", hitValue, sourceName, targetName, hitValue )
        -- Override label for healing abilities
        elseif IsResultHeal[result] or result == ACTION_RESULT_POWER_ENERGIZE then
            labelText = StringFormat( "+%1$d (%2$s)", hitValue, (abilityName and abilityName ~= "") and strformat("<<t:1>>", abilityName) or "Incoming Heal", "", hitValue )
        -- For ourgoing damage
        elseif IsResultDamage[result] then
            local str =
                ( IsResultDot[result] and "-" or
                  (result == ACTION_RESULT_BLOCKED_DAMAGE) and (CI.Colours.BLOCKED.hex .. "Blocked|r ") or
                "" ) ..
                "%1$d " ..
                ( IsResultCritical[result] and (CI.Colours.DAMAGECRIT.hex .. "Critical|r ") or "" ) ..
                "(%2$s)"
            labelText = StringFormat( str, hitValue, strformat("<<t:1>>", abilityName), "", hitValue )
        end

        -- Now if we can try to throttle labels, there is a proper time to make a check
        local throttleKey
        if CI.SV.ThrottleEnabled then
            -- Fill the name of throttle key: we will throttle only completely identical abilities/results/values
            throttleKey = "Scrolling: " .. target .. " a:" .. ( abilityName or "" ) .. " t:" .. ( damageType or "-" ) .. " r:" .. ( result or 0 ) .. " h:" .. hitValue
            -- Look for existing label
            local throttle = throttleLabels[throttleKey]
            if throttle and throttle.label.throttleKey == throttleKey then
                -- Set new values for throttle hits
                throttle.hits = throttle.hits + 1
                -- Update label text
                throttle.label:SetText( labelText .. " |cFFFFFFx|r " .. throttle.hits )
                -- There is nothing else to do as the label is already alive and we do not need to create new ones
                return nil
            end
        end

        -- Override font for some events
        if result == ACTION_RESULT_POWER_ENERGIZE or result == ACTION_RESULT_POWER_DRAIN then
            font = "Regular"
        end

        -- Prepare proper font
        font = Font[ "Scroll" .. font ] or Font[ font ] or font

        -- Control where label to be created
        local targetControl = g_scrollingControls[eventCode]

        targetControl.lastUsedLabel = ( targetControl.lastUsedLabel == targetControl.labelsMax ) and 1 or targetControl.lastUsedLabel + 1
        local label = targetControl.floatingLabels[ targetControl.lastUsedLabel ]
        if  label == nil then
            label = WINDOW_MANAGER:CreateControl( nil, targetControl, CT_LABEL )
            label.icon = label:CreateControl( nil, CT_TEXTURE )
            targetControl.floatingLabels[ targetControl.lastUsedLabel ] = label
        end

        local iconSettings = {
            show            = true,
            align           = RIGHT,
            alignTarget     = LEFT,
            offsetX         = -8,
            offsetY         = 0,
        }

        -- Set initial throttle value
        label.throttleKey = throttleKey
        if throttleKey then
            throttleLabels[throttleKey] = { label = label, hits = 1, }
        end

        -- Label setup
        label.angle = g_scrollingAngle
        label.available = true
        label:SetScale( 1 )
        label:SetDrawLayer( DL_TEXT )
        label:SetColor( colour.r, colour.g, colour.b )
        label:SetFont( font )
        label:SetText( labelText )
        label:ClearAnchors()
        label:SetHidden( false )
        label:SetAlpha( 0 )

        setupIcon(CI.SV.ShowIconsScroll, label, iconSettings, abilityName, abilityId)

    -- Event is fired imemdiatelly into cloud-text areas
    else
        -- Prepare proper font
        font = Font[ "Cloud" .. font ] or Font[ font ] or font

        -- Get target config
        local targetConfig  = combatTargets[ target ]
        local targetControl = targetControls[ targetConfig.parent or target ]

        -- If the control does not exists, then bail out here
        if targetControl == nil then return end

        -- Now if we can try to throttle labels, there is a proper time to make a check
        local throttleKey
        if CI.SV.ThrottleEnabled and targetConfig.throttleOption then
            -- Fill the name of throttle key: we will throttle only completely identical abilities/results/values
            throttleKey = "Cloud: " .. target .. " a:" .. ( abilityName or "" ) .. " t:" .. ( damageType or "-" ) .. " r:" .. ( result or 0 ) .. " h:" .. hitValue
            -- Look for existing label
            local throttle = throttleLabels[throttleKey]
            if throttle and throttle.label.throttleKey == throttleKey then
                -- Set new values for throttle hits
                throttle.hits = throttle.hits + 1
                -- Update label text
                throttle.label:SetText( labelText .. "|cFFFFFF*|cCCCCCC" .. throttle.hits .. "|r" )
                -- There is nothing else to do as the label is already alive and we do not need to create new ones
                return nil
            end
        end

        -- Get label
        targetControl.lastUsedLabel = ( targetControl.lastUsedLabel == targetConfig.labelsMax ) and 1 or targetControl.lastUsedLabel + 1
        local label = targetControl.floatingLabels[ targetControl.lastUsedLabel ]
        if  label == nil then
            label = WINDOW_MANAGER:CreateControl( nil, targetControl, CT_LABEL )
            label.icon = label:CreateControl( nil, CT_TEXTURE )
            targetControl.floatingLabels[ targetControl.lastUsedLabel ] = label
        end

        -- get previous label
        -- local previousNum   = ( targetControl.lastUsedLabel - 1 < 1 ) and targetConfig.labelsMax or targetControl.lastUsedLabel - 1
        -- local previousLabel = targetControl.floatingLabels[ previousNum ]

        -- Label settings
        label.settings = {
            target          = target,
            targetControl   = targetControl,
            animateAlpha    = targetConfig.animateAlpha,
            animateY        = targetConfig.animateY,
            animateX        = targetConfig.animateX,
            animateSpeed    = ( targetConfig.animateY < 0 ) and ( -targetConfig.animateY ) or targetConfig.animateY,
            animateTime     = targetConfig.animateTime,
            animateScaleUp  = animateScaleUp and { animateScaleUp[1], animateScaleUp[2], targetConfig.animateTime * 2 / 3 } or nil,
            fixedTime       = targetConfig.fixedTime,
            fixedScaleDown  = targetConfig.fixedScaleDown,
            align           = targetConfig.align or BOTTOM,
            alignTarget     = targetConfig.alignTarget or CENTER,
        }
        local iconSettings = {
            show            = targetConfig.showIcon,
            align           = targetConfig.alignIcon,
            alignTarget     = targetConfig.alignIconTarget,
            offsetX         = targetConfig.alignIconOffsetX,
            offsetY         = targetConfig.alignIconOffsetY,
        }
        if ( targetConfig.grid and targetConfig.grid.max and targetConfig.grid.max > 1 ) then
            local gridIndex = ( targetConfig.grid.last >= targetConfig.grid.max ) and 1 or targetConfig.grid.last + 1
            targetConfig.grid.last = gridIndex
            label.settings.animateXoffset = ( targetConfig.alignOffsetX or 0 ) + ( targetConfig.grid[ gridIndex ][1] + 0.8*(math.random() - 0.5) ) * targetConfig.grid.size
            label.settings.animateYoffset = ( targetConfig.alignOffsetY or 0 ) + ( targetConfig.grid[ gridIndex ][2] + 0.8*(math.random() - 0.5) ) * targetConfig.grid.size

        else
            label.settings.animateXoffset = targetConfig.alignOffsetX or 0
            label.settings.animateYoffset = targetConfig.alignOffsetY or 0
        end
        label.settings.nextIn           = ( previousLabel ~= nil ) and previousLabel:GetHeight() or 0
        label.settings.fixedAge         = currentTime + label.settings.fixedTime
        label.settings.age              = label.settings.fixedAge + label.settings.animateTime

        -- Set initial throttle value
        label.throttleKey = throttleKey
        if throttleKey then
            throttleLabels[throttleKey] = { label = label, hits = 1, }
        end

        -- Label setup
        label:SetScale( 1 )
        label:SetDrawLayer( DL_TEXT )
        label:SetColor( colour.r, colour.g, colour.b )
        label:SetFont( font )
        label:SetText( labelText )
        label:ClearAnchors()
        label:SetAnchor( label.settings.align, label.settings.targetControl, label.settings.alignTarget, label.settings.animateXoffset, label.settings.animateYoffset )
        label:SetHidden( false )
        label:SetAlpha( 0 )

        setupIcon(CI.SV.ShowIconsCloud, label, iconSettings, abilityName, abilityId)

    end -- Scroll | Cloud
end

function CI.FilterEvent( result, sourceType, targetType, powerType, hitValue )
    -- Ignore Zeroes for non-immunities events
    if hitValue == 0 and not IsResultCC[result] then
        return false
    end

    -- only events from the combatEvents table with defined sourceType/targetType combination
    for k,v in pairs( combatEvents ) do
        if ( result == k ) then
            for k2,v2 in pairs( combatEvents[k] ) do
                if ( sourceType == k2 ) then
                    for k3,v3 in pairs( combatEvents[k][k2] ) do
                        if ( targetType == k3 ) then
                            if ( combatEvents[ k ][ k2 ][ k3 ].savedVarsFilter ~= nil ) then
                                if ( not CI.SV[ combatEvents[ k ][ k2 ][ k3 ].savedVarsFilter ] ) then
                                    return false
                                end
                            end
                            if ( combatEvents[ k ][ k2 ][ k3 ].powers ~= nil ) then
                                if ( combatEvents[k][k2][k3].powers[powerType] ) then
                                    return true
                                end
                            else
                                return true
                            end
                        end
                    end
                end
            end
        end
    end
    return false
end

function CI.OnSlotsFullUpdate(eventCode)
    if not CI.Enabled then
        return
    end

    local setHidden = not ( CI.SV.UltimateEnabled and IsSlotUsed( g_ultimateSlot ) )

    uiUltimate.LabelVal:SetHidden( setHidden )
    if setHidden then
        uiUltimate.LabelPct:SetHidden( true )
    end

    -- Get the currently slotted ultimate cost
    local cost, mechType = GetSlotAbilityCost( g_ultimateSlot )

    g_ultimateCost = ( mechType == POWERTYPE_ULTIMATE ) and cost or 0

    g_ultimatAbilityName = GetSlotName( g_ultimateSlot )
    g_ultimatAbilityId = GetSlotBoundId( g_ultimateSlot )

    -- if this event was caused only by user manually changing the ultimate ability, then
    -- force recalculation of percent value. Otherwise (weapons swap) this will be called by the game
    if ( eventCode == EVENT_ACTION_SLOT_UPDATED or EVENT_ACTION_SLOTS_FULL_UPDATE and not setHidden ) then
        CI.OnPowerUpdatePlayer(EVENT_POWER_UPDATE, "player", nil, POWERTYPE_ULTIMATE, g_ultimateCurrent, 0, 0)
    end
end

function CI.OnPowerUpdatePlayer( eventCode , unitTag, powerIndex, powerType, powerValue, powerMax, powerEffectiveMax )
    if unitTag ~= "player" then return end
    if powerType == POWERTYPE_ULTIMATE then
        -- flag if ultimate is full - we"ll need it for ultimate generation texture
        uiUltimate.NotFull = ( powerValue < powerMax )
        -- Calculate the percentage to activation old one and current
        local pct = ( g_ultimateCost > 0 ) and math.floor( ( powerValue / g_ultimateCost ) * 100 ) or 0
        -- Update the tooltip only when corresponding setting is enabled
        if CI.SV.UltimateEnabled then
            -- Values label: Set Value and assign colour
            -- Pct label: show always when less then 100% and possibly if UltimateHideFull is false
            uiUltimate.LabelVal:SetText( powerValue .. "/" .. g_ultimateCost )
            uiUltimate.LabelPct:SetText( pct .. "%")
            if pct < 100  then
                uiUltimate.LabelPct:SetHidden(false)
                for i = #(uiUltimate.pctColours), 1, -1 do
                    if pct < uiUltimate.pctColours[i].pct then
                        uiUltimate.LabelVal:SetColor( unpack( uiUltimate.pctColours[i].colour ) )
                        break
                    end
                end
            else
                uiUltimate.LabelPct:SetHidden( CI.SV.UltimateHideFull )
                uiUltimate.LabelVal:SetColor( unpack(uiUltimate.colour) )
            end
        end

        -- Maybe fire an alert
        if ( CI.SV.UltimateAlert and pct >= 100 and g_ultimateNotReady ) then
            CI.OnCombatEvent( 0, "custom", false, g_ultimatAbilityName, "", 0, "Ultimate Ready", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_ULTIMATE, 0, false, 0, 0, g_ultimatAbilityId )
        end

        -- Update stored value
        g_ultimateCurrent = powerValue
        -- This hack is needed to avoid erroneous alert fire
        if g_ultimateCost > 0 then
            g_ultimateNotReady = pct < 100
        end

    elseif ( CI.SV.LowEnabled and g_powerPools[ powerType ] ) then
        local newValue = powerValue / powerMax

        if ( g_powerPools[ powerType ] < CI.thresholdAttribute
            or newValue > g_powerPools[ powerType ]
            or newValue > CI.thresholdAttribute ) then

            g_powerPools[ powerType ] = newValue
            return
        end

        g_powerPools[ powerType ] = newValue

        CI.OnCombatEvent( 0, "custom", false, "", "", 0, lowAlertText[powerType], COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", powerValue, powerType, 0, false, 0, 0, 39266 ) -- 39266 == Soul Shatter

        if CI.SV.LowSound then
            PlaySound( "Quest_StepFailed" )
        end
    end
end

function CI.OnPowerUpdateTarget( eventCode , unitTag, powerIndex, powerType, powerValue, powerMax, powerEffectiveMax )
    if unitTag ~= "reticleover" then return end
    if CI.SV.ExecuteEnabled and powerType == POWERTYPE_HEALTH and
            IsUnitAttackable("reticleover") and GetUnitReaction("reticleover") ~= UNIT_REACTION_NEUTRAL and not IsUnitDead("reticleover") and
            powerValue / powerMax < CI.thresholdExecute then
        local unitName = GetUnitName("reticleover")
        local currentTime = GetGameTimeMilliseconds()
        if g_lastExecuteAlert[unitName] == nil or ( currentTime - g_lastExecuteAlert[unitName] > 1000 * CI.SV.ExecuteTimeout ) then
            g_lastExecuteAlert[unitName] = currentTime
            CI.FireCombatEvent( 0, "custom", false, "", "", 0, "Execute Now!", COMBAT_UNIT_TYPE_PLAYER, unitName, "combatTip", powerValue, POWERTYPE_COMBO, 0, false, 0, 0, 0 )
        end
    end
end

function CI.OnDisplayActiveCombatTip( eventCode, activeCombatTipId )
    if activeCombatTipId == 1 then
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "BLOCK NOW", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    elseif activeCombatTipId == 2 then
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "EXPLOIT NOW", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    elseif activeCombatTipId == 3 then
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "INTERRUPT NOW", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    elseif activeCombatTipId == 4 then
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "DODGE NOW", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    elseif activeCombatTipId == 18 then
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "BREAK FREE", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    elseif activeCombatTipId == 19 then
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "ROOTED", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_INVALID, 0, false, 0, 0, 0 )
    --else
        --d("DisplayActiveCombatTip : " .. activeCombatTipId )
    end
end

-- Runs on the EVENT_UNIT_DEATH_STATE_CHANGED listener.
-- This handler fires every time a valid unitTag dies or is resurrected
function CI.OnDeath(eventCode, unitTag, isDead)
    -- Wipe self buffs
    if isDead and "group" == string.sub(unitTag, 0, 5) then -- when group member dies
        CI.FireCombatEvent( eventCode, "custom", false, "", "", 0, "", COMBAT_UNIT_TYPE_PLAYER, GetUnitName(unitTag), "unitDeath", 1, 0, 0, false, 0, 0, 0 )
    end
end

-- Runs on the EVENT_PLAYER_COMBAT_STATE listener.
-- This handler fires every time player enters or leaves combat
function CI.OnPlayerCombatState(eventCode, inCombat)
    local stateText = inCombat and "In Combat" or "Out Of Combat"
    CI.FireCombatEvent( 0, "custom", false, "", "", 0, "", COMBAT_UNIT_TYPE_PLAYER, stateText, "combatState", 1, 0, 0, false, 0, 0, 0 )
    if inCombat then
        g_combatXP = 0
    else
        -- We need some little delay to update combat XP, so we will have to make a delay call
        EVENT_MANAGER:RegisterForUpdate( moduleName .. "_DelayedCombatXP", 300, CI.ReportCombatXP )
    end
end


-- Used to create total combat xp gain. Called from OnPlayerCombatState with delay.
function CI.ReportCombatXP()
    EVENT_MANAGER:UnregisterForUpdate( moduleName .. "_DelayedCombatXP" )
    if g_combatXP > 0 then
        CI.FireCombatEvent( 0, "custom", false, "", "", 0, "", COMBAT_UNIT_TYPE_PLAYER, "", "combatXP", g_combatXP, 0, 0, false, 0, 0, 0 )
    end
end

-- Used to create "Potion Ready" alert. Called from SCB module
function CI.CreatePotionAlert(abilityName)
    if not CI.Enabled then return end
    CI.FireCombatEvent( 0, "custom", false, abilityName, "", 0, "Potion Ready", COMBAT_UNIT_TYPE_PLAYER, "", "combatTip", 1, POWERTYPE_ULTIMATE, 0, false, 0, 0, 0 )
end
