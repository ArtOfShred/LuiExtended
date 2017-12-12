CombatCloud_EventListener = ZO_Object:Subclass()

local callbackManager = CALLBACK_MANAGER
local eventManager = EVENT_MANAGER
local eventPostfix = 1 -- Used to create unique name when registering multiple times to the same game event

function CombatCloud_EventListener:New()
    local obj = ZO_Object:New(self)
    return obj
end

function CombatCloud_EventListener:RegisterForEvent(event, func, ...)
    eventManager:RegisterForEvent('CombatCloud_EVENT_' .. event .. '_' .. eventPostfix, event, function(eventCode, ...) func(...) end)

    -- vararg ... is a list of event filters in format filterType1, filterArg1, filterType2, filterArg2, etc.
    -- example: obj:RegisterForEvent(EVENT_POWER_UPDATE, func, REGISTER_FILTER_UNIT_TAG, 'player', REGISTER_FILTER_POWER_TYPE, POWERTYPE_ULTIMATE)
    local filtersCount = select('#', ...)
    local filters = filtersCount > 0 and {...}
    for i = 1, filtersCount, 2 do
        eventManager:AddFilterForEvent('CombatCloud_EVENT_' .. event .. '_' .. eventPostfix, event, filters[i], filters[i+1])
    end

    eventPostfix = eventPostfix + 1
end

function CombatCloud_EventListener:TriggerEvent(...)
    callbackManager:FireCallbacks(...)
end