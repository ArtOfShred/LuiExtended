------------------
-- Changelog

local changelogMessages = {
    "|cFFFF00General:|r",
    "[*] Updated auras/icons/tooltips/cast bar/etc for all Player Abilities, Siege Weapons/Repair Kits, any missing & new item sets.",
    "[*] Updated auras/icons/tooltips/combat alerts/etc for almost all basic NPC abilities, and started working on Dungeon abilities.",
    "\n|cFFFF00Buffs & Debuffs:|r",
    "[*] Prominent Buffs will now display even when ALL OTHER BUFF/DEBUFF options are turned off. This was always the intended behavior, but was not working due to a massive oversight on my part.",
    "[*] Added a new toggle option for Ground Damage/Healing Auras - when enabled a debuff aura will be displayed when you are standing in a ground aoe effect (e.g. Arrow Barrage)",
    "[*] Fixed an issue where dropping a new rearming trap after only 1 of the 2 traps was consumed would result in two mine auras showing.",
    "\n|cFFFF00Chat Announcements:|r",
    "[*] When looting multiple bodies at once - multiple items with the same ID are now combined into a single count. This significantly reduces the amount of spam loot logging generates.",
    "[*] Updated the Achievement Options with the new category added in Wrathstone and fixed an issue where only some categories would toggle off correctly.",
    "\n|cFFFF00Combat Info:|r",
    "[*] Cast Bar - The cast bar will now automatically break when certain actions are taken, such as roll dodging.",
    "[*] Cast Bar - Added functionality to break the cast bar on movement for casts where this happens, as well as fixed various issues with the cast bar not refreshing when interrupting your cast & attempting to recast before the bar finished.",
    "[*] Ability Bar - Updated the default \"Activation Highlight\" effect (e.g. Shadow Image Teleport) to now loop the visual effect on the bar rather than playing only once.",
    "[*] Ability Bar - Guard and its morphs now display the Toggle Highlight visual effect used by other toggle effects (e.g. Mend Wounds) when active instead of just turning into an \"X\" icon on the bar.",
    "\n|cFFFF00Combat Text:|r",
    "[*] Updated Combat Alerts to work toward making them less spammy (requiring specific criteria for each ability when cast, and applying a refire delay when various error events such as an NPC being out of range are detected).",
    "[*] Added \"Summon\" alerts to Combat Alerts - notifying you if an enemy summons an add.",
    "[*] Fixed an error where the Interrupt message on Combat Alerts was displaying as \"01Interrupt\" due to a syntax error in the default color.",
    "[*] Hid a few snares that rapidly refire from ground auras or other effects that would result in spam when you were immune to them.",
    "\n|cFFFF00Unit Frames:|r",
    "[*] Fixed an issue introduced on the PTS where Player Names on the Group Unit Frames were being displaced from their proper positions.",
}

-- Hide toggle called by the menu or xml button
function LUIE_ToggleChangelog(option)
    LUIEChangelog:ClearAnchors()
    LUIEChangelog:SetAnchor(CENTER, GuiRoot, CENTER, 0, -120 )
    LUIEChangelog:SetHidden(option)
end

-- Called on initialize
function LUIE_ChangelogScreen()
    -- concat messages into one string
    local changelog = table.concat(changelogMessages, "\n")
    -- If text start with '*' replace it with bullet texture
    changelog = string.gsub(changelog, "%[%*%]", "|t12:12:EsoUI/Art/Miscellaneous/bullet.dds|t")
    -- Set the window title
    LUIEChangelogTitle:SetText(zo_strformat("<<1>> Changelog", LUIE.name))
    -- Set the about string
    LUIEChangelogAbout:SetText(zo_strformat("v<<1>> by <<2>>", LUIE.version, LUIE.author))
    -- Set the changelog text
    LUIEChangelogText:SetText(changelog)

    -- Display the changelog if version number < current version
    if (LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion ~= LUIE.version) then
        LUIEChangelog:SetHidden(false)
    end

    -- Set version to current version
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
