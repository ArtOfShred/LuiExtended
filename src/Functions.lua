-- -----------------------------------------------------------------------------
--  LuiExtended                                                               --
--  Distributed under The MIT License (MIT) (see LICENSE file)                --
-- -----------------------------------------------------------------------------

--- @class (partial) LuiExtended
local LUIE = LUIE
-- -----------------------------------------------------------------------------
local string_format = string.format

-- -----------------------------------------------------------------------------
--- Called from the menu and on initialization to update the timestamp color when changed.
LUIE.TimeStampColorize = nil

-- -----------------------------------------------------------------------------
--- Updates the timestamp color based on the value in LUIE.ChatAnnouncements.SV.TimeStampColor.
function LUIE.UpdateTimeStampColor()
    LUIE.TimeStampColorize = ZO_ColorDef:New(unpack(LUIE.ChatAnnouncements.SV.TimeStampColor)):ToHex()
end

-- -----------------------------------------------------------------------------
--- Toggle the display of the Alert Frame.
--- Sets the visibility of the ZO_AlertTextNotification based on the value of LUIE.SV.HideAlertFrame.
function LUIE.SetupAlertFrameVisibility()
    ZO_AlertTextNotification:SetHidden(LUIE.SV.HideAlertFrame)
end

-- -----------------------------------------------------------------------------
do
    -- Get milliseconds from game time
    local function getCurrentMillisecondsFormatted()
        local currentTimeMs = GetGameTimeMilliseconds()
        if currentTimeMs == nil then return end
        return string_format("%03d", currentTimeMs % 1000)
    end

    --- Returns a formatted timestamp based on the provided time string and format string.
    --- @param timeStr string: The time string in the format "HH:MM:SS".
    --- @param formatStr string|nil (optional): The format string for the timestamp. If not provided, the default format from LUIE.ChatAnnouncements.SV.TimeStampFormat will be used.
    --- @param milliseconds string|nil
    --- @return string @ The formatted timestamp.
    local function CreateTimestamp(timeStr, formatStr, milliseconds)
        local showTimestamp = LUIE.ChatAnnouncements.SV.TimeStamp
        if showTimestamp then
            milliseconds = milliseconds or getCurrentMillisecondsFormatted()
        end
        if milliseconds == nil then milliseconds = "" end
        formatStr = formatStr or LUIE.ChatAnnouncements.SV.TimeStampFormat

        -- split up default timestamp
        local hours, minutes, seconds = zo_strmatch(timeStr, "([^%:]+):([^%:]+):([^%:]+)")
        local hoursNoLead = tonumber(hours) -- hours without leading zero
        local hours12NoLead = (hoursNoLead - 1) % 12 + 1
        local hours12
        if (hours12NoLead < 10) then
            hours12 = "0" .. hours12NoLead
        else
            hours12 = hours12NoLead
        end
        local pUp = "AM"
        local pLow = "am"
        if (hoursNoLead >= 12) then
            pUp = "PM"
            pLow = "pm"
        end

        -- create new one
        -- >If you add new formats make sure to update the tooltip at LUIE_STRING_LAM_CA_TIMESTAMPFORMAT_TP too
        local timestamp = formatStr
        timestamp = zo_strgsub(timestamp, "HH", hours)
        timestamp = zo_strgsub(timestamp, "H", hoursNoLead)
        timestamp = zo_strgsub(timestamp, "hh", hours12)
        timestamp = zo_strgsub(timestamp, "h", hours12NoLead)
        timestamp = zo_strgsub(timestamp, "m", minutes)
        timestamp = zo_strgsub(timestamp, "s", seconds)
        timestamp = zo_strgsub(timestamp, "A", pUp)
        timestamp = zo_strgsub(timestamp, "a", pLow)
        timestamp = zo_strgsub(timestamp, "xy", milliseconds)
        return timestamp
    end

    LUIE.CreateTimestamp = CreateTimestamp
end

-- -----------------------------------------------------------------------------
do
    --- Helper function to format a message with an optional timestamp.
    --- @param msg string: The message to be formatted.
    --- @param doTimestamp boolean: If true, a timestamp will be added to the formatted message.
    --- @param lineNumber? number: The current line number for the chat message.
    --- @param chanCode? number: The chat channel code.
    --- @return string: The formatted message.
    local function FormatMessage(msg, doTimestamp, lineNumber, chanCode)
        local formattedMsg = msg or ""
        if doTimestamp then
            local timestring = GetTimeString()
            local timestamp = LUIE.CreateTimestamp(timestring, nil)

            -- Make timestamp clickable if lineNumber and chanCode are provided
            local timestampText
            if lineNumber and chanCode then
                timestampText = ZO_LinkHandler_CreateLink(timestamp, nil, "LUIE", lineNumber .. ":" .. chanCode)
            else
                timestampText = timestamp
            end

            -- Format with color and brackets
            local timestampFormatted = string_format("|c%s[%s]|r ", LUIE.TimeStampColorize, timestampText)

            -- Combine timestamp with message
            formattedMsg = timestampFormatted .. formattedMsg
        end
        return formattedMsg
    end

    LUIE.FormatMessage = FormatMessage
end
-- -----------------------------------------------------------------------------
--- Hides or shows all LUIE components.
--- @param hidden boolean: If true, all components will be hidden. If false, all components will be shown.
function LUIE.ToggleVisibility(hidden)
    for _, control in pairs(LUIE.Components) do
        control:SetHidden(hidden)
    end
end

-- -----------------------------------------------------------------------------
do
    local EmitMessage
    local EmitTable
    local d

    EmitMessage = function (text)
        if text == "" then
            text = "[Empty String]"
        end

        if CHAT_ROUTER then
            CHAT_ROUTER:AddSystemMessage(text)
        end
    end

    EmitTable = function (t, indent, tableHistory)
        indent = indent or "."
        tableHistory = tableHistory or {}

        for k, v in pairs(t)
        do
            local vType = type(v)

            EmitMessage(indent .. "(" .. vType .. "): " .. tostring(k) .. " = " .. tostring(v))

            if (vType == "table")
            then
                if (tableHistory[v])
                then
                    EmitMessage(indent .. "Avoiding cycle on table...")
                else
                    tableHistory[v] = true
                    EmitTable(v, indent .. "  ", tableHistory)
                end
            end
        end
    end

    d = function (...)
        for i = 1, select("#", ...) do
            local value = select(i, ...)
            if (type(value) == "table")
            then
                EmitTable(value)
            else
                EmitMessage(tostring(value))
            end
        end
    end

    --- Adds a system message to the chat.
    --- @param messageOrFormatter string: The message to be printed.
    --- @param ... string: Variable number of arguments to be passed to CHAT_ROUTER:AddSystemMessage.
    local function AddSystemMessage(messageOrFormatter, ...)
        local formattedMessage
        if select("#", ...) > 0 then
            -- Escape '%' characters to prevent illegal format specifiers.
            local safeFormat = zo_strgsub(messageOrFormatter, "%%", "%%%%")
            formattedMessage = string_format(safeFormat, ...)
        else
            formattedMessage = messageOrFormatter
        end
        d(formattedMessage)
    end
    LUIE.AddSystemMessage = AddSystemMessage
end
-- -----------------------------------------------------------------------------
do
    --- Easy Print to Chat.
    --- Prints a message to the chat.
    --- @param msg string: The message to be printed.
    --- @param isSystem? boolean: If true, the message is considered a system message.
    local function PrintToChat(msg, isSystem)
        if not CHAT_SYSTEM.primaryContainer then return end

        local function formatMessage(message)
            if LUIE.ChatAnnouncements.SV.ChatBypassFormat then
                return message
            end
            return LUIE.FormatMessage(message or "no message", LUIE.ChatAnnouncements.SV.TimeStamp)
        end

        local function sendToAllWindows(message)
            LUIE.AddSystemMessage(message)
        end

        local function sendToSpecificTabs(message)
            for _, cc in ipairs(CHAT_SYSTEM.containers) do
                for i = 1, #cc.windows do
                    if LUIE.ChatAnnouncements.SV.ChatTab[i] then
                        local chatContainer = cc
                        local chatWindow = cc.windows[i]

                        -- Skip Combat Metrics Log window if CMX is enabled
                        if not (CMX and CMX.db and CMX.db.chatLog and chatContainer:GetTabName(i) == CMX.db.chatLog.name) then
                            chatContainer:AddEventMessageToWindow(chatWindow, message, CHAT_CATEGORY_SYSTEM)
                        end
                    end
                end
            end
        end

        local formattedMsg = formatMessage(msg)

        if LUIE.ChatAnnouncements.SV.ChatMethod == "Print to All Tabs" then
            sendToAllWindows(formattedMsg)
        else
            if isSystem and LUIE.ChatAnnouncements.SV.ChatSystemAll then
                sendToAllWindows(formattedMsg)
            else
                sendToSpecificTabs(formattedMsg)
            end
        end
    end

    LUIE.PrintToChat = PrintToChat
end
-- -----------------------------------------------------------------------------
--- Formats a number with optional shortening and localized separators.
--- @param number number The number to format
--- @param shorten? boolean Whether to abbreviate large numbers (e.g. 1.5M)
--- @param comma? boolean Whether to add localized digit separators
--- @return string|number The formatted number
function LUIE.AbbreviateNumber(number, shorten, comma)
    -- Handle shortening for large numbers
    if number > 0 and shorten then
        local value, suffix
        if number >= 1000000000 then
            value = number / 1000000000
            suffix = "G"
        elseif number >= 1000000 then
            value = number / 1000000
            suffix = "M"
        elseif number >= 1000 then
            value = number / 1000
            suffix = "k"
        else
            value = number
        end

        -- Format the value
        if value >= 1000 then
            -- Number too large even for G suffix, return full number
            return comma and ZO_CommaDelimitDecimalNumber(number) or number
        end

        -- Format with 0 or 1 decimal places based on size
        local formattedValue
        if value >= 100 or not suffix then
            formattedValue = zo_strformat("<<1>>", zo_floor(value))
        else
            formattedValue = zo_strformat("<<f:1>>", value) -- Uses 1 decimal place
        end

        -- Add suffix if we have one
        return suffix and (formattedValue .. suffix) or formattedValue
    end

    -- Just add separators if requested
    if comma then
        return ZO_CommaDelimitDecimalNumber(number)
    end

    return number
end

-- -----------------------------------------------------------------------------
--- Takes an input with a name identifier, title, text, and callback function to create a dialogue button.
--- @param identifier string: The identifier for the dialogue button.
--- @param title string: The title text for the dialogue button.
--- @param text string: The main text for the dialogue button.
--- @param callback function: The callback function to be executed when the button is clicked.
--- @return table identifier: The created dialogue button table.
function LUIE.RegisterDialogueButton(identifier, title, text, callback)
    ESO_Dialogs[identifier] =
    {
        gamepadInfo =
        {
            dialogType = GAMEPAD_DIALOGS.BASIC,
        },
        canQueue = true,
        title =
        {
            text = title,
        },
        mainText =
        {
            text = text,
        },
        buttons =
        {
            {
                text = SI_DIALOG_CONFIRM,
                callback = callback,
            },
            {
                text = SI_DIALOG_CANCEL,
            },
        },
    }
    return ESO_Dialogs[identifier]
end

-- -----------------------------------------------------------------------------
--- Function to update guild data.
--- Retrieves information about each guild the player is a member of and stores it in LUIE.GuildIndexData table.
function LUIE.UpdateGuildData()
    local GuildsIndex = GetNumGuilds()
    LUIE.GuildIndexData = {}
    for i = 1, GuildsIndex do
        local id = GetGuildId(i)
        local name = GetGuildName(id)
        local guildAlliance = GetGuildAlliance(id)
        LUIE.GuildIndexData[i] = { id = id, name = name, guildAlliance = guildAlliance }
    end
end

-- -----------------------------------------------------------------------------
--- Simple function to check the veteran difficulty.
--- @return boolean: Returns true if the player is in a veteran dungeon or using veteran difficulty, false otherwise.
function LUIE.ResolveVeteranDifficulty()
    if GetGroupSize() <= 1 and IsUnitUsingVeteranDifficulty("player") then
        return true
    elseif GetCurrentZoneDungeonDifficulty() == 2 or IsGroupUsingVeteranDifficulty() == true then
        return true
    else
        return false
    end
end

-- -----------------------------------------------------------------------------
--- Simple function that checks if the player is in a PVP zone.
--- @return boolean: Returns true if the player is PvP flagged, false otherwise.
function LUIE.ResolvePVPZone()
    if IsUnitPvPFlagged("player") then
        return true
    else
        return false
    end
end

-- -----------------------------------------------------------------------------
--- Pulls the name for the current morph of a skill.
--- @param abilityId number: The AbilityId of the skill.
--- @return string abilityName: The name of the current morph of the skill.
function LUIE.GetSkillMorphName(abilityId)
    local skillType, skillIndex, abilityIndex, morphChoice, rankIndex = GetSpecificSkillAbilityKeysByAbilityId(abilityId)
    local abilityName = GetSkillAbilityInfo(skillType, skillIndex, abilityIndex)
    return abilityName
end

-- -----------------------------------------------------------------------------
--- Pulls the icon for the current morph of a skill.
--- @param abilityId number: The AbilityId of the skill.
--- @return string abilityIcon: The icon path of the current morph of the skill.
function LUIE.GetSkillMorphIcon(abilityId)
    local skillType, skillIndex, abilityIndex, morphChoice, rankIndex = GetSpecificSkillAbilityKeysByAbilityId(abilityId)
    local abilityIcon = select(2, GetSkillAbilityInfo(skillType, skillIndex, abilityIndex))
    return abilityIcon
end

-- -----------------------------------------------------------------------------
--- Pulls the AbilityId for the current morph of a skill.
--- @param abilityId number: The AbilityId of the skill.
--- @return number morphAbilityId: The AbilityId of the current morph of the skill.
function LUIE.GetSkillMorphAbilityId(abilityId)
    local skillType, skillIndex, abilityIndex, morphChoice, rankIndex = GetSpecificSkillAbilityKeysByAbilityId(abilityId)
    local morphAbilityId = GetSkillAbilityId(skillType, skillIndex, abilityIndex, false)
    return morphAbilityId -- renamed local (abilityId) to avoid naming conflicts with the parameter
end

-- -----------------------------------------------------------------------------
--- Function to update the syntax for default Mundus Stone tooltips we pull (in order to retain scaling).
--- @param abilityId number: The ID of the ability.
--- @param tooltipText string: The original tooltip text.
--- @return string tooltipText: The updated tooltip text.
function LUIE.UpdateMundusTooltipSyntax(abilityId, tooltipText)
    -- Update syntax for The Lady, The Lover, and the Thief Mundus stones since they aren't consistent with other buffs.
    if abilityId == 13976 or abilityId == 13981 then -- The Lady / The Lover
        tooltipText = zo_strgsub(tooltipText, GetString(LUIE_STRING_SKILL_MUNDUS_SUB_RES_PEN), GetString(LUIE_STRING_SKILL_MUNDUS_SUB_RES_PEN_REPLACE))
    elseif abilityId == 13975 then                   -- The Thief
        tooltipText = zo_strgsub(tooltipText, GetString(LUIE_STRING_SKILL_MUNDUS_SUB_THIEF), GetString(LUIE_STRING_SKILL_MUNDUS_SUB_THIEF_REPLACE))
    end
    -- Replace "Increases your" with "Increase"
    tooltipText = zo_strgsub(tooltipText, GetString(LUIE_STRING_SKILL_MUNDUS_STRING), GetString(LUIE_STRING_SKILL_DRINK_INCREASE))
    return tooltipText
end

-- -----------------------------------------------------------------------------
--- @param index number
--- @param bar? HotBarCategory
--- @return number actionId
function LUIE.GetSlotTrueBoundId(index, bar)
    bar = bar or GetActiveHotbarCategory()
    local id = GetSlotBoundId(index, bar)
    local actionType = GetSlotType(index, bar)
    if actionType == ACTION_TYPE_CRAFTED_ABILITY then
        id = GetAbilityIdForCraftedAbilityId(id)
    end
    return id
end

-- -----------------------------------------------------------------------------
---
--- @param abilityId integer
--- @param overrideActiveRank boolean? -- Defaults to nil
--- @param overrideCasterUnitTag string? -- Defaults to "player"
--- @return integer durationMs
function LUIE.GetAbilityDuration(abilityId, overrideActiveRank, overrideCasterUnitTag)
    abilityId = abilityId or error("An abilityId must be provided to this function!")
    overrideActiveRank = overrideActiveRank or nil
    overrideCasterUnitTag = overrideCasterUnitTag or "player"
    return GetAbilityDuration(abilityId, overrideActiveRank, overrideCasterUnitTag)
end

-- -----------------------------------------------------------------------------

-- Add this if not already.
if not SLASH_COMMANDS["/rl"] then
    SLASH_COMMANDS["/rl"] = ReloadUI
end

-- -----------------------------------------------------------------------------
---
--- @param conditionType QuestConditionType
--- @return string
function LUIE.GetQuestConditionTypeName(conditionType)
    local conditionTypes =
    {
        [1] = "QUEST_CONDITION_TYPE_KILL_MONSTER",
        [2] = "QUEST_CONDITION_TYPE_INTERACT_MONSTER",
        [3] = "QUEST_CONDITION_TYPE_PLAYER_DEATH",
        [4] = "QUEST_CONDITION_TYPE_TIMER",
        [5] = "QUEST_CONDITION_TYPE_GOTO_POINT",
        [6] = "QUEST_CONDITION_TYPE_COLLECT_ITEM",
        [7] = "QUEST_CONDITION_TYPE_GIVE_ITEM",
        [8] = "QUEST_CONDITION_TYPE_INTERACT_OBJECT",
        [9] = "QUEST_CONDITION_TYPE_TALK_TO",
        [10] = "QUEST_CONDITION_TYPE_NPC_GOAL",
        [11] = "QUEST_CONDITION_TYPE_USE_QUEST_ITEM",
        [12] = "QUEST_CONDITION_TYPE_NPC_GOAL_FAIL",
        [13] = "QUEST_CONDITION_TYPE_FOLLOWER_LOST",
        [14] = "QUEST_CONDITION_TYPE_INTERACT_OBJECT_IN_STATE",
        [15] = "QUEST_CONDITION_TYPE_TRANSITION_INTERACT_OBJECT",
        [16] = "QUEST_CONDITION_TYPE_PLAYER_LOGOUT",
        [17] = "QUEST_CONDITION_TYPE_SCRIPT_ACTION",
        [18] = "QUEST_CONDITION_TYPE_ABILITY_USED_ON_NPC",
        [19] = "QUEST_CONDITION_TYPE_ABILITY_TYPE_USED_ON_NPC",
        [20] = "QUEST_CONDITION_TYPE_ENTER_SUBZONE",
        [21] = "QUEST_CONDITION_TYPE_EXIT_SUBZONE",
        [22] = "QUEST_CONDITION_TYPE_ABILITY_USED_ON_TABLE",
        [23] = "QUEST_CONDITION_TYPE_ABILITY_TYPE_USED_ON_TABLE",
        [24] = "QUEST_CONDITION_TYPE_KILL_MONSTER_TABLE",
        [25] = "QUEST_CONDITION_TYPE_DECONSTRUCT_ITEM",
        [26] = "QUEST_CONDITION_TYPE_KILL_ENEMY_PLAYERS",
        [27] = "QUEST_CONDITION_TYPE_KILL_ENEMY_GUARDS",
        [28] = "QUEST_CONDITION_TYPE_CAPTURE_KEEP_TYPE",
        [29] = "QUEST_CONDITION_TYPE_CAPTURE_SPECIFIC_KEEP",
        [30] = "QUEST_CONDITION_TYPE_HAS_ITEM",
        [31] = "QUEST_CONDITION_TYPE_CRAFT_ITEM",
        [32] = "QUEST_CONDITION_TYPE_PICKPOCKET_ITEM",
        [33] = "QUEST_CONDITION_TYPE_EQUIP_ITEM",
        [34] = "QUEST_CONDITION_TYPE_LEAVE_REVIVE_COUNTER_LIST",
        [35] = "QUEST_CONDITION_TYPE_EVENT_SUCCESS",
        [36] = "QUEST_CONDITION_TYPE_EVENT_FAIL",
        [37] = "QUEST_CONDITION_TYPE_FOLLOWER_GAINED",
        [38] = "QUEST_CONDITION_TYPE_INTERACT_SIMPLE_OBJECT",
        [39] = "QUEST_CONDITION_TYPE_INTERACT_SIMPLE_OBJECT_IN_STATE",
        [40] = "QUEST_CONDITION_TYPE_ARTIFACT_CAPTURED",
        [41] = "QUEST_CONDITION_TYPE_ARTIFACT_RETURNED",
        [42] = "QUEST_CONDITION_TYPE_KILL_ENEMY_PLAYERS_OF_CLASS",
        [43] = "QUEST_CONDITION_TYPE_KILL_ENEMY_PLAYERS_WHILE_DEFENDING_KEEP",
        [44] = "QUEST_CONDITION_TYPE_GATHER_ITEM",
        [45] = "QUEST_CONDITION_TYPE_ADVANCE_COMPLETABLE_SIBLINGS",
        [46] = "QUEST_CONDITION_TYPE_SELL_LAUNDER_ITEM",
        [47] = "QUEST_CONDITION_TYPE_KILL_BOUNTY_CLASSIFICATION_TYPE",
        [48] = "QUEST_CONDITION_TYPE_CRAFT_RANDOM_WRIT_ITEM",
        [49] = "QUEST_CONDITION_TYPE_GATHER_ITEM_TYPE",
        [50] = "QUEST_CONDITION_TYPE_BATTLEGROUND_PARTICIPATION",
        [51] = "QUEST_CONDITION_TYPE_BATTLEGROUND_VICTORY",
        [52] = "QUEST_CONDITION_TYPE_BATTLEGROUND_EARNED_POINTS",
        [53] = "QUEST_CONDITION_TYPE_GATHER_ITEM_TRAIT",
        [54] = "QUEST_CONDITION_TYPE_CAPTURE_KEEP_TYPE_UNIQUE_KEEPS",
        [55] = "QUEST_CONDITION_TYPE_SUMMONED_COMPANION",
        [56] = "QUEST_CONDITION_TYPE_DISMISSED_COMPANION",
        [57] = "QUEST_CONDITION_TYPE_LEVEL_UP",
        [58] = "QUEST_CONDITION_TYPE_EARN_CHAMPION_POINT",
        [60] = "QUEST_CONDITION_TYPE_UNEARTH_ANTIQUITY",
        [61] = "QUEST_CONDITION_TYPE_LOOT_TREASURE_CHEST",
        [62] = "QUEST_CONDITION_TYPE_VENDOR_GOLD_TRANSACTION",
        [63] = "QUEST_CONDITION_TYPE_GUILD_TRADER_GOLD_TRANSACTION",
        [64] = "QUEST_CONDITION_TYPE_ENTER_ZONE",
        [65] = "QUEST_CONDITION_TYPE_TRIBUTE_WON_MATCH_MONSTER",
        [66] = "QUEST_CONDITION_TYPE_TRIBUTE_LOST_MATCH_MONSTER",
        [67] = "QUEST_CONDITION_TYPE_TRIBUTE_WON_MATCH_PLAYER",
        [68] = "QUEST_CONDITION_TYPE_TRIBUTE_LOST_MATCH_PLAYER",
        [69] = "QUEST_CONDITION_TYPE_READ_BOOK",
        [70] = "QUEST_CONDITION_TYPE_KILL_MONSTER_TYPE",
        [71] = "QUEST_CONDITION_TYPE_MAX_VALUE"
    }
    return conditionTypes[conditionType] or string_format("UNKNOWN_CONDITION_TYPE_%d", conditionType)
end

-- -----------------------------------------------------------------------------
--- Converts a quest type to its string name representation
--- @param questType QuestType
--- @return string
function LUIE.GetQuestTypeName(questType)
    local questTypes =
    {
        [QUEST_TYPE_NONE] = "QUEST_TYPE_NONE",
        [QUEST_TYPE_GROUP] = "QUEST_TYPE_GROUP",
        [QUEST_TYPE_MAIN_STORY] = "QUEST_TYPE_MAIN_STORY",
        [QUEST_TYPE_GUILD] = "QUEST_TYPE_GUILD",
        [QUEST_TYPE_CRAFTING] = "QUEST_TYPE_CRAFTING",
        [QUEST_TYPE_DUNGEON] = "QUEST_TYPE_DUNGEON",
        [QUEST_TYPE_RAID] = "QUEST_TYPE_RAID",
        [QUEST_TYPE_AVA] = "QUEST_TYPE_AVA",
        [QUEST_TYPE_CLASS] = "QUEST_TYPE_CLASS",
        [QUEST_TYPE_AVA_GROUP] = "QUEST_TYPE_AVA_GROUP",
        [QUEST_TYPE_AVA_GRAND] = "QUEST_TYPE_AVA_GRAND",
        [QUEST_TYPE_HOLIDAY_EVENT] = "QUEST_TYPE_HOLIDAY_EVENT",
        [QUEST_TYPE_BATTLEGROUND] = "QUEST_TYPE_BATTLEGROUND",
        [QUEST_TYPE_PROLOGUE] = "QUEST_TYPE_PROLOGUE",
        [QUEST_TYPE_UNDAUNTED_PLEDGE] = "QUEST_TYPE_UNDAUNTED_PLEDGE",
        [QUEST_TYPE_COMPANION] = "QUEST_TYPE_COMPANION",
        [QUEST_TYPE_TRIBUTE] = "QUEST_TYPE_TRIBUTE",
        [QUEST_TYPE_SCRIBING] = "QUEST_TYPE_SCRIBING",
    }
    return questTypes[questType] or string_format("UNKNOWN_QUEST_TYPE_%d", questType)
end

-- -----------------------------------------------------------------------------
--- Valid item types for deconstruction
local DECONSTRUCTIBLE_ITEM_TYPES =
{
    [ITEMTYPE_ADDITIVE] = true,
    [ITEMTYPE_ARMOR_BOOSTER] = true,
    [ITEMTYPE_ARMOR_TRAIT] = true,
    [ITEMTYPE_BLACKSMITHING_BOOSTER] = true,
    [ITEMTYPE_BLACKSMITHING_MATERIAL] = true,
    [ITEMTYPE_BLACKSMITHING_RAW_MATERIAL] = true,
    [ITEMTYPE_CLOTHIER_BOOSTER] = true,
    [ITEMTYPE_CLOTHIER_MATERIAL] = true,
    [ITEMTYPE_CLOTHIER_RAW_MATERIAL] = true,
    [ITEMTYPE_ENCHANTING_RUNE_ASPECT] = true,
    [ITEMTYPE_ENCHANTING_RUNE_ESSENCE] = true,
    [ITEMTYPE_ENCHANTING_RUNE_POTENCY] = true,
    [ITEMTYPE_ENCHANTMENT_BOOSTER] = true,
    [ITEMTYPE_FISH] = true,
    [ITEMTYPE_GLYPH_ARMOR] = true,
    [ITEMTYPE_GLYPH_JEWELRY] = true,
    [ITEMTYPE_GLYPH_WEAPON] = true,
    [ITEMTYPE_GROUP_REPAIR] = true,
    [ITEMTYPE_INGREDIENT] = true,
    [ITEMTYPE_JEWELRYCRAFTING_BOOSTER] = true,
    [ITEMTYPE_JEWELRYCRAFTING_MATERIAL] = true,
    [ITEMTYPE_JEWELRYCRAFTING_RAW_BOOSTER] = true,
    [ITEMTYPE_JEWELRYCRAFTING_RAW_MATERIAL] = true,
    [ITEMTYPE_JEWELRY_RAW_TRAIT] = true,
    [ITEMTYPE_JEWELRY_TRAIT] = true,
    [ITEMTYPE_POISON_BASE] = true,
    [ITEMTYPE_POTION_BASE] = true,
    [ITEMTYPE_RAW_MATERIAL] = true,
    [ITEMTYPE_REAGENT] = true,
    [ITEMTYPE_STYLE_MATERIAL] = true,
    [ITEMTYPE_WEAPON] = true,
    [ITEMTYPE_WEAPON_BOOSTER] = true,
    [ITEMTYPE_WEAPON_TRAIT] = true,
    [ITEMTYPE_WOODWORKING_BOOSTER] = true,
    [ITEMTYPE_WOODWORKING_MATERIAL] = true,
    [ITEMTYPE_WOODWORKING_RAW_MATERIAL] = true,
}

-- -----------------------------------------------------------------------------
--- Valid crafting types for deconstruction
local DECONSTRUCTIBLE_CRAFTING_TYPES =
{
    [CRAFTING_TYPE_BLACKSMITHING] = true,
    [CRAFTING_TYPE_CLOTHIER] = true,
    [CRAFTING_TYPE_WOODWORKING] = true,
    [CRAFTING_TYPE_JEWELRYCRAFTING] = true,
}

-- -----------------------------------------------------------------------------
--- Get the current crafting mode, accounting for both keyboard and gamepad UI
--- @return number The current crafting mode
function LUIE.GetMode()
    if SCENE_MANAGER:IsShowingBaseScene() then
        -- Gamepad UI
        return SMITHING_GAMEPAD and SMITHING_GAMEPAD.mode or SMITHING.mode
    else
        -- Keyboard UI
        return SMITHING.mode
    end
end

-- -----------------------------------------------------------------------------
--- Checks if an item type is valid for deconstruction in the current crafting context
--- @param itemType number The item type to check
--- @return boolean Returns true if the item can be deconstructed in current context
function LUIE.ResolveCraftingUsed(itemType)
    local craftingType = GetCraftingInteractionType()
    local DECONSTRUCTION_MODE = 4

    -- Check if current crafting type allows deconstruction and we're in deconstruction mode
    return DECONSTRUCTIBLE_CRAFTING_TYPES[craftingType]
        and LUIE.GetMode() == DECONSTRUCTION_MODE
        and DECONSTRUCTIBLE_ITEM_TYPES[itemType] or false
end

-- -----------------------------------------------------------------------------
--- Utility function to handle font setup and validation
--- @param fontNameKey string: The key for the font name.
--- @param fontStyleKey string|nil: The key for the font style (optional).
--- @param fontSizeKey string|nil: The key for the font size (optional).
--- @param settings table: The settings table containing the font settings.
--- @param defaultFont string: The default font name.
--- @param defaultStyle string|nil: The default font style (optional).
--- @param defaultSize number|nil: The default font size (optional).
--- @return string: The formatted font string.
function LUIE.SetupFont(fontNameKey, fontStyleKey, fontSizeKey, settings, defaultFont, defaultStyle, defaultSize)
    -- Handle font name
    local fontName = LUIE.Fonts[settings[fontNameKey]]
    if not fontName or fontName == "" then
        LUIE.PrintToChat(GetString(LUIE_STRING_ERROR_FONT), true)
        fontName = defaultFont
    end

    -- Handle font size and style - if keys aren't provided, don't try to access them in settings
    local fontSize = fontSizeKey and ((settings[fontSizeKey] and settings[fontSizeKey] > 0) and settings[fontSizeKey] or defaultSize)
    local fontStyle = fontStyleKey and ((settings[fontStyleKey] and settings[fontStyleKey] ~= "") and settings[fontStyleKey] or defaultStyle)

    -- Build the font string based on what parameters are available
    if fontSize and fontStyle then
        return fontName .. "|" .. fontSize .. "|" .. fontStyle
    elseif fontSize then
        return fontName .. "|" .. fontSize
    else
        return fontName
    end
end

-- -----------------------------------------------------------------------------
--- Helper function to generate font string with appropriate shadow style based on size
--- @param fontName string: The name of the font.
--- @param fontSize number: The size of the font.
--- @param overrideShadowStyle? string: The shadow style to override.
--- @return string: The formatted font string.
function LUIE.GetFormattedFontString(fontName, fontSize, overrideShadowStyle)
    local shadowStyle = overrideShadowStyle
    if not shadowStyle then
        shadowStyle = fontSize <= 14 and "soft-shadow-thin" or "soft-shadow-thick"
    end
    return ("%s|%d|%s"):format(fontName, fontSize, shadowStyle)
end

-- -----------------------------------------------------------------------------

local CLASS_ICONS = {}

for i = 1, GetNumClasses() do
    local classId, lore, normalIconKeyboard, pressedIconKeyboard, mouseoverIconKeyboard, isSelectable, ingameIconKeyboard, ingameIconGamepad, normalIconGamepad, pressedIconGamepad = GetClassInfo(i)
    CLASS_ICONS[classId] = ingameIconGamepad
end

LUIE.CLASS_ICONS = CLASS_ICONS

function LUIE.GetClassIcon(classId)
    return CLASS_ICONS[classId]
end

-- -----------------------------------------------------------------------------

--- @param armorType any
--- @return integer counter
local function GetEquippedArmorPieces(armorType)
    local counter = 0
    for i = 0, 16 do
        local itemLink = GetItemLink(BAG_WORN, i, LINK_STYLE_DEFAULT)
        if GetItemLinkArmorType(itemLink) == armorType then
            counter = counter + 1
        end
    end
    return counter
end

-- Tooltip handler definitions
local TooltipHandlers =
{
    -- Brace
    [974] = function ()
        local _, _, mitigation = GetAdvancedStatValue(ADVANCED_STAT_DISPLAY_TYPE_BLOCK_MITIGATION)
        local _, _, speed = GetAdvancedStatValue(ADVANCED_STAT_DISPLAY_TYPE_BLOCK_SPEED)
        local _, cost = GetAdvancedStatValue(ADVANCED_STAT_DISPLAY_TYPE_BLOCK_COST)

        -- Get weapon type for resource determination
        local function getActiveWeaponType()
            local weaponPair = GetActiveWeaponPairInfo()
            if weaponPair == ACTIVE_WEAPON_PAIR_MAIN then
                return GetItemWeaponType(BAG_WORN, EQUIP_SLOT_MAIN_HAND)
            elseif weaponPair == ACTIVE_WEAPON_PAIR_BACKUP then
                return GetItemWeaponType(BAG_WORN, EQUIP_SLOT_BACKUP_MAIN)
            end
            return WEAPONTYPE_NONE
        end

        -- Determine resource type based on weapon and skills
        local function getResourceType()
            local weaponType = getActiveWeaponType()
            if weaponType == WEAPONTYPE_FROST_STAFF then
                local skillType, skillIndex, abilityIndex = GetSpecificSkillAbilityKeysByAbilityId(30948)
                local purchased = select(6, GetSkillAbilityInfo(skillType, skillIndex, abilityIndex))
                if purchased then
                    return GetString(SI_ATTRIBUTES2) -- Magicka
                end
            end
            return GetString(SI_ATTRIBUTES3) -- Stamina
        end

        local finalSpeed = 100 - speed
        local roundedMitigation = zo_floor(mitigation * 100 + 0.5) / 100
        return zo_strformat(GetString(LUIE_STRING_SKILL_BRACE_TP), roundedMitigation, finalSpeed, cost, getResourceType())
    end,

    -- Crouch
    [20299] = function ()
        local _, _, speed = GetAdvancedStatValue(ADVANCED_STAT_DISPLAY_TYPE_SNEAK_SPEED_REDUCTION)
        local _, cost = GetAdvancedStatValue(ADVANCED_STAT_DISPLAY_TYPE_SNEAK_COST)

        if speed <= 0 or speed >= 100 then
            return zo_strformat(GetString(LUIE_STRING_SKILL_HIDDEN_NO_SPEED_TP), cost)
        end
        return zo_strformat(GetString(LUIE_STRING_SKILL_HIDDEN_TP), 100 - speed, cost)
    end,

    -- Unchained
    [98316] = function ()
        local duration = (LUIE.GetAbilityDuration(98316) or 0) / 1000
        local pointsSpent = GetNumPointsSpentOnChampionSkill(64) * 1.1
        local adjustPoints = pointsSpent == 0 and 55 or zo_floor(pointsSpent * 100 + 0.5) / 100
        return zo_strformat(GetString(LUIE_STRING_SKILL_UNCHAINED_TP), duration, adjustPoints)
    end,

    -- Medium Armor Evasion
    [150057] = function ()
        local counter = GetEquippedArmorPieces(ARMORTYPE_MEDIUM) * 2
        return zo_strformat(GetString(LUIE_STRING_SKILL_MEDIUM_ARMOR_EVASION), counter)
    end,

    -- Unstoppable Brute
    [126582] = function ()
        local counter = GetEquippedArmorPieces(ARMORTYPE_HEAVY) * 5
        local duration = (LUIE.GetAbilityDuration(126582) or 0) / 1000
        return zo_strformat(GetString(LUIE_STRING_SKILL_UNSTOPPABLE_BRUTE), duration, counter)
    end,

    -- Immovable
    [126583] = function ()
        local counter = GetEquippedArmorPieces(ARMORTYPE_HEAVY) * 5
        local duration = (LUIE.GetAbilityDuration(126583) or 0) / 1000
        return zo_strformat(GetString(LUIE_STRING_SKILL_IMMOVABLE), duration, counter, 65 + counter)
    end,
}

-- Returns dynamic tooltips when called by Tooltip function
function LUIE.DynamicTooltip(abilityId)
    local handler = TooltipHandlers[abilityId]
    return handler and handler()
end
