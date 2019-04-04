--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local SCB = LUIE.SpellCastBuffs
local A = LUIE.GetAbility()

local strformat = zo_strformat

local g_currentDuelTarget = nil -- Saved Duel Target for generating Battle Spirit icon when enabled

-- EVENT_DUEL_STARTED handler for creating Battle Spirit Icon on Target
function SCB.DuelStart()
    local duelState, characterName = GetDuelInfo()
    if duelState == 3 and not SCB.SV.IgnoreBattleSpiritTarget then
        g_currentDuelTarget = strformat(SI_UNIT_NAME, characterName)
        SCB.ReloadEffects("reticleover")
    end
end

-- EVENT_DUEL_FINISHED handler for removing Battle Spirit Icon on Target
function SCB.DuelEnd()
    g_currentDuelTarget = nil
    SCB.ReloadEffects("reticleover")
end

function SCB.LoadBattleSpiritTarget()
    -- Return if we don't have Battle Spirit enabled for Target
    if SCB.SV.HideTargetBuffs or SCB.SV.IgnoreBattleSpiritTarget then
        return
    end

    -- Create Battle Spirit Buff if we are in a PVP zone or this is our current Duel Target
    if ( LUIE.ResolvePVPZone() and IsUnitPlayer("reticleover") and (GetUnitReaction("reticleover") == UNIT_REACTION_PLAYER_ALLY) ) or GetUnitName("reticleover") == g_currentDuelTarget then
        LUIE.EffectsList.reticleover1[ A.Skill_Battle_Spirit ] = {
            type=1,
            id=85701, name=A.Skill_Battle_Spirit, icon = "esoui/art/icons/artificialeffect_battle-spirit.dds",
            dur=0, starts=1, ends=nil,
            forced = "short",
            restart=true, iconNum=0,
        }
    end
end

function SCB.LoadCyrodiilBuffs(unitTag)
    -- If we aren't in the AvA World then return (needs to check for Cyrodiil only - we don't want this displaying in BG's)
    if not IsPlayerInAvAWorld() then
        return
    end

    -- If the unitTag isn't a player then bail out
    if not IsUnitPlayer(unitTag) then
        return
    end

    -- Return if we don't have Buffs / Cyrodiil Buffs enabled for this unitTag
    if unitTag == "player" and (SCB.SV.HidePlayerBuffs or SCB.SV.IgnoreCyrodiilPlayer) then
        return
    elseif unitTag == "reticleover" and (SCB.SV.HideTargetBuffs or SCB.SV.IgnoreCyrodiilTarget) then
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
    local homeKeep, _, _, _, edgeKeepCount = GetAvAKeepScore(campaignId, alliance)
    local id
    local icon
    local name
    local stack

    if edgeKeepCount >= 1 then
        if edgeKeepCount == 1 then
            id = 111549
            icon = "LuiExtended/media/icons/abilities/ability_cryodiil_edge_keep_bonus_1.dds"
            name = A.Skill_Edge_Keep_Bonus_1
            stack = 1
        elseif edgeKeepCount == 2 then
            id = 111552
            icon = "LuiExtended/media/icons/abilities/ability_cryodiil_edge_keep_bonus_2.dds"
            name = A.Skill_Edge_Keep_Bonus_2
            stack = 2
        elseif edgeKeepCount == 3 then
            id = 111553
            icon = "LuiExtended/media/icons/abilities/ability_cryodiil_edge_keep_bonus_3.dds"
            name = A.Skill_Edge_Keep_Bonus_3
            stack = 3
        end
        if not (SCB.SV.BlacklistTable[id] or SCB.SV.BlacklistTable[name]) then
            LUIE.EffectsList[context][ A.Skill_Edge_Keep_Bonus_1 ] = {
                target=unitTag, type=1,
                id=id, name=name, icon = icon,
                dur=0, starts=1, ends=nil,
                forced = forced,
                restart=true, iconNum=0,
                stack = stack,
            }
        end
    end
    if homeKeep and not (SCB.SV.BlacklistTable[11346] or SCB.SV.BlacklistTable[A.Skill_Home_Keep_Bonus]) then
        LUIE.EffectsList[context][ A.Skill_Home_Keep_Bonus ] = {
            target = unitTag, type=1,
            id=11346, name=A.Skill_Home_Keep_Bonus, icon = "LuiExtended/media/icons/abilities/ability_cyrodiil_home_keep_bonus.dds",
            dur=0, starts=1, ends=nil,
            forced = forced,
            restart=true, iconNum=0,
        }
    end
end
