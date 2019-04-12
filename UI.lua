--[[
    LuiExtended
    License: The MIT License (MIT)
--]]

-- UI namespace
LUIE.UI = {}
local UI = LUIE.UI

local windowManager = WINDOW_MANAGER

-- A handy chaining function for quickly setting up UI elements
-- Allows us to reference methods to set properties without calling the specific object
function UI.Chain(object)
    -- Setup the metatable
    local T = {}
    setmetatable(T , { __index = function( self , func)

        -- Know when to stop chaining
        if func == "__END" then return object end

        -- Otherwise, add the method to the parent object
        return function(self , ...)
            assert(object[func] , func .. " missing in object")
            object[func](object , ...)
            return self
        end
    end })

    -- Return the metatable
    return T
end

-- Creates empty CT_TOPLEVELCONTROL window
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
function UI.Control(parent, anchors, dims, hidden, name)
    if not parent then return end

    local name = name or nil
    local c = windowManager:CreateControl(name, parent, CT_CONTROL)
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
function UI.Texture(parent, anchors, dims, texture, drawlayer, hidden)
    if not parent then return end

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
function UI.Backdrop(parent, anchors, dims, center, edge, hidden)
    if not parent then return end

    local center = (center ~= nil and #center == 4) and center or { 0,0,0,0.4 }
    local edge = (edge ~= nil and #edge == 4) and edge or { 0,0,0,0.6 }

    local bg = windowManager:CreateControl(nil, parent, CT_BACKDROP)

    bg:SetCenterColor(center[1], center[2], center[3], center[4])
    bg:SetEdgeColor(edge[1], edge[2], edge[3], edge[4])
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
function UI.ChatBackdrop(parent, anchors, dims, color, edge_size, hidden)
    if not parent then return end

    local color = (color ~= nil and #color == 4) and color or { 0,0,0,1 }
    local edge_size = (edge_size ~= nil and edge_size > 0) and edge_size or 16

    local bg = windowManager:CreateControl(nil, parent, CT_BACKDROP)

    bg:SetCenterColor(color[1], color[2], color[3], color[4])
    bg:SetEdgeColor(color[1], color[2], color[3], color[4])
    bg:SetCenterTexture("/esoui/art/chatwindow/chat_bg_center.dds")
    bg:SetEdgeTexture("/esoui/art/chatwindow/chat_bg_edge.dds", 256, 256, edge_size)
    bg:SetInsets(edge_size, edge_size, -edge_size, -edge_size)
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
function UI.StatusBar(parent, anchors, dims, color, hidden)
    if not parent then return end

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
function UI.Label(parent, anchors, dims, align, font, text, hidden, name)
    if not parent then return end

    local align = (align ~= nil and #align == 2) and align or { TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER }

    local name = name or nil
    local label = windowManager:CreateControl(name, parent, CT_LABEL)

    label:SetFont(font or 'ZoFontGame')
    label:SetHorizontalAlignment(align[1])
    label:SetVerticalAlignment(align[2])
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

    if text then label:SetText(text) end

    return label
end
