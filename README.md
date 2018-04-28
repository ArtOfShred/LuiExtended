# Lui Extended [![Current Release](https://img.shields.io/github/release/ArtOfShred/LuiExtended.svg)](https://github.com/ArtOfShred/LuiExtended/releases) [![GitHub license](https://img.shields.io/github/license/ArtOfShred/LuiExtended.svg)](https://github.com/ArtOfShred/LuiExtended/blob/master/LICENSE)

LUI Extended is an addon that adds multiple custom components including
- **Unit Frames** - Custom Unitframes for Player/Target, Group, Raid, and Bosses. Color group and raid frames by Class or Role, track power changes, armor changes, and dots with animations on the frame.
- **Buff & Debuff Tracking** - Track buffs and debuffs with new custom icons and significant enhancements to auras done by using a manual override table.
- **Chat Announcements** - Display messages in chat when spending or receiving currency, track loot, achievements, experience gain, social events, guild invites, quests, and more.
- **Combat Info** - Track your GCD, Ultimate Value, Quickslot Cooldown, & Highlight Active Abilities on your bar
- **Combat Text** - Display your outgoing and incoming damage/healing, track crowd control, track incoming damaging abilities with a new warning system, and monitor your resource gain.
- **Slash Commands** - Add useful commands to the game such as porting to your primary home, regrouping and more.

Initially this [Elder Scrolls Online][1] addon was based partially on the [LUI][2] addon by LoPony and some features of [Foundry Tactical Combat][3] addon.

## Features
* **Buffs & Debuffs Tracking**
    - Track buffs & debuffs on Player & Target as well as ground targeted buffs & debuffs.
    - Filter various buffs & debuffs to hide from display.
    - Custom tracking for events that do not normally create buffs - Sprinting, Galloping, Resurrection Immunity, Stealth & Disguise State
    - Track additional useful information - When you have Active Mount, Active Pet, Active Assistant, Active Disguise, and monitor Recall Penalty timer
    - Manual override table hides the display of numerous dummy buffs & debuffs that provide no useful information to the player.
    - New custom icons with backgrounds normalized per type. Standard abilities like dodge or block use a standardized "Innate" background, weapon attacks use the "weapon" background, etc...
    - Custom icons added for Potions, Poisons, Food, & Mementos.
    - Custom icons for Champion Point Abilities, Item Sets, Weapon Abilities, and many NPC abilities.
* **Chat Announcements**
    - Currency Spent & Received
    - Items looted & loot acquired by group members
    - Experience Points gained
    - Guild reputation (Guild Skill line experience) earned
    - Skill points earned and skill advancements
    - Collectibles, Lorebooks, and Achievements
    - Level Up Notifications
    - Skill Points & Skill Line Progression
    - Group, Trial, & LFG Events
* **Combat Info**
    - Track Global Cooldown (based off the unimplemented ZOS method) with various customization options!
    - Track the duration of active abilities on your bar (With the ability to toggle labels on/off).
    - Track your current ultimate value, percentage, and display a backdrop texture when generating ultime.
    - Track the cooldown of your quickslot items.
* **Combat Text**
    - Choose from 4 different display methods: Ellipse, Scrolling, Cloud, or Hybrid
    - Display Combat Text for incoming/outgoing healing & damage
    - Choose font format, color for text, message format, and toggle icons on or off
    - Track incoming/outgoing Crowd Control & Low Resources
    - Notifications when entering/exiting combat
    - Override critical damage and incoming damage colors to emulate ZOS combat text.
    - New Custom Alerts system notifies you when an ability is incoming and the methods in which it can be mitigated. This feature allows you to customize formatting options as well as customize ranks of enemies to display the alerts for.
* **Unit Frames:**
    - Custom Player/Target, Group, Raid, Boss, and PVP Unit Frames
    - Choose from multiple formats for labels
    - Display an overlay for active shield effects
    - Color Group & Raid Frames by Role or Class Color
    - Track Hots/Dots with animated arrows
    - Track Power Gain/Loss & Armor Increase/Decrease with animations and texture overlays
    - Hide frames in or out of combat
    - Anchor LUIE Buffs & Debuffs to custom unit Frames
    - Optionally overlay default frames with new label formatting
* **Slash Commands:**
    - `/home` - Teleport to your primary home
    - `/regroup` - Save your current party, disband, and then reinvite the members.
    - `/campaign` - Queue for a Cyrodiil Campaign
    - `/disband` - Disband your current group
    - `/leave` - Leave your current group
    - `/kick` & `/votekick` - Kick a member from the group if you're a leader or initiate a votekick.
    - `/guildinvite`, `/guildkick`, & `/guildquit` - Commands to invite, kick, or leave a guild
    - `/friend` & `/ignore` - Send a friend request or add a player to your ignored list.
    - `/unfriend` & `/unignore` - Remove a friend or remove a player from your ignored list.
    - `/banker`, `/merchant` & `/fence` - Summon your Banker/Merchant/Fence Assistant.

## Information
[Massive spreadsheet tracking for Buff/Debuff issues present here.][4]
Goal is for this spreadsheet to also serve as a modders resource, and a bug tracker for inconsistencies with abilities in the game to report to Zenimax.

LUI code is intended to be open source. Feel free to suggest or make contributions!
You are welcome to copy and edit any code and features as long as they are not sections tagged as pulled from another addon.

## Disclaimer
*This Add-on is not created by, affiliated with or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.*

  [1]: https://www.elderscrollsonline.com
  [2]: http://www.esoui.com/downloads/info413-LUI.html
  [3]: http://www.esoui.com/downloads/info28-FoundryTacticalCombat.html
  [4]: https://docs.google.com/spreadsheets/d/1YOCz2ESzmdcs-QZ4whVNtcFDtcglpbiv-VYxUhZHGpk/edit#gid=709796411
