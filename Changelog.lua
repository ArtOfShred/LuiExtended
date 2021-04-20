--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.2.6|r",
    "",
    "|cFFFF00General:|r",
    "[*] Added options to Buffs & Debuffs, Combat Info - Ability Alerts, Combat Info - Crowd Control Tracker, and Combat Text to use default icons for crowd control effects. This is a WIP for some of the modules as certain things require manual table data to work correctly. I will be aiming to at least add full support for player abilities.",
    "[*] Reset the default color options for Buffs & Debuffs, Combat Info - Ability Alerts (Crowd Control Colors), and Combat Info - Crowd Control Tracker. This change will apply once when loading the addon and save any changes you make after.",
    "[*] Components that have a blacklist/whitelist function now all have buttons with confirmation prompts to clear the entire list.",
    "[*] Updated the keybindings for summoning Merchant/Banker/Fence to display a message in chat always. Previously this used the setting under Chat Announcements for collectible use messages.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Consolidated several submenus in Buffs & Debuffs.",
    "[*] You can now change the container alignment of Long Term Effects & Prominent Buffs/Debuffs without reloading the UI.",
    "[*] Prominent Buffs will no longer show clipping bars/labels when set to display with the horizontal method.",
    "[*] Added an option to hide the display of Short-term effects on the Player/Target in addition to Long-term effects.",
    "[*] Added a new \"Priority Buffs & Debuffs\" whitelist. These buffs & debuffs will show up with a different color.",
    "[*] Added a new menu to customize buff/debuff colors, and the option to toggle coloring debuffs by CC type (Very heavy WIP since it requires manual table data).",
    "[*] Fixed an issue where there was no buff icon for Argonian and Khajiit Summon Shade and its morphs.",
    "[*] Updated mouseover tooltips for buffs/debuffs to reflect if they are a ground buff/debuff, or a tracker effect for an AOE cast by the player.",
    "[*] Added the CC Immunity buff to Target Dummies that were missing it.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Implemented a safeguard that should prevent a UI error from occuring when refining a large amount of crafting materials.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Ability Alerts - Added an option for mitigation alerts to color the incoming ability name by its CC type. Adjusted a few menu options for syntax to accommodate for this change.",
    "[*] Bar Highlight - Fixed an issue where Crystallized Shield and its morphs would throw a UI error when taking damage with this component enabled.",
    "[*] Bar Highlight - Fixed an issue where the bar highlight for Argonian and Khajiit Summon Shade and its morphs didn't function properly.",
    "[*] Bar Highlight - Subterranean Assault now shows a 6 second timer when cast to track the full duration of its effect.",
    "[*] Crowd Control Tracker - Added new color options for Knockback & Pull/Levitate effects.",
    "[*] Crowd Control Tracker - Fixed an issue where unbreakable buffs would turn from the Unbreakable Color to default CC color when the break free animation played.",
    "",
    "|cFFFF00Combat Text:|r",
    "[*] Reset the default bleed damage color to red. This change will apply once when loading the addon and save any changes you make after.",
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
