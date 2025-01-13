-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LUIE

--- @class (partial) CombatTextEventListener : ZO_InitializingObject
local CombatTextEventListener = ZO_InitializingObject:Subclass()

local callbackManager = LUIE.callbackObject
local eventManager = GetEventManager()

local moduleName = LUIE.name .. "CombatText"

--- @type integer
local eventPostfix = 1 -- Used to create unique name when registering multiple times to the same game event

--- @return CombatTextEventListener
function CombatTextEventListener:New()
    local obj = setmetatable({}, self)
    return obj
end

--- @param event any
--- @param func fun(...)
--- @param ... any
function CombatTextEventListener:RegisterForEvent(event, func, ...)
    eventManager:RegisterForEvent(moduleName .. "Event" .. event .. "_" .. eventPostfix, event, function (eventCode, ...)
        func(...)
    end)

    --- @type any[]
    local filters = { ... }
    local filtersCount = select("#", ...)
    if filtersCount > 0 then
        for i = 1, filtersCount, 2 do
            eventManager:AddFilterForEvent(moduleName .. "Event" .. event .. "_" .. eventPostfix, event, filters[i], filters[i + 1])
        end
    end

    eventPostfix = eventPostfix + 1
end

--- @param name any
--- @param timer any
--- @param func fun(...)
--- @param ... any
function CombatTextEventListener:RegisterForUpdate(name, timer, func, ...)
    eventManager:RegisterForUpdate(moduleName .. "Event" .. name .. "_" .. eventPostfix, timer, func)
end

--- @param ... any
function CombatTextEventListener:TriggerEvent(...)
    callbackManager:FireCallbacks(...)
end

--- @class (partial) CombatTextEventListener
LUIE.CombatTextEventListener = CombatTextEventListener
