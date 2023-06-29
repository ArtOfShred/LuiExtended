--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.Data.CollectibleTables = {}
local CollectibleTables = LUIE.Data.CollectibleTables

-- Banker
CollectibleTables.Banker = {
    [267] = "Tythis",
    [6376] = "Ezabi",
    [8994] = "Crow",
    [9743] = "Factotum",
}

-- Merchants
CollectibleTables.Merchants = {
    [301] = "Nuzimeh",
    [6378] = "Fezez",
    [8995] = "Crow",
    [9744] = "Factotum",
    [10617] = "Aderene",
}

-- Deconstruction
CollectibleTables.Decon = {
    [10184] = "Giladil",
}

-- Armory Assistants
CollectibleTables.Armory = {
    [9745] = "Ghrasharog",
    [10618] = "Zhuqoth",
}

-- Fence
CollectibleTables.Fence = {
    [300] = "Pirharri"
}

-- Companions
-- LUI will generate SlashCommands from the lowercase names e.g. Bastian becomes /bastian.
CollectibleTables.Companions = {
    [9245] = "Bastian",
    [9353] = "Mirri",
    [9911] = "Ember",
    [9912] = "Isobel",
    [11113] = "Sharp",
    [11114] = "Azandar",
}

CollectibleTables.All = {}

for k, v in pairs(CollectibleTables.Merchants) do CollectibleTables.All[k] = v end
for k, v in pairs(CollectibleTables.Banker) do CollectibleTables.All[k] = v end
for k, v in pairs(CollectibleTables.Decon) do CollectibleTables.All[k] = v end
for k, v in pairs(CollectibleTables.Armory) do CollectibleTables.All[k] = v end
for k, v in pairs(CollectibleTables.Fence) do CollectibleTables.All[k] = v end
for k, v in pairs(CollectibleTables.Companions) do CollectibleTables.All[k] = v end
