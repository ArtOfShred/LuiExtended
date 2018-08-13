-- Performance Enhancement
local strformat = zo_strformat

local windowManager = WINDOW_MANAGER

-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.

local fillMessages = {

    "|cFFA5005.6 (Wolfhunter)|r",
    "|cFFFF00General:|r",
    "• Temporarily removed custom icons for passives and racials in the skill tree due to the related functions for this being changed in the update. I intend to reimplement this in the future.",
    "• Fixed various localization issues with some components.",
    "• Moved UnitFrames, Buffs & Debuffs, Combat Text, and Info Panel components down to lower draw layers (preventing them from overlapping low priority layer custom addon windows).",
    "|",
    "|cFFFF00Buffs & Debuffs:|r",
    "• It may have been possible for debuffs not cast by the player to display in prominent buffs - added a filter to only show debuffs sourced from the player.",
    "• Fake & Consolidated Buffs & Debuffs can now be added to Prominent Buffs & Debuffs or the Blacklist by AbilityId.",
    "• Mousing over buffs & debuffs now shows the tooltip information.",
    "• Right clicking on buffs that can be removed will now remove the buff.",
    "• Updated & added custom tooltips for many abilities - as well as added normalized tooltips for Major/Minor effects.",
    "• Updated icons + auras for Main Story Quests, Fighter's Guild, Mage's Guild & the first 2 (about 50% of Greenshade as well) zones of AD quests.",
    "• Updated icons for NPC summon abilities (Each summon type now has an individual icon).",
    "• Hid various dummy id's for NPC summon abilities & NPC Caltrops.",
    "• Fixed an issue where NPC name based icon/name overrides for pets didn't apply to the Death Recap Screen.",
    "• Buff Icon for Vanity Pet / Mount now shows the actual collectible icon overlaid over a background (Added an option to show the generic mount icon if desired).",
    "• Added cast bar for various general effects such as Filleting Fish, using Keep/Imperial City Retreat Sigils, Pardon Edicts, etc...",
    "|",
    "|cFFFF00Chat Announcements:|r",
    "• Added an option to show when items are removed by quests or events. This requires the destroyed item message display option to be enabled (Otherwise can't tell if a player just destroys an item).",
    "• Removed hook for EVENT_BROADCAST - stops duplicate server shutdown messages from being displayed.",
    "• Updated Achievement Tracking Categories to support all achievement categories (they have been branched out again with Wolfhunter DLC).",
    "• Added some additional conditionals to messages displayed when upgrading an item in order to prevent errors.",
    "|",
    "|cFFFF00Combat Info:|r",
    "• Added option to resize Cast Bar & Cast Bar Icon.",
    "• Cast Bar frame is now centered by default, and resizing keeps the bar centered.",
    "• Cast Bar - Significantly improved the display options when unlocking the Cast Bar in the menu to adjust position.",
    "• Cast Bar will now break when incoming hard CC hits the player - or when the player rolls/blocks.",
    "• Fixed a bug where Bar Highlight effects that were created by EVENT_COMBAT_EVENT would be removed when mousing over another target.",
    "• Added cast bar indicators for for Main Story Quests, Fighters Guild, Mages Guild & the first 2 (about 50% of Greenshade as well) zones of AD quests.",
    "• Added cast bar for Soul Gem Resurrection.",
    "|",
    "|cFFFF00Combat Text:|r",
    "• Combat Text menu completely reorganized in order to be more accessible. All options are now categorized together (I.E. all options for Outgoing Damage, Healing, etc are grouped together now rather than being split across multiple submenus).",
    "• Updated Alerts to use different colors for each type of alert in order to improve differentiation.",
    "• Updated Alerts to use conditionals to determine if \"Name\" or \"No Name\" prefixes should be used. These options have been added to the menu as well.",
    "• Fixed an issue where custom icons/ability names based off target name were not displaying correctly.",
    "• Added the silence effect from Negate Magic & Morphs to the blacklist for SCT - this will no longer spam immunity notifications every .5 seconds on CC Immune targets.",
    "|",
    "|cFFFF00Unit Frames:|r",
    "• Fixed a major issue where Unit Frames did not properly follow the Account Wide / Player Specific saved variable settings in the menu.",
    "• Added right click handler for Group Frames - you can now acccess group menu functions by right clicking frames.",
    "• Fixed an issue where disabling the option to display the player in Small Group frames would cause the role of class color to be incorrect.",
    "• Added Group Frames, Raid Frames, and Boss Frames into \"loot\" scene to prevent those frames from disappearing when looting an item.",
    "• Added tooltips to Custom Frames - Alternate Player Bar( for level information, Siege, Werewolf, and Mounted Status).",
    "• Alternate Player Bar - Champion XP bar now shows Enlightenment value.",
    "• Fixed an issue where frames weren't added to the \"siegeBarUI\" scene - causing your frames (and buffs if anchored) to fade when typing in chat or switching to mouse controls while using a Siege weapon.",
    "|",
    "|cFFFF00Werewolf Specific Changes:|r",
    "• Werewolf Buff Indicator (Buffs & Debuffs) & Power Bar (Unit Frames) now behave correctly when dead/reincarnating.",
    "• Fixed issue with Werewolf buff icon bouncing back and forth between effects that had a longer duration than it (due to forcing it to always have a maximum duration of 38 seconds).",
    "• Devour Cast Bar now ends when devour channel is broken.",
    "• Devour now pauses Werewolf Timer buff when starting and resumes immediately when ending.",
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
        buffer:SetScrollPosition(41)
        slider:SetValue(buffer:GetNumHistoryLines() - 41)

    end
    -- Set version to current version.
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
