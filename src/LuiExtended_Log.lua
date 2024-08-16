---@class (partial) LuiExtended
local LUIE = LUIE

--[[
    If Sirinsidiator's LibDebugLogger is installed, then return a logger from that. If not, return a NOP replacement.
    How To Use: Insert anywhere you would use d or error
    local Debug = LUIE.Debug
    local Info = LUIE.Info
    local Error = LUIE.Error
    local Warn = LUIE.Warn
]]
local NOP = {}

--[[
    Debug logger function that does nothing.
]]
function NOP:Debug(...) end

--[[
    Info logger function that does nothing.
]]
function NOP:Info(...) end

--[[
    Warn logger function that does nothing.
]]
function NOP:Warn(...) end

--[[
    Error logger function that does nothing.
]]
function NOP:Error(...) end

local string_format = string.format

LUIE.log_to_chat = false

--[[
    Retrieves the logger object.
    @return table: The logger object.
]]
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

--[[
    Logs a message with a specified color.
    @param color string: The color code for the log message.
    @param ...: Variable number of arguments to be formatted and logged.
]]
function LUIE.Log(color, ...)
    if LUIE.log_to_chat then
        d("|c" .. color .. LUIE.name .. ": " .. string_format(...) .. "|r")
    end
end

--[[
    Logs a debug message.
    @param ...: Variable number of arguments to be formatted and logged.
]]
function LUIE.Debug(...)
    LUIE.Log("666666", ...)
    LUIE.Logger():Debug(...)
end

--[[
    Logs an info message.
    @param ...: Variable number of arguments to be formatted and logged.
]]
function LUIE.Info(...)
    LUIE.Log("999999", ...)
    LUIE.Logger():Info(...)
end

--[[
    Logs a warning message.
    @param ...: Variable number of arguments to be formatted and logged.
]]
function LUIE.Warn(...)
    LUIE.Log("FF8800", ...)
    LUIE.Logger():Warn(...)
end

--[[
    Logs an error message.
    @param ...: Variable number of arguments to be formatted and logged.
]]
function LUIE.Error(...)
    LUIE.Log("FF6666", ...)
    LUIE.Logger():Error(...)
end
