--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

local zo_strformat = zo_strformat

local changelogMessages = {
    "|cFFA500LuiExtended Version 6.0.3|r",
    "",
    "|cFFFF00Slash Commands:|r",
    "[*] Fixed an issue where using the /fence Slash Command or Keybinding would throw an error.",
    "[*] When summoning a banker, fence, or merchant with the keybinding, your Chat Announcement setting will now determine if a feedback chat message is displayed. Note that using the slash command will still always return feedback into chat.",
    "",
    "|cFFA500LuiExtended Version 6.0.2|r",
    "",
    "|cFFFF00General:|r",
    "[*] Added a keybinding option for \"Leave Group.\"",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Restored the ability to print chat messages to specific chat tabs.",
    "[*] Removed the \"Enable pChat Message Saving\" setting and replaced it with an \"Allow Addons to Modify LUIE Messages.\" It has the same functionality but is disabled by default. This setting can always be enabled now instead of toggling off when selecting the option to print to specific chat tabs (it still won't effect messages printed to specific tabs but will handle system messages if you choose to print those in all tabs).",
    "[*] Fixed an issue where having LibChatMessage enabled would bypass some Chat Announcements toggle settings, the most common being friends logging on & off. Now if you choose to disable these messages, they will cease to display properly.",
    "[*] Fixed an issue where promoting a player to group leader or being promoted to group leader sometimes wouldn't properly show the promotion chat message/alert.",
    "",
    "|cFFA500LuiExtended Version 6.0.1|r",
    "",
    "|cFFFF00General:|r",
    "[*] Fixed an issue with the Crowd Control Tracker where \"Player Set AOE\" was using the setting for \"Player Ultimate AOE.\"",
    "[*] Fixed an issue where the keybinding options for Summon Banker/Merchant were reversed (Banker key summoned Merchant and vice versa).",
    "[*] Fixed a few strings missing from the German translation.",
    "",
    "|cFFA500LuiExtended Version 6.0.0|r",
    "",
    "|cFFFF00General:|r",
    "[*] DE translation has been started and populated thoroughly thanks to AmonFlorian!",
    "[*] Added keybindings to summon the new Cat Banker/Merchant from the crown store.",
    "[*] Updated tooltips, auras, icons, etc for player ability and set changes in Scalebreaker, Dragonhold, and Harrowstorm, as well as did a pass on the tooltips for all of these abilities to update and add range, normalize syntax, etc.",
    "[*] I purchased a large amount of icons for use from various game development platforms such as the Unity store, this means I will be significantly improving the quality of all custom icons. A good deal of new work as been added with more to come. Credits for custom icons listed at the bottom of the changelog.",
    "[*] Attacks sourced from Morkuldin will now properly show the localized name \"Morkuldin\" in death recap.",
    "[*] Perfected Weapon effect auras, damage, resource restore etc no longer have a \"(Perfected)\" tag on the end. Some set names were getting a little too long on Combat Text.",
    "[*] Dark Shade and its morphs now have proper names in Death Recap instead of \"Gloom Wrath\" (this is the actual name of the pet NPC you summon with Dark Shade + morphs, hopefully ZOS will update it at some point).",
    "[*] Added the \"Forced Square\" font into the list of fonts to choose from for LUIE components. Thanks nomaddc!",
    "[*] Added a function that allows all of LUIE's component frames to be hidden. I did this with support in mind for Essential Housing Tools (and potentially any other addon that makes significant changes to scene display).",
    "[*] Hooked into the Keep Upgrade interface in Cyrodiil (in Keyboard and Gamepad mode). Improved the icons & tooltips as well as tooltip formatting for this menu.",
    "[*] Hooked into the Campaign Bonuses tab in the Campaign Browser (in Keyboard and Gamepad mode). Improved the icons & tooltips as well as tooltip formatting for this menu.",
    "[*] The character \"Active Effects\" Window in gamepad mode will now display updated tooltips properly.",
    "",
    "|cFFFF00Buffs & Debuffs:|r",
    "[*] Prominent Buffs can now be sorted horizontally in addition to the default vertical setting. May still need some testing. Thanks to AmonFlorian!",
    "[*] Added an option to display the Ability Id & Buff Type of auras in the tooltips submenu for Buffs & Debuffs. ",
    "[*] Improved Tooltip formatting & extended this formatting to the character \"Active Effects\" Window.",
    "[*] Updated the icons for all player weapons attacks to be better quality.",
    "[*] Updated various icons for sets and attacks to be better quality.",
    "[*] Updated the icons for many NPC attacks to be far better quality.",
    "[*] The Iron Atronach Target Dummy nows shows a \"fake\" debuff icon for Minor Magickasteal (ZoS implementation of this debuff is inconsistent and this one was not showing).",
    "[*] Added functionality to pull the info from a skill morph for some passive abilities that have shared auras. For example: the Minor Effects from Restoring Aura / Radiant Aura will now show their proper source.",
    "[*] Updated the tooltips for Dawnbreaker, Beast Trap, and Roar of Alkosh to no longer refer to their damage over time component as \"Bleed\" damage, as these effects are not considered a bleed effect.",
    "[*] The stun from the Warden's Feral Guardian + morphs now shows for the player (and other players too since it's pet and not player sources), but at least it can be seen now.",
    "[*] Removed the menu option for tracking the Sprint/Gallop buff for now - the new method ZOS is using doesn't return an abilityId in game.",
    "[*] Previously I had changed a lot of NPC uppercut abilities to use the name/icon for Dizzying Swing to stay consistent with how its mechanics work. However, now that the stun has been removed from Dizzying, I'm just reverting this to their default (and fixing missing icons/etc where need).",
    "[*] The Warden ability Crystallized Shield and its morphs now display the stacks of reflection charges remaining and track the actual duration. This is done by showing the effect that was some reason hidden by default and hiding the default dummy tracker buff.",
    "[*] Some buffs & debuffs were not able to be blacklisted (due to being \"fake\" effects) created using Combat Events instead of Effect Events. Added blacklist support for these auras.",
    "[*] Stone Giant's \"Stagger\" debuff will now show for all players on a target since it effects everyone attacking the target, and any Dragonknight can contribute to refreshing the stacks.",
    "[*] When the werewolf transformation timer is added to prominent buffs, it will now display the timer bar properly.",
    "",
    "|cFFFF00Chat Announcements:|r",
    "[*] Print Chat to multiple tabs is disabled currently due to significant changes that were made to the chat API - will hopefully be reimplemented in the future. You can still toggle timestamps for LUIE messages on/off.",
    "[*] Added additional achievement tracking categories for the new DLC.",
    "[*] Added a submenu into Collectible Options to enable the display of a chat message or alert when a Collectible in the Vanity Pets, Assistants, Ability Skins or one of the Appearance Changes is used.",
    "[*] Added support for Undaunted Keys fors currency and loot tracking.",
    "[*] Fixed some issues with/updated the way VENDOR loot works with the merged messages option selected. Now if you choose to display total currency/total loot it will always display regardless of your individual selections in the other menus. This is so if you want to see totals indepedently on vendors but not when looting (or vice versa) you can.",
    "[*] Added a 1000 ms delay on resetting the variable that determines if the player is currently browsing a store. Depending on latency its possible to purchase items from a vendor and then close the window before a response from the server places the items in your inventory. When this happened the items would appear as looted instead of purchased. This throttle should stop this from happening.",
    "[*] Fixed an error with the messages displayed for absorbing skyshards due to the function not being updated with the API changes made in Dragonhold. Thanks AmonFlorian for making this change.",
    "[*] Updated the quest item added/removed loot tracking to have more syntax options for things like turning in quest items, discarding them, etc. Some of this is automatic and some requires manual input so it will take a while before everything works perfectly.",
    "[*] Updated many handlers for various Chat Announcement components for API changes made over the last couple years. I will be adjusting these on each update in the future instead of letting myself get behind. A few things that weren't working should be now.",
    "[*] Added some new support to changes made to the Guild API (when roster was added). Guild rank changes will now display with better information thanks to some new events added in the API.",
    "[*] Did a pass on the Group Finder chat announcements. The event sequence for group finder is an absolute chaotic mess, but from my testing done on the PTS everything appears to display cleanly, with proper alerts for leaving/entering queue, ready check failure reasons, and entering an LFG activity. I have to hide all group events when an LFG group forms because a mess of party leaving/joining/leader changing happens during it. Hopefully with live server lag during busy times this will still function properly.",
    "",
    "|cFFFF00Combat Info:|r",
    "[*] Implemented the features of Miat's Crowd Control Tracker into LUIE (with permission, thanks to dorrino!). This version of the crowd control tracker is enhanced with several new features.",
	"      - Display a different border color based on the type of CC applied (including unbreakable cc).",
	"      - Choose a custom sound to play when effected by CC.",
	"      - Display an alert when standing in hostile AOE effects with various toggleable categories and different sounds options for each. This list requires manual input but I have player skills added, most overland mobs and have at least made some progress adding dungeon/arena abilities.",
    "[*] Updated many abilities in Combat Alerts with better duration tracking and proper CC types.",
    "[*] Bar Highlight tracking now supports tracking multiple ability id's, resulting in the ability to track ground mine durations & their effects individually and to track both the physical & magical dot from Soul Trap and so on.",
    "[*] Updated Bar Highlight tracking to handle API changes made in Scalebreaker. The bar highlights were being refreshed too quickly which could lead to performance issues and resulted in a stuttering effect occuring on the \"proc\" animation highlight.",
    "[*] Added a few checks into bar highlight tracking to potentially stop errors from being thrown occasionally.",
    "[*] Bound Armaments now plays a proc alert upon reaching 4 stacks (and will play the proc animation at any number of stacks).",
    "[*] Procs that change the ability on your bar (Grim Focus, Power Lash for example) will now have a 3 sec iternal cooldown for playing the proc sound, this way the sound doesn't spam if you swap targets or bar swap.",
    "[*] Updated the \"Absorbing Skyshard\" cast bar to use a new icon added in U24.",
    "[*] Toggling the LUIE ultimate tracker on disables the default UI ultimate tracker to stop overlap from occuring.",
    "[*] The ability alerts component has had some functionality updates. These are mostly backend feature changes that allow me to get around some of the limitations of the API to display better sources for effects that don't provide them etc, by using manual values.",
    "[*] Made some changes to interrupt detection for the cast bar due to changes due to API changes. The castbar should now cancel when the player bashes or blocks if those actions can break the cast (Harrowstorm added the ability to bash the air to interrupt channeled effects).",
    "",
    "|cFFFF00Combat Text:|r",
    "[*] Fixed an issue where the font selection wasn't working properly and would always use the default game font.",
    "[*] Combat Text font selection is now sorted alphabetically like most other long dropdown selections.",
    "[*] Added a slider to control the speed of Combat Text, thanks to AmonFlorian!",
    "[*] Added an ability blacklist menu to Combat Text. This functions in the same way as the Buffs & Debuffs blacklist - you can blacklist by AbilityId or AbilityName.",
    "[*] Fixed an error where the setting for Throttling Critical Hits was being reset when the setting for Throttling normal hits was toggled.",
    "[*] Throttle for Critical Hits menu option is now disabled when Throttle for normal hits is disabled.",
    "",
    "|cFFFF00Slash Commands:|r",
    "[*] Added a menu option to choose between the old banker/merchant or the cat banker/merchant for their respective slash commands.",
    "[*] Any slash command that uses a collectible will now display a message in chat when the collectible is summoned or unsummoned.",
    "",
    "|cFFFF00Unit Frames:|r",
    "[*] Toggling the LUIE overlay on for default unit frames now disables the default UI unitframe text menu option to stop overlap from occuring.",
    "",
    "|cFFFF00Art Assets:|r",
    "[*] Custom ability icons by and modified from eleazzaar licensed under the CC-3 License (https://creativecommons.org/licenses/by/3.0/)",
    "[*] Custom ability icons by and modified from AKiZA, Angelina Avgustova, Dayed, Digital Worlds JSC, Ever Probe, HOSE, Jon Snow, Josch, Kalle Olli, Moon Tribe, N-hance Studio, PONETI, REXARD, Sky Painter, The 7 Heaven, TiGame, and TonityEden licensed under the Unity Store single entity license. (https://unity3d.com/legal/as_terms)",
    "[*] Custom ability icons by and modified from a-ravlik & micart licensed under the GraphicRiver regular license. (https://graphicriver.net/licenses/terms/regular)",
    "[*] Custom ability icons by and modified from Forrest Imel, Frostwindz and Mizuko licensed under the GameDevMarket.net pro license. (https://www.gamedevmarket.net/terms-conditions/#pro-licence)",
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
