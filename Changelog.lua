--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.6.6|r",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Fixed an issue where Chat Announcements for fencing items were displaying incorrectly.",
    "",
    "|cFFA500LuiExtended Version 6.6.5|r",
    "",
    "|cFFFF00General:|r",
    "[*] Updated the hooks for Campaign Bonuses in Cryodiil - fixes a default UI issue with the display of the Emperorship Alliance Bonus passive.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Reimplemented custom tooltips for Buffs & Debuffs. This now has a menu option to toggle on/off (disabled by default since custom tooltips require manual update and are not all up to date).",
    "",
    "|cFFFF00Chat Announcements:|r",
    '[*] Updated "Display Announcements" to use a much better setup (and added support for Endless Archive Progression). These are misc announcements that cover a lot of different things. Menu option configurations are updated for Display Announcements.',
    '[*] Added support for the new "Archival Fortunes" currency earned in Endless Archive.',
    '[*] Filleting fish at the crafting station now shows context-specific messages as intended.',
    '[*] Fixed an issue when mailing gold to another player - if you sent over half of the gold in your inventory the chat announcement would display the value of gold remaining in your bag as the sent amount. This is due to an API issue and required a workaround to fix.',
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Added a new submenu with an option to display Floating Markers for enemies you are in combat with (thanks to DakJaniels).",
    "[*] Bar Highlight tracking for Destruction Staff abilities now works properly on the back bar.",
    "[*] Added a new menu option to track Heavy Attack casts (disabled by default).",
    "[*] Fixed an issue where AOE Damage tracking on Crowd Control Tracker wasn't working.",
    "",
    "|cFFFF00Info Panel:|r",
    "[*] Added an option to change the Clock Formatting (similar to chat timestamp formatting you can customize how the clock displays). Default settings match the current behavior of the Info Panel clock.",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] Added effects to the Unit Frames when a unit becomes Invulnerable (boss invulnerability phases, etc...).",
    "",
}

-- Hide toggle called by the menu or xml button
function LUIE.ToggleChangelog(option)
    LUIE_Changelog:ClearAnchors()
    LUIE_Changelog:SetAnchor(CENTER, GuiRoot, CENTER, 0, -120)
    LUIE_Changelog:SetHidden(option)
end

-- Called on initialize
function LUIE.ChangelogScreen()
    -- concat messages into one string
    local changelog = table.concat(changelogMessages, "\n")
    -- If text start with '*' replace it with bullet texture
    changelog = zo_strgsub(changelog, "%[%*%]", "|t12:12:EsoUI/Art/Miscellaneous/bullet.dds|t")
    -- Set the window title
    LUIE_Changelog_Title:SetText(zo_strformat("<<1>> Changelog", LUIE.name))
    -- Set the about string
    LUIE_Changelog_About:SetText(zo_strformat("v<<1>> by <<2>>", LUIE.version, LUIE.author))
    -- Set the changelog text
    LUIE_Changelog_Text:SetText(changelog)

    -- Display the changelog if version number < current version
    if LUIESV.Default[GetDisplayName()]["$AccountWide"].WelcomeVersion ~= LUIE.version then
        LUIE_Changelog:SetHidden(false)
    end

    -- Set version to current version
    LUIESV.Default[GetDisplayName()]["$AccountWide"].WelcomeVersion = LUIE.version
end
