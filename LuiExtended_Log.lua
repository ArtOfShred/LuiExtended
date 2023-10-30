-- If Sirinsidiator's LibDebugLogger is installed, then return a logger from
-- that. If not, return a NOP replacement.

-- How To Use: Insert anywhere you would use d or error
-- local Debug = LUIE.Debug
-- local Info = LUIE.Info
-- local Error = LUIE.Error
-- local Warn = LUIE.Warn

local strfmat = string.format
local NOP = {}
function NOP:Debug(...) end

function NOP:Info(...) end

function NOP:Warn(...) end

function NOP:Error(...) end

LUIE.log_to_chat = false

function LUIE.Logger()
    local self = LUIE
    if not self.logger then
        if LibDebugLogger then
            self.logger = LibDebugLogger.Create(self.name)
        end
        if not self.logger then
            self.logger = NOP
        end
    end
    return self.logger
end

function LUIE.Log(color, ...)
    if LUIE.log_to_chat then
        d("|c" .. color .. LUIE.name .. ": " .. strfmat(...) .. "|r")
    end
end

function LUIE.Debug(...)
    LUIE.Log("666666", ...)
    LUIE.Logger():Debug(...)
end

function LUIE.Info(...)
    LUIE.Log("999999", ...)
    LUIE.Logger():Info(...)
end

function LUIE.Warn(...)
    LUIE.Log("FF8800", ...)
    LUIE.Logger():Warn(...)
end

function LUIE.Error(...)
    LUIE.Log("FF6666", ...)
    LUIE.Logger():Error(...)
end
