--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local strformat = zo_strformat

local changelogMessages = {
    "|cFFFF00General:|r",
    "[*] Updated packaged libraries and removed dependency on LibStub. It is still included for compatibility.",
    "[*] Streamlined and updated some code present in modules, which probably won't be noticeable at all but may cause a slight performance increase.",
    "[*] Russian translation updated thanks to @amanozako.",
    "\n|cFFFF00Buffs & Debuffs:|r",
    "[*] Added an option to toggle whether detailed tooltips display on mouseover and to assign a \"sticky tooltip\" duration to stop them from fading instantly when mousing off.",
    "[*] Updated tooltips, auras, icons, etc for all player abilities & sets changed in Elsweyr. New sets/Necromancer abilities are not done yet.",
    "[*] Updated auras for various shared vanilla dungeon boss abilities as well as updated specific auras in Elden Hollow II, Banished Cells I & II, and Spindleclutch II",
    "[*] Updated auras for DSA Normal and Stage 1 & 2 on Veteran.",
    "[*] Updated auras for Maelstrom Arena Stage 1-5 on Normal & Veteran.",
    "[*] Added an icon for the Daedric Titan ability \"Swallowing Souls\" that is cast when you interrupt Soul Flame.",
    "[*] Can now add Werewolf Timer to prominent buffs.",
    "[*] Can now blacklist Home & Edge Keep Bonus buffs.",
    "[*] Fixed an issue where UI errors would appear when wearing the Dunmer Cultural Garb disguise or when wearing a Guild Tabard when doing the Arenthia questline in Reaper's March.",
    "[*] Roll Dodge Fatigue now displays stacks each time you roll dodge, and specifies it costs 33% more per stack in the tooltip.",
    "[*] Bolt Escape Fatigue tooltip updated to indicate more clearly that the cost is increased by 50% per stack.",
    "\n|cFFFF00Combat Info:|r",
    "[*] Added a new Combat Alerts component, this is a revamp from the Combat Text alerts moved into this component.",
    "[*] New combat alerts now throttle by 50 ms in order to filter out dummy/bad events (out of range, etc) to prevent possible spam.",
    "[*] New combat alerts have the option to display a sound, a countdown label for the cast time of the ability, as well as color the icon border based off the type of CC the ability applies.",
    "\n|cFFFF00Combat Text:|r",
    "[*] Fixed an issue introduced on the PTS due to EVENT_ACTION_SLOT_ABILITY_SLOTTED being removed.",
    "[*] Removed the Combat Alerts menu and settings, this component has been updated and moved to Combat Info.",
    "[*] Due to the above change, the \"Always Hide Ingame Tips\" option has been removed. You can now toggle on/off the display of ingame tips independently from LUIE's combat alerts.",
    "\n|cFFFF00Unit Frames:|r",
    "[*] Added class color option for Necromancer class.",
    "\n|cFFFF00Known Issues:|r",
    "[*] Some food tooltips may not be right (ZoS hasn't updated them). If they are not fixed with the live update of Elsweyr I will adjust them.",
    "[*] Most combat alerts don't have a timer added yet nor do they show the type of crowd control incoming as this must be done manually on my end.",
    "[*] I haven't had the chance to sort through Necromancer abilities yet so Combat Info Bar Highlights may not be working/accurate for all abilities.",
    "[*] The menu options for Combat Info - Active Combat Alerts are still work in progress and not localized for RU translation.",
    "[*] The timer bar for the Werewolf buff indicator if you add it to prominent buffs does not work correctly.",
}

-- Hide toggle called by the menu or xml button
function LUIE.ToggleChangelog(option)
    LUIE_Changelog:ClearAnchors()
    LUIE_Changelog:SetAnchor(CENTER, GuiRoot, CENTER, 0, -120 )
    LUIE_Changelog:SetHidden(option)
end

-- Called on initialize
function LUIE.ChangelogScreen()
    -- concat messages into one string
    local changelog = table.concat(changelogMessages, "\n")
    -- If text start with '*' replace it with bullet texture
    changelog = string.gsub(changelog, "%[%*%]", "|t12:12:EsoUI/Art/Miscellaneous/bullet.dds|t")
    -- Set the window title
    LUIE_Changelog_Title:SetText(strformat("<<1>> Changelog", LUIE.name))
    -- Set the about string
    LUIE_Changelog_About:SetText(strformat("v<<1>> by <<2>>", LUIE.version, LUIE.author))
    -- Set the changelog text
    LUIE_Changelog_Text:SetText(changelog)

    -- Display the changelog if version number < current version
    if (LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion ~= LUIE.version) then
        LUIE_Changelog:SetHidden(false)
    end

    -- Set version to current version
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
