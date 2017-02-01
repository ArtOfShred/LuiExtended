# Lui-Extended

Utilizing GitHub to attempt to keep a transparent and organized workflow. Feel free to contribute ideas on EsoUI and I'll add them into potential projects or issues!

Current project goals:

Short term - Clean up minor issues with the UI, add better customization options for size of custom unit frames, buff tracker, and combat text.

Long term - Using custom overides, complete replacement of icons for abilities used in the game that currently do not have icons - as well as fixing placeholder or pointless buffs to no longer display and fixing buffs that currently do not have an aura to display. Integration with CombatCloud and plugin for CombatMetrics.

Massive spreadsheet tracking for Buff/Debuff issues present here. Goal is for this spreadsheet to also serve as a modders resource, and a bug tracker for inconsistencies with abilities in the game to report to Zenimax: https://docs.google.com/spreadsheets/d/1YOCz2ESzmdcs-QZ4whVNtcFDtcglpbiv-VYxUhZHGpk/edit#gid=709796411

CHANGELOG:

1-28-17:
- Initial Upload complete for BETA version 
- LootLog update (by psypanda)
    - Added Setting "Show only notable self Loot" (Idea and some code stolen from LootLog - thanks!)
    - Added Setting "Show Item Trait" (Idea and some code stolen from LootLog - thanks!)
    - Added Setting "Timestamp Format" (CreateTimestamp() function borrowed from pChats - thanks!)
    - Changed the color code of the Timestamp to match pChats default
    - Changed printToChat() function (Still left old one commented out)
    - Fixed missing Timestamp on group join/leave events
    - Added a small Blacklist for LootLog to hide certain annoying items to prevent chat spam. (In the future we could create a setting for each one of them if needed)
- Minor Update
    - Fixed Ultimate % value not correctly updating outside of combat
    
2-01-17: Minor update
    - Added Horizontal tiling method for Long Terms Effects container
    - Vertical Long Term Effects container can now be oriented from top/center/bottom just like Horizontal can be aligned to left/center/right. Note - unfortunately changing the sorting order to be different for individual bars is not possible, it would require a significant rewrite to do so, perhaps I will reach the potential to do so in the future.
    - Previous issue of Font Options being very limited resolved by updating to the latest version of LAM (thanks again psypanda!).
    - Updated version number to 4.99 BETA and updated API version to 100018 for Homestead
    - NOTE that I slightly changed the backdrop size for buffs and the thickness of the radial countdown that goes around buffs or debuffs to look better with DarkUI frames. This is temporary or will have a toggle option at some point, apologies if it looks iffy on default UI at the moment.


Lui code is intended to be open source. Feel free to suggest or make contributions!
You are welcome to copy and edit any code and features as long as they are not sections tagged as pulled from another addon.
