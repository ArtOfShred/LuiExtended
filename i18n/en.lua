-- bindings.xml
ZO_CreateStringId("SI_BINDING_NAME_LUIE_DISPLAY_DAMAGE_METER",          "Display Damage Meter")
ZO_CreateStringId("SI_BINDING_NAME_LUIE_DISPLAY_DAMAGE_LOG",            "Display Damage Log")
ZO_CreateStringId("SI_BINDING_NAME_LUIE_POST_DAMAGE_RESULTS",           "Post Damage Results")
ZO_CreateStringId("SI_BINDING_NAME_LUIE_POST_HEALING_RESULTS",          "Post Healing Results")

-- LuiExtended.lua
ZO_CreateStringId("SI_LUIE_SLASHCMDS_DISBAND_FAILED_LFG_ACTIVITY",      "You cannot disband an LFG group.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_FRIEND_FAILED_NONAME",             "You must enter the account or character name of a player to add to friends.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_FRIEND_REMOVE_FAILED_NONAME",      "You must enter the account or online character name of a player to remove from friends.")

ZO_CreateStringId("SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG",                "You have invited \"|cFEFEFE<<1>>|r\" to be your friend.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_FRIEND_INVITE_MSG_LINK",           "You have invited |cFEFEFE<<1>>|r to be your friend.")

ZO_CreateStringId("SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_AVA",           "You cannot teleport to your home while in Cyrodiil.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_IN_COMBAT",     "You cannot teleport to your home while in combat.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_HOME_TRAVEL_FAILED_NOHOME",        "You don't have a primary home set.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_HOME_TRAVEL_SUCCESS_MSG",          "Teleporting to primary home...")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_DISBAND_FAILED_NOGROUP",           "You do not have a group to disband.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_DISBAND_FAILED_NOTLEADER",         "You must be the group leader to disband a group.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_IGNORE_FAILED_ALREADYIGNORE",      "That player is already ignored.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME",             "You must enter the account or character name of a player to add to ignored.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_IGNORE_FAILED_NONAME_REMOVE",      "You must enter the account name of a player to remove from ignored.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_NOGROUP",              "You must be in a group to attempt to remove a party member.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_SELF",                 "You cannot initiate a vote to kick yourself from the group.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_NONAME",               "You must enter the name of a party member to remove.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_INV",  "You must enter a valid guild number followed by an account or character name to invite to a guild.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILDACC_KICK", "You must enter a valid guild number followed by an account or online character name to remove from a guild.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDGUILD_LEAVE",   "You must enter a valid guild number to leave.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME",          "Could not find target player to remove from the group.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_KICK_FAILED_NOVALIDNAME_GUILD",    "Could not find target player to remove from the guild.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_FAILED_LFGACTIVITY",       "Regroup: You cannot initiate a regroup while in an LFG group.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTINGRP",          "Regroup: You must be in a group to do that.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_FAILED_NOTLEADER",         "Regroup: You must be the group leader to do that.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_FAILED_PENDING",           "Regroup: A regroup is currently pending, please wait for the current regroup to finish before attempting another.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_REINVITE_MSG",             "Regroup: Reinviting group members:")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_REINVITE_SENT_MSG",        "Invited → |cFFFFFF<<1>>|r") -- When localize option is turned on, this replaces other format.
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_SAVED_MSG",                "Regroup: Group saved! Disbanding...")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_SAVED_ALL_OFF_MSG",        "Regroup: No party members were online or eligible for regroup. Group was not disbanded.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_REGROUP_SAVED_SOME_OFF_MSG",       "Regroup: Group saved! <<1>> group <<2[member/members]>> <<3[was/were]>> offline, they will not be reinvited.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_TRADE_FAILED_NONAME",              "You must enter the name of a player to trade with.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFG",           "You must be in an LFG group to do that.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NOTLFGKICK",       "You must be in an LFG group to initiate a vote to remove a party member.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_VOTEKICK_FAILED_NONAME",           "You must enter the account or character name of a party member to initiate a vote to remove.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_CAMPAIGNQ_FAILED_NONAME",          "You must enter the name of the campaign to join.")
ZO_CreateStringId("SI_LUIE_SLASHCMDS_CAMPAIGNQ_FAILED_WRONCAMPAIGN",    "The Campaign you entered is not a valid Campaign.")

-- InfoPanel.lua
ZO_CreateStringId("SI_LUIE_PNL_FEEDNOW",                                "Feed Now")
ZO_CreateStringId("SI_LUIE_PNL_MAXED",                                  "Maxed")

-- SpellCastBuffs.lua
ZO_CreateStringId("SI_LUIE_SCB_WINDOWTITLE_PLAYERBUFFS",                "Player Buffs")
ZO_CreateStringId("SI_LUIE_SCB_WINDOWTITLE_PLAYERDEBUFFS",              "Player Debuffs")
ZO_CreateStringId("SI_LUIE_SCB_WINDOWTITLE_PLAYERLONGTERMEFFECTS",      "Player Long Term Effects")
ZO_CreateStringId("SI_LUIE_SCB_WINDOWTITLE_TARGETBUFFS",                "Target Buffs")
ZO_CreateStringId("SI_LUIE_SCB_WINDOWTITLE_TARGETDEBUFFS",              "Target Debuffs")
ZO_CreateStringId("SI_LUIE_SCB_RECALLCOOLDOWN",                         "Recall Cooldown")
ZO_CreateStringId("SI_LUIE_SCB_PET",                                    "Vanity Pet")
ZO_CreateStringId("SI_LUIE_SCB_MOUNTED",                                "Mounted")
ZO_CreateStringId("SI_LUIE_SCB_REZZIMMUNITY",                           "Resurrection Immunity")
ZO_CreateStringId("SI_LUIE_SCB_ERROR_FONT",                             "LUIE_SpellCastBuffs: There was a problem with selecting required font. Falling back to game default.")

-- ChatAnnouncements.lua
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_GOLD",                           " <<1[Gold/Gold]>>") -- Have to create singular strings here to use to prevent plural quantities from being double s
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_ALLIANCE_POINT",                 " <<1[Alliance Point/Alliance Points]>>") -- Have to create singular strings here to use to prevent plural quantities from being double s
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_TELVAR_STONE",                   " <<1[Tel Var Stone/Tel Var Stones]>>") -- Have to create singular strings here to use to prevent plural quantities from being double s
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_WRIT_VOUCHER",                   " <<1[Writ Voucher/Writ Vouchers]>>") -- Have to create singular strings here to use to prevent plural quantities from being double s

ZO_CreateStringId("SI_LUIE_CA_DEBUG_MSG_CURRENCY",                      "Currency Change Reason <<1>> Triggered - Please post on the LUI Extended comments section on ESOUI.com describing what caused this message. Thanks!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_ACCEPTED",                    "Duel challenge accepted.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_CANCELED",                    "Duel challenge canceled.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_DECLINED",                    "Duel challenge declined.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON1",                 "|cFEFEFE<<1>>|r is not available to duel.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON2",                 GetString(SI_DUELINVITEFAILREASON2))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON3",                 GetString(SI_DUELINVITEFAILREASON3))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON4",                 "|cFEFEFE<<1>>|r is not available to duel because they are too far away.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON5",                 "You cannot challenge another player to duel while you have challenged |cFEFEFE<<1>>|r.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON6",                 "You cannot challenge another player to duel while responding to a duel challenge from |cFEFEFE<<1>>|r.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON7",                 "You cannot challenge another player to duel while you are already dueling |cFEFEFE<<1>>|r.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON8",                 "|cFEFEFE<<1>>|r is not available to duel because they have challenged someone else to a duel.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON9",                 "|cFEFEFE<<1>>|r is not available to duel because they are considering another duel challenge.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON10",                "|cFEFEFE<<1>>|r is not available to duel because they are dueling another player.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON11",                 GetString(SI_DUELINVITEFAILREASON11))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON12",                "|cFEFEFE<<1>>|r is not available to duel because they are dead.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON13",                 GetString(SI_DUELINVITEFAILREASON13))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON14",                "|cFEFEFE<<1>>|r is not available to duel because they are swimming.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON15",                 GetString(SI_DUELINVITEFAILREASON15))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON16",                "|cFEFEFE<<1>>|r is not available to duel because they are in combat.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON17",                 GetString(SI_DUELINVITEFAILREASON17))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON18",                "|cFEFEFE<<1>>|r is not available to duel because they are crafting.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON19",                 GetString(SI_DUELINVITEFAILREASON19))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON20",                "You cannot challenge a player to duel who has recently declined your duel challenge.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON21",                 GetString(SI_DUELINVITEFAILREASON21))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_FAILREASON22",                 GetString(SI_DUELINVITEFAILREASON22))
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_PLAYER",                      "Challenge to Duel")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_RECEIVED",                    "|cFEFEFE<<1>>|r has challenged you to a duel.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_INVITE_SENT",                        "You have challenged |cFEFEFE<<1>>|r to a duel.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_NEAR_BOUNDARY_CSA",                  "You are close to the edge of the duel area!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_SELF_RESULT0",                       "You forfeited the duel!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_SELF_RESULT1",                       "You won the duel!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_RESULT0",                            "|cFEFEFE<<1>>|r forfeited the duel!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_RESULT1",                            "|cFEFEFE<<1>>|r won the duel!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_STARTED",                            "Duel started!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_STARTED_WITH_ICON",                  "<<1>> Duel started!")
ZO_CreateStringId("SI_LUIE_CA_DUEL_STATE1",                             "You are currently waiting for a duel challenge response from |cFEFEFE<<1>>|r.")
ZO_CreateStringId("SI_LUIE_CA_DUEL_STATE2",                             "You are currently considering a duel challenge from |cFEFEFE<<1>>|r.")

ZO_CreateStringId("SI_LUIE_CHAMPION_POINT_TYPE",                        "<<1>><<2>> <<3>> <<1[Point/Points]>>")

ZO_CreateStringId("SI_LUIE_CA_EXPERIENCE_MESSAGE",                      "You earn %s.")
ZO_CreateStringId("SI_LUIE_CA_EXPERIENCE_NAME",                         "experience <<1[point/points]>>")

-- COLLECTIBLES
ZO_CreateStringId("SI_LUIE_CA_COLLECTIBLE",                             "Collection Updated")

-- LOREBOOKS
ZO_CreateStringId("SI_LUIE_CA_LOREBOOK_BOOK",                           "Book Discovered")
ZO_CreateStringId("SI_LUIE_CA_LOREBOOK_ADDED_CSA",                      "<<1>> added to <<2>>")
ZO_CreateStringId("SI_LUIE_CA_LOREBOOK_ADDED_CA",                       "added to") -- Have to add this extra string for CA, if we try to colorize the whole string with the link, it also colorizes our custom link type.

ZO_CreateStringId("SI_LUIE_CA_FRIENDS_FRIEND_ADDED",                    "|cFEFEFE<<1>>|r added to friends.")
ZO_CreateStringId("SI_LUIE_CA_FRIENDS_FRIEND_REMOVED",                  "|cFEFEFE<<1>>|r removed from friends.")
ZO_CreateStringId("SI_LUIE_CA_FRIENDS_INCOMING_FRIEND_REQUEST",         "|cFEFEFE<<1>>|r wants to be your friend.")

ZO_CreateStringId("SI_LUIE_CA_PLAYER_TO_PLAYER_ALREADY_FRIEND",         "You are already friends with |cFEFEFE<<1>>|r.")


ZO_CreateStringId("SI_LUIE_CA_FRIENDS_LIST_LOGGED_OFF",                 "|cFEFEFE<<1>>|r has logged off.")
ZO_CreateStringId("SI_LUIE_CA_FRIENDS_LIST_LOGGED_ON",                  "|cFEFEFE<<1>>|r has logged on.")
ZO_CreateStringId("SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_OFF",       "|cFEFEFE<<1>>|r has logged off with |cFEFEFE<<2>>|r.")
ZO_CreateStringId("SI_LUIE_CA_FRIENDS_LIST_CHARACTER_LOGGED_ON",        "|cFEFEFE<<1>>|r has logged on with |cFEFEFE<<2>>|r.")
ZO_CreateStringId("SI_LUIE_CA_FRIENDS_LIST_IGNORE_ADDED",               "|cFEFEFE<<1>>|r added to ignored.")
ZO_CreateStringId("SI_LUIE_CA_FRIENDS_LIST_IGNORE_REMOVED",             "|cFEFEFE<<1>>|r removed from ignored.")

ZO_CreateStringId("SI_LUIE_CA_GROUP_INVITE_MENU",                       "You have invited |cFEFEFE<<1>>|r to join your group.")

ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE0",                    "Could not find a player named \"|cFEFEFE<<1>>|r\" to invite.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE1",                    "|cFEFEFE<<1>>|r accepted your group invitation.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE2",                    "|cFEFEFE<<1>>|r declined your group invitation.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE3",                    "|cFEFEFE<<1>>|r is ignoring you. You cannot extend a group invitation.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE4",                    "|cFEFEFE<<1>>|r already has a pending group invite.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE5",                    "|cFEFEFE<<1>>|r is already in a group.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE6",                    GetString(SI_GROUPINVITERESPONSE6))
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE7",                    GetString(SI_GROUPINVITERESPONSE7))
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE8",                    "You must be the group leader to extend a group invitation.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE9",                    "|cFEFEFE<<1>>|r is a member of another alliance.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE10",                   "You have invited \"|cFEFEFE<<1>>|r\" to join your group.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE11",                   GetString(SI_GROUPINVITERESPONSE11))
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE12",                   GetString(SI_GROUPINVITERESPONSE12))
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE13",                   "Unable to join |cFEFEFE<<1>>|r. The group is full.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE14",                   "Unable to join |cFEFEFE<<1>>|r. You are already in a group.")
ZO_CreateStringId("SI_LUIE_CA_GROUPINVITERESPONSE15",                   "|cFEFEFE<<1>>|r is currently in a battleground.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_ALERT_LFG_JOINED",            "You have joined an LFG group for |cFEFEFE<<1>>|r.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_VOTEKICK_FAIL",               "A vote to kick |cFEFEFE<<1>>|r from the group has failed.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_VOTEKICK_PASSED",             "A vote to kick |cFEFEFE<<1>>|r from the group has passed.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_VOTEKICK_START",              "A vote to kick |cFEFEFE<<1>>|r from the group has started.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_QUEUE_END",                   "You are no longer queued in the group finder.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_QUEUE_START",                 "You are now queued in the group finder.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY",        "Your |cFEFEFE<<1>>|r is ready.")
ZO_CreateStringId("SI_LUIE_CA_GROUPFINDER_READY_CHECK_ACTIVITY_ROLE",   "Your |cFEFEFE<<1>>|r is ready. Your role: |cFEFEFE<<2>> <<3>>|r")

ZO_CreateStringId("SI_LUIE_CA_GROUP_INVITE_NONAME",                     "You must enter the account or character name of a player to invite to group.")

ZO_CreateStringId("SI_LUIE_IGNORE_ERROR_TRADE",                         "You cannot trade with a player you are ignoring.")
ZO_CreateStringId("SI_LUIE_IGNORE_ERROR_GROUP",                         "You cannot extend a group invitation to a player you are ignoring.")
ZO_CreateStringId("SI_LUIE_IGNORE_ERROR_DUEL",                          "You cannot challenge a player you are ignoring to a duel.")
ZO_CreateStringId("SI_LUIE_IGNORE_ERROR_FRIEND",                        "You cannot add a player you are ignoring as a friend.")
ZO_CreateStringId("SI_LUIE_IGNORE_ERROR_WHISPER",                       "You cannot whisper a player you are ignoring.")
ZO_CreateStringId("SI_LUIE_IGNORE_ERROR_GUILD",                         "You cannot extend a guild invitation to a player you are ignoring.")

ZO_CreateStringId("SI_LUIE_CA_GROUP_LEADERKICK_ERROR",                  "You must be the group leader to remove a player from the group.")

ZO_CreateStringId("SI_LUIE_NOTIFICATION_GROUP_INVITE",                  "Group invitation")
ZO_CreateStringId("SI_LUIE_NOTIFICATION_SHARE_QUEST_INVITE",            "Shared quest")
ZO_CreateStringId("SI_LUIE_NOTIFICATION_FRIEND_INVITE",                 "Friend invitation")
ZO_CreateStringId("SI_LUIE_NOTIFICATION_GUILD_INVITE",                  "Guild invitation")

ZO_CreateStringId("SI_LUIE_CA_GROUP_GROUPLEAVEREASON1",                 "<<1>>(<<2>>) has been removed from the group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE",              "|cFEFEFE<<1>>|r wants to share the quest, <<2>>, with you.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_INCOMING_QUEST_SHARE_P2P",          "|cFEFEFE<<1>>|r wants to share the quest, |cFEFEFE<<2>>|r, with you.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_INVITE_MESSAGE",                    "|cFEFEFE<<1>>|r has invited you to join a group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_LEADER_CHANGED",                    "|cFEFEFE<<1>>|r is now the group leader!")
ZO_CreateStringId("SI_LUIE_CA_GROUP_LEADER_CHANGED_SELF",               "You are now the group leader!")
ZO_CreateStringId("SI_LUIE_CA_GROUP_MEMBER_DISBAND_MSG",                "The group has been disbanded.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_MEMBER_JOIN",                       "|cFEFEFE<<1>>|r has joined the group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_MEMBER_JOIN_SELF",                  "You have joined a group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_MEMBER_KICKED",                     "|cFEFEFE<<1>>|r has been removed from the group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_MEMBER_LEAVE",                      "|cFEFEFE<<1>>|r has left the group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_MEMBER_LEAVE_SELF",                 "You have left the group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_QUIT",                              "You are no longer in a group.")
ZO_CreateStringId("SI_LUIE_CA_GROUP_QUIT_LFG",                          "You are no longer in an LFG group.")

ZO_CreateStringId("SI_LUIE_GROUPLEAVEREASON0",                          "|cFEFEFE<<1>>|r has left the group.")
ZO_CreateStringId("SI_LUIE_GROUPLEAVEREASON1",                          "|cFEFEFE<<1>>|r has been removed from the group.")
ZO_CreateStringId("SI_LUIE_GROUPLEAVEREASON2",                          "|cFEFEFE<<1>>|r has disbanded the group.")
ZO_CreateStringId("SI_LUIE_GROUPLEAVEREASON4",                          "|cFEFEFE<<1>>|r has left the battleground.")

ZO_CreateStringId("SI_LUIE_GROUPDISBANDLEADER",                         "You have disbanded the group.")

ZO_CreateStringId("SI_LUIE_CA_GROUP_TRIAL_STARTED",                     "Started: <<1>>")
ZO_CreateStringId("SI_LUIE_CA_GROUP_TRIAL_FAILED",                      "Failed: <<1>>")
ZO_CreateStringId("SI_LUIE_CA_GROUP_TRIAL_COMPLETED_LARGE",             "Completed: <<1>>")
ZO_CreateStringId("SI_LUIE_CA_GROUP_TRIAL_SCORETALLY",                  "Final Score <<1>> Total Time <<2>> Vitality Bonus <<3>> <<4>>")
ZO_CreateStringId("SI_LUIE_CA_GROUP_REVIVE_COUNTER_UPDATED",            "<<1>> Vitality Bonus Decreased")
ZO_CreateStringId("SI_LUIE_CA_GROUP_TRIAL_SCORE_UPDATED",               "<<1>> <<2>> Points Rewarded")

ZO_CreateStringId("SI_LUIE_CA_GUILD_HERALDRY_UPDATE",                   "The heraldry for <<1>> has changed.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_RANKS_UPDATE",                      "Changes to ranks for <<1>> saved.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_RANK_UPDATE",                       "Changes to the rank <<1>> for <<2>> saved.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_MOTD_CHANGED",                      "The message of the day for <<1>> has changed.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_DESCRIPTION_CHANGED",               "The description for <<1>> has changed.")

ZO_CreateStringId("SI_LUIE_CA_GUILD_INCOMING_GUILD_REQUEST",            "|cFEFEFE<<1>>|r has invited you to join <<2>>.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_INVITE_MESSAGE",                    "|cFEFEFE<<3>>|r has invited you to join <<X:1>> |cFEFEFE<<2>>|r.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_JOIN_SELF",                         "You have joined <<1>>.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_LEAVE_SELF",                        "You have left <<1>>.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_RANK_CHANGED",                      "|cFEFEFE<<1>>|r's rank in <<2>> has been changed to <<3>>.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_RANK_CHANGED_SELF",                 "You have been <<1>> to <<2>> in <<3>>.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_RANK_DOWN",                         "demoted")
ZO_CreateStringId("SI_LUIE_CA_GUILD_RANK_UP",                           "promoted")
ZO_CreateStringId("SI_LUIE_CA_GUILD_ROSTER_ADDED",                      "|cFEFEFE<<1>>|r has joined <<2>>.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_ROSTER_INVITED_MESSAGE",            "You have invited \"|cFEFEFE<<1>>|r\" to join <<2>>.")
ZO_CreateStringId("SI_LUIE_CA_GUILD_ROSTER_LEFT",                       "|cFEFEFE<<1>>|r has left <<2>>.")
ZO_CreateStringId("SI_LUIE_CA_JUSTICE_CONFISCATED_BOUNTY_ITEMS_MSG",    "Bounty and stolen items confiscated!")
ZO_CreateStringId("SI_LUIE_CA_JUSTICE_CONFISCATED_MSG",                 "Bounty confiscated!")
ZO_CreateStringId("SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DANGER",           "Danger! Sentry nearby!")
ZO_CreateStringId("SI_LUIE_CA_JUSTICE_DISGUISE_STATE_SUSPICIOUS",       "Danger! You are arousing suspicion!")
ZO_CreateStringId("SI_LUIE_CA_JUSTICE_DISGUISE_STATE_NONE",             "You are no longer disguised")
ZO_CreateStringId("SI_LUIE_CA_JUSTICE_DISGUISE_STATE_DISGUISED",        "You are now disguised")

ZO_CreateStringId("SI_LUIE_CA_LOCKPICK_FAILED",                         "Lockpick failed!")
ZO_CreateStringId("SI_LUIE_CA_LOCKPICK_SUCCESS",                        "Lockpick successful!")

ZO_CreateStringId("SI_LUIE_CA_LVL_ANNOUNCE_CP",                         "Champion Level Achieved!")
ZO_CreateStringId("SI_LUIE_CA_LVL_ANNOUNCE_XP",                         "You have reached")

ZO_CreateStringId("SI_LUIE_CA_MAIL_DELETED_MSG",                        "Mail deleted!")

ZO_CreateStringId("SI_LUIE_CA_MAIL_RECEIVED",                           "Mail received.")
ZO_CreateStringId("SI_LUIE_CA_MAIL_RECEIVED_COD",                       "COD payment sent!")

ZO_CreateStringId("SI_LUIE_CA_MAIL_SENT",                               "Mail sent!")
ZO_CreateStringId("SI_LUIE_CA_MAIL_SENT_COD",                           "COD sent!")

ZO_CreateStringId("SI_LUIE_CA_MAIL_ERROR_NO_COD_VALUE",                 "You must set the Cash on Delivery amount.")

ZO_CreateStringId("SI_LUIE_CA_MAIL_SENDMAILRESULT2",                    "Unknown player.") -- Fixing missing periods on default strings
ZO_CreateStringId("SI_LUIE_CA_MAIL_SENDMAILRESULT3",                    "Recipient's Inbox is full.") -- Fixing missing periods on default strings

ZO_CreateStringId("SI_LUIE_CA_ACHIEVEMENT_PROGRESS_MSG",                "Achievement Updated")

ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT0",                "|cFEFEFE<<1>>|r is too busy to pledge with.")
ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT1",                "You can't join in the Ritual of Mara with a player who is dead.")
ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT2",                "Beginning Ritual of Mara with |cFEFEFE<<1>>|r.")
ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT3",                "You have been joined with |cFEFEFE<<1>>|r in the Ritual of Mara.")
ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT4",                "|cFEFEFE<<1>>|r has declined the Ritual of Mara request")
ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT5",                GetString(SI_PLEDGEOFMARARESULT5))
ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT6",                "|cFEFEFE<<1>>|r is not eligible for the Ritual of Mara.")
ZO_CreateStringId("SI_LUIE_CA_MARA_PLEDGEOFMARARESULT7",                "You are too far away from |cFEFEFE<<1>>|r to perform the Ritual of Mara.")

ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_RECEIVE",                "You receive %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_LOOT",                   "You loot %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_EARN",                   "You earn %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_SPEND",                  "You spend %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_LOST",                   "You lost %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_STEAL",                  "You steal %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_PICKPOCKET",             "You pickpocket %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_BOUNTY",                 "You pay off your bounty of %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_CONFISCATE",             "A guard confiscates %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_REPAIR",                 "You pay %s in repairs.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_TRADER",                 "You purchase an item from the guild trader for %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_LISTING",                "Listing fee of %s charged.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_TRADEIN",                "You receive %s from %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_TRADEOUT",               "You trade %s to %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_MAILIN",                 "You receive mail with %s from %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_MAILOUT",                "You mail %s to %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_MAILCOD",                "You send a COD payment of %s to %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_POSTAGE",                "You pay %s in postage.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSIT",                "You deposit %s in your bank.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAW",               "You withdraw %s from your bank.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_WITHDRAWGUILD",          "You withdraw %s from the guild bank.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_DEPOSITGUILD",           "You deposit %s in the guild bank.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_WAYSHRINE",              "Wayshrine fee of %s charged.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_UNSTUCK",                "Unstuck fee of %s charged.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_STABLE",                 "You purchase %s for %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_STORAGE",                "You purchase %s for %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_ATTRIBUTES",             "You make a donation of %s to redistribute your Attribute Points.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_CHAMPION",               "You pay a fee of %s to redistribute your Champion Points.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_SKILLS",                 "You make a donation of %s to redistribute your Skill Points.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_MORPHS",                 "You make a donation of %s to redistribute your Skill Morphs.")

ZO_CreateStringId("SI_LUIE_CA_CURRENCY_NOTIFY_CHAMPION",                "Champion Points redistributed")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_NOTIFY_ATTRIBUTES",              "Attribute Points reset")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_NOTIFY_SKILLS",                  "Skill Points reset")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_NOTIFY_MORPHS",                  "Skill Morphs reset")

ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_HERALDRY",               "You spend %s from your guild bank to update your %s.")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_NAME_HERALDRY",                  "Guild Heraldry")

ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_LOOT",                       "You loot %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_RECEIVE",                    "You receive %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_STEAL",                      "You steal %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_PICKPOCKET",                 "You pickpocket %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_CONFISCATE",                 "A guard has confiscated %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_TRADEIN",                    "You receive %s from %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_TRADEOUT",                   "You trade %s to %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_MAILIN",                     "You receive mail with %s from %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_MAILOUT",                    "You mail %s to %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_DEPOSIT",                    "You deposit %s in your bank.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_WITHDRAW",                   "You withdraw %s from your bank.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_DEPOSITGUILD",               "You deposit %s in the guild bank.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_WITHDRAWGUILD",              "You withdraw %s from the guild bank.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_BUY",                        "You purchase %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_BUY_VALUE",                  "You purchase %s for %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_BUYBACK",                    "You buyback %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_BUYBACK_VALUE",              "You buyback %s for %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_SELL",                       "You sell %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_SELL_VALUE",                 "You sell %s for %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_FENCE",                      "You fence %s for %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_LAUNDER",                    "You launder %s for %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_USE",                        "You use %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_CRAFT",                      "You craft %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_EXTRACT",                    "You extract %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_UPGRADE",                    "You upgrade %s to %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_UPGRADE_FAIL",               "You fail to upgrade %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_REFINE",                     "You refine %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_DECONSTRUCT",                "You deconstruct %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_RESEARCH",                   "You research %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_DESTROY",                    "You destroy %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_LOCKPICK",                   "Your %s breaks.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_REMOVE",                     "Removed %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_GROUP",                      "%s loots %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_EQUIP",             "You equip %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_REMOVE",            "You unequip %s.")
ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_DISGUISE_DESTROY",           "Your %s is destroyed.")

ZO_CreateStringId("SI_LUIE_CA_STORAGE_RIDINGTYPE1",                     "Riding Speed Upgrade")
ZO_CreateStringId("SI_LUIE_CA_STORAGE_RIDINGTYPE2",                     "Riding Capacity Upgrade")
ZO_CreateStringId("SI_LUIE_CA_STORAGE_RIDINGTYPE3",                     "Riding Stamina Upgrade")

ZO_CreateStringId("SI_LUIE_CA_STORAGE_BAG_UPGRADE",                     "Your inventory capacity has increased.")
ZO_CreateStringId("SI_LUIE_CA_STORAGE_BANK_UPGRADE",                    "Your bank capacity has increased.")

ZO_CreateStringId("SI_LUIE_CA_STORAGE_BAGTYPE1",                        "Backpack Upgrade")
ZO_CreateStringId("SI_LUIE_CA_STORAGE_BAGTYPE2",                        "Bank Space Upgrade")

ZO_CreateStringId("SI_LUIE_CA_STORAGE_LEARN",                           "You learn %s")

ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_TOTALGOLD",              "Total Gold: %s")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_TOTALAP",                "Total AP: %s")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_TOTALTV",                "Total TV: %s")
ZO_CreateStringId("SI_LUIE_CA_CURRENCY_MESSAGE_TOTALWV",                "Total Vouchers: %s")

ZO_CreateStringId("SI_LUIE_CA_LOOT_MESSAGE_TOTAL",                      "New Total:")

ZO_CreateStringId("SI_LUIE_CA_SKILL_LINE_ADDED",                        "Skill line gained: <<1>><<2>>")
ZO_CreateStringId("SI_LUIE_CA_ABILITY_RANK_UP",                         "<<1>> Increased to Rank <<R:2>>")

ZO_CreateStringId("SI_LUIE_CA_SKILL_GUILD_MSG",                         "You earn %s.")
ZO_CreateStringId("SI_LUIE_CA_SKILL_GUILD_REPUTATION",                  "<<1[reputation/reputation]>>")
ZO_CreateStringId("SI_LUIE_CA_SKILL_GUILD_ALERT",                       "Your <<1>> reputation has increased.")

ZO_CreateStringId("SI_LUIE_CA_QUEST_ABANDONED",                         "Abandoned: <<1>>")
ZO_CreateStringId("SI_LUIE_CA_QUEST_ABANDONED_WITH_ICON",               "Abandoned: <<1>> <<2>>")
ZO_CreateStringId("SI_LUIE_CA_QUEST_DISCOVER",                          "Discovered: <<1>>")

ZO_CreateStringId("SI_LUIE_CA_QUEST_ACCEPT",                            "Started: ")
ZO_CreateStringId("SI_LUIE_CA_QUEST_ACCEPT_WITH_ICON",                  "Started: <<1>> <<2>>")
ZO_CreateStringId("SI_LUIE_CA_QUEST_COMPLETE_WITH_ICON",                "Completed: <<1>> <<2>>")
ZO_CreateStringId("SI_LUIE_CA_QUEST_LOG_FULL",                          "Your quest log is full.")

ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT0",                      GetString(SI_TRADEACTIONRESULT0))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT1",                      "|cFEFEFE<<1>>|r is ignoring you. You cannot initiate a trade.")
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT2",                      GetString(SI_TRADEACTIONRESULT2))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT3",                      GetString(SI_TRADEACTIONRESULT3))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT4",                      GetString(SI_TRADEACTIONRESULT4))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT5",                      GetString(SI_TRADEACTIONRESULT5))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT6",                      GetString(SI_TRADEACTIONRESULT6))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT8",                      GetString(SI_TRADEACTIONRESULT8))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT9",                      GetString(SI_TRADEACTIONRESULT9))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT12",                     GetString(SI_TRADEACTIONRESULT12))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT13",                     GetString(SI_TRADEACTIONRESULT13))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT14",                     GetString(SI_TRADEACTIONRESULT14))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT41",                     GetString(SI_TRADEACTIONRESULT41))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT42",                     GetString(SI_TRADEACTIONRESULT42))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT43",                     GetString(SI_TRADEACTIONRESULT43))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT44",                     GetString(SI_TRADEACTIONRESULT44))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT45",                     GetString(SI_TRADEACTIONRESULT45))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT46",                     GetString(SI_TRADEACTIONRESULT46))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT62",                     GetString(SI_TRADEACTIONRESULT62))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT63",                     GetString(SI_TRADEACTIONRESULT63))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT64",                     GetString(SI_TRADEACTIONRESULT64))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT65",                     "You are already trading|cFEFEFE<<1>>|r.")
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT66",                     GetString(SI_TRADEACTIONRESULT66))
ZO_CreateStringId("SI_LUIE_CA_TRADEACTIONRESULT80",                     GetString(SI_TRADEACTIONRESULT80))

ZO_CreateStringId("SI_LUIE_CA_TRADE_INVITE_ACCEPTED",                   "Trade invitation accepted.")
ZO_CreateStringId("SI_LUIE_CA_TRADE_INVITE_DECLINED",                   "Trade invitation declined.")
ZO_CreateStringId("SI_LUIE_CA_TRADE_INVITE_CANCELED",                   "Trade invitation canceled.")
ZO_CreateStringId("SI_LUIE_CA_TRADE_INVITE_CONFIRM",                    "You have invited |cFEFEFE<<1>>|r to trade.")
ZO_CreateStringId("SI_LUIE_CA_TRADE_INVITE_MESSAGE",                    "|cFEFEFE<<1>>|r has invited you to trade.")

-- Entering/Leaving Group Area Notifications used by EVENT_DISPLAY_ANNOUNCEMENT. These don't appear to have any strings in localizegeneratedstrings.lua, so we check for the Default (_D) here and replace the CSA with (_C) to remove the punctuation.
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_D",       "Entering Group Area.")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_D",       "Leaving Group Area.")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPENTER_C",       "Entering Group Area")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_GROUPLEAVE_C",       "Leaving Group Area")

-- VMA Notifications used by EVENT_DISPLAY_ANNOUNCEMENT
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MAELSTROM",          "Maelstrom Arena")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MAELSTROM_CA",       "Maelstrom Arena: ")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE1",          "Vale of the Surreal")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE2",          "Seht's Balcony")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE3",          "Drome of Toxic Shock")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE4",          "Seht's Flywheel")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE5",          "Rink of Frozen Blood")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE6",          "Spiral Shadows")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE7",          "Vault of Umbrage")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE8",          "Igneous Cistern")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_STAGE9",          "Theater of Despair")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND1",          "Round 1")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND1_CA",       "Round 1!")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND2",          "Round 2")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND2_CA",       "Round 2!")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND3",          "Round 3")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND3_CA",       "Round 3!")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND4",          "Round 4")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND4_CA",       "Round 4!")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND5",          "Round 5")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUND5_CA",       "Round 5!")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUNDF",          "Final Round")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_MA_ROUNDF_CA",       "Final Round!")

-- DSA Notifications used by EVENT_DISPLAY_ANNOUNCEMENT

ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA",                "Dragonstar Arena")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA_CA",             "Dragonstar Arena: ")
ZO_CreateStringId("SI_LUIE_CA_DISPLAY_ANNOUNCEMENT_DSA_DESC",           "The arena will begin in 30 seconds!")

-- UnitFrames.lua
ZO_CreateStringId("SI_LUIE_UF_ERROR_FONT",                              "LUIE_CustomFrames: There was a problem with selecting required font. Falling back to game default.")

-- LuiExtendedSettings.lua

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BASE SETTINGS -- LAM --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ZO_CreateStringId("SI_LUIE_LAM_COMPATIBILITY_WARNING",                  "Disable this option if you are having compatibility issues with other addons.")
ZO_CreateStringId("SI_LUIE_LAM_FONT",                                   "Font")
ZO_CreateStringId("SI_LUIE_LAM_FONT_SIZE",                              "Font Size")
ZO_CreateStringId("SI_LUIE_LAM_FONT_STYLE",                             "Font Style")
ZO_CreateStringId("SI_LUIE_LAM_GENERIC_WARNING",                        "Compatibility option!")
ZO_CreateStringId("SI_LUIE_LAM_LUIPRINTTOCHAT",                         "Use LUIE print to chat function")
ZO_CreateStringId("SI_LUIE_LAM_LUIPRINTTOCHAT_TP",                      "Enable this if you are having issues with printed Chat Announcements. Enabling this will prevent other chat addons like PChat from interfering with messages displayed by LUIE, and allow you to prepend messages with a timestamp similiar to pChat.")
ZO_CreateStringId("SI_LUIE_LAM_RELOADUI",                               "This will reload the UI.")
ZO_CreateStringId("SI_LUIE_LAM_RELOADUI_WARNING",                       "Will need to reload the UI.")
ZO_CreateStringId("SI_LUIE_LAM_RESETPOSITION",                          "Reset position")

ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDSHEADER",                        "LUIE Slash Commands Overview")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDSHEADER_GENERAL",                "General Commands:")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_TRADE",                        "'/trade' 'name' Invites a player to trade with you.")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_HOME",                         "'/home' Ports the user to their primary home.")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDSHEADER_GROUP",                  "Group Commands:")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_REGROUP",                      "'/regroup' Saves your current party configuration, disbands the group and reinvites them after 5 seconds. This command does not work in LFG.")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_LEAVE",                        "'/leave' Leaves the current group.\n\t\t\t\t\tAlternate options: '/leavegroup'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_DISBAND",                      "'/disband' Disbands the current group if you are group leader.")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_KICK",                         "'/kick' 'name' Kicks a member from the current group if you are group leader.\n\t\t\t\t\tAlternate options: '/remove', '/groupkick', '/groupremove'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_VOTEKICK",                     "/votekick' 'name' Initiates a vote to kick a member from your current LFG group.\n\t\t\t\t\tAlternate options: '/voteremove'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDSHEADER_GUILD",                  "Guild Commands:")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_GUILDINVITE",                  "'/guildinvite' '#' 'name' Invites a player to one of your guilds based on their order in your Guild Menu.\n\t\t\t\t\tAlternate options: /'ginvite'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_GUILDKICK",                    "'/guildkick' '#' 'name' Kicks a player from one of your guilds if you have permissions to do so.\n\t\t\t\t\tAlternate options: '/gkick'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_GUILDQUIT",                    "'/guildquit' '#' Leave one of your guilds based on their order in your Guild Menu.\n\t\t\t\t\tAlternate options: '/gquit', '/guildleave', '/gleave'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDSHEADER_SOCIAL",                 "Social Commands:")          
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_FRIEND",                       "'/friend' 'name' Invite a player to be friends.\n\t\t\t\t\tAlternate options: '/addfriend'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_IGNORE",                       "'/ignore' 'name' Add a player to ignored.\n\t\t\t\t\t\tAlternate options: '/addignore'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_REMOVEFRIEND",                 "'/unfriend' 'name' Remove a player from friends.\n\t\t\t\t\tAlternate options: '/removefriend'")
ZO_CreateStringId("SI_LUIE_LAM_SLASHCMDS_REMOVEIGNORE",                 "'/unignore' 'name' Remove a player from ignored.\n\t\t\t\t\tAlternate options: '/removeignore'")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LAM MODULE ON/OFF --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ZO_CreateStringId("SI_LUIE_LAM_STARTUPMSG",                             "Disable startup message")
ZO_CreateStringId("SI_LUIE_LAM_STARTUPMSG_TP",                          "This setting will disable the startup message.")
ZO_CreateStringId("SI_LUIE_LAM_TIMESTAMP",                              "Include Timestamp")
ZO_CreateStringId("SI_LUIE_LAM_TIMESTAMPFORMAT",                        "Timestamp format")
ZO_CreateStringId("SI_LUIE_LAM_TIMESTAMPFORMAT_TP",                     "FORMAT:\nHH: hours (24)\nhh: hours (12)\nH: hour (24, no leading 0)\nh: hour (12, no leading 0)\nA: AM/PM\na: am/pm\nm: minutes\ns: seconds")
ZO_CreateStringId("SI_LUIE_LAM_TIMESTAMP_TP",                           "Prepend printed text with current time label.")
ZO_CreateStringId("SI_LUIE_LAM_UF",                                     "Unit Frames")
ZO_CreateStringId("SI_LUIE_LAM_CA",                                     "Chat Announce")
ZO_CreateStringId("SI_LUIE_LAM_CI",                                     "Combat Info")
ZO_CreateStringId("SI_LUIE_LAM_CI_DESCRIPTION",                         "Allows display of ultimate value on bars, effect tracker on bars, as well as cooldown tracking for quick slot items and GCD display for action bars.")
ZO_CreateStringId("SI_LUIE_LAM_BUFFS_DESCRIPTION",                      "Enables buff and debuff display for effects on the player and target. Also has options for various other enhancements.")
ZO_CreateStringId("SI_LUIE_LAM_BUFFSDEBUFFS",                           "Buffs & Debuffs")
ZO_CreateStringId("SI_LUIE_LAM_NAMEDISPLAYMETHOD",                      "Player Name Display Method")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BUFFS & DEBUFFS -- LAM --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ZO_CreateStringId("SI_LUIE_LAM_BUFF_ENABLEEFFECTSTRACK",                "Enable Buffs & Debuffs Module")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HEADER_POSITION",                   "Position and Display Options")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HARDLOCK",                          "Hard-Lock Position to Unit Frames")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HARDLOCK_TP",                       "Hard-Lock position of buff frames to health bar of unit frames (default or custom).")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HARDLOCK_WARNING",                  "Will need to reload the UI.\nWhen this position is locked, you will not be able to buff frames.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_UNLOCKWINDOW",                      "Unlock Buffs Window")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_UNLOCKWINDOW_TP",                   "Unlock to drag buff icon frames. This will not unlock frames that are locked to the unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_RESETPOSITION_TP",                  "This will reset position of all buff icon containers to the default position.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF",                    "Hide PLAYER Buffs")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDEPLAYERBUFF_TP",                 "Prevents your buffs from displaying.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF",                  "Hide PLAYER Debuffs")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDEPLAYERDEBUFF_TP",               "Prevents your debuffs from displaying.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDETARGETBUFF",                    "Hide TARGET Buffs")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDETARGETBUFF_TP",                 "Prevents buffs on your target from displaying.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF",                  "Hide TARGET Debuffs")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDETARGETDEBUFF_TP",               "Prevents debuffs on your target from displaying.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF",              "Hide GROUND Buffs and Debuffs")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HIDEGROUNDBUFFDEBUFF_TP",           "Prevents ground targeted effects from displaying.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_ICON_HEADER",                       "Icon Options")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_ICONSIZE",                          "Buff Icon Size")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_ICONSIZE_TP",                       "Choose the size for buff icons.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL",               "Display Remaining Time Label")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_SHOWREMAINTIMELABEL_TP",            "Show text label with number of seconds left until the buff expires.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LABEL_POSITION_TP",                 "Adjust the vertical position of the buff countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_FONT_TP",                           "Choose the font to use for the buff countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_FONTSIZE_TP",                       "Choose the font size for the buff countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_FONTSTYLE_TP",                      "Choose the font style for the buff countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LABELCOLOR_TP",                     "Set the color of text label to be the same as icon border or keep it white.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS",               "Show Second Fractions")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_SHOWSECONDFRACTIONS_TP",            "Format remaining text labels as \"12.3\" or keep only seconds \"12\".")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HORIZONTICONALIGN",                 "Horizontal Alignment Method")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_HORIZONTICONALIGN_TP",              "Horizontal alignment of buff and debuff icons within container area.")
-- ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VERTALIGNICON",            "Vertical Icons Alignment")
-- ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VERTALIGNICON_TP",         "Vertical alignment of buff and debuff icons within container area.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_DESCENDINGSORT",                    "Sort Direction")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_DESCENDINGSORT_TP",                 "Choose the direction in which buff icons are sorted.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_GLOWICONBORDER",                    "Display Glowing Border")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_GLOWICONBORDER_TP",                 "Display a context colored glow border around each buff or debuff icon.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN",                "Display Radial Countdown Border")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_SHOWBORDERCOOLDOWN_TP",             "Display a context colored radial countdown border as the buff or debuff progresses in duration.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_FADEEXPIREICON",                    "Fade Out Expiring Icons")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_FADEEXPIREICON_TP",                 "When a buff/debuff is about to expire, make the icon transparent.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_HEADER",                   "Long-Term Effects")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SELF",                     "Show Long-term Effects for Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SELF_TP",                  "Show Player icons for effects with duration greater then 2 minutes.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_TARGET",                   "Show Long-term Effects for Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_TARGET_TP",                "Show Long-term Effects for Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL",                  "Use separate control for Player effects")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SEPCTRL_TP",               "Move Player effects icons for long-term effects into independent separate control.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER",                "Container orientation")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_CONTAINER_TP",             "Change orientation of long-term effects to Horizontal or Vertical tiling method.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VERT",                     "Vertical Long Term Buffs Alignment")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VERT_TP",                  "Alignment of buff and debuff icons within the long term buff container when set to vertical orientation.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_HORIZ",                    "Horizontal Long Term Buffs Alignment")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_HORIZ_TP",                 "Alignment of buff and debuff icons within the long term buff container when set to horizontal orientation.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_REVERSE_ORDER",                     "Reverse Long Term Buff Sort Order")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_REVERSE_ORDER_TP",                  "When enabled, the sort direction selected under Icon Options will be reversed for the long term buff container.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_FILTER_LONG_HEADER",                "Long-Term Effect Filters")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT",                "Show Icon for Active Assistant (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_ASSISTANT_TP",             "Set whether the active assitants will display an icon on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE",                 "Show Icon for Equipped Diguise (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_DISGUISE_TP",              "Set whether the equipped disguises will display an icon on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_MOUNT",                    "Show Icon for Active Mount (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_MOUNT_TP",                 "Set whether the active mounts will display an icon on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_PET",                      "Show Icon for Active Vanity Pet (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_PET_TP",                   "Set whether the active vanity pets will display an icon on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER",             "Show Mundus Boons on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSPLAYER_TP",          "Set whether Mundus Stone boons are shown on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET",             "Show Mundus Boons on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_MUNDUSTARGET_TP",          "Set whether Mundus Stone boons are shown on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER",          "Show Vampirism Stage on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGEPLAYER_TP",       "Set whether to show the Vampirism stage buff on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET",          "Show Vampirism Stage on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPSTAGETARGET_TP",       "Set whether to show the Vampirism stage buff on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER",              "Show Lycanthrophy on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_LYCANPLAYER_TP",           "Set whether to show the Lycanthrophy buff on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET",              "Show Lycanthrophy on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_LYCANTARGET_TP",           "Set whether to show the Lycanthrophy buff on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER",             "Show Vamp/Lycan Disease on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWPLAYER_TP",          "Set whether to show the vampirism and lycanthropy precursor disease buffs on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET",             "Show Vamp/Lycan Disease on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_VAMPWWTARGET_TP",          "Set whether to show vampirism and lycanthropy precursor disease buffs on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER",               "Show Vamp/Lycan Bite Timer on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BITEPLAYER_TP",            "Set whether to show the bite cooldown timers for vampirism/lycanthrophy on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET",               "Show Vamp/Lycan Bite Timer on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BITETARGET_TP",            "Set whether to show the bite cooldown timers for vampirism/lycanthrophy on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER",            "Show Battle Spirit on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITPLAYER_TP",         "Set whether the battle spirit buff will display on player.\nNote: Since Update 14 Battle Spirit no longer has an aura in Cyrodiil. This toggle will still control display in Battlegrounds and Duels.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET",            "Show Battle Spirit on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_BSPIRITTARGET_TP",         "Set whether the battle spirit buff will display on target.\nNote: Since Update 14 Battle Spirit no longer has an aura in Cyrodiil. This setting does nothing at the moment.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER",               "Show Cyrodiil Bonuses on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_CYROPLAYER_TP",            "Set whether buffs provided during Cyrodiil AvA are shown on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET",               "Show Cyrodiil Bonuses on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_CYROTARGET_TP",            "Set whether buffs provided during Cyrodiil AvA are shown on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER",            "Show ESO Plus Member on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSPLAYER_TP",         "Set whether the ESO Plus Member buff is displayed on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET",            "Show ESO Plus Member on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_ESOPLUSTARGET_TP",         "Set whether the ESO Plus Member buff is displayed on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER",        "Show Soul Summons ICD on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSPLAYER_TP",     "Set whether to show Soul Summons internal cooldown buff on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET",        "Show Soul Summons ICD on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SOULSUMMONSTARGET_TP",     "Set whether to show Soul Summons internal cooldown buff on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER",             "Show Eternal Warrior Set ICD on Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SETICDPLAYER_TP",          "Set whether to show the iternal cooldown buff from the Immortal and Eternal Warrior trial sets on player.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET",             "Show Eternal Warrior Set ICD on Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_LONGTERM_SETICDTARGET_TP",          "Set whether to show the iternal cooldown buff from the Immortal and Eternal Warrior trial sets on target.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_HEADER",                       "Short-Term Effect Filters")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP",                   "Show Gallop (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWGALLOP_TP",                "Display special buff icon when player is mounted and galloping.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT",                   "Show Sprint (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWSPRINT_TP",                "Display special buff icon when player is sprinting.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWREZZ",                     "Show Resurrection Immunity (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWREZZ_TP",                  "Display special buff icon when player is immune to damage and effects during resurrection.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWRECALL",                   "Show Recall Cooldown (Player only)")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWRECALL_TP",                "Display special buff icon when player has accumulated a wayshrine recall cost penalty.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER",              "Show Block - Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKPLAYER_TP",           "Display special buff icon when player is holding block.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET",              "Show Block - Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWBLOCKTARGET_TP",           "Display special buff icon when target is holding block.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER",            "Show Stealth - Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHPLAYER_TP",         "Display special buff icon when player is hidden or in stealth.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET",            "Show Stealth - Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_SHOWSTEALTHTARGET_TP",         "Display special buff icon when target is hidden or in stealth.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER",       "Show Disguised - Player")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISEPLAYER_TP",    "Display special buff icon when player is in a relevant area and is actively disguised from enemies.")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET",       "Show Disguised - Target")
ZO_CreateStringId("SI_LUIE_LAM_BUFF_MISC_LOOTSHOWDISGUISETARGET_TP",    "Display special buff icon when target is in a relevant area and is actively disguised from enemies.")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CHAT ANNOUNCEMENTS -- LAM --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Base Settings
ZO_CreateStringId("SI_LUIE_LAM_CA_HEADER",                              "Chat Announcements Options")
ZO_CreateStringId("SI_LUIE_LAM_CA_DESCRIPTION",                         "Displays announcements in chat for various events - with many customizable settings.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ENABLE",                              "Enable Chat Announcements Module")
ZO_CreateStringId("SI_LUIE_LAM_CA_NAMEDISPLAYMETHOD_TP",                "Determines the method used to display player names in Chat Announcements where applicable.\nDefault: Character Name")

ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER",            "Character/Account Name Brackets")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_CHARACTER_TP",         "Choose whether or not to display [ ] brackets around character and account names.")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM",                 "Item Link Brackets")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_ITEM_TP",              "Choose whether or not to display [ ] brackets around item links.")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK",             "Lorebook Brackets")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_LOREBOOK_TP",          "Choose whether or not to display [ ] brackets around lorebooks.")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE",          "Collectible Brackets")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_COLLECTIBLE_TP",       "Choose whether or not to display [ ] brackets around collectibles.")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT",          "Achievement Brackets")
ZO_CreateStringId("SI_LUIE_LAM_CA_BRACKET_OPTION_ACHIEVEMENT_TP",       "Choose whether or not to display [ ] brackets around achievements.")

-- Shared Menu Strings
ZO_CreateStringId("SI_LUIE_LAM_CA_SHARED_CA",                           "a Chat Announcement")
ZO_CreateStringId("SI_LUIE_LAM_CA_SHARED_CA_SHORT",                     "CA")
ZO_CreateStringId("SI_LUIE_LAM_CA_SHARED_CSA",                          "a Center Screen Announcement")
ZO_CreateStringId("SI_LUIE_LAM_CA_SHARED_CSA_SHORT",                    "CSA")
ZO_CreateStringId("SI_LUIE_LAM_CA_SHARED_ALERT",                        "an Alert")
ZO_CreateStringId("SI_LUIE_LAM_CA_SHARED_ALERT_SHORT",                  "Alert")

-- Currency Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_HEADER",                     "Currency Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWICONS",                  "Display Currency Icons")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWICONS_TP",               "Display an icon for the relative type of currency when a notification is printed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT",              "Use Context Color for Loot & Currency Gain/Loss")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_COLOR_CONTEXT_TP",           "Color the currency/loot message depending on whether currency/loot was gained or lost.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_COLOR",                      "Currency/Loot Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_COLORDOWN",                  "Currency/Loot Loss Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_COLORUP",                    "Currency/Loot Gain Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLD",                       "Display Gold Changes")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLD_TP",                    "Print a context sensitive notification to chat when gold is gained or lost.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDCOLOR",                  "Gold Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDNAME",                   "Gold Name")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDNAME_TP",                "Name to display for Gold.\nDefault: <<1[Gold/Gold]>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL",                  "Display Total Gold Suffix")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_TP",               "Append the total amount of Gold after change is displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG",              "Total Gold Syntax")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTOTAL_MSG_TP",           "Choose the syntax for the Total Gold message.\nDefault: Total Gold: %s")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD",              "Gold (Loot) - Filter Threshold")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTHRESHOLD_TP",           "Gold looted below this value will not be displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE",               "Combine gold looted from multiple sources")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_GOLDTHROTTLE_TP",            "When toggled on, gold looted from a group of bodies will combine into one value instead of showing individual values.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT",            "Hide gold spent on Guild Trader Purchases")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_HIDEGOLDAHSPENT_TP",         "Toggle this option to hide the display of gold spent on Guild Trader purchases.\nThis is a useful if you are using an addon like Awesome Guild Store to announce trader purchases.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAP",                     "Display Alliance Point Changes")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAP_TP",                  "Print a context sensitive notification to chat when Alliance Points are earned or spent.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPCOLOR",                "Alliance Points Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME",                 "Alliance Points Name")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPNAME_TP",              "Name to display for Alliance Points.\nDefault: <<1[Alliance Point/Alliance Points]>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL",                "Display Total Alliance Points Suffix")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPTOTAL_TP",             "Append the total amount of Alliance Points after change is displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG",                "Total Alliance Points Syntax")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_APTOTAL_MSG_TP",             "Choose the syntax for the Total Alliance Points message.\nDefault: Total AP: %s")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD",            "Alliance Points - Filter Threshold")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHRESHOLD_TP",         "Alliance Points gained below this value will not be displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE",             "Alliance Points - Throttle")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWAPTHROTTLE_TP",          "Setting this option higher than 0 will throttle the display of Alliance Points earned by X milliseconds.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTV",                     "Display Tel Var Stone Changes")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTV_TP",                  "Print a context sensitive notification to chat when Tel Var Stones are gained or lost.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVCOLOR",                "Tel Var Stones Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME",                 "Tel Var Stones Name")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVNAME_TP",              "Name to display for Tel Var Stones.\nDefault: <<1[Tel Var Stone/Tel Var Stones]>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL",                "Display Total Tel Var Stones Suffix")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVTOTAL_TP",             "Append the total amount of Tel Var Stones after change is displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG",                "Total Tel Var Stones Syntax")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_TVTOTAL_MSG_TP",             "Choose the syntax for the Total Tel Var Stones message.\nDefault: Total TV: %s")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD",            "Tel Var Stones - Filter Threshold")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHRESHOLD_TP",         "Tel Var Stones looted below this value will not be displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE",             "Tel Var Stones - Throttle")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWTVTHROTTLE_TP",          "Setting this option higher than 0 will throttle the display of Tel Var Stones looted by X milliseconds.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER",                "Display Writ Voucher Changes")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHER_TP",             "Print a context sensitive notification to chat when Writ Vouchers are rewarded or spent.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERCOLOR",           "Writ Vouchers Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME",            "Writ Vouchers Name")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERNAME_TP",         "Name to display for Writ Vouchers.\nDefault: <<1[Writ Voucher/Writ Vouchers]>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL",           "Display Total Writ Vouchers Suffix")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_SHOWVOUCHERTOTAL_TP",        "Show total amount of Writ Vouchers after change is displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG",                "Total Writ Vouchers Syntax")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_WVTOTAL_MSG_TP",             "Choose the syntax for the Total Writ Vouchers message.\nDefault: Total Vouchers: %s")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_CONTEXT",                    "Context Messages")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE",            "Receive")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_RECEIVE_TP",         "Default: You receive %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT",               "Loot")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOOT_TP",            "Default: You loot %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN",               "Earn")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_EARN_TP",            "Default: You earn %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND",              "Spend")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SPEND_TP",           "Default: You spend %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST",               "Lost")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LOST_TP",            "Default: You lost %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL",              "Steal")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STEAL_TP",           "Default: You steal %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET",         "Pickpocket")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_PICKPOCKET_TP",      "Default: You pickpocket %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY",             "Bounty - Paid")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_BOUNTY_TP",          "Default: You pay off your bounty of %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE",         "Bounty - Confiscated")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CONFISCATE_TP",      "Default: A guard confiscates %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR",             "Repair")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_REPAIR_TP",          "Default: You pay %s in repairs.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER",             "Guild Trader - Purchase")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADER_TP",          "Default: You purchase an item from the guild trader for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING",            "Guild Trader - Listing Fee")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_LISTING_TP",         "Default: Listing fee of %s charged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN",            "Trade (Incoming)")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEIN_TP",         "Default: You receive %s from %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT",           "Trade (Outgoing)")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_TRADEOUT_TP",        "Default: You trade %s to %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN",             "Mail (Incoming)")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILIN_TP",          "Default: You receive mail with %s from %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT",            "Mail (Outgoing)")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILOUT_TP",         "Default: You mail %s to %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILCOD",            "Mail - COD Payment")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MAILCOD_TP",         "Default: You send a COD payment of %s to %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_POSTAGE",            "Mail - Postage")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_POSTAGE_TP",         "Default: You pay %s in postage.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT",            "Bank - Deposit")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSIT_TP",         "Default: You deposit %s in your bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW",           "Bank - Withdraw")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAW_TP",        "Default: You withdraw %s from your bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD",       "Guild Bank - Deposit")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_DEPOSITGUILD_TP",    "Default: You deposit %s in the guild bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD",      "Guild Bank - Withdraw")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WITHDRAWGUILD_TP",   "Default: You withdraw %s from the guild bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE",          "Wayshrine Fee")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_WAYSHRINE_TP",       "Default: Wayshrine fee of %s charged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK",            "Unstuck Fee")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_UNSTUCK_TP",         "Default: Unstuck fee of %s charged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE",             "Riding Upgrade")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STABLE_TP",          "Default: You purchase %s for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE",            "Storage Upgrade")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_STORAGE_TP",         "Default: You purchase %s for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES",         "Respec - Attributes")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_ATTRIBUTES_TP",      "Default: You make a donation of %s to redistribute your Attribute Points.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION",           "Respec - Champion Points")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_CHAMPION_TP",        "Default: You pay a fee of %s to redistribute your Champion Points.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS",             "Respec - Skill Morphs")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_MORPHS_TP",          "Default: You make a donation of %s to redistribute your Skill Morphs.")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS",             "Respec - Skill Points")
ZO_CreateStringId("SI_LUIE_LAM_CA_CURRENCY_MESSAGE_SKILLS_TP",          "Default: You make a donation of %s to redistribute your Skill Points.")

-- LOOT MENU
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_HEADER",                         "Loot Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWICONS",                      "Display Item Icons")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWICONS_TP",                   "Display an icon for items logged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE",                  "Display Item Armor Type")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWARMORTYPE_TP",               "Display the armor type of relevant items logged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE",                  "Display Item Style")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWITEMSTYLE_TP",               "Display the style of relevant items logged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT",                  "Display Item Trait")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWITEMTRAIT_TP",               "Display the trait of relevant items logged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_TOTAL",                          "Display Total Items Suffix")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_TOTAL_TP",                       "Append the total count of an item after an item is logged.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_TOTALSTRING",                    "Total Items Syntax")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_TOTALSTRING_TP",                 "Choose the syntax for the Total Items message.\nDefault: New Total:")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWITEMS",                      "Display Items - Looted")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWITEMS_TP",                   "Print a message to chat when items are looted from corpses, containers, pickpocketing, and quest rewards.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE",                    "Display ONLY Notable Loot")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWNOTABLE_TP",                 "Only display notable items looted (Any set items, any purple+ items, any blue+ special items).")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT",                    "Display Group Members Notable Loot")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWGRPLOOT_TP",                 "Also display the notable loot group members receive (Any set items, any purple+ items, any blue+ special items).")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS",              "Hide Annoying Notable Items")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_TP",           "Don't display annoying notable items looted (Laurels, Malachite Shards, Undaunted Plunder, Mercenary Motif Pages, etc...).")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_HIDEANNOYINGITEMS_WARNING",      "This prevents chat spam in large groups.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_HIDETRASH",                      "Hide Trash Quality Items")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_HIDETRASH_TP",                   "Don't display trash quality items looted.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LootConfiscateD",                "Display Item Loss - Confiscated Items")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LootConfiscateD_TP",             "Display a message when items are confiscated by a guard.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED",              "Display Item Loss - Destroyed Items")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LOOTSHOWDESTROYED_TP",           "Display a message when an item is destroyed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK",               "Display Item Loss - Lockpick Break")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LOOTSHOWLOCKPICK_TP",            "Display a message when a lockpick is broken from attempting to pick or forcing a lock open.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWVENDOR",                     "Display Items - Vendor Transactions")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWVENDOR_TP",                  "Print a message to chat when items are purchased or sold at a vendor.")

ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD",                   "Display Quest Items Looted")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWQUESTADD_TP",                "Display a message when a quest item is looted or received.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM",                   "Display Quest Items Removed")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWQUESTREM_TP",                "Display a message when a quest item is used or removed.")

ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE",                   "Merge Currency & Loot Messages")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_VENDOR_MERGE_TP",                "Combine the individual item purchase message and currency change message into one line.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS",              "Display Total Items on Transactions")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALITEMS_TP",           "Toggle the display of the total count of items on a vendor transaction. Requires Total Items Suffix option to be enabled.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY",           "Display Total Currency on Transactions")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_VENDOR_TOTALCURRENCY_TP",        "Toggle the display of the total currency on a vendor transaction. Requires Total Currency of relevant type to be enabled.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWBANK",                       "Display Items - Banking")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWBANK_TP",                    "Print a message to chat when items are deposited or withdrawn from a bank or guild bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWCRAFT",                      "Display Items - Crafting")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_TP",                   "Print a message to chat when items are received, lost, or upgraded from crafting.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS",            "Display Materials Used")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWCRAFT_MATERIALS_TP",         "Toggle the display of materials used by crafting.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWMAIL",                       "Display Items - Mail")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWMAIL_TP",                    "Print a message to chat when items are received or sent in the mail.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWTRADE",                      "Display Items - Trade")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_SHOWTRADE_TP",                   "Print a message to chat when items are received or lost in a trade.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE",               "Show Disguise equip/unequip message")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_LOOTSHOWDISGUISE_TP",            "Print a message to chat when a disguise is equipped or unequipped.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_LOOT",                   "Loot")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_LOOT_TP",                "Default: You loot %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_RECEIVE",                "Receive")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_RECEIVE_TP",             "Default: You receive %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_STEAL",                  "Steal")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_STEAL_TP",               "Default: You steal %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_PICKPOCKET",             "Pickpocket")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_PICKPOCKET_TP",          "Default: You pickpocket %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_CONFISCATE",             "Bounty - Confiscated")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_CONFISCATE_TP",          "Default: A guard has confiscated %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEIN",                "Trade (Incoming)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEIN_TP",             "Default: You receive %s from %s")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEOUT",               "Trade (Outgoing)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_TRADEOUT_TP",            "Default: You trade %s to %s")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILIN",                 "Mail (Incoming)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILIN_TP",              "Default: You receive mail with %s from %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILOUT",                "Mail (Outgoing)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_MAILOUT_TP",             "Default: You mail %s to %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSIT",                "Bank - Deposit")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSIT_TP",             "Default: You deposit %s in your bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAW",               "Bank - Withdraw")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAW_TP",            "Default: You withdraw %s from your bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSITGUILD",           "Guild Bank - Deposit")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DEPOSITGUILD_TP",        "Default: You deposit %s in the guild bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAWGUILD",          "Guild Bank - Withdraw")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_WITHDRAWGUILD_TP",       "Default: You withdraw %s from the guild bank.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY",                    "Buy (No Value)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_TP",                 "Default: You purchase %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_VALUE",              "Buy")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUY_VALUE_TP",           "Default: You purchase %s for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK",                "Buyback (No Value)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_TP",             "Default: You buyback %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_VALUE",          "Buyback")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_BUYBACK_VALUE_TP",       "Default: You buyback %s for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL",                   "Sell (No Value)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_TP",                "Default: You sell %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_VALUE",             "Sell")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_SELL_VALUE_TP",          "Default: You sell %s for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_FENCE",                  "Fence")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_FENCE_TP",               "Default: You fence %s for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_LAUNDER",                "Launder")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_LAUNDER_TP",             "Default: You launder %s for %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_USE",                    "Crafting - Use")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_USE_TP",                 "Default: You use %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_CRAFT",                  "Crafting - Craft")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_CRAFT_TP",               "Default: You craft %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_EXTRACT",                "Crafting - Extract")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_EXTRACT_TP",             "Default: You extract %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE",                "Crafting - Upgrade (Success)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_TP",             "Default: You upgrade %s to %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_FAIL",           "Crafting - Upgrade (Failure)")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_UPGRADE_FAIL_TP",        "Default: You fail to upgrade %.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_REFINE",                 "Crafting - Refine")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_REFINE_TP",              "Default: You refine %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DECONSTRUCT",            "Crafting - Deconstruct")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DECONSTRUCT_TP",         "Default: You deconstruct %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_RESEARCH",               "Crafting - Research")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_RESEARCH_TP",            "Default: You research %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DESTROY",                "Destroyed")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DESTROY_TP",             "Default: You destroy %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_LOCKPICK",               "Lockpick Broken")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_LOCKPICK_TP",            "Default: Your %s breaks.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_REMOVE",                 "Quest Item - Removed")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_REMOVE_TP",              "Default: Removed %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_GROUP",                  "Group Member Loot")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_GROUP_TP",               "Default: %s loots %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_EQUIP",         "Disguise - Equipped")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_EQUIP_TP",      "Default: You equip %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_REMOVE",        "Disguise - Removed")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_REMOVE_TP",     "Default: You unequip %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_DESTROY",       "Disguise - Destroyed")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOOT_MESSAGE_DISGUISE_DESTROY_TP",    "Default: Your %s is destroyed.")

-- Experience Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER",                          "Experience/Skill Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER_ENLIGHTENED",              "Enlightenment")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_ENLIGHTENED",                     "Display Enlightenment - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_ENLIGHTENED_TP",                  "Display <<1>> when you are enlightened or no longer enlightened.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER_LEVELUP",                  "Level Up")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_LEVELUP",                         "Display Level Up - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_LEVELUP_TP",                      "Display <<1>> when you level up or earn a Champion Point.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND",               "Display Expanded Level Up CSA")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_LEVELUP_CSAEXPAND_TP",            "Adds subtext to the Center Screen Announcement for level up that displays the level attained.")  
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_LVLUPICON",                       "Display Level Icon on Level Up")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_LVLUPICON_TP",                    "Toggle the display of the normal level/champion point icon when you level up or earn a Champion point.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT",               "Color Level by Context")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_COLORLVLBYCONTEXT_TP",            "Colors the current level text to match the current level or champion point context color.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXPERIENCE_LEVELUP_COLOR",            "Level Up Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER_RESPEC",                   "Respec Notifications")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_RESPEC",                          "Display Respec Notification - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_RESPEC_TP",                       "Display <<1>> when you redistribute Champion Points and when you relearn attributes, skill points, or morphs.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER_EXPERIENCEGAIN",           "Experience Points")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN",                     "Display Experience Gain")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_SHOWEXPGAIN_TP",                  "Print a message to chat when Experience Points are earned.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_SHOWEXPICON",                     "Display Experience Icon")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_SHOWEXPICON_TP",                  "Toggle the display of the Experience Points icon.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_MESSAGE",                         "Experience Gain Message Format")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_MESSAGE_TP",                      "Message format for experience gain.\nDefault: You earn %s.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_NAME",                            "Experience Points Name")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_NAME_TP",                         "Name to use for Experience Points.\nDefault: experience <<1[point/points]>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXPERIENCE_COLORMESSAGE",             "Experience Gain Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_EXPERIENCE_COLORNAME",                "Experience Points Name Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_EXPGAINCONTEXTNAME",              "Context Name for Experience Gain")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_EXPGAINCONTEXTNAME_TP",           "This option is intended to offer contrast from currency and loot messages since experience gain is not context sensitive.\nDefault: \"[Earned]\"")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_EXPGAINDISPLAYNAME",              "Display Name for Experience Gain")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_EXPGAINDISPLAYNAME_TP",           "Name to post in chat when experience is earned.\nDefault: \"XP\"")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS",                    "Hide Experience from Kills")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HIDEEXPKILLS_TP",                 "Toggle this option on to only report experience gain in chat from non-combat sources.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD",                "Combat Experience Gain - Filter Threshold")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_EXPGAINTHRESHOLD_TP",             "Experience Points earned from kills below this value will not be displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT",             "Combat Experience Gain - Throttle")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_THROTTLEEXPINCOMBAT_TP",          "Setting this option higher than 0 allows you to throttle Experience Points earned by X milliseconds.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER_SKILL_POINTS",             "Skill Points")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_UPDATED",                  "Display Skill Points Earned - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_UPDATED_TP",               "Display <<1>>> when a Skill Point is earned from leveling up, quests, or skyshards.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_COLOR1",                   "Skyshard Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_COLOR2",                   "Skill Points Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX",            "Skyshard Absorbed Message")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_PARTIALPREFIX_TP",         "When a Skyshard is absorbed this prefix message will be displayed.\nDefault: Skyshard Absorbed")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET",           "Skyshard Separator Bracket")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_PARTIALBRACKET_TP",        "When a Skyshard is absorbed this bracket will encompass the prefix message when skill points (or partial skill points) are earned.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL",           "Display Partial Skill Points")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILLPOINT_UPDATEDPARTIAL_TP",        "Display \"Pieces Collected x/3\" when a Skyshard is absorbed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER_SKILL_LINES",              "Skill Lines")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED",                 "Display Skill Line Unlocked - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_UNLOCKED_TP",              "Display <<1>> when a Skill Line is unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS",                 "Display Skill Line Progression - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_PROGRESS_TP",              "Display <<1>> when a Skill Line levels up.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_ABILITY",                  "Display Ability Progression - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_ABILITY_TP",               "Display <<1>> when an Ability levels up.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_ICON",                     "Display Skill Line Icon")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_ICON_TP",                  "Display the relevant icon for unlocked Skill Lines.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SKILL_LINE_COLOR",                    "Skill/Ability Progression Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_EXP_HEADER_GUILDREP",                 "Guild Reputation")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_ICON",                       "Display Guild Icon")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_ICON_TP",                    "Display the relevant guild icon when Guild Reputation is earned.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MESSAGECOLOR",               "Guild Reputation Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT",              "Guild Reputation Message Format")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MESSAGEFORMAT_TP",           "Message format for Guild Reputation earned.\nDefault: You earn %s")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME",                "Guild Reputation Points Name")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MESSAGENAME_TP",             "Name to use for Guild Reputation.\nDefault: <<1[reputation/reputation]>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_FG",                         "Display Fighters Guild Reputation")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_FG_TP",                      "Display Guild Reputation earned with the Fighters Guild.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_FG_COLOR",                   "Fighters Guild Color")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_THRESHOLD",                  "Fighters Guild - Filter Threshold")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_THRESHOLD_TP",               "Fighters Guild Reputation earned from kills below this value will not be displayed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_THROTTLE",                   "Fighters Guild - Throttle")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_THROTTLE_TP",                "Setting this option higher than 0 allows you to throttle Fighters Guild Reputation earned by X milliseconds.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MG",                         "Display Mages Guild Reputation")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MG_TP",                      "Display Guild Reputation earned with the Mages Guild.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_MG_COLOR",                   "Mages Guild Color")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_UD",                         "Display Undaunted Reputation")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_UD_TP",                      "Display Guild Reputation earned with the Undaunted.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_UD_COLOR",                   "Undaunted Color")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_TG",                         "Display Thieves Guild Reputation")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_TG_TP",                      "Display Guild Reputation earned with the Thieves Guild.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_TG_COLOR",                   "Thieves Guild Color")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_DB",                         "Display Dark Brotherhood Reputation")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_DB_TP",                      "Display Guild Reputation earned with the Dark Brotherhood Guild.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_DB_COLOR",                   "Dark Brotherhood Color")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_ALERT",                      "Display Guild Reputation Alert")
ZO_CreateStringId("SI_LUIE_LAM_CA_GUILDREP_ALERT_TP",                   "When enabled, display a basic alert for any Guilds that are selected above indicating reputation has increased. ")

-- Collectibles/Lorebooks Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_HEADER",                  "Collectible/Lorebooks Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_COL_HEADER",              "Collectibles")

ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE",                  "Display Collectible Unlocked - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_ENABLE_TP",               "Display <<1>> when a  Collectible is unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_ICON",                    "Display Collectible Icon")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_ICON_TP",                 "Display an icon for the relevant Collectible unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_ONE",               "Collectible Prefix Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_COLOR_TWO",               "Collectible Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX",           "Collectible Prefix Message")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_MESSAGEPREFIX_TP",        "Enter the prefix message that will display before the Collectible unlocked.\nDefault: Collection Updated")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET",                 "Collectible Prefix Bracket")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_BRACKET_TP",              "This bracket will encompass the prefix message when a Collectible is unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY",                "Display Collectible Category")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_CATEGORY_TP",             "Append the Collectible unlocked message with the category it was added to.")
ZO_CreateStringId("SI_LUIE_LAM_CA_COLLECTIBLE_LORE_HEADER",             "Lorebooks")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_ENABLE",                     "Display Lorebook Discovery - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_ENABLE_TP",                  "Display <<1>> when a Lorebook is discovered.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_COLLECTION",                 "Display Lore Collection Complete - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_COLLECTION_TP",              "Display <<1>> when a collection of Lorebooks is complete.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_ICON",                       "Display Lorebook Icon")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_ICON_TP",                    "Display an icon for the relevant Lorebook unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_COLOR1",                     "Lorebook Prefix Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_COLOR2",                     "Lorebook Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_PREFIX1",                    "Lorebook Prefix Message")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_PREFIX1_TP",                 "Enter the prefix message displayed when a Lorebook is discovered.\nDefault: Lorebook Discovered")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_PREFIX2",                    "Book Prefix Message")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_PREFIX2_TP",                 "Enter the prefix message displayed when a book is discovered.\nDefault: Book Discovered")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION",          "Lore Collection Prefix Message")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_PREFIX_COLLECTION_TP",       "Enter the prefix message that will display before completed Lore Collection notifications.\nDefault: Collection Completed")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET",           "Lorebook Prefix Bracket")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_BRACKET_TP",        "This bracket will encompass the prefix message when a Lorebook is unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_CATEGORY",                   "Display Collection Category")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_CATEGORY_TP",                "Display the relevant category of a Lorebook unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE",                 "Display Books without Eidetic Memory")
ZO_CreateStringId("SI_LUIE_LAM_CA_LOREBOOK_NOSHOWHIDE_TP",              "Display standard books unlocked even without Eidetic Memory unlocked.")

-- Achievements Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_HEADER",                      "Achievements Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_UPDATE",                      "Display Achievement Update - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_UPDATE_TP",                   "Display <<1>> when progress is made toward the completion of an Achievement.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COMPLETE",                    "Display Achievement Completion - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COMPLETE_TP",                 "Display <<1>> when an Achievement is unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO",                  "Display Detailed Achievement Info")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_DETAILINFO_TP",               "Displays each subcategory required for Achievement completion and progress in each subcategory.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS",               "Color Achievement Progress")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COLORPROGRESS_TP",            "Enables color change for Achievement progress based off completion.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE",                    "Progress Step Size %")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_STEPSIZE_TP",                 "Display Achievement update information every #% to completion. Setting this value to 0 will print Achievement information on every update event.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT",             "Display % on Achievement Completion")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COMPLETEPERCENT_TP",          "Adds a (100%) indicator to achievement completion messages to match progress syntax.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_ICON",                        "Display Achievement Icon")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_ICON_TP",                     "Display the relevant icon for an Achievement on progress or completion.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COLOR1",                      "Achievement Prefix Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COLOR2",                      "Achievement Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_PROGMSG",                     "Achievement Progress Prefix Message")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_PROGMSG_TP",                  "Prefix for Achievement progress messages.\nDefault: Achievement Updated")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG",                 "Achievement Completion Prefix Message")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_COMPLETEMSG_TP",              "Prefix for Achievement completion messages.\nDefault: Achievement Unlocked")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY",                "Display Achievement Category")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_SHOWCATEGORY_TP",             "Display the primary category of an Achievement.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY",             "Display Achievement Subcategory")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_SHOWSUBCATEGORY_TP",          "Display the subcategory of an Achievement.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_BRACKET",                     "Achievement Prefix Bracket")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_BRACKET_TP",                  "This bracket will encompass the prefix message when an Achievement is updated or unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET",             "Achievement Category Bracket")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_CATEGORYBRACKET_TP",          "This bracket will encompass the category and subcategory when an Achievement is updated or unlocked.")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_HEADER",             "Tracking Options")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_CATEGORY",                    "Track \'<<1>>\' Achievements")
ZO_CreateStringId("SI_LUIE_LAM_CA_ACHIEVE_CATEGORY_TP",                 "Enables tracking for Achievements in the <<1>> category.")

-- Quest Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_HEADER",                        "Quest/POI Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE",                "Display Shared Quests - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTSHARE_TP",             "Display <<1>> when another player shares a quest with you.")

ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY",            "Display Location Discovery - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_LOCATION_DISCOVERY_TP",         "Display <<1>> when a location on the map is discovered.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE",                 "Display POI Objective - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_POI_OBJECTIVE_TP",              "Display <<1>> when a quest is accepted with an associated map POI.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_POI_COMPLETE",                  "Display POI Complete - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_POI_COMPLETE_TP",               "Display <<1>> when a quest is completed with an associated map POI.")

ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_ACCEPT",                        "Display Quest Accepted - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_ACCEPT_TP",                     "Display <<1>> when a quest is accepted.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_COMPLETE",                      "Display Quest Completed - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_COMPLETE_TP",                   "Display <<1>> when a quest is completed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_ABANDON",                       "Display Quest Abandoned - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_ABANDON_TP",                    "Display <<1>> when a quest is abandoned.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE",             "Display Quest Objective Failure - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_OBJECTIVE_FAILURE_TP",          "Display <<1>> when a quest failure state is triggered.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE",              "Display Quest Objective Updates - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_OBJECTIVE_UPDATE_TP",           "Display <<1>> when a new quest objective is added.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE",            "Display Quest Objective Completion - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_OBJECTIVE_COMPLETE_TP",         "Display <<1>> when a quest objective is completed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON",                 "Display Quest Difficulty Icon")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTICON_TP",              "Display an icon relevant to the difficulty and type of quest.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG",                 "Display Detailed Quest Description")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTLONG_TP",              "When toggled on, accepting a quest will display the Journal Entry details of the quest.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG",        "Display Detailed POI Description")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_SHOWQUESTOBJECTIVELONG_TP",     "When toggled on, accepting/completing a quest with an associated map POI will display the full description.")
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_COLOR1",                        "POI Name Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_COLOR2",                        "POI Description Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_COLOR3",                        "Quest Name Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_QUEST_COLOR4",                        "Quest Description Color")
-- TODO: Add Tooltip with finalized color value

-- Social Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_HEADER",                       "Social/Guild Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_FRIENDS_HEADER",               "Friends/Ignored List")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_FRIENDS",                      "Display Friends/Ignored Requests - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_FRIENDS_TP",                   "Display <<1>> for friend invites, Friends list changes, and Ignored list changes.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF",                "Display Friends List Log On/Off - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_FRIENDS_ONOFF_TP",             "Display <<1>> when a player on your Friends list logs on or off.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_HEADER",                 "Guild Notifications")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD",                        "Display Guild Invite/Leave/Join - <<1>> ")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_TP",                     "Display <<1>> for Guild invitations and Join/Leave notifications.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK",                   "Display Guild Rank Changes - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_RANK_TP",                "Display <<1>> for Guild Rank changes. Options are determined by the dropdown menu below.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS",            "Guild Rank Display Options")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_RANKOPTIONS_TP",         "Choose the method in which Guild Rank changes will be reported.\nDefault: Self Only")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN",                  "Display Guild Administration - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_ADMIN_TP",               "Display <<1>> when the Guild MOTD or Background Information is updated, rank data is updated, or Heraldry is updated.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS",                  "Display Guild Icons")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_ICONS_TP",               "Displays the faction or Guild Rank icon for guild messages.")

ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR",                  "Guild Name Color")

ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE",         "Use Alliance Colors for Guild Names")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_GUILD_COLOR_ALLIANCE_TP",      "Use the relevant alliance color for guild names, icons, and ranks in guild messages.")

ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_TRADE_HEADER",                 "Trade Notifications")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_TRADE",                        "Display Trade Notifications - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_TRADE_TP",                     "Display <<1>> for trade invitations, cancelation, and success.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUEL_HEADER",                  "Duel Notifications")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUEL",                         "Display Duel Challenges - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUEL_TP",                      "Display <<1>> for duel challenges and declined challenges.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELSTART",                    "Display Duel Start Notification - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TP",                 "Display <<1>> when a duel begins.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELSTART_TPCSA",              "Display <<1>> when a duel begins. Center Screen Announcement also displays a countdown")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION",             "Duel Start Notification Format (CA/Alert Only)")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELSTART_OPTION_TP",          "Choose the format for the message that is displayed when the countdown ends and the duel is started.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE",                 "Display Duel End Notification - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELCOMPLETE_TP",              "Display <<1>> when a duel ends.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY",                 "Display Duel Boundary Warning - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_DUELBOUNDARY_TP",              "Display <<1>> when you are close to the Duel Boundary.")
ZO_CreateStringId("SI_LUIE_LAM_CA_SOCIAL_MARA_HEADER",                  "Pledge of Mara Notifications")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_MARA",                           "Display Pledge of Mara - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_MARA_TP",                        "Display <<1>> for Pledge of Mara events.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_MARA_ALERT",                     "Only Display Alert on Failure")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_MARA_ALERT_TP",                  "When enabled, an Alert will only be displayed if the Pledge of Mara fails. This emulates the behavior of the default UI settings.")

-- Group Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_HEADER",                        "Group/LFG/Trial Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_BASE_HEADER",                   "Group Notifications")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_BASE",                          "Display Group Notifications - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_BASE_TP",                       "Display <<1>> for group invites and group composition changes.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFG_HEADER",                    "LFG Notifications")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGREADY",                      "Display LFG Ready Notifications - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGREADY_TP",                   "Display <<1>> when an LFG group is formed or activity is joined.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGQUEUE",                      "Display LFG Queue Status - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGQUEUE_TP",                   "Display <<1>> when entering or exiting the queue for an LFG activity.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGVOTE",                       "Display LFG Vote/Ready Check - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGVOTE_TP",                    "Display <<1>> for group votes and ready checks.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE",                   "Display LFG Activity Completed - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_LFGCOMPLETE_TP",                "Display <<1>> when a Group Finder activity is completed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_HEADER",                   "Raid Notifications")

ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_BASE",                     "Display Raid Status Notifications - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_BASE_TP",                  "Display <<1>> when a Trial is started, failed, or completed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_SCORE",                    "Display Score Updates - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_SCORE_TP",                 "Display <<1>> when your score in a Trial changes.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE",                "Display New Best Score - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_BESTSCORE_TP",             "Display <<1>> when a new high score is achieved on trial completion.")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_REVIVE",                   "Display Vitality Bonus Loss - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_REVIVE_TP",                "Display <<1>> when Vitality Bonus is decreased.")

ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_ARENA",                    "Display DSA/Maelstrom Arena Stage - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_ARENA_TP",                 "Display <<1>> when a new stage begins in Dragonstar or Maelstrom Arena.")

ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND",              "Display Maelstrom Arena Round - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_GROUP_RAID_ARENA_ROUND_TP",           "Display <<1>> when a new round begins in Maelstrom Arena.")

-- Misc Menu
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_GROUPAREA",                      "Display Entering/Leaving Group Area - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_GROUPAREA_TP",                   "Display <<1>> when entering or leaving a Group Area.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_HEADER",                         "Miscellaneous Announcements")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK",                   "Display Lockpicking Notifications - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWLOCKPICK_TP",                "Display <<1>> on successful or failed lockpick attempts as well as when you attempt to pick a lock and it's impossible or you have no lock picks.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWMAIL",                       "Display Mail Notifications - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWMAIL_TP",                    "Display <<1>> when mail is accepted, deleted, or sent.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWJUSTICE",                    "Display Justice Notifications - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWJUSTICE_TP",                 "Display <<1>> when items or gold are confiscated by a guard.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWBANKBAG",                    "Display Bag/Bank Space Upgrade - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_TP",                 "Display <<1>> when bag or bank space upgrades are purchased ingame or through the crown store.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWBANKBAG_COLOR",              "Bag/Bank Space Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWRIDING",                     "Display Riding Skill Upgrade - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWRIDING_TP",                  "Display <<1>> when riding upgrades are purchased or Crown Riding Skill books are used.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR",               "Riding Skill Message Color")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_SHOWRIDING_COLOR_BOOK",          "Riding Skill (Crown Lesson) Message Color")
-- TODO: Add Tooltip with finalized color value
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE",               "Display Disguise Status - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISE_TP",            "Display <<1>> when entering or exiting a relevant area and becoming disguised or revealed.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT",          "Display Detection Warning - <<1>>")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERT_TP",       "Display <<1>> when near a sentry or performing suspicious activity while disguised.")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR",     "Detection Warning CSA Color")
ZO_CreateStringId("SI_LUIE_LAM_CA_MISC_LOOTSHOWDISGUISEALERTCOLOR_TP",  "Change the color of the Center Screen Announcement displayed when near a sentry or performing suspicious activity while disguised.")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- COMBAT INFO -- LAM --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ZO_CreateStringId("SI_LUIE_LAM_CI_HEADER",                              "Combat Info Options")
ZO_CreateStringId("SI_LUIE_LAM_CI_SHOWCOMBATINFO",                      "Enable Combat Info")
ZO_CreateStringId("SI_LUIE_LAM_CI_SHARED_FONT_TP",                      "Choose the font to use for the countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_CI_SHARED_FONTSIZE_TP",                  "Choose the font size for the countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_CI_SHARED_FONTSTYLE_TP",                 "Choose the font style for the countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_CI_SHARED_POSITION",                     "Label Vertical Position")
ZO_CreateStringId("SI_LUIE_LAM_CI_SHARED_POSITION_TP",                  "Adjust the vertical position of the countdown label.")
ZO_CreateStringId("SI_LUIE_LAM_CI_HEADER_GCD",                          "Global Cooldown Options")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_SHOW",                            "Display Global Cooldown on Action Bars")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_SHOW_TP",                         "Dislay an animation on ability bar slots while on the global cooldown.")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_QUICK",                           "Display GCD for Potions")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_QUICK_TP",                        "Also display the global cooldown animation on the quickslot for potions and items that are not subject to the global cooldown.")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_FLASH",                           "Display Ready Flash")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_FLASH_TP",                        "Display a flash animation on each ability slot on the bar when the global cooldown is finished.")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_DESAT",                           "Desaturate Icons")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_DESAT_TP",                        "Desaturate ability icons while on the global cooldown.")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_COLOR",                           "Color Slot Label # Red")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_COLOR_TP",                        "While on global cooldown, colorize the ability button numeric labels red.")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_ANIMATION",                       "GCD Animation Method")
ZO_CreateStringId("SI_LUIE_LAM_CI_GCD_ANIMATION_TP",                    "Choose the animation type for tracking the global cooldown.")
ZO_CreateStringId("SI_LUIE_LAM_CI_HEADER_ULTIMATE",                     "Ultimate Tracking Options")
ZO_CreateStringId("SI_LUIE_LAM_CI_ULTIMATE_SHOW",                       "Display Current Ultimate Value")
ZO_CreateStringId("SI_LUIE_LAM_CI_ULTIMATE_SHOW_TP",                    "Display current ultimate value and percentage toward completion.")
ZO_CreateStringId("SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL",                   "Hide Label When Full")
ZO_CreateStringId("SI_LUIE_LAM_CI_ULTIMATE_HIDEFULL_TP",                "Remove percentage label from ultimate slot when ability becomes ready.")
ZO_CreateStringId("SI_LUIE_LAM_CI_ULTIMATE_TEXTURE",                    "Display Ultimate Generation Texture")
ZO_CreateStringId("SI_LUIE_LAM_CI_ULTIMATE_TEXTURE_TP",                 "Display special texture under ultimate ability slot when in-combat ultimate generation is detected.")
ZO_CreateStringId("SI_LUIE_LAM_CI_HEADER_BAR",                          "Bar Ability Highlight Options")
ZO_CreateStringId("SI_LUIE_LAM_CI_BAR_EFFECT",                          "Highlight Active Effects")
ZO_CreateStringId("SI_LUIE_LAM_CI_BAR_EFFECT_TP",                       "Highlights currently active buffs on the ability bar for their active duration.")
ZO_CreateStringId("SI_LUIE_LAM_CI_BAR_PROC",                            "Highlight Active Procs")
ZO_CreateStringId("SI_LUIE_LAM_CI_BAR_PROC_TP",                         "Highlights an ability that is in a procced state on the ability bar.")
ZO_CreateStringId("SI_LUIE_LAM_CI_BAR_LABEL",                           "Display Countdown Label")
ZO_CreateStringId("SI_LUIE_LAM_CI_BAR_LABEL_TP",                        "Display a countdown timer for any highlighted ability.")
ZO_CreateStringId("SI_LUIE_LAM_CI_HEADER_POTION",                       "Quickslot Cooldown Timer Options")
ZO_CreateStringId("SI_LUIE_LAM_CI_POTION",                              "Display Quickslot Cooldown Timer")
ZO_CreateStringId("SI_LUIE_LAM_CI_POTION_TP",                           "Display a cooldown timer for potions and other quickslot items.")
ZO_CreateStringId("SI_LUIE_LAM_CI_POTION_COLOR",                        "Color Label")
ZO_CreateStringId("SI_LUIE_LAM_CI_POTION_COLOR_TP",                     "Color the quickslot cooldown timer label based off the remaining duration.")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- INFO PANEL -- LAM --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

ZO_CreateStringId("SI_LUIE_LAM_PNL_DISABLECOLORSRO",                    "Disable colours on read-only values")
ZO_CreateStringId("SI_LUIE_LAM_PNL_DISABLECOLORSRO_TP",                 "Disable value-dependent colour of the information label for items that you don't have direct control: Currently this includes FPS and Latency labels.")
ZO_CreateStringId("SI_LUIE_LAM_PNL_ELEMENTS_HEADER",                    "Info Panel elements")
ZO_CreateStringId("SI_LUIE_LAM_PNL_HEADER",                             "Info Panel Options")
ZO_CreateStringId("SI_LUIE_LAM_PNL_PANELSCALE",                         "Info Panel Scale, %")
ZO_CreateStringId("SI_LUIE_LAM_PNL_PANELSCALE_TP",                      "Used to magnify size of Info Panel on large resolution displays.")
ZO_CreateStringId("SI_LUIE_LAM_PNL_RESETPOSITION_TP",                   "This will reset position of Info Panel into screen top right corner.")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWARMORDURABILITY",                "Show Armour Durability")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWBAGSPACE",                       "Show Bags Space")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWCLOCK",                          "Show Clock")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWEAPONCHARGES",                   "Show Weapons Charges")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWFPS",                            "Show FPS")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWICTROPHYCOUNT",                  "Show Imperial City Trophy count")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWLATENCY",                        "Show Latency")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWMOUNTTIMER",                     "Show Mount Feed Timer |c00FFFF*|r")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWMOUNTTIMER_TP",                  "(*) Once you have trained your mount to maximum level this field will be automatically hidden for current character.")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWPANEL",                          "Show Info Panel")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWPANEL_TP",                       "Info mini panel contains clock, framerate, latency, mount info, inventory and items durability status.")
ZO_CreateStringId("SI_LUIE_LAM_PNL_SHOWSOULGEMS",                       "Show Soul Gems")
ZO_CreateStringId("SI_LUIE_LAM_PNL_UNLOCKPANEL",                        "Unlock panel")
ZO_CreateStringId("SI_LUIE_LAM_PNL_UNLOCKPANEL_TP",                     "Allow mouse dragging for Info Panel.")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- UNITFRAMES -- LAM --
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Base Options
ZO_CreateStringId("SI_LUIE_LAM_UF_ENABLE",                              "Enable Unit Frames Module")
ZO_CreateStringId("SI_LUIE_LAM_UF_DESCRIPTION",                         "This allows display of textual attributes information over default UI controls. It also creates custom frames for player and target.")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHORTNUMBERS",                        "Shorten numbers on all bars")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHORTNUMBERS_TP",                     "Replace large numbers like 12,345 with 12.3k on all bars and labels related to unit frames.")

-- Shared Options
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_LABEL",                        "Label Format")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_LABEL_TP",                     "Format label for custom attribute bar.")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_LABEL_LEFT",                   "Label Format (Left)")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_LABEL_LEFT_TP",                "Format first label for custom attribute bar.")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT",                  "Label Format (Right)")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_LABEL_RIGHT_TP",               "Format second label for custom attribute bar.")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_PT",                           "Player/Target")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_GROUP",                        "Group")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_RAID",                         "Raid")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_BOSS",                         "Boss")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_ARMOR",                        "<<1>> - Display Armor Change Overlay")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_ARMOR_TP",                     "Display additional icon on unit health bar when unit has its armor affected. Also displays cracked texture over health bar when armor is decreased.")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_POWER",                        "<<1>> - Display Power Change Overlay")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_POWER_TP",                     "Display an animated texture overlay when weapon/spell power is increased or decreased.")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_REGEN",                        "<<1>> - Display HoT / DoT Overlay")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_REGEN_TP",                     "Display an animated arrow overlay when regeneration is increased or decreased.")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY",            "Group/Raid Transparency (Shared Setting)")
ZO_CreateStringId("SI_LUIE_LAM_UF_SHARED_GROUPRAID_OPACITY_TP",         "Change the transparency of custom group and raid unit frames.")

-- Default Unit Frames Options
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_HEADER",                      "Default Unit Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_PLAYER",                      "Default PLAYER Frame")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_TARGET",                      "Default TARGET Frame")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_GROUPSMALL",                  "Default GROUP Frame")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_REPOSIT",                     "Reposition Default Player Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_REPOSIT_TP",                  "Change position of the default player frames to be in a compacted pyramid layout in the bottom center of the screen.")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_VERT",                        "Adjust Player Frames Vertical Position")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_VERT_TP",                     "Adjust the vertical position of the default player frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_OOCTRANS",                    "Transparency - Out-of-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_OOCTRANS_TP",                 "Change the transparency of default unit frames when out of combat. Default UI setting is hidden (0).")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_INCTRANS",                    "Transparency - In-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_INCTRANS_TP",                 "Change the transparency of default unit frames when engaged in combat. Default UI setting is fully visible (100).")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_LABEL",                       "Label Format")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_LABEL_TP",                    "Format of the label text for default unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_FONT_TP",                     "Choose the font to use for labels on the default unit frames bars.")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_FONT_SIZE_TP",                "Choose the font size for labels on the default unit frames bars.")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_FONT_STYLE_TP",               "Choose the font style for labels on the default unit frames bars.")
ZO_CreateStringId("SI_LUIE_LAM_UF_DFRAMES_LABEL_COLOR",                 "Label Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_TARGET_COLOR_REACTION",               "Color Target Name by Reaction")
ZO_CreateStringId("SI_LUIE_LAM_UF_TARGET_COLOR_REACTION_TP",            "Change the color of the Targets name label according to unit reaction.")
ZO_CreateStringId("SI_LUIE_LAM_UF_TARGET_ICON_CLASS",                   "Display Target Class Icon")
ZO_CreateStringId("SI_LUIE_LAM_UF_TARGET_ICON_CLASS_TP",                "Display class icon for target player.")
ZO_CreateStringId("SI_LUIE_LAM_UF_TARGET_ICON_GFI",                     "Display Target Friend/Guild/Ignored Icon")
ZO_CreateStringId("SI_LUIE_LAM_UF_TARGET_ICON_GFI_TP",                  "Display icon for target player if this player is your friend, in one of your guilds, or ignored.")

-- Custom Unit Frames Options
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_HEADER",                      "Custom Unit Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_UNLOCK",                      "Unlock Custom Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_UNLOCK_TP",                   "Allow mouse dragging for all custom unit frames. When frames are unlocked, the target frame is not being hidden and may display outdated information.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT",                  "Reset position")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_RESETPOSIT_TP",               "This will reset the position of Custom Frames to the default.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_FONT_TP",                     "Choose the font to use for custom unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS",            "Font Size (Label)")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_LABELS_TP",         "Choose the font size for unit name, caption, etc: everything not on bars.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS",              "Font Size (Bar)")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_FONT_SIZE_BARS_TP",           "Choose the font size for bar labels on custom unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_FONT_STYLE_TP",               "Choose the font style to use for custom unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_TEXTURE",                     "Texture")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_TEXTURE_TP",                  "Texture to use on custom frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE",             "Use Separate Shield Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_TP",          "Enable this option to change the shield bar on Player, Target, and Small Group custom frames to be independent and not overlayed with Health Bar.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT",      "Separate Shield Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SHIELD_SEPERATE_HEIGHT_TP",   "Choose the height for the shield bar.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY",              "Use Full Height Shield Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SHIELD_OVERLAY_TP",           "When Shield bar is NOT separate, use full-sized shield bar on top of health bar for Player, Target, and Small Group custom frames instead of default half-height overlay bar.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS",              "Use Smooth Bar Transition")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_SMOOTHBARTRANS_TP",           "Use smooth transition on all bars when value get changed. Disabling this option could improve performance a little.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_CHAMPION",                    "Champion Point Display Method")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_CHAMPION_TP",                 "Choose whether the actual value of champion points is shown or values above the current maximum attainable cap are displayed.")

-- Custom Unit Frame Color Options
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_HEADER",                "Custom Unit Frame Color Options")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALTH",                "Health Bar Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_SHIELD",                "Shield Bar Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_MAGICKA",               "Magicka Bar Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_STAMINA",               "Stamina Bar Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_DPS",                   "DPS Role Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_HEALER",                "Healer Role Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_TANK",                  "Tank Role Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_DK",                    "Dragonknight Class Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_NB",                    "Nightblade Class Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_SORC",                  "Sorcerer Class Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_TEMP",                  "Templar Class Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_WARD",                  "Warden Class Color")

-- Player/Target Frames
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_HEADER",                    "Custom Unit Frames (Player & Target)")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER",             "Enable Custom PLAYER Frame")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_PLAYER_TP",          "Create custom player unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET",             "Enable Custom TARGET Frame")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_ENABLE_TARGET_TP",          "Create custom target unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_WIDTH",              "Player - Bar Width")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_HP_HIGHT",           "Player - Health Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_HIGHT",          "Player - Magicka Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_HIGHT",         "Player - Stamina Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL",        "Player - Hide Magicka Bar Label")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOLABEL_TP",     "Hide the attribute values label on the Player Magicka Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR",          "Player - Hide Magicka Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_MAG_NOBAR_TP",       "Completely hide the Player Magicka Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL",       "Player - Hide Stamina Bar Label")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOLABEL_TP",    "Hide the attribute values label on the Player Stamina Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR",         "Player - Hide Stamina Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_STAM_NOBAR_TP",      "Completely hide the Player Stamina Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY",          "Player - Transparency - Out-of-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_OOCPACITY_TP",       "Change the transparency of custom player unit frames when out of combat.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY",           "Player - Transparency - In-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_ICPACITY_TP",        "Change the transparency of custom player unit frames when engaged in combat.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER",              "Player - Hide Anchored Buffs Out-of-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_PLAYER_TP",           "When out of combat, hide the buff & debuff frame if they are anchored to the player/target bars.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_SPACING",            "Player - Spacing Between Bars")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF",           "Player - Display Your Name")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_PLAYER_NAMESELF_TP",        "Display your character name and level on the player frame.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR",           "Player - Display Mount/Siege/Werewolf Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_MOUNTSIEGEWWBAR_TP",        "Display a bar to track mount stamina, siege weapon health, and remaining werewolf timer.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR",                   "Player - Display XP/Champion XP Bar")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_XPCPBAR_TP",                "Display a bar to track player experience gain.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR",              "Color Champion XP Bar by Point Type")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_XPCPBARCOLOR_TP",           "Set the color of the of Champion XP bar to be dependent on the type of Champion Point being earned.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_WIDTH",              "Target - Bar Width")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_HEIGHT",             "Target - Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY",          "Target - Transparency - Out-of-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_OOCPACITY_TP",       "Change the transparency of custom target unit frames when out of combat.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_ICPACITY",           "Target - Transparency - In-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_ICPACITY_TP",        "Change the transparency of custom target unit frames when engaged in combat.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_TARGET",              "Target - Hide Anchored Buffs Out-of-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_BuFFS_TARGET_TP",           "When out of combat, hide the buff & debuff frame if they are anchored to the player/target bars.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL",         "Target - Display Class Label")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TARGET_CLASSLABEL_TP",      "Display text label with target class name on target frame together with class icon.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD",              "Target - Execute Health % Threshold")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_EXETHRESHOLD_TP",           "Determines the threshold of HP to color the target label text red, as well as display the skull execute texture if enabled.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE",                "Target - Display Skull Execute Texture")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_EXETEXTURE_TP",             "Display Skull texture next to custom target frame for low-health target that should be executed.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TITLE",                     "Target - Display Title")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_TITLE_TP",                  "Display the title of the target player or NPC.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_RANK",                      "Target - Display AVA Rank")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_RANK_TP",                   "Display the AVA Rank of a player target.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT",           "Treat Missing Power as In-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPT_MISSPOWERCOMBAT_TP",        "When any resource pool is used change the frames to use the in combat opacity value as if engaged in combat.")

-- Group Frames
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_HEADER",                     "Custom Unit Frames (Group)")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE",           "Enable Custom GROUP Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_LUIEFRAMESENABLE_TP",        "Create custom group unit frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_WIDTH",                      "Group Bar Width")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_HEIGHT",                     "Group Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_SPACING",                    "Spacing Between Group Bars")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER",                  "Include Player in Group Frame")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_INCPLAYER_TP",               "Include the player in the list of group frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_ROLEICON",                   "Show Role Icon on Group Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESG_ROLEICON_TP",                "This will show the selected player role on group frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE",         "Color Custom Group Frames by Role")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYROLE_TP",      "Colors the custom group frame bars based off role.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS",        "Color Custom Group Frames by Class")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_GFRAMESBYCLASS_TP",     "Colors the custom group frame bars based off class.")

-- Raid Frames
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_HEADER",                     "Custom Unit Frames (Raid)")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE",           "Enable Custom RAID Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_LUIEFRAMESENABLE_TP",        "Create custom raid unit frames. If custom group frames are unused, then this raid frame will also be used for small groups.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_WIDTH",                      "Raid Bar Width")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_HEIGHT",                     "Raid Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_LAYOUT",                     "Raid Frame Layout")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_LAYOUT_TP",                  "Select layout of raid frame in format 'columns*rows'.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_SPACER",                     "Add Spacer for Every 4 Members")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_SPACER_TP",                  "Add a small spacer between raid members frames to visualize default group splitting.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP",                   "Raid Name Clip Location")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_NAMECLIP_TP",                "Due to the inability to detect the length of the hit point value, you can use this setting to manually change where the name is clipped on raid frames in order to prevent overlap.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_ROLEICON",                   "Class/Role Icon Format")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESR_ROLEICON_TP",                "Choose the method for displaying class or role icons on the raid frames.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE",         "Color Custom Raid Frames by Role")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYROLE_TP",      "Colors the custom raid frame bars based off role.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS",        "Color Custom Raid Frames by Class")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMES_COLOR_RFRAMESBYCLASS_TP",     "Colors the custom raid frame bars based off class.")

-- Boss Frames
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_HEADER",                     "Custom Unit Frames (Boss)")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE",           "Enable Custom BOSS Frames")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_LUIEFRAMESENABLE_TP",        "Create custom boss unit frames. This will track the health of up to 6 bosses in dungeons encounters.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_WIDTH",                      "Boss Bar Width")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_HEIGHT",                     "Boss Bar Height")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC",                 "Boss Bar Transparency - Out-of-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_OPACITYOOC_TP",              "Change the transparency of custom boss unit frames when out of combat.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC",                  "Boss Bar Transparency - In-Combat")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESB_OPACITYIC_TP",               "Change the transparency of custom boss unit frames when engaged in combat.")


-- PVP Frames
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPVP_HEADER",                   "Custom Unit Frames (PvP Target Frame)")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME",              "Enable PvP Target Frame")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_TP",           "Create additional custom target unit frames. This will track health of hostile pvp players only. It also by default has larger size, less information and is positioned in the center of the screen.")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_WIDTH",        "PvP Target Bars Width")
ZO_CreateStringId("SI_LUIE_LAM_UF_CFRAMESPVP_TARGETFRAME_HEIGHT",       "PvP Target Bar Height")

-- Common Options
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_HEADER",                       "Common options")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_NAMEDISPLAYMETHOD_TP",         "Determines the method used to display other player names on unit frames. This setting does not effect the player frame.\nDefault: Character Name")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_CAPTIONCOLOR",                 "Default Caption Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_NPCFONTCOLOR",                 "Friendly NPC Font Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_PLAYERFONTCOLOR",              "Friendly Player Font Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_HOSTILEFONTCOLOR",             "Hostile Font Color")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_RETICLECOLOR",                 "Apply Same Settings to Reticle")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_RETICLECOLOR_TP",              "Change the color of the reticle according to unit reaction.")
ZO_CreateStringId("SI_LUIE_LAM_UF_COMMON_RETICLECOLORINTERACT",         "Interactible Reticle Color")



ZO_CreateStringId("SI_LUIE_LAM_CT",                                     "Combat Text")

ZO_CreateStringId("SI_LUIE_LAM_CT_SHOWCOMBATTEXT",                      "Enable Combat Text (Combat Cloud)")
ZO_CreateStringId("SI_LUIE_LAM_CT_DESCRIPTION",                         "Display Combat Cloud combat text, with damage/healing values, and various alerts.")

CombatCloudLocalization = {
---------------------------------------------------------------------------------------------------------------------------------------
    --//PANEL TITLES//--
---------------------------------------------------------------------------------------------------------------------------------------
    panelTitles = {
        CombatCloud_Outgoing                = "Outgoing",
        CombatCloud_Incoming                = "Incoming",
        CombatCloud_Point                   = "Points",
        CombatCloud_Alert                   = "Alerts",
        CombatCloud_Resource                = "Resources"
    },
---------------------------------------------------------------------------------------------------------------------------------------
    --//MAIN//--
---------------------------------------------------------------------------------------------------------------------------------------
        combatCloudOptions                  = "Combat Cloud Options",
        unlock                              = "Unlock",
        unlockTooltip                       = "Unlock the panels to move them.",
---------------------------------------------------------------------------------------------------------------------------------------
    --//TOGGLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonToggleIncoming                = "Toggle Options [Incoming]",
        buttonToggleOutgoing                = "Toggle Options [Outgoing]",
        buttonToggleNotification            = "Toggle Options [Notifications]",
        headerToggleIncomingDamageHealing   = "Incoming Damage & Healing Toggles",
        headerToggleIncomingMitigation      = "Incoming Mitigation Toggles",
        headerToggleIncomingCrowdControl    = "Incoming Crowd Control Toggles",
        headerToggleOutgoingDamageHealing   = "Outgoing Damage & Healing Toggles",
        headerToggleOutgoingMitigation      = "Outgoing Mitigation Toggles",
        headerToggleOutgoingCrowdControl    = "Outgoing Crowd Control Toggles",
        headerToggleCombatState             = "Combat State Toggles",
        headerToggleAlert                   = "Active Combat Alert Toggles",
        headerTogglePoint                   = "Point Toggles",
        headerToggleResource                = "Resource Toggles",
        descriptionAlert                    = "Set Active Combat Tips to Always Show in the Interface options",
    --General
        inCombatOnly                        = "In Combat Only",
    --Combat State
        combatState                         = "Combat State",
        inCombat                            = "In Combat",
        outCombat                           = "Out Of Combat",
    --Damage & Healing
        damage                              = "Damage",
		damagecritical						= "Critical Damage",
        healing                             = "Healing",
		healingcritical						= "Critical Healing",
        energize                            = "Energize",
        ultimateEnergize                    = "Ultimate energize",
        drain                               = "Drain",
        dot                                 = "Damage over time",
		dotcritical							= "Critical Damage over time",
        hot                                 = "Healing over time",
		hotcritical							= "Critical Healing over time",
		critical							= "Throttle Critical Hits",
    --Mitigation
        mitigation                          = "Mitigation",
        miss                                = "Missed",
        immune                              = "Immune",
        parried                             = "Parried",
        reflected                           = "Reflected",
        damageShield                        = "Damage Shielded",
        dodged                              = "Dodged",
        blocked                             = "Blocked",
        interrupted                         = "Interrupted",
    --Crowd Control
        crowdControl                        = "Crowd Control",
        disoriented                         = "Disoriented",
        feared                              = "Feared",
        offBalanced                         = "Off Balanced",
        silenced                            = "Silenced",
        stunned                             = "Stunned",
    --Alerts
        alert                               = "Active Combat Alerts",
        alertCleanse                        = "Cleanse Now",
        alertBlock                          = "Block Now",
        alertExploit                        = "Exploit Now",
        alertInterrupt                      = "Interrupt Now",
        alertDodge                          = "Dodge Now",
        alertExecute                        = "Execute Now",
        executeThreshold                    = "Execute Threshold",
        executeFrequency                    = "Execute Frequency",
        ingameTips                          = "Hide ingame tips",
    --Points
        point                               = "AP, XP & CP Points",
        pointsAlliance                      = "Alliance Points",
        pointsExperience                    = "Experience Points",
        pointsChampion                       = "Champion Points",
    --Resources
        resource                            = "Resources",
        formatResource                      = "Low Resources",
        lowHealth                           = "Low Health",
        lowMagicka                          = "Low Magicka",
        lowStamina                          = "Low Stamina",
        ultimateReady                       = "Ultimate Ready",
        potionReady                         = "Potion Ready",
        warningSound                        = "Warning Sound",
        warningThresholdHealth              = "Warning Threshold Health",
        warningThresholdMagicka             = "Warning Threshold Magicka",
        warningThresholdStamina             = "Warning Threshold Stamina",
    --Tooltips General
        tooltipInCombatOnly                 = "Will only display incoming and outgoing numbers when in combat",
    --Tooltips Incoming
        --Damage & Healing
        tooltipIncomingDamage               = "Show incoming damage",
        tooltipIncomingHealing              = "Show incoming direct healing",
        tooltipIncomingEnergize             = "Show incoming magicka/stamina return",
        tooltipIncomingUltimateEnergize     = "Show incoming ultimate return",
        tooltipIncomingDrain                = "Show incoming magicka/stamina loss",
        tooltipIncomingDot                  = "Show incoming 'damage over time'",
        tooltipIncomingHot                  = "Show incoming 'healing over time'",
        --Mitigation
        tooltipIncomingMiss                 = "Show missed enemy attacks",
        tooltipIncomingImmune               = "Show immunity to enemy attacks",
        tooltipIncomingParried              = "Show parried attacks",
        tooltipIncomingReflected            = "Show reflected attacks (incoming only)",
        tooltipIncomingDamageShield         = "Show damage shield absorbs",
        tooltipIncomingDodge                = "Show dodged attacks",
        tooltipIncomingBlocked              = "Show blocked attacks",
        tooltipIncomingInterrupted          = "Show interrupted attacks",
        --Crowd Control
        tooltipIncomingDisoriented          = "Show whether you are disoriented",
        tooltipIncomingFeared               = "Show whether you are feared",
        tooltipIncomingOffBalanced          = "Show whether you are off balanced",
        tooltipIncomingSilenced             = "Show whether you are silenced",
        tooltipIncomingStunned              = "Show whether you are stunned",
    --Tooltips Outgoing
        --Damage & Healing
        tooltipOutgoingDamage               = "Show outgoing damage",
        tooltipOutgoingHealing              = "Show outgoing direct healing",
        tooltipOutgoingEnergize             = "Show outgoing magicka/stamina return",
        tooltipOutgoingUltimateEnergize     = "Show outgoing ultimate return",
        tooltipOutgoingDrain                = "Show outgoing magicka/stamina loss",
        tooltipOutgoingDot                  = "Show outgoing 'damage over time'",
        tooltipOutgoingHot                  = "Show outgoing 'healing over time'",
        --Mitigation
        tooltipOutgoingMiss                 = "Show your missed attacks on the enemy",
        tooltipOutgoingImmune               = "Show whether the enemy was immune to the attack",
        tooltipOutgoingParried              = "Show whether the enemy parried the attack",
        tooltipOutgoingReflected            = "Show whether the enemy reflected the attack",
        tooltipOutgoingDamageShield         = "Show whether the enemy absorbed the attack",
        tooltipOutgoingDodge                = "Show whether the enemy dodged the attack",
        tooltipOutgoingBlocked              = "Show whether the enemy blocked the attack",
        tooltipOutgoingInterrupted          = "Show whether the enemy interrupted the attack",
        --Crowd Control
        tooltipOutgoingDisoriented          = "Show whether you disoriented the enemy",
        tooltipOutgoingFeared               = "Show whether you feared the enemy",
        tooltipOutgoingOffBalanced          = "Show whether you made the enemy off balanced",
        tooltipOutgoingSilenced             = "Show whether you silenced the enemy",
        tooltipOutgoingStunned              = "Show whether you stunned the enemy",
    --Tooltips Combat State
        tooltipInCombat                     = "Will display a message upon entering combat",
        tooltipOutCombat                    = "Will display a message upon exiting combat",
    --Tooltips Alerts
        tooltipAlertsCleanse                = "Show alerts when you need to cleanse",
        tooltipAlertsBlock                  = "Show alerts when you can block a special attack",
        tooltipAlertsExploit                = "Show alerts when you can exploit the target",
        tooltipAlertsInterrupt              = "Show alerts when you can interrupt a special attack",
        tooltipAlertsDodge                  = "Show alerts when you can dodge a special attack",
        tooltipAlertsExecute                = "Show alerts when target has low health",
        tooltipExecuteThreshold             = "The threshold at which the execute alert will trigger. Default will display alert at 20% of target's health.",
        tooltipExecuteFrequency             = "The frequency how often will be execute alert triggered for the same target. Default is 8 seconds.",
        tooltipIngameTips                   = "Hide default Active Combat Tips window",
    --Tooltips Points
        tooltipPointsAlliance               = "Show accumulated Alliance Points",
        tooltipPointsExperience             = "Show accumulated Experience Points",
        tooltipPointsChampion                = "Show accumulated Champion Points",
    --Tooltips Resources
        tooltipLowHealth                    = "Show Health warning when below desired threshold",
        tooltipLowMagicka                   = "Show Magicka warning when below desired threshold",
        tooltipLowStamina                   = "Show Stamina warning when below desired threshold",
        tooltipUltimateReady                = "Show a notification when Ultimate becomes available",
        tooltipPotionReady                  = "Show a notification when Potion is ready for use",
        tooltipWarningSound                 = "Play a sound when resources fall below the desired threshold",
        tooltipWarningThresholdHealth       = "The threshold at which the warnings will trigger. Default will display a warning at 35%",
        tooltipWarningThresholdMagicka      = "The threshold at which the warnings will trigger. Default will display a warning at 35%",
        tooltipWarningThresholdStamina      = "The threshold at which the warnings will trigger. Default will display a warning at 35%",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FONT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonFont                          = "Font Options",
        buttonFontCombat                    = "Font Sizes [Combat]",
        buttonFontNotification              = "Font Sizes [Notifications]",
    --General Fonts
        fontFace                            = "Font Face",
        fontOutline                         = "Font Outline",
        fontTest                            = "Test Font",
        gainLoss                            = "Energize & Drain",
    --Tooltips Fonts
        tooltipFontFace                     = "Pick a font face",
        tooltipFontOutline                  = "Pick a font outline",
        tooltipFontTest                     = "Generate numbers to test out the chosen font",
    --Tooltips Fonts Combat
        tooltipFontDamage                   = "Font size of damage, default 26",
		tooltipFontDamageCritical           = "Font size of critical damage, default 26",
        tooltipFontHealing                  = "Font size of direct heals and energize, default 26",
		tooltipFontHealingCritical          = "Font size of critical direct heals and energize, default 26",
		tooptipFontDot						= "Font size of DoTs, default 18",
		tooltipFontDotCritical				= "Font size of critical DoTs, default 18",
		tooltipFontHot						= "Font size of HoTs, default 18",
		tooltipFontHotCritical				= "Font size of critical HoTs, default 18",
        tooltipFontGainLoss                 = "Font size of energize and drain, default 18",
        tooltipFontMitigation               = "Font size of mitigation, default 30",
        tooltipFontCrowdControl             = "Font size of crowd control warnings, default 36",
    --Tooltips Fonts Combat State, Alerts, Points, Resources
        tooltipFontCombatState              = "Font size of message when entering or exiting combat, default 32",
        tooltipFontAlert                    = "Font size of active combat alerts, default 48",
        tooltipFontPoint                    = "Font size of accumulated points, default 32",
        tooltipFontResource                 = "Font size of resource warnings, default 48",
---------------------------------------------------------------------------------------------------------------------------------------
    --//COLOR OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonColorCombat                   = "Color Options [Combat]",
        buttonColorNotification             = "Color Options [Notifications]",
        headerColorDamageHealing            = "Damage & Healing Colors",
        headerColorMitigation               = "Mitigation Colors",
        headerColorCrowdControl             = "Crowd Control Colors",
        headerColorCombatState              = "Combat State Colors",
        headerColorAlert                    = "Active Combat Alert Colors",
        headerColorPoint                    = "Point Colors",
        headerColorResource                 = "Resource Colors",
    --Damage & Healing
        energizeMagicka                     = "Energize (Magicka)",
        energizeStamina                     = "Energize (Stamina)",
        energizeUltimate                    = "Energize (Ultimate)",
        drainMagicka                        = "Drain (Magicka)",
        drainStamina                        = "Drain (Stamina)",
        colorCriticalDamage                 = "Override Critical Damage",
        colorCriticalHealing                = "Override Critical Healing",
		colorIncomingDamage                 = "Override Incoming Damage",
        colorCriticalDamageOverride         = "Critical Damage Color",
        colorCriticalHealingOverride        = "Critical Healing Color",
		colorIncomingDamageOverride         = "Incoming Damage Color",
        damageType = {
            [DAMAGE_TYPE_NONE]              = "None",
            [DAMAGE_TYPE_GENERIC]           = "Generic",
            [DAMAGE_TYPE_PHYSICAL]          = "Physical",
            [DAMAGE_TYPE_FIRE]              = "Fire",
            [DAMAGE_TYPE_SHOCK]             = "Shock",
            [DAMAGE_TYPE_OBLIVION]          = "Oblivion",
            [DAMAGE_TYPE_COLD]              = "Cold",
            [DAMAGE_TYPE_EARTH]             = "Earth",
            [DAMAGE_TYPE_MAGIC]             = "Magic",
            [DAMAGE_TYPE_DROWN]             = "Drown",
            [DAMAGE_TYPE_DISEASE]           = "Disease",
            [DAMAGE_TYPE_POISON]            = "Poison",
        },
    --Tooltips damage & healing
        tooltipColorHealing                 = "Set a color for all healing",
        tooltipColorEnergizeMagicka         = "Set a color for magicka return",
        tooltipColorEnergizeStamina         = "Set a color for stamina return",
        tooltipColorEnergizeUltimate        = "Set a color for ultimate return",
        tooltipColorDrainMagicka            = "Set a color for magicka loss",
        tooltipColorDrainStamina            = "Set a color for stamina loss",
        tooltipColorCriticalDamage          = "Use a set color for critical damage.",
        tooltipColorCriticalHealing         = "Use a set color for critical healing.",
		tooltipColorIncomingDamage          = "Use a sec color for incoming damage.",
        tooltipCriticalDamageOverride       = "Set a color for critical damage override",
        tooltipCriticalHealingOverride      = "Set a color for incoming healing override",
		tooltipIncomingDamageOverride       = "Set a color for incoming damage override",
        tooltipDamageType = {
            [DAMAGE_TYPE_NONE]              = "Set a color for damage with no type",
            [DAMAGE_TYPE_GENERIC]           = "Set a color for Generic damage",
            [DAMAGE_TYPE_PHYSICAL]          = "Set a color for Physical damage",
            [DAMAGE_TYPE_FIRE]              = "Set a color for Fire damage",
            [DAMAGE_TYPE_SHOCK]             = "Set a color for Shock damage",
            [DAMAGE_TYPE_OBLIVION]          = "Set a color for Oblivion damage",
            [DAMAGE_TYPE_COLD]              = "Set a color for Cold damage",
            [DAMAGE_TYPE_EARTH]             = "Set a color for Earth damage",
            [DAMAGE_TYPE_MAGIC]             = "Set a color for Magic damage",
            [DAMAGE_TYPE_DROWN]             = "Set a color for Drowning damage",
            [DAMAGE_TYPE_DISEASE]           = "Set a color for Disease damage",
            [DAMAGE_TYPE_POISON]            = "Set a color for Poison damage",
        },
    --Tooltips Mitigation
        tooltipColorMiss                    = "Set a color for missed attacks",
        tooltipColorImmune                  = "Set a color for immunity to attacks",
        tooltipColorParried                 = "Set a color for parried attacks",
        tooltipColorReflected               = "Set a color for reflected attacks",
        tooltipColorDamageShield            = "Set a color for damage shield absorbs",
        tooltipColorDodge                   = "Set a color for dodged attacks",
        tooltipColorBlocked                 = "Set a color for blocked attacks",
        tooltipColorInterrupted             = "Set a color for interrupted attacks",
    --Tooltips Crowd Control
        tooltipColorDisoriented             = "Set a color for notifications when disoriented",
        tooltipColorFeared                  = "Set a color for notifications when feared",
        tooltipColorOffBalanced             = "Set a color for notifications when off balance",
        tooltipColorSilenced                = "Set a color for notifications when silenced",
        tooltipColorStunned                 = "Set a color for notifications when stunned",
    --Tooltips Alerts
        tooltipColorAlertsCleanse           = "Set a color for cleanse alerts",
        tooltipColorAlertsBlock             = "Set a color for block alerts",
        tooltipColorAlertsExploit           = "Set a color for exploit alerts",
        tooltipColorAlertsInterrupt         = "Set a color for interrupt alerts",
        tooltipColorAlertsDodge             = "Set a color for dodge alerts",
        tooltipColorAlertsExecute           = "Set a color for execute alerts",
    --Tooltips Points
        tooltipColorPointsAlliance          = "Set a color for accumulated Alliance Points",
        tooltipColorPointsExperience        = "Set a color for accumulated Experience Points",
        tooltipColorPointsChampion           = "Set a color for accumulated Champion Points",
    --Tooltips Resources
        tooltipColorLowHealth               = "Set a color for low Health warnings",
        tooltipColorLowMagicka              = "Set a color for low Magicka warnings",
        tooltipColorLowStamina              = "Set a color for low Stamina warnings",
        tooltipColorUltimateReady           = "Set a color for notifications when Ultimate is available",
        tooltipColorPotionReady             = "Set a color for notifications when Potion is ready for use",
    --Tooltips Combat State
        tooltipColorInCombat                = "Set a color for notifications when entering combat",
        tooltipColorOutCombat               = "Set a color for notifications when exiting combat",
---------------------------------------------------------------------------------------------------------------------------------------
    --//FORMAT OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        descriptionFormat                   = "Allows to change the text output. Write any text you want or enter a variable for special outputs\n %t Ability name, localized name\n %a Amount, value\n %r Power type, resource",
        buttonFormatCombat                  = "Format Options [Combat]",
        buttonFormatNotification            = "Format Options [Notifications]",
        headerFormatDamageHealing           = "Damage & Healing Text Formats",
        headerFormatMitigation              = "Mitigation Text Formats",
        headerFormatCrowdControl            = "Crowd Control Text Formats",
        headerFormatCombatState             = "Combat State Formats",
        headerFormatAlert                   = "Active Combat Alert Formats",
        headerFormatPoint                   = "Point Text Formats",
        headerFormatResource                = "Resource Text Formats",
    --Tooltips Damage & Healing
        tooltipFormatDamage                 = "Text format for damage numbers",
		tooltipFormatDamageCritical         = "Text format for critical damage numbers",
        tooltipFormatHealing                = "Text format for direct healing numbers",
		tooltipFormatHealingCritical        = "Text format for critical direct healing numbers",
        tooltipFormatEnergize               = "Text format for magicka/stamina return",
        tooltipFormatUltimateEnergize       = "Text format for ultimate return",
        tooltipFormatDrain                  = "Text format for magicka/stamina loss",
        tooltipFormatDot                    = "Text format for 'damage over time' numbers",
		tooltipFormatDotCritical            = "Text format for critical 'damage over time' numbers",
        tooltipFormatHot                    = "Text format for 'heal over time' numbers",
		tooltipFormatHotCritical            = "Text format for critical 'heal over time' numbers",
    --Tooltips Mitigation
        tooltipFormatMiss                   = "Text format for missed attacks",
        tooltipFormatImmune                 = "Text format for immunity to attacks",
        tooltipFormatParried                = "Text format for parried attacks",
        tooltipFormatReflected              = "Text format for reflected attacks",
        tooltipFormatDamageShield           = "Text format for damage shield absorbs",
        tooltipFormatDodged                 = "Text format for dodged attacks",
        tooltipFormatBlocked                = "Text format for blocked attacks",
        tooltipFormatInterrupted            = "Text format for interrupted attacks",
    --Tooltips Crowd Control
        tooltipFormatDisoriented            = "Text format for notifications when disoriented",
        tooltipFormatFeared                 = "Text format for notifications when feared",
        tooltipFormatOffBalanced            = "Text format for notifications when off balanced",
        tooltipFormatSilenced               = "Text format for notifications when silenced",
        tooltipFormatStunned                = "Text format for notifications when stunned",
    --Tooltips Alerts
        tooltipFormatAlertsCleanse          = "Text format for cleanse alerts",
        tooltipFormatAlertsBlock            = "Text format for block alerts",
        tooltipFormatAlertsExploit          = "Text format for exploit alerts",
        tooltipFormatAlertsInterrupt        = "Text format for interrupt alerts",
        tooltipFormatAlertsDodge            = "Text format for dodge alerts",
        tooltipFormatAlertsExecute          = "Text format for execute alerts",
    --Tooltips Points
        tooltipFormatPointsAlliance         = "Text format for accumulated Alliance Points",
        tooltipFormatPointsExperience       = "Text format for accumulated Experience Points",
        tooltipFormatPointsChampion          = "Text format for accumulated Champion Points",
    --Tooltips Resources
        tooltipFormatResource               = "Text format for warnings when low on resources",
        tooltipFormatUltimateReady          = "Text format for notifications when your Ultimate is available",
        tooltipFormatPotionReady            = "Text format for notifications when Potion is ready for use",
    --Tooltips Combat State
        tooltipFormatInCombat               = "Text format for notifications when entering combat",
        tooltipFormatOutCombat              = "Text format for notifications when exiting combat",
---------------------------------------------------------------------------------------------------------------------------------------
    --//ANIMATION OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonAnimation                     = "Animation Options",
    --General
        animationType                       = "Animation type",
        outgoingDirection                   = "Outgoing direction",
        incomingDirection                   = "Incoming direction",
        animationTest                       = "Test Animation",
        outgoingIcon                        = "Outgoing icon position",
        incomingIcon                        = "Incoming icon position",
    --Tooltips
        tooltipAnimationType                = "Select Animation Type",
        tooltipAnimationIncomingDirection   = "Set the direction of incoming damage",
        tooltipAnimationOutgoingDirection   = "Set the direction of outgoing damage",
        tooltipAnimationTest                = "Test the animations of incoming & outgoing damage",
        tooltipAnimationOutgoingIcon        = "Set the icons position of outgoing events",
        tooltipAnimationIncomingIcon        = "Set the icons position of incoming events",
---------------------------------------------------------------------------------------------------------------------------------------
    --//THROTTLE OPTIONS//--
---------------------------------------------------------------------------------------------------------------------------------------
    --Headers
        buttonThrottle                      = "Throttle Options",
    --General
        descriptionThrottle                 = "Accumulates multiple hits into one. Use the slider to adjust the time frame in milliseconds. Critical hits are never throttled.\n",
        showThrottleTrailer                 = "Show throttle trailer",
    --Tooltips
        tooltipThrottleDamage               = "Set the throttle for damage numbers",
        tooltipThrottleHealing              = "Set the throttle for healing numbers",
        tooltipThrottleDot                  = "Set the throttle for 'damage over time' numbers",
        tooltipThrottleHot                  = "Set the throttle for 'heal over time' numbers",
        tooltipThrottleTrailer              = "Enable throttle trailer",
		tooltipThrottleCritical             = "Enable throttle for critical hits",
}
