--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SpellCastBuffs = LUIE.SpellCastBuffs

local AssistantIcons = LUIE.Data.Effects.AssistantIcons

local zo_strformat = zo_strformat

-- On Reticle Target Change, load mount if needed
function SpellCastBuffs.DisplayMountIcon(unitTag)

    -- Bail out if somehow a non-player/target unitTag gets passed here
    if unitTag ~= "player" and unitTag ~= "reticleover" then
        return
    end

    -- Bail out if we have target mount hidden (we check for target buffs being disabled in the reticleover function that calls this function)
    if unitTag == "reticleover" and SpellCastBuffs.SV.IgnoreMountTarget then
        return
    end

    -- Check mounted state
    local name = GetRawUnitName(unitTag)
    local mountedState = GetTargetMountedStateInfo(name)

    if mountedState == PLAYER_MOUNTED_STATE_MOUNT_RIDER or mountedState == PLAYER_MOUNTED_STATE_MOUNT_PASSENGER then
        local name
        local description
        local icon
        if mountedState == PLAYER_MOUNTED_STATE_MOUNT_RIDER then
            if unitTag == "player" and SpellCastBuffs.SV.MountDetail then
                -- Get detailed collectible information for the player
                local collectible = GetActiveCollectibleByType(COLLECTIBLE_CATEGORY_TYPE_MOUNT)
                local nickname = GetCollectibleNickname(collectible)
                name, description, icon = GetCollectibleInfo(collectible)

                -- Add the nickname into the name if present
                if (nickname ~= "" and nickname ~= nil) then
                    name = zo_strformat('<<1>> "<<2>>"', name, nickname)
                end
            else
                name = GetString(SI_LUIE_SKILL_MOUNTED)
                description = GetString(SI_LUIE_SKILL_MOUNTED_TP)
                icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds'
            end
        elseif mountedState == PLAYER_MOUNTED_STATE_MOUNT_PASSENGER then
            name = GetString(SI_LUIE_SKILL_MOUNTED_PASSENGER)
            description = GetString(SI_LUIE_SKILL_MOUNTED_PASSENGER_TP)
            icon = 'LuiExtended/media/icons/abilities/ability_innate_mounted.dds'
        end

        local target = unitTag .. 1
        SpellCastBuffs.EffectsList[target]["Mount"] = {
            target=unitTag, type=1,
            id = 37059, name = name, icon = icon, backdrop = true, tooltip = description,
            dur = 0, starts = 1, ends = nil, -- ends=nil : last buff in sorting
            forced = "long",
            restart = true, iconNum = 0
        }
    end

end

-- EVENT_MOUNTED_STATE_CHANGED handler to create Mount Buff icon for player
function SpellCastBuffs.MountStatus(eventCode, mounted)
    -- Clear current mount icon
    SpellCastBuffs.EffectsList.player1["Mount"] = nil
    -- Display mount icon if settings are enabled
    if mounted and not (SpellCastBuffs.SV.IgnoreMountPlayer or SpellCastBuffs.SV.HidePlayerBuffs) then
        SpellCastBuffs.DisplayMountIcon("player")
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
