--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local CT = LUIE.CombatText
local CTC = LUIE.CombatTextConstants

local strformat = zo_strformat

local optionsDataCombatText = {}

-- Get fonts
local FontsList = {}
for f in pairs(LUIE.Fonts) do
    table.insert(FontsList, f)
end

function CT.CreateSettings()
    -- Load LibAddonMenu
    local LAM = LibStub("LibAddonMenu-2.0")
    -- Load LibMediaProvider
    local LMP = LibStub("LibMediaProvider-1.0")

    local panelDataCombatText = {
        type = "panel",
        name = strformat("<<1>> - <<2>>", LUIE.name, GetString(SI_LUIE_LAM_CT)),
        displayName = strformat(LUIE.name, GetString(SI_LUIE_LAM_CT), GetString(SI_GAME_MENU_SETTINGS)),
        author = LUIE.author,
        version = LUIE.version,
        website = LUIE.website,
        slashCommand = "/luict",
        registerForRefresh = true,
        registerForDefaults = true,
    }

    -- Combat Text Description
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "description",
        text = GetString(SI_LUIE_LAM_CT_DESCRIPTION),
    }

    -- ReloadUI Button
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "button",
        name = GetString(SI_LUIE_LAM_RELOADUI),
        tooltip = GetString(SI_LUIE_LAM_RELOADUI_BUTTON),
        func = function() ReloadUI("ingame") end,
        width = "full",
    }

    -- Unlock Panels
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type    = "checkbox",
        width = "half",
        name    = GetString(SI_LUIE_LAM_CT_UNLOCK),
        tooltip = GetString(SI_LUIE_LAM_CT_UNLOCK_TP),
        default = CT.D.unlocked,
        getFunc = function() return CT.SV.unlocked end,
        setFunc = function()
            CT.SV.unlocked = not CT.SV.unlocked
            for k, _ in pairs (CT.SV.panels) do
                _G[k]:SetMouseEnabled(CT.SV.unlocked)
                _G[k]:SetMovable(CT.SV.unlocked)
                _G[k .. '_Backdrop']:SetHidden(not CT.SV.unlocked)
                _G[k .. '_Label']:SetHidden(not CT.SV.unlocked)
            end
        end,
    }

    -- Combat Text - Common Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_UF_COMMON_HEADER),
        controls = {
            {
                -- In Combat Only
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_IC_ONLY),
                tooltip = GetString(SI_LUIE_LAM_CT_IC_ONLY_TP),
                getFunc = function() return CT.SV.toggles.inCombatOnly end,
                setFunc = function(v) CT.SV.toggles.inCombatOnly = v end,
                default = CT.D.toggles.inCombatOnly,
            },
            {
                -- Transparency
                type = "slider",
                name = GetString(SI_LUIE_LAM_CT_TRANSPARENCY),
                tooltip = GetString(SI_LUIE_LAM_CT_TRANSPARENCY_TP),
                min = 0,
                max = 100,
                getFunc = function() return CT.SV.common.transparencyValue end,
                setFunc = function(v) CT.SV.common.transparencyValue = v end,
                default = CT.D.common.transparencyValue,
            },
            {
                -- Abbreviate Numbers
                type = "checkbox",
                name = GetString(SI_LUIE_LAM_CT_ABBREVIATE),
                tooltip = GetString(SI_LUIE_LAM_CT_ABBREVIATE_TP),
                getFunc = function() return CT.SV.common.abbreviateNumbers end,
                setFunc = function(v) CT.SV.common.abbreviateNumbers = v end,
                default = CT.D.common.abbreviateNumbers,
            },
        },
    }

    -- Combat Text - Damage & Healing Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_DAMAGE_AND_HEALING), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                width = "full",
            },
            {
                -- Damage (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_TP),
                getFunc = function() return CT.SV.toggles.incoming.showDamage end,
                setFunc = function(v) CT.SV.toggles.incoming.showDamage = v end,
                default = CT.D.toggles.incoming.showDamage,
            },
            {
                -- Damage (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showDamage end,
                setFunc = function(v) CT.SV.toggles.outgoing.showDamage = v end,
                default = CT.D.toggles.outgoing.showDamage,
            },
            {
                -- Damage Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_TP),
                getFunc = function() return CT.SV.formats.damage end,
                setFunc = function(v) CT.SV.formats.damage = v end,
                isMultiline = false,
                default = CT.D.formats.damage,
            },
            {
                -- Damage Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_CRITICAL_TP),
                getFunc = function() return CT.SV.formats.damagecritical end,
                setFunc = function(v) CT.SV.formats.damagecritical = v end,
                isMultiline = false,
                default = CT.D.formats.damagecritical,
            },
            {
                -- Damage Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DAMAGE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.damage end,
                setFunc = function(size) CT.SV.fontSizes.damage = size end,
                default = CT.D.fontSizes.damage,
            },
            {
                -- Damage Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DAMAGE_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.damagecritical end,
                setFunc = function(size) CT.SV.fontSizes.damagecritical = size end,
                default = CT.D.fontSizes.damagecritical,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                width = "full",
            },
            {
                -- Damage over Time (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DOT_TP),
                getFunc = function() return CT.SV.toggles.incoming.showDot end,
                setFunc = function(v) CT.SV.toggles.incoming.showDot = v end,
                default = CT.D.toggles.incoming.showDot,
            },
            {
                -- Damage over Time (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DOT_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showDot end,
                setFunc = function(v) CT.SV.toggles.outgoing.showDot = v end,
                default = CT.D.toggles.outgoing.showDot,
            },
            {
                -- Damage over Time Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_TP),
                getFunc = function() return CT.SV.formats.dot end,
                setFunc = function(v) CT.SV.formats.dot = v end,
                isMultiline = false,
                default = CT.D.formats.dot,
            },
            {
                -- Damage over Time Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DOT_CRITICAL_TP),
                getFunc = function() return CT.SV.formats.dotcritical end,
                setFunc = function(v) CT.SV.formats.dotcritical = v end,
                isMultiline = false,
                default = CT.D.formats.dotcritical,
            },
            {
                -- Damage over Time Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DOT_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.dot end,
                setFunc = function(size) CT.SV.fontSizes.dot = size end,
                default = CT.D.fontSizes.dot,
            },
            {
                -- Damage over Time Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_DOT_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.dotcritical end,
                setFunc = function(size) CT.SV.fontSizes.dotcritical = size end,
                default = CT.D.fontSizes.dotcritical,
            },
            {
                -- Damage Color Options
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_DAMAGE_COLOR),
                width = "full",
            },
            {
                -- None
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_NONE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_NONE_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[0]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[0] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[0][1], g=CT.D.colors.damage[0][2], b=CT.D.colors.damage[0][3]}
            },
            {
                -- Generic
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_GENERIC_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[1]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[1] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[1][1], g=CT.D.colors.damage[1][2], b=CT.D.colors.damage[1][3]}
            },
            {
                -- Physical
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_PHYSICAL_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[2]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[2] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[2][1], g=CT.D.colors.damage[2][2], b=CT.D.colors.damage[2][3]}
            },
            {
                -- Fire
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_FIRE_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[3]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[3] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[3][1], g=CT.D.colors.damage[3][2], b=CT.D.colors.damage[3][3]}
            },
            {
                -- Shock
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHOCK_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[4]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[4] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[4][1], g=CT.D.colors.damage[4][2], b=CT.D.colors.damage[4][3]}
            },
            {
                -- Oblivion
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OBLIVION_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[5]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[5] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[5][1], g=CT.D.colors.damage[5][2], b=CT.D.colors.damage[5][3]}
            },
            {
                -- Cold
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_COLD_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[6]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[6] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[6][1], g=CT.D.colors.damage[6][2], b=CT.D.colors.damage[6][3]}
            },
            {
                -- Eearth
                type     = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_EARTH_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[7]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[7] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[7][1], g=CT.D.colors.damage[7][2], b=CT.D.colors.damage[7][3]}
            },
            {
                -- Magic
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_MAGIC_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[8]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[8] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[8][1], g=CT.D.colors.damage[8][2], b=CT.D.colors.damage[8][3]}
            },
            {
                -- Drown
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DROWN_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[9]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[9] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[9][1], g=CT.D.colors.damage[9][2], b=CT.D.colors.damage[9][3]}
            },
            {
                -- Disease
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_DISEASE_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[10]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[10] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[10][1], g=CT.D.colors.damage[10][2], b=CT.D.colors.damage[10][3]}
            },
            {
                -- Poison
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_POISON_TP),
                getFunc = function() return unpack(CT.SV.colors.damage[11]) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damage[11] = { r, g, b, a } end,
                default = {r=CT.D.colors.damage[11][1], g=CT.D.colors.damage[11][2], b=CT.D.colors.damage[11][3]}
            },
            {
                -- Checkbox Critical Damage Override
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_OVERRIDE_TP),
                getFunc = function() return CT.SV.toggles.criticalDamageOverride end,
                setFunc = function(v) CT.SV.toggles.criticalDamageOverride = v end,
                default = CT.D.toggles.criticalDamageOverride,
            },
            {
                -- Color Critical Damage Override
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_DAMAGE_COLOR_TP),
                getFunc = function() return unpack(CT.SV.colors.criticalDamageOverride) end,
                setFunc = function(r, g, b, a) CT.SV.colors.criticalDamageOverride = { r, g, b, a } end,
                default = {r=CT.D.colors.criticalDamageOverride[1], g=CT.D.colors.criticalDamageOverride[2], b=CT.D.colors.criticalDamageOverride[3]}
            },
            {
                -- Checkbox Incoming Damage Override
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_OVERRIDE_TP),
                getFunc = function() return CT.SV.toggles.incomingDamageOverride end,
                setFunc = function(v) CT.SV.toggles.incomingDamageOverride = v end,
                default = CT.D.toggles.incomingDamageOverride
            },
            {
                -- Color Incoming Damage Override
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INCOMING_COLOR_TP),
                getFunc = function() return unpack(CT.SV.colors.incomingDamageOverride) end,
                setFunc = function(r, g, b, a) CT.SV.colors.incomingDamageOverride = { r, g, b, a } end,
                default = {r=CT.D.colors.incomingDamageOverride[1], g=CT.D.colors.incomingDamageOverride[2], b=CT.D.colors.incomingDamageOverride[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                width = "full",
            },
            {
                -- Healing (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HEALING), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HEALING_TP),
                getFunc = function() return CT.SV.toggles.incoming.showHealing end,
                setFunc = function(v) CT.SV.toggles.incoming.showHealing = v end,
                default = CT.D.toggles.incoming.showHealing,
            },
            {
                -- Healing (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HEALING), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HEALING_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showHealing end,
                setFunc = function(v) CT.SV.toggles.outgoing.showHealing = v end,
                default = CT.D.toggles.outgoing.showHealing,
            },
            {
                -- Healing Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_TP),
                getFunc = function() return CT.SV.formats.healing end,
                setFunc = function(v) CT.SV.formats.healing = v end,
                isMultiline = false,
                default = CT.D.formats.healing,
            },
            {
                -- Healing Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HEALING_CRITICAL_TP),
                getFunc = function() return CT.SV.formats.healingcritical end,
                setFunc = function(v) CT.SV.formats.healingcritical = v end,
                isMultiline = false,
                default = CT.D.formats.healingcritical,
            },
            {
                -- Healing Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HEALING_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.healing end,
                setFunc = function(size) CT.SV.fontSizes.healing = size end,
                default = CT.D.fontSizes.healing,
            },
            {
                -- Healing Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HEALING_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.healingcritical end,
                setFunc = function(size) CT.SV.fontSizes.healingcritical = size end,
                default = CT.D.fontSizes.healingcritical,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                width = "full",
            },
            {
                -- Healing over Time (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_HOT_TP),
                getFunc = function() return CT.SV.toggles.incoming.showHot end,
                setFunc = function(v) CT.SV.toggles.incoming.showHot = v end,
                default = CT.D.toggles.incoming.showHot,
            },
            {
                -- Healing over Time (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_HOT_ABV), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_HOT_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showHot end,
                setFunc = function(v) CT.SV.toggles.outgoing.showHot = v end,
                default = CT.D.toggles.outgoing.showHot,
            },
            {
                -- Healing over Time Format
                type    = "editbox",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_TP),
                getFunc = function() return CT.SV.formats.hot end,
                setFunc = function(v) CT.SV.formats.hot = v end,
                isMultiline = false,
                default = CT.D.formats.hot,
            },
            {
                -- Healing over Time Critical Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_HOT_CRITICAL_TP),
                getFunc = function() return CT.SV.formats.hotcritical end,
                setFunc = function(v) CT.SV.formats.hotcritical = v end,
                isMultiline = false,
                default = CT.D.formats.hotcritical,
            },
            {
                -- Healing over Time Font Size
                type    = "slider",
                width   = "half",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HOT_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.hot end,
                setFunc = function(size) CT.SV.fontSizes.hot = size end,
                default = CT.D.fontSizes.hot,
            },
            {
                -- Healing over Time Critical Font Size
                type    = "slider",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_FONT_SIZE), GetString(SI_LUIE_LAM_CT_SHARED_CRITICAL)),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_HOT_CRITICAL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.hotcritical end,
                setFunc = function(size) CT.SV.fontSizes.hotcritical = size end,
                default = CT.D.fontSizes.hotcritical,
            },
            {
                -- Healing Color Options
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_HEALING_COLOR),
                width = "full",
            },
            {
                -- Healing
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_TP),
                getFunc = function() return unpack(CT.SV.colors.healing) end,
                setFunc = function(r, g, b, a) CT.SV.colors.healing = { r, g, b, a } end,
                default = {r=CT.D.colors.healing[1], g=CT.D.colors.healing[2], b=CT.D.colors.healing[3]}
            },
            {
                -- Checkbox Critical Healing Override
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_HEALING_OVERRIDE_TP),
                getFunc = function() return CT.SV.toggles.criticalHealingOverride end,
                setFunc = function(v) CT.SV.toggles.criticalHealingOverride = v end,
                default = CT.D.toggles.criticalHealingOverride
            },
            {
                -- Color Critical Healing Override
                type    = "colorpicker",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_CRIT_HEALING_COLOR_TP),
                getFunc = function() return unpack(CT.SV.colors.criticalHealingOverride) end,
                setFunc = function(r, g, b, a) CT.SV.colors.criticalHealingOverride = { r, g, b, a } end,
                default = {r=CT.D.colors.criticalHealingOverride[1], g=CT.D.colors.criticalHealingOverride[2], b=CT.D.colors.criticalHealingOverride[3]}
            },
        },
    }

    -- Combat Text - Resource Gain & Drain Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_RESOURCE_GAIN_DRAIN), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Gain Loss Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_GAIN_LOSS_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.gainLoss end,
                setFunc = function(size) CT.SV.fontSizes.gainLoss = size end,
                default = CT.D.fontSizes.gainLoss,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE),
                width = "full",
            },
            {
                -- Resource Gain (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_TP),
                getFunc = function() return CT.SV.toggles.incoming.showEnergize end,
                setFunc = function(v) CT.SV.toggles.incoming.showEnergize = v end,
                default = CT.D.toggles.incoming.showEnergize,
            },
            {
                -- Resource Gain (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showEnergize end,
                setFunc = function(v) CT.SV.toggles.outgoing.showEnergize = v end,
                default = CT.D.toggles.outgoing.showEnergize,
            },
            {
                -- Resource Gain Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_TP),
                getFunc = function() return CT.SV.formats.energize end,
                setFunc = function(v) CT.SV.formats.energize = v end,
                isMultiline = false,
                default = CT.D.formats.energize,
            },
            {
                -- Gain Magicka Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_MAGICKA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_MAGICKA_TP),
                getFunc = function() return unpack(CT.SV.colors.energizeMagicka) end,
                setFunc = function(r, g, b, a) CT.SV.colors.energizeMagicka = { r, g, b, a } end,
                default = {r=CT.D.colors.energizeMagicka[1], g=CT.D.colors.energizeMagicka[2], b=CT.D.colors.energizeMagicka[3]}
            },
            {
                -- Gain Stamina Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_STAMINA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_STAMINA_TP),
                getFunc = function() return unpack(CT.SV.colors.energizeStamina) end,
                setFunc = function(r, g, b, a) CT.SV.colors.energizeStamina = { r, g, b, a } end,
                default = {r=CT.D.colors.energizeStamina[1], g=CT.D.colors.energizeStamina[2], b=CT.D.colors.energizeStamina[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE),
                width = "full",
            },
            {
                -- Ultimate Gain (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return CT.SV.toggles.incoming.showUltimateEnergize end,
                setFunc = function(v) CT.SV.toggles.incoming.showUltimateEnergize = v end,
                default = CT.D.toggles.incoming.showUltimateEnergize,
            },
            {
                -- Ultimate Gain (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ENERGIZE_ULTIMATE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showUltimateEnergize end,
                setFunc = function(v) CT.SV.toggles.outgoing.showUltimateEnergize = v end,
                default = CT.D.toggles.outgoing.showUltimateEnergize,
            },
            {
                -- Ultimate Gain Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return CT.SV.formats.ultimateEnergize end,
                setFunc = function(v) CT.SV.formats.ultimateEnergize = v end,
                isMultiline = false,
                default = CT.D.formats.ultimateEnergize,
            },
            {
                -- Gain Ultimate Color
                type    = "colorpicker",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_ENERGIZE_ULTIMATE_TP),
                getFunc = function() return unpack(CT.SV.colors.energizeUltimate) end,
                setFunc = function(r, g, b, a) CT.SV.colors.energizeUltimate = { r, g, b, a } end,
                default = {r=CT.D.colors.energizeUltimate[1], g=CT.D.colors.energizeUltimate[2], b=CT.D.colors.energizeUltimate[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DRAIN),
                width = "full",
            },
            {
                -- Resource Drain (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DRAIN), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DRAIN_TP),
                getFunc = function() return CT.SV.toggles.incoming.showDrain end,
                setFunc = function(v) CT.SV.toggles.incoming.showDrain = v end,
                default = CT.D.toggles.incoming.showDrain,
            },
            {
                -- Resource Drain (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DRAIN), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DRAIN_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showDrain end,
                setFunc = function(v) CT.SV.toggles.outgoing.showDrain = v end,
                default = CT.D.toggles.outgoing.showDrain,
            },
            {
                -- Resource Damage Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DRAIN_TP),
                getFunc = function() return CT.SV.formats.drain end,
                setFunc = function(v) CT.SV.formats.drain = v end,
                isMultiline = false,
                default = CT.D.formats.drain,
            },
            {
                -- Drain Magicka Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_MAGICKA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_MAGICKA_TP),
                getFunc = function() return unpack(CT.SV.colors.drainMagicka) end,
                setFunc = function(r, g, b, a) CT.SV.colors.drainMagicka = { r, g, b, a } end,
                default = {r=CT.D.colors.drainMagicka[1], g=CT.D.colors.drainMagicka[2], b=CT.D.colors.drainMagicka[3]}
            },
            {
                -- Drain Stamina Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_STAMINA), GetString(SI_LUIE_LAM_CT_SHARED_COLOR)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DRAIN_STAMINA_TP),
                getFunc = function() return unpack(CT.SV.colors.drainStamina) end,
                setFunc = function(r, g, b, a) CT.SV.colors.drainStamina = { r, g, b, a } end,
                default = {r=CT.D.colors.drainStamina[1], g=CT.D.colors.drainStamina[2], b=CT.D.colors.drainStamina[3]}
            },
        },
    }

    -- Combat Text - Mitigation Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_MITIGATION), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Mitigation Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_MITIGATION_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.mitigation end,
                setFunc = function(size) CT.SV.fontSizes.mitigation = size end,
                default = CT.D.fontSizes.mitigation,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_MISS),
                width = "full",
            },
            {
                -- Missed (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_MISS), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_MISS_TP),
                getFunc = function() return CT.SV.toggles.incoming.showMiss end,
                setFunc = function(v) CT.SV.toggles.incoming.showMiss = v end,
                default = CT.D.toggles.incoming.showMiss
            },
            {
                -- Missed (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_MISS), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_MISS_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showMiss end,
                setFunc = function(v) CT.SV.toggles.outgoing.showMiss = v end,
                default = CT.D.toggles.outgoing.showMiss,
            },
            {
                -- Missed (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_MISS_TP),
                getFunc = function() return CT.SV.formats.miss end,
                setFunc = function(v) CT.SV.formats.miss = v end,
                isMultiline = false,
                default = CT.D.formats.miss,
            },
            {
                -- Missed (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_MISS_TP),
                getFunc = function() return unpack(CT.SV.colors.miss) end,
                setFunc = function(r, g, b, a) CT.SV.colors.miss = { r, g, b, a } end,
                default = {r=CT.D.colors.miss[1], g=CT.D.colors.miss[2], b=CT.D.colors.miss[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE),
                width = "full",
            },
            {
                -- Immune (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_IMMUNE_TP),
                getFunc = function() return CT.SV.toggles.incoming.showImmune end,
                setFunc = function(v) CT.SV.toggles.incoming.showImmune = v end,
                default = CT.D.toggles.incoming.showImmune,
            },
            {
                -- Immune (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_IMMUNE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_IMMUNE_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showImmune end,
                setFunc = function(v) CT.SV.toggles.outgoing.showImmune = v end,
                default = CT.D.toggles.outgoing.showImmune,
            },
            {
                -- Immune (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_IMMUNE_TP),
                getFunc = function() return CT.SV.formats.immune end,
                setFunc = function(v) CT.SV.formats.immune = v end,
                isMultiline = false,
                default = CT.D.formats.immune,
            },
            {
                -- Immune (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_IMMUNE_TP),
                getFunc = function() return unpack(CT.SV.colors.immune) end,
                setFunc = function(r, g, b, a) CT.SV.colors.immune = { r, g, b, a } end,
                default = {r=CT.D.colors.immune[1], g=CT.D.colors.immune[2], b=CT.D.colors.immune[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_PARRIED),
                width = "full",
            },
            {
                -- Parried (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_PARRIED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_PARRIED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showParried end,
                setFunc = function(v) CT.SV.toggles.incoming.showParried = v end,
                default = CT.D.toggles.incoming.showParried,
            },
            {
                -- Parried (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_PARRIED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_PARRIED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showParried end,
                setFunc = function(v) CT.SV.toggles.outgoing.showParried = v end,
                default = CT.D.toggles.outgoing.showParried,
            },
            {
                -- Parried (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_PARRIED_TP),
                getFunc = function() return CT.SV.formats.parried end,
                setFunc = function(v) CT.SV.formats.parried = v end,
                isMultiline = false,
                default = CT.D.formats.parried,
            },
            {
                -- Parried (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_PARRIED_TP),
                getFunc = function() return unpack(CT.SV.colors.parried) end,
                setFunc = function(r, g, b, a) CT.SV.colors.parried = { r, g, b, a } end,
                default = {r=CT.D.colors.parried[1], g=CT.D.colors.parried[2], b=CT.D.colors.parried[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED),
                width = "full",
            },
            {
                -- Reflected (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_REFLECTED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showReflected end,
                setFunc = function(v) CT.SV.toggles.incoming.showReflected = v end,
                default = CT.D.toggles.incoming.showReflected,
            },
            {
                -- Reflected (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_REFLECTED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_REFLECTED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showReflected end,
                setFunc = function(v) CT.SV.toggles.outgoing.showReflected = v end,
                default = CT.D.toggles.outgoing.showReflected,
            },
            {
                -- Reflected (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_REFLECTED_TP),
                getFunc = function() return CT.SV.formats.reflected end,
                setFunc = function(v) CT.SV.formats.reflected = v end,
                isMultiline = false,
                default = CT.D.formats.reflected,
            },
            {
                -- Reflected (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_REFLETCED_TP),
                getFunc = function() return unpack(CT.SV.colors.reflected) end,
                setFunc = function(r, g, b, a) CT.SV.colors.reflected = { r, g, b, a } end,
                default = {r=CT.D.colors.reflected[1], g=CT.D.colors.reflected[2], b=CT.D.colors.reflected[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD),
                width = "full",
            },
            {
                -- Damage Shielded (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DAMAGE_SHIELD_TP),
                getFunc = function() return CT.SV.toggles.incoming.showDamageShield end,
                setFunc = function(v) CT.SV.toggles.incoming.showDamageShield = v end,
                default = CT.D.toggles.incoming.showDamageShield,
            },
            {
                -- Damage Shielded (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE_SHIELD), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DAMAGE_SHIELD_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showDamageShield end,
                setFunc = function(v) CT.SV.toggles.outgoing.showDamageShield = v end,
                default = CT.D.toggles.outgoing.showDamageShield,
            },
            {
                -- Damage Shielded (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DAMAGE_SHIELD_TP),
                getFunc = function() return CT.SV.formats.damageShield end,
                setFunc = function(v) CT.SV.formats.damageShield = v end,
                isMultiline = false,
                default = CT.D.formats.damageShield,
            },
            {
                -- Damage Shielded (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DAMAGE_SHIELD_TP),
                getFunc = function() return unpack(CT.SV.colors.damageShield) end,
                setFunc = function(r, g, b, a) CT.SV.colors.damageShield = { r, g, b, a } end,
                default = {r=CT.D.colors.damageShield[1], g=CT.D.colors.damageShield[2], b=CT.D.colors.damageShield[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DODGED),
                width = "full",
            },
            {
                -- Dodged (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DODGED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DODGED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showDodged end,
                setFunc = function(v) CT.SV.toggles.incoming.showDodged = v end,
                default = CT.D.toggles.incoming.showDodged,
            },
            {
                -- Dodged (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DODGED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DODGED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showDodged end,
                setFunc = function(v) CT.SV.toggles.outgoing.showDodged = v end,
                default = CT.D.toggles.outgoing.showDodged,
            },
            {
                -- Dodged (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DODGED_TP),
                getFunc = function() return CT.SV.formats.dodged end,
                setFunc = function(v) CT.SV.formats.dodged = v end,
                isMultiline = false,
                default = CT.D.formats.dodged,
            },
            {
                -- Dodged (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DODGED_TP),
                getFunc = function() return unpack(CT.SV.colors.dodged) end,
                setFunc = function(r, g, b, a) CT.SV.colors.dodged = { r, g, b, a } end,
                default = {r=CT.D.colors.dodged[1], g=CT.D.colors.dodged[2], b=CT.D.colors.dodged[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED),
                width = "full",
            },
            {
                -- Blocked (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_BLOCKED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showBlocked end,
                setFunc = function(v) CT.SV.toggles.incoming.showBlocked = v end,
                default = CT.D.toggles.incoming.showBlocked,
            },
            {
                -- Blocked (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_BLOCKED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_BLOCKED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showBlocked end,
                setFunc = function(v) CT.SV.toggles.outgoing.showBlocked = v end,
                default = CT.D.toggles.outgoing.showBlocked,
            },
            {
                -- Blocked (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_BLOCKED_TP),
                getFunc = function() return CT.SV.formats.blocked end,
                setFunc = function(v) CT.SV.formats.blocked = v end,
                isMultiline = false,
                default = CT.D.formats.blocked,
            },
            {
                -- Blocked (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_BLOCKED_TP),
                getFunc = function() return unpack(CT.SV.colors.blocked) end,
                setFunc = function(r, g, b, a) CT.SV.colors.blocked = { r, g, b, a } end,
                default = {r=CT.D.colors.blocked[1], g=CT.D.colors.blocked[2], b=CT.D.colors.blocked[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED),
                width = "full",
            },
            {
                -- Interrupted (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_INTERRUPTED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showInterrupted end,
                setFunc = function(v) CT.SV.toggles.incoming.showInterrupted = v end,
                default = CT.D.toggles.incoming.showInterrupted,
            },
            {
                -- Interrupted (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_INTERRUPTED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_INTERRUPTED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showInterrupted end,
                setFunc = function(v) CT.SV.toggles.outgoing.showInterrupted = v end,
                default = CT.D.toggles.outgoing.showInterrupted,
            },
            {
                -- Interrupted (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_INTERRUPTED_TP),
                getFunc = function() return CT.SV.formats.interrupted end,
                setFunc = function(v) CT.SV.formats.interrupted = v end,
                isMultiline = false,
                default = CT.D.formats.interrupted,
            },
            {
                -- Interrupted (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_INTERRUPTED_TP),
                getFunc = function() return unpack(CT.SV.colors.interrupted) end,
                setFunc = function(r, g, b, a) CT.SV.colors.interrupted = { r, g, b, a } end,
                default = {r=CT.D.colors.interrupted[1], g=CT.D.colors.interrupted[2], b=CT.D.colors.interrupted[3]}
            },
        },
    }

    -- Combat Text - Crowd Control Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_CROWD_CONTROL), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Crowd Control Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_COMBAT_CROWD_CONTROL_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.crowdControl end,
                setFunc = function(size) CT.SV.fontSizes.crowdControl = size end,
                default = CT.D.fontSizes.crowdControl,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED),
                width = "full",
            },
            {
                -- Disoriented (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_DISORIENTED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showDisoriented end,
                setFunc = function(v) CT.SV.toggles.incoming.showDisoriented = v end,
                default = CT.D.toggles.incoming.showDisoriented,
            },
            {
                -- Disoriented (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_DISORIENTED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_DISORIENTED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showDisoriented end,
                setFunc = function(v) CT.SV.toggles.outgoing.showDisoriented = v end,
                default = CT.D.toggles.outgoing.showDisoriented,
            },
            {
                -- Disoriented (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_DISORIENTED_TP),
                getFunc = function() return CT.SV.formats.disoriented end,
                setFunc = function(v) CT.SV.formats.disoriented = v end,
                isMultiline = false,
                default = CT.D.formats.disoriented,
            },
            {
                -- Disoriented (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_DISORIENTED_TP),
                getFunc = function() return unpack(CT.SV.colors.disoriented) end,
                setFunc = function(r, g, b, a) CT.SV.colors.disoriented = { r, g, b, a } end,
                default = {r=CT.D.colors.disoriented[1], g=CT.D.colors.disoriented[2], b=CT.D.colors.disoriented[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_FEARED),
                width = "full",
            },
            {
                -- Feared (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_FEARED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_FEARED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showFeared end,
                setFunc = function(v) CT.SV.toggles.incoming.showFeared = v end,
                default = CT.D.toggles.incoming.showFeared,
            },
            {
                -- Feared (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_FEARED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_FEARED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showFeared end,
                setFunc = function(v) CT.SV.toggles.outgoing.showFeared = v end,
                default = CT.D.toggles.outgoing.showFeared,
            },
            {
                -- Feared (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_FEARED_TP),
                getFunc = function() return CT.SV.formats.feared end,
                setFunc = function(v) CT.SV.formats.feared = v end,
                isMultiline = false,
                default = CT.D.formats.feared,
            },
            {
                -- Feared (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_FEARED_TP),
                getFunc = function() return unpack(CT.SV.colors.feared) end,
                setFunc = function(r, g, b, a) CT.SV.colors.feared = { r, g, b, a } end,
                default = {r=CT.D.colors.feared[1], g=CT.D.colors.feared[2], b=CT.D.colors.feared[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE),
                width = "full",
            },
            {
                -- Off-Balance (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_OFF_BALANCE_TP),
                getFunc = function() return CT.SV.toggles.incoming.showOffBalanced end,
                setFunc = function(v) CT.SV.toggles.incoming.showOffBalanced = v end,
                default = CT.D.toggles.incoming.showOffBalanced,
            },
            {
                -- Off-Balance (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_OFF_BALANCE), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_OFF_BALANCE_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showOffBalanced end,
                setFunc = function(v) CT.SV.toggles.outgoing.showOffBalanced = v end,
                default = CT.D.toggles.outgoing.showOffBalanced,
            },
            {
                -- Off-Balanced (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_OFF_BALANCE_TP),
                getFunc = function() return CT.SV.formats.offBalanced end,
                setFunc = function(v) CT.SV.formats.offBalanced = v end,
                isMultiline = false,
                default = CT.D.formats.offBalanced,
            },
            {
                -- Off-Balanced (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_OFF_BALANCE_TP),
                getFunc = function() return unpack(CT.SV.colors.offBalanced) end,
                setFunc = function(r, g, b, a) CT.SV.colors.offBalanced = { r, g, b, a } end,
                default = {r=CT.D.colors.offBalanced[1], g=CT.D.colors.offBalanced[2], b=CT.D.colors.offBalanced[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_SILENCED),
                width = "full",
            },
            {
                -- Silenced (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_SILENCED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_SILENCED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showSilenced end,
                setFunc = function(v) CT.SV.toggles.incoming.showSilenced = v end,
                default = CT.D.toggles.incoming.showSilenced,
            },
            {
                -- Silenced (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_SILENCED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_SILENCED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showSilenced end,
                setFunc = function(v) CT.SV.toggles.outgoing.showSilenced = v end,
                default = CT.D.toggles.outgoing.showSilenced,
            },
            {
                -- Silenced (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_SILENCED_TP),
                getFunc = function() return CT.SV.formats.silenced end,
                setFunc = function(v) CT.SV.formats.silenced = v end,
                isMultiline = false,
                default = CT.D.formats.silenced,
            },
            {
                -- Silenced (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_SILENCED_TP),
                getFunc = function() return unpack(CT.SV.colors.silenced) end,
                setFunc = function(r, g, b, a) CT.SV.colors.silenced = { r, g, b, a } end,
                default = {r=CT.D.colors.silenced[1], g=CT.D.colors.silenced[2], b=CT.D.colors.silenced[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_STUNNED),
                width = "full",
            },
            {
                -- Stunned (Incoming)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_STUNNED), GetString(SI_LUIE_LAM_CT_SHARED_INCOMING)),
                tooltip = GetString(SI_LUIE_LAM_CT_INCOMING_STUNNED_TP),
                getFunc = function() return CT.SV.toggles.incoming.showStunned end,
                setFunc = function(v) CT.SV.toggles.incoming.showStunned = v end,
                default = CT.D.toggles.incoming.showStunned,
            },
            {
                -- Stunned (Outgoing)
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>> (<<3>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_STUNNED), GetString(SI_LUIE_LAM_CT_SHARED_OUTGOING)),
                tooltip = GetString(SI_LUIE_LAM_CT_OUTGOING_STUNNED_TP),
                getFunc = function() return CT.SV.toggles.outgoing.showStunned end,
                setFunc = function(v) CT.SV.toggles.outgoing.showStunned = v end,
                default = CT.D.toggles.outgoing.showStunned,
            },
            {
                -- Stunned (Format)
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_COMBAT_STUNNED_TP),
                getFunc = function() return CT.SV.formats.stunned end,
                setFunc = function(v) CT.SV.formats.stunned = v end,
                isMultiline = false,
                default = CT.D.formats.stunned,
            },
            {
                -- Stunned (Color)
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_COMBAT_STUNNED_TP),
                getFunc = function() return unpack(CT.SV.colors.stunned) end,
                setFunc = function(r, g, b, a) CT.SV.colors.stunned = { r, g, b, a } end,
                default = {r=CT.D.colors.stunned[1], g=CT.D.colors.stunned[2], b=CT.D.colors.stunned[3]}
            },
        },
    }

    -- Combat Text -- Notification Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_NOTIFICATION), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_STATE),
                width = "full",
            },
            {
                -- In Combat
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_IN_TP),
                getFunc = function() return CT.SV.toggles.showInCombat end,
                setFunc = function(v) CT.SV.toggles.showInCombat = v end,
                default = CT.D.toggles.showInCombat,
            },
            {
                -- Out of Combat
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_COMBAT_OUT_TP),
                getFunc = function() return CT.SV.toggles.showOutCombat end,
                setFunc = function(v) CT.SV.toggles.showOutCombat = v end,
                default = CT.D.toggles.showOutCombat,
            },
            {
                -- In Combat
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)",GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_COMBAT_IN_TP),
                getFunc = function() return CT.SV.formats.inCombat end,
                setFunc = function(v) CT.SV.formats.inCombat = v end,
                isMultiline = false,
                default = CT.D.formats.inCombat,
            },
            {
                -- Out Combat
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)",GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_COMBAT_OUT_TP),
                getFunc = function() return CT.SV.formats.outCombat end,
                setFunc = function(v) CT.SV.formats.outCombat = v end,
                isMultiline = false,
                default = CT.D.formats.outCombat,
            },
            {
                -- Combat State Font Size
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_COMBAT_STATE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.combatState end,
                setFunc = function(size) CT.SV.fontSizes.combatState = size end,
                default = CT.D.fontSizes.combatState,
            },
            {
                -- In Combat
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_IN)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_IN_TP),
                getFunc = function() return unpack(CT.SV.colors.inCombat) end,
                setFunc = function(r, g, b, a) CT.SV.colors.inCombat = { r, g, b, a } end,
                default = {r=CT.D.colors.inCombat[1], g=CT.D.colors.inCombat[2], b=CT.D.colors.inCombat[3]}
            },
            {
                -- Out Combat
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_COMBAT_OUT)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_COMBAT_OUT_TP),
                getFunc = function() return unpack(CT.SV.colors.outCombat) end,
                setFunc = function(r, g, b, a) CT.SV.colors.outCombat = { r, g, b, a } end,
                default = {r=CT.D.colors.outCombat[1], g=CT.D.colors.outCombat[2], b=CT.D.colors.outCombat[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_DEATH_HEADER),
                width = "full",
            },
            {
                -- Death Toggle
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_DEATH_NOTIFICATION),
                tooltip = GetString(SI_LUIE_LAM_CT_DEATH_NOTIFICATION_TP),
                getFunc = function() return CT.SV.toggles.showDeath end,
                setFunc = function(v) CT.SV.toggles.showDeath = v end,
                default = CT.D.toggles.showDeath,
            },
            {
                -- Death Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_DEATH_FORMAT_TP),
                getFunc = function() return CT.SV.formats.death end,
                setFunc = function(v) CT.SV.formats.death = v end,
                isMultiline = false,
                default = CT.D.formats.death,
            },
            {
                -- Death Font Size
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_DEATH_FONT_SIZE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.death end,
                setFunc = function(size) CT.SV.fontSizes.death = size end,
                default = CT.D.fontSizes.death,
            },
            {
                -- Death Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_DEATH_COLOR_TP),
                getFunc = function() return unpack(CT.SV.colors.death) end,
                setFunc = function(r, g, b, a) CT.SV.colors.death = { r, g, b, a } end,
                default = {r=CT.D.colors.death[1], g=CT.D.colors.death[2], b=CT.D.colors.death[3]}
            },
            {
                type = "header",
                name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE), GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POINT_HEADER)),
                width = "full",
            },
            {
                -- Points Font Size
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_POINTS_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.point end,
                setFunc = function(size) CT.SV.fontSizes.point = size end,
                default = CT.D.fontSizes.point,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_ALLIANCE),
                width = "full",
            },
            {
                -- Alliance Points
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POINTS_ALLIANCE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_ALLIANCE_TP),
                getFunc = function() return CT.SV.toggles.showPointsAlliance end,
                setFunc = function(v) CT.SV.toggles.showPointsAlliance = v end,
                default = CT.D.toggles.showPointsAlliance,
            },
            {
                -- Alliance Points
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_ALLIANCE_TP),
                getFunc = function() return CT.SV.formats.pointsAlliance end,
                setFunc = function(v) CT.SV.formats.pointsAlliance = v end,
                isMultiline = false,
                default = CT.D.formats.pointsAlliance,
            },
            {
                -- Alliance Points Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ALLIANCE_TP),
                getFunc = function() return unpack(CT.SV.colors.pointsAlliance) end,
                setFunc = function(r, g, b, a) CT.SV.colors.pointsAlliance = { r, g, b, a } end,
                default = {r=CT.D.colors.pointsAlliance[1], g=CT.D.colors.pointsAlliance[2], b=CT.D.colors.pointsAlliance[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE),
                width = "full",
            },
            {
                -- Experience Points
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POINTS_EXPERIENCE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_EXPERIENCE_TP),
                getFunc = function() return CT.SV.toggles.showPointsExperience end,
                setFunc = function(v) CT.SV.toggles.showPointsExperience = v end,
                default = CT.D.toggles.showPointsExperience,
            },
            {
                -- Experience Points
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPERIENCE_TP),
                getFunc = function() return CT.SV.formats.pointsExperience end,
                setFunc = function(v) CT.SV.formats.pointsExperience = v end,
                isMultiline = false,
                default = CT.D.formats.pointsExperience,
            },
            {
                -- Experience Points Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPERIENCE_TP),
                getFunc = function() return unpack(CT.SV.colors.pointsExperience) end,
                setFunc = function(r, g, b, a) CT.SV.colors.pointsExperience = { r, g, b, a } end,
                default = {r=CT.D.colors.pointsExperience[1], g=CT.D.colors.pointsExperience[2], b=CT.D.colors.pointsExperience[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION),
                width = "full",
            },
            {
                -- Champion Points
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POINTS_CHAMPION)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POINTS_CHAMPION_TP),
                getFunc = function() return CT.SV.toggles.showPointsChampion end,
                setFunc = function(v) CT.SV.toggles.showPointsChampion = v end,
                default = CT.D.toggles.showPointsChampion,
            },
            {
                -- Champion Points
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_CHAMPION_TP),
                getFunc = function() return CT.SV.formats.pointsChampion end,
                setFunc = function(v) CT.SV.formats.pointsChampion = v end,
                isMultiline = false,
                default = CT.D.formats.pointsChampion,
            },
            {
                -- Champion Points Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CHAMPION_TP),
                getFunc = function() return unpack(CT.SV.colors.pointsChampion) end,
                setFunc = function(r, g, b, a) CT.SV.colors.pointsChampion = { r, g, b, a } end,
                default = {r=CT.D.colors.pointsChampion[1], g=CT.D.colors.pointsChampion[2], b=CT.D.colors.pointsChampion[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_AND_POTION_READY),
                width = "full",
            },
            {
                -- Font Size Ready
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_RESOURCE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.readylabel end,
                setFunc = function(size) CT.SV.fontSizes.readylabel = size end,
                default = CT.D.fontSizes.readylabel,
            },
            {
                -- Ultimate Ready Enable
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ULTIMATE_READY_TP),
                getFunc = function() return CT.SV.toggles.showUltimate end,
                setFunc = function(v) CT.SV.toggles.showUltimate = v end,
                default = CT.D.toggles.showUltimate,
            },
            {
                -- Potion Ready Enable
                type    = "checkbox",
                width   = "half",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_POTION_READY_TP),
                getFunc = function() return CT.SV.toggles.showPotionReady end,
                setFunc = function(v) CT.SV.toggles.showPotionReady = v end,
                default = CT.D.toggles.showPotionReady,
            },
            {
                -- Ultimate Ready Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_ULTIMATE_TP),
                getFunc = function() return CT.SV.formats.ultimateReady end,
                setFunc = function(v) CT.SV.formats.ultimateReady = v end,
                isMultiline = false,
                default = CT.D.formats.ultimateReady,
            },
            {
                -- Potion Ready Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POTION_TP),
                getFunc = function() return CT.SV.formats.potionReady end,
                setFunc = function(v) CT.SV.formats.potionReady = v end,
                isMultiline = false,
                default = CT.D.formats.potionReady,
            },
            {
                -- Ultimate Ready Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_ULTIMATE_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_ULTIMATE_TP),
                getFunc = function() return unpack(CT.SV.colors.ultimateReady) end,
                setFunc = function(r, g, b, a) CT.SV.colors.ultimateReady = { r, g, b, a } end,
                default = {r=CT.D.colors.ultimateReady[1], g=CT.D.colors.ultimateReady[2], b=CT.D.colors.ultimateReady[3]}
            },
            {
                -- Potion Ready Color
                type    = "colorpicker",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_COLOR), GetString(SI_LUIE_LAM_CT_SHARED_POTION_READY)),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POTION_TP),
                getFunc = function() return unpack(CT.SV.colors.potionReady) end,
                setFunc = function(r, g, b, a) CT.SV.colors.potionReady = { r, g, b, a } end,
                default = {r=CT.D.colors.potionReady[1], g=CT.D.colors.potionReady[2], b=CT.D.colors.potionReady[3]}
            },
        },
    }

    -- Combat Text - Low Resource Options
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_LOW_RESOURCE), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_FORMAT_DESCRIPTION),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_RESOURCE_OPTIONS),
                width = "full",
            },
            {
                -- Low Resource Font Size
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_RESOURCE_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.resource end,
                setFunc = function(size) CT.SV.fontSizes.resource = size end,
                default = CT.D.fontSizes.resource,
            },
            {
                -- Low Resource Warning Sound
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_SOUND_TP),
                getFunc = function() return CT.SV.toggles.warningSound end,
                setFunc = function(v) CT.SV.toggles.warningSound = v end,
                disabled = function() return not (CT.SV.toggles.showLowHealth or CT.SV.toggles.showLowMagicka or CT.SV.toggles.showLowStamina) end,
                default = CT.D.toggles.warningSound,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_LOW_HEALTH),
                width = "full",
            },
            {
                -- Low Health
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_LOW_HEALTH)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_HEALTH_TP),
                getFunc = function() return CT.SV.toggles.showLowHealth end,
                setFunc = function(v) CT.SV.toggles.showLowHealth = v end,
                default = CT.D.toggles.showLowHealth,
            },
            {
                -- Low Health Warning Threshold Slider
                type    = "slider",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_HEALTH)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_HEALTH_TP),
                min     = 15,
                max     = 50,
                step    = 1,
                getFunc = function() return CT.SV.healthThreshold end,
                setFunc = function(threshold) CT.SV.healthThreshold = threshold end,
                disabled = function() return not CT.SV.toggles.showLowHealth end,
                default = CT.D.healthThreshold,
            },
            {
                -- Low Health Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_RESOURCE_TP),
                getFunc = function() return CT.SV.formats.resourceHealth end,
                setFunc = function(v) CT.SV.formats.resourceHealth = v end,
                isMultiline = false,
                default = CT.D.formats.resourceHealth,
            },
            {
                -- Low Health Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_HEALTH_TP),
                getFunc = function() return unpack(CT.SV.colors.lowHealth) end,
                setFunc = function(r, g, b, a) CT.SV.colors.lowHealth = { r, g, b, a } end,
                default = {r=CT.D.colors.lowHealth[1], g=CT.D.colors.lowHealth[2], b=CT.D.colors.lowHealth[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA),
                width = "full",
            },
            {
                -- Low Magicka
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_LOW_MAGICKA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_MAGICKA_TP),
                getFunc = function() return CT.SV.toggles.showLowMagicka end,
                setFunc = function(v) CT.SV.toggles.showLowMagicka = v end,
                default = CT.D.toggles.showLowMagicka,
            },
            {
                -- Low Magicka Warning Threshold Slider
                type    = "slider",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_MAGICKA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_MAGICKA_TP),
                min     = 15,
                max     = 50,
                step    = 1,
                getFunc = function() return CT.SV.magickaThreshold end,
                setFunc = function(threshold) CT.SV.magickaThreshold = threshold end,
                disabled = function() return not CT.SV.toggles.showLowMagicka end,
                default = CT.D.magickaThreshold,
            },
            {
                -- Low Magicka Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_RESOURCE_TP),
                getFunc = function() return CT.SV.formats.resourceMagicka end,
                setFunc = function(v) CT.SV.formats.resourceMagicka = v end,
                isMultiline = false,
                default = CT.D.formats.resourceMagicka,
            },
            {
                -- Low Magicka Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_MAGICKA_TP),
                getFunc = function() return unpack(CT.SV.colors.lowMagicka) end,
                setFunc = function(r, g, b, a) CT.SV.colors.lowMagicka = { r, g, b, a } end,
                default = {r=CT.D.colors.lowMagicka[1], g=CT.D.colors.lowMagicka[2], b=CT.D.colors.lowMagicka[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA),
                width = "full",
            },
            {
                -- Low Stamina
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_LOW_STAMINA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_LOW_STAMINA_TP),
                getFunc = function() return CT.SV.toggles.showLowStamina end,
                setFunc = function(v) CT.SV.toggles.showLowStamina = v end,
                default = CT.D.toggles.showLowStamina,
            },
            {
                -- Low Stamina Warning Threshold Slider
                type    = "slider",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_STAMINA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_WARNING_STAMINA_TP),
                min     = 15,
                max     = 50,
                step    = 1,
                getFunc = function() return CT.SV.staminaThreshold end,
                setFunc = function(threshold) CT.SV.staminaThreshold = threshold end,
                disabled = function() return not CT.SV.toggles.showLowStamina end,
                default = CT.D.staminaThreshold,
            },
            {
                -- Low Stamina Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_RESOURCE_TP),
                getFunc = function() return CT.SV.formats.resourceStamina end,
                setFunc = function(v) CT.SV.formats.resourceStamina = v end,
                isMultiline = false,
                default = CT.D.formats.resourceStamina,
            },
            {
                -- Low Stamina Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_LOW_STAMINA_TP),
                getFunc = function() return unpack(CT.SV.colors.lowStamina) end,
                setFunc = function(r, g, b, a) CT.SV.colors.lowStamina = { r, g, b, a } end,
                default = {r=CT.D.colors.lowStamina[1], g=CT.D.colors.lowStamina[2], b=CT.D.colors.lowStamina[3]}
            },
        },
    }

    -- Combat Text - Active Combat Alerts
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_HEADER_ACTIVE_COMBAT_ALERT), GetString(SI_LUIE_LAM_CT_SHARED_OPTIONS)),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERTS_DESC),
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_HEADER_SHARED_FONT_SIZE),
                width = "full",
            },
            {
                -- Alerts Font
                type     = "slider",
                name    = GetString(SI_LUIE_LAM_FONT_SIZE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_NOTIFICATION_ALERT_TP),
                min     = 8,
                max     = 72,
                step    = 1,
                getFunc = function() return CT.SV.fontSizes.alert end,
                setFunc = function(size) CT.SV.fontSizes.alert = size end,
                default = CT.D.fontSizes.alert,
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE),
                width = "full",
            },
            {
                -- Cleanse Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_CLEANSE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_CLEANSE_TP),
                getFunc = function() return CT.SV.toggles.showAlertCleanse end,
                setFunc = function(v) CT.SV.toggles.showAlertCleanse = v end,
                default = CT.D.toggles.showAlertCleanse,
            },
            {
                -- Cleanse Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_CLEANSE_TP),
                getFunc = function() return CT.SV.formats.alertCleanse end,
                setFunc = function(v) CT.SV.formats.alertCleanse = v end,
                isMultiline = false,
                default = CT.D.formats.alertCleanse,
            },
            {
                -- Cleanse Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_CLEANSE_TP),
                getFunc = function() return unpack(CT.SV.colors.alertCleanse) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertCleanse = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertCleanse[1], g=CT.D.colors.alertCleanse[2], b=CT.D.colors.alertCleanse[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT),
                width = "full",
            },
            {
                -- Exploit Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXPLOIT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXPLOIT_TP),
                getFunc = function() return CT.SV.toggles.showAlertExploit end,
                setFunc = function(v) CT.SV.toggles.showAlertExploit = v end,
                default = CT.D.toggles.showAlertExploit,
            },
            {
                -- Exploit  Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXPLOIT_TP),
                getFunc = function() return CT.SV.formats.alertExploit end,
                setFunc = function(v) CT.SV.formats.alertExploit = v end,
                isMultiline = false,
                default = CT.D.formats.alertExploit,
            },
            {
                -- Exploit Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXPLOIT_TP),
                getFunc = function() return unpack(CT.SV.colors.alertExploit) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertExploit = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertExploit[1], g=CT.D.colors.alertExploit[2], b=CT.D.colors.alertExploit[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE),
                width = "full",
            },
            {
                -- Execute Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_EXECUTE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_EXECUTE_TP),
                getFunc = function() return CT.SV.toggles.showAlertExecute end,
                setFunc = function(v) CT.SV.toggles.showAlertExecute = v end,
                default = CT.D.toggles.showAlertExecute,
            },
            {
                -- Execute Threshold Slider
                type    = "slider",
                width   = "half",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFIACTION_EXECUTE_THRESHOLD_TP),
                min     = 10,
                max     = 50,
                getFunc = function() return CT.SV.executeThreshold end,
                setFunc = function(v) CT.SV.executeThreshold = v end,
                disabled = function() return not CT.SV.toggles.showAlertExecute end,
                default = CT.D.executeThreshold,
            },
            {
                -- Execute Frequency Slider
                type    = "slider",
                width   = "half",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_EXECUTE_FREQUENCY_TP),
                min     = 1,
                max     = 20,
                getFunc = function() return CT.SV.executeFrequency end,
                setFunc = function(v) CT.SV.executeFrequency = v end,
                disabled = function() return not CT.SV.toggles.showAlertExecute end,
                default = CT.D.executeFrequency,
            },
            {
                -- Execute Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_EXECUTE_TP),
                getFunc = function() return CT.SV.formats.alertExecute end,
                setFunc = function(v) CT.SV.formats.alertExecute = v end,
                isMultiline = false,
                default = CT.D.formats.alertExecute,
            },
            {
                -- Execute Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_EXECUTE_TP),
                getFunc = function() return unpack(CT.SV.colors.alertExecute) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertExecute = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertExecute[1], g=CT.D.colors.alertExecute[2], b=CT.D.colors.alertExecute[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_INCOMING_ABILITY_ALERTS),
                width = "full",
            },
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_DESCRIPTION),
            },
            {
                -- Hide Ingame Tips
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_INGAME_TIPS_TP),
                getFunc = function() return CT.SV.toggles.hideIngameTips end,
                setFunc = function(v) CT.SV.toggles.hideIngameTips = v; ZO_ActiveCombatTips:SetHidden(v) end,
                default = CT.D.toggles.hideIngameTips,
            },
            {
                -- Mitigation Alerts
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_TP),
                getFunc = function() return CT.SV.toggles.showAlertMitigation end,
                setFunc = function(v) CT.SV.toggles.showAlertMitigation = v end,
                default = CT.D.toggles.showAlertMitigation,
            },
            {
                -- Mitigation Method
                type    = "dropdown",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_METHOD_TP),
                choices = CTC.mitigationType,
                getFunc = function() return CT.SV.toggles.mitigationType end,
                setFunc = function(v) CT.SV.toggles.mitigationType = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationType,
            },
            {
                -- Hide Mitigation Grouped Alerts
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_HIDE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_HIDE_TP),
                getFunc = function() return CT.SV.toggles.hideMitigation end,
                setFunc = function(v) CT.SV.toggles.hideMitigation = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.mitigationType == "Single Line") end,
                default = CT.D.toggles.hideMitigation,
            },
            {
                -- Mitigation Prefix (No Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationPrefix = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationPrefix,
            },
            {
                -- Mitigation Prefix (Name)
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationPrefixN = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationPrefixN,
            },
            {
                -- Mitigation Suffix
                type    = "editbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_SUFFIX_TP),
                getFunc = function() return CT.SV.toggles.mitigationDefaultSuffix end,
                setFunc = function(v) CT.SV.toggles.mitigationDefaultSuffix = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationDefaultSuffix,
            },
            {
                -- Mitigation Aura
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_AURA_TP),
                getFunc = function() return CT.SV.toggles.mitigationAura end,
                setFunc = function(v) CT.SV.toggles.mitigationAura = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationAura,
            },
            {
                -- Mitigation Rank 3
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK3_TP),
                getFunc = function() return CT.SV.toggles.mitigationRank3 end,
                setFunc = function(v) CT.SV.toggles.mitigationRank3 = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationRank3,
            },
            {
                -- Mitigation Rank 2
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK2_TP),
                getFunc = function() return CT.SV.toggles.mitigationRank2 end,
                setFunc = function(v) CT.SV.toggles.mitigationRank2 = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationRank2,
            },
            {
                -- Mitigation Rank 1
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_RANK1_TP),
                getFunc = function() return CT.SV.toggles.mitigationRank1 end,
                setFunc = function(v) CT.SV.toggles.mitigationRank1 = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationRank1,
            },
            {
                -- Mitigation Dungeon
                type    = "checkbox",
                name    = strformat("\t\t\t\t\t<<1>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_DUNGEON_TP),
                getFunc = function() return CT.SV.toggles.mitigationDungeon end,
                setFunc = function(v) CT.SV.toggles.mitigationDungeon = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.mitigationDungeon,
            },
            {
                -- Shared Label Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BASE_TP),
                getFunc = function() return unpack(CT.SV.colors.alertShared) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertShared = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertShared[1], g=CT.D.colors.alertShared[2], b=CT.D.colors.alertShared[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK),
                width = "full",
            },
            {
                -- Block Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_BLOCK_TP),
                getFunc = function() return CT.SV.toggles.showAlertBlock end,
                setFunc = function(v) CT.SV.toggles.showAlertBlock = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertBlock,
            },
            {
                -- Block Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_TP),
                getFunc = function() return CT.SV.formats.alertBlock end,
                setFunc = function(v) CT.SV.formats.alertBlock = v end,
                isMultiline = false,
                default = CT.D.formats.alertBlock,
            },
            {
                -- Block Stagger Format
                type    = "editbox",
                width   = "half",
                name    = strformat("<<1>> (<<2>>)", GetString(SI_LUIE_LAM_CT_SHARED_FORMAT), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_BLOCK_S)),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_BLOCK_S_TP),
                getFunc = function() return CT.SV.formats.alertBlockStagger end,
                setFunc = function(v) CT.SV.formats.alertBlockStagger = v end,
                isMultiline = false,
                default = CT.D.formats.alertBlockStagger,
            },
            {
                -- Block Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_BLOCK_TP),
                getFunc = function() return unpack(CT.SV.colors.alertBlockA) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertBlockA = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertBlockA[1], g=CT.D.colors.alertBlockA[2], b=CT.D.colors.alertBlockA[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE),
                width = "full",
            },
            {
                -- Dodge Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DODGE)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_DODGE_TP),
                getFunc = function() return CT.SV.toggles.showAlertDodge end,
                setFunc = function(v) CT.SV.toggles.showAlertDodge = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertDodge,
            },
            {
                -- Dodge  Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DODGE_TP),
                getFunc = function() return CT.SV.formats.alertDodge end,
                setFunc = function(v) CT.SV.formats.alertDodge = v end,
                isMultiline = false,
                default = CT.D.formats.alertDodge,
            },
            {
                -- Dodge Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DODGE_TP),
                getFunc = function() return unpack(CT.SV.colors.alertDodgeA) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertDodgeA = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertDodgeA[1], g=CT.D.colors.alertDodgeA[2], b=CT.D.colors.alertDodgeA[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID),
                width = "full",
            },
            {
                -- Avoid Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_AVOID)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_AVOID_TP),
                getFunc = function() return CT.SV.toggles.showAlertAvoid end,
                setFunc = function(v) CT.SV.toggles.showAlertAvoid = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertAvoid,
            },
            {
                -- Avoid Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_AVOID_TP),
                getFunc = function() return CT.SV.formats.alertAvoid end,
                setFunc = function(v) CT.SV.formats.alertAvoid = v end,
                isMultiline = false,
                default = CT.D.formats.alertAvoid,
            },
            {
                -- Avoid Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_AVOID_TP),
                getFunc = function() return unpack(CT.SV.colors.alertAvoidB) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertAvoidB = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertAvoidB[1], g=CT.D.colors.alertAvoidB[2], b=CT.D.colors.alertAvoidB[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_INTERRUPT),
                width = "full",
            },
            {
                -- Interrupt Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_UNMIT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_UNMIT_TP),
                getFunc = function() return CT.SV.toggles.showAlertInterrupt end,
                setFunc = function(v) CT.SV.toggles.showAlertInterrupt = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertInterrupt,
            },
            {
                -- Interrupt Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_INTERRUPT_TP),
                getFunc = function() return CT.SV.formats.alertInterrupt end,
                setFunc = function(v) CT.SV.formats.alertInterrupt = v end,
                isMultiline = false,
                default = CT.D.formats.alertInterrupt,
            },
            {
                -- Interrupt Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_INTERRUPT_TP),
                getFunc = function() return unpack(CT.SV.colors.alertInterruptB) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertInterruptB = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertInterruptB[1], g=CT.D.colors.alertInterruptB[2], b=CT.D.colors.alertInterruptB[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_UNMIT),
                width = "full",
            },
            {
                -- Unmit Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_UNMIT)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_UNMIT_TP),
                getFunc = function() return CT.SV.toggles.showAlertUnmit end,
                setFunc = function(v) CT.SV.toggles.showAlertUnmit = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertUnmit,
            },
            {
                -- Unmit Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_UNMIT_TP),
                getFunc = function() return CT.SV.formats.alertUnmit end,
                setFunc = function(v) CT.SV.formats.alertUnmit = v end,
                isMultiline = false,
                default = CT.D.formats.alertUnmit,
            },
            {
                -- Unmit Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_UNMIT_TP),
                getFunc = function() return unpack(CT.SV.colors.alertUnmit) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertUnmit = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertUnmit[1], g=CT.D.colors.alertUnmit[2], b=CT.D.colors.alertUnmit[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_POWER),
                width = "full",
            },
            {
                -- Power Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_POWER)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_POWER_TP),
                getFunc = function() return CT.SV.toggles.showAlertPower end,
                setFunc = function(v) CT.SV.toggles.showAlertPower = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertPower,
            },
            {
                -- Power Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_POWER_TP),
                getFunc = function() return CT.SV.formats.alertPower end,
                setFunc = function(v) CT.SV.formats.alertPower = v end,
                isMultiline = false,
                default = CT.D.formats.alertPower,
            },
            {
                -- Prefix Power (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPowerPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationPowerPrefix = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertPower) end,
                default = CT.D.toggles.mitigationPowerPrefix,
            },
            {
                -- Prefix Power (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_P_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationPowerPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationPowerPrefixN = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertPower) end,
                default = CT.D.toggles.mitigationPowerPrefixN,
            },
            {
                -- Power Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_POWER_TP),
                getFunc = function() return unpack(CT.SV.colors.alertPower) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertPower = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertPower[1], g=CT.D.colors.alertPower[2], b=CT.D.colors.alertPower[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DESTROY),
                width = "full",
            },
            {
                -- Destroy Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_DESTROY)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_DESTROY_TP),
                getFunc = function() return CT.SV.toggles.showAlertDestroy end,
                setFunc = function(v) CT.SV.toggles.showAlertDestroy = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertDestroy,
            },
            {
                -- Destroy Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_DESTROY_TP),
                getFunc = function() return CT.SV.formats.alertDestroy end,
                setFunc = function(v) CT.SV.formats.alertDestroy = v end,
                isMultiline = false,
                default = CT.D.formats.alertDestroy,
            },
            {
                -- Prefix Destroy (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationDestroyPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationDestroyPrefix = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertDestroy) end,
                default = CT.D.toggles.mitigationDestroyPrefix,
            },
            {
                -- Prefix Destroy (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_D_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationDestroyPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationDestroyPrefixN = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertDestroy) end,
                default = CT.D.toggles.mitigationDestroyPrefixN,
            },
            {
                -- Destroy Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_DESTROY_TP),
                getFunc = function() return unpack(CT.SV.colors.alertDestroy) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertDestroy = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertDestroy[1], g=CT.D.colors.alertDestroy[2], b=CT.D.colors.alertDestroy[3]}
            },
            {
                type = "header",
                name = GetString(SI_LUIE_LAM_CT_SHARED_ALERT_SUMMON),
                width = "full",
            },
            {
                -- Summon Enable
                type    = "checkbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_SHARED_DISPLAY), GetString(SI_LUIE_LAM_CT_SHARED_ALERT_SUMMON)),
                tooltip = GetString(SI_LUIE_LAM_CT_NOTIFICATION_ALERT_SUMMON_TP),
                getFunc = function() return CT.SV.toggles.showAlertSummon end,
                setFunc = function(v) CT.SV.toggles.showAlertSummon = v end,
                disabled = function() return not CT.SV.toggles.showAlertMitigation end,
                default = CT.D.toggles.showAlertSummon,
            },
            {
                -- Summon Format
                type    = "editbox",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_FORMAT),
                tooltip = GetString(SI_LUIE_LAM_CT_FORMAT_NOTIFICATION_SUMMON_TP),
                getFunc = function() return CT.SV.formats.alertSummon end,
                setFunc = function(v) CT.SV.formats.alertSummon = v end,
                isMultiline = false,
                default = CT.D.formats.alertSummon,
            },
            {
                -- Prefix Summon (No Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NO_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationSummonPrefix end,
                setFunc = function(v) CT.SV.toggles.mitigationSummonPrefix = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertSummon) end,
                default = CT.D.toggles.mitigationSummonPrefix,
            },
            {
                -- Prefix Summon (Name)
                type    = "editbox",
                name    = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME)),
                tooltip = strformat("<<1>> <<2>>", GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_FORMAT_S_TP), GetString(SI_LUIE_LAM_CT_NOTIFICATION_MITIGATION_NAME_TP)),
                getFunc = function() return CT.SV.toggles.mitigationSummonPrefixN end,
                setFunc = function(v) CT.SV.toggles.mitigationSummonPrefixN = v end,
                disabled = function() return not (CT.SV.toggles.showAlertMitigation and CT.SV.toggles.showAlertSummon) end,
                default = CT.D.toggles.mitigationSummonPrefixN,
            },
            {
                -- Summon Color
                type    = "colorpicker",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_COLOR),
                tooltip = GetString(SI_LUIE_LAM_CT_COLOR_NOTIFICATION_SUMMON_TP),
                getFunc = function() return unpack(CT.SV.colors.alertSummon) end,
                setFunc = function(r, g, b, a) CT.SV.colors.alertSummon = { r, g, b, a } CT.SetAlertColors() end,
                default = {r=CT.D.colors.alertSummon[1], g=CT.D.colors.alertSummon[2], b=CT.D.colors.alertSummon[3]}
            },
        },
    }

    -- Combat Text - Font Format Options Submenu
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_FONT_HEADER),
        controls = {
            {
                -- Font Face Dropdown
                type    = "dropdown",
                scrollable = true,
                name    = GetString(SI_LUIE_LAM_CT_FONT_FACE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_FACE_TP),
                choices = FontsList,
                getFunc = function() return CT.SV.fontFace end,
                setFunc = function(face)
                    CT.SV.fontFace = face
                    for k, _ in pairs (CT.SV.panels) do
                        _G[k .. "_Label"]:SetFont(LMP:Fetch(LMP.MediaType.FONT, CT.SV.fontFace) .. "|26|" .. CT.SV.fontOutline)
                    end
                end,
                default = CT.D.fontFace
            },
            {
                -- Font Outline Dropdown
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_FONT_OUTLINE),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_OUTLINE_TP),
                choices = CTC.outlineType,
                getFunc = function() return CT.SV.fontOutline end,
                setFunc = function(outline)
                    CT.SV.fontOutline = outline
                    for k, _ in pairs (CT.SV.panels) do
                        _G[k .. "_Label"]:SetFont(LMP:Fetch(LMP.MediaType.FONT, CT.SV.fontFace) .. "|26|" .. CT.SV.fontOutline)
                    end
                end,
                default = CT.D.fontOutline
            },
            {
                -- Test Font Button
                type = "button",
                name    = GetString(SI_LUIE_LAM_CT_FONT_TEST),
                tooltip = GetString(SI_LUIE_LAM_CT_FONT_TEST_TP),
                func = function()
                    CALLBACK_MANAGER:FireCallbacks(CTC.eventType.COMBAT, CTC.combatType.INCOMING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                end,
            },
        },
    }

    -- Combat Text - Animation Options Submenu
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_ANIMATION_HEADER),
        controls = {
            {
                -- Animation Type
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_TYPE),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_TYPE_TP),
                choices = CTC.animationType,
                getFunc = function() return CT.SV.animation.animationType end,
                setFunc = function(v) CT.SV.animation.animationType = v end,
                default = CT.D.animation.animationType,
            },
            {
                -- Incoming Direction
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_IN_TP),
                choices = CTC.directionType,
                getFunc = function() return CT.SV.animation.incoming.directionType end,
                setFunc = function(v) CT.SV.animation.incoming.directionType = v end,
                default = CT.D.animation.incoming.directionType,
            },
            {
                -- Incoming Icon Position
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_IN_TP),
                choices = CTC.iconSide,
                getFunc = function() return CT.SV.animation.incomingIcon end,
                setFunc = function(v) CT.SV.animation.incomingIcon = v end,
                default = CT.D.animation.incomingIcon,
            },
            {
                -- Outgoing Direction
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_DIRECTION_OUT_TP),
                choices = CTC.directionType,
                getFunc = function() return CT.SV.animation.outgoing.directionType end,
                setFunc = function(v) CT.SV.animation.outgoing.directionType = v end,
                default = CT.D.animation.outgoing.directionType,
            },
            {
                -- Outgoing Icon Position
                type    = "dropdown",
                name    = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_ICON_OUT_TP),
                choices = CTC.iconSide,
                getFunc = function() return CT.SV.animation.outgoingIcon end,
                setFunc = function(v) CT.SV.animation.outgoingIcon = v end,
                default = CT.D.animation.outgoingIcon,
            },
            {
                -- Test Button
                type = "button",
                name = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST),
                tooltip = GetString(SI_LUIE_LAM_CT_ANIMATION_TEST_TP),
                func = function()
                    CALLBACK_MANAGER:FireCallbacks(CTC.eventType.COMBAT, CTC.combatType.INCOMING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                    CALLBACK_MANAGER:FireCallbacks(CTC.eventType.COMBAT, CTC.combatType.OUTGOING, POWERTYPE_STAMINA, math.random(7, 777), GetString(SI_LUIE_LAM_CT_ANIMATION_TEST), 41567, DAMAGE_TYPE_PHYSICAL, "Test", true, false, false, false, false, false, false, false, false, false, false, false, false, false)
                end,
            },
        },
    }

    -- Combat Text - Throttle Options (Combat) Options Submenu
    optionsDataCombatText[#optionsDataCombatText +1] = {
        type = "submenu",
        name = GetString(SI_LUIE_LAM_CT_THROTTLE_HEADER),
        controls = {
            {
                type = "description",
                text = GetString(SI_LUIE_LAM_CT_THROTTLE_DESCRIPTION),
            },
            {
                -- Damage
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_DAMAGE),
                tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_DAMAGE_TP),
                min     = 0,
                max     = 500,
                step    = 50,
                getFunc = function() return CT.SV.throttles.damage end,
                setFunc = function(v) CT.SV.throttles.damage = v end,
                default = CT.D.throttles.damage,
            },
            {
                -- Damage over Time
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_DOT),
                tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_DOT_TP),
                min     = 0,
                max     = 500,
                step    = 50,
                getFunc = function() return CT.SV.throttles.dot end,
                setFunc = function(v) CT.SV.throttles.dot = v end,
                default = CT.D.throttles.dot,
            },
            {
                -- Healing
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_HEALING),
                tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_HEALING_TP),
                min     = 0,
                max     = 500,
                step    = 50,
                getFunc = function() return CT.SV.throttles.healing end,
                setFunc = function(v) CT.SV.throttles.healing = v end,
                default = CT.D.throttles.healing,
            },
            {
                -- Healing over Time
                type    = "slider",
                name    = GetString(SI_LUIE_LAM_CT_SHARED_HOT),
                tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_HOT_TP),
                min     = 0,
                max     = 500,
                step    = 50,
                getFunc = function() return CT.SV.throttles.hot end,
                setFunc = function(v) CT.SV.throttles.hot = v end,
                default = CT.D.throttles.hot,
            },
            {
                -- Throttle Trailer
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER),
                tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_TRAILER_TP),
                getFunc = function() return CT.SV.toggles.showThrottleTrailer end,
                setFunc = function(v) CT.SV.toggles.showThrottleTrailer = v end,
                default = CT.D.toggles.showThrottleTrailer,
            },
            {
                -- Crits
                type    = "checkbox",
                name    = GetString(SI_LUIE_LAM_CT_THROTTLE_CRITICAL),
                tooltip = GetString(SI_LUIE_LAM_CT_THROTTLE_CRITICAL_TP),
                getFunc = function() return CT.SV.toggles.showThrottleTrailer end,
                setFunc = function(v) CT.SV.toggles.throttleCriticals = v end,
                default = CT.D.toggles.throttleCriticals,
            },
        },
    }

    -- Register the settings panel
    if LUIE.SV.CombatText_Enabled then
        LAM:RegisterAddonPanel('LUIECombatTextOptions', panelDataCombatText)
        LAM:RegisterOptionControls('LUIECombatTextOptions', optionsDataCombatText)
    end
end
