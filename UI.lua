--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- UI namespace
if LUIE.UI == nil then
    LUIE.UI = {}
end

local UI = LUIE.UI

local windowManager = WINDOW_MANAGER

-- A handy chaining function for quickly setting up UI elements
-- Allows us to reference methods to set properties without calling the specific object
function UI.Chain(object)
    -- Setup the metatable
    local T = {}
    setmetatable(T, {
        __index = function(self, func)
            -- Know when to stop chaining
            if func == "__END" then
                return object
            end

            -- Otherwise, add the method to the parent object
            ---@diagnostic disable-next-line: redefined-local
            return function(self, ...)
                assert(object[func], func .. " missing in object")
                object[func](object, ...)
                return self
            end
        end,
    })

    -- Return the metatable
    return T
end

-- Creates empty CT_TOPLEVELCONTROL window
--@param anchors any
--@param dims any
--@return table
function UI.TopLevel(anchors, dims)
    local tlw = windowManager:CreateTopLevelWindow()
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

-- Creates plain CT_CONTROL UI control element
--@param parent any
--@param anchors any
--@param dims any
--@param hidden any
--@param name any
--@return table
function UI.Control(parent, anchors, dims, hidden, name)
    if not parent then
        return
    end
    local controlName = name or nil
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

-- Creates CT_TEXTURE UI control element
--@param parent any
--@param anchors any
--@param dims any
--@param texture any
--@param drawlayer any
--@param hidden any
--@return table
function UI.Texture(parent, anchors, dims, texture, drawlayer, hidden)
    if not parent then
        return
    end

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

-- Creates CT_BACKDROP UI control element
--@param parent any
--@param anchors any
--@param dims any
--@param center any
--@param edge any
--@param hidden any
--@return table
function UI.Backdrop(parent, anchors, dims, center, edge, hidden)
    if not parent then
        return
    end
    local centerColor = (center ~= nil and #center == 4) and center or { 0, 0, 0, 0.4 }
    local edgeColor = (edge ~= nil and #edge == 4) and edge or { 0, 0, 0, 0.6 }
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

-- Creates CT_BACKDROP UI control element with Chat Window background style
--@param parent any
--@param anchors any
--@param dims any
--@param color any
--@param edge_size any
--@param hidden any
--@return table
function UI.ChatBackdrop(parent, anchors, dims, color, edge_size, hidden)
    if not parent then
        return
    end
    local bgColor = (color ~= nil and #color == 4) and color or { 0, 0, 0, 1 }
    local edgeSize = (edge_size ~= nil and edge_size > 0) and edge_size or 16
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

-- Creates CT_STATUSBAR UI control element
--@param parent any
--@param anchors any
--@param dims any
--@param color any
--@param hidden any
--@return table
function UI.StatusBar(parent, anchors, dims, color, hidden)
    if not parent then
        return
    end

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

-- Creates CT_STATUSBAR UI control element
--@param parent any
--@param anchors any
--@param dims any
--@param align any
--@param font any
--@param text any
--@param hidden any
--@param name any
--@return table
function UI.Label(parent, anchors, dims, align, font, text, hidden, name)
    if not parent then
        return
    end
    local alignment = (align ~= nil and #align == 2) and align or { TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER }
    local labelName = name or nil
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
