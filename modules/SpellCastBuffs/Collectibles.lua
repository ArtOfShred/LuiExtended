--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SpellCastBuffs = LUIE.SpellCastBuffs

local AssistantIcons = LUIE.Data.Effects.AssistantIcons

local zo_strformat = zo_strformat

-- EVENT_MOUNTED_STATE_CHANGED handler to create Mount Buff icon for player
function SpellCastBuffs.MountStatus(eventCode, mounted)
    -- Remove icon first
    SpellCastBuffs.EffectsList.player1["Mount"] = nil
    if mounted and not (SpellCastBuffs.SV.IgnoreMount or SpellCastBuffs.SV.HidePlayerBuffs) then
        local collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_MOUNT)
        local nickname = GetCollectibleNickname(collectible)
        local name, description, icon = GetCollectibleInfo(collectible)

        -- Add the nickname into the name if present
        if (nickname ~= "" and nickname ~= nil) then
            name = zo_strformat('<<1>> "<<2>>"', name, nickname)
        end

        -- Use Generic Mount Icon if enabled
        if SpellCastBuffs.SV.MountGenericIcon then
            icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds'
        end

        SpellCastBuffs.EffectsList.player1["Mount"] = {
            target="player", type=1,
            id = 37059, name = name, icon = icon, backdrop = true, tooltip = description,
            dur = 0, starts = 1, ends = nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart = true, iconNum = 0
        }
    end
end

-- EVENT_COLLECTIBLE_USE_RESULT handler - Waits 100 ms + latency for the delay in activating collectibles before checking
function SpellCastBuffs.CollectibleUsed(eventCode, result, isAttemptingActivation)
    local latency = GetLatency()
    latency = latency + 100
    zo_callLater(SpellCastBuffs.CollectibleBuff, latency)
end

-- Handles delayed call from SpellCastBuffs.CollectibleUsed()
function SpellCastBuffs.CollectibleBuff()
    -- Remove Icon First
    SpellCastBuffs.EffectsList.player1["PetType"] = nil
    SpellCastBuffs.EffectsList.player1["AssistantType"] = nil

    -- Bail out if Player Buffs are hidden
    if SpellCastBuffs.SV.HidePlayerBuffs then
        return
    end

    -- Bail out if we are in a PVP Zone
    if LUIE.ResolvePVPZone() then
        return
    end

    -- Pets
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET) > 0 and not SpellCastBuffs.SV.IgnorePet then
        local collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_VANITY_PET)
        local nickname = GetCollectibleNickname(collectible)
        local name, description, icon = GetCollectibleInfo(collectible)

        -- Add the nickname into the name if present
        if (nickname ~= "" and nickname ~= nil) then
            name = zo_strformat('<<1>> "<<2>>"', name, nickname)
        end

        SpellCastBuffs.EffectsList.player1["PetType"] = {
            target="player", type=1,
            id = "Fake", name=name, icon=icon, backdrop=true, tooltip = description,
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart=true, iconNum=0
        }
    end

    -- Assistants
    if GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT) > 0 and not SpellCastBuffs.SV.IgnoreAssistant then
        local collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_ASSISTANT)
        local name, description = GetCollectibleInfo(collectible)
        local iconAssistant = AssistantIcons[name] or ''

        SpellCastBuffs.EffectsList.player1["AssistantType"] = {
            target="player", type=1,
            id = "Fake", name=name, icon=iconAssistant, tooltip = description,
            dur=0, starts=1, ends=nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart=true, iconNum=0
        }
    end
end
