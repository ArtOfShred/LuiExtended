--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.3.0|r",
    "",
    "|cFFFF00General:|r",
    "[*] German localization updated thanks to the efforts of saenic!",
    "[*] Added French localization thanks to the efforts of Zhull-GH!",
    "[*] Implemented the features of Nagolite's \"Updated Assistants for Lui Extended\" patch, see more details below in the Slash Commands section.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Made a few minor changes to tooltips and icons.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] GCD Tracker: Disabled this feature due to API changes made in High Isle breaking it.",
    "[*] Potion Timer: Disabled this feature due to API changes made in High Isle breaking it.",
    "",
    "|cFFFF00Slash Commands:|r",
    "[*] Updated Slash Commands & keybindings with support for Crow Assistants, Factotum Assistants, Ghrasharog, and Giladil the Ragpicker. Thanks to Nagolite for implementing these features!",
    "[*] Updated Slash Commands & keybindings with support for Ember and Isobel, the new companions.",
    "[*] Various quality improvements and fixes made to Slash Command & keybinding functionality for summoning assistants & companions thanks to the efforts of Nagolite.",
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
