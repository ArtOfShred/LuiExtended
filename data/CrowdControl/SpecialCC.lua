--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

-- Use on ACTION_RESULT_EFFECT_GAINED
---@class (partial) SpecialCC
local SpecialCC =
{
    [55756] = true, -- Burning (Valkyn Skoria)
}

---@class (partial) SpecialCC
LUIE.Data.CrowdControl.SpecialCC = SpecialCC
