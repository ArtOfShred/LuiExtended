--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

local pairs = pairs

LUIE.CombatTextPoolManager = ZO_InitializingObject:Subclass()
local CombatTextPoolManager = LUIE.CombatTextPoolManager
---@diagnostic disable-next-line: duplicate-set-field
function CombatTextPoolManager:New()
    local obj = setmetatable({}, self)
    self.pools = {}
    return obj
end

function CombatTextPoolManager:RegisterPool(poolType, pool)
    self.pools[poolType] = pool
end

function CombatTextPoolManager:GetPoolObject(poolType)
    return self.pools[poolType]:AcquireObject()
end

function CombatTextPoolManager:ReleasePoolObject(poolType, objectKey)
    self.pools[poolType]:ReleaseObject(objectKey)
end

function CombatTextPoolManager:TotalFree()
    local count = 0
    for k, _ in pairs(self.pools) do
        count = count + self.pools[k]:GetFreeObjectCount()
    end
    return count
end

function CombatTextPoolManager:TotalInUse()
    local count = 0
    for k, _ in pairs(self.pools) do
        count = count + self.pools[k]:GetActiveObjectCount()
    end
    return count
end
