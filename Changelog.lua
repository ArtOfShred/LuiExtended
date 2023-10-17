--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.6.1|r",
    "",
    "|cFFFF00General:|r",
    "[*] Fixed issues causing UI errors with Gamepad Mode Skills Window.",
    "",
    "|cFFA500LuiExtended Version 6.6.0|r",
    "",
    "|cFFFF00General:|r",
    "[*] Tons of code optimization and cleanup thanks to DakJaniels.",
    "[*] Crystallized Shield & its morphs are now correctly tracked on Combat Info - Bar Highlight and Buffs & Debuffs (Note: the stack count only displays for the player as the ability doesn't return any information to the API about the stack count).",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Fixed issues caused by LUIE with \"Dolgubon's Lazy Writ Crafter.\" The auto-abandon quest option in Writ Crafter now works properly and Quest Center Screen Announcements will now follow the \"Hide Writ Quest Announcements\" setting in Writ Crafter.",
    "[*] Added a toggleable option to hide the display of loot when the addon \"Loot Log\" is active.",
    "[*] Fixed an issue where Collectible Chat Announcements weren't displaying correctly.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Added the option to track Immobilize & Snare effects to the Crowd Control Tracker (thanks to ACastanza). These options are disabled by default. Immobilization tracking requires the base game menu setting under Combat for Active Combat Tips to be enabled. Immobilization effects will display as snares if the setting for Immobilized Warnings is disabled.",
    "[*] Fixed an issue where the cast bar for Recall would be interrupted when teleporting to a Wayshrine in a different zone.",
    "[*] Fixed Bar Highlight tracking for some abilities.",
    "[*] Fixed Proc Sounds not working (Note: Grim Focus is going to require some work due to the changes to the ability).",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] Added the option to play Tales of Tribute with a group member to the Right Click Menu for Group Frames.",
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
