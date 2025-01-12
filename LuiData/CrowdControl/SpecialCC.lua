-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LuiData

-- Use on ACTION_RESULT_EFFECT_GAINED
--- @class (partial) SpecialCC
local SpecialCC =
{
    [55756] = true, -- Burning (Valkyn Skoria)
}

--- @class (partial) SpecialCC
LUIE.Data.CrowdControl.SpecialCC = SpecialCC
