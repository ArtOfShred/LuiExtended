--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.2.4|r",
    "",
    "|cFFFF00General:|r",
    "[*] Fixed an issue where Combat Text was throwing UI errors for Bleed abilities. I missed that a DAMAGE_TYPE_BLEED was added with this patch as a new damage type for bleeds.",
    "[*] Fixed an issue where the Global Cooldown Tracking component of Combat Info was throwing UI errors.",
    "",
    "|cFFA500LuiExtended Version 6.2.3|r",
    "",
    "|cFFFF00General:|r",
    "[*] Fixed various errors related to API changes from this update.",
    "[*] Attempted to fix an issue where the Combat Info Bar Highlight component threw errors when Shimmering Shield was hit on a Warden.",
    "[*] Removed a hooked function for Guild Heraldry updates that had been reported to cause errors.",
    "[*] Removed some unused icons and updated tooltips for most new Champion Point abilities.",
    "[*] A more detailed Change Log may be released in the future. This was a quick update for Flames of Ambition.",
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
