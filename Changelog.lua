--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.2.1|r",
    "",
    "|cFFFF00Known Issues:|r",
    "[*] Currently no chat announcement/alert will display when another player joins your group. This is due to the API Event for group members joining (EVENT_GROUP_MEMBER_JOINED) not triggering properly when players join. I've reported the issue so hopefully it is addressed by the next major game update.",
    "",
    "|cFFFF00General:|r",
    "[*] Added the option to mount as a passenger to the Player to Player interact wheel. I'm not sure if passenger mounts have been added onto the live server yet.",
    "[*] Added a cast bar for mounting as a passenger and Crowd Control tracker will now display the stun effect if you get dismounted while riding as a passenger.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Fixed an issue where the color for the radial border of debuffs was black instead of red due to some testing I was doing and forgot to revert.",
    "[*] The mounted buff has been updated to specify whether you are mounted or riding as a passenger.",
    "[*] Updated the Thief Mundus Stone tooltip to reflect the reduced critical chance from the changes made in game update 6.1.6.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Fixed an issue where a UI error would occur when you hit Champion Level on a character with Alerts for level up enabled. Also fixed this chat announcement & alert to display the champion system icon properly.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Crystal Fragments will now only play its proc sound when the buff is initially gained and not when it is refreshed. This is due to an issue with its implementation - it can actually proc off of itself when you fire the instant cast frag but the buff is consumed during the GCD as it goes off.",
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
    LUIE_Changelog_Title:SetText(zo_strformat("<<1>> Changelog", LUIE.name))
    -- Set the about string
    LUIE_Changelog_About:SetText(zo_strformat("v<<1>> by <<2>>", LUIE.version, LUIE.author))
    -- Set the changelog text
    LUIE_Changelog_Text:SetText(changelog)

    -- Display the changelog if version number < current version
    if (LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion ~= LUIE.version) then
        LUIE_Changelog:SetHidden(false)
    end

    -- Set version to current version
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
