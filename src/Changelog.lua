--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat
local table_concat = table.concat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.6.9|r",
    "",
    "|cFFFF00Combat Text:|r",
    "[*] Fixed an issue where the Combat Text settings reset with this update. This was due to an issue where the specific Saved Variables for Combat Text were accidentally renamed. Your old settings will be restored as long as you haven't manually cleared your saved variables since the update. The renamed variables will also be cleaned up and removed so as not to inflate the size of your LUIE Saved Variables file.",
    "",
    "|cFFA500LuiExtended Version 6.6.8|r",
    "",
    "|cFFFF00General:|r",
    "[*] Added the ArchivoNarrow font as a selectable option.",
    "[*] Added the ability to move the Endless Archive progress tracker (when you Unlock Default UI Elements).",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Updated tooltips for several effects for Cryodiil Siege weapons that were out of date.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Fixed an error that could occur with currency announcements when purchasing items on the Crown Store.",
    "[*] Added an option to show an item loss message when you fillet a fish (manually).",
    '[*] Updated the context messages for filleting fish at the provisioning station to "You fillet..."',
    "[*] KNOWN ISSUE: When filleting a certain amount of fish (seems to be under ~50) the messages for filleting at the crafting station won't display the proper amount of fish used. You can read more details about this on the pinned post in the LUIE comments on ESOUI.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Crowd Control Tracker will now no longer show a CC warning for the cosmetic stun effects when entering various portals in Endless Archive (Thanks ACastanza for finding all these abilityIds).",
    "[*] Floating Markers now use a different more detailed texture.",
    "[*] Fixed an issue where the Floating Marker was removed when changing zones.",
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
    local changelog = table_concat(changelogMessages, "\n")
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
