---@diagnostic disable: duplicate-index
--[[
    LuiExtended
    License: The MIT License (MIT)
]]

---@class (partial) LuiExtended
local LUIE = LUIE;

-- For debug function - convert result reason codes to string value
---@class DebugResults
local DebugResults =
{
    [-1] = 'INVALID';
    [1] = 'DMG';
    [2] = 'DMG!';
    [4] = 'PRECISE DAMAGE';
    [8] = 'WRECKING DAMAGE';
    [16] = 'HEAL';
    [32] = 'HEAL!';
    [64] = 'POWER (-)';
    [128] = 'POWER (+)';
    [2000] = 'IMMUNE';
    [2010] = 'SILENCE';
    [2020] = 'STUN';
    [2025] = 'SNARE';
    [2030] = 'BUSY';
    [2040] = 'BAD TARGET';
    [2050] = 'TARGET DEAD';
    [2060] = 'CASTER DEAD';
    [2070] = 'TARGET NOT IN VIEW';
    [2080] = 'ON CD';
    [2090] = 'OUT OF RESOURCE';
    [2100] = 'TARGET OUT OF RANGE';
    [2110] = 'FAILED';
    [2111] = 'REFLECT';
    [2120] = 'ABSORB';
    [2130] = 'PARRY';
    [2140] = 'DODGE';
    [2150] = 'BLOCK';
    [2151] = 'BLOCK DMG';
    [2160] = 'RESIST';
    [2170] = 'PART RESIST';
    [2180] = 'MISS';
    [2190] = 'DEFEND';
    [2200] = 'BEGIN';
    [2210] = 'CHANNEL';
    [2230] = 'INTERRUPT';
    [2240] = 'GAIN';
    [2245] = 'GAIN DUR';
    [2250] = 'FADE';
    [2260] = 'DIED';
    [2262] = 'DIED XP';
    [2265] = 'KB';
    [2290] = "CAN'T USE";
    [2300] = 'IN COMBAT';
    [2310] = 'FAILED REQ';
    [2320] = 'FEAR';
    [2330] = 'OUT OF LOS';
    [2340] = 'DISORIENT';
    [2350] = 'QUEUED';
    [2360] = 'BLADETURN';
    [2370] = 'TARGET TOO CLOSE';
    [2380] = 'WRONG WEAPON';
    [2390] = 'PACIFY';
    [2391] = 'TARGET NOT PVP FLAGGED';
    [2392] = 'LINKED CAST';
    [2400] = 'LEVITATE';
    [2410] = 'INTERCEPT';
    [2420] = 'FALL DMG';
    [2430] = 'DISARMED';
    [2440] = 'OFF BALANCE';
    [2450] = 'WEAPON SWAP';
    [2460] = 'SHIELD';
    [2470] = 'STAGGER';
    [2475] = 'KNOCKBACK';
    [2480] = 'ROOT';
    [2490] = 'RESURRECT';
    [2500] = 'FALLING';
    [2510] = 'IN AIR';
    [2520] = 'RECALL';
    [2600] = 'SIEGE TOO CLOSE';
    [2605] = 'SIEGE NOT ALLOWED IN ZONE';
    [2610] = 'IN ENEMY KEEP';
    [2611] = 'IN ENEMY TOWN';
    [2612] = 'IN ENEMY RESOURCE';
    [2613] = 'IN ENEMY OUTPOST';
    [2620] = 'SIEGE LIMIT';
    [2630] = 'MUST BE IN OWN KEEP';
    [2640] = 'TOO CLOSE';
    [2700] = 'NO LOCATION FOUND';
    [2800] = 'INVALID TERRAIN';
    [2810] = 'INVALID FIXTURE';
    [2900] = 'UNEVEN TERRAIN';
    [2910] = 'NO RAM ATTACKABLE TARGET WITHIN RANGE';
    [3000] = 'SPRINT';
    [3010] = 'SWIMMING';
    [3020] = 'REINCARNATING';
    [3030] = 'GRAVEYARD TOO CLOSE';
    [3040] = 'MISSING EMPTY SOUL GEM';
    [3050] = 'NOT ENOUGH INVENTORY SPACE SOUL GEM';
    [3060] = 'MISSING FILLED SOUL GEM';
    [3070] = 'MOUNTED';
    [3080] = 'GRAVEYARD DISALLOWED IN INSTANCE';
    [3090] = 'NOT ENOUGH SPACE FOR SIEGE';
    [3100] = 'FAILED SIEGE CREATION REQUIREMENTS';
    [3110] = 'ALL TARGETS OCCUPIED';
    [3120] = 'ALL TARGETS DESTROYED';
    [3130] = 'KILLED BY SUBZONE';
    [3140] = 'MERCENARY LIMIT';
    [3150] = 'MOBILE GRAVEYARD LIMIT';
    [3160] = 'STANDARD LIMIT';
    [3170] = 'STANDARD MISMATCH';
    [3180] = 'STANDARD ALREADY EXISTS';
    [3190] = 'STANDARD TOO CLOSE';
    [3200] = 'STANDARD NO PERMISSION';
    [3210] = 'STANDARDS DISABLED';
    [3220] = 'CAMP TABARD MISMATCH';
    [3230] = 'CAMP EXISTS';
    [3240] = 'CAMP NO PERMISSION';
    [3400] = 'NO WEAP SWAP';
    [3410] = "CAN'T SWAP WHILE CHANGING GEAR";
    [3420] = 'INVALID JUSTICE TARGET';
    [3430] = 'NOT ENOUGH INVENTORY SPACE';
    [3440] = 'IN HIDEYHOLE';
    [3450] = 'CANT SWAP HOTBAR IS OVERRIDDEN';
    [3460] = 'SOUL GEM RESURRECTION ACCEPTED';
    [3461] = 'KILLED BY DAEDRIC WEAPON';
    [3470] = 'HEAL ABORBED';
    [3480] = 'DIED COMPANION XP';
    [3490] = 'SELF PLAYING TRIBUTE';
    [3500] = 'TARGET PLAYING TRIBUTE';
    [3510] = 'CHARMED';
    [1073741825] = 'DOT';
    [1073741826] = 'DOT!';
    [1073741840] = 'HOT';
    [1073741856] = 'HOT!';
};

---@type DebugResults
LUIE.Data.DebugResults = DebugResults;
