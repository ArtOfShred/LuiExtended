--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- PetNames namespace
if LUIE.Data.PetNames == nil then
    LUIE.Data.PetNames = {}
end

local PetNames = LUIE.Data.PetNames

-- Pet Names (Sorcerer)
PetNames.Sorcerer = {
    [GetString(LUIE_PET_NAME_UNSTABLE_FAMILIAR)] = true,
    [GetString(LUIE_PET_NAME_CLANNFEAR)] = true,
    [GetString(LUIE_PET_NAME_VOLATILE_FAMILIAR)] = true,
    [GetString(LUIE_PET_NAME_WINGED_TWILIGHT)] = true,
    [GetString(LUIE_PET_NAME_TWILIGHT_TORMENTOR)] = true,
    [GetString(LUIE_PET_NAME_TWILIGT_MATRIARCH)] = true,
    [GetString(LUIE_PET_NAME_SUMMON_STORM_ATRONACH)] = true,
    [GetString(LUIE_PET_NAME_GREATER_STORM_ATRONACH)] = true,
    [GetString(LUIE_PET_NAME_CHARGED_ATRONACH)] = true,
}

-- Pet Names (Warden)
PetNames.Warden = {
    [GetString(LUIE_PET_NAME_FERAL_GUARDIAN)] = true,
    [GetString(LUIE_PET_NAME_ETERNAL_GUARDIAN)] = true,
    [GetString(LUIE_PET_NAME_WILD_GUARDIAN)] = true,
}

-- Pet Names (Necromancer)
PetNames.Necromancer = {
    [GetString(LUIE_PET_NAME_SKELETAL_MAGE)] = true,
    [GetString(LUIE_PET_NAME_SKELETAL_ARCHER)] = true,
    [GetString(LUIE_PET_NAME_SKELETAL_ARCANIST)] = true,
    [GetString(LUIE_PET_NAME_SPIRIT_MENDER)] = true,
    [GetString(LUIE_PET_NAME_SPIRIT_GUARDIAN)] = true,
    [GetString(LUIE_PET_NAME_INTENSIVE)] = true,
}

-- Pet Names (Sets)
PetNames.Sets = {
    [GetString(LUIE_PET_NAME_ENGINE_GUARDIAN)] = true,
    [GetString(LUIE_PET_NAME_MAW_OF_THE_INFERNAL)] = true,
    [GetString(LUIE_PET_NAME_SHADOWREND)] = true,
    [GetString(LUIE_PET_NAME_SENTINEL_OF_RKUGAMZ)] = true,
    [GetString(LUIE_PET_NAME_MORKULDIN_SWORD)] = true,
}

-- Pet Names (Assistants)
PetNames.Assistants = {
    [GetString(LUIE_PET_NAME_ASSISTANT_EZABI)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_FEZEZ)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_PIRHARRI)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_NUZHIMEH)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_TYTHIS)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_BARON)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_PEDDLER)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_FACTOTUMB)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_FACTOTUMM)] = true,
    [GetString(LUIE_PET_NAME_ASSISTANT_GHRASHAROG)] = true,
}
