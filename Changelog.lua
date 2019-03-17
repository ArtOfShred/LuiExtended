-- Performance Enhancement
local strformat = zo_strformat


-- TODO: Make some vars here for message text from changelog.
-- TODO: Create a basic logo to use when the changelog is displayed - may consider attempting to center it and remove ability to expand box size.

local fillMessages = {
    "General:",
    "* Updated auras/icons/tooltips/cast bar/etc for all Player Abilities, Siege Weapons/Repair Kits, any missing & new item sets.",
    "* Updated auras/icons/tooltips/combat alerts/etc for almost all basic NPC abilities, and started working on Dungeon abilities.",
    "Buffs & Debuffs:",
    "* Prominent Buffs will now display even when ALL OTHER BUFF/DEBUFF options are turned off. This was always the intended behavior, but was not working due to a massive oversight on my part.",
    "* Added a new toggle option for Ground Damage/Healing Auras - when enabled a debuff aura will be displayed when you are standing in a ground aoe effect (e.g. Arrow Barrage)",
    "* Fixed an issue where dropping a new rearming trap after only 1 of the 2 traps was consumed would result in two mine auras showing.",
    "Chat Announcements:",
    "* When looting multiple bodies at once - multiple items with the same ID are now combined into a single count. This significantly reduces the amount of spam loot logging generates.",
    "* Updated the Achievement Options with the new category added in Wrathstone and fixed an issue where only some categories would toggle off correctly.",
    "Combat Info:",
    "* Cast Bar - The cast bar will now automatically break when certain actions are taken, such as roll dodging.",
    "* Cast Bar - Added functionality to break the cast bar on movement for casts where this happens, as well as fixed various issues with the cast bar not refreshing when interrupting your cast & attempting to recast before the bar finished.",
    "* Ability Bar - Updated the default 'Activation Highlight' effect (e.g. Shadow Image Teleport) to now loop the visual effect on the bar rather than playing only once.",
    "* Ability Bar - Guard and its morphs now display the Toggle Highlight visual effect used by other toggle effects (e.g. Mend Wounds) when active instead of just turning into an 'X' icon on the bar.",
    "Combat Text:",
    "* Updated Combat Alerts to work toward making them less spammy (requiring specific criteria for each ability when cast, and applying a refire delay when various error events such as an NPC being out of range are detected).",
    "* Added 'Summon' alerts to Combat Alerts - notifying you if an enemy summons an add.",
    "* Fixed an error where the Interrupt message on Combat Alerts was displaying as '01Interrupt' due to a syntax error in the default color.",
    "* Hid a few snares that rapidly refire from ground auras or other effects that would result in spam when you were immune to them.",
    "Unit Frames:",
    "* Fixed an issue introduced on the PTS where Player Names on the Group Unit Frames were being displaced from their proper positions.",
    --"|",
    --"|cEEEE00Unit Frames|r",
}

function LUIE_WelcomeScreen(menu)
    local lastLabel
    local offset = 0

    local function wrap(str, limit, indent, indent1)
        indent = indent or ""
        indent1 = indent1 or indent
        limit = limit or 180
        local here = 1-#indent1
        local function check(sp, st, word, fi)
            if fi - here > limit then
                here = st - #indent
                return "\n"..indent..word
            end
        end
        return indent1..str:gsub("(%s+)()(%S+)()", check)
    end


    local function AddLine(text, font, color)
        -- If any argument is missing or invalid, use default values
        font  = (type(font)  == "string") and font  or "ZoFontGame"
        text  = (type(text)  == "string") and text  or ""
        color = (type(color) == "table")  and color or ZO_NORMAL_TEXT

        -- If text start with "*", replace it with bullet texture
        text = text:gsub("^*", "|t16:16:EsoUI/Art/Miscellaneous/bullet.dds|t")

        local parent = LUIEChangelogContainerScrollChild

        local label = WINDOW_MANAGER:CreateControl(nil, parent, CT_LABEL)
        label:SetFont(font)
        label:SetText(text)
        label:SetColor(color:UnpackRGBA())
        label:SetDimensions(label:GetTextDimensions())
        if lastLabel == nil then
            label:SetAnchor(TOPLEFT, parent, TOPLEFT, 0, offset + 6)
        else
            label:SetAnchor(TOPLEFT, lastLabel, TOPLEFT, 0, offset + 20)
        end

        offset = 0
        lastLabel = label

        return label
    end

    local function AddSpace(height)
        offset = offset + height
    end

    local function GenerateChangelog()
        AddLine(strformat("<<1>> v<<2>> by <<3>>", LUIE.name, LUIE.version, LUIE.author))
        -- Add all the changes from fillMessages
        for i = 1, #fillMessages do
            AddLine(strformat(fillMessages[i]))
        end
    end

    -- temp shit
    GenerateChangelog()

    luiChangelog2 = LUIEChangelog

end
