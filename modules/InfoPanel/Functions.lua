--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local PNL = LUIE.InfoPanel

local strformat = zo_strformat

function PNL.GetFramesPerSecond()
    local framerate = GetFramerate()
    local lowFPS = 20
    local medFPS = 45

    if framerate > lowFPS and framerate <= medFPS then
        -- bad fps (orange)
    elseif framerate <= lowFPS then
        -- very bad fps (red)
    else
        -- good fps (green)
    end

    return math.floor(framerate)
end

function PNL.GetLatency()
    local latency = GetLatency()
    local highLatency = 300
    local medLatency = 150

    if latency < medLatency then
        -- good latency (green)
    elseif latency >= medLatency and latency < highLatency then
        -- mediocre Latency (orange)
    elseif latency >= highLatency then
        -- bad latency (red)
    end

    return math.floor(latency)
end

function PNL.GetPlayerName()
    local playerName = GetUnitName("player")

    return playerName
end

function PNL.GetPlayerRace()
    local playerRace = GetUnitRace("player")

    return playerRace
end

function PNL.GetPlayerClass()
    local playerClass = GetUnitClass("player")

    return playerClass
end

function PNL.GetCurrentZone()
    local zoneName = GetPlayerLocationName()

    return zoneName
end

function PNL.GetPlayerLevel()
    local playerLevel

    if IsUnitChampion("player") then
        playerLevel = GetPlayerChampionPointsEarned()
    else
        playerLevel = GetUnitLevel("player")
    end

    return playerLevel
end

function PNL.GetMountTraining()
    local timeUntilMountFeed, totalTime = GetTimeUntilCanBeTrained()
    --local speedBonus, _, staminaBonus, _, inventoryBonus = STABLE_MANAGER:GetStats()
    --local ridingSkillMaxedOut = STABLE_MANAGER:IsRidingSkillMaxedOut()

    local carry, carryMax, stamina, staminaMax, speed, speedMax = GetRidingStats()

    return timeUntilMountFeed, totalTime
end

function PNL.GetSoulgemsAmount()
    local icon = "/esoui/art/icons/soulgem_006_filled.dds"

    local playerLevel = GetUnitEffectiveLevel("player")
    local emptyName, iconEmpty, emptySoulgems = GetSoulGemInfo(SOUL_GEM_TYPE_EMPTY, playerLevel)
    local fullName, iconFull, fullSoulgems = GetSoulGemInfo(SOUL_GEM_TYPE_FILLED, playerLevel)

    return emptySoulgems, fullSoulgems
end

function PNL.GetCurrentTime()
    -- https://wiki.esoui.com/FormatTimeMilliseconds
    --ZO_FormatTime
    --TIME_FORMAT_PRECISION_TWELVE_HOUR,
    --TIME_FORMAT_PRECISION_TWENTY_FOUR_HOUR
    local time = GetTimeString()

    return time
end

function PNL.GetBagSpace()
    local bagSize = GetBagSize(BAG_BACKPACK)
    local bagFree = GetNumBagFreeSlots(BAG_BACKPACK)
    local bagUsed = GetNumBagUsedSlots(BAG_BACKPACK)

    local bagPercentageUsed = math.floor((bagUsed / bagSize) * 100)
    local bagPercentageFree = math.floor(((bagSize - bagUsed) / bagSize) * 100)

    return bagUsed, bagSize, bagPercentageUsed, bagPercentageFree
end

function PNL.GetBankSpace()
    local bankSize = GetBagSize(BAG_BANK)
    local bankFree = GetNumBagFreeSlots(BAG_BANK)
    local bankUsed = GetNumBagUsedSlots(BAG_BANK)

    if IsESOPlusSubscriber() then
        bankSize = bankSize + GetBagSize(BAG_SUBSCRIBER_BANK)
        bankFree = bankFree + GetNumBagFreeSlots(BAG_SUBSCRIBER_BANK)
        bankUsed = bankUsed + GetNumBagUsedSlots(BAG_SUBSCRIBER_BANK)
    end

    local bankPercentageUsed = math.floor((bankUsed / bankSize) * 100)
    local bankPercentageFree = math.floor(((bankSize - bankUsed) / bankSize) * 100)

    return bankUsed, bankSize, bankPercentageUsed, bankPercentageFree
end

function PNL.GetPlayerXP()
    local icon = "/esoui/art/icons/icon_experience.dds"
    local playerCPRank
    local playerXP
    local playerLevel

    if IsUnitChampion("player") then
        playerCPRank = GetPlayerChampionPointsEarned()
        playerXP = GetPlayerChampionXP()
        playerXPLevel = GetNumChampionXPInChampionPoint(playerCPRank)
    else
        playerXP = GetUnitXP("player")
        playerXPLevel = GetUnitXPMax("player")
    end

    return playerXP, playerXPLevel, playerCPRank
end

--[[
CurrencyType:
CURT_MONEY
CURT_ALLIANCE_POINTS
CURT_CROWNS
CURT_CROWN_GEMS
CURT_EVENT_TICKETS
CURT_TELVAR_STONES
CURT_CHAOTIC_CREATIA

Location: (Probably only want Account and Character anyways)
"Account" = CURRENCY_LOCATION_ACCOUNT,
"Bank" = CURRENCY_LOCATION_BANK,
"Character" = CURRENCY_LOCATION_CHARACTER,
"Guild Bank" = CURRENCY_LOCATION_GUILD_BANK,

Icons:
"/esoui/art/currency/currency_gold.dds"
"/esoui/art/currency/currency_crown.dds"
"/esoui/art/currency/currency_crown_gems.dds"
"/esoui/art/currency/currency_eventticket.dds"
"/esoui/art/currency/currency_telvar.dds"
"/esoui/art/currency/currency_writvoucher.dds"
"/esoui/art/currency/icon_seedcrystal.dds"
--]]
function PNL.GetCurrency(currencyType, currencyLocation, currencyTitle, currencyIcon)
    local currency = GetCurrencyAmount(currencyType, currencyLocation)

    return currencyIcon, currencyTitle, currency
end

function PNL.GetAchievementPoints()
    local icon = "/esoui/art/tutorial/gamepad/gp_playermenu_icon_achievements.dds"

    local earnedPoints = GetEarnedAchievementPoints()
    local totalPoints = GetTotalAchievementPoints()

    local percentageDone = math.floor((earnedPoints / totalPoints) * 100)
    local percentageMissing = math.floor(((totalPoints - earnedPoints) / totalPoints) * 100)

    return earnedPoints, totalPoints, percentageDone, percentageMissing
end

function PNL.GetFenceInfo()
    local totalLaunderd, usedLaunderd, resetTime = GetFenceLaunderTransactionInfo()
    local totalSells, usedSells, resetTime = GetFenceSellTransactionInfo()

    local fenceSells = totalSells - usedSells
    local fenceLaunders = totalLaunderd - usedLaunderd

    return fenceSells, fenceLaunders
end

function PNL.GetGearRepairCost()
    local icon = "/esoui/art/progression/progression_indexicon_armor_up.dds"
    local repairCost = 0
    local bagSlots = GetBagSize(BAG_WORN)

    for slotIndex=0, bagSlots - 1 do
        local condition = GetItemCondition(BAG_WORN, slotIndex)
        if condition < 100 and not IsItemStolen(BAG_WORN, slotIndex) then
            local icon, stackCount, _, _, _, _, _, quality = GetItemInfo(BAG_WORN, slotIndex)
            if stackCount > 0 then
                repairCost = repairCost + GetItemRepairCost(BAG_WORN, slotIndex)
            end
        end
    end

    return repairCost
end

--[[
Icons:
CRAFTING_TYPE_WOODWORKING = "/esoui/art/icons/servicemappins/servicepin_woodworking.dds",
CRAFTING_TYPE_BLACKSMITHING = "/esoui/art/icons/servicemappins/servicepin_smithy.dds",
CRAFTING_TYPE_CLOTHIER = "/esoui/art/icons/servicemappins/servicepin_outfitter.dds",
CRAFTING_TYPE_JEWELRYCRAFTING = "/esoui/art/icons/icon_jewelrycrafting_symbol.dds",
]]--
function PNL.GetResearchStatus(craftingType)
    local numMaxSlots = GetMaxSimultaneousSmithingResearch(craftingType)
end

function PNL.GetWeaponCharge()
    local equipSlot = {
        EQUIP_SLOT_MAIN_HAND,
        EQUIP_SLOT_OFF_HAND,
        EQUIP_SLOT_BACKUP_MAIN,
        EQUIP_SLOT_BACKUP_OFF
    }

    for i, slot in pairs(equipSlot) do
        if IsItemChargeable(BAG_WORN, slot) then
            local charges, maxCharges = GetChargeInfoForItem(BAG_WORN, slot)
            d(slot .. "  " .. charges .. "/" .. maxCharges)
        end
    end
end

function PNL.GetSkyshardInfo()
    local unspentSkillpoints = GetAvailableSkillPoints()
    local skyshards = GetNumSkyShards()

    return unspentSkillpoints, skyshards
end

function PNL.GetEnlightenment()
    local boosted = 0

    if IsEnlightenedAvailableForCharacter() then
        local enlightenmentPool = GetEnlightenedPool()
        local enlightenmentMultiplier = 1 + GetEnlightenedMultiplier() -- the multiplier is zero-indexed

        if enlightenmentPool > 0 then
            boosted = enlightenmentPool * enlightenmentMultiplier
        end
    end

    return boosted
end
