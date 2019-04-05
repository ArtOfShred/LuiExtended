--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local PNL = LUIE.InfoPanel

local strformat = zo_strformat

local optionsDataInfoPanel = {}

-- Create Settings Menu
function PNL.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibStub("LibAddonMenu-2.0")

    local panelDataInfoPanel = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_PNL)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_PNL), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        slashCommand = "/luiip",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    -- Info Panel description
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_PNL_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Unlock InfoPanel
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "checkbox",
        name = GetString(SI_LUIE_LAM_PNL_UNLOCKPANEL),
        tooltip = GetString(SI_LUIE_LAM_PNL_UNLOCKPANEL_TP),
        getFunc = function() return PNL.panelUnlocked end,
        setFunc = PNL.SetMovingState,
        width = "half",
        default = false,
        disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
        resetFunc = PNL.ResetPosition,
    }

    -- InfoPanel scale
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "slider",
        name = GetString(SI_LUIE_LAM_PNL_PANELSCALE),
        tooltip = GetString(SI_LUIE_LAM_PNL_PANELSCALE_TP),
        min = 100, max = 300, step = 10,
        getFunc = function() return PNL.SV.panelScale end,
        setFunc = function(value) PNL.SV.panelScale = value PNL.SetScale() end,
        width = "full",
        default = 100,
        disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
    }

    -- Reset InfoPanel position
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RESETPOSITION),
        tooltip = GetString(SI_LUIE_LAM_PNL_RESETPOSITION_TP),
        func = PNL.ResetPosition,
        width = "half",
    }

    -- Info Panel Options Submenu
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_PNL_HEADER),
        controls = {
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_PNL_ELEMENTS_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWLATENCY),
                getFunc = function() return not PNL.SV.HideLatency end,
                setFunc = function(value) PNL.SV.HideLatency = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWCLOCK),
                getFunc = function() return not PNL.SV.HideClock end,
                setFunc = function(value) PNL.SV.HideClock = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWFPS),
                getFunc = function() return not PNL.SV.HideFPS end,
                setFunc = function(value) PNL.SV.HideFPS = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWMOUNTTIMER),
                tooltip = GetString(SI_LUIE_LAM_PNL_SHOWMOUNTTIMER_TP),
                getFunc = function() return not PNL.SV.HideMountFeed end,
                setFunc = function(value) PNL.SV.HideMountFeed = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWARMORDURABILITY),
                getFunc = function() return not PNL.SV.HideArmour end,
                setFunc = function(value) PNL.SV.HideArmour = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWEAPONCHARGES),
                getFunc = function() return not PNL.SV.HideWeapons end,
                setFunc = function(value) PNL.SV.HideWeapons = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWBAGSPACE),
                getFunc = function() return not PNL.SV.HideBags end,
                setFunc = function(value) PNL.SV.HideBags = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_SHOWSOULGEMS),
                getFunc = function() return not PNL.SV.HideGems end,
                setFunc = function(value) PNL.SV.HideGems = not value PNL.RearrangePanel() end,
                width = "full",
                default = true,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "header",
                name = GetString(SI_PLAYER_MENU_MISC),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_DISPLAYONWORLDMAP),
                tooltip = GetString(SI_LUIE_LAM_PNL_DISPLAYONWORLDMAP_TP),
                getFunc = function() return PNL.SV.DisplayOnWorldMap end,
                setFunc = function(value) PNL.SV.DisplayOnWorldMap = value PNL.SetDisplayOnMap() end,
                width = "full",
                default = false,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
            {
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_PNL_DISABLECOLORSRO),
                tooltip = GetString(SI_LUIE_LAM_PNL_DISABLECOLORSRO_TP),
                getFunc = function() return PNL.SV.DisableInfoColours end,
                setFunc = function(value) PNL.SV.DisableInfoColours = value end,
                width = "full",
                default = false,
                disabled = function() return not LUIE.SV.InfoPanel_Enabled end,
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.InfoPanel_Enabled then
        LAM:RegisterAddonPanel('LUIEInfoPanelOptions', panelDataInfoPanel)
        LAM:RegisterOptionControls('LUIEInfoPanelOptions', optionsDataInfoPanel)
    end
end
