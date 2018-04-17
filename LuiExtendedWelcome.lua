local LIBMW = LibStub:GetLibrary("LibMsgWin-1.0")

-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.
local memes = zo_iconFormat("LuiExtended/media/changelog/updatenotestemp.dds", 256, 256)

function LUIE_WelcomeScreen(menu)

    local versionNumber = LUIE.version

    -- If saved version number is less than current version number then display the welcome screen.
    if (LUIE.SV.WelcomeVersion ~= versionNumber) or menu then

        -- Only create the window if its the first load or the change log is opened - otherwise there's no reason to bother doing so.
        local luiChangeLog = WINDOW_MANAGER:GetControlByName("LUIE_Welcome_Screen")
        if luiChangeLog == nil then
            luiChangeLog = LIBMW:CreateMsgWindow("LUIE_Welcome_Screen", "LUIE 5.3.- GitHub Development Version")

            luiChangeLog:SetDimensions(800, 600)

            luiChangeLog:ClearAnchors()
            luiChangeLog:SetAnchor(TOP, GuiRoot, TOP, 0,100)
            luiChangeLog:SetMouseEnabled(false)
            luiChangeLog:SetDrawLevel(1)

            function luiChangeLog:SetSlider(position)
                self:GetNamedChild("Buffer"):SetScrollPosition(position)
                local sliderValue = self:GetNamedChild("Buffer"):GetNumHistoryLines()
                self:GetNamedChild("Slider"):SetValue(sliderValue - position)
            end

            button = WINDOW_MANAGER:CreateControlFromVirtual(nil, luiChangeLog, "ZO_DefaultButton")
            button:SetWidth(200)
            button:SetText(GetString(SI_LUIE_LAM_CHANGELOG_CLOSE))
            button:SetAnchor(BOTTOMRIGHT, tlw, BOTTOMRIGHT, -25, 50)

            button:SetMouseEnabled(true)
            button:SetClickSound("Click")
            --button.data = {tooltipText = "Close the Change Log" }
            --button:SetHandler("OnMouseEnter", ZO_Options_OnMouseEnter)
            --button:SetHandler("OnMouseExit", ZO_Options_OnMouseExit)
            button:SetHandler("OnClicked", function(...)
                luiChangeLog:SetHidden(true)
            end)

            luiChangeLog:AddText("Welcome to the latest version of LUI Extended!", 1, 0, 0)
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText(memes)
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("Eventually some cool change log notes will be listed here - but for now, enjoy this product placement!")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("NOTE: This change log notification will only appear once with each update unless opened manually from the menu.")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:AddText("|")
            luiChangeLog:ChangeTextFade(0, 0)

            luiChangeLog:SetSlider(23)
        else
            luiChangeLog:SetSlider(23)
            luiChangeLog:SetHidden(false)
        end
    end

    -- Set version to current version.
    LUIE.SV.WelcomeVersion = LUIE.version

end
