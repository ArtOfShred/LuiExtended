--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.0.9|r",
    "",
    "|cFFFF00General:|r",
    "[*] NOTE: Currently no changes have been made for LUIE Components for the new Vampire Skill Line, Werewolf Skill Line Changes, or any new sets & mythic items added with this update. Buffs & Debuffs will not have custom icons or tooltips, Vampire Abilities won't be correctly labeled for the purpose of hiding them in the menu settings, and Bar Highlight/Cast Bars for new vampire/werewolf abilities are not implemented. Implementing everything listed here will be the priority for the next update.",
    "[*] Updated tooltips & auras for all item sets & monster helms changed in this update as well as updated custom icons for some sets.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Added support for new potions/poisons added in Greymoor & fixed an issue where the tick rate was not displaying correctly in the tooltips for damaging potions and poisons.",
    "[*] Temple Guards in Cyrodiil now show the correct faction specific icon for their Stealth detection ability.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Added options in the menu to display when items are used/lost for: Potion, Food/Drink, Repair Kits/Siege Repair Kits, Soul Gems, Siege Deployment, misc items such as Keep Recall Stones, and items turned in for quests.",
    "[*] You no longer need to toggle on \"Display Item Loss - Destroyed Items\" to show other types of messages related to inventory items being lost/used/etc.",
    "[*] Fixed a longstanding issue with the \"Display Materials Used\" crafting loot option. This will now show the correct item when an item is pulled from the inventory instead of the craft bag.",
    "[*] Messages for crafting materials used will now merge quantities in the case of separate stacks or items being used from multiple bags. For example if you use 30 ingots, 10 from the bank, 10 from inventory, and 10 from the craft bag - they will now just show as using 30x ingot.",
    "[*] Loot messages displayed for items being crafted/deconstructed will now merge stacks instead of displaying individually. For example if you create 10 Iron Battle Axes, you'll now see \"You craft [Iron Battle Axe] x10\" instead of 10 individual comma separated items.",
    "[*] Added support for any addon that uses LibLazyCrafting (Dolgubon's Lazy Writ Creator, etc) for crafting messages. You will now see item messages labeled correctly as crafted/used regardless of what tab of the Crafting interface you are on.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Updated icons & cast bars for deploying new Siege Weapons.",
    "[*] The cast bar for deploying siege will now break when you tab in and out of the game or open an ingame window (inventory, character screen, etc).",
    "[*] The cast bar for stowing siege weapons now breaks if you exit siege mode in the middle of the cast.",
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
