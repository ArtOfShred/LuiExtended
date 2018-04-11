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
