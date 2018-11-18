-- Performance Enhancement
local strformat = zo_strformat

local windowManager = WINDOW_MANAGER

-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.

local fillMessages = {
    "|cFFA5005.7.2|r",
    "• General - Fixed typos in the RU localization that was causing UI errors. Thank you Jmopel for fixing this!",
    "• General - Fixed an issue with the hook for the Skill Window to add custom passive/racial icons that prevented Harven's Improved Skills Window from working correctly.",
    "• Buffs & Debuffs - Added tooltips for all Warden abilities & for melee weapon abilities.",
    "• Buffs & Debuffs - Fixed broken tooltips on Stealth-Draining / Conspicuous Poison.",
    "• Buffs & Debuffs - Added an aura for the new ID used for Dismount Stun.",
    "• Buffs & Debuffs - When \"Hide Duplicates in Paired Auras\" is toggled in SCB, the Active Effects window on the character screen will also hide the auras.",
    "• Chat Announcements - Occasionally \"Champion Point Gained\" Center Screen Announcements can trigger at the same time, causing the output to display the wrong Champion Points gained. Added a small throttle to prevent this.",
    "• Combat Info - Added a redundant check in Combat Info to stop possible duplicate controls for Bar Highlight from being created and throwing UI errors.",
    "• Combat Text - Reset the \"Interrupt\" notification color due to a formatting error that occured.",
    "|",
    "|cFFA5005.7.1|r",
    "• Unit Frames - Fixed an issue where the default Player / Target / Group frames would fail to display even when enabled in the menu. This setting has been updated and the Saved Variables have been reset. Default Frames will be disabled by default and can be re-enabled by changing the menu option.",
    "|",
    "|cFFA5005.7 (Murkmire)|r",
    "|cFFFF00General:|r",
    "• Did some various minor optimization, removing some old and un-needed functions and adjusting a few functions that were enabled all the time to only be used when relevant options are enabled.",
    "• Fixed font paths for non-English localizations.",
    "• Updated Russian localization with many new translations from KiriX. Thank you!",
    "• Fixed an issue where the new icons added for Cyrodiil Campaign Bonuses were clipping through the rounded frames in the Campaign Window.",
    "• Reimplemented custom icons in the Skills Menu & Skills Advisor for Racials & Various passive skill lines.",
    "|",
    "|cFFFF00Buffs & Debuffs:|r",
    "• Fixed an issue where the Mount icon wouldn't disappear when dismounting in any other way than pressing the mount key. This is due to an issue with the API that should be addressed in a later ESO update.",
    "• Fixed various minor issues with buffs & debuffs from changes made in the Wolfhunter & Murkmire updates.",
    "• Updated tooltips for Champion abilities.",
    "• Updated icons, tooltips, and names for Seasonal Items, Seasonal Experience buffs, and mementos.",
    "• Updated the names & tooltips of various food and consumable items by using the Item Names and Item Descriptions from these items.",
    "• Added duration into most toolips and updated the functions used for this to pull accurate values.",
    "• Updated tooltips for almost all item sets (missing Rewards for the Worthy Sets) and all Classes except Warden. Other skill lines will be processed in the future.",
    "• Added a timer to the \"Battleground Deserter\" debuff - and moved it into the long term effects container if enabled.",
    "• WIP - Started adding support to add a \"G\" label on any buff/debuff effect that is applied while the player is standing in a ground AoE effect. This is only implemented on some abilities but will be expanded in the future.",
    "• Fixed an issue where some undispellable debuffs (read by the game API as buffs) weren't set to debuffs in the Character Screen Active Effects Panel.",
    "• \"Crystal Fragments Proc\" has been renamed to \"Crystal Fragments.\" If you are tracking it by name in a prominent container you will need to update the name. The abilityId remains unchanged.",
    "• Fixed an issue where Prominent buffs with an unlimited duration would duplicate auras when you zoned into a new aura.",
    "• Added fake buffs for Home Keep Bonus & Edge Keep Bonuses to Player/Target when Cyrodiil Buffs are enabled.",
    "|",
    "|cFFFF00Chat Announcements:|r",
    "• Added currency message options for Event Tickets.",
    "• Fixed an issue where sometimes when rapidly looting/stealing items the message context would switch back from looted/stolen to \"received.\"",
    "• Fixed an issue causing Tel'var Stone and Alliance Point transactions not to display the amount of currency spent with the merged message option enabled.",
    "• Updated Alliance Point throttle to include AP earned from Keep Repairs & Resurrecting Players.",
    "• Added a note to specify that the \"Show Used Crafting Items\" option in Loot Announcements doesn't work properly without ESO Plus.",
    "• Fixed achievement tracking categories missing with the Murkmire update.",
    "• Fixed a UI Error that would occur from Disguise Alerts during \"The Colovian Occupation\" quest in Arenthia in Reaper's March. This quest puts you into a disguised state without an item in your disguise slot which was causing errors.",
    "|",
    "|cFFFF00Combat Info:|r",
    "• Added a cast/channel bar for various mementos (replacing the icons that showed on buffs & debuffs previously).",
    "• Added a cast/channel bar for some seasonal quest events & items (replaced the icons that showed on buffs & debuffs previously).",
    "• Fixed an issue causing Crystal Fragments proc not to play a sound or be tracked.",
    "• Fixed a few missing Bar Highlight trackers.",
    "• Fixed an issue introduced with Murkmire where Bar Highlight & Ultimate Tracking was not behaving properly due to relying on a function no longer used by the API.",
    "• Dragonknight - Updated the icon for Power Lash to stand out a little more from Molten Whip.",
    "• Nightblade - Shadow Image now has a unique icon (with similar colorization to the new green color for Incapciating Strike when the player is above 120 ultimate).",
    "• Nightblade - The Proc Icon for Grim Focus and its morphs now shows the remaining timer for Grim Focus on it.",
    "• Sorcerer - Unstable Familiar & Summon Winged Twilight abilities now use different icons on their bar/for their effects. The icons matching the base icon are ingame but for some reason not used.",
    "|",
    "|cFFFF00Combat Text:|r",
    "• Added an option to display Group Member Deaths (enabled by default).",
    "• Updated the variable names for Incoming Ability Alerts - this will reset the color for Block, Dodge, Avoid, and Interrupt notifications. In a previous update Combat Alerts were changed to support multiple colors for the different alert mitigation types to improve clarity - this resets this for anyone who wasn't aware as well as adds a blue color for interrupt instead of white.",
    "|",
    "|cFFFF00Info Panel:|r",
    "• Info Panel no longer shows on all screens (Now hidden in menus, on the world map, and during dialogues).",
    "• Added an option to enable the Info Panel on the World Map Screen.",
    "|",
    "|cFFFF00Unit Frames:|r",
    "• Added Resolution Selection options to UnitFrames, this changes the default anchors for UnitFrames.",
    "• Updated UnitFrame default positions to anchor relative to the center of the screen rather than top left.",
    "• If you are installing the addon for the first time or clearing saved variables - the default unit frames are now disabled by default.",
    "• Added a \"Disable\" option to Default Group Unit Frames. It was confusing not being able to set this to disabled before if you were using Custom Group/Raid Frames.",
    "• Added an option to toggle off the Default Compass Boss Bar.",
    "• Added target Rank Stars to elite enemy NPC frames - this will show 1-3 stars based on the difficulty of the elite mob you are fighting - similar to the default boss/target frames indicators.",
    "• Updated Group/Raid frames to follow this functionality described in the Custom Raid Frames description: \"If custom group frames are unused, then this raid frame will also be used for small groups.\"",
    "• Added an option to color the Target Frame by Player Class - this option takes precedence over Reaction Colors when both options are enabled.",
    "• Fixed an issue where Group/Raid Frames didn't color correctly when no role was detected (in Battlegrounds).",
    "• Fixed an issue where the Mount Stamina bar wouldn't toggle off properly when dismounting in any other way than pressing the mount key. This is due to an issue with the API that should be addressed in a later ESO update.",
    "• Fixed an issue where the shared transparency setting for Group/Raid frames under Custom Raid Frames would be disabled when Custom Group Frames were disabled.",
    "• Flipped the menu order for color Group/Raid Frames by Class/Role. Role color takes precendence and therefore is the later option listed in the menu.",
    --"|",
    --"|cEEEE00Unit Frames|r",
}

function LUIE_WelcomeScreen(menu)
    -- Load LibMsgWin library
    local LMW = LibStub:GetLibrary("LibMsgWin-1.0")

    -- If saved version number is less than current version number then display the welcome screen.
    if (LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion ~= LUIE.version) or menu then
        -- Only create the window if its the first load or the change log is opened - otherwise there's no reason to bother doing so.
        local luiChangeLog = windowManager:GetControlByName("LUIE_Welcome_Screen")
        if luiChangeLog == nil then
            -- Create the changelog window
            luiChangeLog = LMW:CreateMsgWindow("LUIE_Welcome_Screen", strformat("<<1>> Changelog", LUIE.name))

            luiChangeLog:SetDimensions(900, 700)
            luiChangeLog:ClearAnchors()
            luiChangeLog:SetAnchor(TOP, GuiRoot, TOP, 0,100)
            luiChangeLog:SetMouseEnabled(false)
            luiChangeLog:SetMovable(false)
            luiChangeLog:SetDrawLayer(DL_CONTROLS)
            luiChangeLog:SetDrawTier(DT_HIGH)

            -- Add welcome to new version message
            luiChangeLog:AddText(strformat("|c00C000Welcome to version <<1>> of <<2>> by <<3>>\nPlease take a few minutes to read over the list of changes in this version.\nThis notification will only appear once with each update unless opened manually from the menu.|r", LUIE.version, LUIE.name, LUIE.author))
            luiChangeLog:AddText("|")

            -- Add all the changes from fillMessages
            for i = 1, #fillMessages do
                luiChangeLog:AddText(fillMessages[i])
            end

            -- Add message about support and bugreports
            luiChangeLog:AddText("|")
            luiChangeLog:AddText(strformat("|c00C000If you have any feedback, bug reports, or other questions about <<1>> please visit ESOUI (http://www.esoui.com/downloads/fileinfo.php?id=818), GitHub (https://github.com/ArtOfShred/LuiExtended/) or contact ArtOfShred at artofshred@artofshred.net.|r", LUIE.name))
            luiChangeLog:AddText("|")

            -- Create extra backdrop to make the window more visible
            luiChangeLog.extrabackdrop = LUIE.UI.ChatBackdrop( luiChangeLog, nil, nil, nil, 32, false)
            luiChangeLog.extrabackdrop:SetAnchor(TOPLEFT, luiChangeLog, TOPLEFT, -8, -6)
            luiChangeLog.extrabackdrop:SetAnchor(BOTTOMRIGHT, luiChangeLog, BOTTOMRIGHT, 4, 4)

            -- Create the close button
            luiChangeLog.close = windowManager:CreateControlFromVirtual(nil, luiChangeLog, "ZO_CloseButton")
            luiChangeLog.close:ClearAnchors()
            luiChangeLog.close:SetAnchor(TOPRIGHT, luiChangeLog, TOPRIGHT, -12, 14)
            luiChangeLog.close:SetClickSound("Click")
            luiChangeLog.close:SetHandler("OnClicked", function(...) luiChangeLog:SetHidden(true) end)

            -- Adjust default slider bar to look better
            luiChangeLog.slider = luiChangeLog:GetNamedChild("Slider")
            luiChangeLog.slider:SetDimensions(11, 64)
            luiChangeLog.slider:SetThumbTexture("EsoUI/Art/ChatWindow/chat_thumb.dds", "EsoUI/Art/ChatWindow/chat_thumb_disabled.dds", nil, 9, 64, nil, nil, 0.3125, nil)
            luiChangeLog.slider:SetBackgroundMiddleTexture("esoui/art/chatwindow/chat_bg_center.dds")
        else
            luiChangeLog:SetHidden(false)
        end

        local buffer = luiChangeLog:GetNamedChild("Buffer")
        local slider = luiChangeLog:GetNamedChild("Slider")
        buffer:SetScrollPosition(65)
        slider:SetValue(buffer:GetNumHistoryLines() - 65)

    end
    -- Set version to current version.
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
