Version 4.99b
- Fixed MAJOR issue with debuffs not displaying on the player.
- Added separate Player Buff, Player Debuff, Target Buff, and Target Debuff containers when you toggle the Hard-Lock position to Unit Frames option off. This allows you to have separate buff/debuff frames without using the LUI player & target frames.
- Enhanced Party Frames to update more consistently when party members go offline.
- Added a toggle option under Buffs and Debuffs to turn off the icon display for Sprint/Gallop
- Added a toggle option in Chat Announcements to turn off default string enhancements. This was added as a request due to the lack of other localization support currently. I recommend using this setting otherwise unless you are experiencing some sort of conflict with another addon.
- Added a toggle option to complete turn off the Chat Announcements component.
- Fixed an issue that was causing an error to generate when editing settings in the Chat Announcements loot component.

Version 4.99a
- File size decreased significantly, previously I had accidentally included various GitHub repository files in the directory.
- Fixed an issue with debuffs not refreshing correctly when changing targets.
- Fixed an issue with the /regroup command not displaying names correctly and trying to reinvite before the group was disbanded. (Please let me know if you experience issues with this still!)
- Added a toggle option for social notifications (friend/ignore list messages)

Version 4.99
- Tons of new icons for various player passives and NPC abilites
    - Part of an ongoing effort to remove placeholder icons from the game, I've created a steadily growing set of new icons for various NPC abilities. Note that there are still MANY things to do here, this is just the start.
- New icons for Potions, Poisons, Consumables and Momentos
    - Potions and Poisons now have their own buff or debuff icons depending on context. Unique food and drink items now have unique icons. Standard food and drink types share the same buffs depending on quality and stats, the icons have now been updated to show the quality of the food buff.
- Implementation of new Zenimax Major/Minor Buff & Debuff icons
    - With the release of Homestead, Zenimax added new icons to game for major and minor buffs and debuffs. These will likely be used when Zenimax implements their own buff frames. LUI is now currently using these icons. If you prefer the old style icons, I'll be uploading a small override file you can use in a bit.
- Overhaul of Chat Announcements
    - Display notifications for Experience gain in and outside of combat.
    - Display Gold, AP, TelVar, or Writ Voucher gains and losses with context sensitive messages
    - Display items acquired via looting, mail, trading, crafting, vendoring, banking, and questing. With the option to display Trait, Armor Type, and Style as well.
    - Option to display items consumed when crafting, items destroyed, and items confiscated by guards.
    - Potential to combine vendor item purchase notifications with the relevant currency change.
    - Display Group messages when players leave or enter a group, and LFG votekicks, ready checks, and queue status.
    - Display Guild invitations, members joining or leaving, rank changes, and MOTD changes.
    - Display Social notifications for friends invitations, friend list changes as well as ignore list changes.
    - Display custom notifications for various activities such as receiving mail, upgrading bag/bank space, horse upgrades, lockpicking.
    - Extensive control of formatting options for messages displayed to chat.
- New Slash Command Features
    - /home - Returns you to your primary home.
    - /disband - Disbands your current group.
    - /regroup - A simple single command for group leaders, will disband your current group and then reinvite all party members back shortly after.
    - /ginvite1/2/3/4/5 "name" - Option to invite a player to a guild.
    - Expect more slash commands to appear in future updates!
- Additional Noteworthy Changes
    - Ability to individually control the size of custom Stamina and Magicka bar.
    - Ability to hide the resource label or entire Stamina or Magicka bar.
    - Long Term Buffs container now supports horizontal orientation!
    - Fixed ultimate % value not updating correctly when bar swapping outside of combat.

Version 4.35
- Buff: Added Magicka Bomb to Debuffs re-adjusted some vMOL debuffs and replaced rending slashes with the actual icon instead of the bleed tick icon.

Version 4.30
- Unit Frames: Fixed smooth transition
- Transition from Veteran ranks to Champion points after 50*
- Buff: Fixed issues with black box on buffs and added vMOL buffs
- Bug fixes

Version 4.14
- Unit Frames: Added option to display shield bar as separate from health
- Unit Frames: Added option to shorten numbers from 12,345 to 12.3k
- Bug fixes

Version 4.13
- Info Panel: added option to disable colouring of FPS/Latency
- Unit Frames: Fixed small misalignment in raid group when having more then 1 column and spacing enabled
- Unit Frames: Added configuration option to set custom transparency when In-Combat

Version 4.12
- Added 13 fonts from Combat Cloud addon; added optional dependency on LMP library to theoretically fetching more fonts from other addons that uses that library. You can select those new fonts in Unit Frames module. No additional fonts for Combat Info module yet
- Lots of various minor and not changes all over the addon code

Version 4.11
- Only API version bump. Everything seems to work without any further changes. Not really tested much though.

Version 4.10
- Buffs: added back timer on Vampire Stage 1-3 buff on player
- Various fixes here and there; typos

Version 4.9
- Buffs: added option to manually select direction of sorted buffs (LtR vs RtL)
- CombatLog: to log incoming debuffs events
- DamageMeter: added logic to count how many actual mobs were damaged

Version 4.8.a
- CombatLog: added option to adjust combat log font size manually

Version 4.8
- CombatInfo: added 'Cleanse Now!' alert
- CombatLog: added more colours to messages and increased font size by 1
- CombatLog: added option to auto-focus corresponding chat tab during combat
- CombatLog: added option to save last 20 messages during logout

Version 4.7
- CombatInfo: changed back the default (for new installations) cloud-like floating text
- CombatInfo: added options to filter out healing and dots events (in- and out-)
- CombatInfo: added more colouring to cloud-like floating labels when damage-dependent colouring option is on
- UnitFrames: fixed smooth target health bar transition on target change

Version 4.6
- Info Panel: fixed IC trophies panel items
- UnitFrames: added smooth transition effect to custom bars (can be disabled in menu)
- Buffs: filtered out _some_ effects, that come usually (f.e. boundless storm, volatile armor, combat prayer)

Version 4.5
- Combat Log: (new) added as a part of Damage Meter module.
- Buffs: fixed issue when buffs were disappearing on character death
- Scrolling combat text: added option to drop some events if queue is getting too long
- Info Panel: added 3rd row (off by default) to track IC trophies
- Various minor fixes and optimizations

Version 4.4
- Buffs: re-added option for cooldown UI element on short buffs icons.
- Buffs: added option to select in what format to display remaining numbers ("%.1f" vs "%.2d")
- Various fixes in other modules

Version 4.3
- Buffs: added option to change font on icons
- Buffs: re-implemented option to split players buffs into 2 windows (short/long). The alignment of long buffs as of now fixed to be vertical.

Version 4.2-beta
- Damage meter: added abilities icons into full damage details window
- Buffs: re-added manual tracking of effects whose information is not provided by API (Negate, Liquid Lighting, Runes, etc).
- Known issue: manual tracking of ground-targeted skills from time to time wrongly triggers creation of custom buff icon when the use of the skill was canceled

Version 4.1-beta
- Various fixes in all modules
- Buffs: First part of reworked Buffs/Effects tracking. Some work is still required

Version 4.0-beta
- Updated all modules for new ESO API
- Combat Info: updated scrolling text to include more skill names.
- Buffs/Debuffs: currently being refactored to work better with new API. Most of the core functionality is present, but it requires more patching and testing.

Version 3.10
- Custom Unit Frames: added another target frame which will display only PvP targets
- Combat Info: tweaked a little existing cloud-like floating labels
- Combat Info: added completely new scrolling text labels. You can switch between existing and new ones, or you can have both of them (though a bit unpractical)

Version 3.9
- Long-term buffs: added option to enable buff icons only for player and not for target
- Custom Unit Frames: Player and Target bars width can be controlled independently
- Custom Unit Frames: Added label to display current anchored position of frames when they are unlocked.

Version 3.8
- Default Unit Frames Extender: added option to change overlay labels colour
- Ultimate Generation Tracking was moved to Combat Info module. Not it will display glowing texture under Ultimate skill button

Version 3.7
- Fixed Achievement reporting on French clients
- Changed icons on Damage Meter mini panel
- Added option to force ChampionXP display for v1-v13 characters

Version 3.6
- Damage Meter: added graph plot feature
- Fixed several minor bugs

Version 3.5
- Long-term effects: added Crystal Fragment Proc to ignored buffs. Now this effect is tracked only in Short-term buffs module
- Chat Announcement: added achievement tracking routines (disabled by default)

Version 3.4
- Custom Unit Frames: added option for shield bar to be full-height instead of default half-height one
- Custom Unit Frames: added option for target frame to show large skull texture when target should be executed (enabled by default)
- Short-term buffs: Stealth custom buff icon is now optional and can be disabled via settings menu

Version 3.3
- Default Unit Frames: changed default font to be consistent with other default UI elements; added options to customize this font
- Default Unit Frames: added Friend/Ignore/Guild icon to default UI small group frames
- Custom Unit Frames: changed left label on target control for critter units. Now it will read as "-critter-" instead of default "9 / 9" health values. Right label will be hidden for critters

Version 3.2
- Unit Frames: Friend/Ignore icon is now Friend/Ignore/Guild, i.e. it will track now if player is if one of your guilds
- Unit Frames: this Friend/Ignore/Guild was added to Custom Small Group frames and Default Target frame to the right of unit name
- Custom Unit Frames: changed position of Leader icon on Custom Small Group frames
- Custom Unit Frames: added options NOT to sort raid size group alphabetically and to add small vertical spacers for every 4 raid members. This way the ordering and grouping of members _should_ correspond to default UI one, though it was not well tested
- Combat Info: added EXPERIMENTAL option to Throttle (group similar) damage and heals events

Version 3.1
- Custom Unit Frames: revised group update code to solve (hopefully) short freezes during raids
- Damage Meter: changed mini-panel default backdrop texture
- Damage Meter: added option to make it completely transparent
- Damage Meter: added option to hide combat time label and have only 3 other visible

Version 3.0
- Custom Unit Frames: fixed issue with experience bar for vr1-vr13 players (I hope so)
- Custom Unit Frames: added IsFriend/IsIgnored icon to target frame
- Short-term buffs: added option to change alignment of icons within holding container
NEW: Chat Announcement Module.
- Prints to chat information on Looted items, Gold and XP changes, Group events.

Version 2.15
- Short-term buffs: updated code for spell activation detection. This should help with ground-targeted spells.
- Custom Unit Frames:
- - Added separate options to display experience bar and Mount/Siege/WW
- - Added option to set colour of ChampionXP bar according to champion point being earned; changed textures of champion point.
- - Size of this alternative bar will now scale with size of the font used

Version 2.14
- Info Panel: added option to change panel scale. This should help on screens with large resolution
- Short-term buffs: rewritten potion tracking algorithms, added passive skill effects tracking
- Short-term buffs: added code to remove 'Mines' target debuff on first activation. This relates to Fire Rune and Daedric Mines

Version 2.13
- Combat Info: rewritten UI part of module. Now different floating text areas are unlockable and movable
- Ultimate Tracking: added option not to hide %% value when > 100%
- Info Panel: added option to toggle information parts to display
- Short-term buffs: added custom "stealth" buff icon

Version 2.12
- Unit Frames: Increased maximum font and sizes of frames, optimized layout for extra large sizes
- Unit Frames: Experience alternative bar will show ChampionXP only for level cap players. For vr1-vr13 it will continue to show your veteran rank progress
- Combat Info: Experience floating text will take account Enlightened buff for vr14 players, i.e. the numbers displayed will relate to ChampionXP instead of raw one
- Long-term effects: added option to hide Cyrodiil buffs
- Short-term buffs: added "toggle" texture for skills: Surge, Momentum and Entropy

Version 2.11
- Unit Frames: Fixed issue that prevented frames to be unlocked for moving
- Ultimate Tracking is merged into Combat Info module
- Damage Meter: Finally completed code to display full damage statistics. Credits goes to FTC: in my version just the layout is a bit different; the code co collect statistics is almost identical to FTC one. To display statistics you can setup key binding or click on fight time label on damage meter mini panel

Version 2.10
- Short-term buffs: Added (optional) in-combat ultimate gain icon
- Combat Info: Added (optional) floating text for interruption and stunned effects as well as miss and reflected events

Version 2.9
- Added Bosses encounter separate frames. When you are in dungeon and near Boss zone, new frame will appear and show current status of up to 6 bosses as thought by game API

Version 2.8
- Added option to display target players class as a text label (disabled by default)
- Added feature to blink player power bars when you are out of power
- Optimized inventory lookup code in Info Panel, so it safely ignores game flooding of evens when you are caught stealing by the guard
- Adjusted a little timing settings for small floating labels in Combat Info module

Version 2.7a
- Added option to enable each component in default and custom frames independently of each other
- Added new option for name colouring for Friendly Players targets
- Fixed bug introduced in previous release
- Added Proc animation over ActionBar slot for Crystal Fragments passive

Version 2.6 - Custom Frames fixes
- Added options to change all sizes of player and target custom frames
- Many bugfixes and improvements

Version 2.5 - Custom Frames fixes
- Added option to disable alternative bar on player custom frame
- Added options to change all sizes on group and raid custom frames
- Adjusted the way visuals are displayed on player and target frames
- Many bugs were fixed and a lot of code optimized

Version 2.4 - Custom Frames fixes
- Added option to disable default target frames when default unit frames extender is not used
- Added option to exclude yourself from small group custom frames
- Added new visuals for increased/decreased armor and increased power on player and target frames (optional)

Version 2.3
- Bug fixes to previous release
- Added option to disable default player frames when default unit frames extender is not used
- Added Small Group Custom frames.

Version 2.2 - new Unit Frames:
Combat Info:
- added option to select font sizes for scrolling text
- changed routing for outgoing healing
- added option to colour outgoing damage according to damage type
NEW: Custom Unit Frames.
- Contains previous Default Unit Frames Externder module
- Provides new Custom Frames for Player, Target, (Raid)Group
- Allows to lock position of short-term buffs and debuffs to corresponding unit frames

Version 2.1:
- Added option to select between 3 font families for floating combat text
- Added display of attributes drained/energized events
- Minor fixes to buff tracking modules

Version 2.0:
- API version bump 100011
- Dropped CrystalFragmentProc module, as now API provides needed info
- Rewritten Short-term buffs module is the same way as FTC was modified
- Default Unit Frames module now put commas into long numbers
- Updates to colouring of reticle.

Version 1.19 - pre Update 6:
- Updated LAM to r17
- Added compatibility code to mount feed timer, so it does not give error on PTS
- Added new manual "Recall" long term effect timer
- In CombatInfo module: the previously queued areas now display numbers as they appear in game events

Version 1.18:
- Added combat status "In/Out Of Combat" alert (disabled by default)
- Bug fixes in Default Unit Frames module, related to group member shields

Version 1.17:
- Added option to disable all icons in Combat Info module
- Code cleanup in some other modules

Version 1.16: ( failed to upload )
- Added more combat tips alerts, rewritten corresponding settings menu
- Added weapon charges tracking into Info Panel

Version 1.15:
- Fixes for previous release
- Added option to menu to actually switch on and off Combat Tips alerts
- Changed default font for Combat Alerts

Version 1.14:
- NEW: Alerts for active combat tips in Combat Info module
- NEW: Group Members class icons in Default Unit Frames extender module

Version 1.13:
- NEW: Damage Meter is enabled by default now
- Player class now properly position without gap left to target level
- More missing icons for synergies and weapon enchantments

Version 1.12:
- NEW: Displays player class icon for current target
- More missing icons for sorc pets and lightning staff

Version 1.11:
- Added some missing icons for floating text damage in Combat Info module
- Added option to change color of reticle according to target reaction in Default Unit Frames module

Version 1.10:
- Default Unit Frames module now displays health and shield numerical values for small group members

Version 1.9.2:
- Minor tweaks to Combat Info Module
- Again commented out Damage Meter.

Version 1.9.1:
- Updated to add more options to Default Unit Frames module

Version 1.9:
- NEW: Default Unit Frames Extender module
- NEW: Long-term Effects Tracker
- Minor updater here and there

Version 1.8:
- Added tracking of used potions into Shot-Time Buffs module
- Rewritten localization module. Full localization for German and French game clients

Version 1.7:
- More customization of how short-time buffs looks
- Adjustments to Combat Info module, so floating text will be more spread on screen

Version 1.6:
- Reworked settings menu
- NEW: (optional) Fadeout expiring buffs icons (disabled by default)
- Minor bug fixes here and there

Version 1.5a:
- Info Panel can be unlocked via settings and moved to desired position on screen

Version 1.5:
- NEW: Prints to chat name of player who has joined and left your group
- Added vampire feeding 5.5-seconds buff icon

Version 1.4:
- Added routines to create 10-seconds Resurrection Immunity buff on player when the soul gem is used to revive
- Some adjustments to spells timing table

Version 1.3:
- Code optimization in InfoPanel
- Added proper icon to UltimateReady alert
- Added several missing translations of spells

Version 1.2:
- Partial localization. Though some of the abilities names are still missing
- New feature: low health/magicka/stamina alert
- Proper handling of Burning effect from EVENT_COMBAT_EVENT to display 4-seconds debuff on target
- Code optimization

Version 1.1:
- Proper handling of ground targeted abilities
- Removal of shield short-time buffs when shield disappears before expiration time
- Removal of buffs and debuffs when player or target dies

Version 1.0:
- Initial release