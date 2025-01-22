-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiData
local LuiData = LuiData

local Tooltips = LuiData.Data.Tooltips
local Unitnames = LuiData.Data.UnitNames
local Zonenames = LuiData.Data.ZoneNames
local Abilities = LuiData.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) IsAbilityActiveGlow
local IsAbilityActiveGlow =
{

    [20824] = true,  -- Power Lash (Flame Lash)

    [126659] = true, -- Flying Blade (Flying Blade)

    [137156] = true, -- Carnage (Pounce)
    [137184] = true, -- Brutal Carnage (Brutal Pounce)
    [137164] = true, -- Feral Carnage (Feral Pounce)
}

--- @class (partial) IsAbilityActiveGlow
LuiData.Data.Effects.IsAbilityActiveGlow = IsAbilityActiveGlow
