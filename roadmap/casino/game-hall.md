# Salão de jogo (game hall lobby, "游戏大厅")

Path aliases:

| Alias | File |
|---|---|
| GHM | `decompiled/core_module/scripts/managers/GameHallManager.as` |
| GHMOD | `decompiled/core_module/scripts/mvc/module/gamehall/GameHallModel.as` |
| GHF | `decompiled/m3/scripts/gamehall/GameHallFrame.as` |
| GHSC | `decompiled/m3/scripts/gamehall/GameHallSceneController.as` |
| GHBV | `decompiled/m3/scripts/gamehall/room/GameHallSceneBottomView.as` |
| GHTR | `decompiled/m3/scripts/gamehall/view/GameHallTeamRightView.as` |
| GHSF | `decompiled/m3/scripts/gamehall/room/GameHallSortFrame.as` |
| BM | `decompiled/core_module/scripts/yishi/manager/BaseManager.as` |
| SPH | `decompiled/core_module/scripts/yishi/SwitchPageHelp.as` |
| DOI | `decompiled/m3/scripts/map/space/view/frame/DialogOptionItem.as` |

## 1. Overview

A multiplayer lobby where up to 4 players form a team for one of the hall games, walk in a shared room scene (`GAME_HALL_SCENE`), get ready and start. The games are defined by `GameHallTemplates.xml`:

| GameId | Name | Group | Open level | Open weekdays | Daily rewarded runs | Owner of the game rules |
|---|---|---|---|---|---|---|
| 1 | "Fase super-rápida" | 1 "Permanente" | 36 | 1,4,7 | 1 | [../campaign/README.md](../campaign/README.md) (rapid through campaign, help `gamehall.HelpFrame1`) |
| 2 | "Campo de Minas" | 1 "Residente" | 80 (profession advance) | 2,5,7 | 1 (extra field 22) | [../final-defense/README.md](../final-defense/README.md) (`landmine`) |
| 3 | "Plano de Crise" | 1 "Residente" | 80, difficulty 1 and 2 | 3,6,7 | 1 | [../trials/README.md](../trials/README.md) (`crisis`) |
| 4 | "Busca de ovos" | 2 "Páscoa" | 160 | every day inside `StartDate..StopDate` | 1 | [easter-egg-hunt.md](easter-egg-hunt.md) |

This module covers the lobby: team list, team lifecycle, invitations, password, game choice, ready state, start, formation and movement. The game sessions themselves are campaigns started by the server after "start".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `gamehall.GameHallFrame` (GHF), 975x645 | "Salão de jogo" (GHF:46) | Tab "activities" (`GameHallActiveView`: games by group, "NEW", "Dia/Semana" open days, "Dificuldade 1/2", rewards preview `ShowItems`, "N° de ganhos restantes ({0}/{1})") and tab "teams" (`GameHallTeamView`: team list "N°. {0}", "Minha equipe", search by id "Insira a ID da Equipe", refresh with 20 s cooldown, auto refresh every 30 s, create) (GHF:81-107, GHTR:180-225) | Space NPC dialog option 135 -> `SwitchPageHelp.openGameHallFrame()` (DOI:800-801, SPH:2552-2564: `VersionSwitch.GAME_HALL` true, right scene); top toolbar `gamehall` (TopToolBtnInfos 4020 "复活节活动") while the Easter event is open (see [easter-egg-hunt.md](easter-egg-hunt.md)) | templates, 4561 |
| `gamehall.GameHallSceneController` (GHSC) | scene `GAME_HALL_SCENE` | Room scene with the team avatars walking (`GameHallSceneMapView`, `GameHallSceneWalkView`), bottom bar `GameHallSceneBottomView` | entered on 4562 op 3 (create), op 103 (login), or back from a game campaign (`CampaignSocketManger.as:2025-2041`) | `selfTeam`, armies |
| `GameHallSceneBottomView` (GHBV) | room bar | Game combo box (captain only), lock (password), invite, leave, formation, kick, transfer captain, start (captain) or ready (members), "N° de ganhos usados ({0}/{1})" with the "use count" checkbox | GHSC | |
| `gamehall.room.GameHallPasswordFrame` | "Senha" | Set or enter a password | lock button; joining a locked team | |
| `gamehall.room.GameHallSortFrame` (GHSF) | "Formação dos Soldados" | Order of heroes in the team battle | formation button (`openControllerByInfo("teammanager","GAME_HALL_SORT_FRAME")`) | 4563 |
| `core.TimeOutInviteFrame` | "Aviso" | Invite "{0} convida você a entrar no Salão do Jogo\n[{1}] (N° de pessoas {2}/4)", 10 s timeout (BM:518-584) | push 4564 | |

Exit: main toolbar exit in `GAME_HALL_SCENE` asks "ui.maintoolbar.MainToolBar.exitGameHall" and sends leave (`MainToolBar.as:1668-1671, 1831-1835`).

## 3. Routes (client to server)

Main route: C>S 8646 (0x21c6) `C_GAME_HALL_OP`, body `gamehall.GameHallOpMsg`: `op` (#1, INT32); `teamId` (#2, INT32); `gameId` (#3, INT32); `difficulty` (#4, INT32); `userId` (#5, INT32); `password` (#6, STRING); `isUseCount` (#7, BOOL) consume one daily rewarded run; `isPrepare` (#8, BOOL); `isRefresh` (#9, BOOL) manual refresh; `autoType` (#10, INT32) Easter auto mode. Senders in GHM:888-1016, op constants GHM:57-95.

| # | op | Action | UI | Client checks | Fields | Expected reply |
|---|---|---|---|---|---|---|
| R1 | 1 | Team list | teams tab open, auto every 30 s, refresh button (GHTR:67, 188, 201) | refresh button 20 s cooldown | `isRefresh` | 4561 |
| R2 | 2 | Team info before joining | click a team (`GameHallTeamItemView.as:127`) | none | `teamId` | 4562 op 2 (client then asks the password if set and sends op 4) |
| R3 | 3 | Create team | create button (GHTR:207-210) | selected game open today (`isOpenToday`, GHMOD:289-315) | `gameId`, `difficulty` | 4562 op 3 -> enter scene |
| R4 | 4 | Join | after R2 (GHM:242-260) | password prompt when locked | `teamId`, `password` | 4562 op 103 to the joiner (assumption) and op 4 to members |
| R5 | 5 | Leave | leave button, main toolbar exit (GHBV:493-496) | none | none | 4562 op 5 to all members (`opUserId`) |
| R6 | 6 | Kick | kick menu (GHBV:524-527) | captain | `userId` | 4562 op 5 or 6 |
| R7 | 7 | Transfer captain | leader menu (GHBV:529-532) | captain | `userId` | 4562 op 7 |
| R8 | 8 | Set password | lock button (GHBV:470-481) | captain | `password` ("" clears) | 4562 op 8 |
| R9 | 9 | Change game | combo box (GHBV:452-468) | captain; game open today else "Este modo de jogo não está aberto" | `gameId`, `difficulty` | 4562 op 9 |
| R10 | 10 | Start | start button (GHBV:534-559) | captain; game 4 needs tickets (see Easter) | `isUseCount`, `autoType` | campaign enter messages of the game; 4562 op 10 |
| R11 | 11 | Accept an invite / join from chat link | invite frame confirm (BM:580-588), chat link "Deseja entrar na sala {0}?" (`ChatOutputViewII.as:657`) | none | `teamId` | as R4 |
| R12 | 12 | Ready / unready | ready button (GHBV:560-589, 762) | game 4 tickets | `isPrepare`, `isUseCount` | 4562 op 12 |
| R13 | 13 | Search team | search box (GHTR:215-222) | numeric id | `teamId` | 4562 op 13 |
| R14 | 14 | Cancel Easter auto mode | auto view cancel | none | `teamId` | 4562 op 14 |

Other routes:

| # | Route | Body | Sender | Purpose | Reply |
|---|---|---|---|---|---|
| R15 | C>S 8648 (0x21c8) `C_GAME_HALL_INVITE` | `simple.PropertyMsg`: `param1` (#1, INT32) invited user id | `GameHallManager.teamInvite(userId)` (GHM:1018-1024) from the room invite lists (`m9/scripts/room/view/invite/InviteItem.as:145`, `InviteItemButton.as:171`) | invite a player | push 4564 to the invitee |
| R16 | C>S 8649 (0x21c9) `C_GAME_HALL_MOVE` | `campaign.SpacePlayerMoveMsg`: `players` (#1, `SpacePlayerMsg`, repeated: `playerId` (#1, INT32), `state` (#2, INT32), `path` (#3, `PosMsg` repeated: `x` (#1), `y` (#2))) | `GameHallManager.teamMove(path)` (GHM:1026-1042) from `GameHallPlayerWalkMediator.as:135` | walk in the room | broadcast 4565 |
| R17 | C>S 8647 (0x21c7) `C_GAME_HALL_EDIT_POS` | `team.MemberFightPosListMsg`: `is_get` (#1, BOOL) true = read; `memberPos` (#2, `MemberFightPos` repeated: `member_id` (#1, INT32), `pos` (#2, INT32), `serverName` (#3, STRING)); `serverName` (#3, STRING) | `teamPosEdit(isGet, list)` (GHM:1044-1063) from GHSF:44 (read), :169 (save) | battle positions | 4563 |
| R18 | C>S 25256 (0x62a8) `CR_GAME_HALL_CHAT` | not sent by this client | none | cross server room chat | none |

## 4. Server messages (server to client)

### S1. 4561 (0x11d1) `U_C_GAME_HALL_TEAM_LIST`
- `gamehall.GameHallMsg`: `teams` (#1, `GameTeamMsg`, repeated).
- Receiver: `GameHallManager.__teamListHandler` (GHM:125, 156-174): replaces `teamList`, sorted mine first, then `teamState` asc, then `teamId` desc.
- When: reply to R1. Opcode 4561 is also named `U_C_FIND_BACK` in the table; this client only uses it here.

### S2. 4562 (0x11d2) `U_C_GAME_HALL_TEAM_DATA`
- `gamehall.GameTeamMsg`: `op` (#1, INT32) see below; `opUserId` (#2, INT32) actor; `teamId` (#3, INT32); `gameId` (#4, INT32); `teamState` (#5, INT32); `captainId` (#6, INT32); `password` (#7, STRING) non empty = locked; `difficulty` (#8, INT32); `players` (#9, `GameTeamPlayerMsg`, repeated); `autoType` (#10, INT32).
- `GameTeamPlayerMsg`: `userId` (#1), `nickName` (#2), `grade` (#3), `headId` (#4), `consortiaName` (#5), `posX` (#6), `posY` (#7), `state` (#8, 7 = online), `isPrepare` (#9, BOOL), `avata` (#10, `GameTeamPlayerAvataMsg`), `buff` (#11, STRING) Easter blessings `"skillId,level|..."`.
- `GameTeamPlayerAvataMsg`: `userId` (#1), `nickName` (#2), `arm` (#3), `cloth` (#4), `wing` (#5), `hat` (#6), `fashionArm` (#7), `fashionCloth` (#8) STRING avatars; `hide` (#9, BOOL) hide fashion; `sex` (#10), `templateId` (#11), `job` (#12), `mountId` (#13), `sharpId` (#14) transform, `fightCapacity` (#15) INT32.
- Receiver: `GameHallManager.__teamDataHandler` (GHM:176-240) by `op`:

| op | Handler | Client effect |
|---|---|---|
| 2 | `teamInfoHandler` (GHM:242-255) | password prompt if locked, then sends R4 |
| 3 | `teamCreateHandler` (GHM:262-271) | sets own team, enters `GAME_HALL_SCENE` (game 4 also sends Easter op 0) |
| 4 | `teamJoinHandler` (GHM:273-283) | adds `players[0]` |
| 5 | `teamLeaveHandler` (GHM:285-328) | self: clears and returns to space (unless in battle); other: removes |
| 6 | `teamKickHandler` | no effect (server should also send op 5) |
| 7 | `teamCaptainHandler` | new `captainId` |
| 8 | `teamPasswordHandler` | lock state |
| 9 | `teamGameHandler` | new game and difficulty |
| 10, 11 | no client effect | |
| 12 | `teamPrepareHandler` (GHM:364-382) | `isPrepare` per player |
| 13 | `teamSearchHandler` (GHM:384-406) | replaces the found team in the list and selects its game |
| 14 | `teamCancelAutoHandler` | `autoType` |
| 101 | `teamSwitchHandler` (GHM:408-431) | team replaced (switch), closes the frame |
| 102 | `teamDeleteHandler` (GHM:433-452) | removes a team from the list |
| 103 | `teamLoginHandler` (GHM:454-462) | enter the scene with the given team (reconnect, login state 7 `BM:1935`) |
| 104 | `teamUpdateAvataHandler` | avatar of `players[0]` |
| 105 | `teamUpdateStateHandler` (GHM:522-536) | online flag (`state == 7`) |
| 106 | `teamUpdateBufferHandler` (GHM:474-494) | all players with their Easter `buff` |

### S3. 4563 (0x11d3) `U_C_GAME_HALL_TEAM_POS`
- `team.MemberFightPosListMsg` (fields above). Receiver `__teamPosHandler` (GHM:576-583): `memberFightPos`, `TEAM_INFO_UPDATE`.
- When: reply to R17, push to members after a change.

### S4. 4564 (0x11d4) `U_C_GAME_HALL_TEAM_INVITE`
- `gamehall.GameHallInviteMsg`: `teamId` (#1, INT32); `gameId` (#2, INT32); `difficulty` (#3, INT32) (Easter map id for game 4); `inviterId` (#4, INT32); `inviterName` (#5, STRING); `count` (#6, INT32) members; `param1` (#7, INT32) unused.
- Receiver: `BaseManager.__gameHallTeamInviteHandler` (BM:347, 518-584): ignored while poker, child arena, ecliptic palace, wedding lock, outyard apply or dream arena matching are active, or when the inviter is blacklisted (relation 2); shown only in space, castle, game hall or outer city scenes and not during mop up.
- When: push to the invitee of R15.

### S5. 4565 (0x11d5) `U_C_GAME_HALL_TEAM_MOVE`
- `campaign.SpacePlayerMoveMsg`. Receiver `__teamMoveHandler` (GHM:585-591) -> `model.moveArmyTo`.
- When: broadcast of R16 to the other members.

### S6. 260 extra field 22
- `PlayerExtraFieldMsg` field 22 = `fixedGroupRewardCount`, rewarded runs of game 2 used today (BM:961-964); the bottom bar shows `Count - used` and `hasEarnings` (GHBV:720-738). Owner: [../hero/README.md](../hero/README.md).

## 5. Rules and formulas

- B1. Team size 1..4 ("N° de pessoas {2}/4").
- B2. A game can be chosen only on its `OpenDays` (1 = Monday .. 7 = Sunday, Sunday mapped from 0) (GHMOD:289-315); game 4 uses `StartDate..StopDate` instead. Level `OpenGrade` (assumption: checked by the server on create, join and start; the client only shows `Recommend`).
- B3. `isUseCount`: when true the run consumes one of the `Count` daily rewarded runs and gives rewards; false plays without rewards (assumption from "N° de ganhos usados").
- B4. Only the captain may change game, password, kick, transfer and start; members toggle ready. Start requires every member ready (assumption).
- B5. Daily rewarded runs reset at 00:00 (`ResetDays` all days).

## 6. Templates

| File | Record | Fields |
|---|---|---|
| `raw/xml/tempinfos/GameHallTemplates.xml` | `GameHallTemplate` (4 rows) | `GameId`, `GameName`, `Group`/`GroupName` (tabs), `StartDate`/`StopDate`, `OpenGrade`, `OpenDays`, `ResetDays`, `Count` daily rewarded runs, `Tag` (1 = new), `ShowItems` reward preview (`|` separates difficulties), `Recommend` text |

## 7. Persistent state

```sql
CREATE TABLE casino.hall_team (
  team_id      SERIAL      PRIMARY KEY,
  game_id      SMALLINT    NOT NULL CHECK (game_id BETWEEN 1 AND 4),
  difficulty   INTEGER     NOT NULL DEFAULT 0,
  captain_id   INTEGER     NOT NULL REFERENCES player.players(player_id),
  password     TEXT        NOT NULL DEFAULT '',
  state        SMALLINT    NOT NULL DEFAULT 0,
  auto_type    SMALLINT    NOT NULL DEFAULT 0,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE casino.hall_team_member (
  team_id     INTEGER  NOT NULL REFERENCES casino.hall_team(team_id) ON DELETE CASCADE,
  player_id   BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  is_ready    BOOLEAN  NOT NULL DEFAULT FALSE,
  use_count   BOOLEAN  NOT NULL DEFAULT TRUE,
  fight_pos   SMALLINT,
  pos_x       INTEGER  NOT NULL DEFAULT 0,
  pos_y       INTEGER  NOT NULL DEFAULT 0,
  PRIMARY KEY (team_id, player_id),
  UNIQUE (player_id)
);

CREATE TABLE casino.hall_daily_runs (
  player_id  BIGINT  NOT NULL REFERENCES player.players(player_id) ON DELETE CASCADE,
  game_id    SMALLINT NOT NULL,
  day        DATE     NOT NULL,
  runs_used  SMALLINT NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, game_id, day)
);
```

Teams are volatile; the tables can also be in memory (assumption: keep in memory and persist only `hall_daily_runs`).

## 8. Backend implementation notes

- `casino::hall::handle_op` (8646) dispatches on `op` to `handle_list`, `handle_info`, `handle_create`, `handle_join`, `handle_leave`, `handle_kick`, `handle_captain`, `handle_password`, `handle_game`, `handle_start`, `handle_invite_join`, `handle_prepare`, `handle_search`, `handle_cancel_auto`.
- Validation order for create, join and start: player not in another team or activity -> game open today and level >= `OpenGrade` -> team not full (4) -> password matches -> for start: captain, all ready, game specific checks (tickets for game 4).
- Pushes: every membership change sends 4562 to all members (op 4, 5, 7, 8, 9, 12, 104, 105, 106) and 4562 op 102 or a 4561 refresh to lobby viewers (assumption).
- `casino::hall::handle_invite` (8648): target online and level ok -> push 4564.
- `casino::hall::handle_move` (8649): store last position, broadcast 4565 to members.
- `casino::hall::handle_edit_pos` (8647): `is_get` -> reply 4563; else validate positions are a permutation, save, push 4563 to members.
- Start: build the campaign of the game (battle configuration owned by the game feature: rapid through, land mine, crisis, Easter maps) with the team as participants; on campaign end return members to the hall scene (`CampaignSocketManger.as:2025-2041`).
- Disconnect: on login, if the player is still in a hall team send 4562 op 103.

## 9. Open questions and assumptions

- Assumption: server enforces `OpenGrade` and the 4 member cap.
- Assumption: op 10 and 11 replies carry no client effect; the start result is the campaign entry.
- Open: `teamState` values (sort only; assumption 0 waiting, 1 playing).
- Open: the cross server chat 25256 is unused.

## 10. Implementation checklist

- [ ] Screens `GameHallFrame` (two tabs), `GAME_HALL_SCENE`, bottom bar, password and formation frames, invite popup
- [ ] Route 8646 ops 1..14
- [ ] Routes 8647, 8648, 8649
- [ ] Messages 4561, 4562 (all ops), 4563, 4564, 4565; extra field 22 in 260
- [ ] Tables `hall_team`, `hall_team_member`, `hall_daily_runs`
- [ ] Rules B1..B5
- [ ] Reconnect into the hall (op 103)
- [ ] Test: create on a closed weekday refused; fifth member refused; wrong password refused

## Screens

- `GameHallEastShopResultFrame` (`decompiled/m3/scripts/gamehall/GameHallEastShopResultFrame.as`) shows the result of a purchase made in the game hall point store.
