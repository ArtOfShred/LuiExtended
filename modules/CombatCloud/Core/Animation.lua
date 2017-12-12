CombatCloud_Animation = ZO_Object:Subclass()

local ANIMATION_MANAGER = ANIMATION_MANAGER
local ANIMATION_ALPHA = ANIMATION_ALPHA
local ANIMATION_SCALE = ANIMATION_SCALE
local ANIMATION_TRANSLATE = ANIMATION_TRANSLATE
local linearEase = ZO_LinearEase

function CombatCloud_Animation:New()
    local obj = ZO_Object:New(self)
    obj.timeline = ANIMATION_MANAGER:CreateTimeline()
    obj.timeline:SetPlaybackType(0, 0)
    obj.namedSteps = {}
    return obj
end

function CombatCloud_Animation:Apply(control)
    self.timeline:ApplyAllAnimationsToControl(control)
end

function CombatCloud_Animation:Stop()
    self.timeline:Stop()
end

function CombatCloud_Animation:SetProgress(progress)
    self.timeline:SetProgress(progress)
end

function CombatCloud_Animation:Play()
    self.timeline:PlayFromStart()
end

function CombatCloud_Animation:PlayForward()
    self.timeline:PlayForward()
end

function CombatCloud_Animation:PlayInstantlyToEnd()
    self.timeline:PlayInstantlyToEnd()
end

function CombatCloud_Animation:Alpha(stepName, startAlpha, endAlpha, duration, delay, easingFunc)
    local step = self.timeline:InsertAnimation(ANIMATION_ALPHA, nil, delay or 0)
    step:SetAlphaValues(startAlpha, endAlpha)
    step:SetDuration(duration)
    step:SetEasingFunction(easingFunc or linearEase)
    if (stepName ~= nil and stepName ~= '') then self.namedSteps[stepName] = step end
    return step
end

function CombatCloud_Animation:Scale(stepName, startScale, endScale, duration, delay, easingFunc)
    local step = self.timeline:InsertAnimation(ANIMATION_SCALE, nil, delay or 0)
    step:SetScaleValues(startScale, endScale)
    step:SetDuration(duration)
    step:SetEasingFunction(easingFunc or linearEase)
    if (stepName ~= nil and stepName ~= '') then self.namedSteps[stepName] = step end
    return step
end

function CombatCloud_Animation:Move(stepName, offsetX, offsetY, duration, delay, easingFunc)
    local step = self.timeline:InsertAnimation(ANIMATION_TRANSLATE, nil, delay or 0)
    step:SetTranslateDeltas(offsetX, offsetY)
    step:SetDuration(duration)
    step:SetEasingFunction(easingFunc or linearEase)
    if (stepName ~= nil and stepName ~= '') then self.namedSteps[stepName] = step end
    return step
end

function CombatCloud_Animation:InsertCallback(func, delay)
    self.timeline:InsertCallback(func, delay)
end

function CombatCloud_Animation:ClearCallbacks()
    self.timeline:ClearAllCallbacks()
end

function CombatCloud_Animation:GetStep(i)
    return self.timeline:GetAnimation(i)
end

function CombatCloud_Animation:GetStepByName(stepName)
    if (stepName ~= nil and stepName ~= '') then
        return self.namedSteps[stepName]
    end
end

function CombatCloud_Animation:GetLastStep()
    return self.timeline:GetLastAnimation()
end

function CombatCloud_Animation:SetStepDelay(step, delay)
    return self.timeline:SetAnimationOffset(step, delay)
end

function CombatCloud_Animation:GetDuration()
    return self.timeline:GetDuration()
end

function CombatCloud_Animation:GetProgress()
    return self.timeline:GetProgress()
end