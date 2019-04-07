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

    return strformat("FPS: <<1>>", math.floor(framerate))
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

    return strformat("PR: <<1>>", math.floor(latency))
end

function PNL.GetPlayerName()
    local playerName = GetUnitName("player")

    return strformat("Name: <<1>>", playerName)
end

function PNL.GetPlayerRace()
    local playerRace = GetUnitRace("player")

    return strformat("Race: <<1>>", playerRace)
end

function PNL.GetPlayerClass()
    local playerClass = GetUnitClass("player")

    return strformat("Class: <<1>>", playerClass)
end

function PNL.GetCurrentZone()
    local zoneName = GetPlayerLocationName()

    return strformat("Zone: <<1>>", zoneName)
end

function PNL.GetPlayerLevel()
    if IsUnitChampion("player") then
        playerLevel = GetPlayerChampionPointsEarned()
    else
        playerLevel = GetUnitLevel("player")
    end

    return strformat("Level: <<1>>", playerLevel)
end

function PNL.GetMountTraining()
    local timeUntilMountFeed, totalTime = GetTimeUntilCanBeTrained()
    --local speedBonus, _, staminaBonus, _, inventoryBonus = STABLE_MANAGER:GetStats()
    --local ridingSkillMaxedOut = STABLE_MANAGER:IsRidingSkillMaxedOut()

    local carry, carryMax, stamina, staminaMax, speed, speedMax = GetRidingStats()

    return strformat("Mount: <<1>> <<2>>", timeUntilMountFeed, totalTime)
end

function PNL.GetSoulgemsAmount()
    local icon = "/esoui/art/icons/soulgem_006_filled.dds"

    local playerLvl = GetUnitEffectiveLevel("player")
    local emptyName, iconEmpty, emptySoulgems = GetSoulGemInfo(SOUL_GEM_TYPE_EMPTY, playerLvl)
    local fullName, iconFull, fullSoulgems = GetSoulGemInfo(SOUL_GEM_TYPE_FILLED, playerLvl)

    return strformat("Soulgems: <<1>>/<<2>>", emptySoulgems, fullSoulgems)
end

function PNL.GetCurrentTime()
    -- https://wiki.esoui.com/FormatTimeMilliseconds
    --ZO_FormatTime
    --TIME_FORMAT_PRECISION_TWELVE_HOUR,
    --TIME_FORMAT_PRECISION_TWENTY_FOUR_HOUR
    local time = GetTimeString()

    return strformat("Time: <<1>>", time)
end

function PNL.GetBagSpace()
    local bagId = BAG_BACKPACK

    local bagSize = GetBagSize(bagId)
    local bagFree = GetNumBagFreeSlots(bagId)
    local bagUsed = GetNumBagUsedSlots(bagId)

    local bagPercentageUsed = math.floor((bagUsed / bagSize) * 100)
    local bagPercentageFree = math.floor(((bagSize - bagUsed) / bagSize) * 100)

    return strformat("Bag Space: <<1>>/<<2>>", bagUsed, bagSize)
end

function PNL.GetBankSpace()
    local bankId = BAG_BANK
    local bankSubId = BAG_SUBSCRIBER_BANK

    local bankSize = GetBagSize(bankId)
    local bankFree = GetNumBagFreeSlots(bankId)
    local bankUsed = GetNumBagUsedSlots(bankId)

    if IsESOPlusSubscriber() then
        bankSize = bankSize + GetBagSize(bankSubId)
        bankFree = bankFree + GetNumBagFreeSlots(bankSubId)
        bankUsed = bankUsed + GetNumBagUsedSlots(bankSubId)
    end

    local bankPercentageUsed = math.floor((bankUsed / bankSize) * 100)
    local bankPercentageFree = math.floor(((bankSize - bankUsed) / bankSize) * 100)

    return strformat("Bank Space: <<1>>/<<2>>", bankUsed, bankSize)
end

function PNL.GetPlayerXP()
    local icon = "/esoui/art/icons/icon_experience.dds"

    if IsUnitChampion("player") then
        local playerRank = GetPlayerChampionPointsEarned()
        local playerXP = GetPlayerChampionXP()
        local playerXPLvl = GetNumChampionXPInChampionPoint(playerRank)
    else
        local playerXP = GetUnitXP("player")
        local playerXPLvl = GetUnitXPMax("player")
    end

    return strformat("XP: <<1>>/<<2>>", playerXP, playerXPLvl)
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

    return strformat("<<1>> <<2>>: <<2>>", currencyIcon, currencyTitle, currency)
end

function PNL.GetAchievementPoints()
    local icon = "/esoui/art/tutorial/gamepad/gp_playermenu_icon_achievements.dds"

    local earnedPoints = GetEarnedAchievementPoints()
    local totalPoints = GetTotalAchievementPoints()

    local percentageDone = math.floor((earnedPoints / totalPoints) * 100)
    local percentageMissing = math.floor(((totalPoints - earnedPoints) / totalPoints) * 100)

    return strformat("Achievement Points: <<1>>/<<2>>", earnedPoints, totalPoints)
end

function PNL.GetFenceInfo()
    local totalLaunderd, usedLaunderd, resetTime = GetFenceLaunderTransactionInfo()
    local totalSells, usedSells, resetTime = GetFenceSellTransactionInfo()

    local fenceSells = totalSells - usedSells
    local fenceLaunders = totalLaunderd - usedLaunderd

    return strformat("Fence: Sells: <<1>> Launders: <<2>>", fenceSells, fenceLaunders)
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

    return strformat("Repair Cost: <<1>>", repairCost)
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

    return strformat("Unspent Skillpoints: <<1>> Skyshards: <<2>>/3", unspentSkillpoints, skyshards)
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
