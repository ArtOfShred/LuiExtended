LUIE.Changelog = ZO_Object:Subclass()

-- Code used here to create the LUIE Changelog is a modified version of LibMsgWin (http://www.esoui.com/downloads/info802-LibMsgWin.html) by circonian.
-- Modified to add function to set scroll position, and button to hide the window.


-- TODO: Make some vars here for message text from changelog.
local memes = zo_iconFormat("LuiExtended/media/changelog/updatenotestemp.dds", 256, 256)

-- TODO: Add localized strings for menu buttons (Not going to bother localizing instances of patch notes).
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.

function LUIE_WelcomeScreen(menu)

    local versionNumber = LUIE.version

    -- If saved version number is less than current version number then display the welcome screen.
    if (LUIE.SV.WelcomeVersion ~= versionNumber) or menu then

        -- Only create the window if its the first load or the change log is opened - otherwise there's no reason to bother doing so.
        local luiChangelog = WINDOW_MANAGER:GetControlByName("LUIE_Welcome_Screen")
        if luiChangelog == nil then
            luiChangelog = LUIE.Changelog:CreateMsgWindow("LUIE_Welcome_Screen", "LUIE 5.3.- GitHub Development Version")

            luiChangelog:AddText("Welcome to the latest version of LUI Extended!", 1, 0, 0)
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText(memes)
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("Eventually some cool change log notes will be listed here - but for now, enjoy this product placement!")
            luiChangelog:AddText("|")
            luiChangelog:AddText("NOTE: This change log notification will only appear once with each update unless opened manually from the menu.")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:AddText("|")
            luiChangelog:ChangeTextFade(0, 0)

            luiChangelog:SetSlider(23)
        else
            luiChangelog:SetHidden(false)
        end
    end

    -- Set version to current version.
    LUIE.SV.WelcomeVersion = LUIE.version

end

local function AdjustSlider(self)
	local numHistoryLines = self:GetNamedChild("Buffer"):GetNumHistoryLines()
	local numVisHistoryLines = self:GetNamedChild("Buffer"):GetNumVisibleLines()
	local bufferScrollPos = self:GetNamedChild("Buffer"):GetScrollPosition()
	local sliderMin, sliderMax = self:GetNamedChild("Slider"):GetMinMax()
	local sliderValue = self:GetNamedChild("Slider"):GetValue()

	self:GetNamedChild("Slider"):SetMinMax(0, numHistoryLines)

	-- If the sliders at the bottom, stay at the bottom to show new text
	if sliderValue == sliderMax then
		self:GetNamedChild("Slider"):SetValue(numHistoryLines)
	-- If the buffer is full start moving the slider up
	elseif numHistoryLines == self:GetNamedChild("Buffer"):GetMaxHistoryLines() then
		self:GetNamedChild("Slider"):SetValue(sliderValue-1)
	end -- Else the slider does not move

	-- If there are more history lines than visible lines show the slider
	if numHistoryLines > numVisHistoryLines then
		self:GetNamedChild("Slider"):SetHidden(false)
	else
		-- else hide the slider
		self:GetNamedChild("Slider"):SetHidden(true)
	end
end

function LUIE.Changelog:CreateMsgWindow(_UniqueName, _LabelText, _FadeDelay, _FadeTime)
	-- Dimension Constraits
	local minWidth = 800
	local minHeight = 600

	local tlw = WINDOW_MANAGER:CreateTopLevelWindow(_UniqueName)
	tlw:SetMouseEnabled(true)
	tlw:SetMovable(true)
	tlw:SetHidden(false)
	tlw:SetClampedToScreen(true)
	tlw:SetDimensions(350, 400)
	tlw:SetClampedToScreenInsets(-24)
	tlw:SetAnchor(CENTER, GuiRoot, CENTER, 0,-130)
	tlw:SetDimensionConstraints(minWidth, minHeight)
	tlw:SetResizeHandleSize(16)
    tlw:SetDrawLevel(1)

	-- Set Fade Delay/Times
	tlw.fadeDelayWindow		= _FadeDelay or 0
	tlw.fadeTimeWindow		= _FadeTime or 0
	tlw.fadeDelayTextLines 	= tlw.fadeDelayWindow/1000
	tlw.fadeTimeTextLines 	= tlw.fadeTimeWindow/1000

	-- Create window fade timeline/animation
	tlw.timeline = ANIMATION_MANAGER:CreateTimeline()
	tlw.animation = tlw.timeline:InsertAnimation(ANIMATION_ALPHA, tlw, tlw.fadeDelayWindow)
	tlw.animation:SetAlphaValues(1, 0)
	tlw.animation:SetDuration(tlw.fadeTimeWindow)
	tlw.timeline:PlayFromStart()

    function tlw:SetSlider(position)
        self:GetNamedChild("Buffer"):SetScrollPosition(position)
        local sliderValue = self:GetNamedChild("Buffer"):GetNumHistoryLines()
		self:GetNamedChild("Slider"):SetValue(sliderValue - position)
    end

	function tlw:AddText(_Message, _Red, _Green, _Blue)
		local Red 	= _Red or 1
		local Green = _Green or 1
		local Blue 	= _Blue or 1

		if not _Message then return end
		-- Add message first
		self:GetNamedChild("Buffer"):AddMessage(_Message, Red, Green, Blue)
		-- Set new slider value & check visibility
		AdjustSlider(self)
		-- Reset Fade Timers
		tlw:SetAlpha(1)
		tlw.timeline:PlayFromStart()
	end
	function tlw:ChangeWinFade(_FadeDelay, _FadeTime)
		if not (type(_FadeDelay) == "number" and type(_FadeTime) == "number") then return end
		tlw.fadeDelayWindow		= _FadeDelay
		tlw.fadeTimeWindow		= _FadeTime

		tlw.timeline:SetAnimationOffset(tlw.animation, _FadeDelay)
		tlw.animation:SetDuration(_FadeTime)
	end
	function tlw:ChangeTextFade(_FadeDelay, _FadeTime)
		if not (type(_FadeDelay) == "number" and type(_FadeTime) == "number") then return end
		tlw.fadeDelayTextLines 	= _FadeDelay/1000
		tlw.fadeTimeTextLines 	= _FadeTime/1000
		self:GetNamedChild("Buffer"):SetLineFade(_FadeDelay/1000, _FadeTime/1000)
	end
	function tlw:ClearText()
		self:GetNamedChild("Buffer"):Clear()
	end

	local bg = WINDOW_MANAGER:CreateControl(_UniqueName.."Bg", tlw, CT_BACKDROP)
	bg:SetAnchor(TOPLEFT, tlw, TOPLEFT, -8, -6)
	bg:SetAnchor(BOTTOMRIGHT, tlw, BOTTOMRIGHT, 4, 4)
	bg:SetEdgeTexture("EsoUI/Art/ChatWindow/chat_BG_edge.dds", 256, 256, 32)
	bg:SetCenterTexture("EsoUI/Art/ChatWindow/chat_BG_center.dds")
	bg:SetInsets(32, 32, -32, -32)
	bg:SetDimensionConstraints(minWidth, minHeight)


	local divider = WINDOW_MANAGER:CreateControl(_UniqueName.."Divider", tlw, CT_TEXTURE)
	divider:SetDimensions(4, 8)
	divider:SetAnchor(TOPLEFT, tlw, TOPLEFT, 20, 40)
	divider:SetAnchor(TOPRIGHT, tlw, TOPRIGHT, -20, 40)
	divider:SetTexture("EsoUI/Art/Miscellaneous/horizontalDivider.dds")
	divider:SetTextureCoords(0.181640625, 0.818359375, 0, 1)

	local buffer = WINDOW_MANAGER:CreateControl(_UniqueName.."Buffer", tlw, CT_TEXTBUFFER)
	buffer:SetFont("ZoFontChat")
	buffer:SetMaxHistoryLines(200)
	buffer:SetMouseEnabled(true)
	buffer:SetLinkEnabled(true)
	buffer:SetAnchor(TOPLEFT, tlw, TOPLEFT, 20, 42)
	buffer:SetAnchor(BOTTOMRIGHT, tlw, BOTTOMRIGHT, -35, -20)
	buffer:SetLineFade(tlw.fadeDelayTextLines, tlw.fadeTimeTextLines)
	buffer:SetHandler("OnLinkMouseUp", function(self, linkText, link, button)
              --  ZO_PopupTooltip_SetLink(link)
		ZO_LinkHandler_OnLinkMouseUp(link, button, self)
	end)
	buffer:SetDimensionConstraints(minWidth-55, minHeight-62)

	buffer:SetHandler("OnMouseWheel", function(self, delta, ctrl, alt, shift)
		local offset = delta
		local slider = buffer:GetParent():GetNamedChild("Slider")
		if shift then
			offset = offset * buffer:GetNumVisibleLines()
		elseif ctrl then
			offset = offset * buffer:GetNumHistoryLines()
		end
		buffer:SetScrollPosition(buffer:GetScrollPosition() + offset)
		slider:SetValue(slider:GetValue() - offset)
	end)

	buffer:SetHandler("OnMouseEnter", function(...)
		tlw.timeline:Stop()
		buffer:SetLineFade(0, 0)
		buffer:ShowFadedLines()
		tlw:SetAlpha(1)
	end)
	buffer:SetHandler("OnMouseExit", function(...)
		buffer:SetLineFade(tlw.fadeDelayTextLines, tlw.fadeTimeTextLines)
		tlw.timeline:PlayFromStart()
	end)

    button = WINDOW_MANAGER:CreateControlFromVirtual(nil, tlw, "ZO_DefaultButton")
    button:SetWidth(200)
    button:SetText("Close Change Log")
    button:SetAnchor(BOTTOMRIGHT, tlw, BOTTOMRIGHT, -25, 50)

    button:SetMouseEnabled(true)
    button:SetClickSound("Click")
    --button.data = {tooltipText = "Close the Change Log" }
    --button:SetHandler("OnMouseEnter", ZO_Options_OnMouseEnter)
    --button:SetHandler("OnMouseExit", ZO_Options_OnMouseExit)
    button:SetHandler("OnClicked", function(...)
        tlw:SetHidden(true)
    end)

	local slider = WINDOW_MANAGER:CreateControl(_UniqueName.."Slider", tlw, CT_SLIDER)
	slider:SetDimensions(15, 32)
	slider:SetAnchor(TOPRIGHT, tlw, TOPRIGHT, -25, 60)
	slider:SetAnchor(BOTTOMRIGHT, tlw, BOTTOMRIGHT, -15, -80)
	slider:SetMinMax(1, 1)
	slider:SetMouseEnabled(true)
	slider:SetValueStep(1)
	slider:SetValue(1)
	slider:SetHidden(true)
	slider:SetThumbTexture("EsoUI/Art/ChatWindow/chat_thumb.dds", "EsoUI/Art/ChatWindow/chat_thumb_disabled.dds", nil, 8, 22, nil, nil, 0.6875, nil)
	slider:SetBackgroundMiddleTexture("EsoUI/Art/ChatWindow/chat_scrollbar_track.dds")

	slider:SetHandler("OnValueChanged", function(self,value, eventReason)
		local numHistoryLines = self:GetParent():GetNamedChild("Buffer"):GetNumHistoryLines()
		local sliderValue = slider:GetValue()

		if eventReason == EVENT_REASON_HARDWARE then
			buffer:SetScrollPosition(numHistoryLines-sliderValue)
		end
	end)


	local scrollUp = WINDOW_MANAGER:CreateControlFromVirtual(_UniqueName.."SliderScrollUp", slider, "ZO_ScrollUpButton")
	scrollUp:SetAnchor(BOTTOM, slider, TOP, -1, 0)
	scrollUp:SetNormalTexture("EsoUI/Art/ChatWindow/chat_scrollbar_upArrow_up.dds")
	scrollUp:SetPressedTexture("EsoUI/Art/ChatWindow/chat_scrollbar_upArrow_down.dds")
	scrollUp:SetMouseOverTexture("EsoUI/Art/ChatWindow/chat_scrollbar_upArrow_over.dds")
	scrollUp:SetDisabledTexture("EsoUI/Art/ChatWindow/chat_scrollbar_upArrow_disabled.dds")
	scrollUp:SetHandler("OnMouseDown", function(...)
		buffer:SetScrollPosition(buffer:GetScrollPosition()+1)
		slider:SetValue(slider:GetValue()-1)
	end)


	local scrollDown = WINDOW_MANAGER:CreateControlFromVirtual(_UniqueName.."SliderScrollDown", slider, "ZO_ScrollDownButton")
	scrollDown:SetAnchor(TOP, slider, BOTTOM, -1, 0)
	scrollDown:SetNormalTexture("EsoUI/Art/ChatWindow/chat_scrollbar_downArrow_up.dds")
	scrollDown:SetPressedTexture("EsoUI/Art/ChatWindow/chat_scrollbar_downArrow_down.dds")
	scrollDown:SetMouseOverTexture("EsoUI/Art/ChatWindow/chat_scrollbar_downArrow_over.dds")
	scrollDown:SetDisabledTexture("EsoUI/Art/ChatWindow/chat_scrollbar_downArrow_disabled.dds")
	scrollDown:SetHandler("OnMouseDown", function(...)
		buffer:SetScrollPosition(buffer:GetScrollPosition()-1)
		slider:SetValue(slider:GetValue()+1)
	end)


	local scrollEnd = WINDOW_MANAGER:CreateControlFromVirtual(_UniqueName.."SliderScrollEnd", slider, "ZO_ScrollEndButton")
	scrollEnd:SetDimensions(16, 16)
	scrollEnd:SetAnchor(TOP, scrollDown, BOTTOM, 0, 0)
	scrollEnd:SetHandler("OnMouseDown", function(...)
		buffer:SetScrollPosition(0)
		slider:SetValue(buffer:GetNumHistoryLines())
	end)

	if _LabelText and _LabelText ~= "" then
		local label = WINDOW_MANAGER:CreateControl(_UniqueName.."Label", tlw, CT_LABEL)
		label:SetText(_LabelText)
		label:SetFont("$(ANTIQUE_FONT)|24")
		label:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
		local textHeight = label:GetTextHeight()
		label:SetDimensionConstraints(minWidth-60, textHeight, nil, textHeight)
		label:ClearAnchors()
		label:SetAnchor(TOPLEFT, tlw, TOPLEFT, 30, (40-textHeight)/2+5)
		label:SetAnchor(TOPRIGHT, tlw, TOPRIGHT, -30, (40-textHeight)/2+5)
	end

	return tlw
end





