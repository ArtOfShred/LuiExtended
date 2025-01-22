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

--------------------------------------------------------------------------------------------------------------------------------
-- List of abilities flagged to display a Proc highlight / sound notification when an ability with a matching name appears as a buff.
--------------------------------------------------------------------------------------------------------------------------------
--- @class (partial) HasAbilityProc
local HasAbilityProc =
{
    [Abilities.Skill_Crystal_Fragments] = 46327,
}

--- @class (partial) HasAbilityProc
LuiData.Data.Effects.HasAbilityProc = HasAbilityProc
