--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local UF = LUIE.UnitFrames

local zo_strformat = zo_strformat

local optionsDataUnitFrames = {}

local nameDisplayOptions     = { "@UserID", "Character Name", "Character Name @UserID" }
local nameDisplayOptionsKeys = { ["@UserID"] = 1, ["Character Name"] = 2, ["Character Name @UserID"] = 3 }
local raidIconOptions        = { "No Icons", "Class Icons Only", "Role Icons Only", "Class Icon in PVP, Role in PVE", "Class Icon in PVE, Role in PVP" }
local raidIconOptionsKeys    = { ["No Icons"] = 1 , ["Class Icons Only"] = 2, ["Role Icons Only"] = 3, ["Class Icon in PVP, Role in PVE"] = 4, ["Class Icon in PVE, Role in PVP"] = 5 }
local playerFrameOptions     = { "Vertical Stacked Frames", "Separated Horizontal Frames", "Pyramid" }
local playerFrameOptionsKeys = { ["Vertical Stacked Frames"] = 1, ["Separated Horizontal Frames"] = 2, ["Pyramid"] = 3 }
local championOptions        = { "Show Above Cap", "Limit to Cap" }
local resolutionOptions      = { "1080p", "1440p", "4K" }
local resolutionOptionsKeys  = { ["1080p"] = 1, ["1440p"] = 2, ["4K"] = 3 }

local formatOptions = {
    "Nothing",
    "Current",
    "Current + Shield",
    "Max",
    "Percentage%",
    "Current / Max",
    "Current + Shield / Max",
    "Current / Max (Percentage%)",
    "Current + Shield / Max (Percentage%)",
    "Current (Percentage%)",
    "Current + Shield (Percentage%)"
}

function UF.CreateSettings()
    -- Load LibAddonMenu
    local LAM = _G["LibAddonMenu2"]

    -- Get fonts
    local FontsList = {}
    for f in pairs(LUIE.Fonts) do
        table.insert(FontsList, f)
    end

    -- Get statusbar textures
    local StatusbarTexturesList = {}
    for key, _ in pairs(LUIE.StatusbarTextures) do
        table.insert(StatusbarTexturesList, key)
    end

    local panelDataUnitFrames = {
        type = "panel",
        name = zo_strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_UF)),
        displayName = zo_strformat("<<1>> <<2>>", LUIE.name, GetString(SI_LUIE_LAM_UF)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
        slashCommand = "/luiuf",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    -- Unit Frames module description
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_UF_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Resolution Options
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "dropdown",
        name = GetString(SI_LUIE_LAM_UF_RESOLUTION),
        tooltip = GetString(SI_LUIE_LAM_UF_RESOLUTION_TP),
        choices = resolutionOptions,
        getFunc = function() return resolutionOptions[UF.SV.ResolutionOptions] end,
        setFunc = function(value) UF.SV.ResolutionOptions = resolutionOptionsKeys[value] UF.CustomFramesSetPositions() end,
        width = "full",
        default = UF.D.ResolutionOptions,
        disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
    }

    -- Custom Unit Frames Unlock
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_UNLOCK_TP),
        getFunc = function() return LUIE.CombatInfo.CastBarUnlocked end,
        setFunc = UF.CustomFramesSetMovingState,
        width = "half",
        default = false,
        disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
        resetFunc = function() UF.CustomFramesResetPosition(false) end,
    }

    -- Custom Unit Frames Reset position
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT_TP),
        func = function() UF.CustomFramesResetPosition(false) end,
        width = "half",
    }

    -- Unit Frames - Default Unit Frames Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_DFRAMES_HEADER),
        controls = {
            {
                -- Default PLAYER frame
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_PLAYER),
                choices = UF.GetDefaultFramesOptions('Player'),
                getFunc = function() return UF.GetDefaultFramesSetting('Player') end,
                setFunc = function(value) UF.SetDefaultFramesSetting('Player', value) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = UF.GetDefaultFramesSetting('Player', true),
            },
            {
                -- Default TARGET frame
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_TARGET),
                choices = UF.GetDefaultFramesOptions('Target'),
                getFunc = function() return UF.GetDefaultFramesSetting('Target') end,
                setFunc = function(value) UF.SetDefaultFramesSetting('Target', value) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = UF.GetDefaultFramesSetting('Target', true),
            },
            {
                -- Default small GROUP frame
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_GROUPSMALL),
                choices = UF.GetDefaultFramesOptions('Group'),
                getFunc = function() return UF.GetDefaultFramesSetting('Group') end,
                setFunc = function(value) UF.SetDefaultFramesSetting('Group', value) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = UF.GetDefaultFramesSetting('Group', true),
            },
            {
                -- Compass Boss Bar
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_BOSS_COMPASS),
                choices = UF.GetDefaultFramesOptions('Boss'),
                getFunc = function() return UF.GetDefaultFramesSetting('Boss') end,
                setFunc = function(value) UF.SetDefaultFramesSetting('Boss', value) UF.ResetCompassBarMenu() end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                default = UF.GetDefaultFramesSetting('Boss', true),
            },
            {
                -- Reposition default player bars
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_REPOSIT),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_REPOSIT_TP),
                getFunc = function() return UF.SV.RepositionFrames end,
                setFunc = function(value) UF.SV.RepositionFrames = value end,
                width = "full",
                default = UF.D.RepositionFrames,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Reposition frames adjust Y Coordinates
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_VERT),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_VERT_TP),
                min = -150, max = 300, step = 5,
                getFunc = function() return UF.SV.RepositionFramesAdjust end,
                setFunc = function(value) UF.SV.RepositionFramesAdjust = value end,
                width = "full",
                default = UF.D.RepositionFramesAdjust,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.RepositionFrames) end,
            },
            {
                -- Out-of-Combat bars transparency
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_OOCTRANS_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.DefaultOocTransparency end,
                setFunc = function(value) UF.SetDefaultFramesTransparency(value, nil) end,
                width = "full",
                default = UF.D.DefaultOocTransparency,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- In-Combat bars transparency
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_INCTRANS),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_INCTRANS_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.DefaultIncTransparency end,
                setFunc = function(value) UF.SetDefaultFramesTransparency(nil, value) end,
                width = "full",
                default = UF.D.DefaultIncTransparency,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Format label text
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_TP),
                choices = formatOptions,
                getFunc = function() return UF.SV.Format end,
                setFunc = function(var) UF.SV.Format = var end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.Format,
            },
            {
                -- DefaultFrames Font
                type = "dropdown",
                scrollable = true,
                name = GetString(SI_LUIE_LAM_FONT),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return UF.SV.DefaultFontFace end,
                setFunc = function(var) UF.SV.DefaultFontFace = var UF.DefaultFramesApplyFont() end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.DefaultFontFace,
            },
            {
                -- DefaultFrames Font Size
                type = "slider",
                name = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_SIZE_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return UF.SV.DefaultFontSize end,
                setFunc = function(value) UF.SV.DefaultFontSize = value UF.DefaultFramesApplyFont() end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.DefaultFontSize,
            },
            {
                -- DefaultFrames Font Style
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_FONT_STYLE),
                tooltip = GetString(SI_LUIE_LAM_UF_DFRAMES_FONT_STYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return UF.SV.DefaultFontStyle end,
                setFunc = function(var) UF.SV.DefaultFontStyle = var UF.DefaultFramesApplyFont() end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.DefaultFontStyle,
            },
            {
                 -- Color of text labels
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_DFRAMES_LABEL_COLOR),
                getFunc = function() return unpack(UF.SV.DefaultTextColour) end,
                setFunc = function(r,g,b,a) UF.SV.DefaultTextColour={r,g,b} UF.DefaultFramesApplyColour() end,
                width = "full",
                default = { r=UF.D.DefaultTextColour[1], g=UF.D.DefaultTextColour[2], b=UF.D.DefaultTextColour[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Color target name by reaction
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION),
                tooltip = GetString(SI_LUIE_LAM_UF_TARGET_COLOR_REACTION_TP),
                getFunc = function() return UF.SV.TargetColourByReaction end,
                setFunc = UF.TargetColourByReaction,
                width = "full",
                default = UF.D.TargetColourByReaction,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Target class icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS),
                tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_CLASS_TP),
                getFunc = function() return UF.SV.TargetShowClass end,
                setFunc = function(value) UF.SV.TargetShowClass = value end,
                width = "full",
                default = UF.D.TargetShowClass,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Target ignore/friend/guild icon
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_TARGET_ICON_GFI),
                tooltip = GetString(SI_LUIE_LAM_UF_TARGET_ICON_GFI_TP),
                getFunc = function() return UF.SV.TargetShowFriend end,
                setFunc = function(value) UF.SV.TargetShowFriend = value end,
                width = "full",
                default = UF.D.TargetShowFriend,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frames Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_HEADER),
        controls = {
            {
                -- Custom Unit Frames Font
                type = "dropdown",
                scrollable = true,
                name = GetString(SI_LUIE_LAM_FONT),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_TP),
                choices = FontsList,
                sort = "name-up",
                getFunc = function() return UF.SV.CustomFontFace end,
                setFunc = function(var) UF.SV.CustomFontFace = var UF.CustomFramesApplyFont() end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.CustomFontFace,
            },
            {
                -- Custom Unit Frames Font size labels
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return UF.SV.CustomFontOther end,
                setFunc = function(value) UF.SV.CustomFontOther = value UF.CustomFramesApplyFont() end,
                width = "half",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.CustomFontOther,
            },
            {
                -- Custom Unit Frames Font size bars
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS_TP),
                min = 10, max = 30, step = 1,
                getFunc = function() return UF.SV.CustomFontBars end,
                setFunc = function(value) UF.SV.CustomFontBars = value UF.CustomFramesApplyFont() end,
                width = "half",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.CustomFontBars,
            },
            {
                -- Custom Unit Frames Font style
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_FONT_STYLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_FONT_STYLE_TP),
                choices = { "normal", "outline", "shadow", "soft-shadow-thick", "soft-shadow-thin", "thick-outline" },
                sort = "name-up",
                getFunc = function() return UF.SV.CustomFontStyle end,
                setFunc = function(var) UF.SV.CustomFontStyle = var UF.CustomFramesApplyFont() end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.CustomFontStyle,
            },
            {
                -- Custom Unit Frames Texture
                type = "dropdown",
                scrollable = true,
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_TEXTURE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_TEXTURE_TP),
                choices = StatusbarTexturesList,
                sort = "name-up",
                getFunc = function() return UF.SV.CustomTexture end,
                setFunc = function(var) UF.SV.CustomTexture = var UF.CustomFramesApplyTexture() end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.CustomTexture,
            },
            {
                -- Custom Unit Frames Separate Shield Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_TP),
                getFunc = function() return UF.SV.CustomShieldBarSeparate end,
                setFunc = function(value) UF.SV.CustomShieldBarSeparate = value end,
                width = "full",
                default = UF.D.CustomShieldBarSeparate,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end
            },
            {
                -- Custom Unit Frames Separate Shield Bar Height
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT_TP),
                min = 4, max = 12, step = 1,
                getFunc = function() return UF.SV.CustomShieldBarHeight end,
                setFunc = function(value) UF.SV.CustomShieldBarHeight = value UF.CustomFramesApplyLayoutPlayer(true) UF.CustomFramesApplyLayoutGroup() end,
                width = "full",
                default = UF.D.CustomShieldBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomShieldBarSeparate ) end,
            },
            {
                -- Custom Unit Frames Overlay Full Height Shield Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY_TP),
                getFunc = function() return UF.SV.CustomShieldBarFull end,
                setFunc = function(value) UF.SV.CustomShieldBarFull = value end,
                width = "full",
                default = UF.D.CustomShieldBarFull,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and not UF.SV.CustomShieldBarSeparate ) end,
            },
            {
                -- Shield Transparency
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_ALPHA),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SHIELD_ALPHA_TP),
                min = 0, max = 100, step = 1,
                getFunc = function() return UF.SV.ShieldAlpha end,
                setFunc = function(value) UF.SV.ShieldAlpha = value UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = UF.D.ShieldAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and not UF.SV.CustomShieldBarSeparate ) end,
            },
            {
                -- Custom Unit Frames Smooth Bar Transition
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS_TP),
                getFunc = function() return UF.SV.CustomSmoothBar end,
                setFunc = function(value) UF.SV.CustomSmoothBar = value end,
                width = "full",
                default = UF.D.CustomSmoothBar,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Champion Points Effective
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_CHAMPION),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_CHAMPION_TP),
                choices = championOptions,
                getFunc = function() return UF.SV.ChampionOptions end,
                setFunc = function(var) UF.SV.ChampionOptions = var UF.OnPlayerActivated() end,
                width = "full",
                default = UF.D.ChampionOptions,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frame Color Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEADER),
        controls = {
            {
                -- Custom Unit Frames Health Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALTH),
                getFunc = function() return unpack(UF.SV.CustomColourHealth) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourHealth={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourHealth[1], g=UF.D.CustomColourHealth[2], b=UF.D.CustomColourHealth[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Shield Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SHIELD),
                getFunc = function() return UF.SV.CustomColourShield[1], UF.SV.CustomColourShield[2], UF.SV.CustomColourShield[3]  end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourShield={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourShield[1], g=UF.D.CustomColourShield[2], b=UF.D.CustomColourShield[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Magicka Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_MAGICKA),
                getFunc = function() return unpack(UF.SV.CustomColourMagicka) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourMagicka={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourMagicka[1], g=UF.D.CustomColourMagicka[2], b=UF.D.CustomColourMagicka[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Stamina Bar Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_STAMINA),
                getFunc = function() return unpack(UF.SV.CustomColourStamina) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourStamina={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourStamina[1], g=UF.D.CustomColourStamina[2], b=UF.D.CustomColourStamina[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames DPS Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DPS),
                getFunc = function() return unpack(UF.SV.CustomColourDPS) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourDPS={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourDPS[1], g=UF.D.CustomColourDPS[2], b=UF.D.CustomColourDPS[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Healer Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALER),
                getFunc = function() return unpack(UF.SV.CustomColourHealer) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourHealer={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourHealer[1], g=UF.D.CustomColourHealer[2], b=UF.D.CustomColourHealer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Tank Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TANK),
                getFunc = function() return unpack(UF.SV.CustomColourTank) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourTank={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourTank[1], g=UF.D.CustomColourTank[2], b=UF.D.CustomColourTank[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Dragonknight Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_DK),
                getFunc = function() return unpack(UF.SV.CustomColourDragonknight) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourDragonknight={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourDragonknight[1], g=UF.D.CustomColourDragonknight[2], b=UF.D.CustomColourDragonknight[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Nightblade Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_NB),
                getFunc = function() return unpack(UF.SV.CustomColourNightblade) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourNightblade={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourNightblade[1], g=UF.D.CustomColourNightblade[2], b=UF.D.CustomColourNightblade[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Sorcerer Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_SORC),
                getFunc = function() return unpack(UF.SV.CustomColourSorcerer) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourSorcerer={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourSorcerer[1], g=UF.D.CustomColourSorcerer[2], b=UF.D.CustomColourSorcerer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Templar Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_TEMP),
                getFunc = function() return unpack(UF.SV.CustomColourTemplar) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourTemplar={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourTemplar[1], g=UF.D.CustomColourTemplar[2], b=UF.D.CustomColourTemplar[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Warden Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_WARD),
                getFunc = function() return unpack(UF.SV.CustomColourWarden) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourWarden={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourWarden[1], g=UF.D.CustomColourWarden[2], b=UF.D.CustomColourWarden[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Frames Necromancer Role Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_NECRO),
                getFunc = function() return unpack(UF.SV.CustomColourNecromancer) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourNecromancer={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourNecromancer[1], g=UF.D.CustomColourNecromancer[2], b=UF.D.CustomColourNecromancer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_PLAYER),
                getFunc = function() return unpack(UF.SV.CustomColourPlayer) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourPlayer={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourPlayer[1], g=UF.D.CustomColourPlayer[2], b=UF.D.CustomColourPlayer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_FRIENDLY),
                getFunc = function() return unpack(UF.SV.CustomColourFriendly) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourFriendly={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourFriendly[1], g=UF.D.CustomColourFriendly[2], b=UF.D.CustomColourFriendly[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_HOSTILE),
                getFunc = function() return unpack(UF.SV.CustomColourHostile) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourHostile={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourHostile[1], g=UF.D.CustomColourHostile[2], b=UF.D.CustomColourHostile[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_NEUTRAL),
                getFunc = function() return unpack(UF.SV.CustomColourNeutral) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourNeutral={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourNeutral[1], g=UF.D.CustomColourNeutral[2], b=UF.D.CustomColourNeutral[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Custom Unit Reaction color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_FILL_R_GUARD),
                getFunc = function() return unpack(UF.SV.CustomColourGuard) end,
                setFunc = function(r,g,b,a) UF.SV.CustomColourGuard={r,g,b} UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = { r=UF.D.CustomColourGuard[1], g=UF.D.CustomColourGuard[2], b=UF.D.CustomColourGuard[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frames (Player & Target) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_HEADER),
        controls = {
            {
                -- Enable LUIE PLAYER frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER_TP),
                getFunc = function() return UF.SV.CustomFramesPlayer end,
                setFunc = function(value) UF.SV.CustomFramesPlayer = value end,
                width = "full",
                default = UF.D.CustomFramesPlayer,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Enable LUIE Target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET_TP),
                getFunc = function() return UF.SV.CustomFramesTarget end,
                setFunc = function(value) UF.SV.CustomFramesTarget = value end,
                width = "full",
                default = UF.D.CustomFramesTarget,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                 -- Player Name Display Method (Player)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_PLAYER),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_PLAYER_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[UF.SV.DisplayOptionsPlayer] end,
                setFunc = function(value) UF.SV.DisplayOptionsPlayer = nameDisplayOptionsKeys[value] UF.CustomFramesReloadControlsMenu(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Player Name Display Method (Target)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_TARGET_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[UF.SV.DisplayOptionsTarget] end,
                setFunc = function(value) UF.SV.DisplayOptionsTarget = nameDisplayOptionsKeys[value] UF.CustomFramesReloadControlsMenu(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Custom Unit Frames format left label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
                choices = formatOptions,
                getFunc = function() return UF.SV.CustomFormatOnePT end,
                setFunc = function(var) UF.SV.CustomFormatOnePT = var UF.CustomFramesFormatLabels(true) UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.CustomFormatOnePT,
            },
            {
                -- Custom Unit Frames format right label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
                choices = formatOptions,
                getFunc = function() return UF.SV.CustomFormatTwoPT end,
                setFunc = function(var) UF.SV.CustomFormatTwoPT = var UF.CustomFramesFormatLabels(true) UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = UF.D.CustomFormatTwoPT,
            },
            {
                -- Player Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_WIDTH),
                min = 200, max = 500, step = 5,
                getFunc = function() return UF.SV.PlayerBarWidth end,
                setFunc = function(value) UF.SV.PlayerBarWidth = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Player Health Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_HP_HIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.PlayerBarHeightHealth end,
                setFunc = function(value) UF.SV.PlayerBarHeightHealth = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerBarHeightHealth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Player Magicka Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_HIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.PlayerBarHeightMagicka end,
                setFunc = function(value) UF.SV.PlayerBarHeightMagicka = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerBarHeightMagicka,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Player Stamina Bar Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_HIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.PlayerBarHeightStamina end,
                setFunc = function(value) UF.SV.PlayerBarHeightStamina = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerBarHeightStamina,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Out-of-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.PlayerOocAlpha end,
                setFunc = function(value) UF.SV.PlayerOocAlpha = value UF.CustomFramesApplyInCombat() UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerOocAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- In-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.PlayerIncAlpha end,
                setFunc = function(value) UF.SV.PlayerIncAlpha = value UF.CustomFramesApplyInCombat() UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerIncAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- HIDE BUFFS OOC - PLAYER
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER_TP),
                getFunc = function() return UF.SV.HideBuffsPlayerOoc end,
                setFunc = function(value) UF.SV.HideBuffsPlayerOoc = value UF.CustomFramesApplyInCombat() end,
                width = "full",
                default = UF.D.HideBuffsPlayerOoc,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- Display self name on Player Frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF_TP),
                getFunc = function() return UF.SV.PlayerEnableYourname end,
                setFunc = function(value) UF.SV.PlayerEnableYourname = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerEnableYourname,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display Mount/Siege/Werewolf Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR_TP),
                getFunc = function() return UF.SV.PlayerEnableAltbarMSW end,
                setFunc = function(value) UF.SV.PlayerEnableAltbarMSW = value UF.CustomFramesSetupAlternative() UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerEnableAltbarMSW,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display XP/Champion XP Bar
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR_TP),
                getFunc = function() return UF.SV.PlayerEnableAltbarXP end,
                setFunc = function(value) UF.SV.PlayerEnableAltbarXP = value UF.CustomFramesSetupAlternative() UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerEnableAltbarXP,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Champion XP Bar Point-Type Color
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR_TP),
                getFunc = function() return UF.SV.PlayerChampionColour end,
                setFunc = function(value) UF.SV.PlayerChampionColour = value UF.OnChampionPointGained() UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerChampionColour,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.PlayerEnableAltbarXP ) end,
            },
            {
                -- Custom Unit Frames Low Health Warning
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_HEALTH),
                tooltip = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_HEALTH_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return UF.SV.LowResourceHealth end,
                setFunc = function(value) UF.SV.LowResourceHealth = value UF.CustomFramesReloadLowResourceThreshold() end,
                width = "full",
                default = UF.D.LowResourceHealth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Custom Unit Frames Low Magicka Warning
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_MAGICKA),
                tooltip = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_MAGICKA_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return UF.SV.LowResourceMagicka end,
                setFunc = function(value) UF.SV.LowResourceMagicka = value UF.CustomFramesReloadLowResourceThreshold() end,
                width = "full",
                default = UF.D.LowResourceMagicka,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Custom Unit Frames Low Stamina Warning
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_STAMINA),
                tooltip = GetString(SI_LUIE_LAM_UF_LOWRESOURCE_STAMINA_TP),
                min = 0, max = 50, step = 1,
                getFunc = function() return UF.SV.LowResourceStamina end,
                setFunc = function(value) UF.SV.LowResourceStamina = value UF.CustomFramesReloadLowResourceThreshold() end,
                width = "full",
                default = UF.D.LowResourceStamina,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Target Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_WIDTH),
                min = 200, max = 500, step = 5,
                getFunc = function() return UF.SV.TargetBarWidth end,
                setFunc = function(value) UF.SV.TargetBarWidth = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesTarget ) end,
            },
            {
                -- Target Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.TargetBarHeight end,
                setFunc = function(value) UF.SV.TargetBarHeight = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesTarget ) end,
            },
            {
                -- Out-of-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.TargetOocAlpha end,
                setFunc = function(value) UF.SV.TargetOocAlpha = value UF.CustomFramesApplyInCombat() UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetOocAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- In-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_ICPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.TargetIncAlpha end,
                setFunc = function(value) UF.SV.TargetIncAlpha = value UF.CustomFramesApplyInCombat() UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetIncAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- HIDE BUFFS OOC - TARGET
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BUFFS_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_BUFFS_TARGET_TP),
                getFunc = function() return UF.SV.HideBuffsTargetOoc end,
                setFunc = function(value) UF.SV.HideBuffsTargetOoc = value UF.CustomFramesApplyInCombat() end,
                width = "full",
                default = UF.D.HideBuffsTargetOoc,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- Color Target by Reaction
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_REACTION_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_REACTION_TARGET_TP),
                getFunc = function() return UF.SV.FrameColorReaction end,
                setFunc = function(value) UF.SV.FrameColorReaction = value UF.CustomFramesApplyReactionColor() end,
                width = "full",
                default = UF.D.FrameColorReaction,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesTarget ) end,
            },
            {
                -- Color Target by Class
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_CLASS_TARGET),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_CLASS_TARGET_TP),
                getFunc = function() return UF.SV.FrameColorClass end,
                setFunc = function(value) UF.SV.FrameColorClass = value UF.CustomFramesApplyReactionColor() end,
                width = "full",
                default = UF.D.FrameColorClass,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesTarget ) end,
            },
            {
                -- Display Target Class Label
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL_TP),
                getFunc = function() return UF.SV.TargetEnableClass end,
                setFunc = function(value) UF.SV.TargetEnableClass = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetEnableClass,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesTarget ) end,
            },
            {
                -- Execute Health % Threshold
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD_TP),
                min = 0, max = 50, step = 5,
                getFunc = function() return UF.SV.ExecutePercentage end,
                setFunc = function(value) UF.SV.ExecutePercentage = value UF.CustomFramesReloadExecuteMenu() end,
                width = "full",
                default = UF.D.ExecutePercentage,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesTarget ) end,
            },
            {
                -- Display Skull Execute Texture
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE_TP),
                getFunc = function() return UF.SV.TargetEnableSkull end,
                setFunc = function(value) UF.SV.TargetEnableSkull = value end,
                width = "full",
                default = UF.D.TargetEnableSkull,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesTarget ) end,
            },
            {
                -- Display title on target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_TITLE_TP),
                getFunc = function() return UF.SV.TargetEnableTitle end,
                setFunc = function(value) UF.SV.TargetEnableTitle = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetEnableTitle,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display rank name on target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TP),
                getFunc = function() return UF.SV.TargetEnableRank end,
                setFunc = function(value) UF.SV.TargetEnableRank = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetEnableRank,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Prioritize Title or AvA Rank
                type = 'dropdown',
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TITLE_PRIORITY)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANK_TITLE_PRIORITY_TP),
                choices = { "AVA Rank", "Title" },
                getFunc = function() return UF.SV.TargetTitlePriority end,
                setFunc = function(value) UF.SV.TargetTitlePriority = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetTitlePriority,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.TargetEnableRank and UF.SV.TargetEnableTitle) end,
            },
            {
                -- Display rank icon on target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANKICON),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_RANKICON_TP),
                getFunc = function() return UF.SV.TargetEnableRankIcon end,
                setFunc = function(value) UF.SV.TargetEnableRankIcon = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.TargetEnableRankIcon,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Display Armor stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
                getFunc = function() return UF.SV.PlayerEnableArmor end,
                setFunc = function(value) UF.SV.PlayerEnableArmor = value end,
                width = "full",
                default = UF.D.PlayerEnableArmor,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- Display Power stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
                getFunc = function() return UF.SV.PlayerEnablePower end,
                setFunc = function(value) UF.SV.PlayerEnablePower = value end,
                width = "full",
                default = UF.D.PlayerEnablePower,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
            {
                -- Custom Unit Frames Display HoT / DoT Animations
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_PT)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
                getFunc = function() return UF.SV.PlayerEnableRegen end,
                setFunc = function(value) UF.SV.PlayerEnableRegen = value end,
                width = "full",
                default = UF.D.PlayerEnableRegen,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Treat Missing Power as In-Combat
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT_TP),
                getFunc = function() return UF.SV.CustomOocAlphaPower end,
                setFunc = function(value) UF.SV.CustomOocAlphaPower = value UF.CustomFramesApplyInCombat() end,
                width = "full",
                default = UF.D.CustomOocAlphaPower,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and ( UF.SV.CustomFramesPlayer or UF.SV.CustomFramesTarget ) ) end,
            },
        },
    }

    -- Unit Frames - Additional Player Frame Display Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_OPTIONS_HEADER),
        controls = {
            {
                -- Player Frames Display Method
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_METHOD),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_METHOD_TP),
                choices = playerFrameOptions,
                getFunc = function() return playerFrameOptions[UF.SV.PlayerFrameOptions] end,
                setFunc = function(value) UF.SV.PlayerFrameOptions = playerFrameOptionsKeys[value] UF.MenuUpdatePlayerFrameOptions(UF.SV.PlayerFrameOptions) end,
                width = "full",
                warning = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_METHOD_WARN),
                default = UF.D.PlayerFrameOptions,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Position Adjust Horizontal
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_HORIZ_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_HORIZ_ADJUST_TP),
                min = 0, max = 500, step = 5,
                getFunc = function() return UF.SV.AdjustStaminaHPos end,
                setFunc = function(value) UF.SV.AdjustStaminaHPos = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.AdjustStaminaHPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Position Adjust Vertical
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_VERT_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_S_VERT_ADJUST_TP),
                min = -250, max = 250, step = 5,
                getFunc = function() return UF.SV.AdjustStaminaVPos end,
                setFunc = function(value) UF.SV.AdjustStaminaVPos = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.AdjustStaminaVPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Position Adjust
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_HORIZ_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_HORIZ_ADJUST_TP),
                min = 0, max = 500, step = 5,
                getFunc = function() return UF.SV.AdjustMagickaHPos end,
                setFunc = function(value) UF.SV.AdjustMagickaHPos = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.AdjustMagickaHPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Position Adjust
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_VERT_ADJUST)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_M_VERT_ADJUST_TP),
                min = -250, max = 250, step = 5,
                getFunc = function() return UF.SV.AdjustMagickaVPos end,
                setFunc = function(value) UF.SV.AdjustMagickaVPos = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.AdjustMagickaVPos,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.PlayerFrameOptions == 2 ) end,
            },
            {
                -- Spacing between Player Bars
                type = "slider",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING_TP),
                min = -1, max = 4, step = 1,
                getFunc = function() return UF.SV.PlayerBarSpacing end,
                setFunc = function(value) UF.SV.PlayerBarSpacing = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.PlayerBarSpacing,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and ( UF.SV.PlayerFrameOptions == 1 or UF.SV.PlayerFrameOptions == 3 ) ) end,
            },
            {
                -- Hide Player Magicka Bar Label
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL_TP),
                getFunc = function() return UF.SV.HideLabelMagicka end,
                setFunc = function(value) UF.SV.HideLabelMagicka = value UF.SV.HideBarMagicka = false end,
                width = "full",
                default = UF.D.HideLabelMagicka,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                 -- Hide Player Magicka Bar
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR_TP),
                getFunc = function() return UF.SV.HideBarMagicka end,
                setFunc = function(value) UF.SV.HideBarMagicka = value end,
                width = "full",
                default = UF.D.HideBarMagicka,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.HideLabelMagicka ) end,
            },
            {
                -- Hide Player Stamina Bar Label
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL_TP),
                getFunc = function() return UF.SV.HideLabelStamina end,
                setFunc = function(value) UF.SV.HideLabelStamina = value UF.SV.HideBarStamina = false end,
                width = "full",
                default = UF.D.HideLabelStamina,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
            {
                -- Hide Player Stamina Bar
                type = "checkbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR)),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR_TP),
                getFunc = function() return UF.SV.HideBarStamina end,
                setFunc = function(value) UF.SV.HideBarStamina = value end,
                width = "full",
                default = UF.D.HideBarStamina,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer and UF.SV.HideLabelStamina ) end,
            },
            {
                -- Reverse Player Magicka and Stamina
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_REVERSE_RES),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_REVERSE_RES_TP),
                getFunc = function() return UF.SV.ReverseResourceBars end,
                setFunc = function(value) UF.SV.ReverseResourceBars = value end,
                width = "full",
                default = UF.D.ReverseResourceBars,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesPlayer ) end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frames (Group) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEADER),
        controls = {
            {
                -- Enable Group Frames
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE_TP),
                getFunc = function() return UF.SV.CustomFramesGroup end,
                setFunc = function(value) UF.SV.CustomFramesGroup = value end,
                width = "full",
                default = UF.D.CustomFramesGroup,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Player Name Display Method (Group/Raid)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[UF.SV.DisplayOptionsGroupRaid] end,
                setFunc = function(value) UF.SV.DisplayOptionsGroupRaid = nameDisplayOptionsKeys[value] UF.CustomFramesReloadControlsMenu(false, true, true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Custom Unit Frames format left label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP),
                choices = formatOptions,
                getFunc = function() return UF.SV.CustomFormatOneGroup end,
                setFunc = function(var) UF.SV.CustomFormatOneGroup = var UF.CustomFramesFormatLabels(true) UF.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
                default = UF.D.CustomFormatOneGroup,
            },
            {
                -- Custom Unit Frames format right label
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP),
                choices = formatOptions,
                getFunc = function() return UF.SV.CustomFormatTwoGroup end,
                setFunc = function(var) UF.SV.CustomFormatTwoGroup = var UF.CustomFramesFormatLabels(true) UF.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
                default = UF.D.CustomFormatTwoGroup,
            },
            {
                -- Group Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_WIDTH),
                min = 100, max = 400, step = 5,
                getFunc = function() return UF.SV.GroupBarWidth end,
                setFunc = function(value) UF.SV.GroupBarWidth = value UF.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = UF.D.GroupBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Group Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.GroupBarHeight end,
                setFunc = function(value) UF.SV.GroupBarHeight = value UF.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = UF.D.GroupBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Group / Raid ALPHA
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.GroupAlpha end,
                setFunc = function(value) UF.SV.GroupAlpha = value UF.CustomFramesGroupAlpha() UF.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = UF.D.GroupAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Spacing between Group Bars
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_SPACING),
                min = 20, max = 80, step = 2,
                getFunc = function() return UF.SV.GroupBarSpacing end,
                setFunc = function(value) UF.SV.GroupBarSpacing = value UF.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = UF.D.GroupBarSpacing,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Include Player in Group Frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER_TP),
                getFunc = function() return not UF.SV.GroupExcludePlayer end,
                setFunc = function(value) UF.SV.GroupExcludePlayer = (not value) UF.CustomFramesGroupUpdate() UF.CustomFramesApplyLayoutGroup(true) UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = not UF.D.GroupExcludePlayer,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Show Role Icon on Group Frames
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESG_ROLEICON_TP),
                getFunc = function() return UF.SV.RoleIconSmallGroup end,
                setFunc = function(value) UF.SV.RoleIconSmallGroup = value UF.CustomFramesApplyLayoutGroup(true) end,
                width = "full",
                default = UF.D.RoleIconSmallGroup,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Custom Unit Frames Group Color Class
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS_TP),
                getFunc = function() return UF.SV.ColorClassGroup end,
                setFunc = function(value) UF.SV.ColorClassGroup = value UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = UF.D.ColorClassGroup,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Custom Unit Frames Group Color Player Role
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE_TP),
                getFunc = function() return UF.SV.ColorRoleGroup end,
                setFunc = function(value) UF.SV.ColorRoleGroup = value UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = UF.D.ColorRoleGroup,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Display Armor stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
                getFunc = function() return UF.SV.GroupEnableArmor end,
                setFunc = function(value) UF.SV.GroupEnableArmor = value end,
                width = "full",
                default = UF.D.GroupEnableArmor,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Display Power stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
                getFunc = function() return UF.SV.GroupEnablePower end,
                setFunc = function(value) UF.SV.GroupEnablePower = value end,
                width = "full",
                default = UF.D.GroupEnablePower,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
            {
                -- Display Regen Arrows
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_GROUP)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
                getFunc = function() return UF.SV.GroupEnableRegen end,
                setFunc = function(value) UF.SV.GroupEnableRegen = value end,
                width = "full",
                default = UF.D.GroupEnableRegen,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesGroup ) end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frames (Raid) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEADER),
        controls = {
            {
                -- Enable Raid Frames
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE_TP),
                getFunc = function() return UF.SV.CustomFramesRaid end,
                setFunc = function(value) UF.SV.CustomFramesRaid = value end,
                width = "full",
                default = UF.D.CustomFramesRaid,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Player Name Display Method (Group/Raid)
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_NAMEDISPLAY_GROUPRAID_TP),
                choices = nameDisplayOptions,
                getFunc = function() return nameDisplayOptions[UF.SV.DisplayOptionsGroupRaid] end,
                setFunc = function(value) UF.SV.DisplayOptionsGroupRaid = nameDisplayOptionsKeys[value] UF.CustomFramesReloadControlsMenu(false, true, true) end,
                width = "full",
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
                default = nameDisplayOptions[2]
            },
            {
                -- Raid HP Bar Format
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_TP),
                choices = formatOptions,
                getFunc = function() return UF.SV.CustomFormatRaid end,
                setFunc = function(var) UF.SV.CustomFormatRaid = var UF.CustomFramesFormatLabels(true) UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
                default = UF.D.CustomFormatRaid,
            },
            {
                -- Raid Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_WIDTH),
                min = 100, max = 500, step = 5,
                getFunc = function() return UF.SV.RaidBarWidth end,
                setFunc = function(value) UF.SV.RaidBarWidth = value UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = UF.D.RaidBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Raid Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.RaidBarHeight end,
                setFunc = function(value) UF.SV.RaidBarHeight = value UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = UF.D.RaidBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Group / Raid ALPHA
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.GroupAlpha end,
                setFunc = function(value) UF.SV.GroupAlpha = value UF.CustomFramesGroupAlpha() UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = UF.D.GroupAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Raid Frame Layout
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_LAYOUT),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_LAYOUT_TP),
                choices = { "1 x 24", "2 x 12", "3 x 8", "4 x 6", "6 x 4" },
                -- sort = "name-up",
                getFunc = function() return UF.SV.RaidLayout end,
                setFunc = function(var) UF.SV.RaidLayout = var UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
                default = UF.D.RaidLayout,
            },
            {
                -- Add Spacer for every 4 members
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_SPACER_TP),
                getFunc = function() return UF.SV.RaidSpacers end,
                setFunc = function(value) UF.SV.RaidSpacers = UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = UF.D.RaidSpacers,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Raid Name Clip
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP_TP),
                min = 0, max = 200, step = 1,
                getFunc = function() return UF.SV.RaidNameClip end,
                setFunc = function(value) UF.SV.RaidNameClip = value UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = UF.D.RaidNameClip,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Class / Role Icon on Raid Frames Setting
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESR_ROLEICON),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESR_ROLEICON_TP),
                choices = raidIconOptions,
                getFunc = function() return raidIconOptions[UF.SV.RaidIconOptions] end,
                setFunc = function(value) UF.SV.RaidIconOptions = raidIconOptionsKeys[value] UF.CustomFramesApplyLayoutRaid(true) end,
                width = "full",
                default = UF.D.RaidIconOptions,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Custom Unit Frames Raid Color Player Class
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS_TP),
                getFunc = function() return UF.SV.ColorClassRaid end,
                setFunc = function(value) UF.SV.ColorClassRaid = value UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = UF.D.ColorClassRaid,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Custom Unit Frames Raid Color Player Role
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE_TP),
                getFunc = function() return UF.SV.ColorRoleRaid end,
                setFunc = function(value) UF.SV.ColorRoleRaid = value UF.CustomFramesApplyColours(true) end,
                width = "full",
                default = UF.D.ColorRoleRaid,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Display Armor stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
                getFunc = function() return UF.SV.RaidEnableArmor end,
                setFunc = function(value) UF.SV.RaidEnableArmor = value end,
                width = "full",
                default = UF.D.RaidEnableArmor,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Display Power stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
                getFunc = function() return UF.SV.RaidEnablePower end,
                setFunc = function(value) UF.SV.RaidEnablePower = value end,
                width = "full",
                default = UF.D.RaidEnablePower,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
            {
                -- Display Regen Arrows
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_RAID)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
                getFunc = function() return UF.SV.RaidEnableRegen end,
                setFunc = function(value) UF.SV.RaidEnableRegen = value end,
                width = "full",
                default = UF.D.RaidEnableRegen,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesRaid ) end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frames (Boss) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEADER),
        controls = {
            {
                -- Enable This Addon BOSS frames
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE_TP),
                getFunc = function() return UF.SV.CustomFramesBosses end,
                setFunc = function(value) UF.SV.CustomFramesBosses = value end,
                width = "full",
                default = UF.D.CustomFramesBosses,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Boss HP Bar Format
                type = "dropdown",
                name = GetString(SI_LUIE_LAM_UF_SHARED_LABEL),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_LABEL_TP),
                choices = formatOptions,
                getFunc = function() return UF.SV.CustomFormatBoss end,
                setFunc = function(var) UF.SV.CustomFormatBoss = var UF.CustomFramesFormatLabels(true) end,
                width = "full",
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
                default = UF.D.CustomFormatBoss,
            },
            {
                -- Boss Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESB_WIDTH),
                min = 100, max = 500, step = 5,
                getFunc = function() return UF.SV.BossBarWidth end,
                setFunc = function(value) UF.SV.BossBarWidth = value UF.CustomFramesApplyLayoutBosses() end,
                width = "full",
                default = UF.D.BossBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
            },
            {
                -- Boss Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESB_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.BossBarHeight end,
                setFunc = function(value) UF.SV.BossBarHeight = value UF.CustomFramesApplyLayoutBosses() end,
                width = "full",
                default = UF.D.BossBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
            },
            {
                -- Out-of-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.BossOocAlpha end,
                setFunc = function(value) UF.SV.BossOocAlpha = value UF.CustomFramesApplyInCombat() end,
                width = "full",
                default = UF.D.BossOocAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
            },
            {
                -- In-Combat frame opacity
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC_TP),
                min = 0, max = 100, step = 5,
                getFunc = function() return UF.SV.BossIncAlpha end,
                setFunc = function(value) UF.SV.BossIncAlpha = value UF.CustomFramesApplyInCombat() end,
                width = "full",
                default = UF.D.BossIncAlpha,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
            },
            {
                -- Display Armor stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_ARMOR), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_ARMOR_TP),
                getFunc = function() return UF.SV.BossEnableArmor end,
                setFunc = function(value) UF.SV.BossEnableArmor = value end,
                width = "full",
                default = UF.D.BossEnableArmor,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
            },
            {
                -- Display Power stat change
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_POWER), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_POWER_TP),
                getFunc = function() return UF.SV.BossEnablePower end,
                setFunc = function(value) UF.SV.BossEnablePower = value end,
                width = "full",
                default = UF.D.BossEnablePower,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
            },
            {
                -- Display Regen Arrows
                type = "checkbox",
                name = zo_strformat(GetString(SI_LUIE_LAM_UF_SHARED_REGEN), GetString(SI_LUIE_LAM_UF_SHARED_BOSS)),
                tooltip = GetString(SI_LUIE_LAM_UF_SHARED_REGEN_TP),
                getFunc = function() return UF.SV.BossEnableRegen end,
                setFunc = function(value) UF.SV.BossEnableRegen = value end,
                width = "full",
                default = UF.D.BossEnableRegen,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.CustomFramesBosses ) end,
            },
        },
    }

    -- Unit Frames - Custom Unit Frames (PvP Target Frame) Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_HEADER),
        controls = {
            {
                -- Enable additional PvP Target frame
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME),
                tooltip = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_TP),
                getFunc = function() return UF.SV.AvaCustFramesTarget end,
                setFunc = function(value) UF.SV.AvaCustFramesTarget = value end,
                width = "full",
                default = UF.D.AvaCustFramesTarget,
                warning = GetString(SI_LUIE_LAM_RELOADUI_WARNING),
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- PvP Target Bars Width
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_WIDTH),
                min = 300, max = 700, step = 5,
                getFunc = function() return UF.SV.AvaTargetBarWidth end,
                setFunc = function(value) UF.SV.AvaTargetBarWidth = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.AvaTargetBarWidth,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.AvaCustFramesTarget ) end,
            },
            {
                -- PvP Target Bars Height
                type = "slider",
                name = GetString(SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_HEIGHT),
                min = 20, max = 70, step = 1,
                getFunc = function() return UF.SV.AvaTargetBarHeight end,
                setFunc = function(value) UF.SV.AvaTargetBarHeight = value UF.CustomFramesApplyLayoutPlayer(true) end,
                width = "full",
                default = UF.D.AvaTargetBarHeight,
                disabled = function() return not ( LUIE.SV.UnitFrames_Enabled and UF.SV.AvaCustFramesTarget ) end,
            },
        },
    }

    -- Unit Frames - Common Options Submenu
    optionsDataUnitFrames[#optionsDataUnitFrames + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HEADER),
        controls = {
            {
                -- Shorten numbers
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS),
                tooltip = GetString(SI_LUIE_LAM_UF_SHORTNUMBERS_TP),
                getFunc = function() return UF.SV.ShortenNumbers end,
                setFunc = function(value) UF.SV.ShortenNumbers = value UF.CustomFramesFormatLabels(true) end,
                width = "full",
                default = UF.D.ShortenNumbers,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Default Caption Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_CAPTIONCOLOR),
                getFunc = function() return unpack(UF.SV.Target_FontColour) end,
                setFunc = function(r,g,b,a) UF.SV.Target_FontColour={r,g,b} end,
                width = "full",
                default = { r=UF.D.Target_FontColour[1], g=UF.D.Target_FontColour[2], b=UF.D.Target_FontColour[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Friendly NPC Font Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_NPCFONTCOLOR),
                getFunc = function() return unpack(UF.SV.Target_FontColour_FriendlyNPC) end,
                setFunc = function(r,g,b,a) UF.SV.Target_FontColour_FriendlyNPC={r,g,b} end,
                width = "full",
                default = { r=UF.D.Target_FontColour_FriendlyNPC[1], g=UF.D.Target_FontColour_FriendlyNPC[2], b=UF.D.Target_FontColour_FriendlyNPC[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Friendly Player Font Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_PLAYERFONTCOLOR),
                getFunc = function() return unpack(UF.SV.Target_FontColour_FriendlyPlayer) end,
                setFunc = function(r,g,b,a) UF.SV.Target_FontColour_FriendlyPlayer={r,g,b} end,
                width = "full",
                default = { r=UF.D.Target_FontColour_FriendlyPlayer[1], g=UF.D.Target_FontColour_FriendlyPlayer[2], b=UF.D.Target_FontColour_FriendlyPlayer[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Hostile Font Color
                type = "colorpicker",
                name = GetString(SI_LUIE_LAM_UF_COMMON_HOSTILEFONTCOLOR),
                getFunc = function() return unpack(UF.SV.Target_FontColour_Hostile) end,
                setFunc = function(r,g,b,a) UF.SV.Target_FontColour_Hostile={r,g,b} end,
                width = "full",
                default = { r=UF.D.Target_FontColour_Hostile[1], g=UF.D.Target_FontColour_Hostile[2], b=UF.D.Target_FontColour_Hostile[3] },
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Apply same settings to reticle
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLOR),
                tooltip = GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLOR_TP),
                getFunc = function() return UF.SV.ReticleColourByReaction end,
                setFunc = UF.ReticleColourByReaction,
                width = "full",
                default = UF.D.ReticleColourByReaction,
                disabled = function() return not LUIE.SV.UnitFrames_Enabled end,
            },
            {
                -- Interactible Reticle Color
                type = "colorpicker",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_UF_COMMON_RETICLECOLORINTERACT)),
                getFunc = function() return unpack(UF.SV.ReticleColour_Interact) end,
                setFunc = function(r,g,b,a) UF.SV.ReticleColour_Interact={r,g,b} end,
                width = "full",
                default = { r=UF.D.ReticleColour_Interact[1], g=UF.D.ReticleColour_Interact[2], b=UF.D.ReticleColour_Interact[3] },
                disabled = function() return not (LUIE.SV.UnitFrames_Enabled and UF.SV.ReticleColourByReaction) end,
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.UnitFrames_Enabled then
        LAM:RegisterAddonPanel('LUIEUnitFramesOptions', panelDataUnitFrames)
        LAM:RegisterOptionControls('LUIEUnitFramesOptions', optionsDataUnitFrames)
    end
end
