--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.2.5|r",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Optimized and reorganized the filtering code, now prominent effects will always show even when long or short-term effects are hidden.",
    "[*] Added icons & tooltips for the new Status Effects for Physical, Bleed, and Magic Damage.",
    "[*] \"Fake\" buffs such as Sneak, Disguised, and Mounted can now be displayed as prominent.",
    "[*] Updated the tooltips for Major/Minor Endurance, Fortitude, and Intellect to reflect their new % values.",
    "[*] Updated the tooltip for Battle Spirit to reflect the changes made in the Flames of Ambition update.",
    "[*] Sneak now has a dynamic tooltip that displays the movement speed reduction and stamina cost.",
    "[*] Merged the \"Long-Term Effects Filters\" submenu options into the \"Long-Term Effects\" submenu options.",
    "[*] Added an option to disable the display of Short-Term Effects.",
    "[*] Added an option to toggle detailed information on/off for active Non-Combat Pet buff (on by default to match previous behavior).",
    "[*] Non-Combat Pet and Assistant buffs no longer display inside houses since you can't have active collectibles of this type inside a house.",
    "[*] Fixed an issue where the Target Iron Atronach, Trial was displaying duplicate buffs.",
    "[*] Updated tracking for Off Balance Immunity. Now you can set this as a Prominent Buff to track the effect on the player or a Prominent Debuff to track the effect on targets.",
    "[*] Fixed an issue where adding/removing a buff/debuff from Prominent Effects or from the Blacklist would reset the buff container anchoring.",
    "",
    "|cFFFF00Combat Text:|r",
    "[*] Combat Text automatically hid some resource regeneration/drain effects that could be slightly spammy (Bull Netch for example). This is no longer the case and instead buttons have been added to the blacklist menu for class abilities that are spammy. By default the stamina drain from sneak is added to this blacklist.",
    "",
    "|cFFFF00Slash Commands:|r",
    "[*] Updated the /cake command to use the 2021 Jubilee Cake.",
    "[*] Updated the /campaign command to work with campaigns added more recently. Thanks to TarodBOFH for discovering this issue.",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] Mousing over the XP Bar on the player frame will now show \"Max XP\" and hide enlightened status details if the player is at max Champion Points (to mimic the behavior of the default XP bar).",
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
