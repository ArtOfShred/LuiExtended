------------------
-- Changelog

local changelogMessages = {
    "|cFFFF00General:|r",
    "[*] Added updated auras for more dungeons - Elden Hollow II, COA I & II, Tempest Island, Selene's Web, and Spindleclutch I & II and updated a few various icons for enemy abilities.",
    "[*] Fixed a bug where LUIE was causing Guild Trade search history to not display correctly, thanks to scorpius2k1 for discovering the source of the issue.",
    "[*] Updated the Changelog to no longer use LibMsgWin, it now uses much simpler and clean xml code to generate the log, thanks to psypanda.",
    "\n|cFFFF00Buffs & Debuffs:|r",
    "[*] Buff sorting updated - Now buffs will sort Toggle > Ground/Unlimited Duration > others and those will all sort alphabetically relative to their categories.",
    "[*] Lots of various table cleanup and minor optimization.",
    "\n|cFFFF00Chat Announcements:|r",
    "[*] Fixed an error that could occur when crafting items when switching between crafting tabs with items queued in Multicraft or with other addons like Dolgubon's Lazy Writ Crafter. Note the chat log output may not be correct when this happens - but it should no longer cause a UI error.",
    "[*] Fixed an issue where the Quest Items in your inventory would display [Received] messages when you log into a character for the first time. While the UI does send the events for this, LUIE just ignores it on login now.",
    "\n|cFFFF00Combat Text:|r",
    "[*] Updated filtering for combat alerts, there should no longer be duplicate alerts displayed from the same ability.",
    "[*] Added a new option for Alerts to display Unmitigatable Effects - was prompted to do this by a few dungeon abilities that you can't avoid.",
    "\n|cFFFF00Slash Commands:|r",
    "[*] Added new commands for /cake (/anniverary), /pie (/jester), /mead (/newlife), and /witch (/witchfest) to use the Event XP Boost mementos.",
    "[*] Added the /report 'name' command - which open the \"Report a Player\" window and autofills it with useful information.",
}

-- Hide toggle called by the menu or xml button
function LUIE_ToggleChangelog(option)
    LUIEChangelog:ClearAnchors()
    LUIEChangelog:SetAnchor(CENTER, GuiRoot, CENTER, 0, -120 )
    LUIEChangelog:SetHidden(option)
end

-- Called on initialize
function LUIE_ChangelogScreen()
    -- concat messages into one string
    local changelog = table.concat(changelogMessages, "\n")
    -- If text start with '*' replace it with bullet texture
    changelog = string.gsub(changelog, "%[%*%]", "|t12:12:EsoUI/Art/Miscellaneous/bullet.dds|t")
    -- Set the window title
    LUIEChangelogTitle:SetText(zo_strformat("<<1>> Changelog", LUIE.name))
    -- Set the about string
    LUIEChangelogAbout:SetText(zo_strformat("v<<1>> by <<2>>", LUIE.version, LUIE.author))
    -- Set the changelog text
    LUIEChangelogText:SetText(changelog)

    -- Display the changelog if version number < current version
    if (LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion ~= LUIE.version) then
        LUIEChangelog:SetHidden(false)
    end

    -- Set version to current version
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
