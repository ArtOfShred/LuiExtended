--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE
local InfoPanel = LUIE.InfoPanel

local zo_strformat = zo_strformat

-- Create Settings Menu
function InfoPanel.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibAddonMenu2
    if LAM == nil then
        return
    end

    local Defaults = InfoPanel.Defaults
    local Settings = InfoPanel.SV

    local panelDataInfoPanel =
    {
        type = "panel",
        name = zo_strformat("<<1>> - <<2>>", LUIE.name, GetString(LUIE_STRING_LAM_PNL)),
        displayName = zo_strformat("<<1>> <<2>>", LUIE.name, GetString(LUIE_STRING_LAM_PNL)),
        author = LUIE.author .. "\n",
        version = LUIE.version,
        website = LUIE.website,
        feedback = LUIE.feedback,
        translation = LUIE.translation,
        donation = LUIE.donation,
        slashCommand = "/luiip",
        registerForRefresh = true,
        registerForDefaults = false,
    }

    local optionsDataInfoPanel = {}

    -- Info Panel description
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] =
    {
        type = "description",
        text = GetString(LUIE_STRING_LAM_PNL_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] =
    {
        type = "button",
        name = GetString(LUIE_STRING_LAM_RELOADUI),
        tooltip = GetString(LUIE_STRING_LAM_RELOADUI_BUTTON),
        func = function ()
            ReloadUI("ingame")
        end,
        width = "full",
    }

    -- Unlock InfoPanel
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] =
    {
        type = "checkbox",
        name = GetString(LUIE_STRING_LAM_PNL_UNLOCKPANEL),
        tooltip = GetString(LUIE_STRING_LAM_PNL_UNLOCKPANEL_TP),
        getFunc = function ()
            return InfoPanel.panelUnlocked
        end,
        setFunc = InfoPanel.SetMovingState,
        width = "half",
        default = false,
        disabled = function ()
            return not LUIE.SV.InfoPanel_Enabled
        end,
        resetFunc = InfoPanel.ResetPosition,
    }

    -- InfoPanel scale
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] =
    {
        type = "slider",
        name = GetString(LUIE_STRING_LAM_PNL_PANELSCALE),
        tooltip = GetString(LUIE_STRING_LAM_PNL_PANELSCALE_TP),
        min = 100,
        max = 300,
        step = 10,
        getFunc = function ()
            return Settings.panelScale
        end,
        setFunc = function (value)
            Settings.panelScale = value
            InfoPanel.SetScale()
        end,
        width = "full",
        default = 100,
        disabled = function ()
            return not LUIE.SV.InfoPanel_Enabled
        end,
    }

    -- Reset InfoPanel position
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] =
    {
        type = "button",
        name = GetString(LUIE_STRING_LAM_RESETPOSITION),
        tooltip = GetString(LUIE_STRING_LAM_PNL_RESETPOSITION_TP),
        func = InfoPanel.ResetPosition,
        width = "half",
    }

    -- Info Panel Options Submenu
    optionsDataInfoPanel[#optionsDataInfoPanel + 1] =
    {
        type = "submenu",
        name = GetString(LUIE_STRING_LAM_PNL_HEADER),
        controls =
        {
            {
                type = "header",
                name = GetString(LUIE_STRING_LAM_PNL_ELEMENTS_HEADER),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWLATENCY),
                getFunc = function ()
                    return not Settings.HideLatency
                end,
                setFunc = function (value)
                    Settings.HideLatency = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWCLOCK),
                getFunc = function ()
                    return not Settings.HideClock
                end,
                setFunc = function (value)
                    Settings.HideClock = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                -- Timestamp Format
                type = "editbox",
                name = zo_strformat("\t\t\t\t\t<<1>>", GetString(LUIE_STRING_LAM_PNL_CLOCKFORMAT)),
                tooltip = GetString(LUIE_STRING_LAM_CA_TIMESTAMPFORMAT_TP),
                getFunc = function ()
                    return Settings.ClockFormat
                end,
                setFunc = function (value)
                    Settings.ClockFormat = value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = Defaults.ClockFormat,
                disabled = function ()
                    return not (LUIE.SV.InfoPanel_Enabled and not Settings.HideClock)
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWFPS),
                getFunc = function ()
                    return not Settings.HideFPS
                end,
                setFunc = function (value)
                    Settings.HideFPS = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWMOUNTTIMER),
                tooltip = GetString(LUIE_STRING_LAM_PNL_SHOWMOUNTTIMER_TP),
                getFunc = function ()
                    return not Settings.HideMountFeed
                end,
                setFunc = function (value)
                    Settings.HideMountFeed = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWARMORDURABILITY),
                getFunc = function ()
                    return not Settings.HideArmour
                end,
                setFunc = function (value)
                    Settings.HideArmour = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWEAPONCHARGES),
                getFunc = function ()
                    return not Settings.HideWeapons
                end,
                setFunc = function (value)
                    Settings.HideWeapons = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWBAGSPACE),
                getFunc = function ()
                    return not Settings.HideBags
                end,
                setFunc = function (value)
                    Settings.HideBags = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_SHOWSOULGEMS),
                getFunc = function ()
                    return not Settings.HideGems
                end,
                setFunc = function (value)
                    Settings.HideGems = not value
                    InfoPanel.RearrangePanel()
                end,
                width = "full",
                default = true,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "header",
                name = GetString(SI_PLAYER_MENU_MISC),
                width = "full",
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_DISPLAYONWORLDMAP),
                tooltip = GetString(LUIE_STRING_LAM_PNL_DISPLAYONWORLDMAP_TP),
                getFunc = function ()
                    return Settings.DisplayOnWorldMap
                end,
                setFunc = function (value)
                    Settings.DisplayOnWorldMap = value
                    InfoPanel.SetDisplayOnMap()
                end,
                width = "full",
                default = false,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
            {
                type = "checkbox",
                name = GetString(LUIE_STRING_LAM_PNL_DISABLECOLORSRO),
                tooltip = GetString(LUIE_STRING_LAM_PNL_DISABLECOLORSRO_TP),
                getFunc = function ()
                    return Settings.DisableInfoColours
                end,
                setFunc = function (value)
                    Settings.DisableInfoColours = value
                end,
                width = "full",
                default = false,
                disabled = function ()
                    return not LUIE.SV.InfoPanel_Enabled
                end,
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.InfoPanel_Enabled then
        LAM:RegisterAddonPanel(LUIE.name .. "InfoPanelOptions", panelDataInfoPanel)
        LAM:RegisterOptionControls(LUIE.name .. "InfoPanelOptions", optionsDataInfoPanel)
    end
end
