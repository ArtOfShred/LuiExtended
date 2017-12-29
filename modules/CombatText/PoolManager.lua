LUIE.CombatTextPoolManager = ZO_Object:Subclass()
local CTPM = LUIE.CombatTextPoolManager

function CTPM:New()
    local obj = ZO_Object:New(self)
    self.pools = {}
    return obj
end

function CTPM:RegisterPool(poolType, pool)
    self.pools[poolType] = pool
end

function CTPM:GetPoolObject(poolType)
    return self.pools[poolType]:AcquireObject()
end

function CTPM:ReleasePoolObject(poolType, objectKey)
    self.pools[poolType]:ReleaseObject(objectKey)
end

function CTPM:TotalFree()
    local count = 0
    for k, _ in pairs(self.pools) do
        count = count + self.pools[k]:GetFreeObjectCount()
    end
    return count
end

function CTPM:TotalInUse()
    local count = 0
    for k, _ in pairs(self.pools) do
        count = count + self.pools[k]:GetActiveObjectCount()
    end
    return count
end
