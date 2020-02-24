--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- StatPanel namespace
LUIE.CombatInfo.StatPanel = {}
local StatPanel = LUIE.CombatInfo.StatPanel

local UI = LUIE.UI --prob we draw the labels with lua

local zo_strformat = zo_strformat

local moduleName = LUIE.name .. "_StatPanel"

--[[
function StatPanel.ToggleStatPanel(option)
    LUIE_StatPanel:ClearAnchors()
    LUIE_StatPanel:SetAnchor(BOTTOM, GuiRoot, CENTER )
    LUIE_StatPanel:SetHidden(option)
end
]]--

local statType = {
    weaponDamage = STAT_POWER,
    spellDamage = STAT_SPELL_POWER,
    weaponCritical = STAT_CRITICAL_STRIKE,
    spellCritical = STAT_SPELL_CRITICAL,
    physicalPenetration = STAT_PHYSICAL_PENETRATION,
    spellPenetration = STAT_SPELL_PENETRATION,
    physicalResistance = STAT_PHYSICAL_RESIST,
    spellResistance = STAT_SPELL_RESIST,
    criticalResistance = STAT_CRITICAL_RESISTANCE,
    healthRecovery = STAT_HEALTH_REGEN_COMBAT,
    staminaRecovery = STAT_STAMINA_REGEN_COMBAT,
    magickaRecovery = STAT_MAGICKA_REGEN_COMBAT,
}

function StatPanel.Damage()
    local weaponPower = GetPlayerStat(STAT_POWER)
    local spellPower = GetPlayerStat(STAT_SPELL_POWER)

    LUIE_StatPanel_DamageLabel:SetText("dmg")

    if weaponPower > spellPower then
        LUIE_StatPanel_Damage:SetText(weaponPower)
    else
        LUIE_StatPanel_Damage:SetText(spellPower)
    end
end

function StatPanel.CriticalDamage()
    local weaponCrit = GetPlayerStat(STAT_CRITICAL_STRIKE)
    local spellCrit = GetPlayerStat(STAT_SPELL_CRITICAL)
    local critPercent

    LUIE_StatPanel_CriticalLabel:SetText("crit")

    if weaponCrit > spellCrit then
        critPercent = string.format("%0.1f", GetCriticalStrikeChance(weaponCrit))
        LUIE_StatPanel_Critical:SetText(zo_strformat("<<1>>%", critPercent))
    else
        critPercent = string.format("%0.1f", GetCriticalStrikeChance(spellCrit))
        LUIE_StatPanel_Critical:SetText(zo_strformat("<<1>>%", critPercent))
    end
end

function StatPanel.Penetration()
    local physicalPen = GetPlayerStat(STAT_PHYSICAL_PENETRATION)
    local spellPen = GetPlayerStat(STAT_SPELL_PENETRATION)

    LUIE_StatPanel_PenetrationLabel:SetText("pen")

    LUIE_StatPanel_Penetration:SetText(physicalPen)
end

function StatPanel.SpellResistance()
    local spellResistance = GetPlayerStat(STAT_SPELL_RESIST)

    LUIE_StatPanel_SpellResistLabel:SetText("resist")

    LUIE_StatPanel_SpellResist:SetText(spellResistance)
end

function StatPanel.PhysicalResistance()
    local physicalResistance = GetPlayerStat(STAT_PHYSICAL_RESIST)

    LUIE_StatPanel_PhysicalResistLabel:SetText("resist")

    LUIE_StatPanel_PhysicalResist:SetText(physicalResistance)
end

function StatPanel.CriticalResistance()
    local criticalResistance = GetPlayerStat(STAT_CRITICAL_RESISTANCE)

    LUIE_StatPanel_CriticalResistLabel:SetText("cresist")

    LUIE_StatPanel_CriticalResist:SetText(criticalResistance)
end

function StatPanel.Recovery(resourceType)
    local recovery = GetPlayerStat(resourceType)

    return recovery
end

EVENT_MANAGER:RegisterForUpdate(moduleName .. 'Damage', 450 , StatPanel.Damage)
EVENT_MANAGER:RegisterForUpdate(moduleName .. 'CriticalDamage', 450 , StatPanel.CriticalDamage)
EVENT_MANAGER:RegisterForUpdate(moduleName .. 'Penetration', 450 , StatPanel.Penetration)
EVENT_MANAGER:RegisterForUpdate(moduleName .. 'SpellResistance', 450 , StatPanel.SpellResistance)
EVENT_MANAGER:RegisterForUpdate(moduleName .. 'PhysicalResistance', 450 , StatPanel.PhysicalResistance)
EVENT_MANAGER:RegisterForUpdate(moduleName .. 'CriticalResistance', 450 , StatPanel.CriticalResistance)
