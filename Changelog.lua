--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.6.4|r",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Fixed an issue where having unanchored buff frames could throw UI errors under certain conditions.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Added error prevention for item chat messages throwing a UI error under certain conditions.",
    "",
    "|cFFA500LuiExtended Version 6.6.3|r",
    "",
    "|cFFFF00General:|r",
    "[*] Updated Bar Highlight & Buff Tracking for these abilities and their morphs: Trap Beast (Fighters Guild), Scorch (Warden), Grim Focus (Nightblade), Bound Armaments (Sorcerer), Blood Frenzy (Vampire).",
    '[*] Abilities that "echo" now display a stack counter (for Bar Highlight & Buff Tracking) to serve as a counter - so far this includes Scorch & Haunting Curse.',
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Added options for row stacking for the Player/Target Buff & Debuff frames when the option to anchor the frames to the Custom Unit Frames is DISABLED. You can customize how wide the containers are and the direction the rows stack (up or down).",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Fixed an issue where the Collectible messages/announcements could throw UI errors.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Fixed an issue where the Ultimate Label would not correctly update if Bar Highlight tracking was disabled.",
    "[*] You can now display the back bar without Bar Highlight tracking enabled if you just want to add the back bar to see it.",
    "[*] Flame Lash (Dragonknight) ability icon on the ability bar now glows when Power Lash is available (targeting an enemy that is rooted or Off-Balance).",
    "",
    "|cFFFF00Unit Frames:|r",
    '[*] Unit Frames now display the "Trauma" effect (healing absorption) - this has a customizable color and will display on all bars. You can also display the value on the bars but this must be configured in the settings menu (the dropdowns for the format now include options for adding the Trauma value).',
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
