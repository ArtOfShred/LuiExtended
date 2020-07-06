--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.1.1|r",
    "",
    "|cFFFF00General:|r",
    "[*] A ton of additional Russian translation has been done by FAR474 including localizing pet names for the buttons in the Pet Unit Frames Options. If you notice any errors with translations, reach out to FAR747 on ESOUI!",
    "[*] Added Grainy Statusbar textures to the dropdown texture options for Unit Frames (thanks to saenic).",
    "[*] Updated icons/auras/alerts/etc for Volenfell as well as improved many enemy ability icons.",
    "[*] The option to unlock default UI elements has been expanded with the ability to move the Alerts Frame, Compass, and Experience Bar.",
    "[*] Fixed an issue where when moving the Objective Capture Meter frame, the objective fill for the frame wouldn't move with it.",
    "[*] Added an option to hide ALL alerts (that display by default in the upper right corner of the screen).",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Added a toggle option under Position and Display Options for showing useful raid debuffs applied by other players (enabled by default to mimic the current behavior).",
    "[*] Added a toggle option under Position and Display Options for showing Major/Minor debuffs applied by other players (enabled by default to mimic the current behavior).",
    "[*] Added buttons under Buff & Debuff Blacklisting to separately add Major & Minor Buffs/Debuffs to the blacklist and a button to clear all entries in the ability blacklist.",
    "[*] Added a toggle option under Custom Icon & Normalization Options to use the default icons for Major & Minor Slayer/Aegis/Courage/Toughness instead of the custom LUIE icons.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Fixed the order in which Antiquity announcements display in chat (after gold/loot but before collectibles/achievements).",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Bar Highlight: Expanded the ability to hide bar label fractions with an option to show fractions when the remaining duration is < 10 seconds and hide them above that duration. Thanks to saenic for implementing this feature!",
    "[*] Ability Alerts: Fixed an issue where interrupt alerts weren't showing (thanks to Niobiritzu for finding this issue).",
    "[*] Ability Alerts: Adjusted the alert for Boulder Toss (Ogrim) to have a slight post cast duration so it remains active while the rock hurtles toward your domepiece.",
    "[*] Ability Alerts: Hid the alert for the Bear Trap dropped by some NPCs since it was pretty much pointless.",
    "",
    "|cFFFF00Combat Text:|r",
    "[*] Added a button to clear all entries in the ability blacklist for Combat Text.",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] Added a button to add all of your CURRENTLY active pets to the whitelist for pet names. This option is useful if you are using an addon like RuESO that changes the way Pet Unit Names display.",
    "[*] Added toggle options to hide the Player Health Bar label and entirely hide the Player Health Bar. I don't recommend hiding the bar but you can still do it if you like.",
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
