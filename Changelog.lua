--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local strformat = zo_strformat

local changelogMessages = {
    "|cFFFF00General:|r",
    "[*] Fixed an issue where initiating a vote kick on a party member in LFG through the Player to Player interaction menu would throw a UI error due to referencing a renamed function.",
    "[*] Fixed an issue where recieving Crown Store gifts through the Notifications prompt would cause a Protected Call error. Unfortunately this means accepted/declined response text from sending various invite types to the player will no longer work. I'll have to find another way to handle this in the future.",
    "\n|cFFFF00Buffs & Debuffs:|r",
    "[*] Updated the auras/icons/tooltips/bar highlight, etc for all Necromancer skill line active and passive skills.",
    "\n|cFFFF00Chat Announcements:|r",
    "[*] Fixed an issue where inviting a player to the guild would display duplicate Guild Member joined messages (since the player invited is added to the roster). Thanks to Eearslya Sleiarion for this fix!",
    "[*] Updated the currency announcements to correctly display \"Earn\" context message for Defensive Keep Ticks.",
    "\n|cFFFF00Combat Info:|r",
    "[*] Updated a significant amount of enemy abilities for Active Combat Alerts (more alerts now show the correct cast time and cc type).",
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
