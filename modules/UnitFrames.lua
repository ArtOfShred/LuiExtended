------------------
-- Default Unit Frames namespace
LUIE.UnitFrames = {}

-- Performance Enhancement
local UF                = LUIE.UnitFrames
local UI                = LUIE.UI
local AbbreviateNumber  = LUIE.AbbreviateNumber
local printToChat       = LUIE.PrintToChat
local strfmt            = string.format
local strformat         = zo_strformat
local strsub            = string.sub
local tableinsert       = table.insert
local tablesort         = table.sort
local tableremove       = table.remove
local mathfloor         = math.floor
local mathmin           = math.min
local mathceil          = math.ceil
local unpack            = unpack
local pairs, ipairs     = pairs, ipairs

local eventManager      = EVENT_MANAGER
local sceneManager      = SCENE_MANAGER

local callLater         = zo_callLater

local moduleName        = LUIE.name .. "_UnitFrames"

local classIcons = {
    [0] = "/esoui/art/contacts/social_status_offline.dds",
    [1] = "/esoui/art/icons/class/class_dragonknight.dds",
    [2] = "/esoui/art/icons/class/class_sorcerer.dds",
    [3] = "/esoui/art/icons/class/class_nightblade.dds",
    [4] = "/esoui/art/icons/class/class_warden.dds",
    [6] = "/esoui/art/icons/class/class_templar.dds",
}

local roleIcons = {
    [0] = "LuiExtended/media/unitframes/unitframes_class_none.dds",
    [1] = "esoui/art/lfg/lfg_icon_dps.dds",
    [4] = "esoui/art/lfg/lfg_icon_healer.dds",
    [2] = "esoui/art/lfg/lfg_icon_tank.dds",
}

local leaderIcons = {
    [0] = "LuiExtended/media/unitframes/unitframes_class_none.dds",
    [1] = "/esoui/art/icons/guildranks/guild_rankicon_misc01.dds",
}

UF.Enabled = false
UF.D = {
    ShortenNumbers                   = false,
    RepositionFrames                 = true,
    DefaultOocTransparency           = 85,
    DefaultIncTransparency           = 85,
    DefaultFramesPlayer              = nil, -- this default setting HAS TO BE nil!!!
    DefaultFramesTarget              = nil, -- this default setting HAS TO BE nil!!!
    DefaultFramesGroup               = nil, -- this default setting HAS TO BE nil!!!
    Format                           = "Current + Shield (Percentage%)",
    DefaultFontFace                  = "Univers 67",
    DefaultFontStyle                 = "soft-shadow-thick",
    DefaultFontSize                  = 16,
    DefaultTextColour                = { 1, 1, 1 },
    TargetShowClass                  = true,
    TargetShowFriend                 = true,
    TargetColourByReaction           = false,
    CustomFormatOnePT                = "Current + Shield / Max", -- TODO: localization
    CustomFormatOneGroup             = "Current + Shield / Max", -- TODO: localization
    CustomFormatTwoPT                = "Percentage%",
    CustomFormatTwoGroup             = "Percentage%",
    CustomFormatRaid                 = "Current (Percentage%)", -- TODO: localization
    CustomFormatBoss                 = "Percentage%",
    CustomFontFace                   = "Univers 67",
    CustomFontStyle                  = "soft-shadow-thin",
    CustomFontBars                   = 16,
    CustomFontOther                  = 20,
    CustomTexture                    = "Minimalistic",
    HideBuffsPlayerOoc               = false,
    HideBuffsTargetOoc               = false,
    PlayerOocAlpha                   = 85,
    PlayerIncAlpha                   = 85,
    TargetOocAlpha                   = 85,
    TargetIncAlpha                   = 85,
    GroupAlpha                       = 85,
    BossOocAlpha                     = 85,
    BossIncAlpha                     = 85,
    CustomOocAlphaPower              = true,
    CustomColourHealth               = { 202/255,  20/255, 0       },
    CustomColourShield               = { 1      , 192/255, 0       }, -- .a=0.5 for overlay and .a = 1 for separate
    CustomColourMagicka              = { 0      ,  83/255, 209/255 },
    CustomColourStamina              = {  28/255, 177/255, 0       },
    CustomColourDPS                  = { 130/255, 99/255, 65/255 },
    CustomColourHealer               = { 117/255, 077/255, 135/255 },
    CustomColourTank                 = { 133/255, 018/255, 013/255 },
    CustomColourDragonknight         = { 255/255, 125/255, 35/255 },
    CustomColourNightblade           = { 255/255, 51/255, 49/255 },
    CustomColourSorcerer             = { 75/255, 83/255, 247/255 },
    CustomColourTemplar              = { 255/255, 240/255, 95/255 },
    CustomColourWarden               = { 136/255, 245/255, 125/255 },
    CustomShieldBarSeparate          = false,
    CustomShieldBarHeight            = 10,
    CustomShieldBarFull              = false,
    CustomSmoothBar                  = true,
    CustomFramesPlayer               = true,
    CustomFramesTarget               = true,
    PlayerBarWidth                   = 300,
    TargetBarWidth                   = 300,
    PlayerBarHeightHealth            = 30,
    PlayerBarHeightMagicka           = 28,
    PlayerBarHeightStamina           = 28,
    BossBarWidth                     = 300,
    BossBarHeight                    = 36,
    HideBarMagicka                   = false,
    HideLabelMagicka                 = false,
    HideBarStamina                   = false,
    HideLabelStamina                 = false,
    PlayerBarSpacing                 = 0,
    TargetBarHeight                  = 36,
    PlayerEnableYourname             = true,
    PlayerEnableAltbarMSW            = true,
    PlayerEnableAltbarXP             = true,
    PlayerChampionColour             = true,
    PlayerEnableArmor                = true,
    PlayerEnablePower                = true,
    PlayerEnableRegen                = true,
    GroupEnableArmor                 = false,
    GroupEnablePower                 = false,
    GroupEnableRegen                 = true,
    RaidEnableArmor                  = false,
    RaidEnablePower                  = false,
    RaidEnableRegen                  = false,
    BossEnableArmor                  = false,
    BossEnablePower                  = false,
    BossEnableRegen                  = false,
    TargetEnableClass                = false,
    TargetEnableRank                 = true,
    TargetEnableRankIcon             = true,
    TargetTitlePriority              = "Title",
    TargetEnableTitle                = true,
    TargetEnableSkull                = true,
    CustomFramesGroup                = true,
    GroupExcludePlayer               = false,
    GroupBarWidth                    = 250,
    GroupBarHeight                   = 36,
    GroupBarSpacing                  = 40,
    CustomFramesRaid                 = true,
    RaidNameClip                     = 94,
    RaidBarWidth                     = 200,
    RaidBarHeight                    = 30,
    RaidLayout                       = "2 x 12",
    RoleIconSmallGroup               = true,
    ColorRoleGroup                   = true,
    ColorRoleRaid                    = true,
    ColorClassGroup                  = false,
    ColorClassRaid                   = false,
    RaidSpacers                      = false,
    CustomFramesBosses               = true,
    AvaCustFramesTarget              = false,
    AvaTargetBarWidth                = 450,
    AvaTargetBarHeight               = 36,
    Target_FontColour                = { 1, 1, 1 },
    Target_FontColour_FriendlyNPC    = { 0, 1, 0 },
    Target_FontColour_FriendlyPlayer = { 0.7, 0.7, 1 },
    Target_FontColour_Hostile        = { 1, 0, 0 },
    Target_FontColour_Neutral        = { 1, 1, 0 },
    Target_Neutral_UseDefaultColour  = true,
    ReticleColour_Interact           = { 1, 1, 0 },
    ReticleColourByReaction          = false,
    DisplayOptionsPlayer             = 2,
    DisplayOptionsTarget             = 2,
    DisplayOptionsGroupRaid          = 2,
    ExecutePercentage                = 20,
    RaidIconOptions                  = 2,
    ChampionOptions                  = "Show Above Cap", -- TODO: localization
    RepositionFramesAdjust           = 0,
    PlayerFrameOptions               = 1,
    AdjustStaminaHPos                = 200,
    AdjustStaminaVPos                = 0,
    AdjustMagickaHPos                = 200,
    AdjustMagickaVPos                = 0,
    FrameColorReaction               = false,
    CustomColourPlayer               = { 178/255, 178/255, 1 },
    CustomColourFriendly             = { 0, 1, 0 },
    CustomColourHostile              = { 1, 0, 0 },
    CustomColourNeutral              = { 150/255, 150/255, 150/255 },
    CustomColourGuard                = { 95/255, 65/255, 54/255 },
    LowResourceHealth                = 25,
    LowResourceStamina               = 25,
    LowResourceMagicka               = 25,
    ShieldAlpha                      = 50,
}
UF.SV = nil

UF.CustomFrames             = {} -- Custom Unit Frames on contrary are!
UF.CustomFramesMovingState  = false

local g_AvaCustFrames       = {} -- Another set of custom frames. Currently designed only to provide AvA Player Target reticleover frame
local g_DefaultFrames       = {} -- Default Unit Frames are not referenced by external modules
local g_MaxChampionPoint    = GetChampionPointsPlayerProgressionCap() -- Keet this value in local constant
local g_defaultTargetNameLabel   -- Reference to default UI target name label
local g_defaultThreshold    = 25
local g_powerError          = {}
local g_savedHealth         = {}
local g_statFull            = {}
local g_targetThreshold
local g_healthThreshold
local g_magickaThreshold
local g_staminaThreshold
local g_targetUnitFrame          -- Reference to default UI target unit frame
local playerDisplayName = GetUnitDisplayName("player")

local CP_BAR_COLOURS = ZO_CP_BAR_GRADIENT_COLORS

local g_PendingUpdate = {
    Group       = { flag = false, delay = 200 , name = moduleName .. "_PendingGroupUpdate" },
    VeteranXP   = { flag = false, delay = 5000, name = moduleName .. "_PendingVeteranXP" },
}

-- Font to be used on default UI overlay labels
local defaultLabelFont = "/LuiExtended/media/fonts/Fontin/fontin_sans_sc.otf|15|outline"

-- Very simple and crude translation support of common labels
local strDead       = GetString(SI_UNIT_FRAME_STATUS_DEAD)
local strOffline    = GetString(SI_UNIT_FRAME_STATUS_OFFLINE)

-- Following settings will be used in options menu to define DefaultFrames behaviour
-- TODO: localization
local g_DefaultFramesOptions = {
    [1] = "Disable",                                -- false
    [2] = "Do nothing (keep default)",              -- nil
    [3] = "Use Extender (display text overlay)",    -- true
}

-- This icon will be used for alternative bar when using ChampionXP
local CHAMPION_ATTRIBUTE_HUD_ICONS = {
    [ATTRIBUTE_NONE] = "/esoui/art/champion/champion_icon_32.dds",
    [ATTRIBUTE_HEALTH] = "/esoui/art/champion/champion_points_health_icon-hud-32.dds",
    [ATTRIBUTE_MAGICKA] = "/esoui/art/champion/champion_points_magicka_icon-hud-32.dds",
    [ATTRIBUTE_STAMINA] = "/esoui/art/champion/champion_points_stamina_icon-hud-32.dds",
}

-- Default Regen/degen animation used on default group frames and custom frames
local function CreateRegenAnimation(parent, anchors, dims, alpha, number)
    if #dims ~= 2 then
        dims = { parent:GetDimensions() }
    end

    local updateDims = { dims[2] * 1.9, dims[2] * .85 }

    -- Create regen control
    local control
    local offsetX
    local distance
    if number == "degen1" then
        control = UI.Texture(parent, anchors, updateDims, "/LuiExtended/media/unitframes/regenleft.dds", 2, true)
        distance = -dims[1] * .35
        offsetX = dims[1] * .425
    elseif number == "degen2" then
        control = UI.Texture(parent, anchors, updateDims, "/LuiExtended/media/unitframes/regenright.dds", 2, true)
        distance = dims[1] * .35
        offsetX = -dims[1] * .425
    elseif number == "regen1" then
        control = UI.Texture(parent, anchors, updateDims, "/LuiExtended/media/unitframes/regenright.dds", 2, true)
        distance = dims[1] * .35
        offsetX = dims[1] * .075
    elseif number == "regen2" then
        control = UI.Texture(parent, anchors, updateDims, "/LuiExtended/media/unitframes/regenleft.dds", 2, true)
        distance = -dims[1] * .35
        offsetX = -dims[1] * .075
    end

    control:SetHidden(true)
    control:SetAlpha(0)
    control:SetDrawLayer(1)

    local isValidAnchor, point, relativeTo, relativePoint, _, offsetY = control:GetAnchor()

    -- Create an horizontal sliding animation
    local animation, timeline = CreateSimpleAnimation(ANIMATION_TRANSLATE,control,0)
    animation:SetTranslateOffsets(offsetX, offsetY, offsetX + distance, offsetY )
    animation:SetDuration(1000)

    -- Fade alpha coming in
    local fadeIn = timeline:InsertAnimation(ANIMATION_ALPHA,control,0)
    fadeIn:SetAlphaValues(0,.75)
    fadeIn:SetDuration(250)
    fadeIn:SetEasingFunction(ZO_EaseOutQuadratic)

    -- Fade alpha going out
    local fadeOut = timeline:InsertAnimation(ANIMATION_ALPHA,control,750)
    fadeOut:SetAlphaValues(.75,0)
    fadeOut:SetDuration(250)
    fadeIn:SetEasingFunction(ZO_EaseOutQuadratic)

    timeline:SetPlaybackType(ANIMATION_PLAYBACK_LOOP, LOOP_INDEFINITELY)
    control.animation = animation
    control.timeline = timeline

    return control
end

-- Decreased armour overlay visuals
local function CreateDecreasedArmorOverlay( parent, small )
    local control = UI.Control( parent, {CENTER,CENTER}, {512,32}, false )
    control.smallTex = UI.Texture(control, {CENTER,CENTER}, {512,32}, "/EsoUI/Art/UnitAttributeVisualizer/attributeBar_dynamic_decreasedArmor_small.dds", 2, false)
    control.smallTex:SetDrawTier(HIGH)
    --control.smallTexGlow = UI.Texture(control, {CENTER,CENTER}, {512,32}, "/EsoUI/Art/UnitAttributeVisualizer/attributeBar_dynamic_decreasedArmor_small_glow.dds", 2, false)
    --control.smallTexGlow:SetDrawTier(HIGH)
    if not small then
        control.normalTex = UI.Texture(control, {CENTER,CENTER}, {512,32}, "/EsoUI/Art/UnitAttributeVisualizer/attributeBar_dynamic_decreasedArmor_standard.dds", 2, false)
        control.normalTex:SetDrawTier(HIGH)
        --control.normalTexGlow = UI.Texture(control, {CENTER,CENTER}, {512,32}, "/EsoUI/Art/UnitAttributeVisualizer/attributeBar_dynamic_decreasedArmor_standard_glow.dds", 2, false)
        --control.normalTexGlow:SetDrawTier(HIGH)
    end

    return control
end

function UF.GetDefaultFramesOptions(frame)
    local retval = {}
    for k,v in pairs(g_DefaultFramesOptions) do
        if k ~= 1 or frame == "Player" or frame == "Target" then
            tableinsert( retval, v )
        end
    end
    return retval
end

function UF.SetDefaultFramesSetting(frame, value)
    local key = "DefaultFrames" .. tostring(frame)
    if value == g_DefaultFramesOptions[3] then
        UF.SV[key] = true
    elseif value == g_DefaultFramesOptions[1] then
        UF.SV[key] = false
    else
        UF.SV[key] = nil
    end
end

function UF.GetDefaultFramesSetting(frame, default)
    local key = "DefaultFrames" .. tostring(frame)
    local from = default and UF.D or UF.SV
    local value = from[key]
    local out_key = (value == true) and 3 or (value == false) and 1 or 2
    return g_DefaultFramesOptions[out_key]
end

-- Right Click function for group frames - basically just a copy of the ZOS group frame menu options
function UF.GroupFrames_OnMouseUp(self, button, upInside)

    local unitTag = self.defaultUnitTag
    if(button == MOUSE_BUTTON_INDEX_RIGHT and upInside) then
        ClearMenu()
        local isPlayer = AreUnitsEqual(unitTag, "player") -- Flag Player
        local isLFG = DoesGroupModificationRequireVote() -- Flag if we're in an LFG Group
        local accountName = strformat(SI_UNIT_NAME, GetUnitDisplayName(unitTag))
        local isOnline = IsUnitOnline(unitTag)

        if isPlayer then
            AddMenuItem(GetString(SI_GROUP_LIST_MENU_LEAVE_GROUP), function() ZO_Dialogs_ShowDialog("GROUP_LEAVE_DIALOG") end)
        elseif isOnline then
            if IsChatSystemAvailableForCurrentPlatform() then
                AddMenuItem(GetString(SI_SOCIAL_LIST_PANEL_WHISPER), function() StartChatInput("", CHAT_CHANNEL_WHISPER, accountName) end)
            end
            AddMenuItem(GetString(SI_SOCIAL_MENU_VISIT_HOUSE), function() JumpToHouse(accountName) end)
            AddMenuItem(GetString(SI_SOCIAL_MENU_JUMP_TO_PLAYER), function() JumpToGroupMember(accountName) end)
        end

        if IsGroupModificationAvailable() then
            if IsUnitGroupLeader("player") then
                if isPlayer then
                    if not isLFG then
                        AddMenuItem(GetString(SI_GROUP_LIST_MENU_DISBAND_GROUP), function() ZO_Dialogs_ShowDialog("GROUP_DISBAND_DIALOG") end)
                    end
                else
                    if not isLFG then
                        AddMenuItem(GetString(SI_GROUP_LIST_MENU_KICK_FROM_GROUP), function() GroupKick(unitTag) end)
                    end
                end
            end

            --Cannot vote for yourself
            if isLFG and not isPlayer then
                AddMenuItem(GetString(SI_GROUP_LIST_MENU_VOTE_KICK_FROM_GROUP), function() BeginGroupElection(GROUP_ELECTION_TYPE_KICK_MEMBER, ZO_GROUP_ELECTION_DESCRIPTORS.NONE, unitTag) end)
            end
        end

        --Per design, promoting doesn't expressly fall under the mantle of "group modification"
        if IsUnitGroupLeader("player") and not isPlayer and isOnline then
            AddMenuItem(GetString(SI_GROUP_LIST_MENU_PROMOTE_TO_LEADER), function() GroupPromote(unitTag) end)
        end

        ShowMenu(self)
    end

end

function UF.AltBar_OnMouseEnterXP(control)

    local isChampion = IsUnitChampion("player")
    local level
    local current
    local levelSize
    local label
    if isChampion then
        level = GetPlayerChampionPointsEarned()
        current = GetPlayerChampionXP()
        levelSize = GetNumChampionXPInChampionPoint(level)
        label = GetString(SI_EXPERIENCE_CHAMPION_LABEL)
    else
        level = GetUnitLevel("player")
        current = GetUnitXP("player")
        levelSize = GetUnitXPMax("player")
        label = GetString(SI_EXPERIENCE_LEVEL_LABEL)
    end
    local percentageXP = zo_floor(current / levelSize * 100)
    local enlightenedPool = GetEnlightenedPool()
    local enlightenedValue = enlightenedPool > 0 and ZO_CommaDelimitNumber(4 * enlightenedPool)

    InitializeTooltip(InformationTooltip, control, BOTTOM, 0, -10)

    SetTooltipText(InformationTooltip, strformat(SI_LEVEL_DISPLAY, label, level))
    InformationTooltip:AddLine(strformat(SI_EXPERIENCE_CURRENT_MAX_PERCENT, ZO_CommaDelimitNumber(current), ZO_CommaDelimitNumber(levelSize), percentageXP))
    if enlightenedPool > 0 then
        InformationTooltip:AddLine(strformat(SI_EXPERIENCE_CHAMPION_ENLIGHTENED_TOOLTIP, enlightenedValue), nil, ZO_SUCCEEDED_TEXT:UnpackRGB())
    end

end

function UF.AltBar_OnMouseEnterWerewolf(control)

    local function UpdateWerewolfPower()
        local currentPower, maxPower = GetUnitPower("player", POWERTYPE_WEREWOLF)
        local percentagePower = zo_floor(currentPower / maxPower * 100)
        local duration = ( currentPower / 27 )
        -- Round up by 1 from any decimal number
        local durationFormatted = mathfloor(duration + 0.999)

        InitializeTooltip(InformationTooltip, control, BOTTOM, 0, -10)
        SetTooltipText(InformationTooltip, strformat(SI_MONSTERSOCIALCLASS45))
        InformationTooltip:AddLine(strformat(SI_LUIE_UF_WEREWOLF_POWER, currentPower, maxPower, percentagePower))
        InformationTooltip:AddLine(strformat(SI_LUIE_UF_WEREWOLF_TP, durationFormatted), nil, ZO_NORMAL_TEXT:UnpackRGBA() )
    end
    UpdateWerewolfPower()

    -- Register Tooltip Update while active
    eventManager:RegisterForEvent(moduleName .. "TooltipPower", EVENT_POWER_UPDATE, UpdateWerewolfPower)
    eventManager:AddFilterForEvent(moduleName .. "TooltipPower", EVENT_POWER_UPDATE, REGISTER_FILTER_POWER_TYPE, POWERTYPE_WEREWOLF, REGISTER_FILTER_UNIT_TAG, "player")
end

function UF.AltBar_OnMouseEnterMounted(control)

    local function UpdateMountPower()
        local currentPower, maxPower = GetUnitPower("player", POWERTYPE_MOUNT_STAMINA)
        local percentagePower = zo_floor(currentPower / maxPower * 100)
        InitializeTooltip(InformationTooltip, control, BOTTOM, 0, -10)

        SetTooltipText(InformationTooltip, strformat(SI_LUIE_SKILL_MOUNTED))
        InformationTooltip:AddLine(strformat(SI_LUIE_UF_MOUNT_POWER, currentPower, maxPower, percentagePower))
    end
    UpdateMountPower()

    -- Register Tooltip Update while active
    eventManager:RegisterForEvent(moduleName .. "TooltipPower", EVENT_POWER_UPDATE, UpdateMountPower)
    eventManager:AddFilterForEvent(moduleName .. "TooltipPower", EVENT_POWER_UPDATE, REGISTER_FILTER_POWER_TYPE, POWERTYPE_MOUNT_STAMINA, REGISTER_FILTER_UNIT_TAG, "player")
end

function UF.AltBar_OnMouseEnterSiege(control)

    local function UpdateSiegePower()
        local currentPower, maxPower = GetUnitPower("controlledsiege", POWERTYPE_HEALTH)
        local percentagePower = zo_floor(currentPower / maxPower * 100)
        local siegeName = GetUnitName("controlledsiege")
        InitializeTooltip(InformationTooltip, control, BOTTOM, 0, -10)

        SetTooltipText(InformationTooltip, strformat(SI_UNIT_NAME, siegeName))
        InformationTooltip:AddLine(strformat(SI_LUIE_UF_SIEGE_POWER, ZO_CommaDelimitNumber(currentPower), ZO_CommaDelimitNumber(maxPower), percentagePower))
    end
    UpdateSiegePower()

    -- Register Tooltip Update while active
    eventManager:RegisterForEvent(moduleName .. "TooltipPower", EVENT_POWER_UPDATE, UpdateSiegePower)
    eventManager:AddFilterForEvent(moduleName .. "TooltipPower", EVENT_POWER_UPDATE, REGISTER_FILTER_POWER_TYPE, POWERTYPE_HEALTH, REGISTER_FILTER_UNIT_TAG, "controlledsiege")

end

function UF.AltBar_OnMouseExit(control)
    ClearTooltip(InformationTooltip)
    eventManager:UnregisterForEvent(moduleName .. "TooltipPower", EVENT_POWER_UPDATE)
end

-- Used to create default frames extender controls for player and target.
-- Called from UF.Initialize
local function CreateDefaultFrames()
    -- Create text overlay for default unit frames for player and reticleover.
    local default_controls = {}

    if UF.SV.DefaultFramesPlayer then
        default_controls.player = {
            [POWERTYPE_HEALTH]  = ZO_PlayerAttributeHealth,
            [POWERTYPE_MAGICKA] = ZO_PlayerAttributeMagicka,
            [POWERTYPE_STAMINA] = ZO_PlayerAttributeStamina,
        }
    end
    if UF.SV.DefaultFramesTarget then
        default_controls.reticleover = { [POWERTYPE_HEALTH]  = ZO_TargetUnitFramereticleover, }
        -- g_DefaultFrames.reticleover should be always present to hold target classIcon and friendIcon
    else
        g_DefaultFrames.reticleover = { ["unitTag"] = "reticleover" }
    end
    -- Now loop through `default_controls` table and create actual labels (if any)
    for unitTag,fields in pairs(default_controls) do
        g_DefaultFrames[unitTag] = { ["unitTag"] = unitTag }
        for powerType,parent in pairs(fields) do
            g_DefaultFrames[unitTag][powerType] = { ["label"] = UI.Label( parent, {CENTER,CENTER}, nil, nil, nil, nil, false ), ["colour"] = UF.SV.DefaultTextColour }
        end
    end

    -- Reference to target unit frame. this is not an UI control! Used to add custom controls to existing fade-out components table
    g_targetUnitFrame = ZO_UnitFrames_GetUnitFrame("reticleover")

    -- When default Target frame is enabled set the threshold value to change colour of label and add label to default fade list
    if g_DefaultFrames.reticleover[POWERTYPE_HEALTH] then
        g_DefaultFrames.reticleover[POWERTYPE_HEALTH].threshold = g_targetThreshold
        tableinsert( g_targetUnitFrame.fadeComponents, g_DefaultFrames.reticleover[POWERTYPE_HEALTH].label )
    end

    -- Create classIcon and friendIcon: they should work even when default unit frames extender is disabled
    g_DefaultFrames.reticleover.classIcon = UI.Texture(g_targetUnitFrame.frame, nil, {32,32}, nil, nil, true)
    g_DefaultFrames.reticleover.friendIcon = UI.Texture(g_targetUnitFrame.frame, nil, {32,32}, nil, nil, true)
    g_DefaultFrames.reticleover.friendIcon:SetAnchor(TOPLEFT, ZO_TargetUnitFramereticleoverTextArea, TOPRIGHT, 30, -4)
    -- add those 2 icons to automatic fade list, so fading will be done automatically by game
    tableinsert( g_targetUnitFrame.fadeComponents, g_DefaultFrames.reticleover.classIcon )
    tableinsert( g_targetUnitFrame.fadeComponents, g_DefaultFrames.reticleover.friendIcon )

    -- When default Group frame in use, then create dummy boolean field, so this setting remain constant between /reloadui calls
    if UF.SV.DefaultFramesGroup then
        g_DefaultFrames.SmallGroup = true
    end

    -- Apply fonts
    UF.DefaultFramesApplyFont()

    -- Instead of using Default Unit Frames Extender, the player could wish simply to disable and hide default UI frames
    if UF.SV.DefaultFramesPlayer == false then
        local frames = { "Health" , "Stamina" , "Magicka" , "MountStamina" , "Werewolf", "SiegeHealth" }
        for i = 1 , #frames do
            local frame = _G["ZO_PlayerAttribute"..frames[i]]
            frame:UnregisterForEvent(EVENT_POWER_UPDATE)
            frame:UnregisterForEvent(EVENT_INTERFACE_SETTING_CHANGED)
            frame:UnregisterForEvent(EVENT_PLAYER_ACTIVATED)
            eventManager:UnregisterForUpdate("ZO_PlayerAttribute"..frames[i].."FadeUpdate")
            frame:SetHidden(true)
        end
    end
end

-- Used to create custom frames extender controls for player and target.
-- Called from UF.Initialize
local function CreateCustomFrames()
    -- Create Custom unit frames
    if UF.SV.CustomFramesPlayer then
        -- Player Frame
        local playerTlw = UI.TopLevel( nil, nil )
        playerTlw:SetDrawLayer(DL_BACKDROP)
        playerTlw:SetDrawTier(DT_LOW)
        playerTlw:SetDrawLevel(1)
        playerTlw.customPositionAttr = "CustomFramesPlayerFramePos"
        playerTlw.preview = LUIE.UI.Backdrop( playerTlw, "fill", nil, nil, nil, true )
        local player = UI.Control( playerTlw, {TOPLEFT,TOPLEFT}, nil, false )
        local topInfo = UI.Control( player, {BOTTOM,TOP,0,-3}, nil, false )
        local botInfo = UI.Control( player, {TOP,BOTTOM,0,2}, nil, false )
        local buffAnchor = UI.Control( player, {TOP,BOTTOM,0,2}, nil, false )
        local phb = LUIE.UI.Backdrop( player, {TOP,TOP,0,0}, nil, nil, nil, false )
        phb:SetDrawLayer(DL_BACKDROP)
        phb:SetDrawLevel(1)
        local pmb = LUIE.UI.Backdrop( player, nil, nil, nil, nil, false )
        pmb:SetDrawLayer(DL_BACKDROP)
        pmb:SetDrawLevel(1)
        local psb = LUIE.UI.Backdrop( player, nil, nil, nil, nil, false )
        psb:SetDrawLayer(DL_BACKDROP)
        psb:SetDrawLevel(1)
        local alt = LUIE.UI.Backdrop( botInfo, {RIGHT,RIGHT}, nil, nil , {0,0,0,1}, false )
        local pli = UI.Texture( topInfo, nil, {20,20}, nil, nil, false )

        local fragment = ZO_HUDFadeSceneFragment:New(playerTlw, 0, 0)

        sceneManager:GetScene("hud"):AddFragment( fragment )
        sceneManager:GetScene("hudui"):AddFragment( fragment )
        sceneManager:GetScene("siegeBar"):AddFragment( fragment )
        sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )

        -- Collect all together
        UF.CustomFrames.player = {
            ["unitTag"]     = "player",
            ["tlw"]         = playerTlw,
            ["control"]     = player,
            [POWERTYPE_HEALTH] = {
                ["backdrop"]= phb,
                ["labelOne"]= UI.Label( phb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "xx / yy", false ),
                ["labelTwo"]= UI.Label( phb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "zz%", false ),
                ["bar"]     = UI.StatusBar( phb, nil, nil, nil, false ),
                ["shield"]  = UI.StatusBar( phb, nil, nil, nil, true ),
                ["threshold"] = g_healthThreshold
            },
            [POWERTYPE_MAGICKA] = {
                ["backdrop"]= pmb,
                ["labelOne"]= UI.Label( pmb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "xx / yy", false ),
                ["labelTwo"]= UI.Label( pmb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "zz%", false ),
                ["bar"]     = UI.StatusBar( pmb, nil, nil, nil, false ),
                ["threshold"] = g_magickaThreshold
            },
            [POWERTYPE_STAMINA] = {
                ["backdrop"]= psb,
                ["labelOne"]= UI.Label( psb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "xx / yy", false ),
                ["labelTwo"]= UI.Label( psb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "zz%", false ),
                ["bar"]     = UI.StatusBar( psb, nil, nil, nil, false ),
                ["threshold"] = g_staminaThreshold
            },
            ["alternative"] = {
                ["backdrop"]= alt,
                ["enlightenment"] = UI.StatusBar( alt, nil, nil, nil, false ),
                ["bar"]     = UI.StatusBar( alt, nil, nil, nil, false ),
                ["icon"]    = UI.Texture( alt, {RIGHT,LEFT,-2,0}, {20,20}, nil, nil, false ),
            },
            ["topInfo"]     = topInfo,
            ["name"]        = UI.Label( topInfo, {BOTTOMLEFT,BOTTOMLEFT}, nil, {0,4}, nil, "Player Name", false ),
            ["levelIcon"]   = pli,
            ["level"]       = UI.Label( topInfo, {LEFT,RIGHT,1,0,pli}, nil, {0,1}, nil, "level", false ),
            ["classIcon"]   = UI.Texture( topInfo, {RIGHT,RIGHT,-1,0}, {22,22}, nil, nil, false ),
            ["botInfo"]     = botInfo,
            ["buffAnchor"]  = buffAnchor,
            ["buffs"]       = UI.Control( playerTlw, nil, nil, false ),
            ["debuffs"]     = UI.Control( playerTlw, {BOTTOM,TOP,0,-2,topInfo}, nil, false ),
        }

        -- If Stamina Label is hidden in menu options, hide the stamina bar labels
        if UF.SV.HideLabelStamina then
            UF.CustomFrames.player[POWERTYPE_STAMINA].labelOne:SetHidden(true)
            UF.CustomFrames.player[POWERTYPE_STAMINA].labelTwo:SetHidden(true)
        end

        -- If Magicka Label is hidden in menu options, hide the magicka bar labels
        if UF.SV.HideLabelMagicka then
            UF.CustomFrames.player[POWERTYPE_MAGICKA].labelOne:SetHidden(true)
            UF.CustomFrames.player[POWERTYPE_MAGICKA].labelTwo:SetHidden(true)
        end

        UF.CustomFrames.controlledsiege = { -- placeholder for alternative bar when using siege weapon
            ["unitTag"]     = "controlledsiege",
        }
    end

    if UF.SV.CustomFramesTarget then
        -- Target Frame
        local targetTlw = UI.TopLevel( nil, nil )
        targetTlw:SetDrawLayer(DL_BACKDROP)
        targetTlw:SetDrawTier(DT_LOW)
        targetTlw:SetDrawLevel(1)
        targetTlw.customPositionAttr = "CustomFramesTargetFramePos"
        targetTlw.preview = LUIE.UI.Backdrop( targetTlw, "fill", nil, nil, nil, true )
        targetTlw.previewLabel = UI.Label( targetTlw.preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", "Target Frame", false )
        local target = UI.Control( targetTlw, {TOPLEFT,TOPLEFT}, nil, false )
        local topInfo = UI.Control( target, {BOTTOM,TOP,0,-3}, nil, false )
        local botInfo = UI.Control( target, {TOP,BOTTOM,0,2}, nil, false )
        local buffAnchor = UI.Control( target, {TOP,BOTTOM,0,2}, nil, false )
        local thb = LUIE.UI.Backdrop(target, {TOP,TOP,0,0}, nil, nil, nil, false )
        thb:SetDrawLayer(DL_BACKDROP)
        thb:SetDrawLevel(1)
        local tli = UI.Texture( topInfo, nil, {20,20}, nil, nil, false )
        local ari = UI.Texture( botInfo, {RIGHT,RIGHT,-1,0}, {20,20}, nil, nil, false )
        local buffs
        local debuffs
        if UF.SV.PlayerFrameOptions == 1 then
            buffs = UI.Control( targetTlw, {TOP,BOTTOM,0,2,buffAnchor}, nil, false )
            debuffs = UI.Control( targetTlw, {BOTTOM,TOP,0,-2,topInfo}, nil, false )
        else
            buffs = UI.Control( targetTlw, {BOTTOM,TOP,0,-2,topInfo}, nil, false )
            debuffs = UI.Control( targetTlw, {TOP,BOTTOM,0,2,buffAnchor}, nil, false )
        end

        local fragment = ZO_HUDFadeSceneFragment:New(targetTlw, 0, 0)

        sceneManager:GetScene("hud"):AddFragment( fragment )
        sceneManager:GetScene("hudui"):AddFragment( fragment )
        sceneManager:GetScene("siegeBar"):AddFragment( fragment )
        sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )

        -- Collect all together
        UF.CustomFrames.reticleover = {
            ["unitTag"]     = "reticleover",
            ["tlw"]         = targetTlw,
            ["control"]     = target,
            ["canHide"]     = true,
            [POWERTYPE_HEALTH] = {
                ["backdrop"]= thb,
                ["labelOne"]= UI.Label( thb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "xx / yy", false ),
                ["labelTwo"]= UI.Label( thb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "zz%", false ),
                ["bar"]     = UI.StatusBar( thb, nil, nil, nil, false ),
                ["shield"]  = UI.StatusBar( thb, nil, nil, nil, true ),
                ["threshold"] = g_targetThreshold,
            },
            ["topInfo"]     = topInfo,
            ["name"]        = UI.Label( topInfo, {BOTTOMLEFT,BOTTOMLEFT}, nil, {0,4}, nil, "Target Name", false ),
            ["levelIcon"]   = tli,
            ["level"]       = UI.Label( topInfo, {LEFT,RIGHT,1,0,tli}, nil, {0,1}, nil, "level", false ),
            ["classIcon"]   = UI.Texture( topInfo, {RIGHT,RIGHT,-1,0}, {22,22}, nil, nil, false ),
            ["className"]   = UI.Label( topInfo, {BOTTOMRIGHT,TOPRIGHT,-1,-1}, nil, {2,4}, nil, "Class", false ),
            ["friendIcon"]  = UI.Texture( topInfo, {RIGHT,RIGHT,-20,0}, {22,22}, nil, nil, false ),
            ["botInfo"]     = botInfo,
            ["buffAnchor"]  = buffAnchor,
            ["title"]       = UI.Label( botInfo, {TOPLEFT,TOPLEFT}, nil, {0,3}, nil, "<Title>", false ),
            ["avaRankIcon"] = ari,
            ["avaRank"]     = UI.Label( botInfo, {RIGHT,LEFT,-1,0,ari}, nil, {2,3}, nil, "ava", false ),
            ["dead"]        = UI.Label( thb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "Status", true ),
            ["skull"]       = UI.Texture( target, {RIGHT,LEFT,-8,0}, nil, "LuiExtended/media/unitframes/unitframes_execute.dds", nil, true ),
            ["buffs"]       = buffs,
            ["debuffs"]     = debuffs,
        }
        UF.CustomFrames.reticleover.className:SetDrawLayer( DL_BACKGROUND )
    end

    if UF.SV.AvaCustFramesTarget then
        -- Target Frame
        local targetTlw = UI.TopLevel( nil, nil )
        targetTlw:SetDrawLayer(DL_BACKDROP)
        targetTlw:SetDrawTier(DT_LOW)
        targetTlw:SetDrawLevel(1)
        targetTlw.customPositionAttr = "AvaCustFramesTargetFramePos"
        targetTlw.preview = LUIE.UI.Backdrop( targetTlw, "fill", nil, nil, nil, true )
        targetTlw.previewLabel = UI.Label( targetTlw.preview, {CENTER,CENTER}, nil, nil, "ZoFontGameMedium", "PvP Player Target Frame", false )
        local target = UI.Control( targetTlw, {TOPLEFT,TOPLEFT}, nil, false )
        local topInfo = UI.Control( target, {BOTTOM,TOP,0,-3}, nil, false )
        local botInfo = UI.Control( target, {TOP,BOTTOM,0,2}, nil, false )
        local buffAnchor = UI.Control( target, {TOP,BOTTOM,0,2}, nil, false )
        local thb = LUIE.UI.Backdrop(target, {TOP,TOP,0,0}, nil, nil, nil, false )
        thb:SetDrawLayer(DL_BACKDROP)
        thb:SetDrawLevel(1)
        local cn = UI.Label( botInfo, {TOP,TOP}, nil, {1,3}, nil, "Class", false )

        local fragment = ZO_HUDFadeSceneFragment:New(targetTlw, 0, 0)

        sceneManager:GetScene("hud"):AddFragment( fragment )
        sceneManager:GetScene("hudui"):AddFragment( fragment )
        sceneManager:GetScene("siegeBar"):AddFragment( fragment )
        sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )

        -- Collect all together
        -- Notice, that we put this table into same UF.CustomFrames table.
        -- This is done to apply formating more easier
        -- Later this table will be referenced from g_AvaCustFrames
        UF.CustomFrames.AvaPlayerTarget = {
            ["unitTag"]     = "reticleover",
            ["tlw"]         = targetTlw,
            ["control"]     = target,
            ["canHide"]     = true,
            [POWERTYPE_HEALTH] = {
                ["backdrop"]= thb,
                ["label"]   = UI.Label( thb, {CENTER,CENTER}, nil, {1,1}, nil, "zz%", false ),
                ["labelOne"]= UI.Label( thb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "xx + ss", false ),
                ["labelTwo"]= UI.Label( thb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "yy", false ),
                ["bar"]     = UI.StatusBar( thb, nil, nil, nil, false ),
                ["shield"]  = UI.StatusBar( thb, nil, nil, nil, true ),
                ["threshold"] = g_targetThreshold,
            },
            ["topInfo"]     = topInfo,
            ["name"]        = UI.Label( topInfo, {BOTTOM,BOTTOM}, nil, {1,4}, nil, "Target Name", false ),
            ["classIcon"]   = UI.Texture( topInfo, {LEFT,LEFT}, {20,20}, nil, nil, false ),
            ["avaRankIcon"] = UI.Texture( topInfo, {RIGHT,RIGHT}, {20,20}, nil, nil, false ),
            ["botInfo"]     = botInfo,
            ["buffAnchor"]  = buffAnchor,
            ["className"]   = cn,
            ["title"]       = UI.Label( botInfo, {TOP,BOTTOM,0,0,cn}, nil, {1,3}, nil, "<Title>", false ),
            ["avaRank"]     = UI.Label( botInfo, {TOPRIGHT,TOPRIGHT}, nil, {2,3}, nil, "ava", false ),
            ["dead"]        = UI.Label( thb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "Status", true ),
        }

        UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].label.fmt = "Percentage%"
        UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].labelOne.fmt = "Current + Shield"
        UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].labelTwo.fmt = "Max"

        -- Put in into table with secondary frames so it can be accessed by other functions in this module
        g_AvaCustFrames.reticleover = UF.CustomFrames.AvaPlayerTarget
    end

    -- Loop through Small Group members
    if UF.SV.CustomFramesGroup then
        -- Group Frame
        local group = UI.TopLevel( nil, nil )
        group:SetDrawLayer(DL_BACKDROP)
        group:SetDrawTier(DT_LOW)
        group:SetDrawLevel(1)
        group.customPositionAttr = "CustomFramesGroupFramePos"
        group.preview = LUIE.UI.Backdrop( group, "fill", nil, nil, nil, true )
        group.previewLabel = UI.Label( group.preview, {BOTTOM,TOP,0,-1,group}, nil, nil, "ZoFontGameMedium", "Small Group", false )

        local fragment = ZO_HUDFadeSceneFragment:New(group, 0, 0)

        sceneManager:GetScene("hud"):AddFragment( fragment )
        sceneManager:GetScene("hudui"):AddFragment( fragment )
        sceneManager:GetScene("siegeBar"):AddFragment( fragment )
        sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )
        sceneManager:GetScene("loot"):AddFragment( fragment )

        for i = 1, 4 do
            local unitTag = "SmallGroup" .. i
            local control = UI.Control( group, nil, nil, false )
            local topInfo = UI.Control( control, {BOTTOMRIGHT,TOPRIGHT,0,-3}, nil, false )
            local ghb = LUIE.UI.Backdrop( control, {TOPLEFT,TOPLEFT}, nil, nil, nil, false )
            ghb:SetDrawLayer(DL_BACKDROP)
            ghb:SetDrawLevel(1)
            local gli = UI.Texture( topInfo, nil, {20,20}, nil, nil, false )

            UF.CustomFrames[unitTag] = {
                ["tlw"]         = group,
                ["control"]     = control,
                [POWERTYPE_HEALTH] = {
                    ["backdrop"]= ghb,
                    ["labelOne"]= UI.Label( ghb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "xx / yy", false ),
                    ["labelTwo"]= UI.Label( ghb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "zz%", false ),
                    ["bar"]     = UI.StatusBar( ghb, nil, nil, nil, false ),
                    ["shield"]  = UI.StatusBar( ghb, nil, nil, nil, true ),
                },
                ["topInfo"]     = topInfo,
                ["name"]        = UI.Label( topInfo, {BOTTOMLEFT,BOTTOMLEFT}, nil, {0,4}, nil, unitTag, false ),
                ["levelIcon"]   = gli,
                ["level"]       = UI.Label( topInfo, {LEFT,RIGHT,1,0,gli}, nil, {0,1}, nil, "level", false ),
                ["classIcon"]   = UI.Texture( topInfo, {RIGHT,RIGHT,-1,0}, {22,22}, nil, nil, false ),
                ["friendIcon"]  = UI.Texture( topInfo, {RIGHT,RIGHT,-20,0}, {22,22}, nil, nil, false ),
                ["roleIcon"]    = UI.Texture( ghb, {LEFT,LEFT, 5,0}, {18,18}, nil, 2, false ),
                ["dead"]        = UI.Label( ghb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, "Status", false ),
                ["leader"]      = UI.Texture( topInfo, {LEFT,LEFT, -7,0}, {32,32}, nil, 2, false ),
            }

            control.defaultUnitTag = GetGroupUnitTagByIndex(i)
            control:SetMouseEnabled(true)
            control:SetHandler("OnMouseUp", UF.GroupFrames_OnMouseUp)
            topInfo.defaultUnitTag = GetGroupUnitTagByIndex(i)
            topInfo:SetMouseEnabled(true)
            topInfo:SetHandler("OnMouseUp", UF.GroupFrames_OnMouseUp)

        end
    end

    -- Loop through Raid Group members
    if UF.SV.CustomFramesRaid then
        -- Raid Frame
        local raid = UI.TopLevel( nil, nil )
        raid:SetDrawLayer(DL_BACKDROP)
        raid:SetDrawTier(DT_LOW)
        raid:SetDrawLevel(1)
        raid.customPositionAttr = "CustomFramesRaidFramePos"
        raid.preview = LUIE.UI.Backdrop( raid, {TOPLEFT,TOPLEFT}, nil, nil, nil, true )
        raid.preview2 = LUIE.UI.Backdrop( raid.preview, nil, nil, nil, nil, false )
        raid.previewLabel = UI.Label( raid.preview, {BOTTOM,TOP,0,-1,raid}, nil, nil, "ZoFontGameMedium", "Raid Group", false )

        local fragment = ZO_HUDFadeSceneFragment:New(raid, 0, 0)

        sceneManager:GetScene("hud"):AddFragment( fragment )
        sceneManager:GetScene("hudui"):AddFragment( fragment )
        sceneManager:GetScene("siegeBar"):AddFragment( fragment )
        sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )
        sceneManager:GetScene("loot"):AddFragment( fragment )

        for i = 1, 24 do
            local unitTag = "RaidGroup" .. i
            local control = UI.Control( raid, nil, nil, false )
            local rhb = LUIE.UI.Backdrop( control, "fill", nil, nil, nil, false )
            rhb:SetDrawLayer(DL_BACKDROP)
            rhb:SetDrawLevel(1)

            UF.CustomFrames[unitTag] = {
                ["tlw"]         = raid,
                ["control"]     = control,
                [POWERTYPE_HEALTH] = {
                    ["backdrop"]= rhb,
                    ["label"]   = UI.Label( rhb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "zz%", false ),
                    ["bar"]     = UI.StatusBar( rhb, nil, nil, nil, false ),
                    ["shield"]  = UI.StatusBar( rhb, nil, nil, nil, true ),
                },
                ["name"]        = UI.Label( rhb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, unitTag, false ),
                ["roleIcon"]    = UI.Texture( rhb, {LEFT,LEFT, 4,0}, {16,16}, nil, 2, false ),
                ["classIcon"]    = UI.Texture( rhb, {LEFT,LEFT, 1,0}, {20,20}, nil, 2, false ),
                ["dead"]        = UI.Label( rhb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "Status", false ),
                ["leader"]      = UI.Texture( rhb, {LEFT,LEFT, -2,0}, {28,28}, nil, 2, false ),

            }

            control.defaultUnitTag = GetGroupUnitTagByIndex(i)
            control:SetMouseEnabled(true)
            control:SetHandler("OnMouseUp", UF.GroupFrames_OnMouseUp)

            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].label.fmt = "Current (Percentage%)"
        end
    end

    -- Loop through Bosses
    if UF.SV.CustomFramesBosses then
        -- Bosses Frame
        local bosses = UI.TopLevel( nil, nil )
        bosses:SetDrawLayer(DL_BACKDROP)
        bosses:SetDrawTier(DT_LOW)
        bosses:SetDrawLevel(1)
        bosses.customPositionAttr = "CustomFramesBossesFramePos"
        bosses.preview = LUIE.UI.Backdrop( bosses, "fill", nil, nil, nil, true )
        bosses.previewLabel = UI.Label( bosses.preview, {BOTTOM,TOP,0,-1,bosses}, nil, nil, "ZoFontGameMedium", "Bosses Group", false )

        local fragment = ZO_HUDFadeSceneFragment:New(bosses, 0, 0)

        sceneManager:GetScene("hud"):AddFragment( fragment )
        sceneManager:GetScene("hudui"):AddFragment( fragment )
        sceneManager:GetScene("siegeBar"):AddFragment( fragment )
        sceneManager:GetScene("siegeBarUI"):AddFragment( fragment )
        sceneManager:GetScene("loot"):AddFragment( fragment )

        for i = 1, 6 do
            local unitTag = "boss" .. i
            local control = UI.Control( bosses, nil, nil, false )
            local bhb = LUIE.UI.Backdrop( control, "fill", nil, nil, nil, false )
            bhb:SetDrawLayer(DL_BACKDROP)
            bhb:SetDrawLevel(1)

            UF.CustomFrames[unitTag] = {
                ["unitTag"]     = unitTag,
                ["tlw"]         = bosses,
                ["control"]     = control,
                [POWERTYPE_HEALTH] = {
                    ["backdrop"]= bhb,
                    ["label"]   = UI.Label( bhb, {RIGHT,RIGHT,-5,0}, nil, {2,1}, nil, "zz%", false ),
                    ["bar"]     = UI.StatusBar( bhb, nil, nil, nil, false ),
                    ["shield"]  = UI.StatusBar( bhb, nil, nil, nil, true ),
                    ["threshold"] = g_targetThreshold,
                },
                ["name"]        = UI.Label( bhb, {LEFT,LEFT,5,0}, nil, {0,1}, nil, unitTag, false ),
            }
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].label.fmt = "Percentage%"
        end
    end

    -- Callback used to hide anchor coords preview label on movement start
    local tlwOnMoveStart = function(self)
        eventManager:RegisterForUpdate( moduleName .. "previewMove", 200, function()
            self.preview.anchorLabel:SetText(strformat("<<1>>, <<2>>", self:GetLeft(), self:GetTop()))
        end)
    end
    -- Callback used to save new position of frames
    local tlwOnMoveStop = function(self)
        eventManager:UnregisterForUpdate( moduleName .. "previewMove" )
        UF.SV[self.customPositionAttr] = { self:GetLeft(), self:GetTop() }
    end

    -- Common actions for all created frames:
    for _, baseName in pairs( { "player", "reticleover", "SmallGroup", "RaidGroup", "boss", "AvaPlayerTarget" } ) do
        -- set mouse handlers for all created tlws and create anchor coords preview labels
        local unitFrame = UF.CustomFrames[baseName] or UF.CustomFrames[baseName .. "1"] or nil
        if unitFrame ~= nil then
            -- Movement handlers
            unitFrame.tlw:SetHandler( "OnMoveStart", tlwOnMoveStart )
            unitFrame.tlw:SetHandler( "OnMoveStop", tlwOnMoveStop )

            -- Create Texture and a label for Anchor Preview
            unitFrame.tlw.preview.anchorTexture = UI.Texture( unitFrame.tlw.preview, {TOPLEFT,TOPLEFT}, {16,16}, "/esoui/art/reticle/border_topleft.dds", DL_OVERLAY, false )
            unitFrame.tlw.preview.anchorTexture:SetColor(1, 1, 0, 0.9)

            unitFrame.tlw.preview.anchorLabel = UI.Label( unitFrame.tlw.preview, {BOTTOMLEFT,TOPLEFT,0,-1}, nil, {0,2}, "ZoFontGameSmall", "xxx, yyy", false )
            unitFrame.tlw.preview.anchorLabel:SetColor(1, 1, 0 , 1)
            unitFrame.tlw.preview.anchorLabel:SetDrawLayer(DL_OVERLAY)
            unitFrame.tlw.preview.anchorLabel:SetDrawTier(1)
            unitFrame.tlw.preview.anchorLabelBg = UI.Backdrop( unitFrame.tlw.preview.anchorLabel, "fill", nil, {0,0,0,1}, {0,0,0,1}, false )
            unitFrame.tlw.preview.anchorLabelBg:SetDrawLayer(DL_OVERLAY)
            unitFrame.tlw.preview.anchorLabelBg:SetDrawTier(0)
        end

        -- Now we have to anchor all bars to their backdrops
        local shieldOverlay = ( baseName == "RaidGroup" or baseName == "boss" ) or not UF.SV.CustomShieldBarSeparate
        local shieldFull = ( baseName == "RaidGroup" or baseName == "boss" ) or UF.SV.CustomShieldBarFull
        for i = 0, 24 do
            local unitTag = (i==0) and baseName or ( baseName .. i )
            if UF.CustomFrames[unitTag] then
                for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA, "alternative"} ) do
                    local powerBar = UF.CustomFrames[unitTag][powerType]
                    if powerBar then
                        powerBar.bar:SetAnchor( TOPLEFT, powerBar.backdrop, TOPLEFT, 1, 1 )
                        powerBar.bar:SetAnchor( BOTTOMRIGHT, powerBar.backdrop, BOTTOMRIGHT, -1, -1 )

                        -- Also set anchors for enlightenment bar
                        if powerBar.enlightenment then
                            powerBar.enlightenment:SetAnchor( TOPLEFT, powerBar.backdrop, TOPLEFT, 1, 1 )
                            powerBar.enlightenment:SetAnchor( BOTTOMRIGHT, powerBar.backdrop, BOTTOMRIGHT, -1, -1 )
                        end

                        if powerBar.shield then
                            if shieldOverlay then
                                powerBar.shield:SetAnchor( TOPLEFT, powerBar.backdrop, shieldFull and TOPLEFT or LEFT, 1, 1 )
                                powerBar.shield:SetAnchor( BOTTOMRIGHT, powerBar.backdrop, BOTTOMRIGHT, -1, -1 )
                            else
                                -- In non-overlay mode we need to create separate backdrop for shield
                                powerBar.shieldbackdrop = LUIE.UI.Backdrop( UF.CustomFrames[unitTag].control, nil, nil, nil, nil, true )
                                powerBar.shield:SetAnchor( TOPLEFT, powerBar.shieldbackdrop, TOPLEFT, 1, 1 )
                                powerBar.shield:SetAnchor( BOTTOMRIGHT, powerBar.shieldbackdrop, BOTTOMRIGHT, -1, -1 )
                            end
                        end
                    end
                end
            end
        end
    end

    -- Create DOT / HOT animations for all attributes bars
    -- We will use this ugly loop over too-many controls, but it will keep things clean and uni-style
    if UF.SV.PlayerEnableRegen then
        for _, baseName in pairs( { 'player', 'reticleover', 'AvaPlayerTarget' } ) do
            local unitTag = baseName
            if UF.CustomFrames[unitTag] then
                for _, powerType in pairs( {POWERTYPE_HEALTH} ) do
                    if UF.CustomFrames[unitTag][powerType] then
                        local backdrop = UF.CustomFrames[unitTag][powerType].backdrop
                        local size1
                        local size2
                        if baseName == "player" then
                            size1 = UF.SV.PlayerBarWidth
                            size2 = UF.SV.PlayerBarHeightHealth
                        elseif baseName == "reticleover" then
                            size1 = UF.SV.TargetBarWidth
                            size2 = UF.SV.TargetBarHeight
                        elseif baseName == "AvaPlayerTarget" then
                            size1 = UF.SV.AvaTargetBarWidth
                            size2 = UF.SV.AvaTargetBarHeight
                        end
                        if size1 ~= nil and size2 ~= nil then
                            UF.CustomFrames[unitTag][powerType].regen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "regen1" )
                            UF.CustomFrames[unitTag][powerType].regen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "regen2" )
                            UF.CustomFrames[unitTag][powerType].degen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "degen1" )
                            UF.CustomFrames[unitTag][powerType].degen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "degen2" )
                        end
                    end
                end
            end
        end
    end

    if UF.SV.GroupEnableRegen then
        for i = 1, 4 do
            local unitTag = 'SmallGroup' .. i
            if UF.CustomFrames[unitTag] then
                for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA} ) do
                    if UF.CustomFrames[unitTag][powerType] then
                        local backdrop = UF.CustomFrames[unitTag][powerType].backdrop
                        local size1 = UF.SV.GroupBarWidth
                        local size2 = UF.SV.GroupBarHeight
                        if size1 ~= nil and size2 ~= nil then
                            UF.CustomFrames[unitTag][powerType].regen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .4) }, 0.55, "regen1" )
                            UF.CustomFrames[unitTag][powerType].regen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .4) }, 0.55, "regen2" )
                            UF.CustomFrames[unitTag][powerType].degen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .4) }, 0.55, "degen1" )
                            UF.CustomFrames[unitTag][powerType].degen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .4) }, 0.55, "degen2" )
                        end
                    end
                end
            end
        end
    end

    if UF.SV.RaidEnableRegen then
        for i = 1, 24 do
            local unitTag = 'RaidGroup' .. i
            if UF.CustomFrames[unitTag] then
                for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA} ) do
                    if UF.CustomFrames[unitTag][powerType] then
                        local backdrop = UF.CustomFrames[unitTag][powerType].backdrop
                        local size1 = UF.SV.RaidBarWidth
                        local size2 = UF.SV.RaidBarHeight
                        if size1 ~= nil and size2 ~= nil then
                            UF.CustomFrames[unitTag][powerType].regen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "regen1" )
                            UF.CustomFrames[unitTag][powerType].regen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "regen2" )
                            UF.CustomFrames[unitTag][powerType].degen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "degen1" )
                            UF.CustomFrames[unitTag][powerType].degen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "degen2" )
                        end
                    end
                end
            end
        end
    end

    if UF.SV.BossEnableRegen then
        for i = 0, 6 do
            local unitTag = 'boss' .. i
            if UF.CustomFrames[unitTag] then
                for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA} ) do
                    if UF.CustomFrames[unitTag][powerType] then
                        local backdrop = UF.CustomFrames[unitTag][powerType].backdrop
                        local size1 = UF.SV.BossBarWidth
                        local size2 = UF.SV.BossBarHeight
                        if size1 ~= nil and size2 ~= nil then
                            UF.CustomFrames[unitTag][powerType].regen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "regen1" )
                            UF.CustomFrames[unitTag][powerType].regen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "regen2" )
                            UF.CustomFrames[unitTag][powerType].degen1 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "degen1" )
                            UF.CustomFrames[unitTag][powerType].degen2 = CreateRegenAnimation( backdrop, {CENTER,CENTER,0,0}, { size1 - 4, size2 -(size2 * .3) }, 0.55, "degen2" )
                        end
                    end
                end
            end
        end
    end

    -- Create armor stat change UI for player and target
    if UF.SV.PlayerEnableArmor then
        for _, baseName in pairs( { 'player', 'reticleover', 'AvaPlayerTarget' } ) do
            local unitTag = baseName
            if UF.CustomFrames[unitTag] then
                -- Assume that unitTag DO have [POWERTYPE_HEALTH] field
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {}
                end
                local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_ARMOR_RATING] = {
                    ["dec"] = CreateDecreasedArmorOverlay( backdrop, false ),
                    ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,13,0}, {24,24}, "/esoui/art/icons/alchemy/crafting_alchemy_trait_increasearmor.dds", 2, true ),
                }
            end
        end
    end

    if UF.SV.GroupEnableArmor then
        for i = 1, 4 do
            local unitTag = 'SmallGroup' .. i
            if UF.CustomFrames[unitTag] then
                -- Assume that unitTag DO have [POWERTYPE_HEALTH] field
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {}
                end
                local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_ARMOR_RATING] = {
                    ["dec"] = CreateDecreasedArmorOverlay( backdrop, false ),
                    ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,13,0}, {24,24}, "/esoui/art/icons/alchemy/crafting_alchemy_trait_increasearmor.dds", 2, true ),
                }
            end
        end
    end

    if UF.SV.RaidEnableArmor then
        for i = 1, 24 do
            local unitTag = 'RaidGroup' .. i
            if UF.CustomFrames[unitTag] then
                -- Assume that unitTag DO have [POWERTYPE_HEALTH] field
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {}
                end
                local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_ARMOR_RATING] = {
                    ["dec"] = CreateDecreasedArmorOverlay( backdrop, false ),
                    ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,13,0}, {24,24}, "/esoui/art/icons/alchemy/crafting_alchemy_trait_increasearmor.dds", 2, true ),
                }
            end
        end
    end

    if UF.SV.BossEnableArmor then
        for i = 0, 6 do
            local unitTag = 'boss' .. i
            if UF.CustomFrames[unitTag] then
                -- Assume that unitTag DO have [POWERTYPE_HEALTH] field
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {}
                end
                local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_ARMOR_RATING] = {
                    ["dec"] = CreateDecreasedArmorOverlay( backdrop, false ),
                    ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,13,0}, {24,24}, "/esoui/art/icons/alchemy/crafting_alchemy_trait_increasearmor.dds", 2, true ),
                }
            end
        end
    end

    -- Create power stat change UI for player and target
    if UF.SV.PlayerEnablePower then
        for _, baseName in pairs( { 'player', 'reticleover', 'AvaPlayerTarget' } ) do
            local unitTag = baseName
            if UF.CustomFrames[unitTag] then
                if baseName == "player" then
                    size1 = UF.SV.PlayerBarWidth
                    size2 = UF.SV.PlayerBarHeightHealth
                elseif baseName == "reticleover" then
                    size1 = UF.SV.TargetBarWidth
                    size2 = UF.SV.TargetBarHeight
                elseif baseName == "AvaPlayerTarget" then
                    size1 = UF.SV.AvaTargetBarWidth
                    size2 = UF.SV.AvaTargetBarHeight
                end
                if size1 ~= nil and size2 ~= nil then
                    if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {} end
                    local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_POWER] = {
                        ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,4,0}, {size1 * 1.8, size2 * 4.0}, "/esoui/art/unitattributevisualizer/increasedpower_animatedhalo_32fr.dds", 0, true ),
                        ["dec"] = UI.Texture( backdrop, {CENTER,CENTER,0,0}, {size1 * 2.2, size2 * 3}, "/esoui/art/unitattributevisualizer/attributebar_dynamic_decreasedpower_halo.dds", 0, true ),
                    }
                end
            end
        end
    end

    if UF.SV.GroupEnablePower then
        for i = 1, 4 do
            local unitTag = 'SmallGroup' .. i
            if UF.CustomFrames[unitTag] then
                -- assume that unitTag DO have [POWERTYPE_HEALTH] field
                local size1 = UF.SV.GroupBarWidth
                local size2 = UF.SV.GroupBarHeight
                --elseif baseName == "RaidGroup" then
                --    size1 = UF.SV.RaidBarWidth
                --    size2 = UF.SV.RaidBarHeight
                if size1 ~= nil and size2 ~= nil then
                    if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {} end
                    local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_POWER] = {
                        ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,4,0}, {size1 * 1.8, size2 * 4.0}, "/esoui/art/unitattributevisualizer/increasedpower_animatedhalo_32fr.dds", 0, true ),
                        ["dec"] = UI.Texture( backdrop, {CENTER,CENTER,0,0}, {size1 * 2.2, size2 * 3}, "/esoui/art/unitattributevisualizer/attributebar_dynamic_decreasedpower_halo.dds", 0, true ),
                    }
                end
            end
        end
    end

    if UF.SV.RaidEnablePower then
        for i = 1, 24 do
            local unitTag = 'RaidGroup' .. i
            if UF.CustomFrames[unitTag] then
                -- assume that unitTag DO have [POWERTYPE_HEALTH] field
                local size1 = UF.SV.RaidBarWidth
                local size2 = UF.SV.RaidBarHeight
                if size1 ~= nil and size2 ~= nil then
                    if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {} end
                    local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_POWER] = {
                        ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,4,0}, {size1 * 1.8, size2 * 4.0}, "/esoui/art/unitattributevisualizer/increasedpower_animatedhalo_32fr.dds", 0, true ),
                        ["dec"] = UI.Texture( backdrop, {CENTER,CENTER,0,0}, {size1 * 2.2, size2 * 3}, "/esoui/art/unitattributevisualizer/attributebar_dynamic_decreasedpower_halo.dds", 0, true ),
                    }
                end
            end
        end
    end

    if UF.SV.BossEnablePower then
        for i = 1, 6 do
            local unitTag = 'boss' .. i
            if UF.CustomFrames[unitTag] then
                -- assume that unitTag DO have [POWERTYPE_HEALTH] field
                local size1 = UF.SV.BossBarWidth
                local size2 = UF.SV.BossBarHeight
                if size1 ~= nil and size2 ~= nil then
                    if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat == nil then UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat = {} end
                    local backdrop = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_POWER] = {
                        ["inc"] = UI.Texture( backdrop, {CENTER,CENTER,4,0}, {size1 * 1.8, size2 * 4.0}, "/esoui/art/unitattributevisualizer/increasedpower_animatedhalo_32fr.dds", 0, true ),
                        ["dec"] = UI.Texture( backdrop, {CENTER,CENTER,0,0}, {size1 * 2.2, size2 * 3}, "/esoui/art/unitattributevisualizer/attributebar_dynamic_decreasedpower_halo.dds", 0, true ),
                    }
                end
            end
        end
    end

    -- Animate Power Glow for all frames that have it displayed
    for _, baseName in pairs( { 'player', 'reticleover', 'AvaPlayerTarget', 'boss', 'SmallGroup', 'RaidGroup' } ) do
        for i = 0, 24 do
            local unitTag = (i==0) and baseName or ( baseName .. i )
            if UF.CustomFrames[unitTag] then
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH] then
                    if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat then
                        if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_POWER] then
                            if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_POWER].inc then
                                -- Create glow animation
                                local control = UF.CustomFrames[unitTag][POWERTYPE_HEALTH].stat[STAT_POWER].inc
                                local animation, timeline = CreateSimpleAnimation(ANIMATION_TEXTURE, control)
                                animation:SetImageData(4, 8)
                                animation:SetFramerate(32)
                                animation:SetDuration(1000)
                                timeline:SetPlaybackType(ANIMATION_PLAYBACK_LOOP, LOOP_INDEFINITELY)

                                control.animation = animation
                                control.timeline = timeline

                                control.timeline:PlayFromStart()
                            end
                        end
                    end
                end
            end
        end
    end

    -- Set proper anchors according to user preferences
    UF.CustomFramesApplyLayoutPlayer(true)
    UF.CustomFramesApplyLayoutGroup(true)
    UF.CustomFramesApplyLayoutRaid(true)
    UF.CustomFramesApplyLayoutBosses()
    -- Set positions of tlws using saved values or default ones
    UF.CustomFramesSetPositions()
    -- Apply formatting for labels
    UF.CustomFramesFormatLabels()
    -- Apply bar textures
    UF.CustomFramesApplyTexture()
    -- Apply fonts
    UF.CustomFramesApplyFont()

    --[[
    -- Add this top level window to global controls list, so it can be hidden
    for _, unitTag in pairs( { "player", "reticleover", "SmallGroup1", "RaidGroup1", "boss1", "AvaPlayerTarget" } ) do
        if UF.CustomFrames[unitTag] then
            LUIE.components[ moduleName .. "_CustomFrame_" .. unitTag ] = UF.CustomFrames[unitTag].tlw
        end
    end
    ]]--
end

-- Main entry point to this module
function UF.Initialize( enabled )
    -- Load settings
    local isCharacterSpecific = LUIESV.Default[GetDisplayName()]['$AccountWide'].CharacterSpecificSV
    if isCharacterSpecific then
        UF.SV = ZO_SavedVars:New( LUIE.SVName, LUIE.SVVer, "UnitFrames", UF.D )
    else
        UF.SV = ZO_SavedVars:NewAccountWide( LUIE.SVName, LUIE.SVVer, "UnitFrames", UF.D )
    end

    if UF.SV.DefaultOocTransparency < 0 or UF.SV.DefaultOocTransparency > 100 then
        UF.SV.DefaultOocTransparency = UF.D.DefaultOocTransparency
    end
    if UF.SV.DefaultIncTransparency < 0 or UF.SV.DefaultIncTransparency > 100 then
        UF.SV.DefaultIncTransparency = UF.D.DefaultIncTransparency
    end

    -- If User does not want the UnitFrames then exit right here
    if not enabled then
        return
    end
    UF.Enabled = true

    -- Even if used do not want to use neither DefaultFrames nor CustomFrames, let us still create tables to hold health and shield values
    -- { powerValue, powerMax, powerEffectiveMax, shield }
    g_savedHealth.player          = {1,1,1,0}
    g_savedHealth.controlledsiege = {1,1,1,0}
    g_savedHealth.reticleover     = {1,1,1,0}
    for i = 1, 24 do
        g_savedHealth["group" .. i] = {1,1,1,0}
    end
    for i = 1, 6 do
        g_savedHealth["boss" .. i] = {1,1,1,0}
    end

    -- Get execute threshold percentage
    g_targetThreshold = UF.SV.ExecutePercentage

    g_healthThreshold = UF.SV.LowResourceHealth
    g_magickaThreshold = UF.SV.LowResourceStamina
    g_staminaThreshold = UF.SV.LowResourceMagicka

    CreateDefaultFrames()

    CreateCustomFrames()

    -- Reposition frames
    if UF.SV.RepositionFrames then
        -- Shift to center magicka and stamina bars
        ZO_PlayerAttributeHealth:ClearAnchors()
        ZO_PlayerAttributeHealth:SetAnchor( BOTTOM, ActionButton5, TOP, 0, -47 - UF.SV.RepositionFramesAdjust )
        ZO_PlayerAttributeMagicka:ClearAnchors()
        ZO_PlayerAttributeMagicka:SetAnchor( TOPRIGHT, ZO_PlayerAttributeHealth, BOTTOM, -1, 2 )
        ZO_PlayerAttributeStamina:ClearAnchors()
        ZO_PlayerAttributeStamina:SetAnchor( TOPLEFT, ZO_PlayerAttributeHealth, BOTTOM, 1, 2 )
        -- Shift to the right siege weapon health and ram control
        ZO_PlayerAttributeSiegeHealth:ClearAnchors()
        ZO_PlayerAttributeSiegeHealth:SetAnchor( CENTER, ZO_PlayerAttributeHealth, CENTER, 300, 0 )
        ZO_RAM.control:ClearAnchors()
        ZO_RAM.control:SetAnchor( BOTTOM, ZO_PlayerAttributeHealth, TOP, 300, 0 )
        -- Shift a little upwards small group unit frames
        ZO_SmallGroupAnchorFrame:ClearAnchors()
        ZO_SmallGroupAnchorFrame:SetAnchor( TOPLEFT, GuiRoot, TOPLEFT, 20, 80 ) -- default is 28,100
    end

    UF.SetDefaultFramesTransparency()

    -- Set event handlers
    eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_ACTIVATED, UF.OnPlayerActivated )
    eventManager:RegisterForEvent(moduleName, EVENT_POWER_UPDATE,     UF.OnPowerUpdate )
    eventManager:RegisterForEvent(moduleName, EVENT_UNIT_ATTRIBUTE_VISUAL_ADDED,   UF.OnVisualizationAdded )
    eventManager:RegisterForEvent(moduleName, EVENT_UNIT_ATTRIBUTE_VISUAL_REMOVED, UF.OnVisualizationRemoved )
    eventManager:RegisterForEvent(moduleName, EVENT_UNIT_ATTRIBUTE_VISUAL_UPDATED, UF.OnVisualizationUpdated )
    eventManager:RegisterForEvent(moduleName, EVENT_TARGET_CHANGE, UF.OnTargetChange )
    eventManager:RegisterForEvent(moduleName, EVENT_RETICLE_TARGET_CHANGED, UF.OnReticleTargetChanged )
    eventManager:RegisterForEvent(moduleName, EVENT_DISPOSITION_UPDATE, UF.OnDispositionUpdate )
    eventManager:RegisterForEvent(moduleName, EVENT_UNIT_CREATED, UF.OnUnitCreated )
    eventManager:RegisterForEvent(moduleName, EVENT_LEVEL_UPDATE,        UF.OnLevelUpdate )
    eventManager:RegisterForEvent(moduleName, EVENT_CHAMPION_POINT_UPDATE, UF.OnLevelUpdate )
    eventManager:RegisterForEvent(moduleName, EVENT_TITLE_UPDATE,  UF.TitleUpdate )
    eventManager:RegisterForEvent(moduleName, EVENT_RANK_POINT_UPDATE,  UF.TitleUpdate )

    -- Next events make sense only for CustomFrames
    if UF.CustomFrames.player or UF.CustomFrames.reticleover or UF.CustomFrames.SmallGroup1 or UF.CustomFrames.RaidGroup1 or UF.CustomFrames.boss1 then
        eventManager:RegisterForEvent(moduleName, EVENT_COMBAT_EVENT,          UF.OnCombatEvent )
        eventManager:AddFilterForEvent(moduleName, EVENT_COMBAT_EVENT, REGISTER_FILTER_IS_ERROR, true )

        eventManager:RegisterForEvent(moduleName, EVENT_UNIT_DESTROYED,        UF.OnUnitDestroyed )
        eventManager:RegisterForEvent(moduleName, EVENT_FRIEND_ADDED,          UF.SocialUpdateFrames)
        eventManager:RegisterForEvent(moduleName, EVENT_FRIEND_REMOVED,        UF.SocialUpdateFrames)
        eventManager:RegisterForEvent(moduleName, EVENT_IGNORE_ADDED,          UF.SocialUpdateFrames)
        eventManager:RegisterForEvent(moduleName, EVENT_IGNORE_REMOVED,        UF.SocialUpdateFrames)
        eventManager:RegisterForEvent(moduleName, EVENT_PLAYER_COMBAT_STATE,    UF.OnPlayerCombatState )
        eventManager:RegisterForEvent(moduleName, EVENT_WEREWOLF_STATE_CHANGED, UF.OnWerewolf )
        eventManager:RegisterForEvent(moduleName, EVENT_BEGIN_SIEGE_CONTROL,       UF.OnSiege )
        eventManager:RegisterForEvent(moduleName, EVENT_END_SIEGE_CONTROL,         UF.OnSiege )
        eventManager:RegisterForEvent(moduleName, EVENT_LEAVE_RAM_ESCORT,          UF.OnSiege )
        eventManager:RegisterForEvent(moduleName, EVENT_MOUNTED_STATE_CHANGED,     UF.OnMount )
        eventManager:RegisterForEvent(moduleName, EVENT_EXPERIENCE_UPDATE,         UF.OnXPUpdate )
        eventManager:RegisterForEvent(moduleName, EVENT_CHAMPION_POINT_GAINED,     UF.OnChampionPointGained )
        eventManager:RegisterForEvent(moduleName, EVENT_GROUP_SUPPORT_RANGE_UPDATE,    UF.OnGroupSupportRangeUpdate )
        eventManager:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_CONNECTED_STATUS, UF.OnGroupMemberConnectedStatus )
        eventManager:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_ROLE_CHANGED, UF.OnGroupMemberRoleChange )
        eventManager:RegisterForEvent(moduleName, EVENT_GROUP_UPDATE, UF.OnGroupMemberChange )
        eventManager:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_JOINED, UF.OnGroupMemberChange )
        eventManager:RegisterForEvent(moduleName, EVENT_GROUP_MEMBER_LEFT, UF.OnGroupMemberChange )
        eventManager:RegisterForEvent(moduleName, EVENT_UNIT_DEATH_STATE_CHANGED,  UF.OnDeath )
        eventManager:RegisterForEvent(moduleName, EVENT_LEADER_UPDATE,         UF.OnLeaderUpdate )
        eventManager:RegisterForEvent(moduleName, EVENT_BOSSES_CHANGED,    UF.OnBossesChanged )

        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_LEFT_GUILD,     UF.SocialUpdateFrames)
        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_SELF_JOINED_GUILD,   UF.SocialUpdateFrames)
        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_ADDED,        UF.SocialUpdateFrames)
        eventManager:RegisterForEvent(moduleName, EVENT_GUILD_MEMBER_REMOVED,      UF.SocialUpdateFrames)
    end

    -- New AvA frames
    if false then
        eventManager:RegisterForEvent(moduleName, EVENT_CURRENT_CAMPAIGN_CHANGED, UF.OnCurrentCampaignChanged) -- (integer eventCode, integer newCurrentCampaignId)
        eventManager:RegisterForEvent(moduleName, EVENT_CAMPAIGN_EMPEROR_CHANGED, UF.OnCampaignEmperorChanged) -- (integer eventCode, integer campaignId)
    end

    g_defaultTargetNameLabel = ZO_TargetUnitFramereticleoverName

    -- Initialize colouring. This is actually needed when user does NOT want those features
    UF.TargetColourByReaction()
    UF.ReticleColourByReaction()
end

-- Sets out-of-combat transparency values for default user-frames
function UF.SetDefaultFramesTransparency(min_pct_value, max_pct_value)
    if min_pct_value ~= nil then
        UF.SV.DefaultOocTransparency = min_pct_value
    end

    if max_pct_value ~= nil then
        UF.SV.DefaultIncTransparency = max_pct_value
    end

    local min_value = UF.SV.DefaultOocTransparency / 100
    local max_value = UF.SV.DefaultIncTransparency / 100

    ZO_PlayerAttributeHealth.playerAttributeBarObject.timeline:GetAnimation():SetAlphaValues(min_value, max_value)
    ZO_PlayerAttributeMagicka.playerAttributeBarObject.timeline:GetAnimation():SetAlphaValues(min_value, max_value)
    ZO_PlayerAttributeStamina.playerAttributeBarObject.timeline:GetAnimation():SetAlphaValues(min_value, max_value)

    local inCombat = IsUnitInCombat("player")
    ZO_PlayerAttributeHealth:SetAlpha(inCombat and max_value or min_value)
    ZO_PlayerAttributeStamina:SetAlpha(inCombat and max_value or min_value)
    ZO_PlayerAttributeMagicka:SetAlpha(inCombat and max_value or min_value)
end

-- Update selection for target name colouring
function UF.TargetColourByReaction(value)
    -- If we have a parameter, save it
    if value ~= nil then
        UF.SV.TargetColourByReaction = value
    end
    -- If this Target name colouring is not required, revert it back to white
    if not value then
        g_defaultTargetNameLabel:SetColor(1,1,1,1)
    end
end

-- Update selection for target name colouring
function UF.ReticleColourByReaction(value)
    if value ~= nil then
        UF.SV.ReticleColourByReaction = value
    end
    -- If this Reticle colouring is not required, revert it back to white
    if not value then
        ZO_ReticleContainerReticle:SetColor(1, 1, 1)
    end
end

-- Update format for labels on CustomFrames
function UF.CustomFramesFormatLabels(menu)
    -- Search CustomFrames for attribute bars with correct labels
    -- Format Player/Target Labels
    for _, baseName in pairs( { "player", "reticleover" } ) do
        local unitTag = baseName
        if UF.CustomFrames[unitTag] then
            for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA} ) do
                if UF.CustomFrames[unitTag][powerType] then
                    if UF.CustomFrames[unitTag][powerType].labelOne then
                        UF.CustomFrames[unitTag][powerType].labelOne.fmt = UF.SV.CustomFormatOnePT
                    end
                    if UF.CustomFrames[unitTag][powerType].labelTwo then
                        UF.CustomFrames[unitTag][powerType].labelTwo.fmt = UF.SV.CustomFormatTwoPT
                    end
                end
            end
        end
        if menu and DoesUnitExist(unitTag) then
            UF.ReloadValues(unitTag)
        end
    end

    -- Format Small Group Labels
    for i = 1, 4 do
        local unitTag = "SmallGroup" .. i
        if UF.CustomFrames[unitTag] then
            if UF.CustomFrames[unitTag][POWERTYPE_HEALTH] then
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].labelOne then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].labelOne.fmt = UF.SV.CustomFormatOneGroup
                end
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].labelTwo then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].labelTwo.fmt = UF.SV.CustomFormatTwoGroup
                end
            end
        end
        if menu and DoesUnitExist(unitTag) then
            UF.ReloadValues(unitTag)
        end
    end

    -- Format Raid Labels
    for i = 1, 24 do
        local unitTag = "RaidGroup" .. i
        if UF.CustomFrames[unitTag] then
            if UF.CustomFrames[unitTag][POWERTYPE_HEALTH] then
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].label then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].label.fmt = UF.SV.CustomFormatRaid
                end
            end
        end
        local baseTag = GetGroupUnitTagByIndex(i)
        if menu and DoesUnitExist(baseTag) then
            UF.ReloadValues(baseTag)
        end
    end

    -- Format Boss Labels
    for i = 1, 6 do
        local unitTag = "boss" .. i
        if UF.CustomFrames[unitTag] then
            if UF.CustomFrames[unitTag][POWERTYPE_HEALTH] then
                if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].label then
                    UF.CustomFrames[unitTag][POWERTYPE_HEALTH].label.fmt = UF.SV.CustomFormatBoss
                end
            end
        end
        if menu and DoesUnitExist(unitTag) then
            UF.ReloadValues(unitTag)
        end
    end
end

-- Runs on the EVENT_PLAYER_ACTIVATED listener.
-- This handler fires every time the player is loaded. Used to set initial values.
function UF.OnPlayerActivated(eventCode)
    -- Reload values for player frames
    UF.ReloadValues("player")
    UF.UpdateRegen( "player", STAT_MAGICKA_REGEN_COMBAT, ATTRIBUTE_MAGICKA, POWERTYPE_MAGICKA )
    UF.UpdateRegen( "player", STAT_STAMINA_REGEN_COMBAT, ATTRIBUTE_STAMINA, POWERTYPE_STAMINA )

    -- Create UI elements for default group members frames
    if g_DefaultFrames.SmallGroup then
        for i = 1, 24 do
            local unitTag = "group" .. i
            if DoesUnitExist(unitTag) then
                UF.DefaultFramesCreateUnitGroupControls(unitTag)
            end
        end
    end

    -- If CustomFrames are used then values will be reloaded in following function
    if UF.CustomFrames.SmallGroup1 ~= nil or UF.CustomFrames.RaidGroup1 ~= nil then
        UF.CustomFramesGroupUpdate()

    -- Else we need to manually scan and update DefaultFrames
    elseif g_DefaultFrames.SmallGroup then
        for i = 1, 24 do
            local unitTag = "group" .. i
            if DoesUnitExist(unitTag) then
                UF.ReloadValues(unitTag)
            end
        end
    end

    UF.OnReticleTargetChanged(nil)
    UF.OnBossesChanged()
    UF.OnPlayerCombatState(EVENT_PLAYER_COMBAT_STATE, IsUnitInCombat("player") )
    UF.CustomFramesGroupAlpha()
    UF.CustomFramesSetupAlternative()

    -- Apply bar colors here, has to be after player init to get group roles
    UF.CustomFramesApplyColours(false)
end

-- Runs on the EVENT_POWER_UPDATE listener.
-- This handler fires every time unit attribute changes.
function UF.OnPowerUpdate(eventCode, unitTag, powerIndex, powerType, powerValue, powerMax, powerEffectiveMax)
    -- Save Health value for future reference -- do it only for tracked unitTags that were defined on initialization
    if powerType == POWERTYPE_HEALTH and g_savedHealth[unitTag] then
        g_savedHealth[unitTag] = { powerValue, powerMax, powerEffectiveMax, g_savedHealth[unitTag][4] or 0 }
    end

    --[[ DEBUG code. Normally should be commented out because it is redundant
    if g_DefaultFrames[unitTag] and g_DefaultFrames[unitTag].unitTag ~= unitTag then
        d("LUIE_DBG DF: " .. tostring(g_DefaultFrames[unitTag].unitTag) .. " ~= " .. tostring(unitTag) )
    end
    if UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag].unitTag ~= unitTag then
        d("LUIE_DBG CF: " .. tostring(UF.CustomFrames[unitTag].unitTag) .. " ~= " .. tostring(unitTag) )
    end
    if g_AvaCustFrames[unitTag] and g_AvaCustFrames[unitTag].unitTag ~= unitTag then
        d("LUIE_DBG AF: " .. tostring(g_AvaCustFrames[unitTag].unitTag) .. " ~= " .. tostring(unitTag) )
    end --]]

    -- Update frames ( if we manually not forbade it )
    if g_DefaultFrames[unitTag] then
        UF.UpdateAttribute( g_DefaultFrames[unitTag][powerType], powerValue, powerEffectiveMax, (powerType == POWERTYPE_HEALTH) and g_savedHealth[unitTag][4] or nil, eventCode == nil )
    end
    if UF.CustomFrames[unitTag] then
        UF.UpdateAttribute( UF.CustomFrames[unitTag][powerType], powerValue, powerEffectiveMax, (powerType == POWERTYPE_HEALTH) and g_savedHealth[unitTag][4] or nil, eventCode == nil )
    end
    if g_AvaCustFrames[unitTag] then
        UF.UpdateAttribute( g_AvaCustFrames[unitTag][powerType], powerValue, powerEffectiveMax, (powerType == POWERTYPE_HEALTH) and g_savedHealth[unitTag][4] or nil, eventCode == nil )
    end

    -- Record state of power loss to change transparency of player frame
    if unitTag == "player" and ( powerType == POWERTYPE_HEALTH or powerType == POWERTYPE_MAGICKA or powerType == POWERTYPE_STAMINA or powerType == POWERTYPE_MOUNT_STAMINA ) then
        g_statFull[powerType] = ( powerValue == powerEffectiveMax )
        UF.CustomFramesApplyInCombat()
    end

    -- If players powerValue is zero, issue new blinking event on Custom Frames
    if unitTag == "player" and powerValue == 0 and powerType ~= POWERTYPE_WEREWOLF then
        UF.OnCombatEvent( eventCode, nil, true, nil, nil, nil, nil, COMBAT_UNIT_TYPE_PLAYER, nil, COMBAT_UNIT_TYPE_PLAYER, 0, powerType, nil, false )
    end

    -- Display skull icon for alive execute-level targets
    if unitTag == "reticleover" and
        powerType == POWERTYPE_HEALTH and
        UF.CustomFrames.reticleover and
        UF.CustomFrames.reticleover.hostile then

        -- Hide skull when target dies
        if powerValue == 0 then
            UF.CustomFrames.reticleover.skull:SetHidden( true )
        -- But show for _below_threshold_ level targets
        elseif 100*powerValue/powerEffectiveMax < UF.CustomFrames.reticleover[POWERTYPE_HEALTH].threshold then
            UF.CustomFrames.reticleover.skull:SetHidden( false )
        end
    end
end

-- Runs on the EVENT_UNIT_CREATED listener.
-- Used to create DefaultFrames UI controls and request delayed CustomFrames group frame update
function UF.OnUnitCreated(eventCode, unitTag)
    --d( strfmt("[%s] OnUnitCreated: %s (%s)", GetTimeString(), unitTag, GetUnitName(unitTag)) )
    -- Create on-fly UI controls for default UI group member and reread his values
    if g_DefaultFrames.SmallGroup then
        UF.DefaultFramesCreateUnitGroupControls(unitTag)
    end
    -- If CustomFrames are used then values for unitTag will be reloaded in delayed full group update
    if UF.CustomFrames.SmallGroup1 ~= nil or UF.CustomFrames.RaidGroup1 ~= nil then
        -- Make sure we do not try to update bars on this unitTag before full group update is complete
        if "group" == strsub(unitTag, 0, 5) then
            UF.CustomFrames[unitTag] = nil
        end
        -- We should avoid calling full update on CustomFrames too often
        if not g_PendingUpdate.Group.flag then
            g_PendingUpdate.Group.flag = true
            eventManager:RegisterForUpdate(g_PendingUpdate.Group.name, g_PendingUpdate.Group.delay, UF.CustomFramesGroupUpdate )
        end
    -- Else we need to manually update this unitTag in g_DefaultFrames
    elseif g_DefaultFrames.SmallGroup then
        UF.ReloadValues(unitTag)
    end
end

-- Runs on the EVENT_UNIT_DESTROYED listener.
-- Used to request delayed CustomFrames group frame update
function UF.OnUnitDestroyed(eventCode, unitTag)
    --d( strfmt("[%s] OnUnitDestroyed: %s (%s)", GetTimeString(), unitTag, GetUnitName(unitTag)) )
    -- Make sure we do not try to update bars on this unitTag before full group update is complete
    if "group" == strsub(unitTag, 0, 5) then
        UF.CustomFrames[unitTag] = nil
    end
    -- We should avoid calling full update on CustomFrames too often
    if not g_PendingUpdate.Group.flag then
        g_PendingUpdate.Group.flag = true
        eventManager:RegisterForUpdate(g_PendingUpdate.Group.name, g_PendingUpdate.Group.delay, UF.CustomFramesGroupUpdate )
    end
end

-- Creates default group unit UI controls on-fly
function UF.DefaultFramesCreateUnitGroupControls(unitTag)
    -- First make preparation for "groupN" unitTag labels
    if g_DefaultFrames[unitTag] == nil then -- If unitTag is already in our list, then skip this
        if "group" == strsub(unitTag, 0, 5) then -- If it is really a group member unitTag
            local i = strsub(unitTag, 6)
            if _G["ZO_GroupUnitFramegroup" .. i] then
                local parentBar     = _G["ZO_GroupUnitFramegroup" .. i .. "Hp"]
                local parentName    = _G["ZO_GroupUnitFramegroup" .. i .. "Name"]
                -- Prepare dimension of regen bar
                local width, height = parentBar:GetDimensions()
                -- Populate UI elements
                g_DefaultFrames[unitTag] = {
                    ["unitTag"] = unitTag,
                    [POWERTYPE_HEALTH] = {
                        label = UI.Label( parentBar, {TOP,BOTTOM}, nil, nil, nil, nil, false ),
                        colour = UF.SV.DefaultTextColour,
                        shield = UI.StatusBar( parentBar, {BOTTOM,BOTTOM,0,0}, {width-height,height}, {1,0.75,0,0.5}, true ),
                    },
                    ["classIcon"]   = UI.Texture( parentName, {RIGHT,LEFT,-4,2},  {24,24}, nil, nil, true ),
                    ["friendIcon"]  = UI.Texture( parentName, {RIGHT,LEFT,-4,24}, {24,24}, nil, nil, true ),
                }
                -- Apply selected font
                UF.DefaultFramesApplyFont(unitTag)
            end
        end
    end
end

-- Runs on the EVENT_UNIT_ATTRIBUTE_VISUAL_ADDED listener.
function UF.OnVisualizationAdded(eventCode, unitTag, unitAttributeVisual, statType, attributeType, powerType, value, maxValue)
    if unitAttributeVisual == ATTRIBUTE_VISUAL_POWER_SHIELDING then
        UF.UpdateShield(unitTag, value, maxValue)
    elseif unitAttributeVisual == ATTRIBUTE_VISUAL_INCREASED_REGEN_POWER or unitAttributeVisual == ATTRIBUTE_VISUAL_DECREASED_REGEN_POWER then
        UF.UpdateRegen(unitTag, statType, attributeType, powerType )
    elseif unitAttributeVisual == ATTRIBUTE_VISUAL_INCREASED_STAT or unitAttributeVisual == ATTRIBUTE_VISUAL_DECREASED_STAT then
        UF.UpdateStat(unitTag, statType, attributeType, powerType )
    end
end

-- Runs on the EVENT_UNIT_ATTRIBUTE_VISUAL_REMOVED listener.
function UF.OnVisualizationRemoved(eventCode, unitTag, unitAttributeVisual, statType, attributeType, powerType, value, maxValue)
    if unitAttributeVisual == ATTRIBUTE_VISUAL_POWER_SHIELDING then
        UF.UpdateShield(unitTag, 0, maxValue)
    elseif unitAttributeVisual == ATTRIBUTE_VISUAL_INCREASED_REGEN_POWER or unitAttributeVisual == ATTRIBUTE_VISUAL_DECREASED_REGEN_POWER then
        UF.UpdateRegen(unitTag, statType, attributeType, powerType )
    elseif unitAttributeVisual == ATTRIBUTE_VISUAL_INCREASED_STAT or unitAttributeVisual == ATTRIBUTE_VISUAL_DECREASED_STAT then
        UF.UpdateStat(unitTag, statType, attributeType, powerType )
    end
end

-- Runs on the EVENT_UNIT_ATTRIBUTE_VISUAL_UPDATED listener.
function UF.OnVisualizationUpdated(eventCode, unitTag, unitAttributeVisual, statType, attributeType, powerType, oldValue, newValue, oldMaxValue, newMaxValue)
    if unitAttributeVisual == ATTRIBUTE_VISUAL_POWER_SHIELDING then
        UF.UpdateShield(unitTag, newValue, newMaxValue)
    elseif unitAttributeVisual == ATTRIBUTE_VISUAL_INCREASED_REGEN_POWER or unitAttributeVisual == ATTRIBUTE_VISUAL_DECREASED_REGEN_POWER then
        UF.UpdateRegen(unitTag, statType, attributeType, powerType )
    elseif unitAttributeVisual == ATTRIBUTE_VISUAL_INCREASED_STAT or unitAttributeVisual == ATTRIBUTE_VISUAL_DECREASED_STAT then
        UF.UpdateStat(unitTag, statType, attributeType, powerType )
    end
end

-- Runs on the EVENT_TARGET_CHANGE listener.
-- This handler fires every time the someone target changes.
-- This function is needed in case the player teleports via Way Shrine
function UF.OnTargetChange(eventCode, unitTag)
    if unitTag ~= "player" then
        return
    end
    UF.OnReticleTargetChanged(eventCode)
end

function UF.UpdateDefaultLevelTarget()
    local targetLevel = ZO_TargetUnitFramereticleoverLevel
    local targetChamp = ZO_TargetUnitFramereticleoverChampionIcon
    local targetName = ZO_TargetUnitFramereticleoverName
    local unitLevel
    local isChampion = IsUnitChampion("reticleover")
    if isChampion then
        if UF.SV.ChampionOptions == "Limit to Cap" then
            unitLevel = GetUnitEffectiveChampionPoints("reticleover")
        else
            unitLevel = GetUnitChampionPoints("reticleover")
        end
    else
        unitLevel = GetUnitLevel("reticleover")
    end

    if unitLevel > 0 then
        targetLevel:SetHidden(false)
        targetLevel:SetText(tostring(unitLevel))
        targetName:SetAnchor(TOPLEFT, targetLevel, TOPRIGHT, 10, 0)
    else
        targetLevel:SetHidden(true)
        targetName:SetAnchor(TOPLEFT)
    end

    if isChampion then
        targetChamp:SetHidden(false)
    else
        targetChamp:SetHidden(true)
    end
end

-- Runs on the EVENT_RETICLE_TARGET_CHANGED listener.
-- This handler fires every time the player's reticle target changes.
-- Used to read initial values of target's health and shield.
function UF.OnReticleTargetChanged(eventCode)
    if DoesUnitExist("reticleover") then
        UF.ReloadValues( "reticleover" )

        local isWithinRange = IsUnitInGroupSupportRange("reticleover")

        -- Now select appropriate custom colour to target name and (possibly) reticle
        local colour, reticle_colour
        local interactableCheck = false
        local reactionType = GetUnitReaction("reticleover")
        local attackable = IsUnitAttackable("reticleover")
        -- Select colour accordingly to reactionType, attackable and interactable
        if reactionType == UNIT_REACTION_HOSTILE then
            colour = UF.SV.Target_FontColour_Hostile
            reticle_colour = attackable and UF.SV.Target_FontColour_Hostile or UF.SV.Target_FontColour
            interactableCheck = true
        elseif reactionType == UNIT_REACTION_PLAYER_ALLY then
            colour          = UF.SV.Target_FontColour_FriendlyPlayer
            reticle_colour  = UF.SV.Target_FontColour_FriendlyPlayer
        elseif attackable and reactionType ~= UNIT_REACTION_HOSTILE then -- those are neutral targets that can become hostile on attack
            colour          = UF.SV.Target_FontColour
            reticle_colour  = colour
        else
            -- Rest cases are ally/friendly/npc, and with possibly interactable
            colour = ( reactionType == UNIT_REACTION_FRIENDLY or reactionType == UNIT_REACTION_NPC_ALLY ) and UF.SV.Target_FontColour_FriendlyNPC or UF.SV.Target_FontColour
            reticle_colour = colour
            interactableCheck = true
        end

        -- Here we need to check if interaction is possible, and then rewrite reticle_colour variable
        if interactableCheck then
            local interactableAction = GetGameCameraInteractableActionInfo()
            -- Action, interactableName, interactionBlocked, isOwned, additionalInfo, context
            if interactableAction ~= nil then
                reticle_colour = UF.SV.ReticleColour_Interact
            end
        end

        -- Is current target Critter? In Update 6 they all have 9 health
        local isCritter = ( g_savedHealth.reticleover[3] <= 9 )
        local isGuard = IsUnitInvulnerableGuard("reticleover")

        -- Hide custom label on Default Frames for critters.
        if g_DefaultFrames.reticleover[POWERTYPE_HEALTH] then
            g_DefaultFrames.reticleover[POWERTYPE_HEALTH].label:SetHidden( isCritter )
            g_DefaultFrames.reticleover[POWERTYPE_HEALTH].label:SetHidden( isGuard )
        end

        -- Update level display based off our setting for Champion Points
        if g_DefaultFrames.reticleover.isPlayer then
            UF.UpdateDefaultLevelTarget()
        end

        -- Update colour of default target if requested
        if UF.SV.TargetColourByReaction then
            g_defaultTargetNameLabel:SetColor( colour[1], colour[2], colour[3], isWithinRange and 1 or 0.5 )
        end
        if UF.SV.ReticleColourByReaction then
            ZO_ReticleContainerReticle:SetColor(reticle_colour[1], reticle_colour[2], reticle_colour[3] )
        end

        -- And colour of custom target name always. Also change 'labelOne' for critters
        if UF.CustomFrames.reticleover then
            UF.CustomFrames.reticleover.hostile = ( reactionType == UNIT_REACTION_HOSTILE ) and UF.SV.TargetEnableSkull
            UF.CustomFrames.reticleover.skull:SetHidden( not UF.CustomFrames.reticleover.hostile or ( g_savedHealth.reticleover[1] == 0 ) or ( 100*g_savedHealth.reticleover[1]/g_savedHealth.reticleover[3] > UF.CustomFrames.reticleover[POWERTYPE_HEALTH].threshold ) )
            UF.CustomFrames.reticleover.name:SetColor( colour[1], colour[2], colour[3] )
            UF.CustomFrames.reticleover.className:SetColor( colour[1], colour[2], colour[3] )
            if isCritter then
                UF.CustomFrames.reticleover[POWERTYPE_HEALTH].labelOne:SetText( " - Critter - " )
            end
            if isGuard then
                UF.CustomFrames.reticleover[POWERTYPE_HEALTH].labelOne:SetText( " - Invulnerable - " )
            end
            UF.CustomFrames.reticleover[POWERTYPE_HEALTH].labelTwo:SetHidden( isCritter or isGuard or not UF.CustomFrames.reticleover.dead:IsHidden() )
            -- Finally show custom target frame
            UF.CustomFrames.reticleover.control:SetHidden( false )
        end
        -- Unhide second target frame only for player enemies
        if UF.CustomFrames.AvaPlayerTarget then
            UF.CustomFrames.AvaPlayerTarget.control:SetHidden( not ( UF.CustomFrames.AvaPlayerTarget.isPlayer and (reactionType == UNIT_REACTION_HOSTILE) and not IsUnitDead("reticleover") ) )
        end

        -- Update position of default target class icon
        if UF.SV.TargetShowClass and g_DefaultFrames.reticleover.isPlayer then
            g_DefaultFrames.reticleover.classIcon:ClearAnchors()
            g_DefaultFrames.reticleover.classIcon:SetAnchor(TOPRIGHT, ZO_TargetUnitFramereticleoverTextArea, TOPLEFT, g_DefaultFrames.reticleover.isChampion and (-32) or (-2), -4)
        else
            g_DefaultFrames.reticleover.classIcon:SetHidden(true)
        end
        -- Instead just make sure it is hidden
        if not UF.SV.TargetShowFriend or not g_DefaultFrames.reticleover.isPlayer then
            g_DefaultFrames.reticleover.friendIcon:SetHidden(true)
        end

        if UF.SV.FrameColorReaction then
            UF.CustomFramesApplyReactionColor()
        end

    -- Target is invalid: reset stored values to defaults
    else
        g_savedHealth.reticleover = {1,1,1,0}

        --[[ Removed due to causing custom UI elements to abruptly fade out. Left here in case there is any reason to re-enable.
        if g_DefaultFrames.reticleover[POWERTYPE_HEALTH] then
            g_DefaultFrames.reticleover[POWERTYPE_HEALTH].label:SetHidden(true)
        end
        g_DefaultFrames.reticleover.classIcon:SetHidden(true)
        g_DefaultFrames.reticleover.friendIcon:SetHidden(true)
        ]]--

        -- Hide target frame bars control, LTE will clear buffs and remove then itself, SCB should continue to display ground buffs
        if UF.CustomFrames.reticleover then
            UF.CustomFrames.reticleover.hostile = false
            UF.CustomFrames.reticleover.skull:SetHidden( true )
            UF.CustomFrames.reticleover.control:SetHidden( true ) --UF.CustomFrames.reticleover.canHide )
        end
        -- Hide second target frame
        if UF.CustomFrames.AvaPlayerTarget then
            UF.CustomFrames.AvaPlayerTarget.control:SetHidden( true ) --UF.CustomFrames.AvaPlayerTarget.canHide )
        end

        -- Revert back the colour of reticle to white
        if UF.SV.ReticleColourByReaction then
            ZO_ReticleContainerReticle:SetColor(1, 1, 1)
        end
    end

    -- Finally if user does not want to have default target frame we have to hide it here all the time
    if not g_DefaultFrames.reticleover[POWERTYPE_HEALTH] and UF.SV.DefaultFramesTarget == false then
        ZO_TargetUnitFramereticleover:SetHidden( true )
    end
end

-- Runs on the EVENT_DISPOSITION_UPDATE listener.
-- Used to reread parameters of the target
function UF.OnDispositionUpdate(eventCode, unitTag)
    if unitTag == "reticleover" then
        UF.OnReticleTargetChanged(eventCode)
    end
end

-- Used to query initial values and display them in corresponding control
function UF.ReloadValues( unitTag )
    -- Build list of powerTypes this unitTag has in both DefaultFrames and CustomFrames
    local powerTypes = {}
    if g_DefaultFrames[unitTag] then
        for powerType,_ in pairs( g_DefaultFrames[unitTag] ) do
            if type(powerType) == "number" then
                powerTypes[powerType] = true
            end
        end
    end
    if UF.CustomFrames[unitTag] then
        for powerType,_ in pairs( UF.CustomFrames[unitTag] ) do
            if type(powerType) == "number" then
                powerTypes[powerType] = true
            end
        end
    end
    if g_AvaCustFrames[unitTag] then
        for powerType,_ in pairs( g_AvaCustFrames[unitTag] ) do
            if type(powerType) == "number" then
                powerTypes[powerType] = true
            end
        end
    end

    -- For all attributes query its value and force updating
    for powerType,_ in pairs(powerTypes) do
        UF.OnPowerUpdate(nil, unitTag, nil, powerType, GetUnitPower(unitTag, powerType))
    end

    -- Update shield value on controls; this will also update health attribute value, again.
    local shield, _ = GetUnitAttributeVisualizerEffectInfo(unitTag, ATTRIBUTE_VISUAL_POWER_SHIELDING, STAT_MITIGATION, ATTRIBUTE_HEALTH, POWERTYPE_HEALTH)
    UF.UpdateShield( unitTag, shield or 0, nil )

    -- Now we need to update Name labels, classIcon
    UF.UpdateStaticControls( g_DefaultFrames[unitTag] )
    UF.UpdateStaticControls( UF.CustomFrames[unitTag] )
    UF.UpdateStaticControls( g_AvaCustFrames[unitTag] )

    -- Get regen/degen values
    UF.UpdateRegen(unitTag, STAT_HEALTH_REGEN_COMBAT, ATTRIBUTE_HEALTH, POWERTYPE_HEALTH)

    -- Get initial stats
    UF.UpdateStat(unitTag, STAT_ARMOR_RATING, ATTRIBUTE_HEALTH, POWERTYPE_HEALTH)
    UF.UpdateStat(unitTag, STAT_POWER, ATTRIBUTE_HEALTH, POWERTYPE_HEALTH)

    if unitTag == "player" then
        g_statFull[POWERTYPE_HEALTH] = ( g_savedHealth.player[1] == g_savedHealth.player[3] )
        UF.CustomFramesApplyInCombat()
    end
end

-- Helper tables for next function
-- I believe this is mostly deprecated, as we no longer want to show the level of anything but a player target
local HIDE_LEVEL_REACTIONS = {
    [UNIT_REACTION_FRIENDLY] = true,
    [UNIT_REACTION_NPC_ALLY] = true,
}
-- I believe this is mostly deprecated, as we no longer want to show the level of anything but a player target
local HIDE_LEVEL_TYPES = {
    [UNIT_TYPE_SIEGEWEAPON] = true,
    [UNIT_TYPE_INTERACTFIXTURE] = true,
    [UNIT_TYPE_INTERACTOBJ] = true,
    [UNIT_TYPE_SIMPLEINTERACTFIXTURE] = true,
    [UNIT_TYPE_SIMPLEINTERACTOBJ] = true,
}

local function IsGuildMate(unitTag)
    local displayName = GetUnitDisplayName(unitTag)
    if displayName == playerDisplayName then
        return
    end
    for i = 1, GetNumGuilds() do
        local guildId = GetGuildId(i)
        if GetGuildMemberIndexFromDisplayName(guildId, displayName) ~= nil then
            return true
        end
    end
    return false
end

-- Updates text labels, classIcon, etc
function UF.UpdateStaticControls( unitFrame )
    if unitFrame == nil then
        return
    end

    -- Get the unitTag to determine the method of name display
    local DisplayOption
    if unitFrame.unitTag == "player" then
        DisplayOption = UF.SV.DisplayOptionsPlayer
    elseif unitFrame.unitTag == "reticleover" then
        DisplayOption = UF.SV.DisplayOptionsTarget
    else
        DisplayOption = UF.SV.DisplayOptionsGroupRaid
    end

    unitFrame.isPlayer  = IsUnitPlayer( unitFrame.unitTag )
    unitFrame.isChampion = IsUnitChampion( unitFrame.unitTag )
    unitFrame.isLevelCap = ( GetUnitChampionPoints( unitFrame.unitTag ) == g_MaxChampionPoint  )
    unitFrame.avaRankValue = GetUnitAvARank( unitFrame.unitTag )

    -- First update roleIcon, classIcon and friendIcon, so then we can set maximal length of name label
    if unitFrame.roleIcon ~= nil then
        local role = GetGroupMemberSelectedRole(unitFrame.unitTag)
       -- d (unitFrame.unitTag.." - "..role)
        local unitRole = roleIcons[role]
        unitFrame.roleIcon:SetTexture(unitRole)
    end
    -- If unitFrame has unit classIcon control
    if unitFrame.classIcon ~= nil then
        local unitDifficulty = GetUnitDifficulty( unitFrame.unitTag )
        local classIcon = classIcons[GetUnitClassId(unitFrame.unitTag)]
        local showClass = ( unitFrame.isPlayer and classIcon ~= nil ) or ( unitDifficulty > 1 )
        if unitFrame.isPlayer then
            unitFrame.classIcon:SetTexture(classIcon)
        elseif unitDifficulty == 2 then
            unitFrame.classIcon:SetTexture("LuiExtended/media/unitframes/unitframes_level_elite.dds")
        elseif unitDifficulty >= 3 then
            unitFrame.classIcon:SetTexture("LuiExtended/media/unitframes/unitframes_level_elite.dds")
        end
        if unitFrame.unitTag == "player" then
            unitFrame.classIcon:SetHidden( not UF.SV.PlayerEnableYourname )
        else
            unitFrame.classIcon:SetHidden( not showClass )
        end
    end
    -- unitFrame frame also have a text label for class name: right now only target
    if unitFrame.className then
        local className = GetUnitClass( unitFrame.unitTag )
        local showClass = unitFrame.isPlayer and className ~= nil and UF.SV.TargetEnableClass
        if showClass then
            unitFrame.className:SetText( className:gsub("%^%a+","") )
        end
        -- this condition is somehow extra, but let keep it to be in consistency with all others
        if unitFrame.unitTag == "player" then
            unitFrame.className:SetHidden( not UF.SV.PlayerEnableYourname )
        else
            unitFrame.className:SetHidden( not showClass )
        end
    end
    -- If unitFrame has unit classIcon control
    if unitFrame.friendIcon ~= nil then
        local isIgnored = unitFrame.isPlayer and IsUnitIgnored( unitFrame.unitTag )
        local isFriend = unitFrame.isPlayer and IsUnitFriend( unitFrame.unitTag )
        local isGuild = unitFrame.isPlayer and (not isFriend) and (not isIgnored) and IsGuildMate( unitFrame.unitTag )
        if isIgnored or isFriend or isGuild then
            unitFrame.friendIcon:SetTexture( isIgnored and "LuiExtended/media/unitframes/unitframes_social_ignore.dds" or isFriend and "/esoui/art/campaign/campaignbrowser_friends.dds" or "/esoui/art/campaign/campaignbrowser_guild.dds" )
            unitFrame.friendIcon:SetHidden(false)
        else
            unitFrame.friendIcon:SetHidden(true)
        end
    end
    -- If unitFrame has unit name label control
    if unitFrame.name ~= nil then
        -- Update max width of label
        local playerName = LUIE.PlayerNameFormatted
        -- Only apply this formatting to non-group frames
        if unitFrame.name:GetParent() == unitFrame.topInfo and unitFrame.unitTag == "reticleover" then
            local width = unitFrame.topInfo:GetWidth()
            if unitFrame.classIcon then
                width = width - unitFrame.classIcon:GetWidth()
            end
        if unitFrame.isPlayer then
            if unitFrame.friendIcon then
                width = width - unitFrame.friendIcon:GetWidth()
            end
            if unitFrame.level then
                width = width - 2.3 * unitFrame.levelIcon:GetWidth()
            end
        end
            unitFrame.name:SetWidth(width)
        end
        if unitFrame.isPlayer and DisplayOption == 3 then
            unitFrame.name:SetText( GetUnitName( unitFrame.unitTag ) .." ".. GetUnitDisplayName (unitFrame.unitTag) )
        elseif unitFrame.isPlayer and DisplayOption == 1 then
            unitFrame.name:SetText( GetUnitDisplayName (unitFrame.unitTag) )
        else
            unitFrame.name:SetText( GetUnitName( unitFrame.unitTag ) )
        end
    end
    -- If unitFrame has level label control
    if unitFrame.level ~= nil then
        -- Show level for players and non-friendly NPCs
        local showLevel = unitFrame.isPlayer -- or not ( IsUnitInvulnerableGuard( unitFrame.unitTag ) or HIDE_LEVEL_TYPES[GetUnitType( unitFrame.unitTag )] or HIDE_LEVEL_REACTIONS[GetUnitReaction( unitFrame.unitTag )] ) -- No longer need to display level for anything but players
        if showLevel then
            if unitFrame.unitTag == "player" or unitFrame.unitTag == "reticleover" then
                unitFrame.levelIcon:ClearAnchors()
                unitFrame.levelIcon:SetAnchor( LEFT, unitFrame.topInfo, LEFT, unitFrame.name:GetTextWidth()+1, 0 )
            end
            unitFrame.levelIcon:SetTexture( unitFrame.isChampion and "LuiExtended/media/unitframes/unitframes_level_champion.dds" or "LuiExtended/media/unitframes/unitframes_level_normal.dds" )
            -- Level label should be already anchored
            if UF.SV.ChampionOptions == "Limit to Cap" then
                unitFrame.level:SetText( tostring( unitFrame.isChampion and GetUnitEffectiveChampionPoints( unitFrame.unitTag ) or GetUnitLevel( unitFrame.unitTag ) ) )
            elseif UF.SV.ChampionOptions == "Show Above Cap" then
                unitFrame.level:SetText( tostring( unitFrame.isChampion and GetUnitChampionPoints( unitFrame.unitTag ) or GetUnitLevel( unitFrame.unitTag ) ) )
            end
        end
        if unitFrame.unitTag == "player" then
            unitFrame.levelIcon:SetHidden( not UF.SV.PlayerEnableYourname )
            unitFrame.level:SetHidden( not UF.SV.PlayerEnableYourname )
        else
            unitFrame.levelIcon:SetHidden( not showLevel )
            unitFrame.level:SetHidden( not showLevel )
        end
    end
    local savedTitle
    -- If unitFrame has unit title label control
    if unitFrame.title ~= nil then
        local title = GetUnitCaption(unitFrame.unitTag)
        local option
        local ava
        if unitFrame.isPlayer then
            title = GetUnitTitle(unitFrame.unitTag)
            ava = GetAvARankName( GetUnitGender(unitFrame.unitTag) , unitFrame.avaRankValue )
            if UF.SV.TargetEnableRank and not UF.SV.TargetEnableTitle then
                title = (ava ~= "") and ava
            elseif UF.SV.TargetEnableTitle and not UF.SV.TargetEnableRank then
                title = (title ~= "") and title
            elseif UF.SV.TargetEnableTitle and UF.SV.TargetEnableRank then
                if UF.SV.TargetTitlePriority == "Title" then
                    title = (title ~= "") and title or (ava ~= "") and ava
                else
                    title = (ava ~= "") and ava or (title ~= "") and title
                end
            end
        end
        title = title or ""
        unitFrame.title:SetText( title:gsub("%^%a+","") )
        if unitFrame.unitTag == "reticleover" then
            unitFrame.title:SetHidden ( not UF.SV.TargetEnableRank and not UF.SV.TargetEnableTitle )
        end

        if title == "" then savedTitle = "" end
    end
    -- If unitFrame has unit AVA rank control
    if unitFrame.avaRank ~= nil then
        if unitFrame.isPlayer then
            unitFrame.avaRankIcon:SetTexture( GetAvARankIcon( unitFrame.avaRankValue ) )
            local alliance = GetUnitAlliance( unitFrame.unitTag )
            local colour = GetAllianceColor( alliance )
            unitFrame.avaRankIcon:SetColor( colour.r, colour.g, colour.b )

            if unitFrame.unitTag == "reticleover" and UF.SV.TargetEnableRankIcon then
                unitFrame.avaRank:SetText( tostring( unitFrame.avaRankValue ) )
                if unitFrame.avaRankValue > 0 then
                    unitFrame.avaRank:SetHidden(false)
                else
                    unitFrame.avaRank:SetHidden(true)
                end
                unitFrame.avaRankIcon:SetHidden(false)
            else
                unitFrame.avaRank:SetHidden(true)
                unitFrame.avaRankIcon:SetHidden(true)
            end
        else
            unitFrame.avaRank:SetHidden(true)
            unitFrame.avaRankIcon:SetHidden(true)
        end
    end
    -- Reanchor buffs if title changes
    if unitFrame.buffs then
        if UF.SV.PlayerFrameOptions ~= 1 and unitFrame.unitTag == "reticleover" then
            if (not UF.SV.TargetEnableRank and not UF.SV.TargetEnableTitle and not UF.SV.TargetEnableRankIcon) or (savedTitle == "" and not UF.SV.TargetEnableRankIcon and unitFrame.isPlayer) or (savedTitle == "" and not unitFrame.isPlayer) then
                unitFrame.debuffs:ClearAnchors()
                unitFrame.debuffs:SetAnchor( TOP, unitFrame.control, BOTTOM, 0, 5 )
            else
                unitFrame.debuffs:ClearAnchors()
                unitFrame.debuffs:SetAnchor( TOP, unitFrame.buffAnchor, BOTTOM, 0, 5 )
            end
        else
            if (not UF.SV.TargetEnableRank and not UF.SV.TargetEnableTitle and not UF.SV.TargetEnableRankIcon) or (savedTitle == "" and not UF.SV.TargetEnableRankIcon and unitFrame.isPlayer) or (savedTitle == "" and not unitFrame.isPlayer) then
                unitFrame.buffs:ClearAnchors()
                unitFrame.buffs:SetAnchor( TOP, unitFrame.control, BOTTOM, 0, 5 )
            else
                unitFrame.buffs:ClearAnchors()
                unitFrame.buffs:SetAnchor( TOP, unitFrame.buffAnchor, BOTTOM, 0, 5 )
            end
        end
    end
    -- If unitFrame has dead/offline indicator, then query its state and act accordingly
    if unitFrame.dead ~= nil then
        if not IsUnitOnline( unitFrame.unitTag ) then
            UF.OnGroupMemberConnectedStatus( nil, unitFrame.unitTag, false )
        elseif IsUnitDead( unitFrame.unitTag ) then
            UF.OnDeath( nil, unitFrame.unitTag, true )
        else
            UF.CustomFramesSetDeadLabel( unitFrame, nil )
        end

    end
    -- Finally set transparency for group frames that has .control field
    if "group" == strsub(unitFrame.unitTag, 0, 5) and unitFrame.control then
        unitFrame.control:SetAlpha( IsUnitInGroupSupportRange(unitFrame.unitTag) and ( UF.SV.GroupAlpha * 0.01) or ( UF.SV.GroupAlpha * 0.01) / 2 )
    end
end

function UF.MenuUpdatePlayerFrameOptions(option)
    if UF.CustomFrames.reticleover then
        local reticleover = UF.CustomFrames.reticleover
        if option == 1 then
            reticleover.buffs:ClearAnchors()
            reticleover.debuffs:ClearAnchors()
            reticleover.buffs:SetAnchor(TOP, reticleover.buffAnchor, BOTTOM, 0, 2)
            reticleover.debuffs:SetAnchor(BOTTOM, reticleover.topInfo, TOP, 0, -2)
        else
            reticleover.buffs:ClearAnchors()
            reticleover.debuffs:ClearAnchors()
            reticleover.buffs:SetAnchor(BOTTOM, reticleover.topInfo, TOP, 0, -2)
            reticleover.debuffs:SetAnchor(TOP, reticleover.buffAnchor, BOTTOM, 0, 2)
        end
    end
    LUIE.UnitFrames.CustomFramesResetPosition(true)
    LUIE.UnitFrames.CustomFramesSetupAlternative()
    LUIE.UnitFrames.CustomFramesApplyLayoutPlayer()
end

-- Updates single attribute.
-- Usually called from OnPowerUpdate handler.
function UF.UpdateAttribute( attributeFrame, powerValue, powerEffectiveMax, shield, forceInit )
    if attributeFrame == nil then
        return
    end

    local pct = mathfloor(100*powerValue/powerEffectiveMax)

    -- Update text values for this attribute. can be on up to 3 different labels
    local shield = ( shield and shield > 0 ) and shield or nil

    if (UF.CustomFrames and UF.CustomFrames["reticleover"] and attributeFrame == UF.CustomFrames["reticleover"][POWERTYPE_HEALTH] and IsUnitInvulnerableGuard("reticleover") ) then
        for _, label in pairs( { "label", "labelOne", "labelTwo" } ) do
            if attributeFrame[label] ~= nil then
                attributeFrame[label]:SetColor( unpack( attributeFrame.colour or {1,1,1} ) )
            end
        end
        if attributeFrame.bar ~= nil then
            if UF.SV.CustomSmoothBar then
                -- Make it twice faster then default UI ones: last argument .085
                ZO_StatusBar_SmoothTransition(attributeFrame.bar, powerValue, powerEffectiveMax, forceInit, nil, 250)
            else
                attributeFrame.bar:SetMinMax(0, powerEffectiveMax)
                attributeFrame.bar:SetValue( powerValue )
            end
        end
    else
        for _, label in pairs( { "label", "labelOne", "labelTwo" } ) do
            if attributeFrame[label] ~= nil then
                -- Format specific to selected label
                local fmt = tostring( attributeFrame[label].fmt or UF.SV.Format )
                local str = fmt:gsub("Percentage", tostring(pct) )
                    :gsub("Max", AbbreviateNumber(powerEffectiveMax, UF.SV.ShortenNumbers, true))
                    :gsub("Current", AbbreviateNumber(powerValue, UF.SV.ShortenNumbers, true))
                    :gsub( "+ Shield", shield and ("+ "..AbbreviateNumber(shield, UF.SV.ShortenNumbers, true)) or "" )
                    :gsub("Nothing", "")
                -- Change text
                attributeFrame[label]:SetText( str )
                -- And colour it RED if attribute value is lower then threshold
                attributeFrame[label]:SetColor( unpack( ( pct < ( attributeFrame.threshold or g_defaultThreshold ) ) and {1,0.25,0.38} or attributeFrame.colour or {1,1,1} ) )
            end
        end

        -- If attribute has also custom statusBar, update its value
        if attributeFrame.bar ~= nil then
            if UF.SV.CustomSmoothBar then
                -- Make it twice faster then default UI ones: last argument .085
                ZO_StatusBar_SmoothTransition(attributeFrame.bar, powerValue, powerEffectiveMax, forceInit, nil, 250)
            else
                attributeFrame.bar:SetMinMax(0, powerEffectiveMax)
                attributeFrame.bar:SetValue( powerValue )
            end
        end
    end
end

-- Updates title for unit if changed, and also reanchors buffs or toggles display on/off if the unittag had no title selected previously
-- Called from EVENT_TITLE_UPDATE
-- Called from EVENT_RANK_POINT_UPDATE
function UF.TitleUpdate( eventCode, unitTag )
    -- TODO: Doesn't seem to be an event handler for AVA Rank change, would be nice to have one for this purpose.
    UF.UpdateStaticControls( g_DefaultFrames[unitTag] )
    UF.UpdateStaticControls( UF.CustomFrames[unitTag] )
    UF.UpdateStaticControls( g_AvaCustFrames[unitTag] )
end

-- Updates shield value for given unit.
-- Called from EVENT_UNIT_ATTRIBUTE_VISUAL_* listeners.
function UF.UpdateShield( unitTag, value, maxValue )
    if g_savedHealth[unitTag] == nil then
        --d( "LUIE DEBUG: Stored health is nil: ", unitTag )
        return
    end

    g_savedHealth[unitTag][4] = value

    local healthValue, _ , healthEffectiveMax, _ = unpack(g_savedHealth[unitTag])
    -- Update frames
    if g_DefaultFrames[unitTag] then
        UF.UpdateAttribute( g_DefaultFrames[unitTag][POWERTYPE_HEALTH], healthValue, healthEffectiveMax, value, false )
        UF.UpdateShieldBar( g_DefaultFrames[unitTag][POWERTYPE_HEALTH], value, healthEffectiveMax )
    end
    if UF.CustomFrames[unitTag] then
        UF.UpdateAttribute( UF.CustomFrames[unitTag][POWERTYPE_HEALTH], healthValue, healthEffectiveMax, value, false )
        UF.UpdateShieldBar( UF.CustomFrames[unitTag][POWERTYPE_HEALTH], value, healthEffectiveMax )
    end
    if g_AvaCustFrames[unitTag] then
        UF.UpdateAttribute( g_AvaCustFrames[unitTag][POWERTYPE_HEALTH], healthValue, healthEffectiveMax, value, false )
        UF.UpdateShieldBar( g_AvaCustFrames[unitTag][POWERTYPE_HEALTH], value, healthEffectiveMax )
    end
end

-- Here actual update of shield bar on attribute is done
function UF.UpdateShieldBar( attributeFrame, shieldValue, healthEffectiveMax)
    if attributeFrame == nil or attributeFrame.shield == nil then
        return
    end

    local hideShield = not (shieldValue > 0)

    if hideShield then
        attributeFrame.shield:SetValue(0)
    else
        if UF.SV.CustomSmoothBar then
            -- Make it twice faster then default UI ones: last argument .085
            ZO_StatusBar_SmoothTransition(attributeFrame.shield, shieldValue, healthEffectiveMax, false, nil, 250)
        else
            attributeFrame.shield:SetMinMax(0, healthEffectiveMax)
            attributeFrame.shield:SetValue( shieldValue )
        end
    end

    attributeFrame.shield:SetHidden(hideShield)
    if attributeFrame.shieldbackdrop then
        attributeFrame.shieldbackdrop:SetHidden(hideShield)
    end
end

-- Reroutes call for regen/degen animation for given unit.
-- Called from EVENT_UNIT_ATTRIBUTE_VISUAL_* listeners.
function UF.UpdateRegen(unitTag, statType, attributeType, powerType )
    if powerType ~= POWERTYPE_HEALTH then return end

    -- Calculate actual value, and fallback to 0 if we call this function with nil parameters
    local value1 = (GetUnitAttributeVisualizerEffectInfo(unitTag, ATTRIBUTE_VISUAL_INCREASED_REGEN_POWER, statType, attributeType, powerType) or 0)
    local value2 = (GetUnitAttributeVisualizerEffectInfo(unitTag, ATTRIBUTE_VISUAL_DECREASED_REGEN_POWER, statType, attributeType, powerType) or 0)
    if value1 < 0 then value1 = 1 end
    if value2 > 0 then value2 = -1 end
    local value = value1 + value2

    -- Here we assume, that every unitTag entry in tables has POWERTYPE_HEALTH key
    if g_DefaultFrames[unitTag] and g_DefaultFrames[unitTag][POWERTYPE_HEALTH] then
        UF.DisplayRegen( g_DefaultFrames[unitTag][POWERTYPE_HEALTH].regen1, value > 0 )
        UF.DisplayRegen( g_DefaultFrames[unitTag][POWERTYPE_HEALTH].regen2, value > 0 )
        UF.DisplayRegen( g_DefaultFrames[unitTag][POWERTYPE_HEALTH].degen1, value < 0 )
        UF.DisplayRegen( g_DefaultFrames[unitTag][POWERTYPE_HEALTH].degen2, value < 0 )
    end
    if UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag][POWERTYPE_HEALTH] then
        UF.DisplayRegen( UF.CustomFrames[unitTag][POWERTYPE_HEALTH].regen1, value > 0 )
        UF.DisplayRegen( UF.CustomFrames[unitTag][POWERTYPE_HEALTH].regen2, value > 0 )
        UF.DisplayRegen( UF.CustomFrames[unitTag][POWERTYPE_HEALTH].degen1, value < 0 )
        UF.DisplayRegen( UF.CustomFrames[unitTag][POWERTYPE_HEALTH].degen2, value < 0 )
    end
    if g_AvaCustFrames[unitTag] and g_AvaCustFrames[unitTag][POWERTYPE_HEALTH] then
        UF.DisplayRegen( g_AvaCustFrames[unitTag][POWERTYPE_HEALTH].regen1, value > 0 )
        UF.DisplayRegen( g_AvaCustFrames[unitTag][POWERTYPE_HEALTH].regen2, value > 0 )
        UF.DisplayRegen( g_AvaCustFrames[unitTag][POWERTYPE_HEALTH].degen1, value < 0 )
        UF.DisplayRegen( g_AvaCustFrames[unitTag][POWERTYPE_HEALTH].degen2, value < 0 )
    end
end

-- Performs actual display of animation control if any
function UF.DisplayRegen( control, isShown )
    if control == nil then
        return
    end

    control:SetHidden( not isShown )
    if isShown then
        -- We restart the animation here only if its not already playing (prevents sharp fades mid-animation)
        if control.animation:IsPlaying() then
            return
        end
        control.timeline:SetPlaybackType(ANIMATION_PLAYBACK_LOOP, LOOP_INDEFINITELY)
        control.timeline:PlayFromStart()
    else
        control.timeline:SetPlaybackLoopsRemaining(0)
    end
end

-- Updates decreasedArmor texture for given unit.
-- While this applicable only to custom frames, we do not need to split this function into 2 different ones
-- Called from EVENT_UNIT_ATTRIBUTE_VISUAL_* listeners.
function UF.UpdateStat(unitTag, statType, attributeType, powerType )
    -- Build a list of UI controls to hold this statType on different UnitFrames lists
    local statControls = {}

    if ( UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag][powerType] and UF.CustomFrames[unitTag][powerType].stat and UF.CustomFrames[unitTag][powerType].stat[statType] ) then
        tableinsert(statControls, UF.CustomFrames[unitTag][powerType].stat[statType])
    end
    if ( g_AvaCustFrames[unitTag] and g_AvaCustFrames[unitTag][powerType] and g_AvaCustFrames[unitTag][powerType].stat and g_AvaCustFrames[unitTag][powerType].stat[statType] ) then
        tableinsert(statControls, g_AvaCustFrames[unitTag][powerType].stat[statType])
    end

    -- If we have a control, proceed next
    if #statControls > 0 then
        -- Calculate actual value, and fallback to 0 if we call this function with nil parameters
        local value = (GetUnitAttributeVisualizerEffectInfo(unitTag, ATTRIBUTE_VISUAL_INCREASED_STAT, statType, attributeType, powerType) or 0)
                    + (GetUnitAttributeVisualizerEffectInfo(unitTag, ATTRIBUTE_VISUAL_DECREASED_STAT, statType, attributeType, powerType) or 0)

        for _, control in pairs(statControls) do
            -- Hide proper controls if they exist
            if control.dec then
                control.dec:SetHidden( value >= 0 )
            end
            if control.inc then
                control.inc:SetHidden( value <= 0 )
            end
        end
    end
end

-- Forces to reload static information on unit frames.
-- Called from EVENT_LEVEL_UPDATE and EVENT_VETERAN_RANK_UPDATE listeners.
function UF.OnLevelUpdate(eventCode, unitTag, level)
    UF.UpdateStaticControls( g_DefaultFrames[unitTag] )
    UF.UpdateStaticControls( UF.CustomFrames[unitTag] )
    UF.UpdateStaticControls( g_AvaCustFrames[unitTag] )

    -- For Custom Player Frame we have to setup experience bar
    if unitTag == "player" and UF.CustomFrames.player and UF.CustomFrames.player.Experience then
        UF.CustomFramesSetupAlternative()
    end
end

-- Runs on the EVENT_PLAYER_COMBAT_STATE listener.
-- This handler fires every time player enters or leaves combat
function UF.OnPlayerCombatState(eventCode, inCombat)
    g_statFull.combat = not inCombat
    UF.CustomFramesApplyInCombat()
end

-- Runs on the EVENT_WEREWOLF_STATE_CHANGED listener.
function UF.OnWerewolf(eventCode, werewolf)
    UF.CustomFramesSetupAlternative( werewolf, false, false )
end

-- Runs on the EVENT_BEGIN_SIEGE_CONTROL, EVENT_END_SIEGE_CONTROL, EVENT_LEAVE_RAM_ESCORT listeners.
function UF.OnSiege(eventCode)
    UF.CustomFramesSetupAlternative( false, nil, false )
end

-- Runs on the EVENT_MOUNTED_STATE_CHANGED listener.
function UF.OnMount(eventCode, mounted)
    UF.CustomFramesSetupAlternative( IsWerewolf(), false, mounted )
end

-- Runs on the EVENT_EXPERIENCE_UPDATE listener.
function UF.OnXPUpdate( eventCode, unitTag, currentExp, maxExp, reason )
    if unitTag ~= "player" or not UF.CustomFrames.player then
        return
    end
    if UF.CustomFrames.player.isChampion then
        -- Query for Veteran and Champion XP not more then once every 5 seconds
        if not g_PendingUpdate.VeteranXP.flag then
            g_PendingUpdate.VeteranXP.flag = true
            eventManager:RegisterForUpdate( g_PendingUpdate.VeteranXP.name, g_PendingUpdate.VeteranXP.delay, UF.UpdateVeteranXP )
        end
    elseif UF.CustomFrames.player.Experience then
        UF.CustomFrames.player.Experience.bar:SetValue( currentExp )
    end
end

-- Helper function that updates Champion XP bar. Called from event listener with 5 sec delay
function UF.UpdateVeteranXP()
    -- Unregister update function
    eventManager:UnregisterForUpdate( g_PendingUpdate.VeteranXP.name )

    if UF.CustomFrames.player then
        if UF.CustomFrames.player.Experience then
            UF.CustomFrames.player.Experience.bar:SetValue( GetUnitChampionPoints("player") )
        elseif UF.CustomFrames.player.ChampionXP then
			local enlightenedPool = 4 * GetEnlightenedPool()
			local xp = GetPlayerChampionXP()
			local maxBar = GetNumChampionXPInChampionPoint(GetPlayerChampionPointsEarned())
			local enlightenedBar = enlightenedPool + xp
			if enlightenedBar > maxBar then enlightenedBar = maxBar end -- If the enlightenment pool extends past the current level then cap it at the maximum bar value.

            UF.CustomFrames.player.ChampionXP.bar:SetValue( xp )
			UF.CustomFrames.player.ChampionXP.enlightenment:SetValue( enlightenedBar )
        end
    end
    -- Clear local flag
    g_PendingUpdate.VeteranXP.flag = false
end

-- Runs on the EVENT_GROUP_SUPPORT_RANGE_UPDATE listener.
function UF.OnGroupSupportRangeUpdate(eventCode, unitTag, status)
    if UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag].control then
        UF.CustomFrames[unitTag].control:SetAlpha( status and ( UF.SV.GroupAlpha * 0.01) or ( UF.SV.GroupAlpha * 0.01) / 2 )
    end
end

-- Runs on the EVENT_GROUP_MEMBER_CONNECTED_STATUS listener.
function UF.OnGroupMemberConnectedStatus(eventCode, unitTag, isOnline)
    --d( strfmt("DC: %s - %s", unitTag, isOnline and "Online" or "Offline" ) )
    if UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag].dead then
        UF.CustomFramesSetDeadLabel( UF.CustomFrames[unitTag], isOnline and nil or strOffline )
    end
    if isOnline and (UF.SV.ColorRoleGroup or UF.SV.ColorRoleRaid) then
        UF.CustomFramesApplyColours(false)
    end

end

function UF.OnGroupMemberRoleChange(eventCode, unitTag, dps, healer, tank)
    if UF.CustomFrames[unitTag] then
        if (UF.SV.ColorRoleGroup or UF.SV.ColorRoleRaid) then
            UF.CustomFramesApplyColoursSingle(unitTag)
        end
        UF.ReloadValues(unitTag)
        UF.CustomFramesApplyLayoutGroup(false)
        UF.CustomFramesApplyLayoutRaid(false)
    end
end

function UF.OnGroupMemberChange(eventCode, memberName)
    callLater(function() UF.CustomFramesApplyColours(false) end, 200)
end

-- Runs on the EVENT_UNIT_DEATH_STATE_CHANGED listener.
-- This handler fires every time a valid unitTag dies or is resurrected
function UF.OnDeath(eventCode, unitTag, isDead)
    --d( strfmt("%s - %s", unitTag, isDead and "Dead" or "Alive" ) )
    if UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag].dead then
        UF.CustomFramesSetDeadLabel( UF.CustomFrames[unitTag], isDead and strDead or nil )
    end

    -- Manually hide regen/degen animation as well as stat-changing icons, because game does not always issue corresponding event before unit is dead
    if isDead and UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag][POWERTYPE_HEALTH] then
        local thb = UF.CustomFrames[unitTag][POWERTYPE_HEALTH] -- not a backdrop
        -- 1. Regen/degen
        UF.DisplayRegen( thb.regen1, false )
        UF.DisplayRegen( thb.regen2, false )
        UF.DisplayRegen( thb.degen1, false )
        UF.DisplayRegen( thb.degen2, false )
        -- 2. Stats
        if thb.stat then
            for _, statControls in pairs( thb.stat ) do
                if statControls.dec then
                    statControls.dec:SetHidden( true )
                end
                if statControls.inc then
                    statControls.inc:SetHidden( true )
                end
            end
        end
    end
end

-- Runs on the EVENT_LEADER_UPDATE listener.
function UF.OnLeaderUpdate(eventCode, leaderTag)
    UF.CustomFramesApplyLayoutGroup(false)
    UF.CustomFramesApplyLayoutRaid(false)
end

-- This function is used to setup alternative bar for player
-- Priority order: Werewolf -> Siege -> Mount -> ChampionXP / Experience
local XP_BAR_COLOURS = ZO_XP_BAR_GRADIENT_COLORS[2]
function UF.CustomFramesSetupAlternative( isWerewolf, isSiege, isMounted )
    if not UF.CustomFrames.player then
        return
    end
    -- If any of input parameters are nil, we need to query them
    if isWerewolf == nil then
        isWerewolf = IsWerewolf()
    end
    if isSiege == nil then
        isSiege = ( IsPlayerControllingSiegeWeapon() or IsPlayerEscortingRam() )
    end
    if isMounted == nil then
        isMounted = IsMounted()
    end

    local center, colour, icon
    local hidden = false
    local right = false
    local left = false
    local recenter = false

    local phb = UF.CustomFrames.player[POWERTYPE_HEALTH] -- Not a backdrop
    local pmb = UF.CustomFrames.player[POWERTYPE_MAGICKA] -- Not a backdrop
    local psb = UF.CustomFrames.player[POWERTYPE_STAMINA] -- Not a backdrop
    local alt = UF.CustomFrames.player.alternative

    if UF.SV.PlayerEnableAltbarMSW and isWerewolf then
        icon    = "LuiExtended/media/unitframes/unitframes_bar_werewolf.dds"
        center  = { 0.05, 0, 0, 0.9 }
        colour  = { 0.8,  0, 0, 0.9 }

        UF.CustomFrames.player[POWERTYPE_WEREWOLF] = UF.CustomFrames.player.alternative
        UF.CustomFrames.controlledsiege[POWERTYPE_HEALTH] = nil
        UF.CustomFrames.player[POWERTYPE_MOUNT_STAMINA] = nil
        UF.CustomFrames.player.ChampionXP = nil
        UF.CustomFrames.player.Experience = nil

        UF.OnPowerUpdate(nil, "player", nil, POWERTYPE_WEREWOLF, GetUnitPower("player", POWERTYPE_WEREWOLF))

        if UF.SV.PlayerFrameOptions ~= 1 then
            left = true
        else
            recenter = true
        end

        UF.CustomFrames.player.alternative.bar:SetMouseEnabled( true )
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseEnter", UF.AltBar_OnMouseEnterWerewolf)
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseExit",  UF.AltBar_OnMouseExit)
		UF.CustomFrames.player.alternative.enlightenment:SetHidden( true )
    elseif UF.SV.PlayerEnableAltbarMSW and isSiege then
        icon    = "LuiExtended/media/unitframes/unitframes_bar_siege.dds"
        center  = { 0.05, 0, 0, 0.9 }
        colour  = { 0.8,  0, 0, 0.9 }

        UF.CustomFrames.player[POWERTYPE_WEREWOLF] = nil
        UF.CustomFrames.controlledsiege[POWERTYPE_HEALTH] = UF.CustomFrames.player.alternative
        UF.CustomFrames.player[POWERTYPE_MOUNT_STAMINA] = nil
        UF.CustomFrames.player.ChampionXP = nil
        UF.CustomFrames.player.Experience = nil

        UF.OnPowerUpdate(nil, "controlledsiege", nil, POWERTYPE_HEALTH, GetUnitPower("controlledsiege", POWERTYPE_HEALTH))

        recenter = true

        UF.CustomFrames.player.alternative.bar:SetMouseEnabled( true )
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseEnter", UF.AltBar_OnMouseEnterSiege)
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseExit",  UF.AltBar_OnMouseExit)
		UF.CustomFrames.player.alternative.enlightenment:SetHidden( true )
    elseif UF.SV.PlayerEnableAltbarMSW and isMounted then
        icon    = "LuiExtended/media/unitframes/unitframes_bar_mount.dds"
        center  = { 0.1*UF.SV.CustomColourStamina[1], 0.1*UF.SV.CustomColourStamina[2], 0.1*UF.SV.CustomColourStamina[3], 0.9 }
        colour  = { UF.SV.CustomColourStamina[1], UF.SV.CustomColourStamina[2], UF.SV.CustomColourStamina[3], 0.9 }

        UF.CustomFrames.player[POWERTYPE_WEREWOLF] = nil
        UF.CustomFrames.controlledsiege[POWERTYPE_HEALTH] = nil
        UF.CustomFrames.player[POWERTYPE_MOUNT_STAMINA] = UF.CustomFrames.player.alternative
        UF.CustomFrames.player.ChampionXP = nil
        UF.CustomFrames.player.Experience = nil

        UF.OnPowerUpdate(nil, "player", nil, POWERTYPE_MOUNT_STAMINA, GetUnitPower("player", POWERTYPE_MOUNT_STAMINA))

        if UF.SV.PlayerFrameOptions ~= 1 then
            right = true
        else
            recenter = true
        end

        UF.CustomFrames.player.alternative.bar:SetMouseEnabled( true )
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseEnter", UF.AltBar_OnMouseEnterMounted)
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseExit",  UF.AltBar_OnMouseExit)
		UF.CustomFrames.player.alternative.enlightenment:SetHidden( true )
    elseif UF.SV.PlayerEnableAltbarXP and ( UF.CustomFrames.player.isLevelCap or ( UF.CustomFrames.player.isChampion )) then
        UF.CustomFrames.player[POWERTYPE_WEREWOLF] = nil
        UF.CustomFrames.controlledsiege[POWERTYPE_HEALTH] = nil
        UF.CustomFrames.player[POWERTYPE_MOUNT_STAMINA] = nil
        UF.CustomFrames.player.ChampionXP = UF.CustomFrames.player.alternative
        UF.CustomFrames.player.Experience = nil

        UF.OnChampionPointGained() -- Setup bar colour and proper icon

		local enlightenedPool = 4 * GetEnlightenedPool()
		local xp = GetPlayerChampionXP()
		local maxBar = GetNumChampionXPInChampionPoint(GetPlayerChampionPointsEarned())
		local enlightenedBar = enlightenedPool + xp
		if enlightenedBar > maxBar then enlightenedBar = maxBar end -- If the enlightenment pool extends past the current level then cap it at the maximum bar value.

		UF.CustomFrames.player.ChampionXP.enlightenment:SetMinMax( 0 , maxBar)
		UF.CustomFrames.player.ChampionXP.enlightenment:SetValue( enlightenedBar )

        UF.CustomFrames.player.ChampionXP.bar:SetMinMax( 0 , maxBar)
        UF.CustomFrames.player.ChampionXP.bar:SetValue( xp )

        recenter = true

        UF.CustomFrames.player.alternative.bar:SetMouseEnabled( true )
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseEnter", UF.AltBar_OnMouseEnterXP)
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseExit",  UF.AltBar_OnMouseExit)
		UF.CustomFrames.player.alternative.enlightenment:SetHidden( false )
    elseif UF.SV.PlayerEnableAltbarXP then
        icon    = "LuiExtended/media/unitframes/unitframes_level_normal.dds"
        center  = { 0, 0.1, 0.1, 0.9 }
        colour  = { XP_BAR_COLOURS.r, XP_BAR_COLOURS.g, XP_BAR_COLOURS.b, 0.9 } -- { 0, 0.9, 0.9, 0.9 }

        UF.CustomFrames.player[POWERTYPE_WEREWOLF] = nil
        UF.CustomFrames.controlledsiege[POWERTYPE_HEALTH] = nil
        UF.CustomFrames.player[POWERTYPE_MOUNT_STAMINA] = nil
        UF.CustomFrames.player.ChampionXP = nil
        UF.CustomFrames.player.Experience = UF.CustomFrames.player.alternative

        UF.CustomFrames.player.Experience.bar:SetMinMax( 0 , UF.CustomFrames.player.isChampion and GetNumChampionXPInChampionPoint("player")  or GetUnitXPMax("player") )
        UF.CustomFrames.player.Experience.bar:SetValue( UF.CustomFrames.player.isChampion and GetPlayerChampionXP() or GetUnitXP("player") )

        recenter = true
    -- Otherwise bar should be hidden and no tracking be done

        UF.CustomFrames.player.alternative.bar:SetMouseEnabled( true )
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseEnter", UF.AltBar_OnMouseEnterXP)
        UF.CustomFrames.player.alternative.bar:SetHandler("OnMouseExit",  UF.AltBar_OnMouseExit)
		UF.CustomFrames.player.alternative.enlightenment:SetHidden( true )
    else
        UF.CustomFrames.player[POWERTYPE_WEREWOLF] = nil
        UF.CustomFrames.controlledsiege[POWERTYPE_HEALTH] = nil
        UF.CustomFrames.player[POWERTYPE_MOUNT_STAMINA] = nil
        UF.CustomFrames.player.ChampionXP = nil
        UF.CustomFrames.player.Experience = nil

        hidden = true
        UF.CustomFrames.player.alternative.bar:SetMouseEnabled( false )
		UF.CustomFrames.player.alternative.enlightenment:SetHidden( true )
    end

    -- Setup of bar colours and icon
    if center then
        UF.CustomFrames.player.alternative.backdrop:SetCenterColor( unpack(center) )
    end
    if colour then
        UF.CustomFrames.player.alternative.bar:SetColor( unpack(colour) )
    end
    if icon then
        UF.CustomFrames.player.alternative.icon:SetTexture( icon )
    end

    local altW = mathceil(UF.SV.PlayerBarWidth * 2/3)
    local padding = alt.icon:GetWidth()
    -- Hide bar and reanchor buffs
    UF.CustomFrames.player.botInfo:SetHidden( hidden )
    UF.CustomFrames.player.buffAnchor:SetHidden( hidden )
    UF.CustomFrames.player.buffs:ClearAnchors()
    if UF.SV.PlayerFrameOptions == 3 then
        if UF.SV.HideBarMagicka and UF.SV.HideBarStamina then
            UF.CustomFrames.player.buffs:SetAnchor( TOP, hidden and UF.CustomFrames.player.control or UF.CustomFrames.player.buffAnchor, BOTTOM, 0, 5 )
        else
            UF.CustomFrames.player.buffs:SetAnchor( TOP, hidden and UF.CustomFrames.player.control or UF.CustomFrames.player.buffAnchor, BOTTOM, 0, 5 + UF.SV.PlayerBarHeightStamina + UF.SV.PlayerBarSpacing )
        end
    else
        UF.CustomFrames.player.buffs:SetAnchor( TOP, hidden and UF.CustomFrames.player.control or UF.CustomFrames.player.buffAnchor, BOTTOM, 0, 5 )
    end
    if right then
        if UF.SV.HideBarStamina or UF.SV.HideBarMagicka then
            UF.CustomFrames.player.botInfo:SetAnchor(TOP, phb.backdrop, BOTTOM, 0, 2 )
            alt.backdrop:ClearAnchors()
            alt.backdrop:SetAnchor( CENTER, UF.CustomFrames.player.botInfo, CENTER, padding * .5 +1, 0)
            alt.backdrop:SetWidth(altW)
            alt.icon:ClearAnchors()
            alt.icon:SetAnchor (RIGHT, alt.backdrop, LEFT,-2,0)
        else
            UF.CustomFrames.player.botInfo:SetAnchor(TOP, psb.backdrop, BOTTOM, 0, 2 )
            alt.backdrop:ClearAnchors()
            alt.backdrop:SetAnchor( LEFT, UF.CustomFrames.player.botInfo, LEFT, padding + 5, 0)
            alt.backdrop:SetWidth(altW)
            alt.icon:ClearAnchors()
            alt.icon:SetAnchor (RIGHT, alt.backdrop, LEFT,-2,0)
        end
    elseif left then
        if UF.SV.HideBarStamina or UF.SV.HideBarMagicka then
            UF.CustomFrames.player.botInfo:SetAnchor(TOP, phb.backdrop, BOTTOM, 0, 2 )
            alt.backdrop:ClearAnchors()
            alt.backdrop:SetAnchor( CENTER, UF.CustomFrames.player.botInfo, CENTER, padding * .5 +1, 0)
            alt.backdrop:SetWidth(altW)
            alt.icon:ClearAnchors()
            alt.icon:SetAnchor (RIGHT, alt.backdrop, LEFT,-2,0)
        else
            UF.CustomFrames.player.botInfo:SetAnchor(TOP, pmb.backdrop, BOTTOM, 0, 2 )
            alt.backdrop:ClearAnchors()
            alt.backdrop:SetAnchor( RIGHT, UF.CustomFrames.player.botInfo, RIGHT, -padding - 5, 0)
            alt.backdrop:SetWidth(altW)
            alt.icon:ClearAnchors()
            alt.icon:SetAnchor (LEFT, alt.backdrop, RIGHT,2,0)
        end
        --alt.icon:ClearAnchors()
    elseif recenter then
        if UF.SV.PlayerFrameOptions == 1 then
            UF.CustomFrames.player.botInfo:SetAnchor(TOP, playerTlw, BOTTOM, 0, 2 )
            alt.backdrop:ClearAnchors()
            alt.backdrop:SetAnchor( CENTER, UF.CustomFrames.player.botInfo, CENTER, padding * .5 +1, 0)
            alt.backdrop:SetWidth(altW)
            alt.icon:ClearAnchors()
            alt.icon:SetAnchor (RIGHT, alt.backdrop, LEFT,-2,0)
        elseif UF.SV.PlayerFrameOptions == 2 then
            UF.CustomFrames.player.botInfo:SetAnchor(TOP, playerTlw, BOTTOM, 0, 2 )
            alt.backdrop:ClearAnchors()
            alt.backdrop:SetAnchor( CENTER, UF.CustomFrames.player.botInfo, CENTER, padding * .5 +1, 0)
            alt.backdrop:SetWidth(altW)
            alt.icon:ClearAnchors()
            alt.icon:SetAnchor (RIGHT, alt.backdrop, LEFT,-2,0)
        elseif UF.SV.PlayerFrameOptions == 3 then
            if UF.SV.HideBarStamina and UF.SV.HideBarMagicka then
                UF.CustomFrames.player.botInfo:SetAnchor(TOP, playerTlw, BOTTOM, 0, 2 )
            elseif UF.SV.HideBarStamina and not UF.SV.HideBarMagicka then
                UF.CustomFrames.player.botInfo:SetAnchor(TOP, pmb.backdrop, BOTTOMRIGHT, 0, 2 )
            else
                UF.CustomFrames.player.botInfo:SetAnchor(TOP, psb.backdrop, BOTTOMLEFT, 0, 2 )
            end
            alt.backdrop:ClearAnchors()
            alt.backdrop:SetAnchor( CENTER, UF.CustomFrames.player.botInfo, CENTER, padding * .5 +1, 0)
            alt.backdrop:SetWidth(altW)
            alt.icon:ClearAnchors()
            alt.icon:SetAnchor (RIGHT, alt.backdrop, LEFT,-2,0)
        else
            UF.CustomFrames.player.botInfo:SetAnchor(TOP, playerTlw, BOTTOM, 0, 2)
        end
    end
end

-- Runs on EVENT_CHAMPION_POINT_GAINED event listener
-- Used to change icon on alternative bar for next champion point type
function UF.OnChampionPointGained(eventCode)
    if UF.CustomFrames.player and UF.CustomFrames.player.ChampionXP then
        local attribute = GetChampionPointAttributeForRank( GetPlayerChampionPointsEarned()+1 )
        local colour = ( UF.SV.PlayerChampionColour and CP_BAR_COLOURS[attribute] ) and CP_BAR_COLOURS[attribute][2] or XP_BAR_COLOURS
        local colour2 = ( UF.SV.PlayerChampionColour and CP_BAR_COLOURS[attribute] ) and CP_BAR_COLOURS[attribute][1] or XP_BAR_COLOURS
        UF.CustomFrames.player.ChampionXP.backdrop:SetCenterColor( 0.1*colour.r, 0.1*colour.g, 0.1*colour.b, 0.9 )
        UF.CustomFrames.player.ChampionXP.enlightenment:SetColor( colour2.r, colour2.g, colour2.b, .40 )
        UF.CustomFrames.player.ChampionXP.bar:SetColor( colour.r, colour.g, colour.b, 0.9 )
        UF.CustomFrames.player.ChampionXP.icon:SetTexture( CHAMPION_ATTRIBUTE_HUD_ICONS[ attribute ] )
    end
end

-- Runs on the EVENT_COMBAT_EVENT listener.
function UF.OnCombatEvent( eventCode, result, isError, abilityName, abilityGraphic, abilityActionSlotType, sourceName, sourceType, targetName, targetType, hitValue, powerType, damageType, log )
    if isError
        and sourceType == COMBAT_UNIT_TYPE_PLAYER
        and targetType == COMBAT_UNIT_TYPE_PLAYER
        and UF.CustomFrames.player ~= nil
        and UF.CustomFrames.player[powerType] ~= nil
        and UF.CustomFrames.player[powerType].backdrop ~= nil
        and ( powerType == POWERTYPE_HEALTH or powerType == POWERTYPE_STAMINA or powerType == POWERTYPE_MAGICKA) then

        if g_powerError[powerType] or IsUnitDead("player") then
            return
        end

        g_powerError[powerType] = true
        -- Save original center colour and colour to red
        local backdrop = UF.CustomFrames.player[powerType].backdrop
        local r,g,b = backdrop:GetCenterColor()
        if powerType == POWERTYPE_STAMINA then
            backdrop:SetCenterColor( 0, 0.2, 0, 0.9 )
        elseif powerType == POWERTYPE_MAGICKA then
            backdrop:SetCenterColor( 0, 0.05, 0.35, 0.9 )
        else
            backdrop:SetCenterColor( 0.4, 0, 0, 0.9 )
        end

        -- Make a delayed call to return original colour
        local uniqueId = moduleName .. "_powerError_" .. powerType
        local firstRun = true

        eventManager:RegisterForUpdate(uniqueId, 300, function()
            if firstRun then
                backdrop:SetCenterColor( r, g, b, 0.9 )
                firstRun = false
            else
                eventManager:UnregisterForUpdate(uniqueId)
                g_powerError[powerType] = false
            end
        end)
    end
end

-- Helper function to update visibility of 'death/offline' label and hide bars and bar labels
function UF.CustomFramesSetDeadLabel( unitFrame, newValue )
    unitFrame.dead:SetHidden( newValue == nil )
    if newValue ~= nil then
        unitFrame.dead:SetText( newValue )
    end
    if newValue == "Offline" then
        classIcon = classIcons[0]
        if unitFrame.level ~= nil then
            unitFrame.level:SetHidden( newValue ~= "Dead" or newValue ~= nil )
        end
        if unitFrame.levelIcon ~= nil then
            unitFrame.levelIcon:SetHidden( newValue ~= "Dead" or newValue ~= nil )
        end
        if unitFrame.friendIcon ~= nil then
            unitFrame.friendIcon:SetHidden( newValue ~= "Dead" or newValue ~= nil )
        end
        if unitFrame.classIcon ~= nil then
            unitFrame.classIcon:SetTexture(classIcon)
        end
    end
    if unitFrame[POWERTYPE_HEALTH] then
        if unitFrame[POWERTYPE_HEALTH].bar ~= nil then
            unitFrame[POWERTYPE_HEALTH].bar:SetHidden( newValue ~= nil )
        end
        if unitFrame[POWERTYPE_HEALTH].label ~= nil then
            unitFrame[POWERTYPE_HEALTH].label:SetHidden( newValue ~= nil )
        end
        if unitFrame[POWERTYPE_HEALTH].labelOne ~= nil then
            unitFrame[POWERTYPE_HEALTH].labelOne:SetHidden( newValue ~= nil )
        end
        if unitFrame[POWERTYPE_HEALTH].labelTwo ~= nil then
            unitFrame[POWERTYPE_HEALTH].labelTwo:SetHidden( newValue ~= nil )
        end
    end
end

-- Repopulate group members, but try to update only those, that require it
function UF.CustomFramesGroupUpdate()
    --d( strfmt("[%s] GroupUpdate", GetTimeString()) )

    -- Unregister update function and clear local flag
    eventManager:UnregisterForUpdate( g_PendingUpdate.Group.name )
    g_PendingUpdate.Group.flag = false

    if ( UF.CustomFrames.SmallGroup1 == nil and UF.CustomFrames.RaidGroup1 == nil ) then
        return
    end

    if UF.SV.CustomFramesGroup then
        if GetGroupSize() <= 4 then ZO_UnitFramesGroups:SetHidden ( true ) end
    end
    if UF.SV.CustomFramesRaid then
        if GetGroupSize() >4 then ZO_UnitFramesGroups:SetHidden ( true ) end
    end

    -- This requires some tricks if we want to keep list alphabetically sorted
    local groupList = {}

    -- First we query all group unitTag for existence and save them to local list
    -- At the same time we will calculate how many group members we have and then will hide rest of custom control elements
    local n = 0 -- counter used to reference custom frames. it always continuous while games unitTag could have gaps
    for i = 1, 24 do
        local unitTag = "group" .. i
        if DoesUnitExist(unitTag) then
            -- Save this member for later sorting
            tableinsert(groupList, { ["unitTag"] = unitTag, ["unitName"] = GetUnitName(unitTag) } )
            -- CustomFrames
            n = n + 1
        else
            -- For non-existing unitTags we will remove reference from CustomFrames table
            UF.CustomFrames[unitTag] = nil
        end
    end

    -- Chose which of custom group frames we are going to use now
    local raid = nil

    -- Now we have to hide all excessive custom group controls
    if n > 4 then
        if UF.CustomFrames.SmallGroup1 then -- Custom group frames cannot be used for large groups
            UF.CustomFramesUnreferenceGroupControl("SmallGroup", 1)
        end
        if UF.CustomFrames.RaidGroup1 then -- Real group is large and custom raid frames are enabled
            UF.CustomFramesUnreferenceGroupControl("RaidGroup", n+1)
            raid = true
        end
    else
        if UF.CustomFrames.SmallGroup1 then -- Custom group frames are enabled and used for small group
            UF.CustomFramesUnreferenceGroupControl("SmallGroup", n+1)
            raid = false
            if UF.CustomFrames.RaidGroup1 then -- In this case just hide all raid frames if they are enabled
                UF.CustomFramesUnreferenceGroupControl("RaidGroup", 1)
            end
        elseif UF.CustomFrames.RaidGroup1 then -- Remove frames if custom Small Group is not set to show
            UF.CustomFramesUnreferenceGroupControl("RaidGroup", 1)
            raid = false
        end
    end

    -- Here we can check unlikely situation when neither custom frames were selected
    if raid == nil then
        return
    end

    -- Now for small group we can exclude player from the list
    if raid == false and UF.SV.GroupExcludePlayer then
        for i = 1, #groupList do
            if AreUnitsEqual( "player", groupList[i].unitTag ) then
                -- Dereference game unitTag from CustomFrames table
                UF.CustomFrames[groupList[i].unitTag] = nil
                -- Remove element from saved table
                tableremove(groupList, i)
                -- Also remove last used (not removed on previous step) SmallGroup unitTag
                -- Variable 'n' is still holding total number of group members
                -- Thus we need to remove n-th one
                local unitTag = "SmallGroup" .. n
                UF.CustomFrames[unitTag].unitTag = nil
                UF.CustomFrames[unitTag].control:SetHidden( true )
                break
            end
        end
    end

    -- Now we have local list with valid units and we are ready to sort it
    -- FIXME: Sorting is again hardcoded to be done always
    --if not raid or UF.SV.RaidSort then
        tablesort( groupList, function(x,y) return x.unitName < y.unitName end )
    --end

    -- Loop through sorted list and put unitTag references into CustomFrames table
    local n = 0
    for _, v in ipairs(groupList) do
        -- Increase local counter
        n = n + 1
        UF.CustomFrames[v.unitTag] = UF.CustomFrames[ (raid and "RaidGroup" or "SmallGroup" ) .. n]
        if UF.CustomFrames[v.unitTag] then
            UF.CustomFrames[v.unitTag].control:SetHidden( false )

            -- For SmallGroup reset topInfo width
            if not raid then
                UF.CustomFrames[v.unitTag].topInfo:SetWidth( UF.SV.GroupBarWidth-5 )
            end

            UF.CustomFrames[v.unitTag].unitTag = v.unitTag
            UF.ReloadValues(v.unitTag)
        end
    end

    UF.OnLeaderUpdate( nil, nil )
end

-- Helper function to hide and remove unitTag reference from unused group controls
function UF.CustomFramesUnreferenceGroupControl( groupType, first )
    local last
    if groupType == "SmallGroup" then
        last = 4
    elseif groupType == "RaidGroup" then
        last = 24
    else return end

    for i = first, last do
        local unitTag =  groupType .. i
        UF.CustomFrames[unitTag].unitTag = nil
        UF.CustomFrames[unitTag].control:SetHidden( true )
    end
end

-- Runs EVENT_BOSSES_CHANGED listener
function UF.OnBossesChanged( eventCode )
    if not UF.CustomFrames.boss1 then
        return
    end

    for i = 1, 6 do
        local unitTag = "boss" .. i
        if DoesUnitExist(unitTag) then
            UF.CustomFrames[unitTag].control:SetHidden(false)
            UF.ReloadValues(unitTag)
        else
            UF.CustomFrames[unitTag].control:SetHidden(true)
        end
    end
end

-- Set anchors for all top level windows of CustomFrames
function UF.CustomFramesSetPositions()
    local default_anchors = { }
    if UF.SV.PlayerFrameOptions == 1 then
        default_anchors = {
            ["player"]      = {TOPLEFT,TOPLEFT,468,745},
            ["reticleover"] = {TOPLEFT,TOPLEFT,1152,745},
            ["SmallGroup1"] = {TOPLEFT,TOPLEFT,6,208},
            ["RaidGroup1"]  = {TOPLEFT,TOPLEFT,6,330},
            ["boss1"]       = {TOPLEFT,TOPLEFT,1266,228},
            ["AvaPlayerTarget"] = {TOP,TOP,0,200},
        }
    elseif UF.SV.PlayerFrameOptions == 2 then
        default_anchors = {
            ["player"]      = {CENTER,CENTER,0,344},
            ["reticleover"] = {CENTER,CENTER,0,-344},
            ["SmallGroup1"] = {TOPLEFT,TOPLEFT,6,208},
            ["RaidGroup1"]  = {TOPLEFT,TOPLEFT,6,330},
            ["boss1"]       = {TOPLEFT,TOPLEFT,1266,228},
            ["AvaPlayerTarget"] = {TOP,TOP,0,200},
        }
    else
        default_anchors = {
            ["player"]      = {CENTER,CENTER,0,334},
            ["reticleover"] = {CENTER,CENTER,0,-344},
            ["SmallGroup1"] = {TOPLEFT,TOPLEFT,6,208},
            ["RaidGroup1"]  = {TOPLEFT,TOPLEFT,6,330},
            ["boss1"]       = {TOPLEFT,TOPLEFT,1266,228},
            ["AvaPlayerTarget"] = {TOP,TOP,0,200},
        }
    end

    for _, unitTag in pairs( { "player", "reticleover", "SmallGroup1", "RaidGroup1", "boss1", "AvaPlayerTarget" } ) do
        if UF.CustomFrames[unitTag] then
            local savedPos = UF.SV[UF.CustomFrames[unitTag].tlw.customPositionAttr]
            local anchors = ( savedPos ~= nil and #savedPos == 2 ) and { TOPLEFT, TOPLEFT, savedPos[1], savedPos[2] } or default_anchors[unitTag]
            UF.CustomFrames[unitTag].tlw:ClearAnchors()
            UF.CustomFrames[unitTag].tlw:SetAnchor( anchors[1], GuiRoot, anchors[2], anchors[3], anchors[4] )
            UF.CustomFrames[unitTag].tlw.preview.anchorLabel:SetText( ( savedPos ~= nil and #savedPos == 2 ) and strformat("<<1>>, <<2>>", savedPos[1], savedPos[2]) or "default" )
        end
    end
end

-- Reset anchors for all top level windows of CustomFrames
function UF.CustomFramesResetPosition(playerOnly)
    for _, unitTag in pairs( { "player", "reticleover" } ) do
        if UF.CustomFrames[unitTag] then
            UF.SV[UF.CustomFrames[unitTag].tlw.customPositionAttr] = nil
        end
    end
    if playerOnly == false then
        for _, unitTag in pairs( { "SmallGroup1", "RaidGroup1", "boss1", "AvaPlayerTarget" } ) do
            if UF.CustomFrames[unitTag] then
                UF.SV[UF.CustomFrames[unitTag].tlw.customPositionAttr] = nil
            end
        end
    end
    UF.CustomFramesSetPositions()
end

-- Unlock CustomFrames for moving. Called from Settings Menu.
function UF.CustomFramesSetMovingState( state )
    UF.CustomFramesMovingState = state

    -- Unlock individual frames
    for _, unitTag in pairs( { "player", "reticleover", "SmallGroup1", "RaidGroup1", "boss1", "AvaPlayerTarget" } ) do
        if UF.CustomFrames[unitTag] then
            local tlw = UF.CustomFrames[unitTag].tlw
            if tlw.preview then
                tlw.preview:SetHidden( not state ) -- player frame does not have 'preview' control
            end
            tlw:SetMouseEnabled( state )
            tlw:SetMovable( state )
            tlw:SetHidden( false )
        end
    end

    -- Unlock buffs for Player ( preview control is created in SCB module )
    if UF.CustomFrames.player then
        if UF.CustomFrames.player.buffs.preview then
            UF.CustomFrames.player.buffs.preview:SetHidden( not state )
        end
        if UF.CustomFrames.player.debuffs.preview then
            UF.CustomFrames.player.debuffs.preview:SetHidden( not state )
        end
    end

    -- Unlock buffs and debuffs for Target ( preview controls are created in LTE and SCB modules )
    if UF.CustomFrames.reticleover then
        if UF.CustomFrames.reticleover.buffs.preview then
            UF.CustomFrames.reticleover.buffs.preview:SetHidden( not state )
        end
        if UF.CustomFrames.reticleover.debuffs.preview then
            UF.CustomFrames.reticleover.debuffs.preview:SetHidden( not state )
        end
        -- Make this hack so target window is not going to be hidden:
        -- Target Frame will now always display old information
        UF.CustomFrames.reticleover.canHide = not state
    end
end

-- Apply selected colours for all known bars on custom unit frames
function UF.CustomFramesApplyColours(isMenu)
    local health    = { UF.SV.CustomColourHealth[1],  UF.SV.CustomColourHealth[2],  UF.SV.CustomColourHealth[3], 0.9 }
    local shield    = { UF.SV.CustomColourShield[1],  UF.SV.CustomColourShield[2],  UF.SV.CustomColourShield[3], 0 } -- .a value will be fixed in the loop
    local magicka   = { UF.SV.CustomColourMagicka[1], UF.SV.CustomColourMagicka[2], UF.SV.CustomColourMagicka[3], 0.9 }
    local stamina   = { UF.SV.CustomColourStamina[1], UF.SV.CustomColourStamina[2], UF.SV.CustomColourStamina[3], 0.9 }

    local dps       =  { UF.SV.CustomColourDPS[1],    UF.SV.CustomColourDPS[2],     UF.SV.CustomColourDPS[3], 0.9 }
    local healer    =  { UF.SV.CustomColourHealer[1], UF.SV.CustomColourHealer[2],  UF.SV.CustomColourHealer[3], 0.9 }
    local tank      =  { UF.SV.CustomColourTank[1],   UF.SV.CustomColourTank[2],    UF.SV.CustomColourTank[3], 0.9 }

    local class1  = { UF.SV.CustomColourDragonknight[1], UF.SV.CustomColourDragonknight[2], UF.SV.CustomColourDragonknight[3], 0.9} -- Dragonkight
    local class3  = { UF.SV.CustomColourNightblade[1], UF.SV.CustomColourNightblade[2], UF.SV.CustomColourNightblade[3], 0.9} -- Nightblade
    local class2  = { UF.SV.CustomColourSorcerer[1], UF.SV.CustomColourSorcerer[2], UF.SV.CustomColourSorcerer[3], 0.9} -- Sorcerer
    local class6  = { UF.SV.CustomColourTemplar[1], UF.SV.CustomColourTemplar[2], UF.SV.CustomColourTemplar[3], 0.9} -- Templar
    local class4  = { UF.SV.CustomColourWarden[1], UF.SV.CustomColourWarden[2], UF.SV.CustomColourWarden[3], 0.9} -- Warden

    local health_bg  = { 0.1*UF.SV.CustomColourHealth[1],  0.1*UF.SV.CustomColourHealth[2],  0.1*UF.SV.CustomColourHealth[3], 0.9 }
    local shield_bg  = { 0.1*UF.SV.CustomColourShield[1],  0.1*UF.SV.CustomColourShield[2],  0.1*UF.SV.CustomColourShield[3], 0.9 }
    local magicka_bg = { 0.1*UF.SV.CustomColourMagicka[1], 0.1*UF.SV.CustomColourMagicka[2], 0.1*UF.SV.CustomColourMagicka[3], 0.9 }
    local stamina_bg = { 0.1*UF.SV.CustomColourStamina[1], 0.1*UF.SV.CustomColourStamina[2], 0.1*UF.SV.CustomColourStamina[3], 0.9 }

    local dps_bg    = { 0.1*UF.SV.CustomColourDPS[1],    0.1*UF.SV.CustomColourDPS[2],    0.1*UF.SV.CustomColourDPS[3], 0.9 }
    local healer_bg = { 0.1*UF.SV.CustomColourHealer[1], 0.1*UF.SV.CustomColourHealer[2], 0.1*UF.SV.CustomColourHealer[3], 0.9 }
    local tank_bg   = { 0.1*UF.SV.CustomColourTank[1],   0.1*UF.SV.CustomColourTank[2],   0.1*UF.SV.CustomColourTank[3], 0.9 }

    local class1_bg  = { 0.1*UF.SV.CustomColourDragonknight[1], 0.1*UF.SV.CustomColourDragonknight[2], 0.1*UF.SV.CustomColourDragonknight[3], 0.9} -- Dragonkight
    local class3_bg  = { 0.1*UF.SV.CustomColourNightblade[1], 0.1*UF.SV.CustomColourNightblade[2], 0.1*UF.SV.CustomColourNightblade[3], 0.9} -- Nightblade
    local class2_bg  = { 0.1*UF.SV.CustomColourSorcerer[1], 0.1*UF.SV.CustomColourSorcerer[2], 0.1*UF.SV.CustomColourSorcerer[3], 0.9} -- Sorcerer
    local class6_bg  = { 0.1*UF.SV.CustomColourTemplar[1], 0.1*UF.SV.CustomColourTemplar[2], 0.1*UF.SV.CustomColourTemplar[3], 0.9} -- Templar
    local class4_bg  = { 0.1*UF.SV.CustomColourWarden[1], 0.1*UF.SV.CustomColourWarden[2], 0.1*UF.SV.CustomColourWarden[3], 0.9} -- Warden

    -- After colour is applied unhide frames, so player can see changes even from menu
    for _, baseName in pairs( { "player", "reticleover", "boss", "AvaPlayerTarget" } ) do
        shield[4] = ( UF.SV.CustomShieldBarSeparate and not (baseName == "boss") ) and 0.9 or ( UF.SV.ShieldAlpha / 100 )
        for i = 0, 6 do
            local unitTag = (i==0) and baseName or ( baseName .. i )
            if UF.CustomFrames[unitTag] then
                local unitFrame = UF.CustomFrames[unitTag]
                local thb = unitFrame[POWERTYPE_HEALTH] -- not a backdrop
                thb.bar:SetColor( unpack(health) )
                thb.backdrop:SetCenterColor( unpack(health_bg) )
                thb.shield:SetColor( unpack(shield) )
                if thb.shieldbackdrop then
                    thb.shieldbackdrop:SetCenterColor( unpack(shield_bg) )
                end
                if isMenu then
                    unitFrame.tlw:SetHidden( false )
                end
            end
        end
    end

    local groupSize = GetGroupSize()

    -- Variables to adjust frame when player frame is hidden in group
    local increment = false -- Once we reach a value set by Increment Marker (group tag of the player), we need to increment all further tags by +1 in order to get the correct color for them.
    local incrementMarker = 0 -- Marker -- Once we reach this value in iteration, we have to add +1 to default unitTag index for all other units.
    for _, baseName in pairs( { "SmallGroup", "RaidGroup" } ) do
        shield[4] = ( UF.SV.CustomShieldBarSeparate and not (baseName == "RaidGroup") ) and 0.9 or ( UF.SV.ShieldAlpha / 100 )

        -- Extra loop if player is excluded in Small Group Frames
        if UF.SV.GroupExcludePlayer and not (baseName == "RaidGroup") then
            -- Force increment groupTag by +1 for determining class/role if player frame is removed from display
            for i = 1, groupSize do
                if i > 4 then break end
                    local defaultUnitTag = GetGroupUnitTagByIndex(i)
                    if AreUnitsEqual(defaultUnitTag, "player") then
                    incrementMarker = i
                end
            end
        end


        for i = 1, groupSize do
            local unitTag = baseName .. i
            if UF.CustomFrames[unitTag] then

                if i == incrementMarker then increment = true end
                local defaultUnitTag
                -- Set default frame reference to +1 if Player Frame is hidden and we reach that index, otherwise, proceed as normal
                if increment then
                    defaultUnitTag = GetGroupUnitTagByIndex(i + 1)
                    if i +1 > 4 and baseName == "SmallGroup" then break end -- Bail out if we're at the end of the small group list
                else
                    defaultUnitTag = GetGroupUnitTagByIndex(i)
                end

                -- Also update control for Right Click Menu
                UF.CustomFrames[unitTag].control.defaultUnitTag = defaultUnitTag
                if UF.CustomFrames[unitTag].topInfo then UF.CustomFrames[unitTag].topInfo.defaultUnitTag = defaultUnitTag end

                local role = GetGroupMemberSelectedRole(defaultUnitTag)
                local class = GetUnitClassId(defaultUnitTag)

                local unitFrame = UF.CustomFrames[unitTag]
                local thb = unitFrame[POWERTYPE_HEALTH] -- not a backdrop

                if (groupSize <= 4 and UF.SV.ColorRoleGroup) or (groupSize > 4 and UF.SV.ColorRoleRaid) then
                    if role == 1 then
                        thb.bar:SetColor( unpack(dps) )
                        thb.backdrop:SetCenterColor( unpack(dps_bg) )
                    elseif role == 4 then
                        thb.bar:SetColor( unpack(healer) )
                        thb.backdrop:SetCenterColor( unpack(healer_bg) )
                    elseif role == 2 then
                        thb.bar:SetColor( unpack(tank) )
                        thb.backdrop:SetCenterColor( unpack(tank_bg) )
                    else
                        thb.bar:SetColor( unpack(health) )
                        thb.backdrop:SetCenterColor( unpack(health_bg) )
                    end
                elseif (groupSize <= 4 and UF.SV.ColorClassGroup) or (groupSize > 4 and UF.SV.ColorClassRaid) and class ~= 0 then
                    local class_color
                    local class_bg
                    if class == 1 then
                        class_color = class1
                        class_bg = class1_bg
                    elseif class == 2 then
                        class_color = class2
                        class_bg = class2_bg
                    elseif class == 3 then
                        class_color = class3
                        class_bg = class3_bg
                    elseif class == 4 then
                        class_color = class4
                        class_bg = class4_bg
                    elseif class == 6 then
                        class_color = class6
                        class_bg = class6_bg
                    else -- Fallback option just in case
                        class_color = health
                        class_bg = health_bg
                    end
                    thb.bar:SetColor( unpack(class_color) )
                    thb.backdrop:SetCenterColor( unpack(class_bg) )
                else
                    thb.bar:SetColor( unpack(health) )
                    thb.backdrop:SetCenterColor( unpack(health_bg) )
                end
                thb.shield:SetColor( unpack(shield) )
                if thb.shieldbackdrop then
                    thb.shieldbackdrop:SetCenterColor( unpack(shield_bg) )
                end
                if isMenu then
                    unitFrame.tlw:SetHidden( false )
                end

            end
        end
    end

    -- Player frame also requires setting of magicka and stamina bars
    if UF.CustomFrames.player then
        UF.CustomFrames.player[POWERTYPE_MAGICKA].bar:SetColor( unpack(magicka) )
        UF.CustomFrames.player[POWERTYPE_MAGICKA].backdrop:SetCenterColor( unpack(magicka_bg) )
        UF.CustomFrames.player[POWERTYPE_STAMINA].bar:SetColor( unpack(stamina) )
        UF.CustomFrames.player[POWERTYPE_STAMINA].backdrop:SetCenterColor( unpack(stamina_bg) )
    end
end

function UF.CustomFramesApplyColoursSingle(unitTag)
    local health    = { UF.SV.CustomColourHealth[1],  UF.SV.CustomColourHealth[2],  UF.SV.CustomColourHealth[3], 0.9 }
    local shield    = { UF.SV.CustomColourShield[1],  UF.SV.CustomColourShield[2],  UF.SV.CustomColourShield[3], 0 } -- .a value will be fixed in the loop
    local magicka   = { UF.SV.CustomColourMagicka[1], UF.SV.CustomColourMagicka[2], UF.SV.CustomColourMagicka[3], 0.9 }
    local stamina   = { UF.SV.CustomColourStamina[1], UF.SV.CustomColourStamina[2], UF.SV.CustomColourStamina[3], 0.9 }

    local dps       =  { UF.SV.CustomColourDPS[1],    UF.SV.CustomColourDPS[2],     UF.SV.CustomColourDPS[3], 0.9 }
    local healer    =  { UF.SV.CustomColourHealer[1], UF.SV.CustomColourHealer[2],  UF.SV.CustomColourHealer[3], 0.9 }
    local tank      =  { UF.SV.CustomColourTank[1],   UF.SV.CustomColourTank[2],    UF.SV.CustomColourTank[3], 0.9 }

    local health_bg  = { 0.1*UF.SV.CustomColourHealth[1],  0.1*UF.SV.CustomColourHealth[2],  0.1*UF.SV.CustomColourHealth[3], 0.9 }
    local shield_bg  = { 0.1*UF.SV.CustomColourShield[1],  0.1*UF.SV.CustomColourShield[2],  0.1*UF.SV.CustomColourShield[3], 0.9 }
    local magicka_bg = { 0.1*UF.SV.CustomColourMagicka[1], 0.1*UF.SV.CustomColourMagicka[2], 0.1*UF.SV.CustomColourMagicka[3], 0.9 }
    local stamina_bg = { 0.1*UF.SV.CustomColourStamina[1], 0.1*UF.SV.CustomColourStamina[2], 0.1*UF.SV.CustomColourStamina[3], 0.9 }

    local dps_bg    = { 0.1*UF.SV.CustomColourDPS[1],    0.1*UF.SV.CustomColourDPS[2],    0.1*UF.SV.CustomColourDPS[3], 0.9 }
    local healer_bg = { 0.1*UF.SV.CustomColourHealer[1], 0.1*UF.SV.CustomColourHealer[2], 0.1*UF.SV.CustomColourHealer[3], 0.9 }
    local tank_bg   = { 0.1*UF.SV.CustomColourTank[1],   0.1*UF.SV.CustomColourTank[2],   0.1*UF.SV.CustomColourTank[3], 0.9 }

    local groupSize = GetGroupSize()

    if (groupSize <= 4 and UF.SV.ColorRoleGroup) or (groupSize > 4 and UF.SV.ColorRoleRaid) then
        if UF.CustomFrames[unitTag] then
            local role = GetGroupMemberSelectedRole(unitTag)
            local unitFrame = UF.CustomFrames[unitTag]
            local thb = unitFrame[POWERTYPE_HEALTH] -- not a backdrop
            if role == 1 then
                thb.bar:SetColor( unpack(dps) )
                thb.backdrop:SetCenterColor( unpack(dps_bg) )
            elseif role == 4 then
                thb.bar:SetColor( unpack(healer) )
                thb.backdrop:SetCenterColor( unpack(healer_bg) )
            elseif role == 2 then
                thb.bar:SetColor( unpack(tank) )
                thb.backdrop:SetCenterColor( unpack(tank_bg) )
            else
                if UF.SV.FrameColorReaction and unitTag == "reticleover" then
                    thb.bar:SetColor( unpack(reactioncolor) )
                    thb.backdrop:SetCenterColor( unpack(reactioncolor_bg) )
                else
                    thb.bar:SetColor( unpack(health) )
                    thb.backdrop:SetCenterColor( unpack(health_bg) )
                end
            end
        end
    end
end

function UF.CustomFramesApplyReactionColor()
    local reactionColor = {
        [UNIT_REACTION_PLAYER_ALLY] = { UF.SV.CustomColourPlayer[1], UF.SV.CustomColourPlayer[2], UF.SV.CustomColourPlayer[3], 0.9 },
        [UNIT_REACTION_DEFAULT]     = { UF.SV.CustomColourFriendly[1], UF.SV.CustomColourFriendly[2], UF.SV.CustomColourFriendly[3], 0.9 },
        [UNIT_REACTION_FRIENDLY]        = { UF.SV.CustomColourFriendly[1], UF.SV.CustomColourFriendly[2], UF.SV.CustomColourFriendly[3], 0.9 },
        [UNIT_REACTION_NPC_ALLY]        = { UF.SV.CustomColourFriendly[1], UF.SV.CustomColourFriendly[2], UF.SV.CustomColourFriendly[3], 0.9 },
        [UNIT_REACTION_HOSTILE]     = { UF.SV.CustomColourHostile[1], UF.SV.CustomColourHostile[2], UF.SV.CustomColourHostile[3], 0.9 },
        [UNIT_REACTION_NEUTRAL]     = { UF.SV.CustomColourNeutral[1], UF.SV.CustomColourNeutral[2], UF.SV.CustomColourNeutral[3], 0.9 },
    }

    local reactionBackground = {
        [UNIT_REACTION_PLAYER_ALLY] = { 0.1*UF.SV.CustomColourPlayer[1],   0.1*UF.SV.CustomColourPlayer[2],   0.1*UF.SV.CustomColourPlayer[3], 0.9 },
        [UNIT_REACTION_DEFAULT]     = { 0.1*UF.SV.CustomColourFriendly[1],   0.1*UF.SV.CustomColourFriendly[2],   0.1*UF.SV.CustomColourFriendly[3], 0.9 },
        [UNIT_REACTION_FRIENDLY]        = { 0.1*UF.SV.CustomColourFriendly[1],   0.1*UF.SV.CustomColourFriendly[2],   0.1*UF.SV.CustomColourFriendly[3], 0.9 },
        [UNIT_REACTION_NPC_ALLY]        = { 0.1*UF.SV.CustomColourFriendly[1],   0.1*UF.SV.CustomColourFriendly[2],   0.1*UF.SV.CustomColourFriendly[3], 0.9 },
        [UNIT_REACTION_HOSTILE]     = { 0.1*UF.SV.CustomColourHostile[1],   0.1*UF.SV.CustomColourHostile[2],   0.1*UF.SV.CustomColourHostile[3], 0.9 },
        [UNIT_REACTION_NEUTRAL]     = { 0.1*UF.SV.CustomColourNeutral[1],   0.1*UF.SV.CustomColourNeutral[2],   0.1*UF.SV.CustomColourNeutral[3], 0.9 },
    }

    if UF.CustomFrames["reticleover"] then
        local unitFrame = UF.CustomFrames["reticleover"]
        local thb = unitFrame[POWERTYPE_HEALTH] -- not a backdrop

        local reactioncolor
        local reactioncolor_bg
        if IsUnitInvulnerableGuard("reticleover") then
            reactioncolor = { UF.SV.CustomColourGuard[1], UF.SV.CustomColourGuard[2], UF.SV.CustomColourGuard[3], 0.9 }
            reactioncolor_bg = { 0.1*UF.SV.CustomColourGuard[1],   0.1*UF.SV.CustomColourGuard[2],   0.1*UF.SV.CustomColourGuard[3], 0.9 }
        else
            reactioncolor = reactionColor[GetUnitReaction("reticleover")]
            reactioncolor_bg = reactionBackground[GetUnitReaction("reticleover")]
        end

        thb.bar:SetColor( unpack(reactioncolor) )
        thb.backdrop:SetCenterColor( unpack(reactioncolor_bg) )
    end
end

-- Apply selected texture for all known bars on custom unit frames
function UF.CustomFramesApplyTexture()
    local texture = LUIE.StatusbarTextures[UF.SV.CustomTexture]

    -- After texture is applied unhide frames, so player can see changes even from menu
    if UF.CustomFrames.player then
        UF.CustomFrames.player[POWERTYPE_HEALTH].backdrop:SetCenterTexture(texture)
        UF.CustomFrames.player[POWERTYPE_HEALTH].bar:SetTexture(texture)
        if UF.CustomFrames.player[POWERTYPE_HEALTH].shieldbackdrop then
            UF.CustomFrames.player[POWERTYPE_HEALTH].shieldbackdrop:SetCenterTexture(texture)
        end
        UF.CustomFrames.player[POWERTYPE_HEALTH].shield:SetTexture(texture)
        UF.CustomFrames.player[POWERTYPE_MAGICKA].backdrop:SetCenterTexture(texture)
        UF.CustomFrames.player[POWERTYPE_MAGICKA].bar:SetTexture(texture)
        UF.CustomFrames.player[POWERTYPE_STAMINA].backdrop:SetCenterTexture(texture)
        UF.CustomFrames.player[POWERTYPE_STAMINA].bar:SetTexture(texture)
        UF.CustomFrames.player.alternative.backdrop:SetCenterTexture(texture)
        UF.CustomFrames.player.alternative.bar:SetTexture(texture)
        UF.CustomFrames.player.alternative.enlightenment:SetTexture(texture)
        UF.CustomFrames.player.tlw:SetHidden( false )
    end
    if UF.CustomFrames.reticleover then
        UF.CustomFrames.reticleover[POWERTYPE_HEALTH].backdrop:SetCenterTexture(texture)
        UF.CustomFrames.reticleover[POWERTYPE_HEALTH].bar:SetTexture(texture)
        if UF.CustomFrames.reticleover[POWERTYPE_HEALTH].shieldbackdrop then
            UF.CustomFrames.reticleover[POWERTYPE_HEALTH].shieldbackdrop:SetCenterTexture(texture)
        end
        UF.CustomFrames.reticleover[POWERTYPE_HEALTH].shield:SetTexture(texture)
        UF.CustomFrames.reticleover.tlw:SetHidden( false )
    end
    if UF.CustomFrames.AvaPlayerTarget then
        UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].backdrop:SetCenterTexture(texture)
        UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].bar:SetTexture(texture)
        if UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].shieldbackdrop then
            UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].shieldbackdrop:SetCenterTexture(texture)
        end
        UF.CustomFrames.AvaPlayerTarget[POWERTYPE_HEALTH].shield:SetTexture(texture)
        UF.CustomFrames.AvaPlayerTarget.tlw:SetHidden( false )
    end
    if UF.CustomFrames.SmallGroup1 then
        for i = 1, 4 do
            local unitTag = "SmallGroup" .. i
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop:SetCenterTexture(texture)
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].bar:SetTexture(texture)
            if UF.CustomFrames[unitTag][POWERTYPE_HEALTH].shieldbackdrop then
                UF.CustomFrames[unitTag][POWERTYPE_HEALTH].shieldbackdrop:SetCenterTexture(texture)
            end
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].shield:SetTexture(texture)
        end
        UF.CustomFrames.SmallGroup1.tlw:SetHidden( false )
    end
    if UF.CustomFrames.RaidGroup1 then
        for i = 1, 24 do
            local unitTag = "RaidGroup" .. i
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop:SetCenterTexture(texture)
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].bar:SetTexture(texture)
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].shield:SetTexture(texture)
        end
        UF.CustomFrames.RaidGroup1.tlw:SetHidden( false )
    end
    if UF.CustomFrames.boss1 then
        for i = 1, 6 do
            local unitTag = "boss" .. i
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].backdrop:SetCenterTexture(texture)
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].bar:SetTexture(texture)
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].shield:SetTexture(texture)
        end
        UF.CustomFrames.boss1.tlw:SetHidden( false )
    end
end

-- Apply selected font for all known label on default unit frames
function UF.DefaultFramesApplyFont(unitTag)
    -- First try selecting font face
    local fontName = LUIE.Fonts[UF.SV.DefaultFontFace]
    if not fontName or fontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        fontName = "$(BOLD_FONT)"
    end

    local fontStyle = ( UF.SV.DefaultFontStyle and UF.SV.DefaultFontStyle ~= "" ) and UF.SV.DefaultFontStyle or "soft-shadow-thick"
    local fontSize = ( UF.SV.DefaultFontSize and UF.SV.DefaultFontSize > 0 ) and UF.SV.DefaultFontSize or 16

    local __applyFont = function(unitTag)
        if g_DefaultFrames[unitTag] then
            local unitFrame = g_DefaultFrames[unitTag]
            for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA} ) do
                if unitFrame[powerType] then
                    unitFrame[powerType].label:SetFont( strformat( "<<1>>|<<2>>|<<3>>", fontName, fontSize, fontStyle ) )
                end
            end
        end
    end

    -- Apply setting only for one requested unitTag
    if unitTag then
        __applyFont(unitTag)

    -- Otherwise do it for all possible unitTags
    else
        __applyFont("player")
        __applyFont("reticleover")
        for i = 0, 24 do
            __applyFont("group" .. i)
        end
    end
end

-- Reapplies colour for default unit frames extender module labels
function UF.DefaultFramesApplyColour()
    -- Helper function
    local __applyColour = function(unitTag)
        if g_DefaultFrames[unitTag] then
            local unitFrame = g_DefaultFrames[unitTag]
            for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA} ) do
                if unitFrame[powerType] then
                    unitFrame[powerType].colour = UF.SV.DefaultTextColour
                    unitFrame[powerType].label:SetColor( UF.SV.DefaultTextColour[1], UF.SV.DefaultTextColour[2], UF.SV.DefaultTextColour[3] )
                end
            end
        end
    end

    -- Apply setting for all possible unitTags
    __applyColour("player")
    __applyColour("reticleover")
    for i = 0, 24 do
        __applyColour("group" .. i)
    end
end

-- Apply selected font for all known label on custom unit frames
function UF.CustomFramesApplyFont()
    -- First try selecting font face
    local fontName = LUIE.Fonts[UF.SV.CustomFontFace]
    if not fontName or fontName == "" then
        printToChat(GetString(SI_LUIE_ERROR_FONT), true)
        fontName = "$(MEDIUM_FONT)"
    end

    local fontStyle = ( UF.SV.CustomFontStyle and UF.SV.CustomFontStyle ~= "" ) and UF.SV.CustomFontStyle or "soft-shadow-thin"
    local sizeCaption = ( UF.SV.CustomFontOther and UF.SV.CustomFontOther > 0 ) and UF.SV.CustomFontOther or 16
    local sizeBars = ( UF.SV.CustomFontBars and UF.SV.CustomFontBars > 0 ) and UF.SV.CustomFontBars or 14

    local __mkFont = function(size) return strformat( "<<1>>|<<2>>|<<3>>", fontName, size, fontStyle ) end

    -- After fonts is applied unhide frames, so player can see changes even from menu
    for _, baseName in pairs( { "player", "reticleover", "SmallGroup", "RaidGroup", "boss", "AvaPlayerTarget" } ) do
        for i = 0, 24 do
            local unitTag = (i==0) and baseName or ( baseName .. i )
            if UF.CustomFrames[unitTag] then
                local unitFrame = UF.CustomFrames[unitTag]
                if unitFrame.name then
                    unitFrame.name:SetFont( __mkFont( (unitFrame.name:GetParent() == unitFrame.topInfo) and sizeCaption or sizeBars ) )
                end
                if unitFrame.level then
                    unitFrame.level:SetFont( __mkFont(sizeCaption) )
                end
                if unitFrame.className then
                    unitFrame.className:SetFont( __mkFont(sizeCaption) )
                end
                if unitFrame.title then
                    unitFrame.title:SetFont( __mkFont(sizeCaption) )
                end
                if unitFrame.avaRank then
                    unitFrame.avaRank:SetFont( __mkFont(sizeCaption) )
                end
                if unitFrame.dead then
                    unitFrame.dead:SetFont( __mkFont(sizeBars) )
                end
                for _, powerType in pairs( {POWERTYPE_HEALTH, POWERTYPE_MAGICKA, POWERTYPE_STAMINA} ) do
                    if unitFrame[powerType] then
                        if unitFrame[powerType].label    then
                            unitFrame[powerType].label:SetFont( __mkFont(sizeBars) )
                        end
                        if unitFrame[powerType].labelOne then
                            unitFrame[powerType].labelOne:SetFont( __mkFont(sizeBars) )
                        end
                        if unitFrame[powerType].labelTwo then
                            unitFrame[powerType].labelTwo:SetFont( __mkFont(sizeBars) )
                        end
                    end
                end
                if i == 0 or i == 1 then
                    unitFrame.tlw:SetHidden( false )
                end
            end
        end
    end

    -- Adjust height of Name and Title labels on Player, Target and SmallGroup frames
    for _, baseName in pairs( { "player", "reticleover", "SmallGroup", "AvaPlayerTarget" } ) do
        for i = 0, 4 do
            local unitTag = (i==0) and baseName or ( baseName .. i )
            if UF.CustomFrames[unitTag] then
                local unitFrame = UF.CustomFrames[unitTag]
                -- Name should always be present
                unitFrame.name:SetHeight( 2 * sizeCaption )
                local nameHeight = unitFrame.name:GetTextHeight()
                -- Update height of name container (topInfo)
                unitFrame.topInfo:SetHeight( nameHeight )
                -- LevelIcon also should exit
                if unitFrame.levelIcon then
                    unitFrame.levelIcon:SetDimensions( nameHeight, nameHeight )
                    unitFrame.levelIcon:ClearAnchors()
                    unitFrame.levelIcon:SetAnchor( LEFT, unitFrame.topInfo, LEFT, unitFrame.name:GetTextWidth()+1, 0 )
                end
                -- ClassIcon too - it looks better if a little bigger
                unitFrame.classIcon:SetDimensions( nameHeight+2, nameHeight+2 )
                -- FriendIcon if exist - same idea
                if unitFrame.friendIcon then
                    unitFrame.friendIcon:SetDimensions( nameHeight+2, nameHeight+2 )
                    unitFrame.friendIcon:ClearAnchors()
                    unitFrame.friendIcon:SetAnchor( RIGHT, unitFrame.classIcon, LEFT, nameHeight/6, 0)
                end
                -- botInfo contain alt bar or title/ava
                if unitFrame.botInfo then
                    unitFrame.botInfo:SetHeight( nameHeight )
                    -- Alternative bar present on Player
                    if unitFrame.alternative then
                        unitFrame.alternative.backdrop:SetHeight( mathceil( nameHeight / 3 )+2 )
                        unitFrame.alternative.icon:SetDimensions( nameHeight, nameHeight )
                    end
                    -- Title present only on Target
                    if unitFrame.title then
                        unitFrame.title:SetHeight( 2 * sizeCaption )
                    end
                end
                if unitFrame.buffAnchor then
                    unitFrame.buffAnchor:SetHeight( nameHeight )
                end
            end
        end
    end
end

-- Set dimensions of custom group frame and anchors or raid group members
function UF.CustomFramesApplyLayoutPlayer(unhide)
    -- Player frame
    if UF.CustomFrames.player then
        local player = UF.CustomFrames.player

        local phb = player[POWERTYPE_HEALTH]  -- Not a backdrop
        local pmb = player[POWERTYPE_MAGICKA] -- Not a backdrop
        local psb = player[POWERTYPE_STAMINA] -- Not a backdrop
        local alt = player.alternative        -- Not a backdrop

        if UF.SV.PlayerFrameOptions == 1 then
            if not UF.SV.HideBarMagicka and not UF.SV.HideBarStamina then
                player.tlw:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + UF.SV.PlayerBarHeightMagicka + UF.SV.PlayerBarHeightStamina + 2*UF.SV.PlayerBarSpacing + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
                player.control:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + UF.SV.PlayerBarHeightMagicka + UF.SV.PlayerBarHeightStamina + 2*UF.SV.PlayerBarSpacing + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
            elseif UF.SV.HideBarMagicka and not UF.SV.HideBarStamina then
                player.tlw:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + UF.SV.PlayerBarHeightStamina + UF.SV.PlayerBarSpacing + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
                player.control:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + UF.SV.PlayerBarHeightStamina + UF.SV.PlayerBarSpacing + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
            elseif UF.SV.HideBarStamina and not UF.SV.HideBarMagicka then
                player.tlw:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + UF.SV.PlayerBarHeightMagicka + UF.SV.PlayerBarSpacing + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
                player.control:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + UF.SV.PlayerBarHeightMagicka + UF.SV.PlayerBarSpacing + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
            else
                player.tlw:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
                player.control:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
            end

            player.topInfo:SetWidth( UF.SV.PlayerBarWidth )
            player.botInfo:SetWidth( UF.SV.PlayerBarWidth )
            player.buffAnchor:SetWidth( UF.SV.PlayerBarWidth )

            player.name:SetWidth( UF.SV.PlayerBarWidth-90 )
            player.buffs:SetWidth( UF.SV.PlayerBarWidth )
            player.debuffs:SetWidth( UF.SV.PlayerBarWidth )

            player.levelIcon:ClearAnchors()
            player.levelIcon:SetAnchor( LEFT, player.topInfo, LEFT, player.name:GetTextWidth()+1, 0 )

            player.name:SetHidden( not UF.SV.PlayerEnableYourname )
            player.level:SetHidden( not UF.SV.PlayerEnableYourname )
            player.levelIcon:SetHidden( not UF.SV.PlayerEnableYourname )
            player.classIcon:SetHidden( not UF.SV.PlayerEnableYourname )

            local altW = mathceil(UF.SV.PlayerBarWidth * 2/3)

            phb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth )

            pmb.backdrop:ClearAnchors()
            if not UF.SV.HideBarMagicka then
                if phb.shieldbackdrop then
                    phb.shieldbackdrop:ClearAnchors()
                    phb.shieldbackdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, 0 )
                    phb.shieldbackdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.CustomShieldBarHeight )
                    pmb.backdrop:SetAnchor( TOP, phb.shieldbackdrop, BOTTOM, 0, UF.SV.PlayerBarSpacing )
                else
                    pmb.backdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, UF.SV.PlayerBarSpacing )
                end
                pmb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightMagicka )
            else
                if phb.shieldbackdrop then
                    phb.shieldbackdrop:ClearAnchors()
                    phb.shieldbackdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, 0 )
                    phb.shieldbackdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.CustomShieldBarHeight )
                end
            end

            psb.backdrop:ClearAnchors()
            if not UF.SV.HideBarStamina then
                if not UF.SV.HideBarMagicka then
                    psb.backdrop:SetAnchor( TOP, pmb.backdrop, BOTTOM, 0, UF.SV.PlayerBarSpacing )
                else
                    if phb.shieldbackdrop then
                        psb.backdrop:SetAnchor( TOP, phb.shieldbackdrop, BOTTOM, 0, UF.SV.PlayerBarSpacing )
                    else
                        psb.backdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, UF.SV.PlayerBarSpacing )
                    end
                end
                psb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightStamina )
            end
            alt.backdrop:SetWidth( altW )

            phb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightHealth-2 )
            phb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightHealth-2 )
            if not UF.SV.HideLabelMagicka then
                pmb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightMagicka-2 )
                pmb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightMagicka-2 )
            end
            if not UF.SV.HideLabelStamina then
                psb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightStamina-2 )
                psb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightStamina-2 )
            end
        elseif UF.SV.PlayerFrameOptions == 2 then
            player.tlw:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
            player.control:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )

            player.topInfo:SetWidth( UF.SV.PlayerBarWidth )
            player.botInfo:SetWidth( UF.SV.PlayerBarWidth )
            player.buffAnchor:SetWidth( UF.SV.PlayerBarWidth )

            player.name:SetWidth( UF.SV.PlayerBarWidth-90 )
            player.buffs:SetWidth( 1000 )
            player.debuffs:SetWidth( 1000 )

            player.levelIcon:ClearAnchors()
            player.levelIcon:SetAnchor( LEFT, player.topInfo, LEFT, player.name:GetTextWidth()+1, 0 )

            player.name:SetHidden( not UF.SV.PlayerEnableYourname )
            player.level:SetHidden( not UF.SV.PlayerEnableYourname )
            player.levelIcon:SetHidden( not UF.SV.PlayerEnableYourname )
            player.classIcon:SetHidden( not UF.SV.PlayerEnableYourname )

            local altW = mathceil(UF.SV.PlayerBarWidth * 2/3)

            phb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth )

            pmb.backdrop:ClearAnchors()
            if not UF.SV.HideBarMagicka then
                if phb.shieldbackdrop then
                    phb.shieldbackdrop:ClearAnchors()
                    phb.shieldbackdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, 0 )
                    phb.shieldbackdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.CustomShieldBarHeight )
                end
                pmb.backdrop:SetAnchor( RIGHT, phb.backdrop, LEFT, -UF.SV.AdjustMagickaHPos,  UF.SV.AdjustMagickaVPos )
                pmb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightMagicka )
            else
                if phb.shieldbackdrop then
                    phb.shieldbackdrop:ClearAnchors()
                    phb.shieldbackdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, 0 )
                    phb.shieldbackdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.CustomShieldBarHeight )
                end
            end

            psb.backdrop:ClearAnchors()
            if not UF.SV.HideBarStamina then
                psb.backdrop:SetAnchor( LEFT, phb.backdrop, RIGHT, UF.SV.AdjustStaminaHPos,  UF.SV.AdjustStaminaVPos )
                psb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightStamina )
            end
            alt.backdrop:SetWidth( altW )

            phb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightHealth-2 )
            phb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightHealth-2 )
            if not UF.SV.HideLabelMagicka then
                pmb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightMagicka-2 )
                pmb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightMagicka-2 )
            end
            if not UF.SV.HideLabelStamina then
                psb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightStamina-2 )
                psb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightStamina-2 )
            end
        else
            player.tlw:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
            player.control:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth + (phb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )

            player.topInfo:SetWidth( UF.SV.PlayerBarWidth )
            player.botInfo:SetWidth( UF.SV.PlayerBarWidth )
            player.buffAnchor:SetWidth( UF.SV.PlayerBarWidth )

            player.name:SetWidth( UF.SV.PlayerBarWidth-90 )
            player.buffs:SetWidth( 1000 )
            player.debuffs:SetWidth( 1000 )

            player.levelIcon:ClearAnchors()
            player.levelIcon:SetAnchor( LEFT, player.topInfo, LEFT, player.name:GetTextWidth()+1, 0 )

            player.name:SetHidden( not UF.SV.PlayerEnableYourname )
            player.level:SetHidden( not UF.SV.PlayerEnableYourname )
            player.levelIcon:SetHidden( not UF.SV.PlayerEnableYourname )
            player.classIcon:SetHidden( not UF.SV.PlayerEnableYourname )

            local altW = mathceil(UF.SV.PlayerBarWidth * 2/3)

            phb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightHealth )

            pmb.backdrop:ClearAnchors()
            if not UF.SV.HideBarMagicka then
                if phb.shieldbackdrop then
                    phb.shieldbackdrop:ClearAnchors()
                    phb.shieldbackdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, 0 )
                    phb.shieldbackdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.CustomShieldBarHeight )
                    pmb.backdrop:SetAnchor( TOP, phb.shieldbackdrop, BOTTOMLEFT, 0, UF.SV.PlayerBarSpacing )
                else
                    pmb.backdrop:SetAnchor( TOP, phb.backdrop, BOTTOMLEFT, 0, UF.SV.PlayerBarSpacing )
                end
                pmb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightMagicka )
            else
                if phb.shieldbackdrop then
                    phb.shieldbackdrop:ClearAnchors()
                    phb.shieldbackdrop:SetAnchor( TOP, phb.backdrop, BOTTOM, 0, 0 )
                    phb.shieldbackdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.CustomShieldBarHeight )
                end
            end

            psb.backdrop:ClearAnchors()
            if not UF.SV.HideBarStamina then
                if phb.shieldbackdrop then
                    psb.backdrop:SetAnchor( TOP, phb.shieldbackdrop, BOTTOMRIGHT, 0, UF.SV.PlayerBarSpacing )
                else
                    psb.backdrop:SetAnchor( TOP, phb.backdrop, BOTTOMRIGHT, 0, UF.SV.PlayerBarSpacing )
                end
                psb.backdrop:SetDimensions( UF.SV.PlayerBarWidth, UF.SV.PlayerBarHeightStamina )
            end

            player.botInfo:SetWidth( UF.SV.PlayerBarWidth )
            player.buffAnchor:SetWidth( UF.SV.PlayerBarWidth )
            alt.backdrop:SetWidth( altW )

            phb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightHealth-2 )
            phb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightHealth-2 )
            if not UF.SV.HideLabelMagicka then
                pmb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightMagicka-2 )
                pmb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightMagicka-2 )
            end
            if not UF.SV.HideLabelStamina then
                psb.labelOne:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightStamina-2 )
                psb.labelTwo:SetDimensions( UF.SV.PlayerBarWidth-50, UF.SV.PlayerBarHeightStamina-2 )
            end
        end
        if unhide then
            player.tlw:SetHidden( false )
        end
    end

    -- Target frame
    if UF.CustomFrames.reticleover then
        local target = UF.CustomFrames.reticleover

        local thb = target[POWERTYPE_HEALTH] -- Not a backdrop

        target.tlw:SetDimensions( UF.SV.TargetBarWidth, UF.SV.TargetBarHeight + (thb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
        target.control:SetDimensions( UF.SV.TargetBarWidth, UF.SV.TargetBarHeight + (thb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
        target.topInfo:SetWidth( UF.SV.TargetBarWidth )
        target.botInfo:SetWidth( UF.SV.TargetBarWidth )
        target.buffAnchor:SetWidth( UF.SV.TargetBarWidth )

        target.name:SetWidth( UF.SV.TargetBarWidth-50 )
        target.title:SetWidth( UF.SV.TargetBarWidth-50 )

        if UF.SV.PlayerFrameOptions == 1 then
            target.buffs:SetWidth( UF.SV.TargetBarWidth )
            target.debuffs:SetWidth( UF.SV.TargetBarWidth )
        else
            target.buffs:SetWidth( 1000 )
            target.debuffs:SetWidth( 1000 )
        end

        if not UF.SV.TargetEnableTitle and not UF.SV.TargetEnableRank then
            target.title:SetHidden(true)
        else
            target.title:SetHidden(false)
        end
        target.avaRank:SetHidden( not UF.SV.TargetEnableRankIcon )
        target.avaRankIcon:SetHidden( not UF.SV.TargetEnableRankIcon )

        local enable
        if (not UF.SV.TargetEnableTitle and not UF.SV.TargetEnableRank and not UF.SV.TargetEnableRankIcon) then
            enable = false
        else
            enable = true
        end

        if UF.SV.PlayerFrameOptions == 1 then
            target.buffs:ClearAnchors()
            target.buffs:SetAnchor( TOP, not enable and target.control or target.buffAnchor, BOTTOM, 0, 5 )
        else
            target.debuffs:ClearAnchors()
            target.debuffs:SetAnchor( TOP, not enable and target.control or target.buffAnchor, BOTTOM, 0, 5 )
        end

        target.levelIcon:ClearAnchors()
        target.levelIcon:SetAnchor( LEFT, target.topInfo, LEFT, target.name:GetTextWidth()+1, 0 )

        target.skull:SetDimensions( 2*UF.SV.TargetBarHeight, 2*UF.SV.TargetBarHeight )

        thb.backdrop:SetDimensions( UF.SV.TargetBarWidth, UF.SV.TargetBarHeight )
        if thb.shieldbackdrop then
            thb.shieldbackdrop:ClearAnchors()
            thb.shieldbackdrop:SetAnchor( TOP, thb.backdrop, BOTTOM, 0, 0 )
            thb.shieldbackdrop:SetDimensions( UF.SV.TargetBarWidth, UF.SV.CustomShieldBarHeight )
        end

        thb.labelOne:SetDimensions( UF.SV.TargetBarWidth-50, UF.SV.TargetBarHeight-2 )
        thb.labelTwo:SetDimensions( UF.SV.TargetBarWidth-50, UF.SV.TargetBarHeight-2 )

        if unhide then
            target.tlw:SetHidden(false)
            target.control:SetHidden(false)
        end
    end

    -- Another Target frame (for PvP)
    if UF.CustomFrames.AvaPlayerTarget then
        local target = UF.CustomFrames.AvaPlayerTarget

        local thb = target[POWERTYPE_HEALTH] -- Not a backdrop

        target.tlw:SetDimensions( UF.SV.AvaTargetBarWidth, UF.SV.AvaTargetBarHeight + (thb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
        target.control:SetDimensions( UF.SV.AvaTargetBarWidth, UF.SV.AvaTargetBarHeight + (thb.shieldbackdrop and UF.SV.CustomShieldBarHeight or 0) )
        target.topInfo:SetWidth( UF.SV.AvaTargetBarWidth )
        target.botInfo:SetWidth( UF.SV.AvaTargetBarWidth )
        target.buffAnchor:SetWidth( UF.SV.AvaTargetBarWidth )

        target.name:SetWidth( UF.SV.AvaTargetBarWidth-50 )

        thb.backdrop:SetDimensions( UF.SV.AvaTargetBarWidth, UF.SV.AvaTargetBarHeight )
        if thb.shieldbackdrop then
            thb.shieldbackdrop:ClearAnchors()
            thb.shieldbackdrop:SetAnchor( TOP, thb.backdrop, BOTTOM, 0, 0 )
            thb.shieldbackdrop:SetDimensions( UF.SV.AvaTargetBarWidth, UF.SV.CustomShieldBarHeight )
        end

        thb.label:SetHeight( UF.SV.AvaTargetBarHeight-2 )
        thb.labelOne:SetHeight( UF.SV.AvaTargetBarHeight-2 )
        thb.labelTwo:SetHeight( UF.SV.AvaTargetBarHeight-2 )

        if unhide then
            target.tlw:SetHidden(false)
            target.control:SetHidden(false)
        end
    end
end

-- Set dimensions of custom group frame and anchors or raid group members
function UF.CustomFramesApplyLayoutGroup(unhide)
    if not UF.CustomFrames.SmallGroup1 then
        return
    end

    local groupBarHeight = UF.SV.GroupBarHeight
    if UF.SV.CustomShieldBarSeparate then
        groupBarHeight = groupBarHeight + UF.SV.CustomShieldBarHeight
    end

    local group = UF.CustomFrames.SmallGroup1.tlw
    group:SetDimensions( UF.SV.GroupBarWidth, groupBarHeight*4 + UF.SV.GroupBarSpacing*3.5 )

    for i = 1, 4 do
        local unitFrame = UF.CustomFrames["SmallGroup" .. i]
        local unitTag = GetGroupUnitTagByIndex(i)

        local ghb = unitFrame[POWERTYPE_HEALTH] -- Not a backdrop

        unitFrame.control:ClearAnchors()
        unitFrame.control:SetAnchor( TOPLEFT, group, TOPLEFT, 0, 0.5*UF.SV.GroupBarSpacing + (groupBarHeight + UF.SV.GroupBarSpacing)*(i-1) )
        unitFrame.control:SetDimensions(UF.SV.GroupBarWidth, groupBarHeight)
        unitFrame.topInfo:SetWidth( UF.SV.GroupBarWidth-5 )

        unitFrame.levelIcon:ClearAnchors()

        if IsUnitGroupLeader(unitTag) then
            unitFrame.name:SetDimensions(UF.SV.GroupBarWidth - 137)
            unitFrame.name:SetAnchor ( LEFT, TopInfo, LEFT, 22, 0)
            unitFrame.levelIcon:SetAnchor( LEFT, unitFrame.topInfo, LEFT, unitFrame.name:GetTextWidth()+23, 0 )
            unitFrame.leader:SetTexture(leaderIcons[1])
        else
            unitFrame.name:SetDimensions(UF.SV.GroupBarWidth - 115)
            unitFrame.name:SetAnchor ( LEFT, TopInfo, LEFT, 0, 0)
            unitFrame.levelIcon:SetAnchor( LEFT, unitFrame.topInfo, LEFT, unitFrame.name:GetTextWidth()+1, 0 )
            unitFrame.leader:SetTexture(leaderIcons[0])
        end

        ghb.backdrop:SetDimensions(UF.SV.GroupBarWidth, UF.SV.GroupBarHeight)
        if ghb.shieldbackdrop then
            ghb.shieldbackdrop:ClearAnchors()
            ghb.shieldbackdrop:SetAnchor( TOP, ghb.backdrop, BOTTOM, 0, 0 )
            ghb.shieldbackdrop:SetDimensions( UF.SV.GroupBarWidth, UF.SV.CustomShieldBarHeight )
        end

        local role = GetGroupMemberSelectedRole(unitTag)

        -- First HP Label
        if UF.SV.RoleIconSmallGroup and role then
            ghb.labelOne:SetDimensions(UF.SV.GroupBarWidth-52, UF.SV.GroupBarHeight-2)
            ghb.labelOne:SetAnchor ( LEFT, phb, LEFT, 25, 0 )
            unitFrame.dead:ClearAnchors()
            unitFrame.dead:SetAnchor ( LEFT, phb, LEFT, 25, 0 )
        else
            ghb.labelOne:SetDimensions(UF.SV.GroupBarWidth-72, UF.SV.GroupBarHeight-2)
            ghb.labelOne:SetAnchor ( LEFT, phb, LEFT, 5, 0 )
            unitFrame.dead:ClearAnchors()
            unitFrame.dead:SetAnchor ( LEFT, phb, LEFT, 5, 0 )
        end
        unitFrame.roleIcon:SetHidden (not UF.SV.RoleIconSmallGroup)

        -- Second HP Label
        ghb.labelTwo:SetDimensions(UF.SV.GroupBarWidth-50, UF.SV.GroupBarHeight-2)
    end

    if unhide then
        group:SetHidden( false )
    end
end

-- Set dimensions of custom raid frame and anchors or raid group members
function UF.CustomFramesApplyLayoutRaid(unhide)
    if not UF.CustomFrames.RaidGroup1 then
        return
    end

    local itemsPerColumn =
        ( UF.SV.RaidLayout == "6 x 4" ) and 4 or
        ( UF.SV.RaidLayout == "4 x 6" ) and 6 or
        ( UF.SV.RaidLayout == "3 x 8" ) and 8 or
        ( UF.SV.RaidLayout == "2 x 12" ) and 12 or
        24

    local spacerHeight = 3
    local spacersPerColumn = { [4] = 1, [6] = 1.5, [8] = 2, [12] = 3, [24] = 6 }

    local raid = UF.CustomFrames.RaidGroup1.tlw

    raid:SetDimensions( UF.SV.RaidBarWidth * (24/itemsPerColumn) + (UF.SV.RaidSpacers and spacerHeight*(itemsPerColumn/4) or 0), UF.SV.RaidBarHeight * itemsPerColumn )

    -- For preview let us consider that large raid consists of 2 groups of 12 players, and display 2 independent preview backdrops
    -- They do not overlap, except for the case of '3 x 8' layout
    local groupWidth = UF.SV.RaidBarWidth * ( itemsPerColumn == 24 and 1 or mathfloor(0.5 + 12/itemsPerColumn) )
    local groupHeight = UF.SV.RaidBarHeight * mathmin(12,itemsPerColumn)

    raid.preview:SetDimensions( groupWidth, groupHeight )
    raid.preview2:SetDimensions( groupWidth, groupHeight )
    -- raid.preview is already anchored to TOPLEFT,TOPLEFT,0,0
    raid.preview2:ClearAnchors()
    raid.preview2:SetAnchor(TOPLEFT, raid, TOPLEFT, UF.SV.RaidBarWidth*mathfloor(12/itemsPerColumn), UF.SV.RaidBarHeight*( itemsPerColumn == 24 and 12 or 0 ) )

    local column = 0    -- 0,1,2,3,4,5
    local row = 0       -- 1,2,3,...,24
    for i = 1, 24 do
        if row == itemsPerColumn then
            column = column + 1
            row = 1
        else
            row = row + 1
        end

        local unitFrame = UF.CustomFrames["RaidGroup" .. i]
        local unitTag = GetGroupUnitTagByIndex(i)

        unitFrame.control:ClearAnchors()
        unitFrame.control:SetAnchor( TOPLEFT, raid, TOPLEFT, UF.SV.RaidBarWidth*column, UF.SV.RaidBarHeight*(row-1) + (UF.SV.RaidSpacers and spacerHeight*(mathfloor((i-1)/4)-mathfloor(column*itemsPerColumn/4)) or 0) )
        unitFrame.control:SetDimensions( UF.SV.RaidBarWidth, UF.SV.RaidBarHeight )

        local role = GetGroupMemberSelectedRole(unitTag)

        -- If we have icons set to display
        if UF.SV.RaidIconOptions > 1 then
            if UF.SV.RaidIconOptions == 2 then -- Class Icon Only
                unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
                unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
                unitFrame.roleIcon:SetHidden (true)
                unitFrame.classIcon:SetHidden (false)
            end
            if UF.SV.RaidIconOptions == 3 then -- Role Icon Only
                if role then
                    unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
                    unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
                    unitFrame.roleIcon:SetHidden (false)
                    unitFrame.classIcon:SetHidden (true)
                end
            end
            if UF.SV.RaidIconOptions == 4 then -- Class PVP, Role PVE
                if IsPlayerInAvAWorld() or IsActiveWorldBattleground() then
                    unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
                    unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
                    unitFrame.roleIcon:SetHidden (true)
                    unitFrame.classIcon:SetHidden (false)
                elseif not ( IsPlayerInAvAWorld() or IsActiveWorldBattleground() ) and role then
                    unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
                    unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
                    unitFrame.roleIcon:SetHidden (false)
                    unitFrame.classIcon:SetHidden (true)
                else
                    -- Fallback if neither condition is true then we clear the frame
                    unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip, UF.SV.RaidBarHeight-2 )
                    unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 5, 0 )
                    unitFrame.roleIcon:SetHidden (true)
                    unitFrame.classIcon:SetHidden (true)
                end
            end
            if UF.SV.RaidIconOptions == 5 then -- Class PVE, Role PVP
                if ( IsPlayerInAvAWorld() or IsActiveWorldBattleground() )  and role then
                    unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
                    unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
                    unitFrame.roleIcon:SetHidden (false)
                    unitFrame.classIcon:SetHidden (true)
                elseif not ( IsPlayerInAvAWorld() or IsActiveWorldBattleground() ) then
                    unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
                    unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
                    unitFrame.roleIcon:SetHidden (true)
                    unitFrame.classIcon:SetHidden (false)
                else
                    -- Fallback if neither condition is true then we clear the frame
                    unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip, UF.SV.RaidBarHeight-2 )
                    unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 5, 0 )
                    unitFrame.roleIcon:SetHidden (true)
                    unitFrame.classIcon:SetHidden (true)
                end
            end
        else
            unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip, UF.SV.RaidBarHeight-2 )
            unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 5, 0 )
            unitFrame.roleIcon:SetHidden (true)
            unitFrame.classIcon:SetHidden (true)
        end

        -- Old Function preserved here just in case
        --[[
        if (UF.SV.RoleIconRaid and role and not IsPlayerInAvAWorld() ) or (UF.SV.ClassIconRaid and IsUnitOnline(unitTag) ) then
            unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
            unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
        else
            unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip, UF.SV.RaidBarHeight-2 )
            unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 5, 0 )
        end
        unitFrame.roleIcon:SetHidden (not UF.SV.RoleIconRaid or IsPlayerInAvAWorld() )
        unitFrame.classIcon:SetHidden (not UF.SV.ClassIconRaid)
        ]]--

        if IsUnitGroupLeader(unitTag) then
            unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip-17, UF.SV.RaidBarHeight-2 )
            unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 22, 0 )
            unitFrame.roleIcon:SetHidden (true)
            unitFrame.classIcon:SetHidden (true)
            unitFrame.leader:SetTexture(leaderIcons[1])
        else
            unitFrame.leader:SetTexture(leaderIcons[0])
        end

        unitFrame.dead:SetDimensions(UF.SV.RaidBarWidth-50, UF.SV.RaidBarHeight-2)
        unitFrame[POWERTYPE_HEALTH].label:SetDimensions(UF.SV.RaidBarWidth-50, UF.SV.RaidBarHeight-2)

        if not IsUnitOnline(unitTag) then
            unitFrame.name:SetDimensions( UF.SV.RaidBarWidth-UF.SV.RaidNameClip, UF.SV.RaidBarHeight-2 )
            unitFrame.name:SetAnchor ( LEFT, rhb, LEFT, 5, 0 )
            unitFrame.classIcon:SetHidden (true)
        end
    end
    if unhide then
        raid:SetHidden( false )
    end
end

-- Set dimensions of custom raid frame and anchors or raid group members
function UF.CustomFramesApplyLayoutBosses()
    if not UF.CustomFrames.boss1 then
        return
    end

    local bosses = UF.CustomFrames.boss1.tlw

    bosses:SetDimensions( UF.SV.BossBarWidth, UF.SV.BossBarHeight * 6 + 2 * 5)

    for i = 1, 6 do
        local unitFrame = UF.CustomFrames["boss" .. i]

        unitFrame.control:ClearAnchors()
        unitFrame.control:SetAnchor( TOPLEFT, bosses, TOPLEFT, 0, (UF.SV.BossBarHeight+2)*(i-1) )
        unitFrame.control:SetDimensions( UF.SV.BossBarWidth, UF.SV.BossBarHeight )

        unitFrame.name:SetDimensions( UF.SV.BossBarWidth-50, UF.SV.BossBarHeight-2 )

        unitFrame[POWERTYPE_HEALTH].label:SetDimensions( UF.SV.BossBarWidth-50, UF.SV.BossBarHeight-2 )
    end

    bosses:SetHidden( false )
end

-- This function reduces opacity of custom frames when player is out of combat and has full attributes
function UF.CustomFramesApplyInCombat()
    local idle = true
    if UF.SV.CustomOocAlphaPower then
        for _, value in pairs(g_statFull) do
            idle = idle and value
        end
    else
        idle = g_statFull.combat
    end

    local oocAlphaPlayer = 0.01 * UF.SV.PlayerOocAlpha
    local incAlphaPlayer = 0.01 * UF.SV.PlayerIncAlpha

    local oocAlphaTarget = 0.01 * UF.SV.TargetOocAlpha
    local incAlphaTarget = 0.01 * UF.SV.TargetIncAlpha

    local oocAlphaBoss = 0.01 * UF.SV.BossOocAlpha
    local incAlphaBoss = 0.01 * UF.SV.BossIncAlpha

    -- Apply to all frames
    if UF.CustomFrames.player then
        UF.CustomFrames.player.control:SetAlpha( idle and oocAlphaPlayer or incAlphaPlayer )
        if UF.SV.HideBuffsPlayerOoc then
            UF.CustomFrames.player.buffs:SetHidden ( idle and true or false )
            UF.CustomFrames.player.debuffs:SetHidden ( idle and true or false )
        else
            UF.CustomFrames.player.buffs:SetHidden ( false )
            UF.CustomFrames.player.debuffs:SetHidden ( false )
        end
    end
    if UF.CustomFrames.AvaPlayerTarget then
        UF.CustomFrames.AvaPlayerTarget.control:SetAlpha( idle and oocAlphaTarget or incAlphaTarget )
    end
    if UF.CustomFrames.reticleover then
        UF.CustomFrames.reticleover.control:SetAlpha( idle and oocAlphaTarget or incAlphaTarget )
        if UF.SV.HideBuffsTargetOoc then
            UF.CustomFrames.reticleover.buffs:SetHidden ( idle and true or false )
            UF.CustomFrames.reticleover.debuffs:SetHidden ( idle and true or false )
        else
            UF.CustomFrames.reticleover.buffs:SetHidden ( false )
            UF.CustomFrames.reticleover.debuffs:SetHidden ( false )
        end
    end

    for i = 1, 6 do
        local unitTag = "boss" .. i
        if UF.CustomFrames[unitTag] then
            UF.CustomFrames[unitTag].control:SetAlpha ( idle and oocAlphaBoss or incAlphaBoss )
        end
    end
end

function UF.CustomFramesGroupAlpha()
    local alphaGroup = 0.01 * UF.SV.GroupAlpha

    for i = 1, 4 do
        local unitTag = "SmallGroup" .. i
        if UF.CustomFrames[unitTag] then
           UF.CustomFrames[unitTag].control:SetAlpha( IsUnitInGroupSupportRange(UF.CustomFrames[unitTag].unitTag) and alphaGroup or ( alphaGroup / 2 ) )
        end
    end

    for i = 1, 24 do
        local unitTag = "RaidGroup" .. i
        if UF.CustomFrames[unitTag] then
            UF.CustomFrames[unitTag].control:SetAlpha( IsUnitInGroupSupportRange(UF.CustomFrames[unitTag].unitTag) and alphaGroup or ( alphaGroup / 2 ) )
        end
    end
end

-- Reload Names from Menu function call
function UF.CustomFramesReloadControlsMenu(player, group, raid)
    UF.UpdateStaticControls( g_DefaultFrames["player"] )
    UF.UpdateStaticControls( UF.CustomFrames["player"] )
    UF.UpdateStaticControls( g_AvaCustFrames["player"] )

    UF.UpdateStaticControls( g_DefaultFrames["reticleover"] )
    UF.UpdateStaticControls( UF.CustomFrames["reticleover"] )
    UF.UpdateStaticControls( g_AvaCustFrames["reticleover"] )

    for i = 1, 24 do
        local unitTag = "group" .. i
        UF.UpdateStaticControls( g_DefaultFrames[unitTag] )
        UF.UpdateStaticControls( UF.CustomFrames[unitTag] )
        UF.UpdateStaticControls( g_AvaCustFrames[unitTag] )
    end

    UF.CustomFramesApplyLayoutPlayer(player)
    UF.CustomFramesApplyLayoutGroup(group)
    UF.CustomFramesApplyLayoutRaid(raid)
end

function UF.CustomFramesReloadExecuteMenu()
    g_targetThreshold = UF.SV.ExecutePercentage

    if g_DefaultFrames.reticleover[POWERTYPE_HEALTH] then
        g_DefaultFrames.reticleover[POWERTYPE_HEALTH].threshold = g_targetThreshold
    end
    if UF.CustomFrames["reticleover"] and UF.CustomFrames["reticleover"][POWERTYPE_HEALTH] then
        UF.CustomFrames["reticleover"][POWERTYPE_HEALTH].threshold = g_targetThreshold
    end
    if g_AvaCustFrames["reticleover"] and g_AvaCustFrames["reticleover"][POWERTYPE_HEALTH] then
        g_AvaCustFrames["reticleover"][POWERTYPE_HEALTH].threshold = g_targetThreshold
    end

    for i = 1, 6 do
        local unitTag = "boss" .. i
        if UF.CustomFrames[unitTag] and UF.CustomFrames[unitTag][POWERTYPE_HEALTH] then
            UF.CustomFrames[unitTag][POWERTYPE_HEALTH].threshold = g_targetThreshold
        end
    end
end

function UF.CustomFramesReloadLowResourceThreshold()
    g_healthThreshold = UF.SV.LowResourceHealth
    g_magickaThreshold = UF.SV.LowResourceStamina
    g_staminaThreshold = UF.SV.LowResourceMagicka

    if UF.CustomFrames["player"] and UF.CustomFrames["player"][POWERTYPE_HEALTH] then
        UF.CustomFrames["player"][POWERTYPE_HEALTH].threshold = g_healthThreshold
    end
    if UF.CustomFrames["player"] and UF.CustomFrames["player"][POWERTYPE_MAGICKA] then
        UF.CustomFrames["player"][POWERTYPE_MAGICKA].threshold = g_magickaThreshold
    end
    if UF.CustomFrames["player"] and UF.CustomFrames["player"][POWERTYPE_STAMINA] then
        UF.CustomFrames["player"][POWERTYPE_STAMINA].threshold = g_staminaThreshold
    end
end

--[[----------------------------------------------------------
 * DEBUG FUNCTIONS
--]]----------------------------------------------------------

function UF.CustomFramesDebugGroup()
    for i = 1, 4 do
        local unitTag = "SmallGroup" .. i
        UF.CustomFrames[unitTag].unitTag = "player"
        UF.CustomFrames[unitTag].control:SetHidden(false)
        UF.UpdateStaticControls( UF.CustomFrames[unitTag] )
    end
    UF.CustomFrames.SmallGroup1.friendIcon:SetHidden(false)
    UF.CustomFrames.SmallGroup1.friendIcon:SetTexture("/esoui/art/campaign/campaignbrowser_friends.dds")
    UF.OnLeaderUpdate( nil, "SmallGroup1" )
end

function UF.CustomFramesDebugRaid()
    for i = 1, 24 do
        local unitTag = "RaidGroup" .. i
        UF.CustomFrames[unitTag].unitTag = "player"
        UF.CustomFrames[unitTag].control:SetHidden(false)
        UF.UpdateStaticControls( UF.CustomFrames[unitTag] )
    end
    UF.OnLeaderUpdate( nil, "RaidGroup1" )
end

-- Updates group frames when a relevant social change event happens
function UF.SocialUpdateFrames()
    for i = 1, 24 do
        local unitTag = "group" .. i
        if DoesUnitExist(unitTag) then
            UF.ReloadValues(unitTag)
        end
    end
    UF.ReloadValues("reticleover")
end
