CombatCloud_Pool = ZO_ObjectPool:Subclass()

local fastSlow = ZO_GenerateCubicBezierEase(.3, .9, .7, 1)
local slowFast = ZO_GenerateCubicBezierEase(.63, .1, .83, .69)
local even = ZO_GenerateCubicBezierEase(.63, 1.2, .83, 1)
local easeOutIn = function(progress)
    progress = progress < 0.5 and progress * 2 or (1 - progress) * 2  
    return zo_sqrt(1 - ((1 - progress) ^ 2))
end 

local poolTypes = CombatCloudConstants.poolType

function CombatCloud_Pool:New(poolType)
    local obj
    if poolType == poolTypes.CONTROL then 
        obj = ZO_ObjectPool:New(self.CreateNewControl, self.ResetControl)
    else
        obj = ZO_ObjectPool:New(self.CreateNewAnimation, function() end)
    end    
    obj.poolType = poolType
    return obj
end

function CombatCloud_Pool:CreateNewControl()
    local control = CreateControlFromVirtual('CombatCloud_Virtual_Instance', CombatCloud, 'CombatCloud_Virtual', self:GetNextControlId())
    control.label = control:GetNamedChild('_Amount')
    control.icon  = control:GetNamedChild('_Icon')  
    return control 
end

function CombatCloud_Pool.ResetControl(control)
    control:ClearAnchors()
    control.label:ClearAnchors()
    control.icon:ClearAnchors()
    control.icon:SetHidden(true)
end

function CombatCloud_Pool:CreateNewAnimation()
    local anim = CombatCloud_Animation:New()

    if (self.poolType == poolTypes.ANIMATION_CLOUD) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Alpha(nil, 1, 0, 500, 1500, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_CLOUD_CRITICAL) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Scale(nil, 1.5, 1, 150, 0, slowFast)
        anim:Alpha(nil, 1, 0, 500, 1500, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_CLOUD_FIREWORKS) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Move('move', 0, 0, 250, 0, fastSlow) -- x and y is set before the animation is played
        anim:Alpha('fadeOut', 1, 0, 500, 1500, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_SCROLL) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Move('scroll', 0, 0, 2500, 0, even)
        anim:Alpha('fadeOut', 1, 0, 500, 1400, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_SCROLL_CRITICAL) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Scale(nil, 1.5, 1, 150, 0, slowFast)
        anim:Move('scroll', 0, 0, 2500, 0, even)
        anim:Alpha('fadeOut', 1, 0, 500, 1400, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_ALERT) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Scale(nil, 0.5, 1.5, 100, 0, fastSlow)
        anim:Scale(nil, 1.5, 1, 200, 250, slowFast)
        anim:Alpha(nil, 1, 0, 500, 3000, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_COMBATSTATE) then
        anim:Alpha(nil, 0, 1, 1000, 0, slowFast)
        anim:Alpha(nil, 1, 0, 500, 3000, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_POINT) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Alpha(nil, 1, 0, 500, 3000, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_RESOURCE) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Scale(nil, 0.5, 1.5, 100, 0, fastSlow)
        anim:Scale(nil, 1.5, 1, 200, 250, slowFast)
        anim:Alpha(nil, 1, 0, 500, 3000, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_ELLIPSE_X) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Move('scrollX', 0, 0, 2500, 0, easeOutIn)
        anim:Alpha('fadeOut', 1, 0, 500, 1800, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_ELLIPSE_Y) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Move('scrollY', 0, 0, 2500) --for delay and easying function will be used defaults (0, ZO_LinearEase)  
        anim:Alpha('fadeOut', 1, 0, 500, 1800, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_ELLIPSE_X_CRIT) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Scale(nil, 1.5, 1, 150, 0, slowFast)
        anim:Move('scrollX', 0, 0, 2500, 0, easeOutIn)
        anim:Alpha('fadeOut', 1, 0, 500, 1800, slowFast)

    elseif (self.poolType == poolTypes.ANIMATION_ELLIPSE_Y_CRIT) then
        anim:Alpha(nil, 0, 1, 50)
        anim:Scale(nil, 1.5, 1, 150, 0, slowFast)
        anim:Move('scrollY', 0, 0, 2500)
        anim:Alpha('fadeOut', 1, 0, 500, 1800, slowFast)

    end

    return anim
end