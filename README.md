# Lui-Extended

Utilizing GitHub to attempt to keep a transparent and organized workflow. Feel free to contribute ideas on EsoUI and I'll add them into potential projects or issues!

Current project goals:

Short term - Clean up minor issues with the UI, add better customization options for size of custom unit frames, buff tracker, and combat text.
Long term - Using custom overides, complete replacement of icons for abilities used in the game that currently do not have icons - as well as fixing placeholder or pointless buffs to no longer display and fixing buffs that currently do not have an aura to display. Integration with CombatCloud and plugin for CombatMetrics.

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
    
- Minor update
    - Fixed Ultimate % value not correctly updating outside of combat


Lui code is intended to be open source. Feel free to suggest or make contributions!
You are welcome to copy and edit any code and features as long as they are not sections tagged as pulled from another addon.
