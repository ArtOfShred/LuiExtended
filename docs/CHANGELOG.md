### Version 6.2.9

Buffs & Debuffs
- Fixed an issue where the icon for the ground tracker buff for Nova and its morphs was missing.
- Fixed an issue where no ground tracker buff was displaying for Cleansing Ritual and its morphs.
- Rune Focus and its morphs now show a buff when you are standing in the healing circle.
- Vampire Stages now show as long term buffs.
- Fixed various ability tooltips to account for changes made in the last couple updates.

Chat Announcements
- Alerts for collectible usage will now also display when you summon/dismiss a companion.

Slash Commands
- You can now specify '/home inside' or '/home outside' when warping to your primary home.
- The '/home' slash command now has an option to toggle whether to default to warping inside or outside your primary home.
- Added a '/companion' slash command to summon a companion and menu option to determine the default companion to summon. You can also specify the companion to summon with '/companion mirri' or '/companion bastian' or by using the '/mirri' or '/bastian' command.
- Added keybinding options to summon either companion.

Unit Frames
- Added a Unit Frame for tracking your active companion (enabled by default). This frame takes the previous default position of the Pet Unit Frames. The Pet Unit Frames position will be reset to default when loading the addon and save any changes you make after.
- Updated support for the "Dead" label to display on frames. Now companions, pets, bosses, and your target will show as "Dead" instead of at 0 Health.
- The Target Unit Frame now displays an indicator when a player is being resurrected or reviving (to match the behavior of Group Unit Frames), this also works for the Companion Unit Frame.

---

### Version 6.2.8

Slash Commands
- Fixed an issue where the '/outfit' command was not working properly due to an API change I missed.

Unit Frames
- Fixed an issue where a UI error would occur when mousing over a Companion with the "Target - Use Reaction Color" option enabled in Unit Frames settings.
- Added the option to change the Reaction Color for Companions in the Custom Unit Frame Color Options menu.

---

### Version 6.2.7

Known Issues
- Duration & Stack Tracking for Bar Highlight is currently disabled. Something that changed in the API broke this and I haven't been able to figure out what caused it yet despite rooting around for an exceptionally long time. I may have to rewrite this component in the future. I'd suggest using Action Duration Reminder in the meantime.

Buffs & Debuffs
- The Gamepad Skills Window & Gamepad Skills Advisor now properly show custom passive icons added by LUIE.
- The Gamepad Active Effects Window now properly hides buffs & debuffs filtered out by LUIE.
- Updated the tooltips for Alliance War Tortes / Scrolls to clarify they increase both "Alliance Rank and Alliance War Skill Line progression."
- Updated the backdrop & tooltip for Cyrodiil Food/Drink buffs since the quality was upgraded from White to Blue.
- Added Icons & Cast Bar support for various item/collectible fragment combination/use.
- Added Icons & Cast Bar support for many Collectibles that were missing it.
- Added Icons & Cast Bar support for the Aetherial Well furnishing item.
- Updated icons and tooltips for the Champion System update.
- Improved icons for several item sets.
- Removed the custom icns used for Major/Minor Aegis, Courage, Slayer, and Toughness since ZOS has implemented new icons.
- The Active Effects Window will now display more detailed information about the type of Buff/Debuff to match the behavior of mousing over LUIE buffs (I.E. shows whether the effect is unbreakable, a ground effect, an AOE Tracker, etc).
- Fixed some missing ACTION_RESULT's for the debug logging option to stop it from throwing errors.
- The toggle option to show Set Internal Cooldowns now has support for the Sentry set and has been moved into the Short-Term effects filters.
- Added an option to toggle the display of Ability Internal Cooldowns (for Champion Abilities - Expert Evasion & Slippery)
- Removed some name override data for Weapon Glyphs (the abilities are just called Crusher/Hardening/Weakening/Weapon Damage) instead of "X Enchantment." This makes the only change from the default UI renaming "Berserker" from the Glyph of Weapon Damage to "Weapon Damage."
- Updated light/medium/heavy attacks for unarmed/weapons/Volendrung/Werewolf to match the current and updated syntax ZOS implemented ex. "Light Attack (Two Handed)."
- The Internal Cooldown for Werewolf & Vampire Player Bites now show as Long-Term effects.

Chat Announcements
- Experience: Updated and restored the announcements for Champion Points being earned.
- Experience: Cleaned up and normalized messages related to Respec Notifications.
- Currency: Fixed an issue where currency postage values weren't always correct when sending mail.
- Loot: Fixed an issue where Chat Announcements for learning recipes would display the total item count for that recipe if there were other copies of the recipe in your inventory.
- Loot: Fixed some collectibles not showing a collectible link when purchasing them from the event vendor.
- Collectible: Collectible Messages now have the option to display both Category & Subcategory.
- Group: When forming a group and inviting a player to the group, the inviter will now see a "You have formed a group" message followed by a message indicating the invited player has joined.
- Group: When you kick the last player in a group instead of seeing a "You have been removed from the group" message, it will now be indicated that you have disbanded the group.

Combat Info
- Cast Bar: Added a blacklist option for the Cast Bar.
- Crowd Control Tracker: "Hiding Spot" is now localized and hidden so non-EN clients should not have a stun effect pop up for this.
- Potion Timer: Now shows Days/Hours/Minutes format for longer duration CD's such as Research Scrolls & Mementos.

Slash Commands
- Added the '/setprimaryhome' command to set the primary home.
- Added the '/eye' command and keybind to use the Antiquarian's Eye.
- Collectible usage keybinds and slash commands will now return an error when trying to use a Merchant/Banker/Fence in a player home.
- Collectible usage keybinds and slash commands will now display the collectible name that can't be used when an error occurs.
- Fixed an issue where the error alert (if enabled) for collectible usage failure when the collectible was not unlocked was missing the name of the collectible.

Unit Frames
- The Experience Bar will now show the proper color/icon for the Champion Point being earned.
- Removed a setting that toggled whether to show the max Champion Points the player/target had earned vs the amount allocated. The API no longer provides information about how many points have been allocated for targets.
- Fixed an issue where the button to whitelist Assistant names for the Pet Frames was adding "Tythis" instead of "Tythis Andromo."

---

### Version 6.2.6

General
- Added options to Buffs & Debuffs, Combat Info - Ability Alerts, Combat Info - Crowd Control Tracker, and Combat Text to use default icons for crowd control effects. This is a WIP for some of the modules as certain things require manual table data to work correctly. I will be aiming to at least add full support for player abilities.
- Reset the default color options for Buffs & Debuffs, Combat Info - Ability Alerts (Crowd Control Colors), and Combat Info - Crowd Control Tracker. This change will apply once when loading the addon and save any changes you make after.
- Components that have a blacklist/whitelist function now all have buttons with confirmation prompts to clear the entire list.
- Updated the keybindings for summoning Merchant/Banker/Fence to display a message in chat always. Previously this used the setting under Chat Announcements for collectible use messages.

Buffs & Debuffs
- Consolidated several submenus in Buffs & Debuffs.
- You can now change the container alignment of Long Term Effects & Prominent Buffs/Debuffs without reloading the UI.
- Prominent Buffs will no longer show clipping bars/labels when set to display with the horizontal method.
- Added an option to hide the display of Short-term effects on the Player/Target in addition to Long-term effects.
- Added a new "Priority Buffs & Debuffs" whitelist. These buffs & debuffs will show up with a different color.
- Added a new menu to customize buff/debuff colors, and the option to toggle coloring debuffs by CC type (Very heavy WIP since it requires manual table data).
- Fixed an issue where there was no buff icon for Argonian and Khajiit Summon Shade and its morphs.
- Updated mouseover tooltips for buffs/debuffs to reflect if they are a ground buff/debuff, or a tracker effect for an AOE cast by the player.
- Added the CC Immunity buff to Target Dummies that were missing it.

Chat Announcements
- Implemented a safeguard that should prevent a UI error from occuring when refining a large amount of crafting materials.

Combat Info
- Ability Alerts - Added an option for mitigation alerts to color the incoming ability name by its CC type. Adjusted a few menu options for syntax to accommodate for this change.
- Bar Highlight - Fixed an issue where Crystallized Shield and its morphs would throw a UI error when taking damage with this component enabled.
- Bar Highlight - Fixed an issue where the bar highlight for Argonian and Khajiit Summon Shade and its morphs didn't function properly.
- Bar Highlight - Subterranean Assault now shows a 6 second timer when cast to track the full duration of its effect.
- Crowd Control Tracker - Added new color options for Knockback & Pull/Levitate effects.
- Crowd Control Tracker - Fixed an issue where unbreakable buffs would turn from the Unbreakable Color to default CC color when the break free animation played.

Combat Text
- Reset the default bleed damage color to red. This change will apply once when loading the addon and save any changes you make after.

---

### Version 6.2.5

Buffs & Debuffs
- Optimized and reorganized the filtering code, now prominent effects will always show even when long or short-term effects are hidden.
- "Fake" buffs such as Sneak, Disguised, and Mounted can now be displayed as prominent.
- Updated the tooltips for Major/Minor Endurance, Fortitude, and Intellect to reflect their new % values.
- Updated the tooltip for Battle Spirit to reflect the changes made in the Flames of Ambition update.
- Added icons & tooltips for the new Status Effects for Physical, Bleed, and Magic Damage.
- Sneak now has a dynamic tooltip that displays the movement speed reduction and stamina cost.
- Merged the "Long-Term Effects Filters" submenu options into the "Long-Term Effects" submenu options.
- Added an option to disable the display of Short-Term Effects.
- Added an option to toggle detailed information on/off for active Non-Combat Pet buff (on by default to match previous behavior).
- Non-Combat Pet and Assistant buffs no longer display inside houses since you can't have active collectibles of this type inside a house.
- Fixed an issue where the Target Iron Atronach, Trial was displaying duplicate buffs.
- Updated tracking for Off Balance Immunity. Now you can set this as a Prominent Buff to track the effect on the player or a Prominent Debuff to track the effect on targets.
- Fixed an issue where adding/removing a buff/debuff from Prominent Effects or from the Blacklist would reset the buff container anchoring.

Combat Text
- Combat Text automatically hid some resource regeneration/drain effects that could be slightly spammy (Bull Netch for example). This is no longer the case and instead buttons have been added to the blacklist menu for class abilities that are spammy. By default the stamina drain from sneak is added to this blacklist.

Slash Commands
- Updated the /cake command to use the 2021 Jubilee Cake.
- Updated the /campaign command to work with campaigns added more recently. Thanks to TarodBOFH for discovering this issue.

Unit Frames
- Mousing over the XP Bar on the player frame will now show "Max XP" and hide enlightened status details if the player is at max Champion Points (to mimic the behavior of the default XP bar).

---

### Version 6.2.4

General
- Fixed an issue where Combat Text was throwing UI errors for Bleed abilities. I missed that a DAMAGE_TYPE_BLEED was added with this patch as a new damage type for bleeds.
- Fixed an issue where the Global Cooldown Tracking component of Combat Info was throwing UI errors.

---

### Version 6.2.3

General
- Fixed various errors related to API changes from this update.
- Attempted to fix an issue where the Combat Info Bar Highlight component threw errors when Shimmering Shield was hit on a Warden.
- Removed a hooked function for Guild Heraldry updates that had been reported to cause errors.
- Removed some unused icons and updated tooltips for most new Champion Point abilities.
- A more detailed Change Log may be released in the future. This was a quick update for Flames of Ambition.

---

### Version 6.2.2

Known Issues
- Due to API changes with Major/Minor effects the Bar Highlight component of Combat Info may have some issues tracking Major/Minor debuffs applied onto a target. In some cases they won't start tracking until you mouse off and back on to the target. This is due to some issues with the API that I hope are addressed in the future (although it may not technically qualify as a bug).

General
- Updated icons & tooltips for the new sets and Alliance War skill line consumables introduced in this update.

Buffs & Debuffs
- You can now independently control the alignment and sorting direction of each buff or debuff container. The new settings mirror the previous default settings, you may need to readjust some of these settings if you had modified them before.
- You can now independently control the Horizontal/Vertical orientation of the Long Term Buffs, Prominent Buffs, and Prominent Debuffs container. The new settings mirror the previous default settings, you may need to readjust some of these settings if you had modified them before.
- Added a new Alignment & Sorting Options submenu for the changes above to make changing these settings easier.
- Removed the display of Cyrodiil Home/Enemy/Edge Keep bonus buffs - these took up too much space and the functions used to determine/display them were inefficient.
- The toggle option for Cyrodiil buffs now only applies to Cyrodiil Scroll bonuses. Emperorship Alliance Bonus & Blessing of War will now always display (Note: The toggle setting for Battle Spirit is separate and remains unchanged).
- The options for Consolidating Major/Minor effects has been removed due to API changes to Major/Minor effect handling.
- Custom icons for Major/Minor effects from Potions/Poisons have been removed due to API Changes and the menu option for toggling these icons has been removed (Note: The option to toggle the default icons for Major/Minor Slayer/Aegis remains).

Combat Info
- Removed the "Highlight Secondary Id" option from Bar Highlight settings. This applied to all of about 2 or 3 abilities before (The magicka regen buff for Honor the Dead for example) that now always display when Highlight is enabled.

---

### Version 6.2.1

Known Issues
- Currently no chat announcement/alert will display when another player joins your group. This is due to the API Event for group members joining (EVENT_GROUP_MEMBER_JOINED) not triggering properly when players join. I've reported the issue so hopefully it is addressed by the next major game update.

General
- Added the option to mount as a passenger to the Player to Player interact wheel. I'm not sure if passenger mounts have been added onto the live server yet.
- Added a cast bar for mounting as a passenger and Crowd Control tracker will now display the stun effect if you get dismounted while riding as a passenger.

Buffs & Debuffs
- Fixed an issue where the color for the radial border of debuffs was black instead of red due to some testing I was doing and forgot to revert.
- The mounted buff has been updated to specify whether you are mounted or riding as a passenger.
- Updated the Thief Mundus Stone tooltip to reflect the reduced critical chance from the changes made in game update 6.1.6.

Chat Announcements:
- Fixed an issue where a UI error would occur when you hit Champion Level on a character with Alerts for level up enabled. Also fixed this chat announcement & alert to display the champion system icon properly.

Combat Info:
- Crystal Fragments will now only play its proc sound when the buff is initially gained and not when it is refreshed. This is due to an issue with its implementation - it can actually proc off of itself when you fire the instant cast frag but the buff is consumed during the GCD as it goes off.

---

### Version 6.2.0

General
- Additional RU translation completed thanks to FAR747!
- Updated aura tracking and tooltips for all sets and player abilities changed/added in the Stonethorn update.
- Improved the quality and added new icons for sets as well as improved many NPC ability icons.
- Improved the quality of the cast bar icons for mementos & usable items (siege, pardon edicts, etc).
- Added cast bars & icons for several item interactions (creating Psijic Ambrosia Recipe, Aetheric Cipher, Alliance Standard-Bearer's License, etc).
- Fixed an issue where some ability names in tooltips weren't punctuated properly due to the base UI string SI_UNIT_NAME being changed.

Buffs & Debuffs
- Updated the Werewolf Timer buff. It's no longer possible to determine the duration of werewolf form due to the variance in Werewolf power drain based off passives and proximity to other Werewolves - but the bar will update based on the % power value when it is set to display as a prominent buff.
- Added an aura that displays in combat when wearing Snow Treaders (only for self due to API limitations).
- Updated the tooltips for Mundus Stone buffs to have consistent syntax with other buffs.
- Updated the tooltips for Daedric Titan abilities to show the correct snare speed reduction %.
- Hid the dummy "Death Achieve Check" buff that would sometimes display on players in Veteran dungeons.
- The debug function to display combat and buff events in chat now prints out to chat normally (so pChat and other chat addons can save the messages).

Chat Announcements
- Transmutation Geodes are now added to the blacklist for Group Member Loot.
- Removed the Mercenary Motifs from the blacklist for Group Member Loot since they are no longer anywhere near as common.
- Fixed several issues with quest item added/removed messages, including fixing the messages for combining quest items to work properly.

Combat Info
- Combat Alerts: Combat alerts for nearby enemy attacks will now hide when the player is in a duel.
- Combat Alerts: Fixed an issue where the sound toggle setting for Single Target CC Abilities wasn't updating properly due to a typo in the variable name.
- Bar Highlight: Ground Mine abilities will now display a stack count.
- Bar Highlight: Added tracking support for Arena Weapon Sets where it was fitting.
- Bar Highlight: Fixed an issue where some abilities that tracked multiple effect ids weren't displaying properly.
- Bar Highlight: Fixed an error that could occasionally occur when a ground mine effect expired.

Unit Frames
- Fixed an error that could occasionally occur when a player changed their title.
- Fixed an issue where sometimes the anchored player buffs frame would clip into the extra bar (horse stamina/werewolf/siege).
- The extra bar for Werewolf will no longer show a duration remaining on the mouseover tooltip due to changes made to the skill line, and will now refer to werewolf power as "Rage."

---

### Version 6.1.2

General
- Thanks to FAR747 for doing additional translation for the RU localization!
- Updated a few icons, including a new appropriately explosive looking icon for Vicious Death.

Buffs & Debuffs
- Updated the tooltips for Battle Spirit, the LFG Buff, and Thrassian Stranglers to use more consistent syntax.
- The under level 50 player Looking For Group health & power buff is now named "Looking for Group" instead of "Looking For Group" (en localization only). I have the power to fix improper title capitalization and I will use it.

Chat Announcements
- Note: I made a discovery recently that when the pChat addon is enabled a lot of the loot chat messages that print multiple items out will get cut very short. This has something to do with the "Enable Copy" setting in pChat, disable this option in pChat if you want the full messages to show.
- When crafting items, if too many items are sent to the item printer at once (currently 12+), the message will now be replaced with "too many items to display." Otherwise the message wouldn't display at all. This is probably temporary, in the future I'd like to split the items received into multiple lines.
- Chat Printer: Added a check if the Combat Metrics addon Combat Log is enabled in order to not print messages to the CMX window if you have the "Print to Specific Tabs" option enabled.
- Indrik Feathers/Berries purchased from the Event Merchants should now display a proper collectible link in chat.
- Separated the "Mail Notifications" option in Misc Announcements into a separate option for "Send/Receive" and "Errors." Errors are enabled to print to chat by default (this alters the default UI behavior of displaying an alert in the corner of the screen).
- Added a "Stow" context option for Loot Announcements for stowing siege weapons (packing your deployed siege weapons back into your inventory).
- Added an option in Collectibles & Lorebook Announcements (enabled by default) to only display the Center Screen Announcement for books discovered if they are in the Shalidor's Library category (normal non-lore books won't show a CSA).

Combat Info
- Ability Alerts: Updated the sound options for Ability Alerts to use different specific categories to give more control over the sounds played. NOTE: This is a WORK IN PROGRESS, only overland abilities are setup for this. I'm hoping to have dungeon abilities updated for the Stonethorn update.
- Ability Alerts: Added an option to show a modifier on certain messages. Currently this is enabled by default and will add an "ON YOU!" message if something is directly targeting you. There's also a "SPREAD OUT!" modifier that will be added to AOE abilities that require the group to spread out.
- Ability Alerts: Fixed an issue where with the "Show Nearby NPC Events" setting disabled many enemy attacks wouldn't show an alert event if they were directly targeting you.
- Bar Highlight: Fixed an issue where hitting a Warden with Crystallized Shield (and its morphs) would throw a UI error.
- Bar Highlight: Added a customizable threshold for displaying decimal values for Bar Highlight timers (1-30 sec duration).
- Ultimate Percentage: Fixed an issue where sometimes when you resurrected the ultimate percentage label would show at 100% even when set to hide.

---

### Version 6.1.1

General
- A ton of additional Russian translation has been done by FAR747 including localizing pet names for the buttons in the Pet Unit Frames Options. If you notice any errors with translations, reach out to FAR747 on ESOUI!
- Added Grainy Statusbar textures to the dropdown texture options for Unit Frames (thanks to saenic).
- Updated icons/auras/alerts/etc for Volenfell as well as improved many enemy ability icons.
- The option to unlock default UI elements has been expanded with the ability to move the Alerts Frame, Compass, and Experience Bar.
- Fixed an issue where when moving the Objective Capture Meter frame, the objective fill for the frame wouldn't move with it.
- Added an option to hide ALL alerts (that display by default in the upper right corner of the screen).

Buffs & Debuffs
- Added a toggle option under Position and Display Options for showing useful raid debuffs applied by other players (enabled by default to mimic the current behavior).
- Added a toggle option under Position and Display Options for showing Major/Minor debuffs applied by other players (enabled by default to mimic the current behavior).
- Added buttons under Buff & Debuff Blacklisting to separately add Major & Minor Buffs/Debuffs to the blacklist and a button to clear all entries in the ability blacklist.
- Added a toggle option under Custom Icon & Normalization Options to use the default icons for Major & Minor Slayer/Aegis/Courage/Toughness instead of the custom LUIE icons.

Chat Announcements
- Fixed the order in which Antiquity announcements display in chat (after gold/loot but before collectibles/achievements).

Combat Info
- Bar Highlight: Expanded the ability to hide bar label fractions with an option to show fractions when the remaining duration is < 10 seconds and hide them above that duration. Thanks to saenic for implementing this feature!
- Ability Alerts: Fixed an issue where interrupt alerts weren't showing (thanks to Niobiritzu for finding this issue).
- Ability Alerts: Adjusted the alert for Boulder Toss (Ogrim) to have a slight post cast duration so it remains active while the rock hurtles toward your domepiece.
- Ability Alerts: Hid the alert for the Bear Trap dropped by some NPCs since it was pretty much pointless.

Combat Text
- Added a button to clear all entries in the ability blacklist for Combat Text.

Unit Frames
- Added a button to add all of your CURRENTLY active pets to the whitelist for pet names. This option is useful if you are using an addon like RuESO that changes the way Pet Unit Names display.
- Added toggle options to hide the Player Health Bar label and entirely hide the Player Health Bar. I don't recommend hiding the bar but you can still do it if you like.

---

### Version 6.1.0

General
- Expanded the option to unlock default UI elements and move them with more elements (Action Bar, Subtitles, Infamy Meter, etc) as well as improved the unlock functionality.
- Updated icons/auras/tooltips/etc to adjust for changes made to the Vampire & Werewolf skill lines and quests, as well as new sets & mythic items added in Greymoor.
- Updated icons/auras/tooltips/alerts/etc for the abilities used by enemies in the Greymoor tutorial area and enemies and bosses in Crypt of Hearts II.
- Updated and improved some icons for enemy abilities and player sets and improved the icons used by Sorcerer and Werewolf pets.
- Updated some player ability tooltips to account for some of the syntax changes and tooltip improvements made by game updates.

Chat Announcements
- General: Fixed an potential issue that could occur with the message printer in Chat Announcements if somehow there was a gap in the index of queued messages.
- Loot: Storage Coffer/Chest collectible items that can be purchased from vendors will now display a proper collectible link when the item is purchased.
- Loot: Fixed an issue where the "Bracket Options" setting was not properly applying to items looted by other players.
- Loot: Added an option to use the generic message color for Loot/Currency transactions that are merged (buying/selling an item).
- Loot: Added support to display a message when you list an item for sale on the guild store.
- Loot: When trading/mailing items, separate stacks of the same item are now combined into one chat message. So if you send 6 stacks of 200 weapon power potions to someone you'll now just see one chat message specifying you sent 1200 potions instead of 6 lines of 200.
- Loot: Updated the options for context messages for Potion/Food/Drink if you choose to modify them.
- Loot: Added a context message for excavating items/gold from a dig site.
- Loot: Added options to display Chat Announcements when a Recipe/Motif/Style is learned as well as an option to disable the default alert (upper right corner message) that appears.
- Antiquities: Added a menu for Antiquities, allowing you to customize the display of Chat Announcements/Alerts/Center Screen Announcements when discovering a lead. You can click on the Antiquity links from Chat Announcements to open the Codex entry for them.

Combat Info
- Bar Highlight: Added the option to display the backbar for Bar Highlight Ability Tracking with several customization options.
- Bar Highlight: Added a stack counter to tracked abilities.
- Bar Highlight: Cleaned up the backend for Bar Highlight tracking, and the highlights now sync with the flipcard animations when bar swapping, making everything look a little smoother.
- Bar Highlight: Tracking for Sorcerer - Bound Armaments now just shows the duration of the overall buff instead of the 10 sec stack duration making it easier to follow.
- Bar Highlight: Tracking for Warden - Crystallized Shield (and its morphs) now track stacks.
- Ultimate Tracking: The ultimate tracking percentage label will now cap at 100% value, and both the value and percentage labels and will update when your Vampire Stage changes or when you change your equipped gear (in case you equip/unequip a set that reduces ultimate cost).
- Ultimate Generation: Fixed an issue where the Ultimate Generation texture sometimes wouldn't display when you were generating ultimate.
- Combat Alerts: Added a context message for "Hard CC" for the interrupt notification for abilities that can only be interrupted by hard crowd control effects.

Unit Frames
- The option to move default Unit Frames up/down is now independent from the option to set them to display in a pyramid mode and both of these options now update on the fly rather than requiring a /reloadui.
- Added a new menu for Player & Target - Bar Fill Direction in Unit Frames allowing you to choose the direction the bars fill from. This allows you to have the bars behave more similarly to the default frames.
- Added an option to the new menu to set the value label for player/target frames to display in the center of the bar instead of having a right and left label.

Slash Commands
- Added a slash command and keybinding option to dismiss Sorcerer and Warden pets.

---

### Version 6.0.9

General
- NOTE: Currently no changes have been made for LUIE Components for the new Vampire Skill Line, Werewolf Skill Line Changes, or any new sets & mythic items added with this update. Buffs & Debuffs will not have custom icons or tooltips, Vampire Abilities won't be correctly labeled for the purpose of hiding them in the menu settings, and Bar Highlight/Cast Bars for new vampire/werewolf abilities are not implemented. Implementing everything listed here will be the priority for the next update.
- Updated tooltips & auras for all item sets & monster helms changed in this update as well as updated custom icons for some sets.

Buffs & Debuffs
- Added support for new potions/poisons added in Greymoor & fixed an issue where the tick rate was not displaying correctly in the tooltips for damaging potions and poisons.
- Temple Guards in Cyrodiil now show the correct faction specific icon for their Stealth detection ability.

Chat Announcements
- Added options in the menu to display when items are used/lost for: Potion, Food/Drink, Repair Kits/Siege Repair Kits, Soul Gems, Siege Deployment, misc items such as Keep Recall Stones, and items turned in for quests.
- You no longer need to toggle on "Display Item Loss - Destroyed Items" to show other types of messages related to inventory items being lost/used/etc.
- Fixed a longstanding issue with the "Display Materials Used" crafting loot option. This will now show the correct item when an item is pulled from the inventory instead of the craft bag.
- Messages for crafting materials used will now merge quantities in the case of separate stacks or items being used from multiple bags. For example if you use 30 ingots, 10 from the bank, 10 from inventory, and 10 from the craft bag - they will now just show as using 30x ingot.
- Loot messages displayed for items being crafted/deconstructed will now merge stacks instead of displaying individually. For example if you create 10 Iron Battle Axes, you'll now see "You craft [Iron Battle Axe] x10" instead of 10 individual comma separated items.
- Added support for any addon that uses LibLazyCrafting (Dolgubon's Lazy Writ Creator, etc) for crafting messages. You will now see item messages labeled correctly as crafted/used regardless of what tab of the Crafting interface you are on.

Combat Info
- Updated icons & cast bars for deploying new Siege Weapons.
- The cast bar for deploying siege will now break when you tab in and out of the game or open an ingame window (inventory, character screen, etc).
- The cast bar for stowing siege weapons now breaks if you exit siege mode in the middle of the cast.

---

### Version 6.0.8

General
- Updated icons/tooltips/alerts/cc tracker/etc for Elsweyr Tutorial, Stros M'Kai and most of Betnikh.
- Fixed an issue with the Loot History window displacing when you unlocked and moved its position.
- Fixed the UI error thrown when trying to reset movable base game UI elements to their default position.
- Fixed an issue where when learning skills with a non-english localization the names would not properly format and show ^f and ^m tags.

Chat Announcements
- Tweaked a few minor ordering issues with quest update message chat announcements.
- Added some additional conditional messages for quest item acquisition/usage.

Combat Info
- Fixed an issue with the Dampen Magic ability used by some NPC casters throwing alerts every time the shield refreshed (whenever the shield took damage). It will now only display an alert on cast.

Unit Frames
- Fixed an issue where the confirmation messages for adding/removing pets to the Whitelist referred to it incorrectly as the "Pet Blacklist."

---

### Version 6.0.7

Unit Frames
- Switched Pet Unit Frames to use a whitelist instead of blacklist. You must add pets to the whitelist in order for them to show up. By default no entries are added here.
- Added five buttons to add specific pets to the whitelist - Necromancer, Sorcerer, Warden, and Item Set Pets, as well as Assistants.
- Added a button to clear the entire whitelist.

---

### Version 6.0.6

General
- Updated the icons for Flying Immunites, Boss Immunites, Major Vulnerability Immunity, Off-Balance Immunity, Minor Toughness, as well as the icons for Major and Minor Aegis, Slayer, and Courage.
- Added an option to the base LuiExtended menu to unlock several default UI elements - Quest Tracker, Battleground Score, Loot History, and Equipment Status.


Buffs & Debuffs
- Housing Target dummies will now display a "Boss Immunities" buff.
- Added a "Custom Icon & Normalization Options" menu to Buffs & Debuffs. Added 3 individual options in this menu that allow you to toggle the custom icons for potion/poison/status effects that have a major/minor effect with the major/minor effect icon. The option for poisons is enabled by default.

Chat Announcements
- Added an option to display "Container" loot messages in Chat Announcements when you empty a container item in your inventory and it is removed.
- Fixed some minor timing issues with the Chat Printer (the chat printer operates on a 50ms throttle to allow any event messages to be properly ordered - some events don't properly line up so they now delay the printer slightly so all queued messages display simultaneously.
- The throttle settings for Tel Var Stones no longer apply to stones when looting them from a chest/container.
- Achievement Tracking Categories are now hardcoded into the menu so I don't have to update the categories with each game update. This will cause these settings to reset for anyone who modified them.
- Added an option to always show the Center Screen Announcement for Achievement Completion even if you have the category filtered out. This is how Achievement Tracking worked before this option was implemented - so it is enabled by default.

Slash Commands
- Using the /friend Slash Command now displays a prompt confirming the name entry & allows you to type a note to that person.

Unit Frames
- Unit Frame names will no longer abbreviate to "..." when cut off and will now truncate instead. This allows for better use of the frame space.
- Added resurrection monitoring status to Group & Raid Unit Frames - now you will be able to see when a target is being resurrected, has a pending resurrection, or is self-reviving. This label updates dynamically and replaces the "Dead" label when one of these conditions is met.
- Updated the right click handler for custom Group Unit Frames to allow you to request to add the player as a friend.
- Increased the default Raid Frame width by 20 units. This won't modify your current settings.
- Added Unit Frames for pets - with a new color option for the pet bar and the option to color the bar by your Class color.
- Added a name blacklist for the new pet frames. Entering a pet name (not case-sensitive) will hide it from displaying on your UI.

---

### Version 6.0.5

General
- Updated icons, tooltips, alerts, and cc tracker for several dungeons (EH I & EH II, COA I & COA II, and Tempest Island) as well as a multitude of monster attacks.

Buffs & Debuffs
- Fixed an issue where the default tooltips for abilities weren't displaying in the Active Effects Window on both the keyboard and gamepad UI.

Chat Announcements
- Added a workaround for duplicate Quest Accepted messages displayed in chat if enabled when using Dolgubon's Lazy Writ Crafter.

Slash Commands
- Updated the /cake command to summon the 2020 anniversary cake and updated the icon. Too little too late at this point.
- Slash Commands are no longer set to nil when disabled in the options menu, this means you will need to reload the UI when disabling slash commands you don't want to use. This is to stop LUIE from removing commands if another addon also adds the same slash command with similar functionality.

---

### Version 6.0.4

General
- Updated icons, tooltips, alerts, and cc tracker for Crypt of Hearts I.
- Updated and added a good chunk of improved custom icons.

Chat Announcements
- Fixed an issue where Friend logon/logoff messages would duplicate when using pChat, now my tatsumaki is more powerful.
- Fixed an issue where the Center Screen Announcement for completing a lore collection for a zone that resulted in Mages Guild reputation gain would throw a UI error & fixed an issue where the Chat Announcement for this event had an icon that was colored by the default system text color.

Combat Info
- Fixed an issue where the fallback font variable was misnamed. This could cause the addon to fail to load if for some reason the selected font wasn't found.
- Removed a debug line from Ability Alerts that could display when enemies used abilities.

---

### Version 6.0.3

Slash Commands
- Fixed an issue where using the /fence Slash Command or Keybinding would throw an error.
- When summoning a banker, fence, or merchant with the keybinding, your Chat Announcement setting will now determine if a feedback chat message is displayed. Note that using the slash command will still always return feedback into chat.

---

### Version 6.0.2

General
- Added a keybinding option for "Leave Group."

Chat Announcements
- Restored the ability to print chat messages to specific chat tabs.
- Removed the "Enable pChat Message Saving" setting and replaced it with an "Allow Addons to Modify LUIE Messages." It has the same functionality but is disabled by default. This setting can always be enabled now instead of toggling off when selecting the option to print to specific chat tabs (it still won't effect messages printed to specific tabs but will handle system messages if you choose to print those in all tabs).
- Fixed an issue where having LibChatMessage enabled would bypass some Chat Announcements toggle settings, the most common being friends logging on & off. Now if you choose to disable these messages, they will cease to display properly.
- Fixed an issue where promoting a player to group leader or being promoted to group leader sometimes wouldn't properly show the promotion chat message/alert.

---

### Version 6.0.1

General
- Fixed an issue with the Crowd Control Tracker where "Player Set AOE" was using the setting for "Player Ultimate AOE."
- Fixed an issue where the keybinding options for Summon Banker/Merchant were reversed (Banker key summoned Merchant and vice versa).
- Fixed a few strings missing from the German translation.

---

### Version 6.0.0

General
- DE translation has been started and populated thoroughly thanks to AmonFlorian!
- Added keybindings to summon the new Cat Banker/Merchant from the crown store.
- Updated tooltips, auras, icons, etc for player ability and set changes in Scalebreaker, Dragonhold, and Harrowstorm, as well as did a pass on the tooltips for all of these abilities to update and add range, normalize syntax, etc.
- I purchased a large amount of icons for use from various game development platforms such as the Unity store, this means I will be significantly improving the quality of all custom icons. A good deal of new work as been added with more to come. Credits for custom icons listed at the bottom of the changelog.
- Attacks sourced from Morkuldin will now properly show the localized name "Morkuldin" in death recap.
- Perfected Weapon effect auras, damage, resource restore etc no longer have a "(Perfected)" tag on the end. Some set names were getting a little too long on Combat Text.
- Dark Shade and its morphs now have proper names in Death Recap instead of "Gloom Wrath" (this is the actual name of the pet NPC you summon with Dark Shade + morphs, hopefully ZOS will update it at some point).
- Added the "Forced Square" font into the list of fonts to choose from for LUIE components. Thanks nomaddc!
- Added a function that allows all of LUIE's component frames to be hidden. I did this with support in mind for Essential Housing Tools (and potentially any other addon that makes significant changes to scene display).
- Hooked into the Keep Upgrade interface in Cyrodiil (in Keyboard and Gamepad mode). Improved the icons & tooltips as well as tooltip formatting for this menu.
- Hooked into the Campaign Bonuses tab in the Campaign Browser (in Keyboard and Gamepad mode). Improved the icons & tooltips as well as tooltip formatting for this menu.
- The character "Active Effects" Window in gamepad mode will now display updated tooltips properly.

Buffs & Debuffs
- Prominent Buffs can now be sorted horizontally in addition to the default vertical setting. May still need some testing. Thanks to AmonFlorian!
- Added an option to display the Ability Id & Buff Type of auras in the tooltips submenu for Buffs & Debuffs.
- Improved Tooltip formatting & extended this formatting to the character "Active Effects" Window.
- Updated the icons for all player weapons attacks to be better quality.
- Updated various icons for sets and attacks to be better quality.
- Updated the icons for many NPC attacks to be far better quality.
- The Iron Atronach Target Dummy nows shows a "fake" debuff icon for Minor Magickasteal (ZoS implementation of this debuff is inconsistent and this one was not showing).
- Added functionality to pull the info from a skill morph for some passive abilities that have shared auras. For example: the Minor Effects from Restoring Aura / Radiant Aura will now show their proper source.
- Updated the tooltips for Dawnbreaker, Beast Trap, and Roar of Alkosh to no longer refer to their damage over time component as "Bleed" damage, as these effects are not considered a bleed effect.
- The stun from the Warden's Feral Guardian + morphs now shows for the player (and other players too since it's pet and not player sources), but at least it can be seen now.
- Removed the menu option for tracking the Sprint/Gallop buff for now - the new method ZOS is using doesn't return an abilityId in game.
- Previously I had changed a lot of NPC uppercut abilities to use the name/icon for Dizzying Swing to stay consistent with how its mechanics work. However, now that the stun has been removed from Dizzying, I'm just reverting this to their default (and fixing missing icons/etc where need).
- The Warden ability Crystallized Shield and its morphs now display the stacks of reflection charges remaining and track the actual duration. This is done by showing the effect that was some reason hidden by default and hiding the default dummy tracker buff.
- Some buffs & debuffs were not able to be blacklisted (due to being "fake" effects) created using Combat Events instead of Effect Events. Added blacklist support for these auras.
- Stone Giant's "Stagger" debuff will now show for all players on a target since it effects everyone attacking the target, and any Dragonknight can contribute to refreshing the stacks.
- When the werewolf transformation timer is added to prominent buffs, it will now display the timer bar properly.

Chat Announcements
- Print Chat to multiple tabs is disabled currently due to significant changes that were made to the chat API - will hopefully be reimplemented in the future. You can still toggle timestamps for LUIE messages on/off.
- Added additional achievement tracking categories for the new DLC.
- Added a submenu into Collectible Options to enable the display of a chat message or alert when a Collectible in the Vanity Pets, Assistants, Ability Skins or one of the Appearance Changes is used.
- Added support for Undaunted Keys fors currency and loot tracking.
- Fixed some issues with/updated the way VENDOR loot works with the merged messages option selected. Now if you choose to display total currency/total loot it will always display regardless of your individual selections in the other menus. This is so if you want to see totals indepedently on vendors but not when looting (or vice versa) you can.
- Added a 1000 ms delay on resetting the variable that determines if the player is currently browsing a store. Depending on latency its possible to purchase items from a vendor and then close the window before a response from the server places the items in your inventory. When this happened the items would appear as looted instead of purchased. This throttle should stop this from happening.
- Fixed an error with the messages displayed for absorbing skyshards due to the function not being updated with the API changes made in Dragonhold. Thanks AmonFlorian for making this change.
- Updated the quest item added/removed loot tracking to have more syntax options for things like turning in quest items, discarding them, etc. Some of this is automatic and some requires manual input so it will take a while before everything works perfectly.
- Updated many handlers for various Chat Announcement components for API changes made over the last couple years. I will be adjusting these on each update in the future instead of letting myself get behind. A few things that weren't working should be now.
- Added some new support to changes made to the Guild API (when roster was added). Guild rank changes will now display with better information thanks to some new events added in the API.
- Did a pass on the Group Finder chat announcements. The event sequence for group finder is an absolute chaotic mess, but from my testing done on the PTS everything appears to display cleanly, with proper alerts for leaving/entering queue, ready check failure reasons, and entering an LFG activity. I have to hide all group events when an LFG group forms because a mess of party leaving/joining/leader changing happens during it. Hopefully with live server lag during busy times this will still function properly.

Combat Info
- Implemented the features of Miat's Crowd Control Tracker into LUIE (with permission, thanks to dorrino!). This version of the crowd control tracker is enhanced with several new features.
	- Display a different border color based on the type of CC applied (including unbreakable cc).
	- Choose a custom sound to play when effected by CC.
	- Display an alert when standing in hostile AOE effects with various toggleable categories and different sounds options for each. This list requires manual input but I have player skills added, most overland mobs and have at least made some progress adding dungeon/arena abilities.
- Updated many abilities in Combat Alerts with better duration tracking and proper CC types.
- Bar Highlight tracking now supports tracking multiple ability id's, resulting in the ability to track ground mine durations & their effects individually and to track both the physical & magical dot from Soul Trap and so on.
- Updated Bar Highlight tracking to handle API changes made in Scalebreaker. The bar highlights were being refreshed too quickly which could lead to performance issues and resulted in a stuttering effect occuring on the "proc" animation highlight.
- Added a few checks into bar highlight tracking to potentially stop errors from being thrown occasionally.
- Bound Armaments now plays a proc alert upon reaching 4 stacks (and will play the proc animation at any number of stacks).
- Procs that change the ability on your bar (Grim Focus, Power Lash for example) will now have a 3 sec iternal cooldown for playing the proc sound, this way the sound doesn't spam if you swap targets or bar swap.
- Updated the "Absorbing Skyshard" cast bar to use a new icon added in U24.
- Toggling the LUIE ultimate tracker on disables the default UI ultimate tracker to stop overlap from occuring.
- The ability alerts component has had some functionality updates. These are mostly backend feature changes that allow me to get around some of the limitations of the API to display better sources for effects that don't provide them etc, by using manual values.
- Made some changes to interrupt detection for the cast bar due to changes due to API changes. The castbar should now cancel when the player bashes or blocks if those actions can break the cast (Harrowstorm added the ability to bash the air to interrupt channeled effects).

Combat Text
- Fixed an issue where the font selection wasn't working properly and would always use the default game font.
- Combat Text font selection is now sorted alphabetically like most other long dropdown selections.
- Added a slider to control the speed of Combat Text, thanks to AmonFlorian!
- Added an ability blacklist menu to Combat Text. This functions in the same way as the Buffs & Debuffs blacklist - you can blacklist by AbilityId or AbilityName.
- Fixed an error where the setting for Throttling Critical Hits was being reset when the setting for Throttling normal hits was toggled.
- Throttle for Critical Hits menu option is now disabled when Throttle for normal hits is disabled.

Slash Commands
- Added a menu option to choose between the old banker/merchant or the cat banker/merchant for their respective slash commands.
- Any slash command that uses a collectible will now display a message in chat when the collectible is summoned or unsummoned.

Unit Frames
- Toggling the LUIE overlay on for default unit frames now disables the default UI unitframe text menu option to stop overlap from occuring.

Art Assets
- Custom Art Assets by and modified from J. W. Bjerk (eleazzaar) licensed under the CC BY 3.0 license (https://creativecommons.org/licenses/by/3.0/)
- Custom Art Assets by and modified from AKiZA, Angelina Avgustova, Blade Dancer, ClayManStudio, Cool Art, Dayed, Digital Worlds JSC, Ever Probe, HOSE, Jon Snow, Josch, Kalle Olli, Little Sweet Daemon, MiDaEm, Moon Tribe, N-hance Studio, PONETI, REXARD, Sky Painter, The 7 Heaven, TiGame, and TonityEden licensed under the Unity Store single entity license. (https://unity3d.com/legal/as_terms)
- Custom Art Assets by and modified from a-ravlik, Horski, and micart licensed under the GraphicRiver regular license. (https://graphicriver.net/licenses/terms/regular)
- Custom Art Assets by and modified from damnwing, Forrest Imel, Frostwindz, and Ruixi licensed under the GameDevMarket.net pro license. (https://www.gamedevmarket.net/terms-conditions/#pro-licence)
- Custom Art Assets by and modified from Combo 21 licensed under the construct.net asset license. (https://www.construct.net/en/game-assets/asset-licenses)

---

### Version 5.9.4

General
- Fixed an issue where initiating a vote kick on a party member in LFG through the Player to Player interaction menu would throw a UI error due to referencing a renamed function.
- Fixed an issue where recieving Crown Store gifts through the Notifications prompt would cause a Protected Call error. Unfortunately this means accepted/declined response text from sending various invite types to the player will no longer work. I'll have to find another way to handle this in the future.

Buffs & Debuffs
- Updated the auras/icons/tooltips/bar highlight, etc for all Necromancer skill line active and passive skills.

Chat Announcements:
- Fixed an issue where inviting a player to the guild would display duplicate Guild Member joined messages (since the player invited is added to the roster). Thanks to Eearslya Sleiarion for this fix!
- Updated the currency announcements to correctly display "Earn" context message for Defensive Keep Ticks.

Combat Info
- Updated a significant amount of enemy abilities for Active Combat Alerts (more alerts now show the correct cast time and cc type).

---

### Version 5.9.3

General
- Fixed a missing local in Hooks.lua & adjusted the load order in order to fix an issue wcausing Friend Invites to throw a UI error.
- Death Recap will now show a source for some environmental effects that used to display with no source (a good example is some variants of traps in areas would source the damage they deal from the player instead of the trap).

Buffs & Debuffs
- Updated icons, auras, and tooltips for the remaining item sets added with Elsweyr.
- Updated MOST icons, auras, tooltips, and bar highlight for Volendrung artifact weapon abilities. Still missing any effects not present or usable in the tutorial quest.
- Updated icons, auras, tooltips, and bar highlight for the Grave Lord Necromancer skill line.
- The Crusher & Weakening Glyph debuffs will now show for all players on targets regardless of who applied it.
- Removed some code used to create a fake "Home Keep" buff for players in Cyrodiil due to the changed in Elsweyr showing a proper buff again.
- Added icons/tooltips/alerts for Boss Wamasu in Craglorn.

Chat Announcements
- Updated the Achievement Tracking options with the missing category added with Elsweyr.

Combat Info
- The option to display the global cooldown on abilities when used now only hooks the default UI when enabled. If you disable this component and prefer to use another addon for handling the GCD, it is now possible.
- Fixed a few missing strings for the default variables for Combat Alerts. These default variables have been adjusted to automatically replace the settings that were incorrect.
- Combat Alerts now fade out over 1 sec when the effect ends for a cleaner appearance.
- Combat Alert cast/channel time tracking has been updated to be more accurate.
- Updated the Cast Time & CC type of many alerts. This is still a work in progress, unfortunately the majority of channeled abilities in game don't provide the correct duration in the API settings so I have to check them manually which is rather time consuming.
- Added basic support for interrupt detection for Combat Alerts. This doesn't work in all situations, anything not directly targeting the player or creating a buff effect doesn't provide enough information to determine if an ability was interrupted.

Combat Text
- Added two toggles to show Overkill/Overhealing in the Common Options menu of Combat Text. These are enabled by default, resulting in damage/healing being displayed the same way it was before the API changes made with Elsweyr.

Unit Frames
- Added an option to swap the position of the Stamina & Magicka Bar when using the Pyramid or Separate Frames option. Contributed by Eearslya Sleiarion, thanks!

---

### Version 5.9.2

General
- Removed LibStub dependency since it is embedded in both libraries LuiExtended depends on.
- Fixed an issue with the function that loaded LMP that could cause UI Errors.
Buffs & Debuffs
- Fixed an issue with the Werewolf Buff Icon Option that would cause UI errors when you died in Werewolf form.
Combat Info
- Added localization and updated tooltips for some of the menu options for Combat Info Alerts.

---

### Version 5.9.1

General
- Removed embedded libaries, you will now need to download LibAddonMenu and LibMediaProvider separately.
- Fixed an issue where LUIE wasn't dependent on LibStub which could cause the addon not to load correctly.
Buffs & Debuffs
- Fixed an issue where a missing variable was causing the "Show Icon for Active Assistant" option to throw UI errors.
- Added custom icons for a few sets added in Elsweyr.

---

### Version 5.9.0

General
- Streamlined and updated some code present in modules, which probably won't be noticeable at all but may cause a slight performance increase.
- Russian translation updated thanks to @amanozako

Buffs & Debuffs
- Added an option to toggle whether detailed tooltips display on mouseover and to assign a "sticky tooltip" duration to stop them from fading instantly when mousing off.
- Updated tooltips, auras, icons, etc for all player abilities & sets changed in Elsweyr. New sets/Necromancer abilities are not done yet.
- Updated auras for various shared vanilla dungeon boss abilities as well as updated specific auras in Elden Hollow II, Banished Cells I & II, and Spindleclutch II
- Updated auras for DSA Normal and Stage 1 & 2 on Veteran.
- Updated auras for Maelstrom Arena Stage 1-5 on Normal & Veteran.
- Added an icon for the Daedric Titan ability "Swallowing Souls" that is cast when you interrupt Soul Flame.
- Can now add Werewolf Timer to prominent buffs.
- Can now blacklist Home & Edge Keep Bonus buffs.
- Fixed an issue where UI errors would appear when wearing the Dunmer Cultural Garb disguise or when wearing a Guild Tabard when doing the Arenthia questline in Reaper's March.
- Roll Dodge Fatigue now displays stacks each time you roll dodge, and specifies it costs 33% more per stack in the tooltip.
- Bolt Escape Fatigue tooltip updated to indicate more clearly that the cost is increased by 50% per stack.

Combat Info:
- Added a new Combat Alerts component, this is a revamp from the Combat Text alerts moved into this component.
- New combat alerts now throttle by 50 ms in order to filter out dummy/bad events (out of range, etc) to prevent possible spam.
- New combat alerts have the option to display a sound, a countdown label for the cast time of the ability, as well as color the icon border based off the type of CC the ability applies.

Combat Text:
- Fixed an issue introduced on the PTS due to EVENT_ACTION_SLOT_ABILITY_SLOTTED being removed.
- Removed the Combat Alerts menu and settings, this component has been updated and moved to Combat Info.
- Due to the above change, the "Always Hide Ingame Tips" option has been removed. You can now toggle on/off the display of ingame tips independently from LUIE's combat alerts.

Unit Frames:
- Added class color option for Necromancer class.

Known Issues:
- Some food tooltips may not be right (ZoS hasn't updated them). If they are not fixed with the live update of Elsweyr I will adjust them.
- Most combat alerts don't have a timer added yet nor do they show the type of crowd control incoming as this must be done manually on my end.
- I haven't had the chance to sort through Necromancer abilities yet so Combat Info Bar Highlights may not be working/accurate for all abilities.
- The menu options for Combat Info - Active Combat Alerts are still work in progress and not localized for RU translation.
- The timer bar for the Werewolf buff indicator if you add it to prominent buffs does not work correctly.

---

### Version 5.8.1

General
- Added updated auras for more dungeons - Elden Hollow II, COA I & II, Tempest Island, Selene's Web, and Spindleclutch I & II and updated a few various icons for enemy abilities.
- Fixed a bug where LUIE was causing Guild Trade search history to not display correctly, thanks to scorpius2k1 for discovering the source of the issue.
- Updated the Changelog to no longer use LibMsgWin, it now uses much simpler and clean xml code to generate the log, thanks to psypanda.

Buffs & Debuffs
- Buff sorting updated - Now buffs will sort Toggle > Ground/Unlimited Duration > others and those will all sort alphabetically relative to their categories.
- Lots of various table cleanup and minor optimization.

Chat Announcements
- Fixed an error that could occur when crafting items when switching between crafting tabs with items queued in Multicraft or with other addons like Dolgubon's Lazy Writ Crafter. Note the chat log output may not be correct when this happens - but it should no longer cause a UI error.
- Fixed an issue where the Quest Items in your inventory would display [Received] messages when you log into a character for the first time. While the UI does send the events for this, LUIE just ignores it on login now.

Combat Text
- Updated filtering for combat alerts, there should no longer be duplicate alerts displayed from the same ability.
- Added a new option for Alerts to display Unmitigatable Effects - was prompted to do this by a few dungeon abilities that you can't avoid.

Slash Commands
- Added new commands for /cake (/anniverary), /pie (/jester), /mead (/newlife), and /witch (/witchfest) to use the Event XP Boost mementos.
- Added the /report 'name' command - which open the "Report a Player" window and autofills it with useful information.

---

### Version 5.8.0

General
- Updated auras/icons/tooltips/cast bar/etc for all Player Abilities, Siege Weapons/Repair Kits, any missing & new item sets.
- Updated auras/icons/tooltips/combat alerts/etc for almost all basic NPC abilities, and started working on Dungeon abilities.

Buffs & Debuffs
- Prominent Buffs will now display even when ALL OTHER BUFF/DEBUFF options are turned off. This was always the intended behavior, but was not working due to a massive oversight on my part.
- Added a new toggle option for Ground Damage/Healing Auras - when enabled a debuff aura will be displayed when you are standing in a ground aoe effect (e.g. Arrow Barrage)
- Fixed an issue where dropping a new rearming trap after only 1 of the 2 traps was consumed would result in two mine auras showing.

Chat Announcements
- When looting multiple bodies at once - multiple items with the same ID are now combined into a single count. This significantly reduces the amount of spam loot logging generates.
- Updated the Achievement Options with the new category added in Wrathstone and fixed an issue where only some categories would toggle off correctly.

Combat Info
- Cast Bar - The cast bar will now automatically break when certain actions are taken, such as roll dodging.
- Cast Bar - Added functionality to break the cast bar on movement for casts where this happens, as well as fixed various issues with the cast bar not refreshing when interrupting your cast & attempting to recast before the bar finished.
- Ability Bar - Updated the default "Activation Highlight" effect (e.g. Shadow Image Teleport) to now loop the visual effect on the bar rather than playing only once.
- Ability Bar - Guard and its morphs now display the Toggle Highlight visual effect used by other toggle effects (e.g. Mend Wounds) when active instead of just turning into an "X" icon on the bar.

Combat Text
- Updated Combat Alerts to work toward making them less spammy (requiring specific criteria for each ability when cast, and applying a refire delay when various error events such as an NPC being out of range are detected).
- Added "Summon" alerts to Combat Alerts - notifying you if an enemy summons an add.
- Fixed an error where the Interrupt message on Combat Alerts was displaying as "01Interrupt" due to a syntax error in the default color.
- Hid a few snares that rapidly refire from ground auras or other effects that would result in spam when you were immune to them.

Unit Frames
- Fixed an issue introduced on the PTS where Player Names on the Group Unit Frames were being displaced from their proper positions.

---

### Version 5.7.3

General
- Significantly updated the Russian localization, as well as fixed an error causing RU strings not to load at all. Thanks KiriX!

Buffs & Debuffs
- Updated tooltips & some auras/icons for all Weapon, Armor, Soul Magic, and Werewolf Skills.

Combat Info
- Fixed a few abilities that had broken Bar Highlight functionality and did some minor cleanup with this functionality.

---

### Version 5.7.2

General
- Fixed typos in the RU localization that was causing UI errors. Thank you Jmopel for fixing this!
- Fixed an issue with the hook for the Skill Window to add custom passive/racial icons that prevented Harven's Improved Skills Window from working correctly.

Buffs & Debuffs
- Added tooltips for all Warden abilities & for melee weapon abilities.
- Fixed broken tooltips on Stealth-Draining / Conspicuous Poison.
- Added an aura for the new ID used for Dismount Stun.
- When "Hide Duplicates in Paired Auras" is toggled in SCB, the Active Effects window on the character screen will also hide the auras.

Chat Announcements
- Occasionally "Champion Point Gained" Center Screen Announcements can trigger at the same time, causing the output to display the wrong Champion Points gained. Added a small throttle to prevent this.

Combat Info
- Added a redundant check in Combat Info to stop possible duplicate controls for Bar Highlight from being created and throwing UI errors.

Combat Text
- Reset the "Interrupt" notification color due to a formatting error that occured.

---

### Version 5.7.1

Unit Frames
- Fixed an issue where the default Player / Target / Group frames would fail to display even when enabled in the menu. This setting has been updated and the Saved Variables have been reset. Default Frames will be disabled by default and can be re-enabled by changing the menu option.

---

### Version 5.7.0

General
- Did some various minor optimization, removing some old and un-needed functions and adjusting a few functions that were enabled all the time to only be used when relevant options are enabled.
- Fixed font paths for non-English localizations.
- Updated Russian localization with many new translations from KiriX. Thank you!
- Fixed an issue where the new icons added for Cyrodiil Campaign Bonuses were clipping through the rounded frames in the Campaign Window.
- Reimplemented custom icons in the Skills Menu & Skills Advisor for Racials & Various passive skill lines.

Buffs & Debuffs
- Fixed an issue where the Mount icon wouldn't disappear when dismounting in any other way than pressing the mount key. This is due to an issue with the API that should be addressed in a later ESO update.
- Fixed various minor issues with buffs & debuffs from changes made in the Wolfhunter & Murkmire updates.
- Updated tooltips for Champion abilities.
- Updated icons, tooltips, and names for Seasonal Items, Seasonal Experience buffs, and mementos.
- Updated the names & tooltips of various food and consumable items by using the Item Names and Item Descriptions from these items.
- Added duration into most toolips and updated the functions used for this to pull accurate values.
- Updated tooltips for almost all item sets (missing Rewards for the Worthy Sets) and all Classes except Warden. Other skill lines will be processed in the future.
- Added a timer to the "Battleground Deserter" debuff - and moved it into the long term effects container if enabled.
- Started adding support to add a "G" label on any buff/debuff effect that is applied while the player is standing in a ground AoE effect. This is only implemented on some abilities but will be expanded in the future.
- Fixed an issue where some undispellable debuffs (read by the game API as buffs) weren't set to debuffs in the Character Screen Active Effects Panel.
- "Crystal Fragments Proc" has been renamed to "Crystal Fragments." If you are tracking it by name in a prominent container you will need to update the name. The abilityId remains unchanged.
- Fixed an issue where Prominent buffs with an unlimited duration would duplicate auras when you zoned into a new aura.
- Added fake buffs for Home Keep Bonus & Edge Keep Bonuses to Player/Target when Cyrodiil Buffs are enabled.

Chat Announcements
- Added currency message options for Event Tickets.
- Fixed an issue where sometimes when rapidly looting/stealing items the message context would switch back from looted/stolen to "received."
- Fixed an issue causing Tel'var Stone and Alliance Point transactions not to display the amount of currency spent with the merged message option enabled.
- Updated Alliance Point throttle to include AP earned from Keep Repairs & Resurrecting Players.
- Added a note to specify that the "Show Used Crafting Items" option in Loot Announcements doesn't work properly without ESO Plus.
- Fixed achievement tracking categories missing with the Murkmire update.
- Fixed a UI Error that would occur from Disguise Alerts during "The Colovian Occupation" quest in Arenthia in Reaper's March. This quest puts you into a disguised state without an item in your disguise slot which was causing errors.

Combat Info
- Added a cast/channel bar for various mementos (replacing the icons that showed on buffs & debuffs previously).
- Added a cast/channel bar for some seasonal quest events & items (replaced the icons that showed on buffs & debuffs previously).
- Fixed an issue causing Crystal Fragments proc not to play a sound or be tracked.
- Fixed a few missing Bar Highlight trackers.
- Fixed an issue introduced with Murkmire where Bar Highlight & Ultimate Tracking was not behaving properly due to relying on a function no longer used by the API.
- Dragonknight: Updated the icon for Power Lash to stand out a little more from Molten Whip.
- Nightblade: Shadow Image now has a unique icon (with similar colorization to the new green color for Incapciating Strike when the player is above 120 ultimate).
- Nightblade: The Proc Icon for Grim Focus and its morphs now shows the remaining timer for Grim Focus on it.
- Sorcerer: Unstable Familiar & Summon Winged Twilight abilities now use different icons on their bar/for their effects. The icons matching the base icon are ingame but for some reason not used.

Combat Text
- Added an option to display Group Member Deaths (enabled by default).
- Updated the variable names for Incoming Ability Alerts - this will reset the color for Block, Dodge, Avoid, and Interrupt notifications. In a previous update Combat Alerts were changed to support multiple colors for the different alert mitigation types to improve clarity - this resets this for anyone who wasn't aware as well as adds a blue color for interrupt instead of white.

Info Panel
- Info Panel no longer shows on all screens (Now hidden in menus, on the world map, and during dialogues).
- Added an option to enable the Info Panel on the World Map Screen.

Unit Frames
- Added Resolution Selection options to UnitFrames, this changes the default anchors for UnitFrames.
- Updated UnitFrame default positions to anchor relative to the center of the screen rather than top left.
- If you are installing the addon for the first time or clearing saved variables - the default unit frames are now disabled by default.
- Added a "Disable" option to Default Group Unit Frames. It was confusing not being able to set this to disabled before if you were using Custom Group/Raid Frames.
- Added an option to toggle off the Default Compass Boss Bar.
- Added target Rank Stars to elite enemy NPC frames - this will show 1-3 stars based on the difficulty of the elite mob you are fighting - similar to the default boss/target frames indicators.
- Updated Group/Raid frames to follow this functionality described in the Custom Raid Frames description: "If custom group frames are unused, then this raid frame will also be used for small groups."
- Added an option to color the Target Frame by Player Class - this option takes precedence over Reaction Colors when both options are enabled.
- Fixed an issue where Group/Raid Frames didn't color correctly when no role was detected (in Battlegrounds).
- Fixed an issue where the Mount Stamina bar wouldn't toggle off properly when dismounting in any other way than pressing the mount key. This is due to an issue with the API that should be addressed in a later ESO update.
- Fixed an issue where the shared transparency setting for Group/Raid frames under Custom Raid Frames would be disabled when Custom Group Frames were disabled.
- Flipped the menu order for color Group/Raid Frames by Class/Role. Role color takes precendence and therefore is the later option listed in the menu.

---

### Version 5.6.1

Combat Info
- Fixed an issue where Cast Bar custom position was not saving correctly.

Unit Frames
- Fixed an issue where Group and Raid frame Role Colors & Icons were not working (thanks SilverWF for finding the issue and fixing it).

---

### Version 5.6.0

General
- Temporarily removed custom icons for passives and racials in the skill tree due to the related functions for this being changed in the update. I intend to reimplement this in the future.
- Fixed various localization issues with some components.
- Moved UnitFrames, Buffs & Debuffs, Combat Text, and Info Panel components down to lower draw layers (preventing them from overlapping low priority layer custom addon windows).

Buffs & Debuffs
- It may have been possible for debuffs not cast by the player to display in prominent buffs - added a filter to only show debuffs sourced from the player.
- Fake & Consolidated Buffs & Debuffs can now be added to Prominent Buffs & Debuffs or the Blacklist by AbilityId.
- Mousing over buffs & debuffs now shows the tooltip information.
- Right clicking on buffs that can be removed will now remove the buff.
- Updated & added custom tooltips for many abilities - as well as added normalized tooltips for Major/Minor effects.
- Updated icons + auras for Main Story Quests, Fighter's Guild, Mage's Guild & the first 2 (about 50% of Greenshade as well) zones of AD quests.
- Updated icons for NPC summon abilities (Each summon type now has an individual icon).
- Hid various dummy id's for NPC summon abilities & NPC Caltrops.
- Fixed an issue where NPC name based icon/name overrides for pets didn't correctly apply to the Death Recap Screen.
- Buff Icon for Vanity Pet / Mount now shows the actual collectible icon overlaid over a background (Added an option to show the generic mount icon if desired).
- Added cast bar for various general effects such as Filleting Fish, using Keep/Imperial City Retreat Sigils, Pardon Edicts, etc...
- Werewolf Buff Indicator & Power Bar now behave correctly when dead/reincarnating
- Fixed issue with Werewolf buff icon bouncing back and forth between effects that had a longer duration than it (due to forcing it to always have a maximum duration of 38 seconds).
- Devour Cast Bar now ends when devour channel is broken
- Devour now pauses Werewolf Timer buff when starting and resumes immediately when ending

Chat Announcements
- Added an option to show when items are removed by quests or events. This requires the destroyed item message display option to be enabled (Otherwise can't tell if a player just destroys an item).
- Removed hook for EVENT_BROADCAST - stops duplicate server shutdown messages from being displayed.
- Updated Achievement Tracking Categories to support all achievement categories (they have been branched out again with Wolfhunter DLC).
- Added some additional conditionals to messages displayed when upgrading an item in order to prevent errors.

Combat Info
- Added option to resize Cast Bar & Cast Bar Icon
- Cast Bar Frame is now centered by default, and resizing keeps the bar centered
- Cast Bar - Significantly improved the display options when unlocking the Cast Bar in the menu to adjust position.
- Cast Bar will now break when incoming hard CC hits the player - or when the player rolls/blocks
- Fixed a bug where Bar Highlight effects that were created by EVENT_COMBAT_EVENT would be removed when mousing over another target.
- Added cast bar indicators for for Main Story Quests, Fighters Guild, Mages Guild & the first 2 (about 50% of Greenshade as well) zones of AD quests.
- Added cast bar for Soul Gem Resurrection.

Combat Text
- Combat Text menu completely reorganized in order to be more accessible. All options are now categorized together (I.E. all options for Outgoing Damage, Healing, etc are grouped together now rather than being split across multiple submenus).
- Updated Alerts to use different colors for each type of alert in order to improve differentiation.
- Updated Alerts to use conditionals to determine if "Name" or "No Name" prefixes should be used. These options have been added to the menu as well.
- Fixed an issue where custom icons/ability names based off target name were not displaying correctly.
- Added the silence effect from Negate Magic & Morphs to the blacklist for SCT - this will no longer spam immunity notifications every .5 seconds on CC Immune targets.

Unit Frames
- Fixed a major issue where Unit Frames did not properly follow the Account Wide / Player Specific saved variable settings in the menu.
- Added right click handler for Group Frames - you can now acccess group menu functions by right clicking frames.
- Fixed an issue where disabling the option to display the player in Small Group frames would cause the role of class color to be incorrect.
- Added Group Frames, Raid Frames, and Boss Frames into "loot" scene to prevent those frames from disappearing when looting an item.
- Added tooltips to Custom Frames - Alternate Player Bar( for level information, Siege, Werewolf, and Mounted Status).
- Alternate Player Bar - Champion XP bar now shows Enlightenment value.
- Fixed an issue where frames weren't added to the "siegeBarUI" scene - causing your frames (and buffs if anchored) to fade when typing in chat or switching to mouse controls while using a Siege weapon.

---

### Version 5.5.2

Combat Info
- Added a cast bar for player abilities. Has a variety of customization options and position customization.
- Fixed an issue where bar highlight for some abilities wasn't working. Updated ground tracking and mine tracking to remove auras when ground effects end prematurely.

Buffs & Debuffs
- Ground based auras are now removed when a ground effect ends prematurely.
- Updated mine tracker to work for Eternal Hunt set, Manifestation of Terror, and Frozen Gate + morphs.
- Fixed an issue where disabling ground effects from display would not do anything - as well as fixed blacklisting ground abilities not working.
- Updated icons and auras for base Cyrodiil buffs. Keep bonus now shows a stack counter equivalent to the number of enemy keeps your Alliance controls. Also hid some useless auras on Guards/Structures.
- Added missing icon/name changes for pve bite variants of Lycantrophy and Vampirism precursors (evidently its a different abilityId than you get from player bites).
- Updated a few various icons for auras & environmental hazards.

---

### Version 5.5.1

Combat Info
- All bar proc abilities will now play a sound when available for use, not just Crystal Fragments.

Buffs & Debuffs:
- Fixed an issue with the prominent buffs font selector that could cause a UI error if an invalid font was selected.
- The debug option for Combat Events and Effect Changes now display abilities with the name updated to reflect changes made by LUIE.

---

### Version 5.5

General Components
- Added RU Translation thanks to a ton of effort from KiriX!

Buffs & Debuffs
- Did a pass on ALL player skill line abilities - updated auras for all abilities with name corrections, icon corrections, and hid unneccessary dummy auras.
- Added custom icons for the attacks used by Nightblade, Sorcerer, and Warden pet abilities.
- Added custom icons for a great deal of NPCs that were missing them including all Dwemer NPCs, Giants, Trolls, Daedric Hungers, Iron Atronachs, etc...
- Updated localization for major/minor debuffs so that all languages will show major/minor debuffs on the target regardless of source.
- Reset the options for "Display Extra Buffs & Consolidate Buffs" to account for some changes made with this update as well as added an additional option to consolidate single major/minor auras.
- Grim Focus updated to track its stack count on the duration buff applied to the player.
- Fixed an issue where Ground Mine stacks weren't decremented when a mine triggered if an aura was set to prominent.
- Removed a significant amount of older code related to ground effects that should result in minor performance enhancement.
- Fixed an issue where the Pelinal's Ferocity experience buff was not correctly labeled as an experience buffs for the purpose of hiding it from display.
- Updated auras for various sets, and added updated icons/auras for sets from Dragonstar/Maelstrom Arena, as well as all Summerset sets.
- Fixed an issue where prominent auras weren't removed from tracking when the player died.
- Added the option to display a timer buff when transformed into a Werewolf. This timer will pause at a Werewolf Shrine or when using the Devour passive.
- Fixed an issue where dummy auras added by target name (example: CC Immunity buff added to some boss NPCs) would display on dead targets.
- Fixed an issue where Artifical Effect id's would not refresh when updating settings in the Buffs & Debuffs menu (dummy auras added by ZOS - such as Battle Spirit).

Chat Announcements
- Fixed an issue that was causing Disguise Notifications not to display even when enabled.
- Updated Achievement Tracking options with all current categories.
- Added Psijic Order guild reputation tracking.
- Fixed an issue where the menu option to modify the context currency/loot message for "Spend" was missing.
- Added a new context message option "Pay" for gold given to NPC's in conversation options.
- Jewelry Crafting should now be supported by Loot crafting messages.

Combat Info
- Did a pass on ALL player skill line abilities - Bar Ability Highlight tracking is now supported for any ability the player can slot.
- Bar Ability Highlight tracking now supports multi-target tracking, when changing targets the highlighted abilities will update based on what debuffs are currently applied to that target.
- Fixed an issue where the Crystal Fragments proc sound wouldn't play due to a bad variable name.

Combat Text
- Fixed an issue where errors would be displayed when the Shorten Numbers option was enabled.

Info Panel
- Reimplemented the menu option to change the scaling on the Info Panel for higher resolution displays.
- Mount feed cooldown notification updated from "Feed Now" to "Train Now."

Slash Commands
- Added the "/outfit" "#" command. Allows you to swap to an outfit. Also adding keybinding options.

---

### Version 5.4

General
- Implemented an ingame changelog that will display on the first load with LuiExtended enabled when the version number is different than your current version. This changelog can also be viewed from the addon settings menu.
- Added the option to switch between using ACCOUNT WIDE or CHARACTER SPECIFIC savedVariables settings. Profiles can be copied between characters or deleted from the addon settings menu.
- Separated Slash Commands & Info Panel modules into their own individual component menus.
- Updated and cleaned up various menus to be more intuitive.
- Replaced GetSynergyInfo() hook with ZO_Synergy:OnSynergyAbilityChanged() hook in order to fix compatibility issue with Innocent Blade of Woe addon by dorrino. This is a better way to hook, as only the displayed icon is modified and the original synergy info is preserved.
- Chat Printing settings have been moved to Chat Announcements - and updated to allow the option to print to individual tabs instead of all tabs. This allows you to have loot, experience, etc notifications only display in one chat tab. Also added a toggle to allow system/notification based messages to bypass this and still appear in all tabs. These settings have been reset to default due to this change.
- Added an option to choose the color for timestamps prepended to chat messages.

Buffs and Debuffs
- Added the ability to track prominent player buffs & debuffs by name or AbilityId. Prominent containers support the ability to display the aura name and a timer bar.
- Added the ability to blacklist buffs & debuffs by name or AbilityId.
- Updated auras and improved custom icons for various NPC abilities as well as added new icons and updated auras for many NPC's missing them.
- Added auras & icons for Scalecaller Crown Crate memento effects.
- New internal table allows simulated aura display on targets based on name. This allows for the display of buffs such as Radiance on Flame Atronachs and CC Immunity on boss rank enemies.
- Added a Debug option to display the AbilityId of effects on their buff/debuff icon.
- Added Night Mother's Gaze & Line-Breaker into debuffs that always display on a target regardless of source.
- Fixed an unintentional change which modified the Line-Breaker debuff from the Alkosh set to be named "Roar of Alkosh." This should prevent Combat Metrics from combining the two debuffs when reporting uptime.
- Fixed an issue where Off Balance Immunity wasn't displaying on targets and adjusted it to display as a buff rather then debuff. This effect can still be tracked by prominent buffs & debuffs due to its importance.

Chat Announcements
- Updated the default variable settings for Alliance Point, Tel Var Stone, and Experience Point notifications so throttling is enabled by default.

Combat Info
- Added an option to toggle on/off the display of bar highlight for secondary effects like the magicka restore from Honor the Dead or Major Savagery from Biting Jabs.
- Added option to change the formatting of the Ultimate Percentage Label & set the default font/position to match that of bar highlight.
- Added an option to play a sound on ability procs.
- Anchored bar labels to Action Button instead of flipcards, this stops the label from wiggling erratically when swapping bars.
- Fixed an issue where when bar ability highlight for the Ultimate slot was enabled along with Ultimate % label the two labels would overlap on application for a split second.
- Fixed an issue where the initial bar highlight label created for effects would display the default base ability duration without compensating for the extra duration added to many abilites added by EVENT_EFFECT_CHANGED.

Combat Text
- Added an option to set Transparency for Combat Text.
- Added an option to abbreviate numbers like 12345 to 12.3k.
- Updated Incoming Ability Alerts to hide suggested mitigation options by default. Now messages will simply display incoming ability name/icon unless mitigation method notification is toggled on.

Info Panel
- Info Panel module has been moved to its own "LuiExtended - Info Panel" settings menu.
- Fixed an issue where the Info Panel displayed over other UI menu's by adding it into the Scene Manager.
- Fixed an issue where the "Feed Now" timer was clipped.
- Fixed an issue where the Armor Durability indicator was clipped.
- Removed outdated Imperial City Trophy Display & Scaling Options.

Slash Commands
- Slash Commands module has been moved to its own "LuiExtended - Slash Commands" settings menu.
- Slash commands can now be enabled or disabled individually.
- Added /banker, /merchant, /fence commands to summon assistants.
- Added /ready command to initiate ready checks.
- Added keybinding options for /banker, /merchant, /fence, /ready, /home & /regroup.

Unit Frames
- Added an option to display the AVA Icon & Rank Number independently from the Title or AVA Rank Name on Target Frames.
- Added an option to set the priority for AVA Rank vs Title Display on Target Frames.
- Added individual options to choose the Low Resource threshold for HP/Magicka/Stamina labels.
- Added an option to select the transparency of the shield bar when using the default Overlay mode.
- Fixed an issue on Target Frames where rank 0 "Citizen" players would display with a rank number of "ava."
- Fixed an issue where changing the Player Frames layout would also reset the position of Group, Raid, Boss, and AvA frames.
- Fixed an issue where the AvA rank icon of players of the same faction was colored white. The AvA icon for players of the same faction will now display the proper faction color.

---

### Version 5.3.2

General
- Updated LibAddonMenu to the latest version.

Buffs and Debuffs
- (WIP) Updating auras for Dragonknight Skills & added new custom icon for Power Lash (only rank 1 currently).
- Added Debug Options in the Buffs and Debuffs Menu for EVENT_COMBAT_EVENT and EVENT_EFFECT_CHANGED - Mostly this is included for development.
- Added option to only show one buff/debuff in paired effects (like Burning Talons or Throw Dagger that have a dot + snare/root of the same duration) - saves some space in the debuff container.
- Vampire Stage now shows a Stack Counter dependant on the stage.
- Did a pass on all basic overland Human NPC's and Human DLC NPC's as well as Justice NPC's and Cyrodiil Guards. Aura updates, icons & Combat Text alerts updated. Some Animal and Insect mobs have been updated as well.
- Added ground mine aura tracker for Eternal Hunt set.

Chat Announcements
- Fixed an issue with the score always displaying as "nil" in VMA/DSA/Trial Announcements.
- Hopefully fixed an issue where some users were getting error messages on login or looting related to the Laundered item function.
- Updated Quest Loot display function to now display removed items first always instead of going in order of the item index.

Combat Text
- Added support for Combat Event based notifications to Alerts.
- Added option to display new Alerts for two events.
- Hid the notification that targets are immune to the Sacred Ground templar passive snare due to screen spam.

Unit Frames
- Fixed an issue where Guard -Invulnerable- HP bars would remain in the red execute range text color if mousing over them when the previous target was in execute range.
- Show an alert when an important/powerful enemy ability is used such as significant power increases.
- Show an alert when a priority target is spawned - enemies or objects that apply significant damage boost, damage reduction, or invulnerability. So far just used for Goblin Shaman's Aura of Protection.

---

### Version 5.3.1

Buffs and Debuffs
- Fixed an issue where using Beast Trap (and its morphs) with the Buffs and Debuffs component enabled could throw UI errors.
- Fixed an issue where the aura for Beast Trap (and its morphs) ground duration tracking wouldn't be removed when the target dodged the attack.

---

### Version 5.3

General
- Did a pass on custom override tables for Templar Skills, Destruction Staff, Restoration Staff, Fighter's Guild, and Medium Armor. Many effects are now fixed to show the proper names and icons for Buffs and Debuffs and Combat Text. Additionally many erroneous auras that displayed now longer show up - such as pointless placeholder effects when the healing effect from Healing Ward fading triggered. Bar Highlight tracking for Combat Info has been updated to track many more abilities both offensive and defensive in these ability categories.
- The above support extends to additional addons if they use GetAbilityName() or GetAbilityIcon() functions - For example Combat Metrics will show the correct icon/name for incoming healing tracked from Templar/Restoration Staff skills with LUI Extended enabled. Previously many healing abilities were named incorrectly, a good example being the initial heal from Healing Ward being named "Grand Healing."
- General cleanup - Removed some un-needed hooks and a few lines of outdated code from various components.
- Fixed an issue due to an oudated hook function where the Skills Advisor would throw UI errors whenever an ability was learned.
- Skills Advisor now reads custom icons used for Class passive abilities.

Buffs and Debuffs
- Added localization support for auras for player abilities, sets, and consumables.
- Thanks to the API update added Death Recap list can now use AbilityId's to properly update ability Names & Icons.
- New icon added for Soul Summons passive, Roar of Alkosh
- Added new icons for root effect from Beast Trap and it's Morphs and the Fighter's Guild skill Silver Leash's secondary ability "Tighten."
- Effects with a stack count now display at one stack rather than only showing their stack count when above 1 stack.
- Fixed an issue where Fake Debuffs (buffs/debuffs without an effect aura that are manually tracked so the player can keep track of them - example is Rearming Traps damage component) weren't properly saving their info for Target players and would fade when changing target and then mousing back over the target again.
- Stack support added for Ground Mine effects - Rearming Trap now displays with 2 stacks, one is consumed every time rearming trap triggers. Later support to be added for Daedric Mines, and sets like Eternal Hunt.
- Added an option to toggle on/off the display of Extra Buff/Debuff icons for certain player abilities that don't normally show a tracking icon such as Dragon Blood or Restoring Focus.
- Added an option to toggle on/off consolidation of Major/Minor buff/debuff auras from certain player abilities such as Dragon Blood or Restoring Focus.

Chat Announcements
- Updated currency context messages to support currency received from Level Up Rewards.
- Updated icon for Outfit Change tokens.
- Crafting loot messages will now display for equipped items (for the new base game feature to upgrade equipped items).
- Hopefully updated Guild Heraldry function to display the correct amount of gold deducted when setting Heraldry (can't test this currently).
- When buying a Horse from the Stable, the Item Link is now replaced with a Collectible Link.
- Fixed an issue where a few functions wouldn't properly set item brackets based on the menu setting.

Combat Info
- Fixed an issue where label timers for active abilities highlighted on the Action bar would flash when a potion was used.
- Fixed an issue where label timers for active abilities on the action bar didn't apply the label immediately upon the effect being gained (sometimes showing 0 duration or no label for a split second).
- Updated bar tracking function to be more accurate. Bar tracking no longer starts until the actual EVENT_EFFECT_CHANGED or EVENT_COMBAT_EVENT fires.
- Bar tracking now uses effect duration (with a custom table for fixing issues) rather than GetAbilityDuration() as these value's often don't match for ground targeted effects.
- Reimplemented highlight animation for skills with a proc effect that change the Action Bar icon when enabled (Grim Focus + morphs, Silver Leash).

Combat Text
- Fixed an issue where the Ellipse style text did not properly display with the scrolling direction set to up.

Unit Frames
- Added multiple options to choose how to display the Player Name on UnitFrames. You can now select a different method for Player, Target, and Group/Raid.
- Updated several Menu Options to change on the fly rather then requiring /reloadui.
- Updated several Menu Options to properly unhide the relevant frames when making customization changes.

---

Version 5.2.8

- Unit Frames - Fixed issue with Regen Arrows animation throwing errors if one of the few abilities in game that properly tries to apply a magicka or stamina regen animation is used. Now if the regeneration type isn't Health the function will end.

### Version 5.2.7

General
- Death recap custom icon replacement temporarily disabled. New function is all set and will be implemented with the API changes when the Dragon Bones update goes live.

Buffs and Debuffs
- Added individual hide options for Player/Target for Food/Drink buffs & Experience buffs.
- Updated localization for Consumables & Mementos

Chat Announcements
- Merged Currency and Loot context messages into one set, and moved the settings into their own Shared Submenu.
- Added tracking options for Transmute Crystals, Outfit Change Tokens, Crowns, and Crown Gems to currency announcements.
- Removed pointless ZO_Smithing and ZO_Enchanting hooks: these could cause other addons that hook the same function such as FCO Craft Filter and Multicraft not to work properly.
- Added option to hide the Guild Trading House listing fee.
- Fixed an issue where laundering/fencing items without "Merge Currency & Loot Messages" enabled would throw UI errors. Now added context messages for Fence/Launder without a gold value in case of this.
- Fixed an issue where mail received when returned from another player would throw errors when loot or currency announcements were enabled.
- Fixed an issue where the Group Leader changing would occasionally throw UI errors (after leaving group sometimes the event would fire).

Combat Info
- Can now toggle the Ultimate Value label and Ultimate Percentage label independently.
- Can now toggle to display the duration label and glow effect on Ultimate ability. This will hide the % label for the duration of the active ability when enabled.
- Removed IsError filter on Combat Text which was preventing immunity messages from displaying correctly.
- Hopefully fixed an issue with Combat Text occasionally throwing error messages on Alerts with the Single Line Alert method option selected.

Info Panel
- Updated spacing and font format for Info Panel.
- Adjusted the threshold for the colorization of various labels and removed the decimal place in FPS tracking.

Unit Frames
- Added an option to color target custom Unit Frame by Reaction type.
- Guards now have an Invulnerable tag on their HP bar instead of displaying HP.
- Fixed an issue where the Regen arrows animation was applied on Magicka/Stamina bar (this was never implemented in the game correctly to use and only seemed to trigger from something in Cyrodiil).
- Fixed an issue where the alternate bar would not anchor correctly to the separate shield bar if enabled when using Horizontal or Pyramid unit frames.

---

### Version 5.2.6

Unit Frames
- Fixed issue where setting menu option for player frame mode would throw errors if the custom target frame was disabled.
- Fixed an issue where the a UI error would be displayed if the PVP Target Frame was enabled.
- Fixed spacing issues with alternate bar below frames - now the distance should be normalized for all bar setups.
- Moved menu for Additional Player Frame options down as well as updated a few menu strings.

---

### Version 5.2.5

Combat Info
- Fixed a MAJOR PERFORMANCE ISSUE with the Show Global Cooldown function - This setting is now reset to disabled for all players using the addon. This setting now has a warning for high CPU usage.

Buffs and Debuffs
- Changed icons for the one hour buffs granted by completing World Boss events in Craglorn to use the achievement icons which fit far better for each buff.

Chat Announcements
- Moved Common Options settings for Chat Announcements to the bottom of the menu and fixed the missing header.
- Moved the various events related to EVENT_DISPLAY_ANNOUNCEMENT into their own category in chat announcements. This currently includes: Respec Notifications, Entering/Leaving Group Area, DSA/Maelstrom Stages, Maelstrom Rounds, Imperial City Area Messages, Craglorn Buffs (new).
- Display Announcements no longer display a debug message by default - You can now turn this setting on if you'd like to help process messages that are not yet included in the LUI Extended Options.
- Fixed an issue where sending a COD payment would also send a duplicate "Mail sent!" message if Mail Notifications are on.
- Fixed a UI error that would occur in gamepad mode when trying to send mail due to not being able to determine the recipient name.
- Fixed Group Loot member names sometimes displaying as "nil"
- Fixed an issue where UI errors would be thrown when attempting to trade after accepting a trade invite after reloading the UI.
- Mail, Trade, and Group Loot functions now have fallback options in case the name of the target player cannot be resolved. There are new context menu strings for these messages.
- Formerly when sending mail to an invalid player name, a currency sent and received message would print for the transaction and immediate refund. These messages are now suppressed.

Unit Frames
- Fixed an issue where regen/degen arrows would play the first time you moused over a target on loading the game.
- Moved menu options into dropdown categories instead of one gigantic menu
- Added new Player Frame Methods - You can now choose to have bars displayed in a horizontal spread out layout like the default UI, or in a Pyramid stack. NOTE: This setting will reset your custom positions and center the frames!!!
- Alternate Bar (XP Tracker, Werewolf Tracker, Siege Tracker, Mount Stamina Tracker) is now located centered below the attribute bars. Additionally this frame will now move to the stamina or magicka bar if you have Horizontal or Pyramid Frames selected.

---

### Version 5.2.4

Unit Frames
- Fixed a massive performance issue caused by the Unit Frames Regeneration Arrows overlay. This update should remove menu lag and fps drop when turning your camera or in crowded areas as well as FPS drop in combat. You may still experience some FPS hit when using the Scrolling Combat Text. Let me know if you have any major performance issues after this update.

Combat Info
- Added filters onto Combat Events for CombatInfo component to increase performance

Unit Frames
- WIP: Started to add a new method for Unit Frames to display the 3 bars separately on the bottom of the screen. This is a work in progress with menu option localization incomplete, default position incomplete, and missing functionality to move the mount/ww bar to the stamina/magicka frames.

---

### Version 5.2.3

Buffs and Debuffs
- Added filters for EVENT_COMBAT_EVENT - Should help with performance issues.

Combat Text
- Added filters for EVENT_COMBAT_EVENT - Should help with performance issues.

Chat Announcements
- Added group loot print function back in (never intended to remove it).
- Fixed an issue where inviting a player to group who could not be found would display "That player is busy" instead of "Could not find a played named "input" to invite."
- Fixed an error that would occur when depositing items into the bank.
- Temporarily removed EVENT_DISPLAY_ANNOUNCEMENT debug message. Think I've just about logged everything here now, thanks guys.

Unit Frames
- Frames no longer unhide in menus when group members change role/or leader is updated

---

### Version 5.2.2

General
- Fixed a major issue causing group invites to not function when Chat Announcements was enabled.

Chat Announcements
- Fixed an issue where using the Sell All Junk button at a vendor with Loot Announcements enabled would throw errors when more than one item was sold. The fix here is temporary (only one item will display - with the total value of gold received) until I have time to drum up a better solution.

---

### Version 5.2.1

Buffs and Debuffs
- Fixed an issue with a missing function causing buffs fading to throw UI errors when Fade Out Expiring Icons is enabled.

Chat Announcements
- Hopefully fixed an issue where Guild Rank changes would throw UI errors when enabled. I am unable to verify this works currently due to lacking a guild to test in on the PTS.
- Fixed an issue where all currency gain/loss would display unless you had all 4 currency types set to disabled.
- Fixed an issue where certain functions in this component would trigger even when it was disabled in the settings menu.

Combat Text
- Controls renamed to "LUIE_CombatText" to prevent conflicts with other addons.
- Added slight filter for combat events (previously a few variables were being set on every combat event even if it wasn't related to player or pet/target - now that only happens if the source/target is the player or pet)
- Added an option (disabled by default) to hide nearby enemies abilities that don't directly target the player. This prevents spam from abilites that are happening out of range of the player when disabled. Note: These alerts still always display in dungeons since players are likely to all be in relatively the same area.
- Fixed an issue where incoming mitigation warnings would always display even when disabled.
- Added a missing menu option for turning Outgoing Reflects off. Additionally fixed the toggle options for reflects so Incoming displays attacks you Reflect and Outgoing displays attacked an enemy reflected.

---

### Version 5.2

General
- Damage Meter Component has been removed. Highly suggest using Combat Metrics instead. (http://www.esoui.com/downloads/info1360-CombatMetrics.html).
- Combat Info component has been split into two components: Scrolling Combat text has been revamped and replaced with the more advanced features from the Combat Cloud addon. Combat Info has been updated with additional functionality. More details listed per component below.
- Added an option to Hide the Experience Bar/Skill Progess Bar from popping up when the player earns XP from Experience Gain from Quests, Discover, Boss Kills, and Skill Line Updates. This is useful if you wish to place a UI component in the top left corner of your screen.
- Updated description and functionality of the various SLASH commands. Error messages have been streamlined and will display additional alerts based off your preferences in Chat Announcements for the relevant commands.
- Several SLASH commands now return errors if attempting to use them in Cyrodiil or Battlegrounds where it is not possible to do so.
- /regroup command no longer attempts to invite offline players or duplicate players in the party, as well as provides information if no additional players are present. If all party members are offline the regroup command will not proceed.
- Added a new /campaign option to queue for campaign. Enter /campaign "name" to queue for a campaign.
- Added Trajan Pro and Trajan Pro Bold fonts to the font library for use in LUI.
- Dropdown menu options to select font now use a scrollbar method to prevent the number of font choices from going off the screen.
- Adjusted menu options for various components to be more logically organized.
- Fixed an issue where Buff/Debuff names, Combat Text messages and Item Styles did not display correctly on non-English clients.
- Fixed an issue where the /kick SLASH command would prevent the /kick emote from being used. Now if you enter /kick without any additional input, the kick emote will be performed correctly.

Buffs and Debuffs
- Bar highlighting component removed and reimplemented in Combat Info component.
- Buffs/Debuffs now display by EffectSlot instead of abilityId, this means if you have 3 searing strikes on your, they will all show as an individual debuff as you would expect.
- Buffs/Debuffs will not display the stack count in the upper right corner of the icon when applicable.
- Player/target debuffs no longer stack infinitely across the screen when anchored to the LUI Target Frame, and instead will stack upward (in the same way buffs stack downward).
- Remaining time label can now be moved up or down to be positioned below or further inside the icon.
- The radial cooldown border for buffs and debuffs now shows relevant to the total duration of the effect. Previously effects showed a solid border until their remaining time dropped below 8 seconds.
- Buffs/debuffs with unlimited durations will now display a solid radial cooldown border instead of being empty.
- Recall Cooldown indicator renamed to Recall Penalty and adjusted radial cooldown border to show its remaining duration relevant to the full 10 minute duration.
- Added an option to reverse the buff sorting order for the Long Term buff container.
- Fixed an issue where the long term buff container anchor was displaced when moving the frames with the Horizontal display option selected.
- Added an option to HIDE the display of player or target buffs in addition to debuffs. Also added an option to hide the display of ground targeted buffs and debuffs.
- Removed many excessive icons options for collectibles. Collectibles have been condensed into 3 options: Assistants, Vanity Pets, and Mounts.
- When the option to show equipped disguises is enabled, a buff will no longer be displayed when wearing a guild tabard.
- Option to Show/Hide Vampirism & Lycanthrophy buffs on Player/Target have been split into several categories: Vampirism Stage, Lycanthrophy, Precursor Disease, and Bite Cooldown
- Option to Show/Hide Battle Spirit on Player/Target have been updated to now correctly display Battle Spirit in Battlegrounds, Cyrodiil, or Duels.
- Added an option to Show/Hide Soul Summons internal cooldown on Player/Target.
- Added an option to Show/Hide Set Bonus long internal cooldowns (Phoenix, Eternal Warrior, Immortal Warrior) on Player/Target.
- Ground targeted buffs/debuffs no longer incorrectly display an aura when the player presses the relevant ability but cancels it without selecting the target location.
- Updated code for ground targeted buffs/debuffs for more accurate duration resolution. Note: Not all buffs/debuffs have been correctly adjusted to use this new code yet)
- Added/updated icons for new Clockwork City food, and new crown items and memento's added in the last several updates.
- Updated aura information for various consumables and memento's (Examples include hiding some goofy duplicate buffs that show for certain food/drinks, renaming seasonal foods that didn't have the correct names, etc)
- Updated several memento self-stuns as well as various other abilities to use the "unbreakable" border color for buffs/debuffs - indicating there is no way to remove the effect.
- Updated icons and auras for New Life Festival & added icon for new memento version of Breda's Magnificent Mead.
- Updated Dodge Fatigue and Bolt Escape Fatigue auras to use the "unbreakable" border.
- Added new custom icons & fixed aura display for almost all Item Sets in the game (missing VMA and DSA sets currently due to lack of inclusion in PTS containers - will be added in the future). Several new "fake auras" have been added to make certain effects easier to track such as Ilambris or Spawn of Mephala.
- Updated Death Recap to display many of the new icons applied to item sets and abilities.
- Internal cooldown buffs (Phoenix, Eternal Warrior, Immortal Warrior, Soul Summons, Vampire/WW Bite) now use a significantly darkened icon to represent they are on cooldown.
- Added custom icons for several Justice Guard abilities as well as updated the display of various auras. (Hid a bunch of pointless trigger buffs that offered no useful information).
- Added custom icons for Daedric Anchor abilities - Static Charge, Anchor Drop (meteor damage from standing under a dropped NPC), and Power of the Daedra.
- Added custom icons for Champion Point Passives
- Added custom icon for Ayleid Well health bonus

Chat Announcements
- Many announcements now send messages to a single printer function on a 50 ms throttle. This function interprets the messages it receives in order to print them in a logical manner. This means when a large number of messages is displayed from for example, a quest being completed, the messages will be displayed in a logical order. In addition this solves the issue where certain components used to cause an annoying scrolling effect as the messages were printed at different ms intervals.
- Added individual options to toggle the display of [] brackets for Character/Account Name Links, Item Links, Lorebook Links, Collectible Links, and Achievement Links.
- Most components now allow you to toggle on/off the display of Chat Announcements, Alerts, or Center Screen Announcements.
- Significantly updated the syntax and display options for most components.
- Hooked many functions in the game in order to provide more accurate information for commands and errors sent from ingame menus.
- Shared: Added an option to use a single color for currency and item gain/loss instead of context based color.
- Shared: Updated the syntax for Currency & Loot messages to display more detailed messages.
- Currency: Added in several missing methods of currency acquisition with context messages.
- Currency: Currency Names now use zo_stringformat, allowing you to enter both a singular and plural name for the currency if you wish to change it.
- Currency: Streamlined options to throttle the gain of Alliance Points and Tel Var Stones. Now the throttle timer will be extended if additional currency is acquired instead of always displaying the currency gained a set duration after it is received. In other words: If you continue to earn AP at 3 second intervals with a 5 second throttle set, the currency gained will not print until a lapse of 5 seconds occurs between gaining currency.
- Loot: Updated indexing function to always display accurate information about items received!
- Loot: Fixed various issues with the display of Armor Type, Style, and Trait
- Loot: Updated Group Loot to display either the Character or Account name of the player receiving the item based off your setting.
- Loot: Fixed Group Loot/Notable Loot function to correctly display Green Quality set items looted.
- Loot: Added individual options to show when a Quest Item is Looted or Removed from your inventory.
- Loot: Added individual options to toggle the display of Total Item Count and Total Currency remaining when purchasing an item from a vendor.
- Experience/Skills: Removed several options for cleaner functionality. Updated syntax for experience gain.
- Experience/Skills: Now the throttle timer will be extended if additional experience is earned instead of always displaying the experience earned a set duration after it is received. In other words: If you continue to earn experience at 3 second intervals with a 5 second throttle set, the experience earned will not print until a lapse of 5 seconds occurs between earning experience.
- Experience/Skills: Added option to toggle the display of Enlightenment State change messages.
- Experience/Skills: Added option to toggle the display of Respec Notifications (champion points, attributes, skill points, morphs).
- Experience/Skills: Added option to toggle the display of Skill Points earned and Skyshards absorbed with several options to adjust display.
- Experience/Skills: Added options to toggle the display of Skill Lines Unlocked, Skill Line Progression, and Ability Progression.
- Experience/Skills: Added options to toggle the display of Guild Reputation earned. With various options for color and syntax - and a throttle option for Fighter's Guild reputation earned from kills.
- Collectibles/Lorebooks: Added several new options to Collectibles and Lorebooks display and updated syntax for messages.
- Achievements: Removed several options for cleaner functionality. Added several options and updated syntax for messages.
- Quest/POI: Quest Difficult Icon will now display in Accept/Complete/Abandon messages correctly.
- Quest/POI: Added many new options to toggle the display of various individual quest updates.
- Quest/POI: Added option to toggle the display of Imperial City Sewers area notification messages.
- Social/Guild: Added many new options to toggle the display of various messages.
- Social/Guild: Added option to color guild names and ranks based on Alliance.
- Group/LFG/Trial: Added many new options to toggle the display of various individual LFG or Trial messages.
- Group/LFG/Trial: Messages are now hooked to functions and should no longer display spammy/incorrect information.
- Group/LFG/Trial: Added option to toggle the display of Maelstrom Arena/Dragonstar Arena stage start notifications.
- Group/LFG/Trial: Added option to toggle the display of Maelstrom Arena round notifications.
- Misc Announcements: Added option to toggle the display of Entering/Leaving Group Area notifications.
- Misc Announcements: Updated Mail Notifications to be slightly more basic.
- Misc Announcements: Updated options and syntax for Bag/Bank & Riding Skill Upgrades.

Combat Info
- Removed all old combat text options and damage meter options. Combat Text features moved into Combat Text component.
- Removed old Global Cooldown function to implement new one based off the unused Zenimax GCD function. Added various options.
- Added new Bar Ability highlight options with the ability to add a duration onto the label. This component tracks active abilities or procs.
- Procs triggered when Bar highlight is enabled now play a sound.
- Updated and separated old option to display a Cooldown duration for Potions and Quickslot items. Added options to configure label formatting.

Combat Text
- Combat Text component completed replaced by a modified and updated version of the Combat Cloud addon originally by Sideshow: http://www.esoui.com/downloads/info281-CombatCloud.html#info
- Adjusted default options for Combat Text to have formatting similar to the default game combat text.
- Combat Text now uses icon and name override tables from LUI buffs & debuffs components.
- Combat Text now hides some un-needed or spammy messages such as resource drain from Sprint and Stealth.
- Fixed an issue from Combat Cloud where the combat state would not be correctly toggled when reloading the UI in combat causing Enter/Leave combat messages to be reversed.
- Fixed an issue where the Potion Ready alert would not trigger due to referencing a function that no longer exists.
- Adjusted text speed for all scrolling methods to be slightly faster and have less overlap. Ellipse method now much faster and more similar to old LUIE style or FTC style combat text.
- Added options to adjust the format for Damage/Critical Damage, Dots/Critical Dots, Healing/Critical Healing, and Hots/Critical Hots individually.
- Added options to override the color for all Critical Damage done, all Critical Healing done, or all incoming damage. This can be used if you want to emulate the way the default game combat text is formatted.
- Notifications to Block/Dodge/Interrupt have been overhauled and replaced with new advanced notifications, allowing you to display a warning displaying the name/icon of the incoming ability as well as the ways it can be mitigated. This option has various customization options for formatting and to choose what ranks of NPC's trigger these alerts.

Unit Frames
- Fixed regeneration/degeneration arrow animation
- Added option to toggle the display of hot/dot animation, power change, and armor change individually for Player/Target, Group, Raid, and Boss frames.
- Power and Armor change overlays now use the animated effects from the default unitframes.
- Added option to change the display method for Champion Points (show above cap or limit to cap). This extends to the default unit frames as well.
- Added individual options to hide the display of the target Title/AVA Rank. Anchored buffs container position will adjust based off whether or not a target has a title/ava rank displayed.
- Added option to color group/raid unit frames by Class Color.
- Added option to display either Class Icon or Role on Raid Frames (one or the other or set a certain way depending on whether the player is in PVE or PVP content).
- Separated transparency and size options for Player/Target bars.
- Added option to hide anchored buffs frames when out of combat (if you choose to set player/target frame to 0 opacity when out of combat you might want to hide the buffs as well).
- Added option to format the label on Raid/Boss frames.
- Added option to configure the transparency of Group/Raid frames.
- Added option to configure the transparency and size of Boss Frames.
- Added option to shift the vertical location of default player frames if repositioning is enabled.
- Fixed an issue where character name was displayed instead of account name for the player when name display method was set to "@UserId" or "Character Name @UserId"
- Fixed an issue causing Default Unit Frames overlay components (Class/Friend Icon and labels) to sharply disappear on target change rather than fading out with the base frame components
- Low Stamina/Magicka will now flash green/blue on the bar instead of red.
- Fixed an issue where sometimes the low resource flash effect would play several times on the stamina bar on player death.
- Fixed an issue where the "Dead" label would clip into the role icon for dead players.

---

### Version 5.1.2

General
- Updated API version for Horns of the Reach.
- Temporarily removed function that add news icons to Death Recap until I have a chance to look at the changes to the function from this API update.
- Removed LibAnnoyingUpdate and LibCustomTitles - Don't really see a need for these libraries to be here.

Buffs and Debuffs
- Buff and debuff icon countdown border now displays based on the FULL duration of the buff rather than only counting down at 8 seconds.

---

### Version 5.1.1

Buffs and Debuffs
- Fixed bar highlight for the majority of abilities to work correctly again. Note its a long time WIP to significantly enhance what shows here but it requires manual processing of every relevant rank of ability and morph to do so.
- Hiding certain buff categories from displaying on the player/target (Mundus, ESO Plus, etc) now works correctly again!
- Updated auras & icons for Air Atronach & Kotu Gava, added icons to Death Recap.

Chat Announcements
- Added an option to show the total # of items held when an item is looted (thanks to a new ZOS function).

---

### Version 5.1

General
- Added posthooks for GetAbilityName and GetAbilityIcon, allowing new LUI ability icons and name corrections to be used by other addons (not fully implemented yet).
- Started custom icon implementation with Death Recap - at the moment only a bit of this is done and only English localization is supported (I have to override specificially by NPC names and skill names), although most of the single player content in Morrowind has been added.
- Updated many passive skill tree icons and racial icons. Now passives for each skill tree have icons that match the relevant style of their active abilities. Please let me know if there are any icons you don't like. Still enhancing a few of them!

Unit Frames
- Fixed a major issue where Unit Frames disappeared in Battlegrounds when swapping to potions, an issue with Unit Frames disappearing randomly in player houses, and not correctly hiding when in the Housing Editor.
- Fixed an issue where Wardens appears with a white square instead of the proper class icon
- Fixed an issue where players changing role or joining/leaving group would cause the Unit Frames to appear when in another interface tab.
- Fixed an issue where bars had blank space in front of them if Role Icons were toggled on in a battleground.
- Group and Raid Frames now shift if Role Icons are enabled and a player changes their role to none.

Buffs and Debuffs
- Integrated into default UI components, the Effects Screen will now show the update names and icons of abilities, and hide relevant abilities that provide no useful information. NOTE: Does not hide special category buffs such as Cyrodiil Bonuses or Battle Spirit, these are only hidden from the LUI Buff & Debuff frames if selected.
- Added different border colors for unbreakable/unremovable crowd control effects (haven't had time to expand implementation for this much yet)
- Updated and enhanced many custom icons and did a pass to hide more pointless auras (blue skill placeholder icons). There is still much to do! NOTE: At the moment there are a few placeholder icons present for several effects, I will replace these as soon as I can.
- Implemented Artificial Effect Id's (something ZOS added recently) - The only cases I've seen this used so far is for the Battle Spirt buffs when dueling or in a Battleground).
- Disguise Buffs: Fixed an issue where the Scarlet Judge disguise would throw UI errors and added an icon for this costume.
- Fixed various menu options here to function slightly better
- Temporary issue: Bar highlight for many abilities is currently disabled, I am in the process of switching from a basic abilityName resolving function to using abilityId's for more control of the bar highlight. It will be reimplemented in the future.

Chat Announcements
- Corrected and updated various strings for consistency.
- Fixed various misc small issues and adjusted timing on some chat printing events. The order of events is far less likely to be out of whack when a large amount of events happen at once.
- Achievements Announcements: Significantly overhauled the options for Achievements Announcements
- Collectible Announcements: Overhauled the options for Collectible Announcements and moved them into a new menu category with Lorebooks.
- Lorebook Announcements: Added option to display Lorebooks Discovered (and Eidetic Memory Books + Crafting Motifs) with many customization options.
- Loot Announcements: Fixed a bug that caused the index to break when items were confiscated by a Guard and the option to print the items confiscated was disabled. Regardless of the options selected, the index should refresh correctly when items are confiscated
- Loot Announcements: Fixed an issue where using Gamepad mode and crafted item announcements would throw a placeholder error string.
- Loot Announcements: Added Subscriber Bank into Loot Announcements. Bank items should all display correctly again now.
- Loot Announcements: When equipping multiple pieces of gear or equipping a set of gear with addons like AlphaGear, LUI is much less likely to erroneously print [Received] notifications in chat. NOTE: This will still happen if you rapidly spam equip/uneqip a piece of gear, I am looking into a solution for this.
- Loot Announcements: Fixed an issue where items added to the craft bag from not-looted sources
- Currency Announcements: Fixed an issue where earning gold from battleground medals earned was displaying a debug message.always displayed as [Looted].
- Group Announcements: Updated group invite messages to correctly work with the changes to this event implemented in Update 14 (It no longer resolves names automatically and only returns what you type when using /invite to invite someone).
- Group Announcements: Updated Group Finder message syntax to correctly display Dungeons and Battlegrounds.
- Group Announcements: Updated methods used for LFG announcements to be more accurate and relevant. Unfortunately the events thrown by the API here are chaotic, I may be able to tune it just a little more in the future.
- Misc: Bag Space Upgrade Announcements: Added an additional check here to prevent these messages from appearing randomly in chat.
- Misc: Mail Announcements: Updated the reset timer on displaying sent mail message info, when the server lags its less likely you should see any duplicate sent messages now.
- Misc: Duel Announcements: Added an option to configure the "Duel Started" message to various formats with the addition of the icon ZOS uses in Update 14.
- Misc: Disguise Announcements: Fixed and updated Center Screen Messages for disguises equipped/unequipped.
- Quest Announcements: Fixed and updated Center Screen Messages for Quests abandoned (this will now display the Icon for quest difficulty if the option is toggled on).

---

### Version 5.03

General
- Hopefully fixed an issue where using a set equipping addon such as AlphaGear would cause [Received] item displays to print out randomly.

Unit Frames
- Added "Raid Name Clip" slider in the UnitFrames Options, this allows you to clip the raid frame name manually in order to prevent it from overlapping with the HP display.

Chat Announcements
- Fixed an issue where removing items from the Guild Bank would occasionally throw UI errors.
- Added a debug message to fix an error where Crafting items with Crafted Loot Announcments on would sometimes throw errors. I'm still attempting to determine the cause of this, please notify me if you receive the error notification.

---

### Version 5.02

Buffs and Debuffs
- Fixed an issue caused by the last hotfix that broke Buffs and Debuffs attaching to the custom Unitframes.
- Fixed an issue where Hide Target Buffs menu option was missing.

---

### Version 5.01

General
- Fixed an issue where the addon did not load correctly for certain people.

Chat Announcements
- Fixed an issue causing Tel Var Stone currency announcements to throw UI errors.

---

### Version 5.00

General
- LUIE Chat Printing function has been updated, this option can be turned on to add timestamps to messages or help with compatibility issues with certain addons such as Social Indicators if you are also using pChat.
- Chat Announcements and Buffs and Debuffs now have their own individual menus for easier use.
- Improved functionality of existing commands.
- Error returns from slash commands now also display a ZO Alert and play the generic error sound.
- /regroup and /disband now return errors when attempted in LFG.
- Updated /ginvite command syntax. Now format is /ginvite "#" "name."
- Guild order is now indexed correctly, allowing all /g commands to work properly when guilds are left/joined without having to reload the UI.
- New Command: /ignore "name"
- New Command: /removeignore "name"
- New Command: /friend "name"
- New Command: /removefriend "name"
- New Command: /leave - Leaves current group
- New Command: /kick "name" - Kicks the target player if you are the group leader.
- New Command: /votekick "name" - Initiates a votekick in LFG.
- New Command: /gquit "#" - Quit guild # entered.
- New Command: /gkick "#" "name" - Kicks the target player from guild # if you have permissions to do so.

Chat Announcements
- Separate many Chat Announcement components into better categories and expanded options.
- Updated and normalized strings for various CA functions to be more consistent, a long with fixing several broken strings.
- Guild Messages now have the correct Alliance Icons.
- Group Finder messages now display correctly for all players whether joining as a full group, partial group, or as an individual.
- Fixed an issue where removing items from the mail could cause UI errors.
- Fixed an issue where moving items around in the guild bank could cause UI errors.
- Fixed several issues with context messages for mail, as well as fixing an error that would cause items to be falsely announced to the player if they attempted to loot and one or more items were unable to be looted due to lack of inventory space.
- Justice confiscation messages reverted to display 1 item per line again - the multiline print from it was causing issues when enough items were removed at once.
- Fixed several issues with currency announcement formatting - most importantly the total value will now correctly separate large numbers with commas (or relevant localization)
- Fixed an issue where purchasing mount riding skill upgrades also printing a bag space upgrade message with both components active.
- Fixed an issue where Achievement details were not displaying correctly in the Achievements component.
- Show destroyed items and show confiscated items now also applies to EQUIPPED items.
- Major update to Loot Announcements - Now looted items will be indexed and printed in a more accurate fashion. This means some odd events that didn't trigger a loot message before such as obtaining a ring of Mara, receiving loot from the Dark Brotherhood Supplier, or purchasing items from the Crown Store will now show a loot message.
- Crafting Loot Announcements has been updated to now show better context specific messages based off the type of crafting you are performing (ex: Researching a item now shows as [Researched]).
- Quest Announcements: New category added with options to display quests being accepted/failed/abandoned with various additional options and POI discovery/completion options as well.
- Group, Guild and Social Announcements have been split off from the misc menu and now have several addition sub options.
- Loot Announcements: Added color options for [Context Specific] gain or loss messages for currency announcements.
- Experience Announcements: Added option to show Level Icon if the "Total Level" setting is toggled on for experience gain.
- Experience Announcements: Added option to display enlightened state changes.
- Social Announcements: Added Dueling
- Misc Announcements: Added option to display "Inventory is Full" messages.
- Misc Announcements: Added Pledge of Mara
- Misc Announcements: Added /stuck messages
- Loot Announcements: New option to display when a Collectible is unlocked.
- Loot Announcements: Added toggle option to show when a lockpick is broken.
- Loot Announcements: Added a new option to display when a disguise is equipped/unequipped.
- Misc Announcements: Added new component for Disguises that displays a message when you enter/exit a Disguise state (entering/exiting the relevant area for the disguise). These messages are context specific based off the disguise.
- Misc Announcements: Added new component for Disguises that displays a warning message and plays an alert sound when the player is near a Sentry NPC or performing suspicious activity.
- New throttle options: Added a throttle (delays printing of gains) and a threshold option (prevents display of values under a certain value) for Gold/AP/TV gain in Combat to prevent spam.
- Currency Announcements: Added an option to HIDE the display of Guild Trader posting fee gold loss. This is intended as an option for players using AGS (or any other addon that prints a message when an item is purchased from a Trader).
- Group Announcements: Added individual toggles for Group/LFG messages.

Buffs and Debuffs
- Added in icons and custom auras for several champion point passive effects that were missing them.
- Removed pointless buff icons that display for ~100 ms from the Magicka and Stamina restore effects that are applied on the player when resurrected by another player.
- Added icon for generic "melee snare" applied by players in PVP. Updated icon for ghost ability "Haunting Spectre."
- Resurrection Immunity icon will now correctly display if the player relogs or reloads UI after dying and then resurrects.
- PVP Support Line "Guard" ability added to the list of effects that display as "T" toggled.
- Stealth icon now has a "T" toggled indicator.
- Fixed broken links to Poison icons, poisons will now display correctly.
- Updated categorical icon display toggle options to now hide icons for the player or target individually.
- Toggle option added to show/hide BLOCK icon.
- Toggle option added to show/hide Recall Cooldown indicator.
- Toggle option added to show/hide Battle Spirit (individually from Cyrodiil buffs)
- Toggle option added to show/hide ESO Plus Member icon
- New toggle added to display DISGUISED state on the player or target.
- Updated icons for Wild Hunt Crates - Momento Rewards and new poisons
- Updated icons for XP Scrolls, Psijic Ambrosia, Mythic Aetherial Ambrosia
- New icon added for Resurrection Immunity & Recall Cooldown
- Added aura for Skyshard Collect and Mundus Stone use.
- Added new toggleable display option for various collectibles - Mount, Non-Combat Pets, Assistants, Polymorphs, Skins, Costumes, and Hats. NOTE: These icons automatically adjust and hide each other when an effect is blocking another. For example wearing a polymorph will hide active Skins, Costumes, and Hats. Pets are automatically hidden in Cyrodiil as well.
- Added new toggleable display for disguise equipped.

Unit Frames
- Updated code for resizing and positioning, names should now longer clip into icons on the player bar, and the target bar will no longer fail to shorten the name correctly.
- Removed an unnecessary guild indexing function that was being used to display Guild Icons on Unitframes (now using a far more lightweight solution). This will likely fix issues with the game hardlocking when running LUIE with Guild Notificators.
- Raid frames now display HP value as well as % HP
- Added toggleable option to display ROLE icon on party / raid frames.
- Added toggleable option to color party / raid frames by ROLE.

---

### Version 4.99f

Unit Frames
- Fixed a major error with the option to turn off the display of stamina/magicka bar labels or bar display. Now these features work as intended.
- Fixed an issue where the party leader name on group frames would clip into the other icons.

Chat Announcements
- Fixed an annoying issue where weapon and armor trait crafting items, as well as style materials would display their trait/style.
- Fixed an issue where withdrawing crafting materials from the guild bank was throwing UI errors (if you have a craft bag, the materials attempt to go into it).
- Fixed an issue where removing an item from trade with items remaining in a later slot index would try to display the nonexistent item in the slot and throw an error.
- Fixed broken saved variables in LuiExtended.lua that affected the functionality of chat system settings.
- Fixed the Chat Announcements toggle option to hide materials consumed by crafting - now items will be hidden with the option off, and displayed with the option on.

---

### Version 4.99e

General
- Added a description of the Slash Commands available in LUI to the main Addon settings window.

Chat Announcements
- Sending mail with Gold currency change announcements toggled on, but currency icons off will no longer throw a UI error from attempting to reference an invalid variable.
- Fixed a minor issue where Costume items were being hidden by the Hide Trash chat announcements option.

---

### Version 4.99d

Chat Announcements
- Fixed a silly oversight that caused groups of items looted from the mail to all share the icon of the first looted item. (Accidentally declared a variable as global instead of local).

Buffs and Debuffs
- Fixed a double declaration of a variable in SpellCastBuffs.lua (shouldn't have effected anything, but just in case).

---

### Version 4.99c

Unit Frames
- Fixed an issue with raid frames where players going offline was throwing UI errors.
- Fixed a minor issue with raid frames that caused player names to clip into the OFFLINE label if present.
- The Unit Frames Champion XP bar now shows the correct value for completion toward the next level.

Chat Announcements
- Currency Change Reason 32 (AH Refund) now has a proper context message and will no longer display a debug message.
- Lockpick failure message no longer insults you :-D
- Grey quality clothing looted when stealing, as well as disguises looted are no longer considered trash when the filter option for hiding Trash items is toggled on.
- Disguises have been added into the show prominent loot setting.
- Show only prominent items option no longer unintentionally applies to items received in the mail.
- Made some changes to further integrate the mail components with one another - this should hopefully stop UI errors from being thrown occasionally.

---

### Version 4.99b

Buffs and Debuffs
- Fixed major issue with debuffs not displaying on the player.
- Added separate Player Buff, Player Debuff, Target Buff, and Target Debuff containers when you toggle the Hard-Lock position to Unit Frames option off. This allows you to have separate buff/debuff frames without using the LUI player & target frames.
- Added a toggle option under Buffs and Debuffs to turn off the icon display for Sprint/Gallop

Unit Frames
- Enhanced Party Frames to update more consistently when party members go offline.

Chat Announcements
- Added a toggle option in Chat Announcements to turn off default string enhancements. This was added as a request due to the lack of other localization support currently. I recommend using this setting otherwise unless you are experiencing some sort of conflict with another addon.
- Added a toggle option to complete turn off the Chat Announcements component.
- Fixed an issue that was causing an error to generate when editing settings in the Chat Announcements loot component.

---

### Version 4.99a

General
- File size decreased significantly, previously I had accidentally included various GitHub repository files in the directory.
- Fixed an issue with the /regroup command not displaying names correctly and trying to reinvite before the group was disbanded. (Please let me know if you experience issues with this still!)
- Added a toggle option for social notifications (friend/ignore list messages)

Buffs and Debuffs
- Fixed an issue with debuffs not refreshing correctly when changing targets.

---

### Version 4.99

General
- Added new Slash commands: /home, /disband, /regroup, ginvite1,2,3,4,5.
- Updated options for any messages LUI prints to chat. By default messages are no longer printed to system chat by default. This functionality was intended to allow players using pChat to take advantage of pChat's feature to preserve messages in chat between sessions.
- Timestamp now has more options and the color now matches that of pChat.
- Reorganized the folder structure of the addon, as well as updated Addon libraries.

Combat Info
- Fixed an issue with Ultimate % values not correctly updating outside of combat when swapping weapons.

Buffs and Debuffs
- Adjusted buffs and debuffs component for the new API changes, now players will only be able to see self applied or pet applied debuffs, as well as major/minor category debuffs.
- Updated Major and Minor debuffs to use the new Zenimax icons added to the game in Homestead.
- Implemented horizontal container orientation for long term effects.
- Updated a number of buffs that display a green highlight on the ability bar while their duration is active.
- Updated the duration of ground tracking effects to be more accurate based on cast time. There is still some work to do here.
- Added a significant amount of new icons for player effects - Potions, poisons, food, experience consumables, mementos, and weapon enchants.
- Added a significant amount of new icons for NPC abilities, as well as updating icons for certain player passives, champion point passives with active components, etc..
- Many placeholder icons used by abilities or NPC abilites have been updated.
- Implemented new "fake" buff tracking to display a buff/debuff for effects that normally do not show one in the base game. This includes the weapon and spell damage weapon enchant procs.
- Utilized new "fake" buff option to make a far more accurate display of Stagger effects on players and NPC's. Now for example, when a heavy attack from an NPC is blocked, the stagger effect should appear to smoothly transition into a stun as the mob staggers backwards.
- Altered a significant amount of NPC abilities and quest based buffs and debuffs to correctly display as a buff or debuff if they were not previously, as well as hid multiple useless debuffs that provided no useful feedback to the player.
- Corrected errors with various ability name inconsistency to provide a more polished experience. Renamed the Ability ID for weapon medium attacks so they now properly display as "Medium Attack."

Chat Announcements
- Added option to choose method of name display printed to chat for players - Character Name, Display Name, or both.
- Added option to print Group Event messages to chat - Leaving/joining a group, disbanding, queueing, ready checks, votekicks.
- Added option to print Trade Event messages to chat - Trade invitation and success/cancellation.
- Added option to print Mail Event messages to chat - Mail sent, received, or deleted.
- Added option to print Guild notifications to chat - Invites, members leaving, as well as rank changes.
- Added option to display a message when Bag/Bank space upgrades are purchased, as well as Riding Skill Upgrades
- Added option to display a notification when lockpick attempts succeed or fail.
- Added option to display a message when gold or items are confiscated by a guard.
- Expanded option to display currency changes for Gold, AP, Tel Var Stones, and Writ Vouchers with multiple options for customization.
- Multiple options for currency color, method of display, and syntax are available.
- Updated option to display items looted - with the option to filter certain items, as well as show notible items looted by group members.
- Added option to display inventory changes from selling or buying at a vendor or laundering at a fence.
- Added option to display inventory changes from depositing or withdrawing from the bank.
- Added option to display inventory changes from sending and receiving mail.
- Added option to display inventory changes from trading.
- Added option to display inventory changes from crafting items - with an optional setting to show materials that are consumed.
- Added option to display when items are destroyed.
- Added option to display the Armor Type, Trait, and Style of an item.
- New option to MERGE the results of inventory changes with currency changes where applicable.
- Significantly overhauled the experience component - now allows the display of experience gain and levelups. With options for formatting, and the ability to toggle the display of experience gain in combat.

Unit Frames
- Added the ability to individually control the size of custom Magic and Stamina bar.
- Added the ability to hide the Magicka or Stamina bar labels, or hide the bars entirely.
- Updated the icons on unit frames to be more consistent, as well as replaced the execute skull texture.
- Added option to choose method of name display for player targets - Character Name, Display Name, or both.
