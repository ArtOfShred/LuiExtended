--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SpellCastBuffs = LUIE.SpellCastBuffs

local Abilities = LUIE.Data.Abilities

local zo_strformat = zo_strformat

local g_currentDuelTarget = nil -- Saved Duel Target for generating Battle Spirit icon when enabled

-- EVENT_DUEL_STARTED handler for creating Battle Spirit Icon on Target
function SpellCastBuffs.DuelStart()
    local duelState, characterName = GetDuelInfo()
    if duelState == 3 and not SpellCastBuffs.SV.IgnoreBattleSpiritTarget then
        g_currentDuelTarget = zo_strformat("<<C:1>>", characterName)
        SpellCastBuffs.ReloadEffects("reticleover")
    end
end

-- EVENT_DUEL_FINISHED handler for removing Battle Spirit Icon on Target
function SpellCastBuffs.DuelEnd()
    g_currentDuelTarget = nil
    SpellCastBuffs.ReloadEffects("reticleover")
end

function SpellCastBuffs.LoadBattleSpiritTarget()
    -- Return if we don't have Battle Spirit enabled for Target
    if SpellCastBuffs.SV.HideTargetBuffs or SpellCastBuffs.SV.IgnoreBattleSpiritTarget then
        return
    end

    -- Create Battle Spirit Buff if we are in a PVP zone or this is our current Duel Target
    if ( LUIE.ResolvePVPZone() and IsUnitPlayer("reticleover") and (GetUnitReaction("reticleover") == UNIT_REACTION_PLAYER_ALLY) ) or GetUnitName("reticleover") == g_currentDuelTarget then
        local abilityId
        -- Imperial City version of battle spirit doesn't extend the range of our abilities, unlike the variant used for Cyrodiil, Duels, and BGs.
        if IsInImperialCity() then
            abilityId = 999015
        else
            abilityId = 999014
        end
        SpellCastBuffs.EffectsList.reticleover1[ Abilities.Skill_Battle_Spirit ] = {
            type=1,
            id=abilityId, name=Abilities.Skill_Battle_Spirit, icon = "esoui/art/icons/artificialeffect_battle-spirit.dds",
            dur=0, starts=1, ends=nil,
            forced = "short",
            restart=true, iconNum=0,
        }
    end
end

function SpellCastBuffs.LoadCyrodiilBuffs(unitTag)
    -- If we aren't in the AvA World then return (needs to check for Cyrodiil only - we don't want this displaying in BG's)
    if not IsPlayerInAvAWorld() then
        return
    end

    -- If the unitTag isn't a player then bail out
    if not IsUnitPlayer(unitTag) then
        return
    end

    -- Return if we don't have Buffs / Cyrodiil Buffs enabled for this unitTag
    if unitTag == "player" and (SpellCastBuffs.SV.HidePlayerBuffs or SpellCastBuffs.SV.IgnoreCyrodiilPlayer) then
        return
    elseif unitTag == "reticleover" and (SpellCastBuffs.SV.HideTargetBuffs or SpellCastBuffs.SV.IgnoreCyrodiilTarget) then
        return
    end

    -- Set context based off unitTag
    local context = unitTag .. "1"
    -- Force to long container if Player and short if Target
    local forced = unitTag == "player" and "long" or "short"

    local campaignId = GetCurrentCampaignId()
    local alliance = GetUnitAlliance(unitTag)
    -- Bail if no Alliance is returned
    if alliance == ALLIANCE_NONE then
        return
    end
    local _, _, _, _, edgeKeepCount = GetAvAKeepScore(campaignId, alliance)
    local id
    local icon
    local name
    local stack

    if edgeKeepCount >= 1 then
        if edgeKeepCount == 1 then
            id = 111549
            icon = "LuiExtended/media/icons/abilities/ability_cryodiil_edge_keep_bonus_1.dds"
            name = Abilities.Skill_Edge_Keep_Bonus_I
            stack = 1
        elseif edgeKeepCount == 2 then
            id = 111552
            icon = "LuiExtended/media/icons/abilities/ability_cryodiil_edge_keep_bonus_2.dds"
            name = Abilities.Skill_Edge_Keep_Bonus_II
            stack = 2
        elseif edgeKeepCount == 3 then
            id = 111553
            icon = "LuiExtended/media/icons/abilities/ability_cryodiil_edge_keep_bonus_3.dds"
            name = Abilities.Skill_Edge_Keep_Bonus_III
            stack = 3
        end
        if not (SpellCastBuffs.SV.BlacklistTable[id] or SpellCastBuffs.SV.BlacklistTable[name]) then
            SpellCastBuffs.EffectsList[context][ Abilities.Skill_Edge_Keep_Bonus_I ] = {
                target=unitTag, type=1,
                id=id, name=name, icon = icon,
                dur=0, starts=1, ends=nil,
                forced = forced,
                restart=true, iconNum=0,
                stack = stack,
            }
        end
    end
end
