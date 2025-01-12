-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LuiData

local Tooltips = LUIE.Data.Tooltips
local Unitnames = LUIE.Data.UnitNames
local Zonenames = LUIE.Data.ZoneNames
local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

--------------------------------------------------------------------------------------------------------------------------------
-- EFFECTS TABLE FOR BAR HIGHLIGHT RELATED OVERRIDES
--------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification when an ability with a matching name appears as a buff.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) HasAbilityProc
local HasAbilityProc =
{
    [Abilities.Skill_Crystal_Fragments] = 46327,
}

--- @class (partial) HasAbilityProc
LUIE.Data.Effects.HasAbilityProc = HasAbilityProc
