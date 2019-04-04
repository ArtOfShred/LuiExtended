--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local PNL = LUIE.InfoPanel

local strformat = zo_strformat

function PNL.FramesPerSecond()
    local framerate = GetFramerate()
    local lowFPS = 15
    local medFPS = 25

    return strformat("FPS: <<1>>", math.floor(framerate))
end

function PNL.Latency()
    local latency = GetLatency()
    local highLat = 300
    local medLat = 150

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

function PNL.GetPlayerLevel()
    if IsUnitChampion('player') then
        playerLevel = GetPlayerChampionPointsEarned()
    else
        playerLevel = GetUnitLevel("player")
    end

    return strformat("Level: <<1>>", playerLevel)
end

function PNL.CurrentZone()
    local zone = GetPlayerLocationName()

    return strformat("Zone: <<1>>", zone)
end

function PNL.MountTraining()
    local mountFeedTime = GetTimeUntilCanBeTrained()

    return strformat("Mount: <<1>>", mountFeedTime)
end

function PNL.SoulgemsAmount()
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

function PNL.BagSpace()
    local bagId = BAG_BACKPACK

    local bagSize = tonumber(GetBagSize(bagId))
    local bagFree = tonumber(GetNumBagFreeSlots(bagId))
    local bagUsed = tonumber(GetNumBagUsedSlots(bagId))

    return strformat("Bag Space: <<1>>/<<2>>", bagUsed, bagSize)
end

function PNL.BankSpace()
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

    return strformat("Bank Space: <<1>>/<<2>>", bankUsed, bankSize)
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
