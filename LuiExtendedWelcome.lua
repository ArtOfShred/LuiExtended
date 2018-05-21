-- Performance Enhancement
local strformat = zo_strformat

local windowManager = WINDOW_MANAGER

-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.

local fillMessages = {
    "|cEEEE00General Components|r",
    "• Added RU Translation thanks to a ton of effort from KiriX!",
    "|",
    "|cEEEE00Buffs & Debuffs|r",
    "• Did a pass on ALL player skill line abilities - updated auras for all abilities with name corrections, icon corrections, and hid unneccessary dummy auras.",
    "• Added custom icons for the attacks used by Nightblade, Sorcerer, and Warden pet abilities.",
    "• Added custom icons for a great deal of NPCs that were missing them including all Dwemer NPCs, Giants, Trolls, Daedric Hungers, Iron Atronachs, etc...",
    "• Updated localization for major/minor debuffs so that all languages will show major/minor debuffs on the target regardless of source.",
    "• Reset the options for \"Display Extra Buffs & Consolidate Buffs\" to account for some changes made with this update as well as added an additional option to consolidate single major/minor auras.",
    "• Grim Focus updated to track its stack count on the duration buff applied to the player.",
    "• Fixed an issue where Ground Mine stacks weren't decremented when a mine triggered if an aura was set to prominent.",
    "• Removed a significant amount of older code related to ground effects that should result in minor performance enhancement.",
    "• Fixed an issue where the Pelinal's Ferocity experience buff was not correctly labeled as an experience buffs for the purpose of hiding it from display.",
    "• Updated auras for various sets, and added updated icons/auras for sets from Dragonstar/Maelstrom Arena, as well as all Summerset sets.",
    "• Fixed an issue where prominent auras weren't removed from tracking when the player died.",
    "• Added the option to display a timer buff when transformed into a Werewolf. This timer will pause at a Werewolf Shrine or when using the Devour passive.",
    "• Fixed an issue where dummy auras added by target name (example: CC Immunity buff added to some boss NPCs) would display on dead targets.",
    "• Fixed an issue where Artifical Effect id's would not refresh when updating settings in the Buffs & Debuffs menu (dummy auras added by ZOS - such as Battle Spirit).",
    "|",
    "|cEEEE00Chat Announcements|r",
    "• Fixed an issue that was causing Disguise Notifications not to display even when enabled.",
    "• Updated Achievement Tracking options with all current categories.",
    "• Added Psijic Order guild reputation tracking.",
    "• Fixed an issue where the menu option to modify the context currency/loot message for \"Spend\" was missing.",
    "• Added a new context message option \"Pay\ for gold given to NPC's in conversation options.",
    "• Jewelry Crafting should now be supported by Loot crafting messages.",
    "|",
    "|cEEEE00Combat Info|r",
    "• Did a pass on ALL player skill line abilities - Bar Ability Highlight tracking is now supported for any ability the player can slot.",
    "• Bar Ability Highlight tracking now supports multi-target tracking, when changing targets the highlighted abilities will update based on what debuffs are currently applied to that target.",
    "• Fixed an issue where the Crystal Fragments proc sound wouldn't play due to a bad variable name.",
    "|",
    "|cEEEE00Combat Text|r",
    "• Fixed an issue where errors would be displayed when the Shorten Numbers option was enabled.",
    "|",
    "|cEEEE00Info Panel|r",
    "• Reimplemented the menu option to change the scaling on the Info Panel for higher resolution displays.",
    "• Mount feed cooldown notification updated from \"Feed Now\" to \"Train Now.\"",
    "|",
    "|cEEEE00Slash Commands|r",
    "• Added the \"/outfit\" \"#\" command. Allows you to swap to an outfit. Also adding keybinding options.",
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
            luiChangeLog:SetDrawLevel(1)

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
        buffer:SetScrollPosition(30)
        slider:SetValue(buffer:GetNumHistoryLines() - 30)

    end
    -- Set version to current version.
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
