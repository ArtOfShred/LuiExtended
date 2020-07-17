--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.1.2|r",
    "",
    "|cFFFF00General:|r",
    "[*] Thanks to FAR747 for doing additional translation for the RU localization!",
    "[*] Updated a few icons, including a new appropriately explosive looking icon for Vicious Death.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Updated the tooltips for Battle Spirit, the LFG Buff, and Thrassian Stranglers to use more consistent syntax.",
    "[*] The under level 50 player Looking For Group health & power buff is now named \"Looking for Group\" instead of \"Looking For Group\" (en localization only). I have the power to fix improper title capitalization and I will use it.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Note: I made a discovery recently that when the pChat addon is enabled a lot of the loot chat messages that print multiple items out will get cut very short. This has something to do with the \"Enable Copy\" setting in pChat, disable this option in pChat if you want the full messages to show.",
    "[*] When crafting items, if too many items are sent to the item printer at once (currently 12+), the message will now be replaced with \"too many items to display.\" Otherwise the message wouldn't display at all. This is probably temporary, in the future I'd like to split the items received into multiple lines.",
    "[*] Chat Printer: Added a check if the Combat Metrics addon Combat Log is enabled in order to not print messages to the CMX window if you have the \"Print to Specific Tabs\" option enabled.",
    "[*] Indrik Feathers/Berries purchased from the Event Merchants should now display a proper collectible link in chat.",
    "[*] Separated the \"Mail Notifications\" option in Misc Announcements into a separate option for \"Send/Receive\" and \"Errors.\" Errors are enabled to print to chat by default (this alters the default UI behavior of displaying an alert in the corner of the screen).",
    "[*] Added a \"Stow\" context option for Loot Announcements for stowing siege weapons (packing your deployed siege weapons back into your inventory).",
    "[*] Added an option in Collectibles & Lorebook Announcements (enabled by default) to only display the Center Screen Announcement for books discovered if they are in the Shalidor's Library category (normal non-lore books won't show a CSA).",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Ability Alerts: Updated the sound options for Ability Alerts to use different specific categories to give more control over the sounds played. NOTE: This is a WORK IN PROGRESS, only overland abilities are setup for this. I'm hoping to have dungeon abilities updated for the Stonethorn update.",
    "[*] Ability Alerts: Added an option to show a modifier on certain messages. Currently this is enabled by default and will add an \"ON YOU!\" message if something is directly targeting you. There's also a \"SPREAD OUT!\" modifier that will be added to AOE abilities that require the group to spread out.",
    "[*] Ability Alerts: Fixed an issue where with the \"Show Nearby NPC Events\" setting disabled many enemy attacks wouldn't show an alert event if they were directly targeting you.",
    "[*] Bar Highlight: Fixed an issue where hitting a Warden with Crystallized Shield (and its morphs) would throw a UI error.",
    "[*] Bar Highlight: Added a customizable threshold for displaying decimal values for Bar Highlight timers (1-30 sec duration).",
    "[*] Ultimate Percentage: Fixed an issue where sometimes when you resurrected the ultimate percentage label would show at 100% even when set to hide.",
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
