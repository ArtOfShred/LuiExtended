--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- Performance Enhancement
local SCB           = LUIE.SpellCastBuffs
local strformat     = zo_strformat
local callLater     = zo_callLater

-- EVENT_MOUNTED_STATE_CHANGED handler to create Mount Buff icon for player
function SCB.MountStatus(eventCode, mounted)
    -- Remove icon first
    LUIE.EffectsList.player1["Mount"] = nil
    if mounted and not (SCB.SV.IgnoreMount or SCB.SV.HidePlayerBuffs) then

        local collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_MOUNT)
        local nickname = GetCollectibleNickname(collectible)
        local name, description, icon = GetCollectibleInfo(collectible)

        -- Add the nickname into the name if present
        if (nickname ~= "" and nickname ~= nil) then
            name = strformat('<<1>> "<<2>>"', name, nickname)
        end

        -- Use Generic Mount Icon if enabled
        if SCB.SV.MountGenericIcon then
            icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds'
        end

        LUIE.EffectsList.player1["Mount"] = {
            target="player", type=1,
            id =37059, name=name, icon=icon, backdrop=true, tooltip = description,
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart=true, iconNum=0
        }
    end
end

-- EVENT_COLLECTIBLE_USE_RESULT handler - Waits 100 ms + latency for the delay in activating collectibles before checking
function SCB.CollectibleUsed(eventCode, result, isAttemptingActivation)
    local latency = GetLatency()
    latency = latency + 100
    callLater(SCB.CollectibleBuff, latency)
end

-- Handles delayed call from SCB.CollectibleUsed()
function SCB.CollectibleBuff()

    -- Remove Icon First
    LUIE.EffectsList.player1["PetType"] = nil
    LUIE.EffectsList.player1["AssistantType"] = nil

    -- Bail out if Player Buffs are hidden
    if SCB.SV.HidePlayerBuffs then
        return
    end

    -- Bail out if we are in a PVP Zone
    if LUIE.ResolvePVPZone() then
        return
    end

    -- Pets
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET) > 0 and not SCB.SV.IgnorePet then
        local collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET)
        local nickname = GetCollectibleNickname(collectible)
        local name, description, icon = GetCollectibleInfo(collectible)

        -- Add the nickname into the name if present
        if (nickname ~= "" and nickname ~= nil) then
            name = strformat('<<1>> "<<2>>"', name, nickname)
        end

        LUIE.EffectsList.player1["PetType"] = {
            target="player", type=1,
            id = "Fake", name=name, icon=icon, backdrop=true, tooltip = description,
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart=true, iconNum=0
        }
    end

    -- Assistants
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0 and not SCB.SV.IgnoreAssistant then
        local collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT)
        local name, description = GetCollectibleInfo(collectible)
        local iconAssistant = E.AssistantIcons[name] ~= nil and E.AssistantIcons[name] or ''

        LUIE.EffectsList.player1["AssistantType"] = {
            target="player", type=1,
            id = "Fake", name=name, icon=iconAssistant, tooltip = description,
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart=true, iconNum=0
        }
    end

end
