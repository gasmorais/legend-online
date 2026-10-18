# Team arena ("Arena", room type 1)

Module `arena::team_arena`. Prefixes as in [README.md](README.md).

## 1. Overview

During the daily arena windows (`MatchTime` = 12:00,14:00 \| 18:00,20:00, "竞技场开放时间") the server sets the player flag `isPVPStart` (push 4201). Players of level 22+ open the room list ("Arena"), create, search, quick join or enter a 4 seat campaign room of type 1 (scene `PVP_ROOM_SCENE`), set ready, and the owner starts (5039). The room enters state 2 (matching, countdown timer). The server pairs two rooms and runs a 4 vs 4 match; on return the client goes back to `PVP_ROOM_SCENE` (`BattleManager.preScene`, `CM/managers/RoomManager.as:73-76`). Each player has a daily count of rewarded arena matches (`JJCcount`, from player data `matchRoomCount`); with 0 left the client warns "Você já esgotou suas vezes da Arena, ao entrar não terá nenhum ganho. Continuar?". The arena shop ("Loja da Arena", `shop` openType 3, currency 8 "Medalha") is reached from the "Salão da Arena" multi tab.

How the match is fought in this client build (A): the war field map UI (`map.campaign.mediator.pvp.*`, `PvpWarFightModel`, 4252/4254/4255, attack 8334) is reachable only through `WorldBossHelper.checkPvp(mapId)`, which **always returns false** (`CM/yishi/utils/WorldBossHelper.as:146-149`); the same war field code is used by Flame Temple (map 4101), Dusk Area and Ice Fire Temple (campaign feature). The remaining path is a direct battle: battle type 10 `BATTLE_MATCHING` shows the detailed result view like 16 (`CM/battle/handler/BattleResultHandler.as:750-760`; `docs/battle/rules.md`). Recommendation: implement the team arena match as battle type 10 between the two rooms' heroes and armies.

## 2. Screens

| Class | pt-BR title | Purpose | Opened from | Data shown |
|---|---|---|---|---|
| `pvp.PvPFrame` with `PvPSingleView` / `PvPMultiView` | Salão da Arena | hub: single (colosseum scene) and multi (room list, shop); texts `pvp.view.PvPSingleView.text`, `pvp.view.PvPMultiView.text` | controller `pvp` (`CM/mvc/controler/PvPControler.as:42-70`), after colosseum battles (`CM/managers/ChallengeManager.as:244-251`) | `M9/pvp/PvPFrame.as:31-68`; `M9/pvp/view/PvPMultiView.as:65-89`; `M9/pvp/view/PvPSingleView.as:90-96` |
| `pvproomlist.PVPRoomListFrame` / `PVPRoomListView` / `PVPPlayerListView` | Arena | room list (id, name, "count/capacity", state, lock), online player list (level >= 22, sorted VIP, transfer grade, level), buttons create, search, quick join, refresh | top bar `pvp`, multi tab | 13 / 4270 (`M9/pvproomlist/view/PVPRoomListView.as:100-145`; `M9/pvproomlist/view/PVPPlayerListView.as:120-210`; `M9/pvproomlist/view/PVPRoomItem.as:108-128`) |
| `pvproomlist.view.PVPRoomSearchFrame` | (pve search strings) | search by room id and optional password | search button | `M9/pvproomlist/view/PVPRoomSearchFrame.as:153-185` |
| scene `mvc.controler.PvpRoomControl` (`PVP_ROOM_SCENE`) with `room.view.pvp.PVPRoomView` | | 4 seats anteroom (`room.view.anteroom.PVPAnteroomView`) | 12 with `roomType 1` (`CM/yishi/manager/BaseManager.as:2654-2657`) | room members 120 |
| `room.view.pvp.PVPRoomRightView` | Informações da Sala | room id, "n / 4", lock/password, start (owner), ready / cancel (members), invite, team order, matching timer | room view | `M9/room/view/pvp/PVPRoomRightView.as:104-545` |

## 3. Routes (client to server)

`RoomReqMsg` fields are listed in [../theseus-arena/multi-rooms.md](../theseus-arena/multi-rooms.md). Senders: `CM/mvc/controler/PVPRoomListControler.as` (PRC), `CM/yishi/manager/RoomListSocketOutManager.as` (RLS), `M9/room/net/RoomSocketOuterManager.as` (RSO).

| # | Action | UI control | Client sender | Client checks | Request | Responses |
|---|---|---|---|---|---|---|
| T1 | Open room list | top bar `pvp`, multi tab "start" | `TopToolsBar` (`:1359-1365`), `PvPMultiView.__startMultiHandler` (`:65-76`) -> `PRC.showFrame` -> `requestRoomInfo` (`PRC` `requestRoomList(1)`) | level >= 22 (`pvp.view.PvPMultiView.command01` "Nível insuficiente, só pode entrar no Nv. 22"); `checkIsOpen(0)`: level, then `isPVPStart` must be true else "Evento ainda não foi aberto, não é possível entrar" (`CM/ui/toptoolbar/TopToolsBar.as:1581-1601`; `CM/ui/toptoolbar/view/TimeActiveBoxOpenTime.as:47-50,200-229`) | 5026 `{roomType:1, nameKey:"0"}` | 13 `RoomListRspMsg` |
| T2 | Create room | player list create | `PVPPlayerListView.__createRoomHandler` -> `PRC.sendCreateRoom` -> `RLS.sendCreateRoom(3, 1, "")` | 5 s throttle | 5023 `{capacity:3, roomType:1, password:""}` (capacity as sent, A: server uses 4) | 12 (`roomType 1`), 120 |
| T3 | Enter room | room item click | `PVPRoomItem.__clickHandler` (`:108-128`): locked room -> 8465 search first; else `sendEnterRoom(1, id, pwd)` -> `RLS.addRoomById` | 5 s throttle | 5024 `{roomId, password, roomType:1}` | 12, 120 to all members |
| T4 | Search / quick join | search frame, quick button | `PRC.sendSearchRoomInfo(1, id)` (`PVPPlayerListView.as:195-205`: quick = id 0) | | 8465 `U_C_ROOM_FIND` `{roomId, roomType:1}` | 4370 `RoomMsg` then client T3 (password prompt if `isSetPassword`) (`PRC.__searchRoomHandler`) |
| T5 | Lock room | owner lock button | `RSO.sendLockCampaignRoom` (`PVPRoomRightView.as:295-307`) | owner | 8344 (0x2098) `C_ROOM_PWDCHANGE` (room password, campaign module) | 32 room edit |
| T6 | Ready / unready | `_readyBtn`, `_cancelBtn` | `RSO.sendPlayerState(1/0)` (`PVPRoomRightView.as:431-466,492-510`) | `isPVPStart` else `room.view.pvp.RoomRightView.IsOver` "Período encerrado!"; 0 arena counts -> warning dialog (daily "Não alertar mais") | 5036 `{state}` | 24 / 17 |
| T7 | Start (owner) | `_startBtn` | `PVPRoomRightView._startClick` -> `start` -> `RSO.sendStartCampaignScene(0, 0)` (`:314-377`) | `isPVPStart`; 2 s throttle; arena count warning; fewer than 4 players -> "Número de quartos ainda vazios, deseja começar?" (once a day option); button enabled only when all ready (`allPlayerReader`) | 5039 `CampaignReqMsg{}` | 25 room state 2 (timer), then the match (battle 10, A), result, room state back to 1 |
| T8 | Cancel matching | `_cancelBtn` while state 2 | owner `RSO.sendRoomState(1)`, member `sendPlayerState(0)` (`:492-510`) | | 5037 `{state:1}` / 5036 `{state:0}` | 25 |
| T9 | Invite | invite button | `room.RoomInviteFrame.show(1)` (`:411-423`) | free seat | 5028 (campaign module) | 16 |
| T10 | Team order | sort button | controller `teammanager` | | team module | |
| T11 | Leave | toolbar exit | campaign exit | | 5025 | 15, client returns to space with `isOpenPvpRoomList` (`CM/managers/RoomManager.as:481-484`) |
| T12 | Arena shop | multi tab shop | `PvPControler.openShopFrame` -> `shop` 3 (`CM/mvc/controler/PvPControler.as:57-60`) | level 22 | shop module | |

## 4. Server messages (server to client)

### 4201 (0x1069) `U_C_MATCH_STATE`, `room.MatchStateMsg`

Receiver `BaseManager.__requestHandler` (`CM/yishi/manager/BaseManager.as:318,1485-1492`) -> `playerInfo.isPVPStart = matchState`. Fields: `matchState` (#1, BOOL, arena window open), `param1` (#2, STRING), `param2` (#3, STRING) (not read). When: at login and at each window boundary to all online players. Drives the top bar time box (state 2 = open) and every start/ready check.

### Player data `matchRoomCount`

Field of the player info message handled in `CM/yishi/manager/PlayerManager.as:1058-1062` (`JJCcount`, info tip key 10). Remaining rewarded arena matches today (A: default from config, decremented by the server per match).

### Room messages

13, 4270, 4370, 12 (`roomType 1`), 120, 15, 16, 17, 24, 25, 32 (campaign module, see [../campaign/README.md](../campaign/README.md)).

### War field messages (shared with Flame Temple etc., not reachable for room type 1 in this build)

4252 (0x109C) `U_C_WARFIELD_INFO` `WarFightInfoMsg` (`teamId` #1, `score` #2, `order` #3, `geste` #4, `hitCount` #5, `leftTime` #6, `oneCount` #7, `twoCount` #8, `oneScore` #9, `twoScore` #10, `one_FlagCount` #11, `two_FlagCount` #12) -> `M3/map/campaign/CampaignSocketManger.as:354,1255-1273`; 4254 (0x109E) `U_C_WARREPORT` and 4255 (0x109F) `U_C_ORDERREQUEST`, both `WarReportListMsg` (`:355-356,1160-1250`); attack request 8334 (0x208E) `C_WARFIELD_ATTACK` `WarFieldAttackMsg{userId, defenceServerName}` (`M3/map/net/MapSocketOuterManager.as:147-155`). Owned by [../campaign/README.md](../campaign/README.md).

## 5. Rules and formulas

| # | Rule | Source |
|---|---|---|
| A1 | Window `MatchTime` = 12:00-14:00 and 18:00-20:00 (A: server time); the client shows "soon" 30 min before (`1800` s) but only the server flag opens it | config; `TimeActiveBoxOpenTime.as:200-229` |
| A2 | Level 22 (`TIME_ACTIVE_GRADES[0]`) | `CM/ui/toptoolbar/TopBtnType.as:214` |
| A3 | Room: type 1, 4 seats; start requires all present members ready; fewer than 4 allowed after confirmation | `PVPRoomRightView.as:223-226,271-293,341-357` |
| A4 | Pairing (A): rooms in state 2, nearest average fight power; timeout returns to state 1 | |
| A5 | Rewards (A): per match medals (currency 8) and honor while `JJCcount > 0`; no reward table in the client templates | LANG `disclist03` |

## 6. Templates

`TPL/ConfigInfos.xml` `MatchTime`. Shop 3 items: [../shops/catalog.md](../shops/catalog.md).

## 7. Persistent state

```sql
CREATE TABLE arena.team_arena_daily (
  player_id       BIGINT NOT NULL REFERENCES player.players(player_id),
  day             date NOT NULL,
  matches_played  smallint NOT NULL DEFAULT 0,
  rewarded_left   smallint NOT NULL,                   -- matchRoomCount
  PRIMARY KEY (player_id, day)
);

CREATE TABLE arena.team_arena_match (
  match_id        bigserial PRIMARY KEY,
  room_a_players  integer[] NOT NULL,
  room_b_players  integer[] NOT NULL,
  winner_side     smallint CHECK (winner_side IN (1, 2)),
  battle_id       text,
  fought_at       timestamptz NOT NULL DEFAULT now()
);
```

Rooms are in memory (campaign room service).

## 8. Backend implementation notes

- Scheduler: push 4201 `matchState` true/false at the `MatchTime` boundaries; send it at login.
- Room type 1 in the shared room service: capacity 4, list filter type 1; refuse create/enter/ready/start when `isPVPStart` is false or level < 22.
- `arena::team_arena::handle_start` (5039 in a type 1 room): owner, all ready, state 1 -> 2, enqueue. On pair: battle type 10 with all heroes of both rooms (formation from team order), `count_down` 180; on end decrement `rewarded_left`, grant rewards, update player data `matchRoomCount`, rooms back to state 1.

## 9. Open questions and assumptions

- (A) Match format (battle 10 vs war field map) and rewards.
- (A) Capacity sent as 3 by the client on create.

## 10. Implementation checklist

- [ ] 4201 schedule and login push
- [ ] Room type 1 list/create/find/enter/lock/ready/state/exit
- [ ] 5039 start, pairing, battle 10, result
- [ ] Daily counts (`matchRoomCount`) and rewards
- [ ] Tables `team_arena_daily`, `team_arena_match`
- [ ] Tests: closed window, level 21, member not ready, cancel matching
