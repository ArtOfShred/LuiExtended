-- Performance Enhancement
local strformat = zo_strformat

local windowManager = WINDOW_MANAGER

-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.
local memes = zo_iconFormat("LuiExtended/media/changelog/updatenotestemp.dds", 256, 256)

function LUIE_WelcomeScreen(menu)

    -- Load LibMsgWin library
    local LMW = LibStub:GetLibrary("LibMsgWin-1.0")

    local versionNumber = LUIE.version

    -- If saved version number is less than current version number then display the welcome screen.
    if (LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion ~= versionNumber) or menu then

        -- Only create the window if its the first load or the change log is opened - otherwise there's no reason to bother doing so.
        local luiChangeLog = windowManager:GetControlByName("LUIE_Welcome_Screen")
        if luiChangeLog == nil then
            luiChangeLog = LMW:CreateMsgWindow("LUIE_Welcome_Screen", strformat("<<1>> Changelog", LUIE.name))

            luiChangeLog:SetDimensions(800, math.min(600,GuiRoot:GetHeight()*0.8))
            luiChangeLog:ClearAnchors()
            luiChangeLog:SetAnchor(TOP, GuiRoot, TOP, 0,100)
            luiChangeLog:SetMouseEnabled(false)
            luiChangeLog:SetMovable(false)
            luiChangeLog:SetDrawLevel(1)

            --luiChangeLog:AddText(memes)
            luiChangeLog:AddText(strformat("Welcome to version <<1>> of <<2>> by <<3>>\nPlease take a few minutes to read over the list of changes in this version.\nThis notification will only appear once with each update unless opened manually from the menu.", LUIE.version, LUIE.name, LUIE.author))
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("General")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("UnitFrames")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("Combat Info")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("Combat Text")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("Buffs and Debuffs")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("Chat Announcements")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("Info Panel")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("Slash Commands")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText(strformat("If you have any feedback, bug reports, or other questions about <<1>> please visit ESOUI or Github bla bla bla more text here where to get support and where to submit bugs.", LUIE.name))
--[[
            luiChangeLog:SetSlider(23)
            function luiChangeLog:SetSlider(position)
                self:GetNamedChild("Buffer"):SetScrollPosition(position)
                local sliderValue = self:GetNamedChild("Buffer"):GetNumHistoryLines()
                self:GetNamedChild("Slider"):SetValue(sliderValue - position)
            end
]]--
            -- Create the close button
            luiChangeLog.button = windowManager:CreateControlFromVirtual(nil, luiChangeLog, "ZO_DefaultButton")
            luiChangeLog.button:SetWidth(200)
            luiChangeLog.button:SetText(GetString(SI_LUIE_LAM_CHANGELOG_CLOSE))
            luiChangeLog.button:SetAnchor(BOTTOMRIGHT, tlw, BOTTOMRIGHT, -10, 35)
            luiChangeLog.button:SetMouseEnabled(true)
            luiChangeLog.button:SetClickSound("Click")
            luiChangeLog.button:SetHandler("OnClicked", function(...) luiChangeLog:SetHidden(true) end)
        else
           --luiChangeLog:SetSlider(23)
            luiChangeLog:SetHidden(false)
        end
    end

    -- Set version to current version.
    LUIESV.Default[GetDisplayName()]['$AccountWide'].WelcomeVersion = LUIE.version

end
