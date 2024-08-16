--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

---@class (partial) LuiExtended
local LUIE = LUIE

-- UI namespace
---@class UI
local UI = {}

local windowManager = WINDOW_MANAGER

--- Creates an empty `CT_TOPLEVELCONTROL` window.
---@param anchors table|nil: The anchor points for the window.
---@param dims table|nil: The dimensions of the window.
---@return object tlw: The created top-level window.
function UI.TopLevel(anchors, dims)
    ---@type object
    local tlw = windowManager:CreateTopLevelWindow(nil)
    tlw:SetClampedToScreen(true)
    tlw:SetMouseEnabled(false)
    tlw:SetMovable(false)
    tlw:SetHidden(true)
    if anchors ~= nil and #anchors >= 2 and #anchors <= 5 then
        tlw:SetAnchor(anchors[1], anchors[5] or GuiRoot, anchors[2], anchors[3] or 0, anchors[4] or 0)
    end
    if dims ~= nil and #dims == 2 then
        tlw:SetDimensions(dims[1], dims[2])
    end
    return tlw
end

--- Creates a plain `CT_CONTROL` UI control element.
---@param parent object|nil: The parent control for the control.
---@param anchors table|nil: The anchor points for the control.
---@param dims table|nil: The dimensions of the control.
---@param hidden boolean: Whether the control is hidden or not.
---@param name string|nil: The name of the control.
---@return Control|nil c: The created control.
function UI.Control(parent, anchors, dims, hidden, name)
    if not parent then
        return
    end
    local controlName = name or nil
    ---@type Control
    local c = windowManager:CreateControl(controlName, parent, CT_CONTROL)
    c:SetHidden(hidden)
    if anchors == "fill" then
        c:SetAnchorFill()
    elseif anchors ~= nil and #anchors >= 2 and #anchors <= 5 then
        c:SetAnchor(anchors[1], anchors[5] or parent, anchors[2], anchors[3] or 0, anchors[4] or 0)
    end
    if dims == "inherit" then
        c:SetDimensions(parent:GetWidth(), parent:GetHeight())
    elseif dims ~= nil and #dims == 2 then
        c:SetDimensions(dims[1], dims[2])
    end
    return c
end

--- Creates a `CT_TEXTURE` UI control element.
---@param parent object|nil: The parent control for the texture.
---@param anchors table|nil: The anchor points for the texture.
---@param dims table|nil: The dimensions of the texture.
---@param texture string: The path to the texture for the texture control.
---@param drawlayer number: The draw layer of the texture.
---@param hidden boolean: Whether the texture is hidden or not.
---@return TextureControl|nil t: The created texture control.
function UI.Texture(parent, anchors, dims, texture, drawlayer, hidden)
    if not parent then
        return
    end
    ---@type TextureControl
    local t = windowManager:CreateControl(nil, parent, CT_TEXTURE)
    t:SetHidden(hidden)
    if anchors == "fill" then
        t:SetAnchorFill()
    elseif anchors ~= nil and #anchors >= 2 and #anchors <= 5 then
        t:SetAnchor(anchors[1], anchors[5] or parent, anchors[2], anchors[3] or 0, anchors[4] or 0)
    end
    if dims == "inherit" then
        t:SetDimensions(parent:GetWidth(), parent:GetHeight())
    elseif dims ~= nil and #dims == 2 then
        t:SetDimensions(dims[1], dims[2])
    end
    if texture then
        t:SetTexture(texture)
    end
    if drawlayer then
        t:SetDrawLayer(drawlayer)
    end
    return t
end

--- Creates a `CT_BACKDROP` UI control element.
---@param parent object|nil: The parent control for the backdrop.
---@param anchors string|table|nil: The anchor points for the backdrop.
---@param dims table|nil: The dimensions of the backdrop.
---@param center table|nil: The color of the center of the backdrop.
---@param edge table|nil: The color of the edge of the backdrop.
---@param hidden boolean: Whether the backdrop is hidden or not.
---@return BackdropControl|nil bg: The created backdrop control.
function UI.Backdrop(parent, anchors, dims, center, edge, hidden)
    if not parent then
        return
    end
    local centerColor = (center ~= nil and #center == 4) and center or { 0, 0, 0, 0.4 }
    local edgeColor = (edge ~= nil and #edge == 4) and edge or { 0, 0, 0, 0.6 }
    ---@type BackdropControl
    local bg = windowManager:CreateControl(nil, parent, CT_BACKDROP)
    bg:SetCenterColor(centerColor[1], centerColor[2], centerColor[3], centerColor[4])
    bg:SetEdgeColor(edgeColor[1], edgeColor[2], edgeColor[3], edgeColor[4])
    bg:SetEdgeTexture("", 8, 1, 0)
    bg:SetDrawLayer(DL_BACKGROUND)
    bg:SetHidden(hidden)
    if anchors == "fill" then
        bg:SetAnchorFill()
    elseif anchors ~= nil and #anchors >= 2 and #anchors <= 5 then
        bg:SetAnchor(anchors[1], anchors[5] or parent, anchors[2], anchors[3] or 0, anchors[4] or 0)
    end
    if dims == "inherit" then
        bg:SetDimensions(parent:GetWidth(), parent:GetHeight())
    elseif dims ~= nil and #dims == 2 then
        bg:SetDimensions(dims[1], dims[2])
    end
    return bg
end

---Creates a `CT_BACKDROP` UI control element with Chat Window background style.
---@param parent object|nil: The parent control for the backdrop.
---@param anchors table|nil: The anchor points for the backdrop.
---@param dims table|nil: The dimensions of the backdrop.
---@param color table|nil: The color of the backdrop.
---@param edge_size number: The size of the backdrop edge.
---@param hidden boolean: Whether the backdrop is hidden or not.
---@return BackdropControl|nil bg: The created backdrop control.
function UI.ChatBackdrop(parent, anchors, dims, color, edge_size, hidden)
    if not parent then
        return
    end
    local bgColor = (color ~= nil and #color == 4) and color or { 0, 0, 0, 1 }
    local edgeSize = (edge_size ~= nil and edge_size > 0) and edge_size or 16
    ---@type BackdropControl
    local bg = windowManager:CreateControl(nil, parent, CT_BACKDROP)
    bg:SetCenterColor(bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    bg:SetEdgeColor(bgColor[1], bgColor[2], bgColor[3], bgColor[4])
    bg:SetCenterTexture("/esoui/art/chatwindow/chat_bg_center.dds")
    bg:SetEdgeTexture("/esoui/art/chatwindow/chat_bg_edge.dds", 256, 256, edgeSize)
    bg:SetInsets(edgeSize, edgeSize, -edgeSize, -edgeSize)
    bg:SetDrawLayer(DL_BACKGROUND)
    bg:SetHidden(hidden)
    if anchors == "fill" then
        bg:SetAnchorFill()
    elseif anchors ~= nil and #anchors >= 2 and #anchors <= 5 then
        bg:SetAnchor(anchors[1], anchors[5] or parent, anchors[2], anchors[3] or 0, anchors[4] or 0)
    end
    if dims == "inherit" then
        bg:SetDimensions(parent:GetWidth(), parent:GetHeight())
    elseif dims ~= nil and #dims == 2 then
        bg:SetDimensions(dims[1], dims[2])
    end
    return bg
end

---Creates a `CT_STATUSBAR` UI control element.
---@param parent object|nil: The parent control for the status bar.
---@param anchors table|nil: The anchor points for the status bar.
---@param dims table|nil: The dimensions of the status bar.
---@param color table|nil: The color of the status bar.
---@param hidden boolean: Whether the status bar is hidden or not.
---@return StatusBarControl|nil sb: The created status bar control.
function UI.StatusBar(parent, anchors, dims, color, hidden)
    if not parent then
        return
    end
    ---@type StatusBarControl
    local sb = windowManager:CreateControl(nil, parent, CT_STATUSBAR)
    sb:SetHidden(hidden)
    if anchors == "fill" then
        sb:SetAnchorFill()
    elseif anchors ~= nil and #anchors >= 2 and #anchors <= 5 then
        sb:SetAnchor(anchors[1], anchors[5] or parent, anchors[2], anchors[3] or 0, anchors[4] or 0)
    end
    if dims == "inherit" then
        sb:SetDimensions(parent:GetWidth(), parent:GetHeight())
    elseif dims ~= nil and #dims == 2 then
        sb:SetDimensions(dims[1], dims[2])
    end
    if color ~= nil and (#color == 3 or #color == 4) then
        sb:SetColor(unpack(color))
    end
    return sb
end

--- Creates a `CT_STATUSBAR UI` control element.
--- @param parent object|nil: The parent control for the label.
--- @param anchors table|nil: The anchor points for the label.
--- @param dims table|nil: The dimensions of the label.
--- @param align table|nil: The text alignment of the label.
--- @param font string|nil: The font for the label.
--- @param text string|nil: The text for the label.
--- @param hidden boolean: Whether the label is hidden or not.
--- @param name? string: The name of the label control.
--- @return LabelControl|nil label: The created label control.
function UI.Label(parent, anchors, dims, align, font, text, hidden, name)
    if not parent then
        return
    end
    local alignment = (align ~= nil and #align == 2) and align or { TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER }
    local labelName = name or nil
    ---@type LabelControl
    local label = windowManager:CreateControl(labelName, parent, CT_LABEL)
    label:SetFont(font or "ZoFontGame")
    label:SetHorizontalAlignment(alignment[1])
    label:SetVerticalAlignment(alignment[2])
    label:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
    label:SetHidden(hidden)
    if anchors == "fill" then
        label:SetAnchorFill()
    elseif anchors ~= nil and #anchors >= 2 and #anchors <= 5 then
        label:SetAnchor(anchors[1], anchors[5] or parent, anchors[2], anchors[3] or 0, anchors[4] or 0)
    end
    if dims == "inherit" then
        label:SetDimensions(parent:GetWidth(), parent:GetHeight())
    elseif dims ~= nil and #dims == 2 then
        label:SetDimensions(dims[1], dims[2])
    end
    if text then
        label:SetText(text)
    end
    return label
end

LUIE.UI = UI
