
local changelogMessages = {
    General = {
        "General:",
        "* this is the a general changelog message. very very long and annoying",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "* this is the a general changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
    },
    BuffsAndDebuffs = {
        "Buffs and Debuffs:",
        "this is the a buffs and debuffs changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a buffs and debuffs changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a buffs and debuffs changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a buffs and debuffs changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a buffs and debuffs changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a buffs and debuffs changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
    },
    ChatAnnouncements = {
        "Chat Announcements:",
        "this is the a chat announcement changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a chat announcement changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a chat announcement changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a chat announcement changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a chat announcement changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
    },
    CombatInfo = {
        "Combat Info:",
        "this is the a combat info changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat info changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat info changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat info changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat info changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat info changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
    },
    CombatText = {
        "Combat Text:",
        "this is the a combat text changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat text changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat text changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a combat text changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
    },
    UnitFrames = {
        "UnitFrames:",
        "this is the a unitframe changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a unitframe changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a unitframe changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
        "this is the a unitframe changelog message. very very long and annoying bla bla bla bla bla need to wrap this at some point later though but not now. im dead inside. bla bla bla bla",
    }
}

function LUIE_ToggleChangelog(option)
    LUIEChangelog:SetHidden(option)
end

function LUIE_ChangelogScreen(option)
    local changelogGeneral = table.concat(changelogMessages.General, "\n")

    -- If text start with '*' replace it with bullet texture
    changelogGeneral = changelogGeneral:gsub("*", "|t16:16:EsoUI/Art/Miscellaneous/bullet.dds|t")

    -- Set the window title
    LUIEChangelogTitle:SetText(zo_strformat("<<1>> Changelog", LUIE.name))
    -- Set the about string
    LUIEChangelogAbout:SetText(zo_strformat("v<<1>> by <<2>>", LUIE.version, LUIE.author))

    LUIEChangelogText:SetText(changelogGeneral)
end
