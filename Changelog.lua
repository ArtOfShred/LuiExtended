--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.2.2|r",
    "",
    "|cFFFF00Known Issues:|r",
    "[*] Due to API changes with Major/Minor effects the Bar Highlight component of Combat Info may have some issues tracking Major/Minor debuffs applied onto a target. In some cases they won't start tracking until you mouse off and back on to the target. This is due to some issues with the API that I hope are addressed in the future (although it may not technically qualify as a bug).",
    "",
    "|cFFFF00General:|r",
    "[*] Updated icons & tooltips for the new sets and Alliance War skill line consumables introduced in this update.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] You can now independently control the alignment and sorting direction of each buff or debuff container. The new settings mirror the previous default settings, you may need to readjust some of these settings if you had modified them before.",
    "[*] You can now independently control the Horizontal/Vertical orientation of the Long Term Buffs, Prominent Buffs, and Prominent Debuffs container. The new settings mirror the previous default settings, you may need to readjust some of these settings if you had modified them before.",
    "[*] Added a new Alignment & Sorting Options submenu for the changes above to make changing these settings easier.",
    "[*] Removed the display of Cyrodiil Home/Enemy/Edge Keep bonus buffs - these took up too much space and the functions used to determine/display them were inefficient.",
    "[*] The toggle option for Cyrodiil buffs now only applies to Cyrodiil Scroll bonuses. Emperorship Alliance Bonus & Blessing of War will now always display (Note: The toggle setting for Battle Spirit is separate and remains unchanged).",
    "[*] The options for Consolidating Major/Minor effects has been removed due to API changes to Major/Minor effect handling.",
    "[*] Custom icons for Major/Minor effects from Potions/Poisons have been removed due to API Changes and the menu option for toggling these icons has been removed (Note: The option to toggle the default icons for Major/Minor Slayer/Aegis remains).",
    "",
    "|cFFFF00Combat Info:|r",
    "- Removed the \"Highlight Secondary Id\" option from Bar Highlight settings. This applied to all of about 2 or 3 abilities before (The magicka regen buff for Honor the Dead for example) that now always display when Highlight is enabled.",
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
