-- Performance Enhancement
local strformat = zo_strformat

local windowManager = WINDOW_MANAGER

-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.
--local memes = zo_iconFormat("LuiExtended/media/changelog/updatenotestemp.dds", 256, 256)

fillMessages = {
    "|cEEEE00General Components|r",
    "• Implemented an in game changelog that will display on the first load with LUIE enabled when the version number is different than your current version. This changelog can also be viewed from the LUIE addon settings menu.",
    "• Added the option to switch between using ACCOUNT WIDE or CHARACTER SPECIFIC savedVariables settings. Profiles can be copied between characters or deleted from the LUIExtended addon menu.",
    "• Separated Slash Commands & Info Panel modules into their own individual menus.",
    "• Updated and cleaned up various menus to be more intuitive.",
    "• Replaced GetSynergyInfo() hook with ZO_Synergy:OnSynergyAbilityChanged() hook in order to fix compatibility issue with Innocent Blade of Aoe addon by dorrino. This is a better way to hook as only the displayed icon is modified and the original synergy info is preserved.",
    "• Update Chat Printing options to allow the option to print to individual tabs instead of all tabs. This allows you to have loot, experience, etc notifications only display in one chat tab. Also added a toggle to allow system/notification based messages to bypass this and still appear in all tabs.",
    "• Added an option to choose the color for timestamps prepended to chat messages.",
    "|",
    "|cEEEE00Buffs & Debuffs|r",
    "• Added the ability to track prominent player buffs & debuffs by name or AbilityId. Prominent containers support the ability to display the aura name and a timer bar.",
    "• Added the ability to blacklist buffs & debuffs by name or AbilityId.",
    "• Updated auras and improved custom icons for various NPC abilities as well as added new icons and updated auras for many NPC's missing them.",
    "• Added auras & icons for Scalecaller Crown Crate memento effects.",
    "• New internal table allows simulated aura display on targets based on name. This allows for the display of buffs such as Radiance on Flame Atronachs and CC Immunity on boss rank enemies.",
    "• Added a Debug option to display the AbilityId of effects on their buff/debuff icon.",
    "• Added Night Mother's Gaze & Line-Breaker into debuffs that always display on a target regardless of source.",
    "• Fixed an unintentional change which modified the Line-Breaker debuff from the Alkosh set to be named \"Roar of Alkosh.\" This should prevent Combat Metrics from combining the two debuffs when reporting uptime.",
    "• Fixed an issue where Off Balance Immunity wasn't displaying on targets and adjusted it to display as a buff rather then debuff. This effect can still be tracked by prominent buffs & debuffs due to its importance.",
    "|",
    "|cEEEE00Chat Announcements|r",
    "• Updated the default variable settings for Alliance Point, Tel Var Stone, and Experience Point notifications so throttling is enabled by default.",
    "|",
    "|cEEEE00Combat Info|r",
    "• Added an option to toggle on/off the display of bar highlight for secondary effects like the magicka restore from Honor the Dead or Major Savagery from Biting Jabs.",
    "• Added option to change the formatting of the Ultimate Percentage Label & set the default font/position to match that of bar highlight.",
    "• Added an option to play a sound on ability procs.",
    "• Anchored bar labels to Action Button instead of flipcards, this stops the label from wiggling erratically when swapping bars.",
    "• Fixed an issue where when bar ability highlight for the Ultimate slot was enabled along with Ultimate % label the two labels would overlap on application for a split second.",
    "• Fixed an issue where the initial bar highlight label created for effects would display the default base ability duration without compensating for the extra duration added to many abilites added by EVENT_EFFECT_CHANGED.",
    "|",
    "|cEEEE00Combat Text|r",
    "• Added an option to set Transparency for Combat Text.",
    "• Added an option to abbreviate numbers like 12345 to 12.3k.",
    "• Updated Incoming Ability Alerts to hide suggested mitigation options by default. Now messages will simply display incoming ability name/icon unless mitigation method notification is toggled on.",
    "|",
    "|cEEEE00Info Panel|r",
    "• Info Panel module has been moved to its own \"LuiExtended - Info Panel\" settings menu.",
    "• Fixed an issue where the Info Panel displayed over other UI menu's by adding it into the Scene Manager.",
    "• Fixed an issue where the \"Feed Now\" timer was clipped.",
    "• Fixed an issue where the Armor Durability indicator was clipped.",
    "• Removed outdated Imperial City Trophy Display & Scaling Options.",
    "|",
    "|cEEEE00Slash Commands|r",
    "• Slash Commands module has been moved to its own \"LuiExtended - Slash Commands\" settings menu.",
    "• Slash commands can now be enabled or disabled individually.",
    "• Added /banker, /merchant, /fence commands to summon assistants.",
    "• Added /ready command to initiate ready checks.",
    "• Added keybinding options for /banker, /merchant, /fence, /ready, /home & /regroup.",
    "|",
    "|cEEEE00Unit Frames|r",
    "• Removed a conditional that colored the AvA rank icon of players of the same faction white. The AvA icon for players of the same faction will now display the proper faction color.",
    "• Added an option to display the AVA Icon & Rank Number independently from the Title or AVA Rank Name on Target Frames.",
    "• Added an option to set the priority for AVA Rank vs Title Display on Target Frames.",
    "• Added individual options to choose the Low Resource threshold for HP/Magicka/Stamina labels.",
    "• Fixed an issue on Target Frames where rank 0 \"Citizen\" players would display with a rank number of \"ava.\"",
    "• Fixed an issue where changing the Player Frames layout would also reset the position of Group, Raid, Boss, and AvA frames.",
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
            luiChangeLog:SetDrawLevel(1)

            -- Add welcome to new version message
            strformat("|c00C000Welcome to version <<1>> of <<2>> by <<3>>\nPlease take a few minutes to read over the list of changes in this version.\nThis notification will only appear once with each update unless opened manually from the menu.|r", LUIE.version, LUIE.name, LUIE.author)
            luiChangeLog:AddText("|")

            -- Add all the changes from fillMessages
            for i = 1, #fillMessages do
                luiChangeLog:AddText(fillMessages[i])
            end

            -- Add message about support and bugreports
            luiChangeLog:AddText("|")
            luiChangeLog:AddText(strformat("|c00C000If you have any feedback, bug reports, or other questions about <<1>> please visit ESOUI or Github bla bla bla more text here where to get support and where to submit bugs.|r", LUIE.name))
            luiChangeLog:AddText("|")

            --[[
            luiChangeLog:SetSlider(23)
            function luiChangeLog:SetSlider(position)
                self:GetNamedChild("Buffer"):SetScrollPosition(position)
                local sliderValue = self:GetNamedChild("Buffer"):GetNumHistoryLines()
                self:GetNamedChild("Slider"):SetValue(sliderValue - position)
            end
            ]]--

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
            luiChangeLog.slider = windowManager:GetControlByName("LUIE_Welcome_ScreenSlider")
            luiChangeLog.slider:SetDimensions(11, 64)
            luiChangeLog.slider:SetThumbTexture("EsoUI/Art/ChatWindow/chat_thumb.dds", "EsoUI/Art/ChatWindow/chat_thumb_disabled.dds", nil, 9, 64, nil, nil, 0.3125, nil)
            luiChangeLog.slider:SetBackgroundMiddleTexture("esoui/art/chatwindow/chat_bg_center.dds")
        else
            --luiChangeLog:SetSlider(23)
            luiChangeLog:SetHidden(false)
        end
    end
    -- Set version to current version.
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
