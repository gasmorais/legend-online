# Theseus arena: MP rooms and matches ("Arena MP Teseu")

Module `theseus_arena::multi_rooms`. Prefixes as in [README.md](README.md).

## 1. Overview

The multiplayer ladder is room based (campaign room `roomType 16`, up to 4 seats). Players list, search, create and join rooms, invite friends or guild members, set ready; the owner starts matchmaking (5039). The room state goes to 2 (matching); when the server pairs two rooms it pushes 581 with both lineups (VS view with up to 4 per side) and starts battle 3912 `THESE_MultiPVP_BATTLE`. After the battle the client returns to `THESE_Double_PVP_SCENE` and the buffered 582 opens the result. Points use `TPL/TheseusMultiPvpTmpls.xml` and `TPL/TheseusMultiPvpIntegralTmpls.xml`. Matches per day: `theseus_multi_pvp_day_free_count` = 5, purchases `theseus_multi_pvp_buy_count_points` (5 x 50 diamonds), items 7640004 "Bilhete de Desafio Interservidores".

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `theseusdoublepvproom.TheseusDoubleRoomListFrame` / `TheseusDoubleRoomListView` | | room list (owner name, owner stage from `masterScore` = pvpId, "curCount / capacity"), buttons join, create, refresh, search by id | hub "join" -> controller `theseusroomlist` (`CM/mvc/controler/TheseusRoomListControler.as:159-205`) | 13 / 4270 (`M3/theseusdoublepvproom/TheseusDoubleRoomListView.as:130-250`; `M3/theseusdoublepvproom/TheseusDoubleRoomItem.as:95-195`) |
| `theseusdoublepvproom.TheseusPlayerListView` | | own stats and link to reports | list frame | `M3/theseusdoublepvproom/TheseusPlayerListView.as:105-116` |
| `core.RoomPasswordFrame` / `theseusdoublepvproom.TheseusRoomPasswordFrame` | | password prompt for locked rooms / set password | 4370 with `isSetPassword` | `TheseusRoomListControler.as:46-74` |
| `theseusdoublepvproom.invite.TheseusTeamInviteFrame` | (title `room.view.invite.RoomInviteFrame.title`) | invite tabs guild, friends, hall (4161 list) | anteroom invite button | `M3/theseusdoublepvproom/invite/TheseusTeamInviteFrame.as:93-278` |
| scene `theseusDoublepvpscene.TheseusDoublePvpScene` (`THESE_Double_PVP_SCENE`) | | hosts `TheseusDoubleRoomView`; returns to space if `RoomManager.exit` | 12 with `roomType 16` (`CM/yishi/manager/BaseManager.as:2686-2689`); preScene (`CM/managers/RoomManager.as:101-104`) | `M3/theseusDoublepvpscene/TheseusDoublePvpScene.as:24-138` |
| `theseusDoublepvpscene.view.TheseusAnteroomView` | | 4 seats (`PLAYER_COUNT = 4`), owner: match / cancel / invite; members: ready / cancel ready; buy, item use, "Restam: {0}" | room view | `RoomInfo` (`roomState`, `placesState`, owner), 575 (`M3/theseusDoublepvpscene/view/TheseusAnteroomView.as:91-600`) |
| `theseusDoublepvpscene.view.TheseusRoomReadyTopView` | | own stage, progress, season countdown, 4 daily task boxes (`TheseusBoxItem`, click = claim) | room view; sends op 13 on creation | 576 (`M3/theseusDoublepvpscene/view/TheseusRoomReadyTopView.as:78-160`; `M3/theseusDoublepvpscene/view/TheseusBoxItem.as:54-57`) |
| `theseusDoublepvpscene.view.TheseusDoublepvpSceneRightView` | | buttons shop 1027, ranking `SORTDOUBLE`, rewards `REWARDDOUBLE`, glory `PRIVATE_DOUBLE` | room view | `M3/theseusDoublepvpscene/view/TheseusDoublepvpSceneRightView.as:57-72` |
| `theseusdoublepvp.TheseusDoubleVsView` | | VS view, 4 blue (self side) vs 4 red | 581 | `matchSelfInfoArr`, `matchOtherInfoArr` (`M3/theseusdoublepvp/TheseusDoubleVsView.as:93-97`) |
| `theseusdoublepvp.TheseusDoublePvpResultFrame` | | same as single result | 582 via `BATTLE_RESULTDOUBLE` | |
| `theseusdoublepvp.TheseusDoublePvpBuyTimeFrame` | Mais Combinações | use 7640004 items | item icon (`BUY_TIMEDOUBLE`) | `M3/theseusdoublepvp/TheseusDoublePvpBuyTimeFrame.as:148-157` |

## 3. Routes (client to server)

Room requests use `room.RoomReqMsg`: `roomId` (#1), `dungeonId` (#2), `campaignId` (#3), `armyId` (#4), `userId` (#5), `state` (#6), `index` (#7), `open` (#8), `roomType` (#9), `nameKey` (#10, STRING), `password` (#11, STRING), `isInvite` (#12, BOOL), `capacity` (#13), `isGet` (#14, BOOL), `serverName` (#15, STRING). Senders in `CM/yishi/manager/RoomListSocketOutManager.as` (RLS) and `TPM:147-194`.

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| R1 | Room list | list frame open, refresh | `TheseusRoomListControler.requestRoomInfo` -> `RLS.requestRoomList(16, searchId)` (`RLS:22-29`) | none | C to S 5026 (0x13A2) `U_C_CAMPAIGN_ROOM_LIST` `{roomType:16, nameKey:String(searchId)}` | 13 `U_C_CAMPAIGN_ROOM_LIST` `RoomListRspMsg` (`room` #1 repeated `RoomMsg`) |
| R2 | Create room | hub "create", list "create" | `sendCreateRoom` -> `RLS.sendCreateRoom(1, 16, "")` (`RLS:58-72`), followed by 9736 op 1 | 5 s throttle ("activity.view.ActivityItem.command01") | 5023 (0x139F) `U_C_CAMPAIGN_ROOM_CREATE` `{capacity:1, roomType:16, password:""}` | 12 `RoomMsg` (`roomType 16`, server sets real capacity 4, A), 120, 575, 576 |
| R3 | Search / join by id | search button, join button | `sendSearchRoomInfo(16, id)` -> `RLS.sendSearchRoomInfo` (`RLS:49-56`) | id > 0 | 8465 (0x2111) `U_C_ROOM_FIND` `{roomId, roomType:16}` | 4370 `U_C_ROOM_FIND_RESULT` `RoomMsg`; client then sends R4 (with password prompt if locked) |
| R4 | Enter room | after 4370 | `sendEnterRoom(16, roomId, password, false)` -> `RLS.addRoomById` (`RLS:31-47`) | 5 s throttle | 5024 (0x13A0) `U_C_CAMPAIGN_ROOM_ENTER` `{roomId, password, roomType:16, isInvite, isGet}` | 12, 120 to all members |
| R5 | Invite | invite item | `TheseusPvpManager.sendRoomInvite(userId)` (`TPM:188-194`; `M3/theseusdoublepvproom/invite/TheseusInviteItemButton.as:189`) | target level checks of the room map | 5028 (0x13A4) `U_C_CAMPAIGN_ROOM_INVITE` `{userId}` | 16 `U_C_CAMPAIGN_ROOM_INVITE` to the target (campaign module) |
| R6 | Ready / unready (member) | `_ready` / `_cancelready` | `TheseusPvpManager.sendPlayerState(1 / 0)` (`TPM:147-154`; `TheseusAnteroomView.as:270-278`) | none | 5036 (0x13AC) `U_C_PLAYER_READY_STATE` `{state, isGet:false}` | 24 `U_C_PLAYER_READY_STATE` / 17 place state to all members |
| R7 | Start matching (owner) | `_matchBtn` | `matchHandler` -> `sendStartCampaignScene()` (`TheseusAnteroomView.as:410-426`; `TPM:164-176`) | before `stopDate` else `theseuspvp.inCounting`; counts > 0 else `theseuspvp.fightNeedGood` | 5039 (0x13AF) `U_C_CAMPAIGN_ENTER` `CampaignReqMsg{paraBool1:false, paraInt2:0, isCross:false}` | 25 `U_C_ROOM_STATE` / 32 with `roomState 2` (matching), later 581, battle 3912 |
| R8 | Cancel matching | `_cancelBtn` | owner: `sendRoomState(1)` (5037, `TPM:156-162`); member: `sendPlayerState(0)` (`TheseusAnteroomView.as:258-268`) | none | 5037 (0x13AD) `U_C_ROOM_STATE` `{state:1}` or 5036 `{state:0}` | 25 room state 1 |
| R9 | Buy / add matches | buy button, item icon | 9736 `{op:15}` (`TheseusAnteroomView.as:196-230`), `{op:14, count}` | as single (P2/P3 with MP config) | 9736 | 575 |
| R10 | Claim task box | task box | `TheseusBoxItem.__clickHandler` | none | 9736 `{op:7, id:templateId}` | 576 |
| R11 | Leave | toolbar exit, confirm `theseuspvpMulti.return` "Deseja sair da Arena Multiplayer de Teseus?" | `MainToolBar.exitTheseusMultiPvpGame` (`CM/ui/maintoolbar/MainToolBar.as:1933-1939`) | | 5025 `RoomExitMsg{msg:""}` | 15 to all members, new owner 121 |

## 4. Server messages (server to client)

### 581 (0x0245) `U_C_THESEUS_PVPDOUBLE_MATCH`, `TheseusMultiPvpMatchMsg`

Receiver `__matchInfosDoubleHandler` (`TPM:650-672`): `roomType` (#1, INT32) -> `matchState`, and the side id: players whose `roomType` equals it are the own side. `players` (#2, repeated `TheseusMultiPvpMatchPlayerMsg`: `integral` #1, `pvpId` #2, `nickName` #3, `serverName` #4, `job` #5, `fightCapacity` #6, `roomType` #7 side id). Notification `theseuspvpDoubleMatchEvent` opens the VS view (`TheseusAnteroomView.as:301-307`).

### 582 (0x0246) `U_C_THESEUS_PVPDOUBLE_FIGHT_RESULT`, `TheseusMultiPvpFightResultMsg`

Same fields as 4319 ([single-match.md](single-match.md)); buffered until `THESE_Double_PVP_SCENE` (`TPM:625-648`).

### Room messages (campaign module)

12 (`roomType 16`), 13, 15, 16, 17, 24, 25, 32, 120, 121, 4270 `U_C_ROOM_SEND` (room row update: refresh list when `capacity == 0` or `roomState` 2/3, `TheseusRoomListControler.as:109-130`), 4370. `RoomPlayerMsg` carries `theseusMultiPvpRankName` (#59, STRING) and `theseusMultiPvpIntegral` (#60, INT32) for the seat figures.

Room state values used by the anteroom: `roomState <= 1` idle (buy, match, invite visible), 2 matching (spinner, cancel) (`TheseusAnteroomView.as:309-363`); place state 0 = not ready.

### Battle

Battle 3912: exit to `THESE_Double_PVP_SCENE` (`CM/battle/handler/BattleResultHandler.as:309-311`).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| D1 | Room type 16, up to 4 members; owner starts, all members must be ready (A) | `TheseusAnteroomView.as:45`; client shows ready only for members |
| D2 | Every member needs matches left (A: each consumes one) | `TheseusAnteroomView.as:410-424` (owner check only) |
| D3 | Pairing: rooms whose average points fall in each other's `MatchingSection` (A); `theseus_multi_pvp_matching_cd` like single | templates; config |
| D4 | Points: `TPL/TheseusMultiPvpIntegralTmpls.xml` (Mode 1 only: win +40..100, loss -30..90 by Section); streak bonus `WinningStreak`; stages 1..16 ("Mestre" at 10000) | templates |
| D5 | Daily free 5, purchases 5 x 50 diamonds, item 7640004 (`theseus_multi_pvp_item_count` = 7640003,10, A: config names a different item than the client) | config; `TheseusDoublePvpBuyTimeFrame.as:148` |

## 6. Templates

`TPL/TheseusMultiPvpTmpls.xml`, `TPL/TheseusMultiPvpIntegralTmpls.xml` (note: TempleteManager loads it with the name "TheseusMultiPvpIntegralTmpl", `CM/yishi/manager/TempleteManager.as:1400`), `TPL/ConfigInfos.xml` `theseus_multi_pvp_*`.

## 7. Persistent state

Rooms are in memory (campaign room service). Matches in `theseus_arena.match` with `mode = 2` and one row per member pair, or:

```sql
CREATE TABLE theseus_arena.multi_match (
  match_id        bigserial PRIMARY KEY,
  season_id       integer NOT NULL,
  side_a_players  integer[] NOT NULL,
  side_b_players  integer[] NOT NULL,
  side_a_won      boolean NOT NULL,
  battle_id       text,
  fought_at       timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE theseus_arena.multi_match_player (
  match_id        bigint NOT NULL REFERENCES theseus_arena.multi_match(match_id) ON DELETE CASCADE,
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  side            smallint NOT NULL CHECK (side IN (1, 2)),
  points_delta    integer NOT NULL,
  streak_bonus    integer NOT NULL DEFAULT 0,
  PRIMARY KEY (match_id, player_id)
);
```

## 8. Backend implementation notes

- Room handlers are the shared campaign room handlers with `roomType 16` specifics: capacity 4, room list filtered by type 16, `masterScore` = owner `pvpId`.
- `theseus_arena::multi_rooms::handle_start_match` (5039 in a type 16 room): owner only, all ready, season running, counts; set `roomState 2`, push 25 to members, enqueue the room.
- `handle_cancel` (5037 state 1 by owner or 5036 state 0 by a member while matching): dequeue, `roomState 1`.
- Pairing hit: consume counts, push 581 to both rooms (`roomType` = side id), start battle 3912 with all members; on end apply D4 per member, push 575 and 582, set rooms back to state 1.

## 9. Open questions and assumptions

- (A) Real capacity and minimum members; client sends capacity 1.
- (A) How pairing aggregates points; whether the matched rooms must be full.
- (A) Which item the server must accept for op 14 (7640004 in the client vs 7640003 in config).

## 10. Implementation checklist

- [ ] Room type 16 in the campaign room service (list, create, find, enter, invite, ready, state, exit)
- [ ] 5039 start and 5037 cancel for type 16
- [ ] 581 / 582, battle 3912
- [ ] 9736 ops 7, 14, 15 with 575 / 576
- [ ] Tables `multi_match`, `multi_match_player`
- [ ] Tests: member not ready, owner leaves while matching, 4 vs 4 VS data
