--[[
Author: Ayantir
Filename: LibCustomTitles.lua
Version: 20
]]--

--[[

This software is under : CreativeCommons CC BY-NC-SA 4.0
Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

You are free to:

    Share — copy and redistribute the material in any medium or format
    Adapt — remix, transform, and build upon the material
    The licensor cannot revoke these freedoms as long as you follow the license terms.


Under the following terms:

    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
    NonCommercial — You may not use the material for commercial purposes.
    ShareAlike — If you remix, transform, or build upon the material, you must distribute your contributions under the same license as the original.
    No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.


Please read full licence at : 
http://creativecommons.org/licenses/by-nc-sa/4.0/legalcode

]]--

local libLoaded
local LIB_NAME, VERSION = "LibCustomTitles", 20
local LibCustomTitles, oldminor = LibStub:NewLibrary(LIB_NAME, VERSION)
if not LibCustomTitles then return end

function LibCustomTitles:Init()
	
	local CT_NO_TITLE = 0
	local CT_TITLE_ACCOUNT = 1
	local CT_TITLE_CHARACTER = 2
	
	-- Default override
	local overriden = {
		en = "Volunteer",
		fr = "Volontaire",
		de = "Freiwillige",
	}

	local customTitles = {
	
		["@Ayantir"] = { -- Dev / EU. v1
			ov = true,
			en = "The Enlightened",
			fr = "Mangeuse de Gâteaux",
			de = "Die Erleuchtete",
		},
		
		["@Baertram"] = { -- Dev / EU. v4
			ov = true,
			en = "Ursa Major",
			fr = "Ursa Major",
			de = "Ursa Major",
		},
		
		["@sirinsidiator"] = { -- Dev / EU. v5
			["Illonia Ithildû"] = {
				ov = true,
				en = "Planeswalker",
				fr = "Arpenteuse de Mondes",
				de = "Weltenwanderer",
			},
			ov = true,
			en = "Absolutely Not Suspicious",
			fr = "Carrément pas suspect",
			de = "Absolut Nicht Verdächtig",
		},
		
		["@Randactyl"] = { -- Dev / NA. v6
			["Vedrasi Rilim"] = {
				ov = true,
				en = "Glorious Leader",
			},
			ov = true,
			en = "No Lollygaggin'",
		},
		
		["@Wedgez"] = { -- NA. v8
			ov = true,
			en = "Golden Light Master",
		},
		
		["@Ign0tus"] = { -- NA. v8
			["Smudgê"] = {
				ov = true,
				en = "Infiltrator",
			},
			["Nefandus Pravus"] = {
				ov = true,
				en = "Nightlord",
			},
			["Zero Divisor"] = {
				ov = true,
				en = "Executioner",
			},
			ov = true,
			en = "Sweetroll Thief",
		},
		
		["@dOpiate"] = { -- Dev / EU. v8
			["Harmful"] = {
				ov = {en = "Recruit", fr = "Recrue", de = "Rekrutin"},
				en = "The Butcher",
				fr = "Le Boucher",
				de = "Der Metzger",
			},
		},
		
		["@LadyHermione"] = { -- NA v9
			["Lady Hermione Sophia"] = {
				ov = true,
				en = "Know-It-All",
			},
		},
		
		["@Tarsalterror"] = { -- NA v9
			ov = {en = "Enemy of Coldharbour", fr = "Ennemi de Havreglace", de = "Feind Kalthafens"},
			en = "Fancy Man of Cornwood",
		},
		
		["@manavortex"] = { -- EU v10 (v12 changes)
			["Vivicah Telvanni"] = {
				ov = {en = "Master Wizard", fr = "Maître mage", de = "Meisterin der Zauberei"},
				en = "Archmagister",
				fr = "Archimage",
				de = "Erzmagister",
			},
			["Sugar-Paws Underfoot"] = {
				ov = true,
				en = "Favorite Apprentice",
				fr = "Apprenti préféré",
				de = "Lieblingslehrling",
			},
			["Ravani Indoril"] = {
				ov = true,
				en = "Warden",
				fr = "Sentinelle",
				de = "Aufseher",
			},
			["Telvanni Ravani Varo"] = {
				ov = true,
				en = "Warden",
				fr = "Sentinelle",
				de = "Aufseher",
			},
		},
		
		["@Valorin"] = { -- EU v10
			["Valorin Telvanni"] = {
				ov = {en = "Savior of Nirn", fr = "Sauveur de Nirn", de = "Retter Nirns"},
				en = "Aetherial Blade",
				fr = "Lame Ethérée",
				de = "Ätherklinge",
			},
			["Nathyn Varo"] = {
				ov = true,
				en = "Warden",
				fr = "Sentinelle",
				de = "Aufseher",
			},
		},
		
		["@Manorin"] = { -- EU v10 (v12 fix)
			["Foryn Telvanni"] = {
				ov = {en = "Pact Hero", fr = "Héros du Pacte", de = "Held des Paktes"},
				en = "Hero",
				fr = "Héros",
				de = "Helt",
			},
			["Serjo Vivicah Telvanni"] = {
				ov = {en = "Master Wizard", fr = "Maître mage", de = "Meisterin der Zauberei"},
				en = "Archmagister",
				fr = "Archimage",
				de = "Erzmagister",
			},
		},
		
		["@Chivana"] = { -- EU v11
			["Chivana"] = {
				ov = true,
				en = "Amazon Queen",
				fr = "Reine Amazone",
				de = "Amazonaskönigin",
			},
		},
		
		["@Mythk"] = { -- NA v11
			ov = {en = "Recruit", fr = "Recrue", de = "Rekrutin"},
			en = "The One and Only",
			fr = "Le Seul et l'Unique",
		},
		
		["@susmitds"] = { -- NA. v11
			["Shadow Kitter"] = {
				ov = true,
				en = "Emperor Slayer",
			},
			["Venom Kitter"] = {
				ov = true,
				en = "Poison Angel",
			},
			["Wind Kitter"] = {
				ov = true,
				en = "Cyclone Walker",
			},
			["Lumina Kitter"] = {
				ov = true,
				en = "Darklight Seeker",
			},
			["Thunder Xyler"] = {
				ov = true,
				en = "Unbound Infinium",
			},
			["Light Xyler"] = {
				ov = true,
				en = "Everglow Hunter",
			},
			["Fire Xyler"] = {
				ov = true,
				en = "Eternal Inferno",
			},
			["Void Xyler"] = {
				ov = true,
				en = "Existential Anomaly",
			},
		},
		
		["@JasminTheSecond"] = { -- EU v11
			["Durac"] = {
				ov = true,
				en = "The Lost",
				fr = "L'égaré",
				de = "Der Verschollene",
			},
		},
		
		["@Haunted1994"] = { -- v12
			["Jah'rakal"] = {
				ov = {en = "Veteran", fr = "Vétéran", de = "Veteran"},
				en = "Troll Warlord",
				fr = "Troll Warlord",
				de = "Troll Warlord",
			},
		},
		
		["@Vortexman11"] = { -- v12
			["Ålaunus"] = {
				ov = true,
				en = "The Silent",
				fr = "Le Discret",
				de = "Die Stille",
			},
		},

		["@Domardal"] = { -- v12
			ov = true,
			en = "Coco",
			fr = "Coco",
			de = "Coco",
		},

		["@RaddyBK"] = { -- v12
			["Radolfus"] = {
				ov = {en = "Major", fr = "Major", de = "Major"},
				en = "The Elder Dragon",
				fr = "Le Vieux Dragon",
				de = "The Elder Dragon",
			},
			["RADOLFUS II"] = {
				ov = {en = "Executioner", fr = "Exécuteur", de = "Henker"},
				en = "The Elder Dragon",
				fr = "Le Vieux Dragon",
				de = "The Elder Dragon",
			},
		},
		
		["@Dolgubon"] = { -- v12
			["Relthion"] = {
				ov = true,
				en = "Undying",
				fr = "L'immortel",
				de = "Undying",
			},
		},
		
		["@Sethize"] = { -- EU v12
			["Nelvan Telvanni"] = {
				ov = {en = "Master Wizard", fr = "Maître mage", de = "Meister der Zauberei"},
				en = "Master",
				fr = "Maître",
				de = "Meister",
			},
		},
		
		["@ScattyThePirate"] = { -- EU v13
			["Teldryn Dreth"] = {
				ov = true,
				en = "Warden",
				fr = "Sentinelle",
				de = "Aufseher",
			},
			["Ralyn Telvanni"] = {
				ov = true,
				en = "Spellwright",
				fr = "Tisseur de Sorts",
				--de = "Meister",
			},
			["Shabar-Jo"] = {
				ov = true,
				en = "Tisseur de Sorts",
				fr = "Spellwright",
				--de = "Meister",
			},
			["Shurkul gro-Kharzog"] = {
				ov = {en = "Fighters Guild Victor", fr = "Champion de la guilde des guerriers", de = "Sieger der Kriegergilde"},
				en = "The Monster",
				fr = "La Bête",
				de = "Das Monster",
			},
			["Azuk gro-Shakh"] = {
				ov = {en = "Fighters Guild Victor", fr = "Champion de la guilde des guerriers", de = "Sieger der Kriegergilde"},
				en = "Windsinger",
				fr = "Ténor des tempêtes",
				--de = "Das Monster",
			},
			["Xal-Shei"] = {
				ov = {en = "Fighters Guild Victor", fr = "Champion de la guilde des guerriers", de = "Sieger der Kriegergilde"},
				en = "Swamp Knight",
				fr = "Chevalier des Marais",
				--de = "Das Monster",
			},
		},
		
		["@ScattyTheWizard"] = { -- v13
			["Marukh-do"] = {
				ov = true,
				en = "Privateer",
				fr = "Corsaire",
				--de = "Meister",
			},
		},

		["@Karstyll"] = { -- v13
			ov = true,
			en = "Forsaken",
			fr = "L'oublié",
			de = "Die Verlassene",
		},

		["@Methuselah86"] = { -- v13
			ov = true,
			en = "Wabbajack Warrior",
			fr = "Guerrier de Wabbajack",
			--de = "Die Verlassene",
		},

		["@DaedricAdept"] = { -- v14
			ov = {en = "Pact Hero", fr = "Héros du Pacte", de = "Held des Paktes"},
			en = "Hand of Almalexia",
			fr = "Main d'Almalexia",
			--de = "Die Verlassene",
		},

		["@Cloudless"] = { -- v14
			ov = true,
			en = "Order of Doctrine",
			fr = "Ordre de la Doctrine",
			--de = "Die Verlassene",
		},

		["@Atomkern"] = { -- v13
			ov = true,
			en = "The Refrigerator",
			fr = "Le glacé",
			--de = "Die Verlassene",
		},

		["@Orizonta"] = { -- v13
			ov = true,
			en = "Manslayer",
			fr = "Assassin",
			--de = "Die Verlassene",
		},

		["@laksikus"] = { -- v13
			ov = {en = "Veteran", fr = "Vétéran", de = "Veteran"},
			en = "Sexy Zogger",
			fr = "Zog-Zog",
			--de = "Die Verlassene",
		},

		["@flyty"] = { -- v13
			ov = true,
			en = "Always Drunk",
			fr = "Toujours bourré",
			--de = "Die Verlassene",
		},
		
		["@Deltia"] = { -- v13
			ov = {en = "Tyro", fr = "Première classe", de = "Tyro"},
			en = "The Destroyer",
			fr = "Le Destructeur",
			--de = "Die Verlassene",
		},

		["@tannips"] = { -- v13
			ov = true,
			en = "Potentate",
			fr = "Potentat",
			--de = "Die Verlassene",
		},

		["@sioniann"] = { -- v13
			["Uloth The Furious Blade"] = {
				ov = true,
				en = "Sinister Turkey",
				fr = "Dindon Sinistre",
				--de = "Meister",
			},
			["Enid an Gleana"] = {
				ov = true,
				en = "Fountain of Auridon",
				fr = "Fontaine d'Auridia",
				--de = "Meister",
			},
		},
		
		["@HMS-Dragonfly"] = { -- v16
			ov = true,
			en = "Knight of Stendarr",
			fr = "Chevalier de Stendarr",
			--de = "Die Verlassene",
		},

		["@Faso"] = { -- v16
			["Fasò"] = {
				ov = true,
				en = "Knights Radiant",
			},
		},

		["@nifty2g"] = { -- v16
			["Nifty Jong-Un"] = {
				ov = true,
				en = "Dawn of Anu",
			},
		},

		["@Twirlz"] = { -- v17
			["Yirel Virith"] = {
				ov = true,
				en = "Nightcaller",
			},
		},

		["@Anceane"] = { -- v19
			ov = true,
			en = "Dark Emerald",
			fr = "Emeraude Sombre",
		},

		["@Potato-Salad"] = { -- v19
			ov = true,
			en = "Seraphim of Azura",
			fr = "Séraphin d'Azura",
		},

		["@blakeblox"] = { -- v19
			["fyboba"] = {
				ov = {en = "Tyro", fr = "Première classe", de = "Tyro"},
				en = "Golden Lady",
			},
		},
		
	}
	
	local lang = GetCVar("Language.2")
	
	local function GetCustomTitleType(displayName, unitName)
		if customTitles[displayName] then
			if customTitles[displayName][unitName] then
				return CT_TITLE_CHARACTER
			end
			return CT_TITLE_ACCOUNT
		end
		return CT_NO_TITLE
	end
	
	local function GetModifiedTitle(originalTitle, displayName, unitName, registerType)
		
		local title = originalTitle
		if registerType == CT_TITLE_CHARACTER then
			if customTitles[displayName][unitName].ov then
				if type(customTitles[displayName][unitName].ov) == "boolean" then
					if originalTitle == overriden[lang] then
						title = customTitles[displayName][unitName][lang] or originalTitle
					end
				elseif originalTitle == customTitles[displayName][unitName].ov[lang] then
					title = customTitles[displayName][unitName][lang] or originalTitle
				end
			end
		elseif registerType == CT_TITLE_ACCOUNT then
			if customTitles[displayName].ov then
				if type(customTitles[displayName].ov) == "boolean" then
					if originalTitle == overriden[lang] then
						title = customTitles[displayName][lang] or originalTitle
					end
				elseif originalTitle == customTitles[displayName].ov[lang] then
					title = customTitles[displayName][lang] or originalTitle
				end
			end
		end
		
		return title
		
	end

	local GetUnitTitle_original = GetUnitTitle
	GetUnitTitle = function(unitTag)
		local unitTitleOriginal = GetUnitTitle_original(unitTag)
		local unitDisplayName = GetUnitDisplayName(unitTag)
		local unitCharacterName = GetUnitName(unitTag)
		local registerType = GetCustomTitleType(unitDisplayName, unitCharacterName)
		if registerType ~= CT_NO_TITLE then
			return GetModifiedTitle(unitTitleOriginal, unitDisplayName, unitCharacterName, registerType)
		end
		return unitTitleOriginal
	end
	
	local GetTitle_original = GetTitle
	GetTitle = function(index)
		local titleOriginal = GetTitle_original(index)
		local displayName = GetDisplayName()
		local characterName = GetUnitName("player")
		local registerType = GetCustomTitleType(displayName, characterName)
		if registerType ~= CT_NO_TITLE then
			return GetModifiedTitle(titleOriginal, displayName, characterName, registerType)
		end
		return titleOriginal
	end

end

local function OnAddonLoaded()
	if not libLoaded then
		libLoaded = true
		local LCC = LibStub('LibCustomTitles')
		LCC:Init()
		EVENT_MANAGER:UnregisterForEvent(LIB_NAME, EVENT_ADD_ON_LOADED)
	end
end

EVENT_MANAGER:RegisterForEvent(LIB_NAME, EVENT_ADD_ON_LOADED, OnAddonLoaded)