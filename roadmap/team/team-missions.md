# Team missions (Missão de equipe, groupfb)

Feature `team`, module `team-missions`. Rooms for the cooperative two side team campaign ("Ruínas de Narendra").

Conventions as in [freedom-team.md](freedom-team.md). All requests use one opcode, C>S 8972 0x230c `C_TEAM_CAMPAIGN_OP`, with `marriage.MarriageOpMsg` as body: `user_id (#1, INT32)`, `op_type (#2, INT32)`, `pay_type (#3, INT32)`, `property1 (#4, INT32)`, `property2 (#5, INT32)`, `property3 (#6, STRING)`, `property4 (#7, STRING)`, `property5 (#8, BOOL)`, `userIds (#9, INT32, repeated)`, `properties (#10, PropertyListMsg, repeated)` with `PropertyListMsg`: `property1 (#1, INT32)`, `property2 (#2, INT32)`, `isNoGet (#11, BOOL)`. Op codes are constants in `GroupfbSender` (`decompiled/core_module/scripts/mvc/module/groupfb/GroupfbSender.as`).

## 1. Overview

A player opens the room list, creates a room (becomes master), or joins one (search by number, click a row, quick join, invitation popup or chat link). In the room each member is on side 1 or 2, sets ready, and the master starts the campaign when there are at least 2 players with at least one on each side. The room pushes its full state (4786) to all members on every change; the room list (4785) is pushed to players viewing it. A "use reward chances" checkbox (`isNoGet`) lets a player join without consuming a daily reward attempt (`teamCount / teamMaxCount`). Inside the campaign map the server pushes skill animations (4790) and damage (4792). The global open state (4784) shows or hides the entry icon in the top tool bar.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `groupfb.GroupfbRoomListFrame` `decompiled/m9/scripts/groupfb/GroupfbRoomListFrame.as:52` | "Missão de equipe" (`groupfb.GroupfbRoomListFrame.title`) | Room list, quick join, search, create, counter `teamCount / teamMaxCount` (`:89`) | `GroupfbController` openType 1 (Open question: opener) | rooms (id, name, count/capacity, lock, state) |
| `GroupfbRoomItem` `decompiled/m9/scripts/groupfb/GroupfbRoomItem.as` | | One room; click searches it (`:147`) | list | |
| `groupfb.GroupfbRoomSearchFrame` `decompiled/m9/scripts/groupfb/GroupfbRoomSearchFrame.as` | | Search by room number (`:153`) | list frame search button (`GroupfbRoomListFrame.as:273`, openType 3) | |
| `groupfb.GroupfbTeamFrame` `decompiled/m9/scripts/groupfb/GroupfbTeamFrame.as` | "Gerenciamento da Equipe"; "Usar chances de ganhos"; tips "Deseja sair da equipe?", start confirm "Depois da campanha iniciar os dois parceiros não podem trocar de membros\nQuer iniciar?" | Room: two side lists (`GroupfbTeamListView`, header key `groupfb.GroupfbTeamListView.title`: character, level, combat power, ready state), ready "Preparado" / "--", lock (password), lineup, prepare, cancel, start, exit | openType 2 after entering a room (4786) | `GroupfbModel.selfTeam` |
| `GroupfbTeamItem` + `GroupfbTeamItemDropMediator` `decompiled/m9/scripts/groupfb/GroupfbTeamItem.as`, `GroupfbTeamItemDropMediator.as:100` | kick confirm "Deseja expulsar [{0}] da equipe?" | member card; drag to the other side to swap | room | |
| `teammanager.GroupSortFrame` `decompiled/m5/scripts/teammanager/GroupSortFrame.as:302` | | Battle positions for the group | room lineup button | |
| `core.RoomPasswordFrame` | | password input | 4791 with a password | |
| `yishi.view.frame.InviteFrame` `decompiled/core_module/scripts/yishi/view/frame/InviteFrame.as:200` | | invitation popup with the reward checkbox | room invitation (room feature) | |

## 3. Routes (client to server)

All rows: C>S 8972 0x230c `C_TEAM_CAMPAIGN_OP`, body `MarriageOpMsg`.

| # | UI control | Client sender | Client checks | `op_type` and fields | Response |
|---|---|---|---|---|---|
| G1 | Open room list | `GroupfbRoomListFrame` constructor `:57` then `GroupfbSender.requestList` | none | 3 `TEAM_LIST` | 4785 |
| G2 | "Criar" | `GroupfbRoomListFrame.__createRoomHandler` `:228` then `creatGroup` | 2 s anti double click ("Clique excessivo, tente novamente"); `WorldBossHelper.getCampaignTips()` empty (`decompiled/core_module/scripts/yishi/utils/WorldBossHelper.as:334`); no free team and no group team ("Favor retirar o estado de equipe") | 1 `TEAM_CREATE` | 4786 (room with self as master) |
| G3 | Quick join | `__quickClickHandler` `:276` then `enterGroup(0)` | same checks | 6 `TEAM_ENTER`, `property1` = 0 (any room) | 4786 |
| G4 | Click a room / search by number / chat room link | `GroupfbRoomItem` `:147`, `GroupfbRoomSearchFrame` `:153`, `ChatOutputViewII` (`searchRoom(id, true)`) then `searchRoom` | same checks for list/search | 14 `ROOM_INFO`, `property1` room id, `property5` true when coming from a chat invitation link | 4791 |
| G5 | Enter after 4791 | `GroupfbManager.__serachRoomResultHandler` `decompiled/core_module/scripts/managers/GroupfbManager.as:67`, `passWordBackCall` `:110`, `inviteBackCall` `:115`, `InviteFrame` `:200` | invitation: confirm popup with remaining boss count; password: password frame | 6 `TEAM_ENTER`, `property1` room id, `property3` password, `property5` true when accepting an invitation, `isNoGet` true to skip reward use | 4786 |
| G6 | Invite a player | room invite items `decompiled/m9/scripts/room/view/invite/InviteItem.as`, `InviteItemButton.as`, `TheseusInviteItemButton` then `inviteGroup` | in a group room | 5 `TEAM_INVITE`, `property1` target user id | target gets an invitation (room feature popup) leading to G4/G5 |
| G7 | Prepare | `GroupfbTeamFrame.__prepareBtnHandler` `:321` then `editGroup(2, !checkbox)` | | 8 `TEAM_STATE_EDIT`, `property1` 2 (ready), `isNoGet` | 4786 |
| G8 | Cancel ready | `__cancleBtnHandler` `:333` then `editGroup(1)` | | 8, `property1` 1 (waiting), `isNoGet` false | 4786 |
| G9 | Reward checkbox | `__checkBtnHandler` `:296` then `useIncome` | | 17 `USE_INCOME`, `isNoGet` | 4786 |
| G10 | Lock button (password) | `__lockBtnHandler` `:304` then `changePassward` | master | 10 `UPDATE_PWD`, `property3` password ("" clears) | 4786 / 4785 |
| G11 | Rename | `renameCampaign` (no caller found) | master | 9 `UPDATE_NAME`, `property3` name | 4786 |
| G12 | Change master | `changeMaster` (member menu, no caller found by literal search) | master | 11 `CHANGE_MASTER`, `property1` new master id | 4786 |
| G13 | Kick | `GroupfbTeamItem` `:233` then `delPlayer` after "Deseja expulsar [{0}] da equipe?" | master | 13 `REMOVE_PLAYER`, `property1` user id | 4786 to all; kicked member gets 4786 without himself (Assumption) |
| G14 | Drag to other side | `GroupfbTeamItemDropMediator.beDropHitCallBack` `:100` then `changeTeam` | target on another side | 15 `CHANGE_TEAM`, `properties` = [`PropertyListMsg` `property1` moved user, `property2` user on the target slot or 0] | 4786 |
| G15 | Lineup | `GroupSortFrame` `:302` then `editPos` | master (Assumption) | 12 `EDIT_FIGHT_POS`, `properties` = per member (`property1` user id, `property2` position) | 4786 |
| G16 | Start | `GroupfbTeamFrame.__startBtnHandler` `:368` then `startCampaign(!checkbox)` | >= 2 players ("Apenas precisa de 2 pessoas para entrar na campanha"), side 1 not empty, side 2 not empty ("{0}Precisa no mínimo de 1 pessoa para entrar na campanha"), confirmation; `canStart`: master and all others ready (`GroupfbModel.as:40`) | 7 `TEAM_CAMPAIGN_START`, `isNoGet` | enter the campaign map (campaign feature packets) |
| G17 | Exit | `__exitBtnHandler` `:342` then `exitGroup` | confirmation "Deseja sair da equipe?" | 4 `TEAM_EXIT` | 4786 to remaining members; leaver gets room state 3 (Assumption) |
| G18 | Boss reinforce | `GroupfbSender.reinforce` (no caller found) | | 16 `BOSS_REINFORCE`, `property1` | Open question |
| G19 | Find | constant 2 `TEAM_FIND` (unused) | | 2 | |

## 4. Server messages (server to client)

`room.TeamRoomMsg`: `id (#1, INT32)` room number; `name (#2, STRING)`; `pwd (#3, STRING)` password (empty = open); `room_state (#4, INT32)` (3 = closed/ended; rooms in state 3 are dropped from the list and `hasGroupTeam` is false); `count (#5, INT32)`; `capacity (#6, INT32)`; `infos (#7, room.TeamPlayerMsg, repeated)`; `master_id (#8, INT32)`; `boss_count (#9, INT32)` remaining bosses (< 0 = unknown text); `is_invite (#10, BOOL)`.

`room.TeamPlayerMsg`: `user_id (#1, INT32)`, `nick_name (#2, STRING)`, `fight_power (#3, INT32)`, `grade (#4, INT32)`, `ready_state (#5, INT32)` (1 waiting, 2 ready), `team (#6, INT32)` side 1 or 2, `pos (#7, INT32)` (unused by the reader), `consortia_name (#8, STRING)`, `job (#9, INT32)`, `fight_pos (#10, INT32)` battle position, `head_id (#11, INT32)`, `is_online (#12, BOOL)`, `templateid (#13, INT32)`, `isNoGet (#14, BOOL)`.

| Route | Message | Client receiver | When |
|---|---|---|---|
| S>C 4785 0x12b1 `U_C_TEAM_CAMPAIGN_LIST` | `room.TeamRoomListMsg`: `roomList (#1, TeamRoomMsg, repeated)` (only `id`, `name`, `count`, `capacity`, `pwd`, `room_state` read) | `GroupfbManager.__roomListHandler` `GroupfbManager.as:135` | response to op 3 and on list changes to viewers (Assumption) |
| S>C 4786 0x12b2 `U_C_TEAM_CAMPAIGN_PLAYER_STATE` | `TeamRoomMsg` full room | `__playerState` `:179` (sets `selfTeam`, opens the room frame when the player just joined in castle or space scene) | after any room change, to every member |
| S>C 4791 0x12b7 `U_C_TEAM_ROOM_INFO` | `TeamRoomMsg` (`id`, `pwd`, `is_invite`, `boss_count`) | `__serachRoomResultHandler` `:67` | response to op 14: invitation popup when `is_invite`, password frame when `pwd` is set, else immediate op 6 |
| S>C 4784 0x12b0 `U_C_TEAM_CAMPAIGN_STATE` | `room.MatchStateMsg`: `match_state (#1, BOOL)` open; `param1 (#2, STRING)`, `param2 (#3, STRING)` unused | `__campaignSwitch` `:123` (refreshes the top tool bar) | at login and when the opening window (`team_campaign_time`) starts or ends |
| S>C 4790 0x12b6 `U_C_TEAM_CAMPAIGN_ATTACK` | `VehicleAttackRspMsg` (vehicle feature message) | `CampaignSocketManger.__groupfbMovieHandler` `decompiled/m3/scripts/map/campaign/CampaignSocketManger.as:2231` | boss skill animation in the campaign map |
| S>C 4792 0x12b8 `U_C_TEAM_CAMPAIGN_DAMAGE` | `VehicleAttackRspMsg` with `playerHurtDataList` | `__groupfbAttackHandler` `:2247` | damage to players in the campaign map |

## 5. Rules and formulas

- Opening hours `team_campaign_time = 19:00,23:00` (`raw/xml/tempinfos/ConfigInfos.xml`, "团队副本开放时间").
- Daily reward attempts `PlayerInfo.teamCount / teamMaxCount` (sent in player data, account feature); `isNoGet = true` means the player participates without consuming an attempt and without rewards (Assumption from the label "Usar chances de ganhos").
- Start requires >= 2 players, at least one per side, all non master members ready.
- Cannot create or join while in a free team or another group room.
- Group chat channel 14 targets room members ([../chat/channels.md](../chat/channels.md)).
- Room capacity and the side size are not visible client side (Assumption: capacity 4, 2 per side, matching the "two partners" wording).

## 6. Templates

| File | Use |
|---|---|
| `raw/xml/tempinfos/ConfigInfos.xml` | `team_campaign_time` |
| campaign templates (campaign feature) | the team campaign map ("Ruínas de Narendra") |

## 7. Persistent state

Rooms are runtime objects. Daily attempts:

```sql
CREATE TABLE team.mission_daily (
    player_id     integer     NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
    day           date        NOT NULL,
    attempts_used smallint    NOT NULL DEFAULT 0 CHECK (attempts_used >= 0),
    PRIMARY KEY (player_id, day)
);
```

## 8. Backend implementation notes

- One dispatcher `team::missions::handle_op` (8972) routing by `op_type` to `handle_create` (1), `handle_list` (3), `handle_exit` (4), `handle_invite` (5), `handle_enter` (6), `handle_start` (7), `handle_state_edit` (8), `handle_rename` (9), `handle_password` (10), `handle_change_master` (11), `handle_edit_fight_pos` (12), `handle_remove_player` (13), `handle_room_info` (14), `handle_change_team` (15), `handle_boss_reinforce` (16), `handle_use_income` (17).
- Room registry in memory (id allocation from 1); every mutation pushes 4786 to all members and 4785 to subscribed list viewers.
- Start: validate rules, consume attempts for members with `isNoGet = false` (one transaction on `team.mission_daily`), create the campaign instance and move members (campaign feature); room state becomes in progress; when the campaign ends set state 3.
- Scheduler: at the window start and end push 4784 to all online players; reject ops 1, 6, 7 outside the window.

## 9. Open questions and assumptions

1. No client code opens `GroupfbController` in this version; the entry may come from an NPC dialog or the activity list. To be confirmed in game.
2. Ops 2, 9, 11, 16 have no caller found.
3. Room capacity, side size and boss count source are not in the client.

## 10. Implementation checklist

- [ ] Room list, create, quick join, search, password, invitation popup (ops 3, 1, 6, 14 and pushes 4785, 4786, 4791)
- [ ] Ready, cancel, reward checkbox, side swap, kick, exit (ops 8, 17, 15, 13, 4)
- [ ] Start with validation and attempt consumption (op 7)
- [ ] Opening window push 4784 and time checks
- [ ] Campaign attack and damage pushes 4790, 4792 (with the campaign feature)
- [ ] Table `team.mission_daily`
