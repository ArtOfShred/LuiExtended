CombatCloud_PoolManager = ZO_Object:Subclass()

function CombatCloud_PoolManager:New()
    local obj = ZO_Object:New(self)
    self.pools = {}
    return obj
end

function CombatCloud_PoolManager:RegisterPool(poolType, pool)
    self.pools[poolType] = pool
end

function CombatCloud_PoolManager:GetPoolObject(poolType)
    return self.pools[poolType]:AcquireObject()
end

function CombatCloud_PoolManager:ReleasePoolObject(poolType, objectKey)
    self.pools[poolType]:ReleaseObject(objectKey)
end

function CombatCloud_PoolManager:TotalFree()
    local count = 0
    for k, _ in pairs(self.pools) do
        count = count + self.pools[k]:GetFreeObjectCount()
    end
    return count
end

function CombatCloud_PoolManager:TotalInUse()
    local count = 0
    for k, _ in pairs(self.pools) do
        count = count + self.pools[k]:GetActiveObjectCount()
    end
    return count
end