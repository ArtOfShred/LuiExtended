LUIE.CombatTextAnimation = ZO_Object:Subclass()
local CTA = LUIE.CombatTextAnimation

local ANIMATION_MANAGER = ANIMATION_MANAGER
local ANIMATION_ALPHA = ANIMATION_ALPHA
local ANIMATION_SCALE = ANIMATION_SCALE
local ANIMATION_TRANSLATE = ANIMATION_TRANSLATE
local linearEase = ZO_LinearEase

function CTA:New()
    local obj = ZO_Object:New(self)
    obj.timeline = ANIMATION_MANAGER:CreateTimeline()
    obj.timeline:SetPlaybackType(0, 0)
    obj.namedSteps = {}
    return obj
end

function CTA:Apply(control)
    self.timeline:ApplyAllAnimationsToControl(control)
end

function CTA:Stop()
    self.timeline:Stop()
end

function CTA:SetProgress(progress)
    self.timeline:SetProgress(progress)
end

function CTA:Play()
    self.timeline:PlayFromStart()
end

function CTA:PlayForward()
    self.timeline:PlayForward()
end

function CTA:PlayInstantlyToEnd()
    self.timeline:PlayInstantlyToEnd()
end

function CTA:Alpha(stepName, startAlpha, endAlpha, duration, delay, easingFunc)
    local step = self.timeline:InsertAnimation(ANIMATION_ALPHA, nil, delay or 0)
    step:SetAlphaValues(startAlpha, endAlpha)
    step:SetDuration(duration)
    step:SetEasingFunction(easingFunc or linearEase)
    if (stepName ~= nil and stepName ~= '') then self.namedSteps[stepName] = step end
    return step
end

function CTA:Scale(stepName, startScale, endScale, duration, delay, easingFunc)
    local step = self.timeline:InsertAnimation(ANIMATION_SCALE, nil, delay or 0)
    step:SetScaleValues(startScale, endScale)
    step:SetDuration(duration)
    step:SetEasingFunction(easingFunc or linearEase)
    if (stepName ~= nil and stepName ~= '') then self.namedSteps[stepName] = step end
    return step
end

function CTA:Move(stepName, offsetX, offsetY, duration, delay, easingFunc)
    local step = self.timeline:InsertAnimation(ANIMATION_TRANSLATE, nil, delay or 0)
    step:SetTranslateDeltas(offsetX, offsetY)
    step:SetDuration(duration)
    step:SetEasingFunction(easingFunc or linearEase)
    if (stepName ~= nil and stepName ~= '') then self.namedSteps[stepName] = step end
    return step
end

function CTA:InsertCallback(func, delay)
    self.timeline:InsertCallback(func, delay)
end

function CTA:ClearCallbacks()
    self.timeline:ClearAllCallbacks()
end

function CTA:GetStep(i)
    return self.timeline:GetAnimation(i)
end

function CTA:GetStepByName(stepName)
    if (stepName ~= nil and stepName ~= '') then
        return self.namedSteps[stepName]
    end
end

function CTA:GetLastStep()
    return self.timeline:GetLastAnimation()
end

function CTA:SetStepDelay(step, delay)
    return self.timeline:SetAnimationOffset(step, delay)
end

function CTA:GetDuration()
    return self.timeline:GetDuration()
end

function CTA:GetProgress()
    return self.timeline:GetProgress()
end