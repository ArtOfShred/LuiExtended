--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

--- @class (partial) LuiExtended
local LUIE = LUIE

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) IsGrimFocus
local IsGrimFocus =
{
    [122585] = true, -- Grim Focus
    [122587] = true, -- Relentless Focus
    [122586] = true, -- Merciless Resolve
}

--- @class (partial) IsGrimFocus
LUIE.Data.Effects.IsGrimFocus = IsGrimFocus
