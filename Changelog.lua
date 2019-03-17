-- Performance Enhancement
local strformat = zo_strformat

local windowManager = WINDOW_MANAGER

-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.

local fillMessages = {
    "|cFFA5005.8 (Wrathstone)|r",
    "|cFFFF00General:|r",
    "• Updated auras/icons/tooltips/cast bar/etc for all Player Abilities, Siege Weapons/Repair Kits, any missing & new item sets.",
    "• Updated auras/icons/tooltips/combat alerts/etc for almost all basic NPC abilities, and started working on Dungeon abilities.",
    "|",
    "|cFFFF00Buffs & Debuffs:|r",
    "• Prominent Buffs will now display even when ALL OTHER BUFF/DEBUFF options are turned off. This was always the intended behavior, but was not working due to a massive oversight on my part.",
    "• Added a new toggle option for Ground Damage/Healing Auras - when enabled a debuff aura will be displayed when you are standing in a ground aoe effect (e.g. Arrow Barrage)",
    "• Fixed an issue where dropping a new rearming trap after only 1 of the 2 traps was consumed would result in two mine auras showing.",
    "|",
    "|cFFFF00Chat Announcements:|r",
    "• When looting multiple bodies at once - multiple items with the same ID are now combined into a single count. This significantly reduces the amount of spam loot logging generates.",
    "• Updated the Achievement Options with the new category added in Wrathstone and fixed an issue where only some categories would toggle off correctly.",
    "|",
    "|cFFFF00Combat Info:|r",
    "• Cast Bar - The cast bar will now automatically break when certain actions are taken, such as roll dodging.",
    "• Cast Bar - Added functionality to break the cast bar on movement for casts where this happens, as well as fixed various issues with the cast bar not refreshing when interrupting your cast & attempting to recast before the bar finished.",
    "• Ability Bar - Updated the default \"Activation Highlight\" effect (e.g. Shadow Image Teleport) to now loop the visual effect on the bar rather than playing only once.",
    "• Ability Bar - Guard and its morphs now display the Toggle Highlight visual effect used by other toggle effects (e.g. Mend Wounds) when active instead of just turning into an \"X\" icon on the bar.",
    "|",
    "|cFFFF00Combat Text:|r",
    "• Updated Combat Alerts to work toward making them less spammy (requiring specific criteria for each ability when cast, and applying a refire delay when various error events such as an NPC being out of range are detected).",
    "• Added \"Summon\" alerts to Combat Alerts - notifying you if an enemy summons an add.",
    "• Fixed an error where the Interrupt message on Combat Alerts was displaying as \"01Interrupt\" due to a syntax error in the default color.",
    "• Hid a few snares that rapidly refire from ground auras or other effects that would result in spam when you were immune to them.",
    "|",
    "|cFFFF00Unit Frames:|r",
    "• Fixed an issue introduced on the PTS where Player Names on the Group Unit Frames were being displaced from their proper positions.",
    --"|",
    --"|cEEEE00Unit Frames|r",
}

function LUIE_WelcomeScreen(menu)
    -- Load LibMsgWin library
    local LMW = LibStub:GetLibrary("LibMsgWin-1.0")


    -- temp shit
    luiChangelog2 = LUIE_Welcome_Screen2

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
        buffer:SetScrollPosition(16)
        slider:SetValue(buffer:GetNumHistoryLines() - 16)

    end
    -- Set version to current version.
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version
end
