--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.CombatTextDeathViewer = LUIE.CombatTextEventViewer:Subclass()
local CTV = LUIE.CombatTextDeathViewer

local zo_strformat = zo_strformat

local poolTypes = LUIE.CombatTextConstants.poolType

function CTV:New(...)
    local obj = LUIE.CombatTextEventViewer:New(...)
    obj:RegisterCallback(LUIE.CombatTextConstants.eventType.DEATH, function(...) self:OnEvent(...) end)
    self.locationOffset = 0  -- Simple way to avoid overlapping. When number of active notes is back to 0, the offset is also reset
    self.activePoints = 0
    return obj
end

function CTV:OnEvent(unitTag)

    local S = LUIE.CombatText.SV

	local name = zo_strformat(SI_UNIT_NAME, GetUnitName(unitTag))

    --Label setup
    local control, controlPoolKey = self.poolManager:GetPoolObject(poolTypes.CONTROL)

    local size, color, text
---------------------------------------------------------------------------------------------------------------------------------------
    --//POINTS//--
---------------------------------------------------------------------------------------------------------------------------------------
	color = S.colors.death
	size = S.fontSizes.death
	text = self:FormatString(S.formats.death, { text = name, value = name })

    self:PrepareLabel(control.label, size, color, text)
    self:ControlLayout(control)

    --Control setup
    control:SetAnchor(CENTER, LUIE_CombatText_Point, TOP, 0, self.locationOffset * (S.fontSizes.death + 5))
    self.locationOffset = self.locationOffset + 1
    self.activePoints = self.activePoints + 1

    --Get animation
    local animationPoolType = poolTypes.ANIMATION_DEATH
    local animation, animationPoolKey = self.poolManager:GetPoolObject(animationPoolType)

    local panel = LUIE_CombatText_Point
    local _, h = panel:GetDimensions()
    local targetY = h + 100
    animation:GetStepByName('scroll'):SetDeltaOffsetY(targetY)

    animation:Apply(control)
    animation:Play()

    --Add items back into pool after animation
    zo_callLater(function()
        self.poolManager:ReleasePoolObject(poolTypes.CONTROL, controlPoolKey)
        self.poolManager:ReleasePoolObject(animationPoolType, animationPoolKey)
        self.activePoints = self.activePoints - 1
        if (self.activePoints == 0 or self.activePoints >= 5 ) then
            self.locationOffset = 0
        end
    end, animation:GetDuration())
end
