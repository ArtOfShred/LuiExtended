--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

LUIE.Data.CombatTextBlacklistPresets = {}
local BlacklistPresets = LUIE.Data.CombatTextBlacklistPresets

-- Crouch Drain
BlacklistPresets.CrouchDrain = {
    [20301] = true, -- Crouch Drain
}

-- Sets
BlacklistPresets.Sets = {
    [135919] = true, -- Spell Parasite (Spell Parasite's)
}

-- Sorcerer
BlacklistPresets.Sorcerer = {
    [114903] = true, -- Dark Exchange
    [114908] = true, -- Dark Deal
    [114909] = true, -- Dark Conversion
}

-- Templar
BlacklistPresets.Templar = {
    [37009] = true, -- Channeled Focus (Channeled Focus)
    [114842] = true, -- Restoring Focus (Restoring Focus)
}

-- Warden
BlacklistPresets.Warden = {
    [114854] = true, -- Betty Netch (Blue Betty)
    [114853] = true, -- Bull Netch (Bull Netch)
}

-- Necromancer
BlacklistPresets.Necromancer = {
    [118014] = true, -- Mystic Siphon (Mystic Siphon)
    [123233] = true, -- Mortal Coil (Mortal Coil)
}
