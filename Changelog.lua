--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.1.0|r",
    "",
    "|cFFFF00General:|r",
    "[*] Expanded the option to unlock default UI elements and move them with more elements (Action Bar, Subtitles, Infamy Meter, etc) as well as improved the unlock functionality.",
    "[*] Updated icons/auras/tooltips/etc to adjust for changes made to the Vampire & Werewolf skill lines and quests, as well as new sets & mythic items added in Greymoor.",
    "[*] Updated icons/auras/tooltips/alerts/etc for the abilities used by enemies in the Greymoor tutorial area and enemies and bosses in Crypt of Hearts II.",
    "[*] Updated and improved some icons for enemy abilities and player sets and improved the icons used by Sorcerer and Werewolf pets.",
    "[*] Updated some player ability tooltips to account for some of the syntax changes and tooltip improvements made by game updates.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] General: Fixed an potential issue that could occur with the message printer in Chat Announcements if somehow there was a gap in the index of queued messages.",
    "[*] Loot: Storage Coffer/Chest collectible items that can be purchased from vendors will now display a proper collectible link when the item is purchased.",
    "[*] Loot: Fixed an issue where the \"Bracket Options\" setting was not properly applying to items looted by other players.",
    "[*] Loot: Added an option to use the generic message color for Loot/Currency transactions that are merged (buying/selling an item).",
    "[*] Loot: Added support to display a message when you list an item for sale on the guild store.",
    "[*] Loot: When trading/mailing items, separate stacks of the same item are now combined into one chat message. So if you send 6 stacks of 200 weapon power potions to someone you'll now just see one chat message specifying you sent 1200 potions instead of 6 lines of 200.",
    "[*] Loot: Updated the options for context messages for Potion/Food/Drink if you choose to modify them.",
    "[*] Loot: Added a context message for excavating items/gold from a dig site.",
    "[*] Loot: Added options to display Chat Announcements when a Recipe/Motif/Style is learned as well as an option to disable the default alert (upper right corner message) that appears.",
    "[*] Antiquities: Added a menu for Antiquities, allowing you to customize the display of Chat Announcements/Alerts/Center Screen Announcements when discovering a lead. You can click on the Antiquity links from Chat Announcements to open the Codex entry for them.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Bar Highlight: Added the option to display the backbar for Bar Highlight Ability Tracking with several customization options.",
    "[*] Bar Highlight: Added a stack counter to tracked abilities.",
    "[*] Bar Highlight: Cleaned up the backend for Bar Highlight tracking, and the highlights now sync with the flipcard animations when bar swapping, making everything look a little smoother.",
    "[*] Bar Highlight: Tracking for Sorcerer - Bound Armaments now just shows the duration of the overall buff instead of the 10 sec stack duration making it easier to follow.",
    "[*] Bar Highlight: Tracking for Warden - Crystallized Shield (and its morphs) now track stacks.",
    "[*] Ultimate Tracking: The ultimate tracking Percentage label will now cap at 100% value, and both the value and percentage labels and will update when your Vampire Stage changes or when you change your equipped gear (in case you equip/unequip a set that reduces ultimate cost).",
    "[*] Ultimate Generation: Fixed an issue where the Ultimate Generation texture sometimes wouldn't display when you were generating ultimate.",
    "[*] Combat Alerts: Added a context message for \"Hard CC\" for the interrupt notification for abilities that can only be interrupted by hard crowd control effects.",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] The option to move default Unit Frames up/down is now independent from the option to set them to display in a pyramid mode and both of these options now update on the fly rather than requiring a /reloadui.",
    "[*] Added a new menu for Player & Target - Bar Fill Direction in Unit Frames allowing you to choose the direction the bars fill from. This allows you to have the bars behave more similarly to the default frames.",
    "[*] Added an option to the new menu to set the value label for player/target frames to display in the center of the bar instead of having a right and left label.",
    "",
    "|cFFFF00Slash Commands:|r",
    "[*] Added a slash command and keybinding option to dismiss Sorcerer and Warden pets.",
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
