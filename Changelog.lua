--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.2.0|r",
    "",
    "|cFFFF00General:|r",
    "[*] Additional RU translation completed thanks to FAR747!",
    "[*] Updated aura tracking and tooltips for all sets and player abilities changed/added in the Stonethorn update.",
    "[*] Improved the quality and added new icons for sets as well as improved many NPC ability icons.",
    "[*] Improved the quality of the cast bar icons for mementos & usable items (siege, pardon edicts, etc).",
    "[*] Added cast bars & icons for several item interactions (creating Psijic Ambrosia Recipe, Aetheric Cipher, Alliance Standard-Bearer's License, etc).",
    "[*] Fixed an issue where some ability names in tooltips weren't punctuated properly due to the base UI string SI_UNIT_NAME being changed.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Updated the Werewolf Timer buff. It's no longer possible to determine the duration of werewolf form due to the variance in Werewolf power drain based off passives and proximity to other Werewolves - but the bar will update based on the % power value when it is set to display as a prominent buff.",
    "[*] Added an aura that displays in combat when wearing Snow Treaders (only for self due to API limitations).",
    "[*] Updated the tooltips for Mundus Stone buffs to have consistent syntax with other buffs.",
    "[*] Updated the tooltips for Daedric Titan abilities to show the correct snare speed reduction %.",
    "[*] Hid the dummy \"Death Achieve Check\" buff that would sometimes display on players in Veteran dungeons.",
    "[*] The debug function to display combat and buff events in chat now prints out to chat normally (so pChat and other chat addons can save the messages).",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Transmutation Geodes are now added to the blacklist for Group Member Loot.",
    "[*] Removed the Mercenary Motifs from the blacklist for Group Member Loot since they are no longer anywhere near as common.",
    "[*] Fixed several issues with quest item added/removed messages, including fixing the messages for combining quest items to work properly.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Combat Alerts: Combat alerts for nearby enemy attacks will now hide when the player is in a duel.",
    "[*] Combat Alerts: Fixed an issue where the sound toggle setting for Single Target CC Abilities wasn't updating properly due to a typo in the variable name.",
    "[*] Bar Highlight: Ground Mine abilities will now display a stack count.",
    "[*] Bar Highlight: Added tracking support for Arena Weapon Sets where it was fitting.",
    "[*] Bar Highlight: Fixed an issue where some abilities that tracked multiple effect ids weren't displaying properly.",
    "[*] Bar Highlight: Fixed an error that could occasionally occur when a ground mine effect expired.",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] Fixed an error that could occasionally occur when a player changed their title.",
    "[*] Fixed an issue where sometimes the anchored player buffs frame would clip into the extra bar (horse stamina/werewolf/siege).",
    "[*] The extra bar for Werewolf will no longer show a duration remaining on the mouseover tooltip due to changes made to the skill line, and will now refer to werewolf power as \"Rage.\"",
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
