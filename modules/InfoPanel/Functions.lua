--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local PNL = LUIE.InfoPanel

local strformat = zo_strformat

function PNL.GetFramesPerSecond()
    local framerate = GetFramerate()
    local lowFPS = 30
    local medFPS = 60

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
    local zone = GetPlayerLocationName()

    return strformat("Zone: <<1>>", zone)
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

    if timeUntilMountFeed == nil or totalTime == nil then
        -- none to train
    else
        return strformat("Mount: <<1>> <<2>>", timeUntilMountFeed, totalTime)
    end
end

function PNL.GetSoulgemsAmount()
    -- "/esoui/art/icons/soulgem_006_empty.dds"
    -- "/esoui/art/icons/soulgem_006_filled.dds"

    local name = ""
    local emptySoulgems = 0
    local fullSoulgems = 0
    local playerLvl = GetUnitEffectiveLevel("player")
    local emptyName, iconEmpty, emptySoulgems = GetSoulGemInfo(SOUL_GEM_TYPE_EMPTY, playerLvl)
    local fullName, iconFull, fullSoulgems = GetSoulGemInfo(SOUL_GEM_TYPE_FILLED, playerLvl)

    return strformat("Soulgems: <<1>>/<<2>>", emptySoulgems, fullSoulgems)
end

function PNL.GetCurrentTime()
    local time = GetTimeString()

    return strformat("Time: <<1>>", time)
end

function PNL.GetBagSpace()
    local bagId = BAG_BACKPACK

    local bagSize = tonumber(GetBagSize(bagId))
    local bagFree = tonumber(GetNumBagFreeSlots(bagId))
    local bagUsed = tonumber(GetNumBagUsedSlots(bagId))

    local bagPercentage = ( bagUsed / bagSize ) * 100

    return strformat("Bag Space: <<1>>/<<2>> <<3>>% Full", bagUsed, bagSize, bagPercentage)
end

function PNL.GetBankSpace()
    local bankId = BAG_BANK
    local bankSubId = BAG_SUBSCRIBER_BANK

    local bankSize = GetBagSize(bankId)
    local bankFree = GetNumBagFreeSlots(bankId)
    local bankUsed = GetNumBagUsedSlots(bankId)

    if IsESOPlusSubscriber() then
        bankSize = tonumber(bankSize + GetBagSize(bankSubId))
        bankFree = tonumber(bankFree + GetNumBagFreeSlots(bankSubId))
        bankUsed = tonumber(bankUsed + GetNumBagUsedSlots(bankSubId))
    end

    local bankPercentage = ( bankUsed / bankSize ) * 100

    return strformat("Bank Space: <<1>>/<<2>> <<3>>% Full", bankUsed, bankSize, bankPercentage)
end

function PNL.GetPlayerXP()
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
    -- "/esoui/art/tutorial/gamepad/gp_playermenu_icon_achievements.dds"

    local earnedPoints = GetEarnedAchievementPoints()
    local totalPoints = GetTotalAchievementPoints()
	-- local percent = math.floor(earnedPoints / totalPoints *100)

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
    -- "/esoui/art/progression/progression_indexicon_armor_up.dds"
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
