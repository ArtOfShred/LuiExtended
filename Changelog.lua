--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local strformat = zo_strformat

local changelogMessages = {
    "|cFFFF00General:|r",
    "[*] Fixed a missing local in Hooks.lua & adjusted the load order in order to fix an issue wcausing Friend Invites to throw a UI error.",
    "[*] Death Recap will now show a source for some environmental effects that used to display with no source (a good example is some variants of traps in areas would source the damage they deal from the player instead of the trap).",
    "\n|cFFFF00Buffs & Debuffs:|r",
    "[*] Updated icons, auras, and tooltips for the remaining item sets added with Elsweyr.",
    "[*] Updated MOST icons, auras, tooltips, and bar highlight for Volendrung artifact weapon abilities. Still missing any effects not present or usable in the tutorial quest.",
    "[*] Updated icons, auras, tooltips, and bar highlight for the Grave Lord Necromancer skill line.",
    "[*] The Crusher & Weakening Glyph debuffs will now show for all players on targets regardless of who applied it.",
    "[*] Removed some code used to create a fake \"Home Keep\" buff for players in Cyrodiil due to the changed in Elsweyr showing a proper buff again.",
    "[*] Added icons/tooltips/alerts for Boss Wamasu in Craglorn.",
    "\n|cFFFF00Chat Announcements:|r",
    "[*] Updated the Achievement Tracking options with the missing category added with Elsweyr.",
    "\n|cFFFF00Combat Info:|r",
    "[*] The option to display the global cooldown on abilities when used now only hooks the default UI when enabled. If you disable this component and prefer to use another addon for handling the GCD, it is now possible.",
    "[*] Fixed a few missing strings for the default variables for Combat Alerts. These default variables have been adjusted to automatically replace the settings that were incorrect.",
    "[*] Combat Alerts now fade out over 1 sec when the effect ends for a cleaner appearance.",
    "[*] Combat Alert cast/channel time tracking has been updated to be more accurate.",
    "[*] Updated the Cast Time & CC type of many alerts. This is still a work in progress, unfortunately the majority of channeled abilities in game don't provide the correct duration in the API settings so I have to check them manually which is rather time consuming.",
    "[*] Added basic support for interrupt detection for Combat Alerts. This doesn't work in all situations, anything not directly targeting the player or creating a buff effect doesn't provide enough information to determine if an ability was interrupted.",
    "\n|cFFFF00Combat Text:|r",
    "[*] Added two toggles to show Overkill/Overhealing in the Common Options menu of Combat Text. These are enabled by default, resulting in damage/healing being displayed the same way it was before the API changes made with Elsweyr.",
    "\n|cFFFF00Unit Frames:|r",
    "[*] Added an option to swap the position of the Stamina & Magicka Bar when using the Pyramid or Separate Frames option. Contributed by Eearslya Sleiarion, thanks!",
    "",
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
